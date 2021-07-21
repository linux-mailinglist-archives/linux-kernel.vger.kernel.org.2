Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE053D0804
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhGUESs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhGUESh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19772611C1;
        Wed, 21 Jul 2021 04:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626843554;
        bh=b6IDKKSTuET5UbImwi5gnCTWu3F5j9/wKXMyH1lizOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYCKH6IZ0XCf/I+eSPBPKisIl6CfLr+SjsaBUudlWdY8HOyFC4ym65221NMExS0TN
         m+JR8LWk+9w6pJOFkE1FAtLcGy4Ic82ZKlTdhFvbELpnSGnumibJJ/+2HWd4CS0Sr7
         UiHXtO8O7lIS58Fa8RWC5nZvlQ7soKtSMmuQxcuc=
Date:   Wed, 21 Jul 2021 06:59:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Broadfoot <msbroadf@gmail.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A reset can be sent anytime and so the vhcd Root Hub
 should renable the port always on a virtual reset
Message-ID: <YPepoOjwX9WSjJYG@kroah.com>
References: <YPd1FhI/ASlQ2K9o@michael-gitpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPd1FhI/ASlQ2K9o@michael-gitpc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:15:02AM +1000, Michael Broadfoot wrote:
> And if the HIGH and LOW flags are not set on the port
> status that means FULL speed and is not an
> error (see 11.24.2.7.1 Port Status Bits)
> ---
>  drivers/usb/usbip/vhci_hcd.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..3ea76dcdc8e2 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -455,15 +455,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
>  			vhci_hcd->re_timeout = 0;
>  
> -			if (vhci_hcd->vdev[rhport].ud.status ==
> -			    VDEV_ST_NOTASSIGNED) {
>  				usbip_dbg_vhci_rh(
>  					" enable rhport %d (status %u)\n",
>  					rhport,
>  					vhci_hcd->vdev[rhport].ud.status);
>  				vhci_hcd->port_status[rhport] |=
>  					USB_PORT_STAT_ENABLE;
> -			}
>  
>  			if (hcd->speed < HCD_USB3) {
>  				switch (vhci_hcd->vdev[rhport].speed) {
> @@ -475,8 +472,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  					vhci_hcd->port_status[rhport] |=
>  						USB_PORT_STAT_LOW_SPEED;
>  					break;
> -				default:
> -					pr_err("vhci_device speed not set\n");
> +				default: // FULL speed
>  					break;
>  				}
>  			}
> -- 
> 2.30.2
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
