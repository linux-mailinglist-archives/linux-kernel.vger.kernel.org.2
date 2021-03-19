Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE23427E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCSVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCSVb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:31:59 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C9C06175F;
        Fri, 19 Mar 2021 14:31:59 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so2650551ooq.8;
        Fri, 19 Mar 2021 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbwokAg1Y0JpITILeBwOOIJo/WV7PBaUARw4/x1pYIQ=;
        b=YLjumjeMbsQG6QuGIQl2H6yK7tVfpcSYfeirPJPLQM2jKkmBzSWr95aO6qKzK9MDfA
         g+50JFJq0USETaUM0uZfzswpU/u+rRgwOBYu4fha/ijVZCqWcZpFXw9G8YcEqLxLC48m
         E4Br0d7tPtIYO1twHZoN98f43POhuT7+Yt093jvEGHug4Sffav+50G5Fkadd0D4SGFvN
         Vep+eEoZUfoTOAuSh6ZoUUvsr8iUyX7joogc1g3vuGfDCloPPgQ+VpGhn7uzgVQrunhF
         5/5vHzNDW7urZkRJl60397pqMxqIaD2boqlOmuPehNiTScMeKMDJf1oE5J7O0v6heN0Z
         02jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbwokAg1Y0JpITILeBwOOIJo/WV7PBaUARw4/x1pYIQ=;
        b=NMr6NoUYnphpfbwo8QL1xEciP9aL70qKmrGEHRCM0OcWNfI5/ascN/oP6BWbHF6v7h
         YtSKJElYOdasJAwa6qtzpNhXEqqn0TqB2Kzo5etWdqVbMMcLJA4T5ASsdWnrXrt/2L8P
         qnxJT9SwFWhbfOM6yR+2g8K5mGq8IrusmHKt2iNED2JIqVQod+VhfKAEFA6HRZ2ULhqE
         ujsi2tV6ncpSH6Dp3aQ7eZ3bzh3uAf/Pv8Am1DGoRfzyexniBJHGhRq8UNO7F9lNoxji
         ErDPWo9cqnjHq+qQJcYn7hYtEnth7rV1txeOIeNXQHB+8SbmvTmKldXH1FTvvRHxmfUZ
         LKdw==
X-Gm-Message-State: AOAM533W/fzqQIUK/OAGGRipbd3PkOOT3hlKgYtsi3WdRFqHQAWB7BHf
        N7mY/jDBlBkoaiHQCE0VaPc9DDhYcfs=
X-Google-Smtp-Source: ABdhPJx6DCDr0B5DoEJjXEJrRBcADfFUFphlv2uchEhJzF4ffgKAU2aueuxxLPnJ5UtdGCWnA5bn3w==
X-Received: by 2002:a4a:e8d1:: with SMTP id h17mr2999477ooe.20.1616189518735;
        Fri, 19 Mar 2021 14:31:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f129sm1522644oia.9.2021.03.19.14.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Mar 2021 14:31:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Mar 2021 14:31:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Message-ID: <20210319213156.GA24420@roeck-us.net>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
 <20210317040231.21490-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:02:31PM +1300, Chris Packham wrote:
> The BPA-RS600 is a compact 600W AC to DC removable power supply module.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

