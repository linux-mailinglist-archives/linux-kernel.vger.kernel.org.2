Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E430326199
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhBZKzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhBZKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:55:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 421E164EE1;
        Fri, 26 Feb 2021 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614336891;
        bh=edOHBPkEfxZwmBzRX/ETwqCCjnmKyxVyCmVbup1TnxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IV33vp+bm0TaEniNyLKnEhZNNyMe5o6i0vDlknB2i7pKOibVQL/cbZbCBFHcyjtVo
         tQF7NCMzUDK4L8fulLQ3GX094g3mrbsGl8AP32nLPXpEnebmUXSW2JYEiXw8dSH1Sd
         eV9KCdza8kopNvajD3TTsMQru5v/fCglwZuWTLOEU5b1lbZgHUhkf9tEHMoqbWGQJy
         n8diK9/PcJoLLiWEs5QndEKqE36ya/9JyzZU7L6pevpdxlCeAppV6nDjzt0RWUuoMA
         BjvnSaDJVoJJMZAlMaIEymDES9r+spxtuNRocOkmvsbt/BVDN8DQbX2YZ68LSdflXM
         5yagWUk1uAF3Q==
Date:   Fri, 26 Feb 2021 11:54:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] USB: serial: xr: fix NULL-deref on disconnect
Message-ID: <20210226115447.6ace5490@coco.lan>
In-Reply-To: <20210226100826.18987-1-johan@kernel.org>
References: <20210226100826.18987-1-johan@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Feb 2021 11:08:26 +0100
Johan Hovold <johan@kernel.org> escreveu:

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

That solved the issue with XR21V1410:

	[ 8176.265862] usbcore: registered new interface driver xr_serial
	[ 8176.265885] usbserial: USB Serial support registered for xr_serial
	[ 8176.265921] xr_serial 2-1:1.1: xr_serial converter detected
	[ 8176.266041] usb 2-1: xr_serial converter now attached to ttyUSB0
	[ 8176.268023] printk: console [ttyUSB0] enabled
	[ 8186.512841] usb 2-1: USB disconnect, device number 5
	[ 8186.513131] printk: console [ttyUSB0] disabled
	[ 8186.513340] xr_serial ttyUSB0: xr_serial converter now disconnected from ttyUSB0
	[ 8186.513376] xr_serial 2-1:1.1: device disconnected

Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Regards,
Mauro

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



Thanks,
Mauro
