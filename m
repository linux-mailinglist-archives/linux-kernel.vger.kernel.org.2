Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680EE32619F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBZK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:58:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3816964EE1;
        Fri, 26 Feb 2021 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614337055;
        bh=00rc4RUiQWZ4q7RnENrzGetH5T02eUu9IMxTo8Kdgjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhWtCujebkitKYQm4YIa58nOtrACAyc9BbCc1w2h0yDcL2d13EEzOFfpAIFu4dIRw
         FTJlZH7w2jAFCIEnHlCPMV8sdAkEilYJOHZbA3tbIcOabDiOW36q0MwSOqMeUvL1hO
         i+LNzo/q1Cr7iVXU+KNY/pSInllfNGhY2RXyuy6SJptZmngwN5Ry7kxYim0eKGsMAp
         8t9t5akqw8O75pi/Mofs/2GKA0BunbsUssMKq3riNLxwoEKxDSqKnV6yoVxtmXHC4o
         BY/aikGhGgLfPYgjfXhk45kfODtG9UaE3eti+sPXoanpqfNFHJXS0KWp/rSm8K9msU
         wQne/sl5YNdqw==
Date:   Fri, 26 Feb 2021 16:27:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: xr: fix NULL-deref on disconnect
Message-ID: <20210226105729.GA7069@work>
References: <20210226100826.18987-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226100826.18987-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:08:26AM +0100, Johan Hovold wrote:
> Claiming the sibling control interface is a bit more involved and
> specifically requires adding support to USB-serial core for managing
> either interface being unbound first, something which could otherwise
> lead to a NULL-pointer dereference.
> 
> Similarly, additional infrastructure is also needed to handle suspend
> properly.
> 
> Since the driver currently isn't actually using the control interface,
> we can defer this for now by simply not claiming the control interface.
> 
> Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/usb/serial/xr_serial.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index 483d07dee19d..0ca04906da4b 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -545,37 +545,13 @@ static void xr_close(struct usb_serial_port *port)
>  
>  static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
>  {
> -	struct usb_driver *driver = serial->type->usb_driver;
> -	struct usb_interface *control_interface;
> -	int ret;
> -
>  	/* Don't bind to control interface */
>  	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
>  		return -ENODEV;
>  
> -	/* But claim the control interface during data interface probe */
> -	control_interface = usb_ifnum_to_if(serial->dev, 0);
> -	if (!control_interface)
> -		return -ENODEV;
> -
> -	ret = usb_driver_claim_interface(driver, control_interface, NULL);
> -	if (ret) {
> -		dev_err(&serial->interface->dev, "Failed to claim control interface\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> -static void xr_disconnect(struct usb_serial *serial)
> -{
> -	struct usb_driver *driver = serial->type->usb_driver;
> -	struct usb_interface *control_interface;
> -
> -	control_interface = usb_ifnum_to_if(serial->dev, 0);
> -	usb_driver_release_interface(driver, control_interface);
> -}
> -
>  static const struct usb_device_id id_table[] = {
>  	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
>  	{ }
> @@ -590,7 +566,6 @@ static struct usb_serial_driver xr_device = {
>  	.id_table		= id_table,
>  	.num_ports		= 1,
>  	.probe			= xr_probe,
> -	.disconnect		= xr_disconnect,
>  	.open			= xr_open,
>  	.close			= xr_close,
>  	.break_ctl		= xr_break_ctl,
> -- 
> 2.26.2
> 
