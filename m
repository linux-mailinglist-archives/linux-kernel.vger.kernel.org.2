Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C53A2CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFJN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhFJN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:28:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F333F613DE;
        Thu, 10 Jun 2021 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623331606;
        bh=HRWGM8U5uk1Jr5eXvzBS5bpaAGmP4Fjz6ld8w5qV1xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbBiWYMZud8RFl+cWKLQ81lctP+P7ys5BCJ8XSLPyAp5DP0I3g7oGBOivffECIGLm
         SLv/10za6gIiwYJRrtX9KA7Gd2yG4ogN+AJs8maqaENhWee62TJ0kdpx2r8dFdWAko
         /uWwQOuYCINTO5bdm0X/uxO0yhNri8xDC+m/fJM1gQlXABDMHAAN+e/cWTpgimydNO
         MC7nxe/NM4hDf7FjV2xZGd9+mtPiBpmP430powfeyqrQByIy/zaZtdnm0Thfuz1/9+
         Jzt+401/zNCmV90Sob685Inv/P/kIiaB99ykMTH9EAXT7pNiY95ZdixQdJcZ+71ZD2
         JF7xINpqpDW3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lrKhj-0006cQ-PO; Thu, 10 Jun 2021 15:26:39 +0200
Date:   Thu, 10 Jun 2021 15:26:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     tu pham <thanhtung1909@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YMITDyLtcPinbHMv@hovoldconsulting.com>
References: <20210426091244.19994-1-tupham@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426091244.19994-1-tupham@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:12:44PM +0700, tu pham wrote:
> From: Pho Tran <pho.tran@silabs.com>
> 
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
> supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared
> to all of those interfaces. So, just need to initialize GPIOs of CP2108
> with only one interface (I use interface 0). It means just only 1 gpiochip
> device file will be created for CP2108.
> 
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
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> Co-developed-by: Tung Pham <tung.pham@silabs.com>
> Signed-off-by: Tung Pham <tung.pham@silabs.com>
> ---
> 
> 04/26/2021: Patch v11 Add Signed-off-by Tung Pham
> 04/26/2021: Patch v10 Add Co-developed-by Tung Pham
> 04/23/2021: Patch v9 Modified code according to comment of Johan:
>         1. Remove quad-port-config comment.
>         2. Move defice EF_IFC_GPIOs go after the quad-port-config 
>         structure with the other port config defines, add CP2108_ prefix.
>         3. Drop CP2108 Quad Port State structure sentence comment;
>          clear from the code.
>         4. remove Double new line.
>         5. Use lowercase pb for consistency.
>         6. Avoid // comments. CP2108 (uppercase P).
>         7. remove Double new line.
>         8. Lowercase ifc.
>         9. Just keep the current struct as is and add a second one for 16 bits
>          (e.g. struct cp210x_gpio_write16).
>         10. don't need both u16 buf, but it may be cleaner to use u8 buf[2] 
>         for the transfer buffer.
>         11. Add missing indentation.
>         12. Try to be consistent with capitalisation of CP210x.
>         13. Just do the read after the switch into a common u8 buf[2] and 
>         use the full length only for CP2108.
>         14. Add leak the PM counter reference here.
>         15. Change buf = le16_to_cpu(wbuf); to le16_to_cpup((__le16 *)buf).
>         16. Keep the original struct as is cp210x_gpio_write.
>         17. Add another one for cp2108 with a suitable suffix.
>         18. No need to do open-parenthesis alignment; two tabs is enough.
>         19. Random whitespace changes.
>         20. Change check enhancedfxn_ifc.
>         21. Remove case EF_IFC_GPIO_RS485_LOGIC.
>         22. Remove case EF_IFC_DYNAMIC_SUSPEND.
>         23. Correct typo: only.
> 04/08/2021: Patch v8 Fixed build warning reported by kernel test robot
> with ARCH=i386
> 04/05/2021: Patch v7 Modified commit message follow Greg's comment.
> 04/05/2021: Patch v6 Fixed build warning reported by kernel test robot
> with ARCH=x86_64
> 03/15/2021: Patch v5 Modified code according to comment of Johan:
>         1. Unified the handling of CP2108 and other types and
>         take care about endianness.
>         2. Used suitable types data for variable.
>         3. Fixed cp2108_gpio_init and add more detail on
>         commit message and comment.
>         4. Dropped some of the ones that don't add any value.
>         5. Changed how the altfunctions were detected and fixed the gpio_init
>          error handling.
> 03/12/2021: Patch v4 used git send-mail instead of send patch by manual
> follow the instructions of Johan Hovold <johan@kernel.org>.
> 03/05/2021: Patch v3 modified format and contents of changelog follow feedback
> from Johan Hovold <johan@kernel.org>.
> 03/04/2021: Patch v2 modified format patch as comment from
> Johan Hovold <johan@kernel.org>:
>         1. Break commit message lines at 80 cols
>         2. Use kernel u8 and u16 instead of the c99 ones.
> 03/01/2021: Initialed submission of patch "Make the CP210x driver work with
> GPIOs of CP2108.".

