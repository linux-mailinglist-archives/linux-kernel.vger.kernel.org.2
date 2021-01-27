Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9779306235
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbhA0RiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbhA0Rdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:33:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA9C061573;
        Wed, 27 Jan 2021 09:32:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id h6so3000222oie.5;
        Wed, 27 Jan 2021 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oz+/hcKZxIpJaMX8a8BFQY8IQewFeLmT4ZAvAqwd6ig=;
        b=JmpUz8b2+/eGPi0g9usur5TmcWm0dZc0TErnAYt8LqUzfz2rdfoXfoOcNnKhkzUCBp
         t4P2eZ27n70cM/obBZGVv2jQkjuIr4dzAvBsSaAm8+mid5lMGiyjlxQgjOxmYYf7pu1i
         +5zDdG+RJajYyUZ7ReeRNlASuyZtdrTR1chtHTvuT+yQyuHQlTWZ6qAQeorAYeGYm89Z
         F6TO3gb2qRXnVykxBPgxJpD/EnkVn2dTOOoMJkmtq5fctgr+rqcP6YjVQovVpXX+uT7z
         liMJJQlna4jRWP3ZqyP8O8JkHnI9cdy1AmvVXttNqI891R19mEBtoaqRZ+dsjs1hUoU5
         wvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oz+/hcKZxIpJaMX8a8BFQY8IQewFeLmT4ZAvAqwd6ig=;
        b=s4mUFUJM6t5BQdQNME2twNvjNjE8YeHHBs7FDtMK+soLqVgXSRgkfUWtx5t9QLCRAr
         jQeP15ofAwJH068cqyGXZxb1NLJCfJ9Jx5eZdoSLZJqciYhb1MNYhlWDdsknco2pBkpU
         rFxBu9OFq4RG4T2pfUClGMogSGGqq7ZkjZlMzDwXm6fLZcWGNBLZEptc71I9c2fP+FvD
         W1bLw2WPLf/2XugSwWy4i8uSJ/9QW5HTEJI4wdHU76oYM4Dy6xXNiDsCz/gV7biCxu4i
         hQEuz/OOYk4bQXjHyw2+TTq4p+ypO3sQa5U69vxjXYzYptD7V3aTQUa+jkIP+x3v7Yih
         AVwA==
X-Gm-Message-State: AOAM531Ob+XSS+91uczO4ymS2bda2FgFeD+6FPBhEAe43Vy79COQkHLR
        NcCkyw0Hm0PrQgnF/WPesNv3VEZkyfA=
X-Google-Smtp-Source: ABdhPJwk3OyNzwKzu/MJGzCTXZ3ZrCm+jSiq9RlZLcdCy05OzhJwaKUkxHMjjDPglSnsEDitiFliZw==
X-Received: by 2002:aca:b755:: with SMTP id h82mr3789287oif.5.1611768777878;
        Wed, 27 Jan 2021 09:32:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6sm477510ote.28.2021.01.27.09.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jan 2021 09:32:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Jan 2021 09:32:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/1] Add ST STPDDC60 pmbus driver
Message-ID: <20210127173255.GA144627@roeck-us.net>
References: <20210127084140.35626-1-erik.rosen@metormote.com>
 <20210127084140.35626-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127084140.35626-2-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:41:40AM +0100, Erik Rosen wrote:
> Add ST STPDDC60 pmbus client driver.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  Documentation/hwmon/index.rst    |   1 +
>  Documentation/hwmon/stpddc60.rst |  79 +++++++++++++
>  MAINTAINERS                      |   7 ++
>  drivers/hwmon/pmbus/Kconfig      |  10 ++
>  drivers/hwmon/pmbus/Makefile     |   2 +
>  drivers/hwmon/pmbus/stpddc60.c   | 188 +++++++++++++++++++++++++++++++
>  6 files changed, 287 insertions(+)
>  create mode 100644 Documentation/hwmon/stpddc60.rst
>  create mode 100644 drivers/hwmon/pmbus/stpddc60.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fcb870ce6286..94b4fcf182cd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -169,6 +169,7 @@ Hardware Monitoring Kernel Drivers
>     smsc47m192
>     smsc47m1
>     sparx5-temp
> +   stpddc60
>     tc654
>     tc74
>     thmc50
> diff --git a/Documentation/hwmon/stpddc60.rst b/Documentation/hwmon/stpddc60.rst
> new file mode 100644
> index 000000000000..11d5a9977e80
> --- /dev/null
> +++ b/Documentation/hwmon/stpddc60.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver stpddc60
> +======================
> +
> +Supported chips:
> +
> +  * ST STPDDC60
> +
> +    Prefix: 'stpddc60', 'bmr481'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/documents/fpm-techspec-bmr481
> +
> +Author: Erik Rosen <erik.rosen@metormote.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for ST STPDDC60 controller chip and
> +compatible modules.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
> +on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +The vout under- and over-voltage limits are read-only for this chip.
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Vin, iout and temp limits
> +are read-write; all other attributes are read-only.
> +
> +======================= ========================================================
> +in1_label		"vin"
> +in1_input		Measured input voltage.
> +in1_lcrit		Critical minimum input voltage.
> +in1_crit		Critical maximum input voltage.
> +in1_lcrit_alarm		Input voltage critical low alarm.
> +in1_crit_alarm		Input voltage critical high alarm.
> +
> +in2_label		"vout1"
> +in2_input		Measured output voltage.
> +in2_lcrit		Critical minimum output Voltage.
> +in2_crit		Critical maximum output voltage.
> +in2_lcrit_alarm		Critical output voltage critical low alarm.
> +in2_crit_alarm		Critical output voltage critical high alarm.
> +
> +curr1_label		"iout1"
> +curr1_input		Measured output current.
> +curr1_max		Maximum output current.
> +curr1_max_alarm		Output current high alarm.
> +curr1_crit		Critical maximum output current.
> +curr1_crit_alarm	Output current critical high alarm.
> +
> +temp1_input		Measured maximum temperature of all phases.
> +temp1_max		Maximum temperature limit.
> +temp1_max_alarm		High temperature alarm.
> +temp1_crit		Critical maximum temperature limit.
> +temp1_crit_alarm	Critical maximum temperature alarm.
> +======================= ========================================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992fe3b0900a..e4c696f8eabe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16819,6 +16819,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/busses/i2c-stm32*
>  
> +ST STPDDC60 DRIVER
> +M:	Daniel Nilsson <daniel.nilsson@flex.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/stpddc60.rst
> +F:	drivers/hwmon/pmbus/stpddc60.c
> +
>  ST VL53L0X ToF RANGER(I2C) IIO DRIVER
>  M:	Song Qiang <songqiang1304521@gmail.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 03606d4298a4..b2becdd84b11 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -247,6 +247,16 @@ config SENSORS_Q54SJ108A2
>  	  This driver can also be built as a module. If so, the module will
>  	  be called q54sj108a2.
>  
> +config SENSORS_STPDDC60
> +	tristate "ST STPDDC60"
> +	help
> +	  If you say yes here you get hardware monitoring support for ST
> +	  STPDDC60 Universal Digital Multicell Controller, as well as for
> +	  Flex BMR481.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called stpddc60.
> +
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..ef468806238c 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -28,9 +28,11 @@ obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
> +obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>  obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>  obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> +
> diff --git a/drivers/hwmon/pmbus/stpddc60.c b/drivers/hwmon/pmbus/stpddc60.c
> new file mode 100644
> index 000000000000..4e3ab260a3c2
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/stpddc60.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for the STPDDC60 controller
> + *
> + * Copyright (c) 2021 Flextronics International Sweden AB.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +enum chips { stpddc60 };

