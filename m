Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396493E09B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhHDU5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:57:34 -0400
Received: from foss.arm.com ([217.140.110.172]:37214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhHDU5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:57:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC4C1FB;
        Wed,  4 Aug 2021 13:57:19 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A34D3F40C;
        Wed,  4 Aug 2021 13:57:18 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:57:15 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH v2] firmware: arm_scmi: Free mailbox channels if probe
 fails
Message-ID: <20210804205715.GT6592@e120937-lin>
References: <1628099499-27394-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628099499-27394-1-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 10:51:39AM -0700, Rishabh Bhatnagar wrote:
> Mailbox channels for the base protocol are setup during probe.
> There can be a scenario where probe fails to acquire the base
> protocol due to a timeout leading to cleaning up of all device
> managed memory including the scmi_mailbox structure setup during
> mailbox_chan_setup function.
> [   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: version_get+0x84/0x140)
> [   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
> [   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110
> 
> Now when a message arrives at cpu slightly after the timeout, the mailbox
> controller will try to call the rx_callback of the client and might end
> up accessing freed memory.
> [   12.758363][    C0] Call trace:
> [   12.758367][    C0]  rx_callback+0x24/0x160
> [   12.758372][    C0]  mbox_chan_received_data+0x44/0x94
> [   12.758386][    C0]  __handle_irq_event_percpu+0xd4/0x240
> This patch frees the mailbox channels setup during probe and adds some more
> error handling in case the probe fails.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---

Hi,

>  drivers/firmware/arm_scmi/driver.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 9b2e8d4..aab2ac1 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1390,6 +1390,21 @@ void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
>  	mutex_unlock(&scmi_requested_devices_mtx);
>  }
>  
> +static int cleanup_txrx_channels(struct scmi_info *info)
> +{
> +	int ret;
> +	struct idr *idr = &info->tx_idr;
> +
> +	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
> +	idr_destroy(&info->tx_idr);
> +
> +	idr = &info->rx_idr;
> +	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
> +	idr_destroy(&info->rx_idr);
> +
> +	return ret;
> +}
> +

Sorry for being pedantic but the preferred naming for the function
should be scmi_cleanup_txrx_channels()

>  static int scmi_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -1430,7 +1445,7 @@ static int scmi_probe(struct platform_device *pdev)
>  
>  	ret = scmi_xfer_info_init(info);
>  	if (ret)
> -		return ret;
> +		goto clear_txrx_setup;
>  
>  	if (scmi_notification_init(handle))
>  		dev_err(dev, "SCMI Notifications NOT available.\n");
> @@ -1443,7 +1458,7 @@ static int scmi_probe(struct platform_device *pdev)
>  	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
>  	if (ret) {
>  		dev_err(dev, "unable to communicate with SCMI\n");
> -		return ret;
> +		goto notification_exit;
>  	}
>  
>  	mutex_lock(&scmi_list_mutex);
> @@ -1482,6 +1497,12 @@ static int scmi_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> +
> +notification_exit:
> +	scmi_notification_exit(&info->handle);
> +clear_txrx_setup:
> +	cleanup_txrx_channels(info);
> +	return ret;
>  }
>  
>  void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
> @@ -1493,7 +1514,6 @@ static int scmi_remove(struct platform_device *pdev)
>  {
>  	int ret = 0, id;
>  	struct scmi_info *info = platform_get_drvdata(pdev);
> -	struct idr *idr = &info->tx_idr;
>  	struct device_node *child;
>  
>  	mutex_lock(&scmi_list_mutex);
> @@ -1517,14 +1537,7 @@ static int scmi_remove(struct platform_device *pdev)
>  	idr_destroy(&info->active_protocols);
>  
>  	/* Safe to free channels since no more users */
> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
> -	idr_destroy(&info->tx_idr);
> -
> -	idr = &info->rx_idr;
> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
> -	idr_destroy(&info->rx_idr);
> -
> -	return ret;
> +	return cleanup_txrx_channels(info);
>  }
>  

Maybe also a Fixes: tag could be appropriate, but I'm not so sure you
could easily identify one common commit to use given that notifications
have been added later and the code around scmi_protocol_acquire() has
been changed recently too. (in such a case just ignore the Fixes tag
suggestion)

Other than the above remarks,

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
