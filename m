Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7165734FC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhCaJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234690AbhCaJXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C781619AB;
        Wed, 31 Mar 2021 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617182594;
        bh=JKpmHm2uNtJ5ggICISNdatwBvKC1xPxxp1z1I+SSq3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgxNnOQ02rQebCKSu5lcLjtI4SsehRnhDif6KSjZgR8aAKIF7ToA3lwRmlVleaJBK
         zelF3ypfPOPsBcXgqo0wKrvrwanzXIP30f+w3iT/eGmsvKj7f5zJQIjAaL0YTqUzT1
         4mvuJD/OVInGwWIGk1C6ypgY4JZR29R6uKsApzDJfL4JUkW9blO84kKVANwFk6gxJ1
         YuUzbRmk54CQT0MS0gDNlTA1XRKdMIgZTHWbkCxA8w3dwsGbZcPO0AuSTwPfuZJ2H7
         /boYscndkF3leQmOzuJ1ra6SU94EkEmVoI0g2ZzXB7+HsrkfjkPLWCQwf1EIHbT3ug
         l+zjyGmJc/NNg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRX4a-0004qP-3y; Wed, 31 Mar 2021 11:23:36 +0200
Date:   Wed, 31 Mar 2021 11:23:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <photranvan0712@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v5] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs of CP2108
Message-ID: <YGQ/mOV/8Qv+OYRG@hovoldconsulting.com>
References: <20210315105626.2510-1-photranvan0712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315105626.2510-1-photranvan0712@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 05:56:26PM +0700, Pho Tran wrote:
> From: Pho Tran <pho.tran@silabs.com>
> 
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
> supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared
> to all of those interfaces. So, just need to initialize GPIOs of CP2108
> with only one interface (I use interface 0). It means just only 1 gpiochip
> device file will be created for CP2108.

Yeah, that seems like the right approach here even if the pins are
grouped so that their alternate functions are related to one of the
four ports.

> CP2108 has 16 GPIOs, So data types of several variables need to be is u16
> instead of u8(in struct cp210x_serial_private). This doesn't affect other
> CP210x devices.
> 
> Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions
> will be different from other CP210x devices. So need to check part number
> of the device to use correct data format  before sending commands to
> devices.
> 
> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore,
> should be mask all pins which are not in GPIO mode in cp2108_gpio_init()
> function.

This generally looks good, but it seems you should be able to reuse more
of the existing code and reduce the amount of conditionals a bit.

Also try to shorten the commit summary (Subject) by trimming redundant
information (e.g. you mention cp210x twice and no need to say that's a
driver). Use something like:

	USB: serial: cp210x: add support for GPIOs on CP2108

> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> ---
> 
> 03/12/2022: Patch v4 used git send-mail instead of send patch by manual
> follow the instructions of Johan Hovold <johan@kernel.org>.
> 03/05/2021: Patch v3 modified format and contents of changelog follow feedback
> from Johan Hovold <johan@kernel.org>.
> 03/04/2021: Patch v2 modified format patch as comment from
> Johan Hovold <johan@kernel.org>:
> 	1. Break commit message lines at 80 cols
> 	2. Use kernel u8 and u16 instead of the c99 ones.
> 03/01/2021: Initialed submission of patch "Make the CP210x driver work with
> GPIOs of CP2108.".
> 
>  drivers/usb/serial/cp210x.c | 199 +++++++++++++++++++++++++++++++-----
>  1 file changed, 172 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 7bec1e730b20..0e92e41bacc5 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -245,9 +245,9 @@ struct cp210x_serial_private {
>  #ifdef CONFIG_GPIOLIB
>  	struct gpio_chip	gc;
>  	bool			gpio_registered;
> -	u8			gpio_pushpull;
> -	u8			gpio_altfunc;
> -	u8			gpio_input;
> +	u16			gpio_pushpull;
> +	u16			gpio_altfunc;
> +	u16			gpio_input;
>  #endif
>  	u8			partnum;
>  	speed_t			min_speed;
> @@ -500,6 +500,25 @@ struct cp210x_single_port_config {
>  	u8	device_cfg;
>  } __packed;
>  
> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
> + * on a CP2108 chip. Structure needs padding due to unused/unspecified bytes.

Which padding are you referring to here?

> + */
> +struct cp210x_quad_port_state {
> +	__le16 Mode_PB[5];
> +	__le16 LowPower_PB[5];
> +	__le16 Latch_PB[5];
> +} __packed;
> +
> +struct cp210x_quad_port_config {
> +	struct cp210x_quad_port_state reset_state;
> +	struct cp210x_quad_port_state suspend_state;
> +	u8 IPDelay_IFC[4];
> +	u8 EnhancedFxn_IFC[4];
> +	u8 EnhancedFxn_Device;
> +	u8 ExtClkFreq[4];
> +} __packed;

Do you a reference to the documentation for these structures?

And are the names taken directly from there? Avoid using CamelCase
unless that's what's used in the public documentation for these structs.

> +
>  /* GPIO modes */
>  #define CP210X_SCI_GPIO_MODE_OFFSET	9
>  #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
> @@ -510,6 +529,27 @@ struct cp210x_single_port_config {
>  #define CP210X_GPIO_MODE_OFFSET		8
>  #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
>  
> +#define CP2108_GPIO_MODE_OFFSET		0
> +#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
> +
> +/* CP2108 port configuration values */
> +#define CP2108_GPIO0_ALTERNATE_FUNC		BIT(0)
> +#define CP2108_GPIO1_ALTERNATE_FUNC		BIT(1)
> +#define CP2108_GPIO2_ALTERNATE_FUNC		BIT(2)
> +#define CP2108_GPIO3_ALTERNATE_FUNC		BIT(3)
> +#define CP2108_GPIO4_ALTERNATE_FUNC		BIT(4)
> +#define CP2108_GPIO5_ALTERNATE_FUNC		BIT(5)
> +#define CP2108_GPIO6_ALTERNATE_FUNC		BIT(6)
> +#define CP2108_GPIO7_ALTERNATE_FUNC		BIT(7)
> +#define CP2108_GPIO8_ALTERNATE_FUNC		BIT(8)
> +#define CP2108_GPIO9_ALTERNATE_FUNC		BIT(9)
> +#define CP2108_GPIO10_ALTERNATE_FUNC	BIT(10)
> +#define CP2108_GPIO11_ALTERNATE_FUNC	BIT(11)
> +#define CP2108_GPIO12_ALTERNATE_FUNC	BIT(12)
> +#define CP2108_GPIO13_ALTERNATE_FUNC	BIT(13)
> +#define CP2108_GPIO14_ALTERNATE_FUNC	BIT(14)
> +#define CP2108_GPIO15_ALTERNATE_FUNC	BIT(15)

I think you can just drop these since they don't add any value (e.g. by
documenting the alternate function).

> +
>  /* CP2105 port configuration values */
>  #define CP2105_GPIO0_TXLED_MODE		BIT(0)
>  #define CP2105_GPIO1_RXLED_MODE		BIT(1)
> @@ -532,6 +572,12 @@ struct cp210x_gpio_write {
>  	u8	state;
>  };
>  
> +/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes on CP2108. */

Make sure you break your code and comments at 80 columns (unless not
doing so improves readability).

> +struct cp2108_gpio_write {
> +	u16	mask;
> +	u16	state;
> +} __packed;

No need for __packed.

> +
>  /*
>   * Helper to get interface number when we only have struct usb_serial.
>   */
> @@ -1298,50 +1344,73 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	u8 req_type = REQTYPE_DEVICE_TO_HOST;
>  	int result;
> -	u8 buf;
> -
> -	if (priv->partnum == CP210X_PARTNUM_CP2105)
> -		req_type = REQTYPE_INTERFACE_TO_HOST;
>  
> -	result = usb_autopm_get_interface(serial->interface);
> -	if (result)
> -		return result;

No need to reproduce this in every branch below; keep the shared bits
shared if you can.

> +	if (priv->partnum == CP210X_PARTNUM_CP2108) {
> +		u16 buf;
>  
> -	result = cp210x_read_vendor_block(serial, req_type,
> -					  CP210X_READ_LATCH, &buf, sizeof(buf));
> -	usb_autopm_put_interface(serial->interface);
> -	if (result < 0)
> -		return result;
> -
> -	return !!(buf & BIT(gpio));
> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +		result = usb_autopm_get_interface(serial->interface);
> +		if (result)
> +			return result;
> +		result = cp210x_read_vendor_block(serial, req_type,
> +						CP210X_READ_LATCH, &buf, sizeof(buf));

What is the endianess of the returned u16 mask here?

> +		usb_autopm_put_interface(serial->interface);
> +		if (result < 0)
> +			return result;
> +		return !!(buf & BIT(gpio));

I think you should be able unify the handling of CP2108 and the other
types, for example, by extending buf to u16 and taking care about
endianess when only reading 1 byte into buf.

Try and see what increases the amount of shared code without becoming to
contrived.

> +	} else {
> +		u8 buf;
> +
> +		if (priv->partnum == CP210X_PARTNUM_CP2105)
> +			req_type = REQTYPE_INTERFACE_TO_HOST;
> +		result = usb_autopm_get_interface(serial->interface);
> +		if (result)
> +			return result;
> +		result = cp210x_read_vendor_block(serial, req_type,
> +						CP210X_READ_LATCH, &buf, sizeof(buf));
> +		usb_autopm_put_interface(serial->interface);
> +		if (result < 0)
> +			return result;
> +		return !!(buf & BIT(gpio));
> +	}
>  }
>  
>  static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> -	struct cp210x_gpio_write buf;
> +	struct cp210x_gpio_write u8_buf;
> +	struct cp2108_gpio_write u16_buf;

