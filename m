Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4894F31666E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBJMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhBJMM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:12:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED3664DF0;
        Wed, 10 Feb 2021 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612959108;
        bh=bSAc2e8m/A9jQUXC9A9vzo6+rAFEk18X6U6Ix90KYLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWcUFfV9ySiW0wXQCYcD8KMJ9NesEQ6GES8PYaU+BhYAwzuEAtJpiiKwKL8m+Yb6E
         nvX90N9PxzNWM9l6SGzWifCjemhfDpYFCJJljV4YDTqPzomRX2d80oW8fDSuTpxnIB
         AeBG+oS5kY/1eAGUf7nWgcpDBp0y5McDuFcaE7So=
Date:   Wed, 10 Feb 2021 13:11:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Ursella <stefan.ursella@wolfvision.net>
Cc:     Johan Hovold <johan@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Tomasz =?utf-8?Q?Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: quirks: add quirk to start video capture on ELMO
 L-12F document camera reliable
Message-ID: <YCPNgNblgqQPcnY6@kroah.com>
References: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
 <20210210115144.17014-1-stefan.ursella@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210115144.17014-1-stefan.ursella@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:51:43PM +0100, Stefan Ursella wrote:
> Without this quirk starting a video capture from the device often fails with
> 
> kernel: uvcvideo: Failed to set UVC probe control : -110 (exp. 34).
> 
> Signed-off-by: Stefan Ursella <stefan.ursella@wolfvision.net>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 84b5da0a26a5..270ad082d3ba 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -381,6 +381,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* X-Rite/Gretag-Macbeth Eye-One Pro display colorimeter */
>  	{ USB_DEVICE(0x0971, 0x2000), .driver_info = USB_QUIRK_NO_SET_INTF },
>  
> +	/* ELMO L-12F document camera */
> +	{ USB_DEVICE(0x09a1, 0x0028), .driver_info = USB_QUIRK_DELAY_CTRL_MSG },
> +
>  	/* Broadcom BCM92035DGROM BT dongle */
>  	{ USB_DEVICE(0x0a5c, 0x2021), .driver_info = USB_QUIRK_RESET_RESUME },
>  
> -- 
> 2.17.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
