Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8633464D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhCJSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:10:05 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:52862 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhCJSJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:09:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615399785; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=4UDlzegvOLBDg09bYlcNach0n7DBzaGRIBBydQB+MVU=; b=Rgy7GzYSWFmzfegMlZ7iyZ271r/W4K92AtkOgcUzxH0yLmdwH4bPAKEXAtUSDwNSGormhNSn
 nwajvh0k9Uv1BB9ii5lJJ4GfngV8iTgmdD/h/LyVYNga/2h1VTbvOWBoUOI1qkl2flGQsjV0
 w3oKLztROxayDm/iAIzY2iXRC8c=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60490b5cf14e98d35db6fb63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 18:09:32
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CADE7C43468; Wed, 10 Mar 2021 18:09:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF1ABC43465;
        Wed, 10 Mar 2021 18:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF1ABC43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 10 Mar 2021 10:09:25 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
Message-ID: <20210310180925.GA16385@jackp-linux.qualcomm.com>
References: <1615374130-28353-1-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615374130-28353-1-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Wed, Mar 10, 2021 at 03:02:10AM -0800, Wesley Cheng wrote:
> In the situations where the DWC3 gadget stops active transfers, once
> calling the dwc3_gadget_giveback(), there is a chance where a function
> driver can queue a new USB request in between the time where the dwc3
> lock has been released and re-aquired.  This occurs after we've already
> issued an ENDXFER command.  When the stop active transfers continues
> to remove USB requests from all dep lists, the newly added request will
> also be removed, while controller still has an active TRB for it.
> This can lead to the controller accessing an unmapped memory address.
> 
> Fix this by ensuring parameters to prevent EP queuing are set before
> calling the stop active transfers API.

Is it correct to say this Fixes: ae7e86108b12 ("usb: dwc3: Stop active
transfers before halting the controller") ?

Jack

> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4780983..4d98fbf 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -783,8 +783,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>  
>  	trace_dwc3_gadget_ep_disable(dep);
>  
> -	dwc3_remove_requests(dwc, dep);
> -
>  	/* make sure HW endpoint isn't stalled */
>  	if (dep->flags & DWC3_EP_STALL)
>  		__dwc3_gadget_ep_set_halt(dep, 0, false);
> @@ -803,6 +801,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>  		dep->endpoint.desc = NULL;
>  	}
>  
> +	dwc3_remove_requests(dwc, dep);
> +
>  	return 0;
>  }
>  
> @@ -1617,7 +1617,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>  {
>  	struct dwc3		*dwc = dep->dwc;
>  
> -	if (!dep->endpoint.desc || !dwc->pullups_connected) {
> +	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>  				dep->name);
>  		return -ESHUTDOWN;
> @@ -2247,6 +2247,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	if (!is_on) {
>  		u32 count;
>  
> +		dwc->connected = false;
>  		/*
>  		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>  		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
> @@ -3329,8 +3330,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>  {
>  	u32			reg;
>  
> -	dwc->connected = true;
> -
>  	/*
>  	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
>  	 * would cause a missing Disconnect Event if there's a
> @@ -3370,6 +3369,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>  	 * transfers."
>  	 */
>  	dwc3_stop_active_transfers(dwc);
> +	dwc->connected = true;
>  
>  	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>  	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
