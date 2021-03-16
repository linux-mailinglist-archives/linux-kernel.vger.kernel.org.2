Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BB33CC41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhCPDoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhCPDnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:43:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCBC06174A;
        Mon, 15 Mar 2021 20:43:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p24so7959135ota.11;
        Mon, 15 Mar 2021 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=97yIwcqG91BuzkZQnrweNKa76iwWaVifqroWNybveps=;
        b=DSJXwrGEjShPdnAe6zWhp9jlcQtmpzYEofeZHrwWa2P56wVcB7ss/lm9iDhGlNZT3e
         p2M7iP1a+jwgVOpvTDUUQ5+IaVg3DYt1+j1s9IAeBzmYSzHA6iPTzvPqpXYexsygy5fH
         SO5i/gsUBsuAjLqudOU8/aajCBvMd/FAeFXNPb9ChMAD8Zy+uHU5UbLDvdeZXF1L9Y24
         bmtoOEfz9aIvuMA31ApH+/P8QR6M+QyBJj9lZk55YdgGZglBzk7GjX8gPjTIbWRjYn9f
         CnNwID+IZFmlRqa/6zolnyAmviUW74MfdAKmyS/YE4GHOmTThhpdXrj6J1xOYpkCT8xK
         3MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=97yIwcqG91BuzkZQnrweNKa76iwWaVifqroWNybveps=;
        b=k5lVj0E23ewLhSxBWP8vT8qnoPmu0g6xQw7I5wnzfbhcG/du9KRa/QJhIMEB6Af7qw
         wbcDjUQYdHuSI+4Ohhnea79vzbVnGFKIbixnjQGgeRspIygyfwb9gjYb5eyzFY31HvYB
         VqV8Wz8IvwPdrIYKh6sJoUaf1/rfVhjyjFy5AIpOSFeOrjmdWj8k4iqEB6bA+cHJC7AF
         vvxYNJ3oMH7qMwle+haeUAf31Is1BTlyeB+DlT2jDuv+HA92zthuri11DqxslP5h7Op6
         jhvDy/Y8d3MH/a2hP8UEKez5UOcqDxvT30fesTUWX+7uF3fZ6/ROlvxUmfMGifuRfy+s
         9g0w==
X-Gm-Message-State: AOAM530jTDoGFXYDo3IdiCLeZicXwHQLUcJlJ1tbXPKe0Rjk5b4X3YAX
        Zt32seU8qDDPT8U0HHKXxHXFGLG5meM=
X-Google-Smtp-Source: ABdhPJwuubK6JhYAtpH1+wn2FpHzPxTSybR5KWtQCWsmy1w1gLmkO2cBsY+/n9/U3nq7B9AAjoO97w==
X-Received: by 2002:a9d:19a3:: with SMTP id k32mr1829713otk.189.1615866230722;
        Mon, 15 Mar 2021 20:43:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13sm2754847otq.3.2021.03.15.20.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 20:43:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, jdelvare@suse.com
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
 <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <46a69700-ae1f-a441-2399-0e8c8e2a588d@roeck-us.net>
Date:   Mon, 15 Mar 2021 20:43:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 7:35 PM, Chris Packham wrote:
> The BPA-RS600 is a compact 600W AC to DC removable power supply module.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/hwmon/bpa-rs600.rst |  74 ++++++++++++
>  drivers/hwmon/pmbus/Kconfig       |  10 ++
>  drivers/hwmon/pmbus/Makefile      |   1 +
>  drivers/hwmon/pmbus/bpa-rs600.c   | 179 ++++++++++++++++++++++++++++++
>  4 files changed, 264 insertions(+)
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
> index 32d2fc850621..d1f0f1cd8247 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -56,6 +56,16 @@ config SENSORS_BEL_PFE
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
> +

Extra empty line

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
> index 000000000000..94cbf42816f0
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for BluTek BPA-RS600 Power Supplies
> + *
> + * Copyright 2021 Allied Telesis Labs
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"

alphabetic include file order please

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
> +static int bpa_rs600_read_byte_data(struct i2c_client *client, int page,
> +				    int reg)

100 column line length limit

> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_FAN_CONFIG_12:
> +		ret = pmbus_read_byte_data(client, 0,
> +					   PMBUS_FAN_CONFIG_12);
> +		if (ret >= 0)
> +			ret &= ~(PB_FAN_2_INSTALLED | PB_FAN_2_PULSE_MASK);

Please explain.

> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bpa_rs600_read_word_data(struct i2c_client *client, int page,
> +		int phase, int reg)

line length limit, and multi-line alignment

> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		ret = -ENXIO;

Is that needed ? Why not -ENODATA ?

> +		break;
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_VIN_MIN);
> +		break;
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_VIN_MAX);
> +		break;
> +	case PMBUS_VOUT_UV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_VOUT_MIN);
> +		break;
> +	case PMBUS_VOUT_OV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_VOUT_MAX);
> +		break;
> +	case PMBUS_IIN_OC_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_IIN_MAX);
> +		break;
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_IOUT_MAX);
> +		break;
> +	case PMBUS_PIN_OP_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_PIN_MAX);
> +		break;
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, 0, 0xff,
> +					   BPARS600_MFR_POUT_MAX);
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
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_WORD_DATA
> +				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +
extra empty line

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
> +	{ "bpa_rs600", 0 },

Hmm, no, this has an underscore. Guess you'll have to use the trick from
iio_hwmon.c or similar to generate a valid name.

Oh, wait, this is a pmbus driver, and the pmbus core uses client->name.
Maybe we need to add an optional strreplace() to the pmbus core.

Guenter

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

