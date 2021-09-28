Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBEC41B2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhI1Pae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:30:34 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:50280 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbhI1Pad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:30:33 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 11:30:33 EDT
Received: from fiber.protonic.nl (edge2.prtnl [192.168.1.170])
        by sparta.prtnl (Postfix) with ESMTP id 9DE7344A024E;
        Tue, 28 Sep 2021 17:20:26 +0200 (CEST)
MIME-Version: 1.0
Date:   Tue, 28 Sep 2021 17:20:26 +0200
From:   Robin van der Gracht <robin@protonic.nl>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: ht16k33: Make use of device properties
Reply-To: robin@protonic.nl
In-Reply-To: <20210914144232.511697-1-geert@linux-m68k.org>
References: <20210914144232.511697-1-geert@linux-m68k.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0501066e3c65efe2c8b1d06ea85d67b9@protonic.nl>
X-Sender: robin@protonic.nl
Organization: Protonic Holland
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

As part of this change let's rename matrix_keypad_parse_of_params() to
matrix_keypad_parse_properties() as well.

- Robin

On 2021-09-14 16:42, Geert Uytterhoeven wrote:
> The device property API allows drivers to gather device resources from
> different sources, such as ACPI, and lift the dependency on Device Tree.
> Convert the driver to unleash the power of the device property API.
> 
> Suggested-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only for the !OF case.
> 
> This depends on "[PATCH v6 00/19] auxdisplay: ht16k33: Add character display
> support"
> (https://lore.kernel.org/r/20210914143835.511051-1-geert@linux-m68k.org)
> 
>  drivers/auxdisplay/Kconfig   |  2 +-
>  drivers/auxdisplay/ht16k33.c | 25 +++++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index e32ef7f9945d49b2..64012cda4d126707 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -169,7 +169,7 @@ config IMG_ASCII_LCD
> 
>  config HT16K33
>  	tristate "Holtek Ht16K33 LED controller with keyscan"
> -	depends on FB && OF && I2C && INPUT
> +	depends on FB && I2C && INPUT
>  	select FB_SYS_FOPS
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index 89ee5b4b3dfccb68..e5b810e37e0337a6 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -12,7 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/fb.h>
>  #include <linux/slab.h>
>  #include <linux/backlight.h>
> @@ -481,15 +481,13 @@ static int ht16k33_led_probe(struct device *dev, 
> struct
> led_classdev *led,
>  			     unsigned int brightness)
>  {
>  	struct led_init_data init_data = {};
> -	struct device_node *node;
>  	int err;
> 
>  	/* The LED is optional */
> -	node = of_get_child_by_name(dev->of_node, "led");
> -	if (!node)
> +	init_data.fwnode = device_get_named_child_node(dev, "led");
> +	if (!init_data.fwnode)
>  		return 0;
> 
> -	init_data.fwnode = of_fwnode_handle(node);
>  	init_data.devicename = "auxdisplay";
>  	init_data.devname_mandatory = true;
> 
> @@ -510,7 +508,6 @@ static int ht16k33_keypad_probe(struct i2c_client 
> *client,
>  				struct ht16k33_keypad *keypad)
>  {
>  	struct device *dev = &client->dev;
> -	struct device_node *node = dev->of_node;
>  	u32 rows = HT16K33_MATRIX_KEYPAD_MAX_ROWS;
>  	u32 cols = HT16K33_MATRIX_KEYPAD_MAX_COLS;
>  	int err;
> @@ -529,11 +526,11 @@ static int ht16k33_keypad_probe(struct i2c_client 
> *client,
>  	keypad->dev->open = ht16k33_keypad_start;
>  	keypad->dev->close = ht16k33_keypad_stop;
> 
> -	if (!of_get_property(node, "linux,no-autorepeat", NULL))
> +	if (!device_property_present(dev, "linux,no-autorepeat"))
>  		__set_bit(EV_REP, keypad->dev->evbit);
> 
> -	err = of_property_read_u32(node, "debounce-delay-ms",
> -				   &keypad->debounce_ms);
> +	err = device_property_read_u32(dev, "debounce-delay-ms",
> +				       &keypad->debounce_ms);
>  	if (err) {
>  		dev_err(dev, "key debounce delay not specified\n");
>  		return err;
> @@ -620,8 +617,8 @@ static int ht16k33_fbdev_probe(struct device *dev, 
> struct
> ht16k33_priv *priv,
>  		goto err_fbdev_buffer;
>  	}
> 
> -	err = of_property_read_u32(dev->of_node, "refresh-rate-hz",
> -				   &fbdev->refresh_rate);
> +	err = device_property_read_u32(dev, "refresh-rate-hz",
> +				       &fbdev->refresh_rate);
>  	if (err) {
>  		dev_err(dev, "refresh rate not specified\n");
>  		goto err_fbdev_info;
> @@ -727,8 +724,8 @@ static int ht16k33_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
> 
> -	err = of_property_read_u32(dev->of_node, "default-brightness-level",
> -				   &dft_brightness);
> +	err = device_property_read_u32(dev, "default-brightness-level",
> +				       &dft_brightness);
>  	if (err) {
>  		dft_brightness = MAX_BRIGHTNESS;
>  	} else if (dft_brightness > MAX_BRIGHTNESS) {
> @@ -816,7 +813,7 @@ static struct i2c_driver ht16k33_driver = {
>  	.remove		= ht16k33_remove,
>  	.driver		= {
>  		.name		= DRIVER_NAME,
> -		.of_match_table	= of_match_ptr(ht16k33_of_match),
> +		.of_match_table	= ht16k33_of_match,
>  	},
>  	.id_table = ht16k33_i2c_match,
>  };