Same here. Try adding two u16 variables for state and mask, and then
update these structures in each branch below instead, for example.

>  	int result;
>  
>  	if (value == 1)
> -		buf.state = BIT(gpio);
> +		u8_buf.state = BIT(gpio);
>  	else
> -		buf.state = 0;
> +		u8_buf.state = 0;
>  
> -	buf.mask = BIT(gpio);
> +	u8_buf.mask = BIT(gpio);
>  
>  	result = usb_autopm_get_interface(serial->interface);
>  	if (result)
>  		goto out;
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +	if (priv->partnum == CP210X_PARTNUM_CP2105)
>  		result = cp210x_write_vendor_block(serial,
>  						   REQTYPE_HOST_TO_INTERFACE,
> -						   CP210X_WRITE_LATCH, &buf,
> -						   sizeof(buf));
> +						   CP210X_WRITE_LATCH, &u8_buf,
> +						   sizeof(u8_buf));
> +	else if (priv->partnum == CP210X_PARTNUM_CP2108) {
> +		if (value == 1)
> +			u16_buf.state = cpu_to_le16(BIT(gpio));
> +		else
> +			u16_buf.state = 0;
> +		u16_buf.mask = cpu_to_le16(BIT(gpio));
> +		result = cp210x_write_vendor_block(serial,
> +						   REQTYPE_HOST_TO_INTERFACE,
> +						   CP210X_WRITE_LATCH, &u16_buf,
> +						   sizeof(u16_buf));
>  	} else {
> -		u16 wIndex = buf.state << 8 | buf.mask;
> -
> +		u16 wIndex = u8_buf.state << 8 | u8_buf.mask;
>  		result = usb_control_msg(serial->dev,
>  					 usb_sndctrlpipe(serial->dev, 0),
>  					 CP210X_VENDOR_SPECIFIC,
> @@ -1350,7 +1419,6 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  					 wIndex,
>  					 NULL, 0, USB_CTRL_SET_TIMEOUT);
>  	}
> -

Unrelated white space change.

>  	usb_autopm_put_interface(serial->interface);
>  out:
>  	if (result < 0) {
> @@ -1420,6 +1488,75 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
>  	return -ENOTSUPP;
>  }
>  
> +static int cp2108_gpio_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	struct cp210x_quad_port_config config;
> +	u16 iface_config;
> +	u16 gpio_latch;
> +	int result;
> +	u16 i;

Nit: i can be u8 as above, or just int.

> +
> +	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_GET_PORTCONFIG, &config,
> +					  sizeof(config));
> +	if (result < 0) {
> +		dev_warn(&serial->interface->dev,
> +			 "querying port config on cp2108 failed\n");

We already print an error if gpio initialisation fails, so I think you
can drop this warning.

> +		return result;
> +	}
> +	priv->gc.ngpio = 16;
> +	iface_config = config.EnhancedFxn_IFC[0];

This looks broken; EnhancedFxn_IFC is u8, so you cannot use it this way
to determine alternate functions of the upper 8 pins below.

> +	priv->gpio_pushpull = (u16)((le16_to_cpu(config.reset_state.Mode_PB[1]) &
> +								CP2108_GPIO_MODE_MASK) >>
> +								CP2108_GPIO_MODE_OFFSET);

No need for the u16 cast, and try adding a temporary variable (e.g. for
mode_pb in cpu endianess) to reduce the line length.

> +	gpio_latch = (u16)((le16_to_cpu(config.reset_state.Latch_PB[1]) &
> +						CP2108_GPIO_MODE_MASK) >>
> +						CP2108_GPIO_MODE_OFFSET);

