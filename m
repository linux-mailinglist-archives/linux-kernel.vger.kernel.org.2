Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BC3E06C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhHDR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:29:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32179 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhHDR3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:29:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628098180; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nzaujCSgUfZkjQc5wEHtAsDBcRXD0VdybmR5O72hMKQ=;
 b=pZXfda0dTTrKxDAgqWkByMad6i4oY73ZnPqu6mCAeq+eE9Rx2/L4iGDPjxdXuL6fX/8mmStB
 OBZT2/B9R65NkcD1MT4gFWbSfCo2vYSietuCmrWhzrW3JjhbJfYD4O4F8RAVBNDbF2INNGuZ
 p5pL9pFr0k/lNFhGQA2QLRZeGoE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 610ace79bcdc32aad3f147db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 17:29:29
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48DF2C43460; Wed,  4 Aug 2021 17:29:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6913CC433F1;
        Wed,  4 Aug 2021 17:29:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Aug 2021 10:29:28 -0700
From:   rishabhb@codeaurora.org
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH] firmware: arm_scmi: Free mailbox channels if probe fails
In-Reply-To: <20210804084032.GS6592@e120937-lin>
References: <1628029342-3638-1-git-send-email-rishabhb@codeaurora.org>
 <20210804083358.GR6592@e120937-lin> <20210804084032.GS6592@e120937-lin>
Message-ID: <8b5434c123c2e310d7dbeac8c9a10146@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 01:40, Cristian Marussi wrote:
> On Wed, Aug 04, 2021 at 09:33:58AM +0100, Cristian Marussi wrote:
>> On Tue, Aug 03, 2021 at 03:22:22PM -0700, Rishabh Bhatnagar wrote:
>> > Mailbox channels for the base protocol are setup during probe.
>> > There can be a scenario where probe fails to acquire the base
>> > protocol due to a timeout leading to cleaning up of all device
>> > managed memory including the scmi_mailbox structure setup during
>> > mailbox_chan_setup function.
>> > [   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: version_get+0x84/0x140)
>> > [   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
>> > [   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110
>> >
>> > Now when a message arrives at cpu slightly after the timeout, the mailbox
>> > controller will try to call the rx_callback of the client and might end
>> > up accessing freed memory.
>> > [   12.758363][    C0] Call trace:
>> > [   12.758367][    C0]  rx_callback+0x24/0x160
>> > [   12.758372][    C0]  mbox_chan_received_data+0x44/0x94
>> > [   12.758386][    C0]  __handle_irq_event_percpu+0xd4/0x240
>> > This patch frees the mailbox channels setup during probe and adds some more
>> > error handling in case the probe fails.
>> >
>> > Change-Id: I1214ec2c4c92c4a3ca5fa73de11e0e403b13b46a
>> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> 
>> Hi Rishabh,
>> 
>> Good catch, thanks for this.
>> 
> 
> Hi again,
> 
> sorry forgot one thing.
> 
>> > ---
>> >  drivers/firmware/arm_scmi/driver.c | 11 +++++++++--
>> >  1 file changed, 9 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> > index 9b2e8d4..518c7b9 100644
>> > --- a/drivers/firmware/arm_scmi/driver.c
>> > +++ b/drivers/firmware/arm_scmi/driver.c
>> > @@ -1430,7 +1430,7 @@ static int scmi_probe(struct platform_device *pdev)
>> >
>> >  	ret = scmi_xfer_info_init(info);
>> >  	if (ret)
>> > -		return ret;
>> > +		goto clear_txrx_setup;
>> >
>> >  	if (scmi_notification_init(handle))
>> >  		dev_err(dev, "SCMI Notifications NOT available.\n");
>> > @@ -1443,7 +1443,7 @@ static int scmi_probe(struct platform_device *pdev)
>> >  	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
>> >  	if (ret) {
>> >  		dev_err(dev, "unable to communicate with SCMI\n");
>> > -		return ret;
>> > +		goto notification_exit;
>> >  	}
>> >
>> >  	mutex_lock(&scmi_list_mutex);
>> > @@ -1482,6 +1482,13 @@ static int scmi_probe(struct platform_device *pdev)
>> >  	}
>> >
>> >  	return 0;
>> > +
>> > +notification_exit:
>> > +	scmi_notification_exit(&info->handle);
>> > +clear_txrx_setup:
>> > +	idr_for_each(&info->tx_idr, info->desc->ops->chan_free, &info->tx_idr);
>> > +	idr_for_each(&info->rx_idr, info->desc->ops->chan_free, &info->rx_idr);
>> > +	return ret;
>> >  }
>> >
>> 
>> Shouldn't we also clear the internal IDRs memory allocs after these
>> idr_for_each() adding a couple of:
>> 
>> 	idr_destroy(&info->tx_idr);
>> 
>> 	idr_destroy(&info->rx_idr);
>> 
>> like scmi_remove() does ?
>> 
> 
> Maybe it could be worth at this point unifying this common
> "cleanup-all-channels"
> logic shared between scmi_probe()-error-path and scmi_remove() into its 
> own
> helper function to call from both sites.
> 
> Thanks,
> Cristian
Thanks for the review. I'll move the cleanup to a common helper 
function.
It makes sense to destroy tx/rx idrs. I didn't realize they allocate 
memory
internally.
