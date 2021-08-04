Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46B13DFD18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhHDIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:40:49 -0400
Received: from foss.arm.com ([217.140.110.172]:57608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236477AbhHDIks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:40:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C39831B;
        Wed,  4 Aug 2021 01:40:36 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025663F66F;
        Wed,  4 Aug 2021 01:40:34 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:40:32 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH] firmware: arm_scmi: Free mailbox channels if probe fails
Message-ID: <20210804084032.GS6592@e120937-lin>
References: <1628029342-3638-1-git-send-email-rishabhb@codeaurora.org>
 <20210804083358.GR6592@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804083358.GR6592@e120937-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 09:33:58AM +0100, Cristian Marussi wrote:
> On Tue, Aug 03, 2021 at 03:22:22PM -0700, Rishabh Bhatnagar wrote:
> > Mailbox channels for the base protocol are setup during probe.
> > There can be a scenario where probe fails to acquire the base
> > protocol due to a timeout leading to cleaning up of all device
> > managed memory including the scmi_mailbox structure setup during
> > mailbox_chan_setup function.
> > [   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: version_get+0x84/0x140)
> > [   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
> > [   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110
> > 
> > Now when a message arrives at cpu slightly after the timeout, the mailbox
> > controller will try to call the rx_callback of the client and might end
> > up accessing freed memory.
> > [   12.758363][    C0] Call trace:
> > [   12.758367][    C0]  rx_callback+0x24/0x160
> > [   12.758372][    C0]  mbox_chan_received_data+0x44/0x94
> > [   12.758386][    C0]  __handle_irq_event_percpu+0xd4/0x240
> > This patch frees the mailbox channels setup during probe and adds some more
> > error handling in case the probe fails.
> > 
> > Change-Id: I1214ec2c4c92c4a3ca5fa73de11e0e403b13b46a
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> 
> Hi Rishabh,
> 
> Good catch, thanks for this.
> 

Hi again,

sorry forgot one thing.

> > ---
> >  drivers/firmware/arm_scmi/driver.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 9b2e8d4..518c7b9 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1430,7 +1430,7 @@ static int scmi_probe(struct platform_device *pdev)
> >  
> >  	ret = scmi_xfer_info_init(info);
> >  	if (ret)
> > -		return ret;
> > +		goto clear_txrx_setup;
> >  
> >  	if (scmi_notification_init(handle))
> >  		dev_err(dev, "SCMI Notifications NOT available.\n");
> > @@ -1443,7 +1443,7 @@ static int scmi_probe(struct platform_device *pdev)
> >  	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
> >  	if (ret) {
> >  		dev_err(dev, "unable to communicate with SCMI\n");
> > -		return ret;
> > +		goto notification_exit;
> >  	}
> >  
> >  	mutex_lock(&scmi_list_mutex);
> > @@ -1482,6 +1482,13 @@ static int scmi_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	return 0;
> > +
> > +notification_exit:
> > +	scmi_notification_exit(&info->handle);
> > +clear_txrx_setup:
> > +	idr_for_each(&info->tx_idr, info->desc->ops->chan_free, &info->tx_idr);
> > +	idr_for_each(&info->rx_idr, info->desc->ops->chan_free, &info->rx_idr);
> > +	return ret;
> >  }
> >  
> 
> Shouldn't we also clear the internal IDRs memory allocs after these
> idr_for_each() adding a couple of:
> 
> 	idr_destroy(&info->tx_idr);
> 
> 	idr_destroy(&info->rx_idr);
> 
> like scmi_remove() does ?
> 

Maybe it could be worth at this point unifying this common "cleanup-all-channels"
logic shared between scmi_probe()-error-path and scmi_remove() into its own
helper function to call from both sites.

Thanks,
Cristian
