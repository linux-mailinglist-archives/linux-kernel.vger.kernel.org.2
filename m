Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6EE3F47B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhHWJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhHWJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCBBB613A1;
        Mon, 23 Aug 2021 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629711334;
        bh=CH9hXLteUpsRuWjGPC0tT2eQoaaJPCaZsNRvenD8s8Y=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=t6BQ1zn/Q4DilPqm0vxmPDmzQZo69iPu4m6tKIXMJvezlGBdN/j3m2hv4SblGM3PK
         5MqEH+UavaOCriudTW3RqBOTqFwmh+lQdkC0lMSaYI63HFrKtQEUfD1n9LTcif5e+w
         4m990p8fJFGczY3Xx9H99pBzl+HuPHFvNlm2BAr1+bNZ1FTYdCorit6Y4ztlmd6Ipr
         7VrFsnbOgrGtnYnrbdTCEnJFLRMb/GjIMAvwEkK0DN8M+BGTyhVMgh6NuMykEq+1ke
         HKHGGd3XQvv8hGtkBFVpjio+9cmHFuA6qqE8O1Sm5cRExExX+C6KjG50Vx4KIFqdYY
         1g98zhwNKGCCQ==
References: <20210823092324.1949-1-wcheng@codeaurora.org>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Stop EP0 transfers during pullup
 disable
Date:   Mon, 23 Aug 2021 12:34:07 +0300
In-reply-to: <20210823092324.1949-1-wcheng@codeaurora.org>
Message-ID: <87eeakld0d.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wesley Cheng <wcheng@codeaurora.org> writes:

> During a USB cable disconnect, or soft disconnect scenario, a pending
> SETUP transaction may not be completed, leading to the following
> error:
>
>     dwc3 a600000.dwc3: timed out waiting for SETUP phase
>
> If this occurs, then the entire pullup disable routine is skipped and
> proper cleanup and halting of the controller does not complete.

nit: might want to add a blank line between paragraphs to aid
readability

> Instead of returning an error (which is ignored from the UDC
> perspective), allow the pullup disable to routine to continue, which
                                         ^^
                                         remove this?

> will also handle disabling of EP0/1.  This will end any active
> transfers as well.  Ensure to clear any delayed_status as well, as the
> timeout could happen within the STATUS stage.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
> Changes in v2:
>  - Removed calls to dwc3_ep0_end_control_data() and just allow the ep disables
>    on EP0 handle the proper ending of transfers.
>  - Ensure that delayed_status is cleared, as ran into enumeration issues if the
>    SETUP transaction fails on a STATUS stage.  Saw delayed_status == TRUE on the
>    next connect, which blocked further SETUP transactions to be handled.
>
>  drivers/usb/dwc3/gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 5d084542718d..8b6a95c35741 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2430,7 +2430,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>  		if (ret == 0) {
>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
> -			return -ETIMEDOUT;
>  		}

Since the `if' now has a single statement, you should remove the curly braces.

-- 
balbi
