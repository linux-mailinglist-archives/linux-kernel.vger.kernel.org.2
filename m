Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282973B0DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhFVT6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhFVT6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:58:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5965F6100B;
        Tue, 22 Jun 2021 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624391782;
        bh=LyYRwhLs+JRdEP5xKhL9L3kwtUp9LtMKTUuL1voWUnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nc6wVvjslJbKHAsLCOm5PtRWWXx7gVsFj8vTiTi3OfX7IVzIunNVftSgFaLe6xtlP
         bgeOA6xb167WmvUxlavsFjSMiU0tTK9DOwVbf08UnSF6bSZQFygtAdsiJ6kQG+QpNW
         CHofzexvPV2vA46eGeG/KvAK530z7fFcPwF9HSQk=
Date:   Tue, 22 Jun 2021 21:56:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <YNJAZDwuFmEoTJHe@kroah.com>
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
 <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> It seems 10 secs timeout is too long in general case. A core would wait for
> 10 secs without doing other task and it can be happended on every device.

Only if the handshake does not come back sooner, right?

What is causing your device to timeout here?

> It's better to reduce timeout for general case and use new quirk if needed.

What new quirk?

And why 1 second, where did that number come from?

> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 9248ce8..0a1b6be 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -196,7 +196,7 @@ int xhci_reset(struct xhci_hcd *xhci)
>  		udelay(1000);
>  
>  	ret = xhci_handshake(&xhci->op_regs->command,
> -			CMD_RESET, 0, 10 * 1000 * 1000);
> +			CMD_RESET, 0, 1 * 1000 * 1000);
>  	if (ret)
>  		return ret;
>  
> @@ -210,7 +210,7 @@ int xhci_reset(struct xhci_hcd *xhci)
>  	 * than status until the "Controller Not Ready" flag is cleared.
>  	 */
>  	ret = xhci_handshake(&xhci->op_regs->status,
> -			STS_CNR, 0, 10 * 1000 * 1000);
> +			STS_CNR, 0, 1 * 1000 * 1000);

With this change, what "goes faster"?  What is currently causing
problems with your host controller that this timeout value actually
matters?  Why is it failing?

thanks,

greg k-h