Same here.

> +
> +	/* mark all pins which are not in GPIO mode */
> +	if (iface_config & CP2108_GPIO0_ALTERNATE_FUNC)		/* GPIO 0 */
> +		priv->gpio_altfunc |= BIT(0);
> +	if (iface_config & CP2108_GPIO1_ALTERNATE_FUNC)		/* GPIO 1 */
> +		priv->gpio_altfunc |= BIT(1);
> +	if (iface_config & CP2108_GPIO2_ALTERNATE_FUNC)		/* GPIO 2 */
> +		priv->gpio_altfunc |= BIT(2);
> +	if (iface_config & CP2108_GPIO3_ALTERNATE_FUNC)		/* GPIO 3 */
> +		priv->gpio_altfunc |= BIT(3);
> +	if (iface_config & CP2108_GPIO4_ALTERNATE_FUNC)		/* GPIO 4 */
> +		priv->gpio_altfunc |= BIT(4);
> +	if (iface_config & CP2108_GPIO5_ALTERNATE_FUNC)		/* GPIO 5 */
> +		priv->gpio_altfunc |= BIT(5);
> +	if (iface_config & CP2108_GPIO6_ALTERNATE_FUNC)		/* GPIO 6 */
> +		priv->gpio_altfunc |= BIT(6);
> +	if (iface_config & CP2108_GPIO7_ALTERNATE_FUNC)		/* GPIO 7 */
> +		priv->gpio_altfunc |= BIT(7);
> +	if (iface_config & CP2108_GPIO8_ALTERNATE_FUNC)		/* GPIO 8 */
> +		priv->gpio_altfunc |= BIT(8);
> +	if (iface_config & CP2108_GPIO9_ALTERNATE_FUNC)		/* GPIO 9 */
> +		priv->gpio_altfunc |= BIT(9);
> +	if (iface_config & CP2108_GPIO10_ALTERNATE_FUNC)	/* GPIO 10 */
> +		priv->gpio_altfunc |= BIT(10);
> +	if (iface_config & CP2108_GPIO11_ALTERNATE_FUNC)	/* GPIO 11 */
> +		priv->gpio_altfunc |= BIT(11);
> +	if (iface_config & CP2108_GPIO12_ALTERNATE_FUNC)	/* GPIO 12 */
> +		priv->gpio_altfunc |= BIT(12);
> +	if (iface_config & CP2108_GPIO13_ALTERNATE_FUNC)	/* GPIO 13 */
> +		priv->gpio_altfunc |= BIT(13);
> +	if (iface_config & CP2108_GPIO14_ALTERNATE_FUNC)	/* GPIO 14 */
> +		priv->gpio_altfunc |= BIT(14);
> +	if (iface_config & CP2108_GPIO15_ALTERNATE_FUNC)	/* GPIO 15 */
> +		priv->gpio_altfunc |= BIT(15);

As mentioned above, this doesn't add anything, so just update
gpio_altfunc from iface_config directly after making sure you handle
endianess correctly.

> +
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		/* Set direction to "input" if pin is open-drain and reset value is 1 */

Line over 80 columns again; use the same formatting as in the other init
functions.

> +		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
> +			priv->gpio_input |= BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * This function is for configuring GPIO using shared pins, where other signals
>   * are made unavailable by configuring the use of GPIO. This is believed to be
> @@ -1649,6 +1786,14 @@ static int cp210x_gpio_init(struct usb_serial *serial)
>  	case CP210X_PARTNUM_CP2102N_QFN20:
>  		result = cp2102n_gpioconf_init(serial);
>  		break;
> +	case CP210X_PARTNUM_CP2108:
> +		/*
> +		 * CP2108 has 4 interfaces, but GPIOs at 4 interfaces are the same and shared.
> +		 * So just need init GPIO chip for 1 interface.
> +		 */

Above 80 columns again, and I think you can shorten the comment to
something like:

	/*
	 * The GPIOs are not tied to any specific port so only register
	 * once for interface 0.
	 */


> +		if (cp210x_interface_num(serial) == 0)
> +			result = cp2108_gpio_init(serial);

This is broken as you leave result undefined for interfaces other than
number zero. You need to return 0 explicitly here in that case:

	if (cp210x_interface_num(serial) != 0)
		return 0;

	result = cp2108_gpio_init(serial);

> +		break;
>  	default:
>  		return 0;
>  	}

Johan
