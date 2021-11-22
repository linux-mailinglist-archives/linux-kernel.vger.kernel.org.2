Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F945898C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhKVHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhKVHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:05:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C80E860F24;
        Mon, 22 Nov 2021 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637564531;
        bh=HqHzOX2x8A2bBW7j4cgfMHOEsSLbe+uOkjnMuhTI+7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eP+MjYVGoB7A8398EUpB5BXTK3hUdwfjYG8WRVv0uml1gOmLyeo1H8vc/6xMB1VYx
         OZM6O0bVuIsyFXEdVoBqlYPMrbi5dj1jPyhw2fnInbApzPyD9q7faaxtcjlcXhTPTw
         QoHGi4ayYRlS7MOLNqSVCuAxCRuXqnBHx5TyMoZ8=
Date:   Mon, 22 Nov 2021 08:02:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     robh+dt@kernel.org, mka@chromium.org, ravisadineni@chromium.org,
        stern@rowland.harvard.edu, alcooperx@gmail.com,
        michal.simek@xilinx.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sgoud@xilinx.com
Subject: Re: [PATCH V2 2/2] usb: misc: usb244: add support for USB2 ultra
 fast sd controller
Message-ID: <YZtAb9lz8WLnWu7E@kroah.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
 <20211122062834.1812005-3-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122062834.1812005-3-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:58:34AM +0530, Piyush Mehta wrote:
> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
> provides an ultra-fast interface between a USB host controller and flash
> media cards.
> 
> This patch adds a GPIO based usb-sd reset for USB2244 USB2 ultra fast
> SD controller. This usb2244 driver trigger sd reset signal after soft
> reset or core Reset. The SD needs to be resetted after completion of
> phy initialization. After the toggling of gpio, controller gets out
> form reset. USB2244 is a simple platform device driver.
> 
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of microseconds is added in between high and
> low to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Update reset polarity, make reset ACTIVE LOW in the usb2244 driver.
> - Fix WARNING: msleep < 20ms can sleep for up to 20ms by changing msleep to
>   usleep_range()
> ---
>  drivers/usb/misc/Kconfig   | 10 +++++++
>  drivers/usb/misc/Makefile  |  1 +
>  drivers/usb/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++

This isn't really a USB driver, so maybe drivers/misc/ instead?

>  3 files changed, 80 insertions(+)
>  create mode 100644 drivers/usb/misc/usb2244.c
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 8f11443..e1c66a2 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -215,6 +215,16 @@ config USB_ISIGHTFW
>  	  driver beforehand. Tools for doing so are available at
>  	  http://bersace03.free.fr
>  
> +config USB_USB2244
> +	tristate "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
> +	depends on GPIOLIB
> +	help
> +	  Say Y or M here if you want to reset Microchip USB2244 Ultra Fast
> +	  USB 2.0 SD controller.
> +	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
> +	  SD controller. This driver reset the gpio pin makes controller out of
> +	  reset.

Module name?

> +
>  config USB_YUREX
>  	tristate "USB YUREX driver support"
>  	help
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index 5f4e598..5b4af7d 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_USB_LEGOTOWER)		+= legousbtower.o
>  obj-$(CONFIG_USB_TEST)			+= usbtest.o
>  obj-$(CONFIG_USB_EHSET_TEST_FIXTURE)    += ehset.o
>  obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
> +obj-$(CONFIG_USB_USB2244)		+= usb2244.o
>  obj-$(CONFIG_USB_USS720)		+= uss720.o
>  obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
>  obj-$(CONFIG_USB_YUREX)			+= yurex.o
> diff --git a/drivers/usb/misc/usb2244.c b/drivers/usb/misc/usb2244.c
> new file mode 100644
> index 0000000..5a868c2
> --- /dev/null
> +++ b/drivers/usb/misc/usb2244.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Microchip USB2244 Ultra Fast USB 2.0 Multi-Format,
> + * SD/MMC, and MS Flash Media Controllers
> + *
> + * Copyright (c) 2021 Xilinx, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +
> +struct usb2244 {
> +	struct gpio_desc *reset_gpio;
> +};

Why is this structure needed?

> +
> +static int usb2244_init_hw(struct device *dev, struct usb2244 *data)
> +{
> +	data = devm_kzalloc(dev, sizeof(struct usb2244), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->reset_gpio)) {
> +		dev_err_probe(dev, PTR_ERR(data->reset_gpio),
> +			      "Failed to request reset GPIO %ld, errcode",
> +			      PTR_ERR(data->reset_gpio));
> +		return PTR_ERR(data->reset_gpio);
> +	}
> +
> +	/* Toggle RESET_N to reset the hub. */
> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +	usleep_range(5, 10);
> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
> +	usleep_range(5000, 6000);

Why do you need a kernel driver for this at all?  Why not just toggle
the pin from userspace?

thanks,

greg k-h
