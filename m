Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E243CE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbhJ0P72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbhJ0P71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:59:27 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C47C061570;
        Wed, 27 Oct 2021 08:57:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id q39-20020a4a962a000000b002b8bb100791so1094778ooi.0;
        Wed, 27 Oct 2021 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4Tgjy0R9+NuNxN+5grAOonWTUZ22oVG3TDQLtPG8Rk=;
        b=iKyXn10KFwg2GYwC1hOqGQvowA9lCHwDrRlICOVtnRng2O/0+XvKupp/HijgXLYV9J
         jHDGqM7j8B2n4PM1f1mPd1aNHNMUUakd4nsdFHYOA9trriEyIQw299vYVZVx4BpqqY1d
         gFKlS8707uBuu9cVQK0LZrylxlo6SWAjD8ht67VppyomqTZgNd5m0iWso4m2/r0mrp4R
         UHqnl53UuL1kDujeY6jhG9rUI+sI/nAaw3dtxhZEd1YSoQ+kxPY1/9ERuozE5ApoXox0
         nPsbg5G6BoDIPe7l/8PHZ2KP8NJLc4WUT/YleFAtxWBN0Es2QKtQHJCScXTc4UZht3Pv
         /t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4Tgjy0R9+NuNxN+5grAOonWTUZ22oVG3TDQLtPG8Rk=;
        b=sYm6ySB+dUxfuDkAUZOCC1ol88xrg3fCsryqfg1JLx83Bp3HKT+494qjroIZU5hqxH
         A9E79kpauMXiKvDhkw+LmHUKGNlpl+eSZezv7jDjL2C8UzJKiKxQE7Nx9m28q0pqUefe
         Q1VcNgR8Ci9KmVo1jl7BCBe+vnrn8A1ZpDBHRBSot0O//gJxlovhhW8dBxGb2nI/XNPk
         yRstTILrre/fy/lSKRiSIDXu52Q8ZvlKKaV0m7NFZ3Q1cSQoi2o+6Jxvtitv7xMFNt2j
         z3Jh/UYbWxixWDWNKenvOUpAukNAg6m3b/zCPePmDeUVGa6xcJLl0is+ZZsqQH1EsXmo
         zHnQ==
X-Gm-Message-State: AOAM530WlotcPCbDDH84WrOa86foAQfUUgR3Lq3tS8pidHXVSchKCjC4
        Z8ubEzV+kfnTWdGASMojj78=
X-Google-Smtp-Source: ABdhPJwitxLyZ/P2RBEER17qb6REPeSKym0HQRgAia1Oo5kDf1VxfR/efJPle81IWyjoqi9ojzRBYw==
X-Received: by 2002:a4a:6412:: with SMTP id o18mr22805093ooc.79.1635350221125;
        Wed, 27 Oct 2021 08:57:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15sm102877oiy.8.2021.10.27.08.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:57:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Nathan Rossi <nathan@nathanrossi.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211027074212.690611-0-nathan@nathanrossi.com>
 <20211027074212.690611-3-nathan@nathanrossi.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/3] hwmon: Driver for Texas Instruments INA238
