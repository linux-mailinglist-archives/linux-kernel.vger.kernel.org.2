Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C493DE1B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhHBVeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:34:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55611 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhHBVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:34:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627940034; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=b8IL7+f3j4Is7lBvpG+WcoalH2aNdPrYqZ34d0uvjjU=; b=rQFKrB4N32D+hF4UA6WwGsUDCQ+i6F5VguY7ugxm181LohjpdJpUi5ZnszSQ04stpv+GNZX1
 a7qnEqPseVjuQqHNM/sZK4C7FPIUnQ7kHhzrZZCytjVpiHeRoOUgv7F1cWojd1sEotxIj+PN
 l2UBeBPcLApy88GSmSm+wPRZFFg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6108649c17c2b4047d3bf72c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Aug 2021 21:33:16
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2975C433F1; Mon,  2 Aug 2021 21:33:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CEC5C433D3;
        Mon,  2 Aug 2021 21:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CEC5C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 2 Aug 2021 14:33:01 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid runtime resume if disabling
 pullup
Message-ID: <20210802213301.GG25299@jackp-linux.qualcomm.com>
References: <1627691374-15711-1-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627691374-15711-1-git-send-email-wcheng@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Fri, Jul 30, 2021 at 05:29:34PM -0700, Wesley Cheng wrote:
> If the device is already in the runtime suspended state, any call to
> the pullup routine will issue a runtime resume on the DWC3 core
> device.  If the USB gadget is disabling the pullup, then avoid having
> to issue a runtime resume, as DWC3 gadget has already been
> halted/stopped.
> 
> This fixes an issue where the following condition occurs:
> 
> usb_gadget_remove_driver()
> -->usb_gadget_disconnect()
>  -->dwc3_gadget_pullup(0)
>   -->pm_runtime_get_sync() -> ret = 0
>   -->pm_runtime_put() [async]
> -->usb_gadget_udc_stop()
>  -->dwc3_gadget_stop()
>   -->dwc->gadget_driver = NULL
> ...
> 
> dwc3_suspend_common()
> -->dwc3_gadget_suspend()
>  -->DWC3 halt/stop routine skipped, driver_data == NULL
> 
> This leads to a situation where the DWC3 gadget is not properly
> stopped, as the runtime resume would have re-enabled EP0 and event
> interrupts, and since we avoided the DWC3 gadget suspend, these
> resources were never disabled.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a29a4ca..5d08454 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2435,6 +2435,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	}
>  
>  	/*
> +	 * Avoid issuing a runtime resume if the device is already in the
> +	 * suspended state during gadget disconnect.  DWC3 gadget was already
> +	 * halted/stopped during runtime suspend.
> +	 */
> +	if (!is_on) {
> +		pm_runtime_barrier(dwc->dev);
> +		if (pm_runtime_suspended(dwc->dev))
> +			return 0;
> +	}
> +
> +	/*
>  	 * Check the return value for successful resume, or error.  For a
>  	 * successful resume, the DWC3 runtime PM resume routine will handle
>  	 * the run stop sequence, so avoid duplicate operations here.

Should this also go to stable with Fixes: 77adb8bdf422 ("usb: dwc3:
gadget: Allow runtime suspend if UDC unbinded") ?

Jack
