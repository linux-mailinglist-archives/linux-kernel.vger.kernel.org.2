Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBA314E29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBILW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhBILUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:20:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 941FD64E6B;
        Tue,  9 Feb 2021 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612869610;
        bh=O66toB/7BMykQ77TijJRtJ+Twsm+4LxeZAE82BtmgTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylg3/b9g0w+Em/zrEMNoKWNN/on+pUJdzinH6/iqrLfJOJwnMkZNfjz8MGjaNzObO
         rge7MtjJFZKImE3wmE23XKSjyW3G5nfdSFoENID+BHLJPGZTKR/ZWZH1dCGucCKa2r
         MT8SCFgIqsnDdOcfIKW6uVCGsAyqycmC0C9+7ks8=
Date:   Tue, 9 Feb 2021 12:20:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: misc: usb5744: Add support for USB hub
 controller
Message-ID: <YCJv59g3Tq2haDSa@kroah.com>
References: <cover.1612867682.git.michal.simek@xilinx.com>
 <d6accf76bb5d060a13067816f23008e93264f317.1612867682.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6accf76bb5d060a13067816f23008e93264f317.1612867682.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:48:10AM +0100, Michal Simek wrote:
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> 
> This patch adds a USB GPIO based hub reset for USB5744 hub. This usb5744
> driver trigger hub reset signal after soft reset or core Reset. The HUB
> needs to be resetted after completion of phy initialization. After the
> toggling of gpio, hub configure using i2c usb attached command.
> 
> USB5744 hub can be used without any I2C connection, is handled by a
> simple platform device driver.
> 
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of millisecond is added in between low and
> high to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - s/USB_USB5744/USB_HUB_USB5744/g
> - Fix order in Makefile and Kconfig
> 
>  MAINTAINERS                |   1 +
>  drivers/usb/misc/Kconfig   |   9 +++
>  drivers/usb/misc/Makefile  |   1 +
>  drivers/usb/misc/usb5744.c | 115 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 drivers/usb/misc/usb5744.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7439471b5d37..56d1fcdd24f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2706,6 +2706,7 @@ F:	drivers/edac/synopsys_edac.c
>  F:	drivers/i2c/busses/i2c-cadence.c
>  F:	drivers/i2c/busses/i2c-xiic.c
>  F:	drivers/mmc/host/sdhci-of-arasan.c
> +F:	drivers/usb/misc/usb5744.c
>  N:	zynq
>  N:	xilinx
>  
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 8f1144359012..9995a5701fd9 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -255,6 +255,15 @@ config USB_HSIC_USB4604
>  	help
>  	  This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
>  
> +config USB_HUB_USB5744
> +	tristate "Microchip USB5744 Hub driver"
> +	depends on I2C
> +	depends on GPIOLIB
> +	help
> +	  This option enables support for Microchip USB5744 Hub. This driver
> +	  optionally reset the hub using gpio pin and configure hub via i2c if
> +	  connected.
> +
>  config USB_LINK_LAYER_TEST
>  	tristate "USB Link Layer Test driver"
>  	help
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index 5f4e598573ab..fbb9adf08f8c 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_USB_YUREX)			+= yurex.o
>  obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
>  obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
>  obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
> +obj-$(CONFIG_USB_HUB_USB5744)		+= usb5744.o
>  obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
>  
>  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
> diff --git a/drivers/usb/misc/usb5744.c b/drivers/usb/misc/usb5744.c
> new file mode 100644
> index 000000000000..729b76345c69
> --- /dev/null
> +++ b/drivers/usb/misc/usb5744.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Microchip USB5744 4-port hub.
> + *
> + * Copyright (c) 2021 Xilinx, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +
> +static int usb5744_init_hw(struct device *dev)
> +{
> +	struct gpio_desc *reset_gpio;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(dev, "Failed to bind reset gpio");
> +		return -ENODEV;
> +	}
> +
> +	if (reset_gpio) {
> +		/* Toggle RESET_N to reset the hub. */
> +		gpiod_set_value(reset_gpio, 0);
> +		usleep_range(5, 20); /* trstia */
> +		gpiod_set_value(reset_gpio, 1);
> +		usleep_range(5000, 10000); /* tcsh */
> +	}
> +
> +	return 0;
> +}
> +
> +static int usb5744_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	/* Trigger gpio reset to the hub. */
> +	ret = usb5744_init_hw(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Send SMBus command to boot hub. */
> +	ret = i2c_smbus_write_word_data(client, 0xAA, swab16(0x5600));
> +	if (ret < 0)
> +		dev_err(dev, "Sending boot command failed");
> +
> +	return ret;
> +}
> +
> +static int usb5744_platform_probe(struct platform_device *pdev)
> +{
> +	/* Trigger gpio reset to the hub. */
> +	return usb5744_init_hw(&pdev->dev);
> +}
> +
> +static const struct i2c_device_id usb5744_id[] = {
> +	{ "usb5744", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, usb5744_id);
> +
> +static struct i2c_driver usb5744_i2c_driver = {
> +	.driver = {
> +		.name = "usb5744",
> +	},
> +	.probe = usb5744_i2c_probe,
> +	.id_table = usb5744_id,
> +};
> +
> +static const struct of_device_id usb5744_platform_id[] = {
> +	{ .compatible = "microchip,usb5744", },
> +	{ }
> +};
> +
> +static struct platform_driver usb5744_platform_driver = {
> +	.driver = {
> +		.name = "microchip,usb5744",
> +		.of_match_table = usb5744_platform_id,
> +	},
> +	.probe = usb5744_platform_probe,
> +};
> +
> +static int __init usb5744_init(void)
> +{
> +	int err;
> +
> +	err = i2c_add_driver(&usb5744_i2c_driver);
> +	if (err != 0)
> +		pr_err("usb5744: Failed to register I2C driver: %d\n", err);
> +
> +	err = platform_driver_register(&usb5744_platform_driver);
> +	if (err != 0)
> +		pr_err("usb5744: Failed to register platform driver: %d\n",
> +		       err);
> +	return 0;

So, no matter how many failures happen, you still say everything is good
and continue on with loading the module?

Please don't.

thanks,

greg k-h
