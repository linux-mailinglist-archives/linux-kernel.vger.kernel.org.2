Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F13AA047
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhFPPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235806AbhFPPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:46:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BCED6101A;
        Wed, 16 Jun 2021 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623858286;
        bh=f/xcAG1IRmaGtuCoW1IWbSMqwmbcXKq1LV28L5Ej9dA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=coTe9lX/le3kVOq3qM/BKv1R8u4AgSuv9TvLVgHCO4i7Fh463q2tZFa2g5XasDZiH
         0vKjWqJOcLIHU7DMy+XeI3yZK9qqoH1jjDUgU1ZwFGG+K8NwnaD3e6ibqtyU5ceF3U
         DJF0Ro6AWT0y9LIH6YYmWSRDjPx73BDJc2lwYYc8hnd8bvVA6kcoq1WjEQU2dRCCZG
         58sDvra/DwrMQ8QoEy+CPK2MGBVl/+9u4sRsM45pRymhPiSzV3fsbK6S0jOITxsrCh
         qNShz4iQvbUopOqMjPSqtvAi8bgwGgC9RPGixXKbsmDloD/BomVLM0Kh9j/aRj3THt
         Mvv4fXorR2qeA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ltXid-0000Jt-RZ; Wed, 16 Jun 2021 17:44:43 +0200
Date:   Wed, 16 Jun 2021 17:44:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     tu pham <thanhtung1909@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hung.Nguyen@silabs.com, Tung.Pham@silabs.com,
        Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v13] USB: serial: cp210x: add support for GPIOs on CP2108
Message-ID: <YMoca78ftxqGH2Kp@hovoldconsulting.com>
References: <YMITDyLtcPinbHMv@hovoldconsulting.com>
 <20210610132844.25495-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610132844.25495-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 03:28:44PM +0200, Johan Hovold wrote:
> From: Pho Tran <pho.tran@silabs.com>
> 
> Similar to some other CP210x device types, CP2108 has a number of GPIO
> pins that can be exposed through gpiolib.
> 
> CP2108 has four serial interfaces but only one set of GPIO pins, which
> is modelled as a single gpio chip and registered as a child of the first
> interface.
> 
> CP2108 has 16 GPIOs so the width of the state variables needs to be
> extended to 16 bits and this is also reflected in the control requests.
> 
> Like CP2104, CP2108 have GPIO pins with configurable alternate
> functions and pins unavailable for GPIO use are determined and reported
> to gpiolib at probe.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> Co-developed-by: Tung Pham <tung.pham@silabs.com>
> Signed-off-by: Tung Pham <tung.pham@silabs.com>
> [ johan: rewrite gpio get() and set(); misc cleanups; amend commit
>          message ]
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Tested using CP2108 and CP2102N.
> 
> Changes in v13
>  - rewrite cp210x_gpio_get() using a shared 16 bit mask and
>    le16_to_cpus()
>  - rewrite cp210x_gpio_set() using shared 16-bit mask and state
>    variables
>  - drop pointless no-op shift and mask operations during initialisation
>  - reorder defines
>  - reword some comments
>  - fix some style issues
>  - amend commit message
> 
> v12 can be found here:
>  - https://lore.kernel.org/r/20210426091244.19994-1-tupham@silabs.com
> 
> 
>  drivers/usb/serial/cp210x.c | 189 ++++++++++++++++++++++++++++++++----
>  1 file changed, 170 insertions(+), 19 deletions(-)

> @@ -1414,52 +1468,84 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> -	u8 req_type = REQTYPE_DEVICE_TO_HOST;
> +	u8 req_type;
> +	u16 mask;
>  	int result;
> -	u8 buf;
> -
> -	if (priv->partnum == CP210X_PARTNUM_CP2105)
> -		req_type = REQTYPE_INTERFACE_TO_HOST;
> +	int len;
>  
>  	result = usb_autopm_get_interface(serial->interface);
>  	if (result)
>  		return result;
>  
> -	result = cp210x_read_vendor_block(serial, req_type,
> -					  CP210X_READ_LATCH, &buf, sizeof(buf));
> +	switch (priv->partnum) {
> +	case CP210X_PARTNUM_CP2105:
> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +		len = 1;
> +		break;
> +	case CP210X_PARTNUM_CP2108:
> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +		len = 2;
> +		break;
> +	default:
> +		req_type = REQTYPE_DEVICE_TO_HOST;
> +		len = 1;
> +		break;
> +	}
> +
> +	mask = 0;
> +	result = cp210x_read_vendor_block(serial, req_type, CP210X_READ_LATCH,
> +					  &mask, len);
> +
>  	usb_autopm_put_interface(serial->interface);
> +
>  	if (result < 0)
>  		return result;
>  
> -	return !!(buf & BIT(gpio));
> +	le16_to_cpus((__le16 *)&mask);

Now applied after removing the (__le16 *) cast here.

> +
> +	return !!(mask & BIT(gpio));
>  }

Johan
