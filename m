Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6508236FBBB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhD3NtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhD3NtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:49:02 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAC0C06138D;
        Fri, 30 Apr 2021 06:48:14 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so341956oot.6;
        Fri, 30 Apr 2021 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uc+Ut8vQsBYs+xAYXPAhP//pnlTY5r3vW60DBaUzYjg=;
        b=oKVxXiW9RZeR26sPxMK+R2nAj3GCqiLpJkF9m+UC5QEQCpG5QkdW38CIyIdl3fRVtm
         FS+VBdulKfTsPyRDl7dgf2ilCl91nKVRnLdRL9vhEIEo0nTJ4h26vZxYdZ0VkqVnMAeW
         J8qg/Y21UyUkbfXQ8CSU8KVwjm2NEOnhB34Mw2Hf19YwBiBC1ltQubgRNKGBhno6b797
         7oA3cAYdd5k38JneHYdaEzom7FR04tUozLqbi9XspFNAo0Uggx535k45wmG52b5T5zaM
         HLmzzo3GkQRnW9V5ZCDExsWh3khcpb2kOm+ua7PVrPvfKNA8iKdgwO/4WRdONOwoOyTq
         WhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uc+Ut8vQsBYs+xAYXPAhP//pnlTY5r3vW60DBaUzYjg=;
        b=ph+etkoad8T7Xc7DQYGtCJJqj3/Zm94zzRT5ktvOdJtcyq0GWdqsWILQuaLz4BjdGy
         bfOAjJsuxKpa+FYPW4rkpwD2vcfBAazoTprYdAhdJgHqq0stulBEUVQJaD6UJ9+l5ACM
         ozOFQA/0qX1w0Q+Lq4MFw/xHe4Irsw3nVYDgXTv9J/fpOrYmdYyi/8xhbWPQLVA9n8WM
         +ZrIng2PtmjI8OwQRiL13jgHNno2fNfU7xDMUGdOJGsWhbjQ8P5k9WLvOtd6dC5DHNKT
         WE1Pjn1k4/EmGB+j0tpqAyMtKzkw5Z8BCMDGAlAjKZIxsER9ZFxWA/AyiiOBd4Nyahnn
         cBdg==
X-Gm-Message-State: AOAM531WCUZwMvwdpIxFB/qQNf3qPWpKXxJ7uCAjtWOzDIj6cvKBKjdF
        cLvgjqsCKTXyqFD75m2TOC3C2SVbYnM=
X-Google-Smtp-Source: ABdhPJxLdLsZRePrWxCerD/70aWbR7cz7SIoNMoWDNi7vjWrhDaj4ON4GU08vB77hu9/lsSlGXODog==
X-Received: by 2002:a4a:1703:: with SMTP id 3mr2074038ooe.92.1619790493159;
        Fri, 30 Apr 2021 06:48:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm691483otw.58.2021.04.30.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:48:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 06:48:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <20210430134810.GA2714262@roeck-us.net>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430132735.127342-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:27:33PM +0200, Robert Marko wrote:
> This adds support for the Delta DPS-920AB PSU.
> 
> Only missing feature is fan control which the PSU supports.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/hwmon/dps920ab.rst | 80 ++++++++++++++++++++++++++++++++
>  Documentation/hwmon/index.rst    |  1 +
>  drivers/hwmon/pmbus/Kconfig      |  9 ++++
>  drivers/hwmon/pmbus/Makefile     |  1 +
>  drivers/hwmon/pmbus/dps920ab.c   | 63 +++++++++++++++++++++++++
>  5 files changed, 154 insertions(+)
>  create mode 100644 Documentation/hwmon/dps920ab.rst
>  create mode 100644 drivers/hwmon/pmbus/dps920ab.c
> 
> diff --git a/Documentation/hwmon/dps920ab.rst b/Documentation/hwmon/dps920ab.rst
> new file mode 100644
> index 000000000000..df0aef530c7e
> --- /dev/null
> +++ b/Documentation/hwmon/dps920ab.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver dps920ab
> +========================
> +
> +Supported chips:
> +
> +  * Delta DPS920AB
> +
> +    Prefix: 'dps920ab'
> +
> +    Addresses scanned: -
> +
> +Authors:
> +    Robert Marko <robert.marko@sartura.hr>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for Delta DPS920AB 920W 54V DC single output
> +power supply with PMBus support.
> +
> +The driver is a client driver to the core PMBus driver.
> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +
> +Sysfs entries
> +-------------
> +
> +======================= ======================================================
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_crit		Critical maximum current
> +curr1_crit_alarm	Current critical high alarm
> +
> +curr2_label		"iout1"
> +curr2_input		Measured output current
> +curr2_crit		Critical maximum current
> +curr2_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_lcrit		Critical minimum input voltage
> +in1_lcrit_alarm		Input voltage critical low alarm
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in2_label		"vout1"
> +in2_input		Measured output voltage
> +in2_lcrit		Critical minimum output voltage
> +in2_lcrit_alarm		Output voltage critical low alarm
> +in2_crit		Critical maximum output voltage
> +in2_crit_alarm		Output voltage critical high alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +
> +power2_label		"pout1"
> +power2_input		Measured output power
> +
> +temp[1-2]_input		Measured temperature
> +temp[1-2]_crit		Critical high temperature
> +temp[1-2]_crit_alarm	Chip temperature critical high alarm
> +temp[1-2]_max		Maximum temperature
> +temp[1-2]_max_alarm	Chip temperature high alarm
> +
> +fan1_alarm		Fan 1 warning.
> +fan1_fault		Fan 1 fault.
> +fan1_input		Fan 1 speed in RPM.
> +======================= ======================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8d5a2df1ecb6..b24436f22052 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -54,6 +54,7 @@ Hardware Monitoring Kernel Drivers
>     dell-smm-hwmon
>     dme1737
>     drivetemp
> +   dps920ab
>     ds1621
>     ds620
>     emc1403
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..865ade0aa205 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -66,6 +66,15 @@ config SENSORS_IBM_CFFPS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ibm-cffps.
>  
> +config SENSORS_DPS920AB
> +	tristate "Delta DPS920AB Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta
> +	  DPS920AB Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called dps920ab.
> +
>  config SENSORS_INSPUR_IPSPS
>  	tristate "INSPUR Power System Power Supply"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..f59ba0123d68 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> +obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>  obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
> new file mode 100644
> index 000000000000..d579ed9f879c
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/dps920ab.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta DPS920AB PSU
> + *
> + * Copyright (C) 2021 Delta Networks, Inc.
> + * Copyright (C) 2021 Sartura Ltd.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info dps920ab_info = {
> +	.pages = 1,
> +
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_FAN] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN  |
> +	PMBUS_HAVE_VOUT  | PMBUS_HAVE_STATUS_VOUT   |
> +	PMBUS_HAVE_IOUT  | PMBUS_HAVE_STATUS_IOUT   |
> +	PMBUS_HAVE_TEMP  | PMBUS_HAVE_TEMP2         |
> +	PMBUS_HAVE_PIN   | PMBUS_HAVE_POUT          |
> +	PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12  |
> +	PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int dps920ab_probe(struct i2c_client *client)
> +{
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;

This check is done in pmbus_do_probe(), and repeating it here does not add
any value.

That makes me wonder: Is this driver needed in the first place, or could
it be added to drivers/hwmon/pmbus/pmbus.c ?

Thanks,
Guenter

> +
> +	return pmbus_do_probe(client, &dps920ab_info);
> +}
> +
> +static const struct of_device_id __maybe_unused dps920ab_of_match[] = {
> +	{ .compatible = "delta,dps920ab", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, dps920ab_of_match);
> +
> +static struct i2c_driver dps920ab_driver = {
> +	.driver = {
> +		   .name = "dps920ab",
> +		   .of_match_table = of_match_ptr(dps920ab_of_match),
> +	},
> +	.probe_new = dps920ab_probe,
> +};
> +
> +module_i2c_driver(dps920ab_driver);
> +
> +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> +MODULE_DESCRIPTION("PMBus driver for Delta DPS920AB PSU");
> +MODULE_LICENSE("GPL");
> -- 
> 2.31.1
> 