Checkpatch now complains about five white-space issues.

Normally, I'd just ask you to fix up and resend, but I fear this will
take all summer to get into shape so I'll fix up the warnings and a
number of issues that I point out below *this* time.

I'm really quite annoyed to find that you have again ignored a number of
my comments on v9.

Next time, do some proper internal review before posting and make sure
you have addressed all review comments (by following the suggestions or
arguing why you will not).

>  drivers/usb/serial/cp210x.c | 211 +++++++++++++++++++++++++++++++-----
>  1 file changed, 182 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 7bec1e730b20..24cdf86ed23c 100644
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
> @@ -500,6 +500,50 @@ struct cp210x_single_port_config {
>  	u8	device_cfg;
>  } __packed;
>  
> +/*
> + * Quad Port Config definitions
> + * Refer to https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
> + * for more information.
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
> + * on a CP2108 chip.
> + */

At least the last part of this comment belongs above the config
structure itself.

> +struct cp210x_quad_port_state {
> +	__le16 gpio_mode_pb0;
> +	__le16 gpio_mode_pb1;
> +	__le16 gpio_mode_pb2;
> +	__le16 gpio_mode_pb3;
> +	__le16 gpio_mode_pb4;
> +
> +	__le16 gpio_lowpower_pb0;
> +	__le16 gpio_lowpower_pb1;
> +	__le16 gpio_lowpower_pb2;
> +	__le16 gpio_lowpower_pb3;
> +	__le16 gpio_lowpower_pb4;
> +
> +	__le16 gpio_latch_pb0;
> +	__le16 gpio_latch_pb1;
> +	__le16 gpio_latch_pb2;
> +	__le16 gpio_latch_pb3;
> +	__le16 gpio_latch_pb4;
> +};
> +
> +#define CP2108_EF_IFC_GPIO_TXLED		0x01
> +#define CP2108_EF_IFC_GPIO_RXLED		0x02
> +#define CP2108_EF_IFC_GPIO_RS485		0x04
> +#define CP2108_EF_IFC_GPIO_RS485_LOGIC 0x08
> +#define CP2108_EF_IFC_GPIO_CLOCK		0x10
> +#define CP2108_EF_IFC_DYNAMIC_SUSPEND	0x40

Why aren't all the values aligned?