For my reference (aiting for bindings approval):

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - Fix typo BPD -> BPA
>     - Allow for NUL terminator in buf
>     Changes in v2:
>     - Whitespace and line length cleanup
>     - Add comments about commands that return data but shouldn't be used
> 
>  Documentation/hwmon/bpa-rs600.rst |  74 +++++++++++++
>  drivers/hwmon/pmbus/Kconfig       |   9 ++
>  drivers/hwmon/pmbus/Makefile      |   1 +
>  drivers/hwmon/pmbus/bpa-rs600.c   | 172 ++++++++++++++++++++++++++++++
>  4 files changed, 256 insertions(+)
>  create mode 100644 Documentation/hwmon/bpa-rs600.rst
>  create mode 100644 drivers/hwmon/pmbus/bpa-rs600.c
> 
> diff --git a/Documentation/hwmon/bpa-rs600.rst b/Documentation/hwmon/bpa-rs600.rst
> new file mode 100644
> index 000000000000..28313995d4ae
> --- /dev/null
> +++ b/Documentation/hwmon/bpa-rs600.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver bpa-rs600
> +=======================
> +
> +Supported chips:
> +
> +  * BPA-RS600-120
> +
> +    Datasheet: Publicly available at the BluTek website
> +       http://blutekpower.com/wp-content/uploads/2019/01/BPA-RS600-120-07-19-2018.pdf
> +
> +Authors:
> +      - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +Description
> +-----------
> +
> +The BPA-RS600 is a compact 600W removable power supply module.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not probe for PMBus devices. You will have to instantiate
> +devices explicitly.
> +
> +Sysfs attributes
> +----------------
> +
> +======================= ============================================
> +curr1_label             "iin"
> +curr1_input		Measured input current
> +curr1_max		Maximum input current
> +curr1_max_alarm		Input current high alarm
> +
> +curr2_label		"iout1"
> +curr2_input		Measured output current
> +curr2_max		Maximum output current
> +curr2_max_alarm		Output current high alarm
> +
> +fan1_input		Measured fan speed
> +fan1_alarm		Fan warning
> +fan1_fault		Fan fault
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_max			Maximum input voltage
> +in1_max_alarm		Input voltage high alarm
> +in1_min			Minimum input voltage
> +in1_min_alarm		Input voltage low alarm
> +
> +in2_label		"vout1"
> +in2_input		Measured output voltage
> +in2_max			Maximum output voltage
> +in2_max_alarm		Output voltage high alarm
> +in2_min			Maximum output voltage
> +in2_min_alarm		Output voltage low alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power alarm
> +power1_max		Maximum input power
> +
> +power2_label		"pout1"
> +power2_input		Measured output power
> +power2_max		Maximum output power
> +power2_max_alarm	Output power high alarm
> +
> +temp1_input		Measured temperature around input connector
> +temp1_alarm		Temperature alarm
> +
> +temp2_input		Measured temperature around output connector
> +temp2_alarm		Temperature alarm
> +======================= ============================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..512d6f656dca 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -56,6 +56,15 @@ config SENSORS_BEL_PFE
>  	  This driver can also be built as a module. If so, the module will
>  	  be called bel-pfe.
>  
> +config SENSORS_BPA_RS600
> +	tristate "BluTek BPA-RS600 Power Supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for BluTek
> +	  BPA-RS600 Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called bpa-rs600.
> +
>  config SENSORS_IBM_CFFPS
>  	tristate "IBM Common Form Factor Power Supply"
>  	depends on LEDS_CLASS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..80a437060dc4 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>  obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> +obj-$(CONFIG_SENSORS_BPA_RS600)	+= bpa-rs600.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> new file mode 100644
> index 000000000000..c4ede68b3e26
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for BluTek BPA-RS600 Power Supplies
> + *
> + * Copyright 2021 Allied Telesis Labs
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +#define BPARS600_MFR_VIN_MIN	0xa0
> +#define BPARS600_MFR_VIN_MAX	0xa1
> +#define BPARS600_MFR_IIN_MAX	0xa2
> +#define BPARS600_MFR_PIN_MAX	0xa3
> +#define BPARS600_MFR_VOUT_MIN	0xa4
> +#define BPARS600_MFR_VOUT_MAX	0xa5
> +#define BPARS600_MFR_IOUT_MAX	0xa6
> +#define BPARS600_MFR_POUT_MAX	0xa7
> +
> +static int bpa_rs600_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_FAN_CONFIG_12:
> +		/*
> +		 * Two fans are reported in PMBUS_FAN_CONFIG_12 but there is
> +		 * only one fan in the module. Mask out the FAN2 bits.
> +		 */
> +		ret = pmbus_read_byte_data(client, 0, PMBUS_FAN_CONFIG_12);
> +		if (ret >= 0)
> +			ret &= ~(PB_FAN_2_INSTALLED | PB_FAN_2_PULSE_MASK);
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MIN);
> +		break;
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MAX);
> +		break;
> +	case PMBUS_VOUT_UV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MIN);
> +		break;
> +	case PMBUS_VOUT_OV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MAX);
> +		break;
> +	case PMBUS_IIN_OC_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IIN_MAX);
> +		break;
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IOUT_MAX);
> +		break;
> +	case PMBUS_PIN_OP_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_PIN_MAX);
> +		break;
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_POUT_MAX);
> +		break;
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		/* These commands return data but it is invalid/un-documented */
> +		ret = -ENXIO;
> +		break;
> +	default:
> +		if (reg >= PMBUS_VIRT_BASE)
> +			ret = -ENXIO;
> +		else
> +			ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info bpa_rs600_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_FAN] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT |
> +		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +		PMBUS_HAVE_FAN12 |
> +		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_FAN12,
> +	.read_byte_data = bpa_rs600_read_byte_data,
> +	.read_word_data = bpa_rs600_read_word_data,
> +};
> +
> +static int bpa_rs600_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_WORD_DATA
> +				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read Manufacturer Model\n");
> +		return ret;
> +	}
> +
> +	if (strncmp(buf, "BPA-RS600", 8)) {
> +		buf[ret] = '\0';
> +		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	return pmbus_do_probe(client, &bpa_rs600_info);
> +}
> +
> +static const struct i2c_device_id bpa_rs600_id[] = {
> +	{ "bpars600", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
> +
> +static const struct of_device_id __maybe_unused bpa_rs600_of_match[] = {
> +	{ .compatible = "blutek,bpa-rs600" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bpa_rs600_of_match);
> +
> +static struct i2c_driver bpa_rs600_driver = {
> +	.driver = {
> +		.name = "bpa-rs600",
> +		.of_match_table = of_match_ptr(bpa_rs600_of_match),
> +	},
> +	.probe_new = bpa_rs600_probe,
> +	.id_table = bpa_rs600_id,
> +};
> +
> +module_i2c_driver(bpa_rs600_driver);
> +
> +MODULE_AUTHOR("Chris Packham");
> +MODULE_DESCRIPTION("PMBus driver for BluTek BPA-RS600");
> +MODULE_LICENSE("GPL");