Seems pointless since it is not used.

> +
> +static const struct i2c_device_id stpddc60_id[] = {
> +	{"stpddc60", stpddc60},
> +	{"bmr481", stpddc60},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, stpddc60_id);
> +
> +static struct pmbus_driver_info stpddc60_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +		| PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +		| PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +		| PMBUS_HAVE_POUT,
> +};
> +
> +/*
> + * Convert VID value to milli-volt
> + */
> +static long stpddc60_vid2mv(int val)
> +{
> +	long rv = 0;
> +
> +	if (val >= 0x01)
> +		rv = 250 + (val - 1) * 5;
> +
> +	return rv;
> +}
> +
> +/*
> + * Convert milli-volt to linear
> + */
> +static int stpddc60_mv2l(long mv)
> +{
> +	int rv;
> +
> +	rv = (mv << 8) / 1000;

DIV_ROUND_CLOSEST(), maybe ?

> +
> +	return rv;
> +}

Pleae combine those two functions into one to directly convert VID to
linear format. Having two functions is confusing and adds unnecessary
complexity.

> +
> +/*
> + * The VOUT_COMMAND register uses the VID format but the vout alarm limit
> + * registers use the linear format so we override VOUT_MODE here to force
> + * linear format for all registers.
> + */
> +static int stpddc60_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		ret = 0x18;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Do the necessary conversions between VID and linear data format.
> + */
> +static int stpddc60_read_word_data(struct i2c_client *client, int page,
> +				   int phase, int reg)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +		ret = stpddc60_mv2l(stpddc60_vid2mv(ret));

It might possibly be simpler to just return the value reported
by MFR_READ_VOUT. 

> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +		ret &= 0x07ff;

This needs explanation. The BMR481 datasheet does not suggest that only
11 bits are valid.

> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * The vout under- and over-voltage limits are readonly for this chip.
> + */

Not really. The BMR481 datasheet suggests that the value can be changed
by writing to MFR_OV_LIMIT_OFFSET and MFR_UV_LIMIT_OFFSET.
I am not saying that you should implement that if you don't want to,
but I would suggest a better (more accurate) explanation.

> +static int stpddc60_write_word_data(struct i2c_client *client, int page,
> +				    int reg, u16 word)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		ret = -EACCES;
> +		break;
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = -EACCES;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int stpddc60_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	int status;
> +	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
> +	const struct i2c_device_id *mid;
> +	struct pmbus_driver_info *info = &stpddc60_info;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	status = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, device_id);
> +	if (status < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
> +		return status;
> +	}
> +	for (mid = stpddc60_id; mid->name[0]; mid++) {
> +		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
> +			break;
> +	}
> +	if (!mid->name[0]) {
> +		dev_err(&client->dev, "Unsupported device\n");
> +		return -ENODEV;
> +	}
> +
> +	info->read_byte_data = stpddc60_read_byte_data;
> +	info->read_word_data = stpddc60_read_word_data;
> +	info->write_word_data = stpddc60_write_word_data;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static struct i2c_driver stpddc60_driver = {
> +	.driver = {
> +		   .name = "stpddc60",
> +		   },
> +	.probe = stpddc60_probe,

Please use the probe_new function callback (no id parameter).

> +	.id_table = stpddc60_id,
> +};
> +
> +module_i2c_driver(stpddc60_driver);
> +
> +MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
> +MODULE_DESCRIPTION("PMBus driver for ST STPDDC60");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
> 
