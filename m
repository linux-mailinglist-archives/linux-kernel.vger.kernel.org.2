Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A433E67D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCQB67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCQB6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:58:24 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936DC06174A;
        Tue, 16 Mar 2021 18:58:12 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so185252oot.7;
        Tue, 16 Mar 2021 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QexooDNTvorrGc/CXURATAyzMmjsR35GYeoj+xZO6gw=;
        b=gnKNiLQXzXxH5ojnQahBXLM8vIC5rFrD5U12JfFH0CfAwrcPJdxrHU78/GIJvEKvrp
         BHK214wMGPd73xjMrYISgIyV9BKuhPfAh0sDkTlCVRLdCAQr1WyYhVltAhYg/Hj+RMXm
         CMEgw3FYXMjXMCknoEREsGoypKtqLXGLzYJYF58OHZE58JCg0Y1VimNCX9T9Gy0JW5Wi
         BkKa+Fm9vBi078nYFjzjLEDubMzHheYWubEoPG7+pUvVj320ToHkxQC48uRbYRmlYwST
         fdeAt0y0KPMRO7wjVE7p/NSO9ovtiyZJnUeyFKLXh3xBY3MSuBuwewa35FIQOzP9nlz4
         Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QexooDNTvorrGc/CXURATAyzMmjsR35GYeoj+xZO6gw=;
        b=aYF+CJsgodXyAX7fHBgo1ZO9TYcrrIMiHIRQbm9/4AtbTvcUJ7wFogpmDA6MkN+/ru
         RDnH2WUMo6EzWjDo0FqXcnumQKGZqEGF1Avvi6P+UBKzfA+VPQpM1iHN2MDucO4FVnEV
         wNUKpzFMgef1L6unMu9E8NFr22GKAlfgzCj+lzp71JuwTzRBAz+UPUS+EJuohKXgqHpR
         M77+g7cbYn7y2SeoqRFuYDCjPVDb7Yunj7XPB3ScS7ApLDKRylQe6oSfkfCzSSJQvf3R
         JkLUXvZ7qYDwiCGAd415LXX19N04nsx72PoTxsiG7pyvTpMnc0fgepprpDw4J14/HTMo
         JrFg==
X-Gm-Message-State: AOAM533cwqS7EVgITn//aLXMipNr/nfms0BWrS6+tNK0pa5ciYG9PITC
        2RQN0Aff2FYywVA9lp1uZlvG7/kyQBg=
X-Google-Smtp-Source: ABdhPJyc8Sa7qo3XmeV0jjs5P/jP7X2WDpe4HYAhtT6ZWuNiJY708ZpMiHureo/6KXYpRtME5YpkUg==
X-Received: by 2002:a4a:dc51:: with SMTP id q17mr1375625oov.76.1615946291899;
        Tue, 16 Mar 2021 18:58:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm8025224oov.2.2021.03.16.18.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 18:58:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus): Add driver for BluTek BPA-RS600
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, jdelvare@suse.com
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210316203036.17674-1-chris.packham@alliedtelesis.co.nz>
 <20210316203036.17674-3-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4e3b2108-ac1e-5b15-5539-18c1bff1de19@roeck-us.net>
Date:   Tue, 16 Mar 2021 18:58:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316203036.17674-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 1:30 PM, Chris Packham wrote:
> The BPA-RS600 is a compact 600W AC to DC removable power supply module.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
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
> index 32d2fc850621..c9f08725d201 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -56,6 +56,15 @@ config SENSORS_BEL_PFE
>  	  This driver can also be built as a module. If so, the module will
>  	  be called bel-pfe.
>  
> +config SENSORS_BPA_RS600
> +	tristate "BluTek BPD-RS600 Power Supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for BluTek
> +	  BPD-RS600 Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called bpd-rs600.
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
> index 000000000000..bdfdef86bf1e
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
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];

I think that needs to be I2C_SMBUS_BLOCK_MAX + 1 to have space for the terminating '\0'.

Otherwise looks good.

Guenter

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
> 

