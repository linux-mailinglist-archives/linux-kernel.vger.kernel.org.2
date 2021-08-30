Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B6A3FBDEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhH3VKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:10:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34704 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhH3VKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:10:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630357787; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9aiJNDyoXg8dcZ/AYxbmPAl9u0xuADYkliFu1q902ZQ=;
 b=gcAdVnxJnkvMhems8tp9FwB/G2OECEgkgq7SiPOQa3j/ak9KWmZbjZpim4hMs9XXtAxQZjP+
 xiQzdKbA78nRJbKNTg6y7H7xhKcIM8SUMwT9DNK9eIFWNkI23WcUH74WBOEh1Dzg+0mUEtzs
 AtVgxiWND4va+VX38f0mgtNkU3A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 612d4913c603a0154f29bf6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Aug 2021 21:09:39
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9228FC4360D; Mon, 30 Aug 2021 21:09:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 841AFC4338F;
        Mon, 30 Aug 2021 21:09:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Aug 2021 14:09:37 -0700
From:   rishabhb@codeaurora.org
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe
 fails
In-Reply-To: <20210805105427.GU6592@e120937-lin>
References: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
 <20210805105427.GU6592@e120937-lin>
Message-ID: <51782599a01a6a22409d01e5fc1f8a50@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian
There seems to be another issue here. The response from agent can be 
delayed causing a timeout during base protocol acquire,
which leads to the probe failure. What I have observed is sometimes the 
failure of probe and rx_callback (due to a delayed message)
happens at the same time on different cpus.
Because of this race, the device memory may be cleared while the 
interrupt(rx_callback) is executing on another cpu.
How do you propose we solve this? Do you think it is better to take the 
setting up of base and other protocols out of probe and
in some delayed work? That would imply the device memory is not released 
until remove is called. Or should we add locking to
the interrupt handler(scmi_rx_callback) and the cleanup in probe to 
avoid the race?

On 2021-08-05 03:54, Cristian Marussi wrote:
> On Wed, Aug 04, 2021 at 02:19:59PM -0700, Rishabh Bhatnagar wrote:
>> Mailbox channels for the base protocol are setup during probe.
>> There can be a scenario where probe fails to acquire the base
>> protocol due to a timeout leading to cleaning up of all device
>> managed memory including the scmi_mailbox structure setup during
>> mailbox_chan_setup function.
>> [   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: 
>> version_get+0x84/0x140)
>> [   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
>> [   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110
>> 
>> Now when a message arrives at cpu slightly after the timeout, the 
>> mailbox
>> controller will try to call the rx_callback of the client and might 
>> end
>> up accessing freed memory.
>> [   12.758363][    C0] Call trace:
>> [   12.758367][    C0]  rx_callback+0x24/0x160
>> [   12.758372][    C0]  mbox_chan_received_data+0x44/0x94
>> [   12.758386][    C0]  __handle_irq_event_percpu+0xd4/0x240
>> This patch frees the mailbox channels setup during probe and adds some 
>> more
>> error handling in case the probe fails.
>> 
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/firmware/arm_scmi/driver.c | 35 
>> ++++++++++++++++++++++++-----------
>>  1 file changed, 24 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/firmware/arm_scmi/driver.c 
>> b/drivers/firmware/arm_scmi/driver.c
>> index 9b2e8d4..ead3bd3 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -1390,6 +1390,21 @@ void scmi_protocol_device_unrequest(const 
>> struct scmi_device_id *id_table)
>>  	mutex_unlock(&scmi_requested_devices_mtx);
>>  }
>> 
> 
> Hi,
> 
>> +static int scmi_cleanup_txrx_channels(struct scmi_info *info)
>> +{
>> +	int ret;
>> +	struct idr *idr = &info->tx_idr;
>> +
>> +	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> +	idr_destroy(&info->tx_idr);
>> +
>> +	idr = &info->rx_idr;
>> +	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> +	idr_destroy(&info->rx_idr);
>> +
>> +	return ret;
>> +}
>> +
>>  static int scmi_probe(struct platform_device *pdev)
>>  {
>>  	int ret;
>> @@ -1430,7 +1445,7 @@ static int scmi_probe(struct platform_device 
>> *pdev)
>> 
>>  	ret = scmi_xfer_info_init(info);
>>  	if (ret)
>> -		return ret;
>> +		goto clear_txrx_setup;
>> 
>>  	if (scmi_notification_init(handle))
>>  		dev_err(dev, "SCMI Notifications NOT available.\n");
>> @@ -1443,7 +1458,7 @@ static int scmi_probe(struct platform_device 
>> *pdev)
>>  	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
>>  	if (ret) {
>>  		dev_err(dev, "unable to communicate with SCMI\n");
>> -		return ret;
>> +		goto notification_exit;
>>  	}
>> 
>>  	mutex_lock(&scmi_list_mutex);
>> @@ -1482,6 +1497,12 @@ static int scmi_probe(struct platform_device 
>> *pdev)
>>  	}
>> 
>>  	return 0;
>> +
>> +notification_exit:
>> +	scmi_notification_exit(&info->handle);
>> +clear_txrx_setup:
>> +	scmi_cleanup_txrx_channels(info);
>> +	return ret;
>>  }
>> 
>>  void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, 
>> int id)
>> @@ -1493,7 +1514,6 @@ static int scmi_remove(struct platform_device 
>> *pdev)
>>  {
>>  	int ret = 0, id;
>>  	struct scmi_info *info = platform_get_drvdata(pdev);
>> -	struct idr *idr = &info->tx_idr;
>>  	struct device_node *child;
>> 
>>  	mutex_lock(&scmi_list_mutex);
>> @@ -1517,14 +1537,7 @@ static int scmi_remove(struct platform_device 
>> *pdev)
>>  	idr_destroy(&info->active_protocols);
>> 
>>  	/* Safe to free channels since no more users */
>> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> -	idr_destroy(&info->tx_idr);
>> -
>> -	idr = &info->rx_idr;
>> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> -	idr_destroy(&info->rx_idr);
>> -
>> -	return ret;
>> +	return scmi_cleanup_txrx_channels(info);
>>  }
>> 
> 
> Looks good to me.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> (Re-tested on for-next/scmi on top of virtio-scmi series)
> 
> Thanks,
> Cristian