Message-ID: <1e38449d-f70f-1b66-e1a8-dca47fe2c1a3@roeck-us.net>
Date:   Wed, 27 Oct 2021 08:56:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027074212.690611-3-nathan@nathanrossi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 12:42 AM, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> The INA238 is a I2C power monitor similar to other INA2xx devices,
> providing shunt voltage, bus voltage, current, power and temperature
> measurements.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
> Changes in v2:
> - Add ina238 documentation to hwmon/index
> - Remove unused header includes and sort
> - Set regmap_config max_register in struct initialization
> - Remove shunt-resistor attribute and associated functions
> - Rename crit/lcrit attributes to max/min
> - Rework to use the hwmon_chip_info API
> - Add max_alarm and min_alarm channels and associated alert/alarm config
> - Add device tree ti,shunt-gain property use and ADCRANGE setup
> ---
>   Documentation/hwmon/ina238.rst |  56 ++++
>   Documentation/hwmon/index.rst  |   1 +
>   drivers/hwmon/Kconfig          |  12 +
>   drivers/hwmon/Makefile         |   1 +
>   drivers/hwmon/ina238.c         | 672 +++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 742 insertions(+)
>   create mode 100644 Documentation/hwmon/ina238.rst
>   create mode 100644 drivers/hwmon/ina238.c
> 
> diff --git a/Documentation/hwmon/ina238.rst b/Documentation/hwmon/ina238.rst
> new file mode 100644
> index 0000000000..d9f4799844
> --- /dev/null
> +++ b/Documentation/hwmon/ina238.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver ina238
> +====================
> +
> +Supported chips:
> +
> +  * Texas Instruments INA238
> +
> +    Prefix: 'ina238'
> +
> +    Addresses: I2C 0x40 - 0x4f
> +
> +    Datasheet:
> +	https://www.ti.com/lit/gpn/ina238
> +
> +Author: Nathan Rossi <nathan.rossi@digi.com>
> +
> +Description
> +-----------
> +
> +The INA238 is a current shunt, power and temperature monitor with an I2C
> +interface. It includes a number of programmable functions including alerts,
> +conversion rate, sample averaging and selectable shunt voltage accuracy.
> +
> +The shunt value in micro-ohms can be set via platform data or device tree at
> +compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
> +refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
> +if the device tree is used.
> +
> +Sysfs entries
> +-------------
> +
> +======================= =======================================================
> +in0_input		Shunt voltage (mV)
> +in0_min			Minimum shunt voltage threshold (mV)
> +in0_min_alarm		Minimum shunt voltage alarm
> +in0_max			Maximum shunt voltage threshold (mV)
> +in0_max_alarm		Maximum shunt voltage alarm
> +
> +in1_input		Bus voltage (mV)
> +in1_min			Minimum bus voltage threshold (mV)
> +in1_min_alarm		Minimum shunt voltage alarm
> +in1_max			Maximum bus voltage threshold (mV)
> +in1_max_alarm		Maximum shunt voltage alarm
> +
> +power1_input		Power measurement (uW)
> +power1_max		Maximum power threshold (uW)
> +power1_max_alarm	Maximum power alarm
> +
> +curr1_input		Current measurement (mA)
> +
> +temp1_input		Die temperature measurement (mC)
> +temp1_max		Maximum die temperature threshold (mC)
> +temp1_max_alarm		Maximum die temperature alarm
> +======================= =======================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 7046bf1870..6f30c8c9c7 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -76,6 +76,7 @@ Hardware Monitoring Kernel Drivers
>      ibmpowernv
>      ina209
>      ina2xx
> +   ina238
>      ina3221
>      intel-m10-bmc-hwmon
>      ir35221
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7fde4c6e1e..21aff4cef7 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1872,6 +1872,18 @@ config SENSORS_INA2XX
>   	  This driver can also be built as a module. If so, the module
>   	  will be called ina2xx.
>   
> +config SENSORS_INA238
> +	tristate "Texas Instruments INA238"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the INA238 power monitor
> +	  chip. This driver supports voltage, current, power and temperature
> +	  measurements as well as alarm configuration.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ina238.
> +
>   config SENSORS_INA3221
>   	tristate "Texas Instruments INA3221 Triple Power Monitor"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4d..1ddb26f57a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
>   obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>   obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
>   obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
> +obj-$(CONFIG_SENSORS_INA238)	+= ina238.o
>   obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
>   obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
>   obj-$(CONFIG_SENSORS_IT87)	+= it87.o
> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
> new file mode 100644
> index 0000000000..f9d031bdfe
> --- /dev/null
> +++ b/drivers/hwmon/ina238.c
> @@ -0,0 +1,672 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Texas Instruments INA238 power monitor chip
> + * Datasheet: https://www.ti.com/product/ina238
> + *
> + * Copyright (C) 2021 Nathan Rossi <nathan.rossi@digi.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon-sysfs.h>

Unnecessary.

> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/platform_data/ina2xx.h>
> +
> +/* INA238 register definitions */
> +#define INA238_CONFIG			0x0
> +#define INA238_ADC_CONFIG		0x1
> +#define INA238_SHUNT_CALIBRATION	0x2
> +#define INA238_SHUNT_VOLTAGE		0x4
> +#define INA238_BUS_VOLTAGE		0x5
> +#define INA238_DIE_TEMP			0x6
> +#define INA238_CURRENT			0x7
> +#define INA238_POWER			0x8
> +#define INA238_DIAG_ALERT		0xb
> +#define INA238_SHUNT_OVER_VOLTAGE	0xc
> +#define INA238_SHUNT_UNDER_VOLTAGE	0xd
> +#define INA238_BUS_OVER_VOLTAGE		0xe
> +#define INA238_BUS_UNDER_VOLTAGE	0xf
> +#define INA238_TEMP_LIMIT		0x10
> +#define INA238_POWER_LIMIT		0x11
> +#define INA238_DEVICE_ID		0x3f
> +
> +#define INA238_CONFIG_ADCRANGE		BIT(4)
> +
> +#define INA238_DIAG_ALERT_TMPOL		BIT(7)
> +#define INA238_DIAG_ALERT_SHNTOL	BIT(6)
> +#define INA238_DIAG_ALERT_SHNTUL	BIT(5)
> +#define INA238_DIAG_ALERT_BUSOL		BIT(4)
> +#define INA238_DIAG_ALERT_BUSUL		BIT(3)
> +#define INA238_DIAG_ALERT_POL		BIT(2)
> +
> +#define INA238_REGISTERS		0x11
> +
> +#define INA238_RSHUNT_DEFAULT		10000 /* uOhm */
> +
> +/* Default configuration of device on reset. */
> +#define INA238_CONFIG_DEFAULT		0
> +/* 16 sample averaging, 1052us conversion time, continuous mode */
> +#define INA238_ADC_CONFIG_DEFAULT	0xfb6a
> +/* Configure alerts to be based on averaged value (SLOWALERT) */
> +#define INA238_DIAG_ALERT_DEFAULT	0x2000
> +/*
> + * This driver uses a fixed calibration value in order to scale current/power
> + * based on a fixed shunt resistor value. This allows for conversion within the
> + * device to avoid integer limits whilst current/power accuracy is scaled
> + * relative to the shunt resistor value within the driver. This is similar to
> + * how the ina2xx driver handles current/power scaling.
> + *
> + * The end result of this is that increasing shunt values (from a fixed 20 mOhm
> + * shunt) increase the effective current/power accuracy whilst limiting the
> + * range and decreasing shunt values decrease the effective accuracy but
> + * increase the range.
> + *
> + * The value of the Current register is calculated given the following:
> + *   Current (A) = (shunt voltage register * 5) * calibration / 81920
> + *
> + * The maximum shunt voltage is 163.835 mV (0x7fff, ADC_RANGE = 0, gain = 4).
> + * With the maximum current value of 0x7fff and a fixed shunt value results in
> + * a calibration value of 16384 (0x4000).
> + *
> + *   0x7fff = (0x7fff * 5) * calibration / 81920
> + *   calibration = 0x4000
> + *
> + * Equivalent calibration is applied for the Power register (maximum value for
> + * bus voltage is 102396.875 mV, 0x7fff), where the maximum power that can
> + * occur is ~16776192 uW (register value 0x147a8):
> + *
> + * This scaling means the resulting values for Current and Power registers need
> + * to be scaled by the difference between the fixed shunt resistor and the
> + * actual shunt resistor:
> + *
> + *  shunt = 0x4000 / (819.2 * 10^6) / 0.001 = 20000 uOhms (with 1mA/lsb)
> + *
> + *  Current (mA) = register value * 20000 / rshunt / 4 * gain
> + *  Power (W) = 0.2 * register value * 20000 / rshunt / 4 * gain
> + */
> +#define INA238_CALIBRATION_VALUE	16384
> +#define INA238_FIXED_SHUNT		20000
> +
> +#define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
> +#define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
> +#define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
> +
> +static struct regmap_config ina238_regmap_config = {
> +	.max_register = INA238_REGISTERS,
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +};
> +
> +struct ina238_data {
> +	struct i2c_client *client;
> +	struct mutex config_lock;
> +	struct regmap *regmap;
> +	u32 rshunt;
> +	u32 gain;
> +};
> +
> +static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u32 *val)
> +{
> +	u8 data[3];
> +	int err;
> +
> +	/* 24-bit register read */
> +	err = i2c_smbus_read_i2c_block_data(client, reg, 3, data);
> +	if (err != 3)
> +		return err;

i2c_smbus_read_i2c_block_data() can return 1 or 2, which should be reported as error.
You need something like

	if (err < 0)
		return err;
	if (err != 3)
		return -EIO;

> +	*val = (data[0] << 16) | (data[1] << 8) | data[2];
> +
> +	return 0;
> +}
> +
> +static int ina238_read_in(struct device *dev, u32 attr, int channel,
> +			  long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int reg, mask;
> +	int regval;
> +	int err;
> +
> +	switch (channel) {
> +	case 0:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			reg = INA238_SHUNT_VOLTAGE;
> +			break;
> +		case hwmon_in_max:
> +			reg = INA238_SHUNT_OVER_VOLTAGE;
> +			break;
> +		case hwmon_in_min:
> +			reg = INA238_SHUNT_UNDER_VOLTAGE;
> +			break;
> +		case hwmon_in_max_alarm:
> +			reg = INA238_DIAG_ALERT;
> +			mask = INA238_DIAG_ALERT_SHNTOL;
> +			break;
> +		case hwmon_in_min_alarm:
> +			reg = INA238_DIAG_ALERT;
> +			mask = INA238_DIAG_ALERT_SHNTUL;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case 1:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			reg = INA238_BUS_VOLTAGE;
> +			break;
> +		case hwmon_in_max:
> +			reg = INA238_BUS_OVER_VOLTAGE;
> +			break;
> +		case hwmon_in_min:
> +			reg = INA238_BUS_UNDER_VOLTAGE;
> +			break;
> +		case hwmon_in_max_alarm:
> +			reg = INA238_DIAG_ALERT;
> +			mask = INA238_DIAG_ALERT_BUSOL;
> +			break;
> +		case hwmon_in_min_alarm:
> +			reg = INA238_DIAG_ALERT;
> +			mask = INA238_DIAG_ALERT_BUSUL;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = regmap_read(data->regmap, reg, &regval);
> +	if (err < 0)
> +		return err;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +	case hwmon_in_max:
> +	case hwmon_in_min:
> +		/* signed register, value in mV */
> +		if (channel == 0)
> +			/* gain of 1 -> LSB / 4 */
> +			*val = div_s64((s16)regval * INA238_SHUNT_VOLTAGE_LSB,
> +				       1000 * (4 - data->gain + 1));
> +		else
> +			*val = div_s64((s16)regval * INA238_BUS_VOLTAGE_LSB,
> +				       1000);

Pleae check the use of 64-bit divide operations. The above operations
never overflow a long, not even a 32-bit long, and div_s64() is therefore
unencessary. I am quite sure the same applies to current read operations,
though I didn't check.

> +		break;
> +	case hwmon_in_max_alarm:
> +	case hwmon_in_min_alarm:
> +		*val = regval & mask ? 1 : 0;

		*val = !!(regval & mask);

> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina238_write_in(struct device *dev, u32 attr, int channel,
> +			   long val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +
> +	if (attr != hwmon_in_max && attr != hwmon_in_min)
> +		return -EOPNOTSUPP;
> +
> +	/* convert decimal to register value */
> +	switch (channel) {
> +	case 0:
> +		/* signed */
> +		regval = div_s64((s64)val * 1000LL * (4 - data->gain + 1),
> +				 INA238_SHUNT_VOLTAGE_LSB);

I am quite sure the typecast is unnecessary here. Also, if you'd use clamp_val()
prior to the multiply/divide operation, I am quite sure you would not need
to use 64-bit divide operations.

> +		if (regval > S16_MAX || regval < S16_MIN)
> +			return -EINVAL;

We usually handle limit writes out of range with clamp_val() and
do not expect users to find the valid range for a given chip.

		regval = clamp_val(regval, S16_MIN, S16_MAX);

> +
> +		switch (attr) {
> +		case hwmon_in_max:
> +			return regmap_write(data->regmap,
> +					    INA238_SHUNT_OVER_VOLTAGE, regval);
> +		case hwmon_in_min:
> +			return regmap_write(data->regmap,
> +					    INA238_SHUNT_UNDER_VOLTAGE, regval);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	case 1:
> +		regval = div_u64((u64)val * 1000ULL, INA238_BUS_VOLTAGE_LSB);

This converts -1 to a really large value, which then overflows before being divided.
The result is more or less random. I think you'll need to use clamp_val first here.

> +		if (regval > U16_MAX || regval < 0)
> +			return -EINVAL;

		regval = clamp_val(regval, 0, U16_MAX);

> +
> +		switch (attr) {
> +		case hwmon_in_max:
> +			return regmap_write(data->regmap,
> +					    INA238_BUS_OVER_VOLTAGE, regval);
> +		case hwmon_in_min:
> +			return regmap_write(data->regmap,
> +					    INA238_BUS_UNDER_VOLTAGE, regval);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ina238_read_current(struct device *dev, u32 attr, int channel,
> +			       long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +	int err;
> +
> +	if (channel != 0)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		err = regmap_read(data->regmap, INA238_CURRENT, &regval);
> +		if (err < 0)
> +			return err;
> +
> +		/* Signed register, fixed 1mA current lsb. result in mA */
> +		*val = div_s64((s16)regval * INA238_FIXED_SHUNT * data->gain,
> +			       data->rshunt * 4);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina238_read_power(struct device *dev, u32 attr, int channel,
> +			     long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	long long power;
> +	int regval;
> +	int err;
> +
> +	if (channel != 0)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		err = ina238_read_reg24(data->client, INA238_POWER, &regval);
> +		if (err)
> +			return err;
> +
> +		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
> +		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *
> +				data->gain, 20 * data->rshunt);
> +		/* Clamp value to maximum value of long */
> +		*val = clamp_val(power, 0, LONG_MAX);
> +		break;
> +	case hwmon_power_max:
> +		err = regmap_read(data->regmap, INA238_POWER_LIMIT, &regval);
> +		if (err)
> +			return err;
> +
> +		/*
> +		 * Truncated 24-bit compare register, lower 8-bits are
> +		 * truncated. Same conversion to/from uW as POWER register.
> +		 */
> +		power = div_u64((regval << 8) * 1000ULL * INA238_FIXED_SHUNT *
> +			       data->gain, 20 * data->rshunt);
> +		/* Clamp value to maximum value of long */
> +		*val = clamp_val(power, 0, LONG_MAX);
> +		break;
> +	case hwmon_power_max_alarm:
> +		err = regmap_read(data->regmap, INA238_DIAG_ALERT, &regval);
> +		if (err)
> +			return err;
> +
> +		*val = regval & INA238_DIAG_ALERT_POL ? 1 : 0;

		*val = !!(regval & INA238_DIAG_ALERT_POL);

> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina238_write_power(struct device *dev, u32 attr, int channel,
> +			      long val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +
> +	if (channel != 0 || attr != hwmon_power_max)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Compared against the 24-bit power register, lower 8-bits are
> +	 * truncated. Same conversion to/from uW as POWER register.
> +	 */
> +	regval = div_u64((u64)val * 20ULL * data->rshunt,
> +			 1000ULL * INA238_FIXED_SHUNT * (u64)data->gain);

Same problem as above - negative values of val will have in unpredictable results.
The last typecat should be unnecessary.

> +	regval = regval >> 8;
> +	if (regval > U16_MAX || regval < 0)
> +		return -EINVAL;

	regval = clamp_val(...);

> +
> +	return regmap_write(data->regmap, INA238_POWER_LIMIT, regval);
> +}
> +
> +static int ina238_read_temp(struct device *dev, u32 attr, int channel,
> +			    long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +	int err;
> +
> +	if (channel != 0)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		err = regmap_read(data->regmap, INA238_DIE_TEMP, &regval);
> +		if (err)
> +			return err;
> +
> +		/* Signed, bits 15-4 of register, result in mC */
> +		*val = ((s16)regval >> 4) * INA238_DIE_TEMP_LSB;
> +		break;
> +	case hwmon_temp_max:
> +		err = regmap_read(data->regmap, INA238_TEMP_LIMIT, &regval);
> +		if (err)
> +			return err;
> +
> +		/* Signed, bits 15-4 of register, result in mC */
> +		*val = ((s16)regval >> 4) * INA238_DIE_TEMP_LSB;
> +		break;
> +	case hwmon_temp_max_alarm:
> +		err = regmap_read(data->regmap, INA238_DIAG_ALERT, &regval);
> +		if (err)
> +			return err;
> +
> +		*val = regval & INA238_DIAG_ALERT_TMPOL ? 1 : 0;

		*val = !!(regval & INA238_DIAG_ALERT_TMPOL);

> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina238_write_temp(struct device *dev, u32 attr, int channel,
> +			     long val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +
> +	if (channel != 0 || attr != hwmon_temp_max)
> +		return -EOPNOTSUPP;
> +
> +	/* Signed, bits 15-4 of register */
> +	regval = (div_s64(val, INA238_DIE_TEMP_LSB) << 4);
> +	if (regval > S16_MAX || regval < S16_MIN)
> +		return -EINVAL;

	regval = clamp_val(regval, S16_MIN, S16_MAX) & 0xfff0;

> +	regval = regval & 0xfff0;
> +
> +	return regmap_write(data->regmap, INA238_TEMP_LIMIT, regval);
> +}
> +
> +static int ina238_read(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return ina238_read_in(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return ina238_read_current(dev, attr, channel, val);
> +	case hwmon_power:
> +		return ina238_read_power(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return ina238_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int ina238_write(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int err;
> +
> +	mutex_lock(&data->config_lock);
> +
> +	switch (type) {
> +	case hwmon_in:
> +		err = ina238_write_in(dev, attr, channel, val);
> +		break;
> +	case hwmon_power:
> +		err = ina238_write_power(dev, attr, channel, val);
> +		break;
> +	case hwmon_temp:
> +		err = ina238_write_temp(dev, attr, channel, val);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	mutex_unlock(&data->config_lock);
> +	return err;
> +}
> +
> +static umode_t ina238_is_visible(const void *drvdata,
> +				 enum hwmon_sensor_types type,
> +				 u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		if (channel != 0 && channel != 1)
> +			return 0;

FWIW, channel checks are not really needed.

> +
> +		switch (attr) {
> +		case hwmon_in_input:
> +		case hwmon_in_max_alarm:
> +		case hwmon_in_min_alarm:
> +			return 0444;
> +		case hwmon_in_max:
> +		case hwmon_in_min:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_curr:
> +		if (channel != 0)
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_power:
> +		if (channel != 0)
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_power_input:
> +		case hwmon_power_max_alarm:
> +			return 0444;
> +		case hwmon_power_max:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_temp:
> +		if (channel != 0)
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_max_alarm:
> +			return 0444;
> +		case hwmon_temp_max:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +#define INA238_HWMON_IN_CONFIG (HWMON_I_INPUT | \
> +				HWMON_I_MAX | HWMON_I_MAX_ALARM | \
> +				HWMON_I_MIN | HWMON_I_MIN_ALARM)
> +
> +static const struct hwmon_channel_info *ina238_info[] = {
> +	HWMON_CHANNEL_INFO(in,
> +			   /* 0: shunt voltage */
> +			   INA238_HWMON_IN_CONFIG,
> +			   /* 1: bus voltage */
> +			   INA238_HWMON_IN_CONFIG),
> +	HWMON_CHANNEL_INFO(curr,
> +			   /* 0: current through shunt */
> +			   HWMON_C_INPUT),
> +	HWMON_CHANNEL_INFO(power,
> +			   /* 0: power */
> +			   HWMON_P_INPUT | HWMON_P_MAX | HWMON_P_MAX_ALARM),
> +	HWMON_CHANNEL_INFO(temp,
> +			   /* 0: die temperature */
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_ALARM),
> +	NULL
> +};
> +
> +static const struct hwmon_ops ina238_hwmon_ops = {
> +	.is_visible = ina238_is_visible,
> +	.read = ina238_read,
> +	.write = ina238_write,
> +};
> +
> +static const struct hwmon_chip_info ina238_chip_info = {
> +	.ops = &ina238_hwmon_ops,
> +	.info = ina238_info,
> +};
> +
> +static int ina238_probe(struct i2c_client *client)
> +{
> +	struct ina2xx_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct ina238_data *data;
> +	int config;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	/* set the device type */

Pointless comment. I don't even understand what it is supposed to mean.

> +	mutex_init(&data->config_lock);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ina238_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/* load shunt value */
> +	data->rshunt = INA238_RSHUNT_DEFAULT;
> +	if (device_property_read_u32(dev, "shunt-resistor", &data->rshunt) < 0 &&
> +	    pdata)

Drop the continuation line. Lines longer than 80 columns are fine when
improving readability, and that is definitely the case here.

> +		data->rshunt = pdata->shunt_uohms;
> +	if (data->rshunt == 0) {
> +		dev_err(dev, "invalid shunt resister value %u\n", data->rshunt);
> +		return -EINVAL;
> +	}
> +
> +	/* load shunt gain value */
> +	if (device_property_read_u32(dev, "ti,shunt-gain", &data->gain) < 0)
> +		data->gain = 4; /* Default of ADCRANGE = 0 */
> +	if (data->gain != 1 && data->gain != 4) {
> +		dev_err(dev, "invalid shunt gain value %u\n", data->gain);
> +		return -EINVAL;
> +	}

I think ti,shunt-gain needs a better explanation in the .yaml file, for
people writing devicetree files to understand how the gain value converts
to a register value.

> +
> +	/* Setup CONFIG register */
> +	config = INA238_CONFIG_DEFAULT;
> +	if (data->gain == 1)
> +		config |= INA238_CONFIG_ADCRANGE; /* ADCRANGE = 1 is /1 */
> +	ret = regmap_write(data->regmap, INA238_CONFIG, config);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the device: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	/* Setup ADC_CONFIG register */
> +	ret = regmap_write(data->regmap, INA238_ADC_CONFIG,
> +			   INA238_ADC_CONFIG_DEFAULT);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the device: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	/* Setup SHUNT_CALIBRATION register with fixed value */
> +	ret = regmap_write(data->regmap, INA238_SHUNT_CALIBRATION,
> +			   INA238_CALIBRATION_VALUE);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the device: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	/* Setup alert/alarm configuration */
> +	ret = regmap_write(data->regmap, INA238_DIAG_ALERT,
> +			   INA238_DIAG_ALERT_DEFAULT);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the device: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
> +							 &ina238_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(dev, "power monitor %s (Rshunt = %u uOhm, gain = %u)\n",
> +		 client->name, data->rshunt, data->gain);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ina238_id[] = {
> +	{ "ina238", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ina238_id);
> +
> +static const struct of_device_id __maybe_unused ina238_of_match[] = {
> +	{ .compatible = "ti,ina238" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ina238_of_match);
> +
> +static struct i2c_driver ina238_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "ina238",
> +		.of_match_table = of_match_ptr(ina238_of_match),
> +	},
> +	.probe_new	= ina238_probe,
> +	.id_table	= ina238_id,
> +};
> +
> +module_i2c_driver(ina238_driver);
> +
> +MODULE_AUTHOR("Nathan Rossi <nathan.rossi@digi.com>");
> +MODULE_DESCRIPTION("ina238 driver");
> +MODULE_LICENSE("GPL");
> ---
> 2.33.0
> 

