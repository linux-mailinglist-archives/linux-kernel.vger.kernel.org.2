Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE03F59C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhHXITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhHXITL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21F1461220;
        Tue, 24 Aug 2021 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629793107;
        bh=nykxD81K9jux0Z9cYpoVeP6Sogs7zBWpCbzPYz9PWvo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=DcUkzqlfF30qlcEzv0MWg1icXwzmG6RXblOkrmMUnY2rEbGruDFmV4TR4xnUWJIQj
         6cqSjYVtIhd+XxZOTk6GQ3I8oQTjBYzF9HOro4u1MlCEQm8dYAw1d+0CmF23YjQYJA
         6SBw/inxQ9nN5PUU2QzDIvT/PTY/Me5fO3eDwu5O09sw0GhO6BRRUDoZIJTWkDgOsb
         GVVC7taJd76uqlY/mH43Em86D6aCs4xr9BlQ2qV1tSawheKp5t3yxFVWuaoHBFSHFm
         SE5nGnujtPygw2A0laSYhpBeNspH1DgnIASkmrelOO0J4+ZxE337sR+BlRZyDFNi3A
         9jF5IKearMCGw==
References: <20210823222458.3760-1-wcheng@codeaurora.org>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v4] usb: dwc3: gadget: Stop EP0 transfers during pullup
 disable
Date:   Tue, 24 Aug 2021 11:17:59 +0300
In-reply-to: <20210823222458.3760-1-wcheng@codeaurora.org>
Message-ID: <87y28r6ysv.fsf@kernel.org>
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
>
> Instead of returning an error (which is ignored from the UDC
> perspective), allow the pullup disable routine to continue, which
> will also handle disabling of EP0/1.  This will end any active
> transfers as well.  Ensure to clear any delayed_status also, as the
> timeout could happen within the STATUS stage.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
> Changes in v4:
>  - Fixed formatting and typos in commit text
>  - Removed braces due to the removal of the return statement
>
> Changes in v3:
>  - Added suggestion by Thinh to change dev_err to dev_warn
>
> Changes in v2:
>  - Removed calls to dwc3_ep0_end_control_data() and just allow the ep disables
>    on EP0 handle the proper ending of transfers.
>  - Ensure that delayed_status is cleared, as ran into enumeration issues if the
>    SETUP transaction fails on a STATUS stage.  Saw delayed_status == TRUE on the
>    next connect, which blocked further SETUP transactions to be handled.
>
>  drivers/usb/dwc3/gadget.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 5d084542718d..63f6d9f2a692 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2428,10 +2428,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  
>  		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
> -		if (ret == 0) {
> -			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
> -			return -ETIMEDOUT;
> -		}
> +		if (ret == 0)
> +			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");

looks like a bug fix. Do we need to Cc stable?

-- 
balbi