> +
> +/* CP2108 Quad Port Config structure */
> +struct cp210x_quad_port_config {
> +	struct cp210x_quad_port_state reset_state;
> +	struct cp210x_quad_port_state suspend_state;
> +	u8 ipdelay_ifc[4];
> +	u8 enhancedfxn_ifc[4];
> +	u8 enhancedfxn_device;
> +	u8 extclkfreq[4];
> +} __packed;
> +
>  /* GPIO modes */
>  #define CP210X_SCI_GPIO_MODE_OFFSET	9
>  #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
> @@ -510,6 +554,9 @@ struct cp210x_single_port_config {
>  #define CP210X_GPIO_MODE_OFFSET		8
>  #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
>  
> +#define CP2108_GPIO_MODE_OFFSET		0
> +#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
> +
>  /* CP2105 port configuration values */
>  #define CP2105_GPIO0_TXLED_MODE		BIT(0)
>  #define CP2105_GPIO1_RXLED_MODE		BIT(1)
> @@ -526,7 +573,19 @@ struct cp210x_single_port_config {
>  #define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
>  #define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
>  
> -/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
> + * 0x04 bytes on CP2108.
> + */
> +struct cp210x_gpio_write16 {
> +	__le16	mask;
> +	__le16	state;
> +};
> +
> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these
> + * 0x02 bytes on CP2102N, Cp2103, Cp2104 and CP2105.

You're still using lower-case 'p' for some of the models above.

> + */
>  struct cp210x_gpio_write {
>  	u8	mask;
>  	u8	state;
> @@ -1298,22 +1357,39 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	u8 req_type = REQTYPE_DEVICE_TO_HOST;
>  	int result;
> -	u8 buf;
> -
> -	if (priv->partnum == CP210X_PARTNUM_CP2105)
> -		req_type = REQTYPE_INTERFACE_TO_HOST;
> +	u8 buf[2];
>  
>  	result = usb_autopm_get_interface(serial->interface);
>  	if (result)
>  		return result;
> +	/*
> +	 * This function will be read latch value of gpio and storage to buf(16bit)
> +	 * where bit 0 is GPIO0, bit 1 is GPIO1, etc. Up to GPIOn where n is
> +	 * total number of GPIO pins the interface supports.
> +	 * Interfaces on CP2102N supports 7 GPIOs
> +	 * Interfaces on CP2103 amd CP2104 supports 4 GPIOs
> +	 * Enhanced interfaces on CP2105 support 3 GPIOs
> +	 * Standard interfaces on CP2105 support 4 GPIOs
> +	 * Interfaces on CP2108 supports 16 GPIOs
> +	 */

Typo: "amd".

But as I mentioned earlier, I'm not sure it's worth adding this comment.
The code should be made obvious enough that it isn't needed.

> +	if ((priv->partnum == CP210X_PARTNUM_CP2108) || (priv->partnum == CP210X_PARTNUM_CP2105)) {
> +	/*
> +	 * Request type to Read_Latch of CP2105 and CP2108
> +	 * is 0xc1 <REQTYPE_INTERFACE_TO_HOST>
> +	 */

This comment is not indented correctly. It also not needed since what it
says is obvious from the code as I mentioned before.

> +		req_type = REQTYPE_INTERFACE_TO_HOST;
> +	}

The above should be a switch that also sets a length variable.

>  
>  	result = cp210x_read_vendor_block(serial, req_type,
> -					  CP210X_READ_LATCH, &buf, sizeof(buf));
> -	usb_autopm_put_interface(serial->interface);

Why are you changing the autopm call?

> -	if (result < 0)
> -		return result;
> +				CP210X_READ_LATCH, buf, 2);

And no need to read 2 bytes for any device types but CP2108 as I also
mentioned earlier. Does that even work?

>  
> -	return !!(buf & BIT(gpio));
> +	if (result < 0){

Missing space before {.

> +		usb_autopm_put_interface(serial->interface);
> +		return result;
> +	}
> +	result = le16_to_cpup((__le16 *)buf);
> +	usb_autopm_put_interface(serial->interface);
> +	return !!(result & BIT(gpio));
>  }

When cleaning up the above, I switched to reading into a u16 mask
directly instead, which makes the code a bit more readable still.

>  static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
> @@ -1321,37 +1397,51 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	struct cp210x_gpio_write buf;
> +	struct cp210x_gpio_write16 buf16;
> +	u16 wIndex;
>  	int result;
>  
> -	if (value == 1)
> +	if (value == 1) {
>  		buf.state = BIT(gpio);
> -	else
> +		buf16.state = cpu_to_le16(BIT(gpio));
> +	} else {
>  		buf.state = 0;
> -
> +		buf16.state = 0;
> +	}
>  	buf.mask = BIT(gpio);
> +	buf16.mask = cpu_to_le16(BIT(gpio));

Here I asked you to use two u16 variables for mask and state, which you
then use to set up the arguments below.
  
>  	result = usb_autopm_get_interface(serial->interface);
>  	if (result)
>  		goto out;
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +	switch (priv->partnum) {
> +	case CP210X_PARTNUM_CP2108:
>  		result = cp210x_write_vendor_block(serial,
> -						   REQTYPE_HOST_TO_INTERFACE,
> -						   CP210X_WRITE_LATCH, &buf,
> -						   sizeof(buf));
> -	} else {
> -		u16 wIndex = buf.state << 8 | buf.mask;
> -
> +						REQTYPE_HOST_TO_INTERFACE,
> +						CP210X_WRITE_LATCH, &buf16,
> +						sizeof(buf16));
> +		break;
> +	case CP210X_PARTNUM_CP2105:
> +		result = cp210x_write_vendor_block(serial,
> +						REQTYPE_HOST_TO_INTERFACE,
> +						CP210X_WRITE_LATCH, &buf,
> +						sizeof(buf));
> +		break;
> +	default:
> +		wIndex = buf.state << 8 | buf.mask;
>  		result = usb_control_msg(serial->dev,
> -					 usb_sndctrlpipe(serial->dev, 0),
> -					 CP210X_VENDOR_SPECIFIC,
> -					 REQTYPE_HOST_TO_DEVICE,
> -					 CP210X_WRITE_LATCH,
> -					 wIndex,
> -					 NULL, 0, USB_CTRL_SET_TIMEOUT);
> +						usb_sndctrlpipe(serial->dev, 0),
> +						CP210X_VENDOR_SPECIFIC,
> +						REQTYPE_HOST_TO_DEVICE,
> +						CP210X_WRITE_LATCH,
> +						wIndex,
> +						NULL, 0, USB_CTRL_SET_TIMEOUT);
> +		break;

No need to be shuffling all the existing code around.

>  	}
>  
>  	usb_autopm_put_interface(serial->interface);
> +

Random whitespace change.

>  out:
>  	if (result < 0) {
>  		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
> @@ -1420,6 +1510,60 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
>  	return -ENOTSUPP;
>  }
>  
> +static int cp2108_gpio_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	struct cp210x_quad_port_config config;
> +	u16 gpio_latch;
> +	u16 temp;
> +	int result;
> +	u8 i;
> +
> +	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_GET_PORTCONFIG, &config,
> +					  sizeof(config));
> +	if (result < 0)
> +		return result;
> +	priv->gc.ngpio = 16;
> +	temp = le16_to_cpu(config.reset_state.gpio_mode_pb1);
> +	priv->gpio_pushpull = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;
> +	temp = le16_to_cpu(config.reset_state.gpio_latch_pb1);
> +	gpio_latch = (temp & CP2108_GPIO_MODE_MASK) >> CP2108_GPIO_MODE_OFFSET;

As I mentioned earlier, the temporaries do not buy you anything since
the masks are 16 bits just like the structure fields, and the shifting
and masking is pointless.

I'll reply to this mail with an updated v13 addressing the above.

Johan
