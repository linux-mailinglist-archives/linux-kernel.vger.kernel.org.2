Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341323694A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhDWO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhDWO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:28:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929EC061574;
        Fri, 23 Apr 2021 07:27:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso36812054ott.8;
        Fri, 23 Apr 2021 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDY0rUitiYjY1Gdzo3JLW6cvc4WRFyUmQnzh3Ywoi8s=;
        b=ScUqT1SysTzLCEeuPv4t+QlWNAANL+fMZElODHuBTyuI0sok7p1ej2bjB8a5yG+2KF
         KQZ2ulnCUVCmVLL9BwxQYh8YQ5rW247xHXRjwgFdME5+XSj08Rw1CaNxjhMVOm1a6uKM
         JMQuew4pR2gQANpGtLCQzSDVoWZ/N+IhfDS1ZIFztZRnDUwomV/GEFXg6kC1v1s1QvAr
         /XSsMSFCElEM8itNa3DU5FByuchPJ5RpUVtlx/7tQ4wv03GpK4zKlaG+nNw3iqUaFs8U
         esSLkGd212yRqolaSA4ZW46uv+6eyC8qG409jDHodkXUVEgo+CuqczRKxmpFADk4wkNd
         DLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDY0rUitiYjY1Gdzo3JLW6cvc4WRFyUmQnzh3Ywoi8s=;
        b=l6ud/Zrrzd/09NviiUVOlpne/B07cPHZ/g5xFhawyVcfVNJnQ1asc3ydtjrz6XTNQl
         MZOkNxPTOshO1xYkcniGenEEye8wLfL5E/24w3ZkT1HJoqU9MI+PJ2s0d4dJ9fZtCfm+
         mkJhg/YHDk216byY8RVmQO7wJWPGVH/ziCfHtDR54XPO9s0hdY1DPWFsWTEuo/qFNXvt
         Er8rM0ey90vdMYBGSEvi7alPbkVZ9xk/ugh/T01xtT7a6Ee/uFtXWX2FOOjXIa8U7E5H
         gfztED7P34gZ/6oIyG41ejfwPKWy4HWF4uPg0BlPcTEg0WHQ+tHpEV47lBdisEcHD7bH
         9Jeg==
X-Gm-Message-State: AOAM532cstaIEs/Alz8OnlVC5781OhjfESOpWxk9pp5dSvIPg+Mt2/CT
        UmJGXaNgxCFNBH3pyEkeAOlLTjpOGJM=
X-Google-Smtp-Source: ABdhPJyWzmR2basCt0dgPAUVZGnoGpzf4Oz8iULP4sBiKoP1dKmJv5HSFbaEL0HcREi59cVO53oX8g==
X-Received: by 2002:a05:6830:14cd:: with SMTP id t13mr3678225otq.74.1619188046361;
        Fri, 23 Apr 2021 07:27:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x5sm1430148ota.79.2021.04.23.07.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Apr 2021 07:27:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Apr 2021 07:27:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v4 3/4] hwmon: smpro: Add Ampere's Altra smpro-hwmon
 driver
Message-ID: <20210423142724.GA136170@roeck-us.net>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
 <20210422090843.4614-4-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422090843.4614-4-quan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:08:42PM +0700, Quan Nguyen wrote:
> This commit adds support for Ampere SMpro hwmon driver. This driver
> supports accessing various CPU sensors provided by the SMpro co-processor
> including temperature, power, voltages, and current.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

For my reference:
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

We'll need to wait for dt approval.

Thanks,
Guenter

> ---
> Changes in v4:
>   + Returned regmap_read() error code [Guenter]
> 
> Changes in v3:
>   + Handled negative temperature value [Guenter]
>   + Returned -ENODEV if Manufacturer ID is wrong [Guenter]
>   + Refactored smpro_read_string() and smpro_temp_read() [Guenter]
>   + Removed smpro_write() function [Guenter]
>   + Added minor refactor changes [Quan]
> 
> Changes in v2:
>   + Removed "virtual" sensors [Guenter]
>   + Reported SOC_TDP as "Socket TDP" using max attributes [Guenter]
>   + Corrected return error code when host is turn off [Guenter]
>   + Reported MEM HOT Threshold for all DIMMs as temp*_crit [Guenter]
>   + Removed license info as SPDX-License-Identifier existed [Guenter]
>   + Added is_visible() support [Guenter]
>   + Used HWMON_CHANNEL_INFO() macro and LABEL attributes [Guenter]
>   + Made is_valid_id() return boolean [Guenter]
>   + Returned -EPROBE_DEFER when smpro reg inaccessible [Guenter]
>   + Removed unnecessary error message when dev register fail [Guenter]
>   + Removed Socket TDP sensor [Quan]
>   + Included sensor type and channel in labels [Quan]
>   + Refactorized code to fix checkpatch.pl --strict complaint [Quan]
> 
>  drivers/hwmon/Kconfig       |   8 +
>  drivers/hwmon/Makefile      |   1 +
>  drivers/hwmon/smpro-hwmon.c | 491 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 500 insertions(+)
>  create mode 100644 drivers/hwmon/smpro-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 0ddc974b102e..ba4b5a911baf 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -67,6 +67,14 @@ config SENSORS_ABITUGURU3
>  	  This driver can also be built as a module. If so, the module
>  	  will be called abituguru3.
>  
> +config SENSORS_SMPRO
> +	tristate "Ampere's Altra SMpro hardware monitoring driver"
> +	depends on MFD_SMPRO
> +	help
> +	  If you say yes here you get support for the thermal, voltage,
> +	  current and power sensors of Ampere's Altra processor family SoC
> +	  with SMpro co-processor.
> +
>  config SENSORS_AD7314
>  	tristate "Analog Devices AD7314 and compatibles"
>  	depends on SPI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 59e78bc212cf..b25391f9c651 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -174,6 +174,7 @@ obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
>  obj-$(CONFIG_SENSORS_SHTC1)	+= shtc1.o
>  obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
>  obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
> +obj-$(CONFIG_SENSORS_SMPRO)	+= smpro-hwmon.o
>  obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
> diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
> new file mode 100644
> index 000000000000..1be3d98e73c7
> --- /dev/null
> +++ b/drivers/hwmon/smpro-hwmon.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Ampere Computing SoC's SMPro Hardware Monitoring Driver
> + *
> + * Copyright (c) 2021, Ampere Computing LLC
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* Identification Registers */
> +#define MANUFACTURER_ID_REG	0x02
> +#define AMPERE_MANUFACTURER_ID	0xCD3A
> +
> +/* Logical Power Sensor Registers */
> +#define SOC_TEMP		0x00
> +#define SOC_VRD_TEMP		0x01
> +#define DIMM_VRD_TEMP		0x02
> +#define CORE_VRD_TEMP		0x03
> +#define CH0_DIMM_TEMP		0x04
> +#define CH1_DIMM_TEMP		0x05
> +#define CH2_DIMM_TEMP		0x06
> +#define CH3_DIMM_TEMP		0x07
> +#define CH4_DIMM_TEMP		0x08
> +#define CH5_DIMM_TEMP		0x09
> +#define CH6_DIMM_TEMP		0x0A
> +#define CH7_DIMM_TEMP		0x0B
> +#define RCA_VRD_TEMP		0x0C
> +
> +#define CORE_VRD_PWR		0x10
> +#define SOC_PWR			0x11
> +#define DIMM_VRD1_PWR		0x12
> +#define DIMM_VRD2_PWR		0x13
> +#define CORE_VRD_PWR_MW		0x16
> +#define SOC_PWR_MW		0x17
> +#define DIMM_VRD1_PWR_MW	0x18
> +#define DIMM_VRD2_PWR_MW	0x19
> +#define RCA_VRD_PWR		0x1A
> +#define RCA_VRD_PWR_MW		0x1B
> +
> +#define MEM_HOT_THRESHOLD	0x22
> +#define SOC_VR_HOT_THRESHOLD	0x23
> +#define CORE_VRD_VOLT		0x24
> +#define SOC_VRD_VOLT		0x25
> +#define DIMM_VRD1_VOLT		0x26
> +#define DIMM_VRD2_VOLT		0x27
> +#define RCA_VRD_VOLT		0x28
> +
> +#define CORE_VRD_CURR		0x29
> +#define SOC_VRD_CURR		0x2A
> +#define DIMM_VRD1_CURR		0x2B
> +#define DIMM_VRD2_CURR		0x2C
> +#define RCA_VRD_CURR		0x2D
> +
> +struct smpro_hwmon {
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +struct smpro_sensor {
> +	const u8 reg;
> +	const u8 reg_ext;
> +	const char *label;
> +};
> +
> +static const struct smpro_sensor temperature[] = {
> +	{
> +		.reg = SOC_TEMP,
> +		.label = "temp1 SoC"
> +	},
> +	{
> +		.reg = SOC_VRD_TEMP,
> +		.reg_ext = SOC_VR_HOT_THRESHOLD,
> +		.label = "temp2 SoC VRD"
> +	},
> +	{
> +		.reg = DIMM_VRD_TEMP,
> +		.label = "temp3 DIMM VRD"
> +	},
> +	{
> +		.reg = CORE_VRD_TEMP,
> +		.label = "temp4 CORE VRD"
> +	},
> +	{
> +		.reg = CH0_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp5 CH0 DIMM"
> +	},
> +	{
> +		.reg = CH1_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp6 CH1 DIMM"
> +	},
> +	{
> +		.reg = CH2_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp7 CH2 DIMM"
> +	},
> +	{
> +		.reg = CH3_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp8 CH3 DIMM"
> +	},
> +	{
> +		.reg = CH4_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp9 CH4 DIMM"
> +	},
> +	{
> +		.reg = CH5_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp10 CH5 DIMM"
> +	},
> +	{
> +		.reg = CH6_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp11 CH6 DIMM"
> +	},
> +	{
> +		.reg = CH7_DIMM_TEMP,
> +		.reg_ext = MEM_HOT_THRESHOLD,
> +		.label = "temp12 CH7 DIMM"
> +	},
> +	{
> +		.reg = RCA_VRD_TEMP,
> +		.label = "temp13 RCA VRD"
> +	},
> +};
> +
> +static const struct smpro_sensor voltage[] = {
> +	{
> +		.reg = CORE_VRD_VOLT,
> +		.label = "vout0 CORE VRD"
> +	},
> +	{
> +		.reg = SOC_VRD_VOLT,
> +		.label = "vout1 SoC VRD"
> +	},
> +	{
> +		.reg = DIMM_VRD1_VOLT,
> +		.label = "vout2 DIMM VRD1"
> +	},
> +	{
> +		.reg = DIMM_VRD2_VOLT,
> +		.label = "vout3 DIMM VRD2"
> +	},
> +	{
> +		.reg = RCA_VRD_VOLT,
> +		.label = "vout4 RCA VRD"
> +	},
> +};
> +
> +static const struct smpro_sensor curr_sensor[] = {
> +	{
> +		.reg = CORE_VRD_CURR,
> +		.label = "iout1 CORE VRD"
> +	},
> +	{
> +		.reg = SOC_VRD_CURR,
> +		.label = "iout2 SoC VRD"
> +	},
> +	{
> +		.reg = DIMM_VRD1_CURR,
> +		.label = "iout3 DIMM VRD1"
> +	},
> +	{
> +		.reg = DIMM_VRD2_CURR,
> +		.label = "iout4 DIMM VRD2"
> +	},
> +	{
> +		.reg = RCA_VRD_CURR,
> +		.label = "iout5 RCA VRD"
> +	},
> +};
> +
> +static const struct smpro_sensor power[] = {
> +	{
> +		.reg = CORE_VRD_PWR,
> +		.reg_ext = CORE_VRD_PWR_MW,
> +		.label = "power1 CORE VRD"
> +	},
> +	{
> +		.reg = SOC_PWR,
> +		.reg_ext = SOC_PWR_MW,
> +		.label = "power2 SoC"
> +	},
> +	{
> +		.reg = DIMM_VRD1_PWR,
> +		.reg_ext = DIMM_VRD1_PWR_MW,
> +		.label = "power3 DIMM VRD1"
> +	},
> +	{
> +		.reg = DIMM_VRD2_PWR,
> +		.reg_ext = DIMM_VRD2_PWR_MW,
> +		.label = "power4 DIMM VRD2"
> +	},
> +	{
> +		.reg = RCA_VRD_PWR,
> +		.reg_ext = RCA_VRD_PWR_MW,
> +		.label = "power5 RCA VRD"
> +	},
> +};
> +
> +static int smpro_read_temp(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + temperature[channel].reg, &value);
> +		if (ret)
> +			return ret;
> +		break;
> +	case hwmon_temp_crit:
> +		ret = regmap_read(hwmon->regmap,
> +				  hwmon->offset + temperature[channel].reg_ext, &value);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	*val = sign_extend32(value, 8) * 1000;
> +	return 0;
> +}
> +
> +static int smpro_read_in(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + voltage[channel].reg, &value);
> +		if (ret < 0)
> +			return ret;
> +		/* 15-bit value in 1mV */
> +		*val = value & 0x7fff;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read_curr(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + curr_sensor[channel].reg, &value);
> +		if (ret < 0)
> +			return ret;
> +		/* Scale reported by the hardware is 1mA */
> +		*val = value & 0x7fff;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read_power(struct device *dev, u32 attr, int channel, long *val_pwr)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int val = 0, val_mw = 0;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + power[channel].reg, &val);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + power[channel].reg_ext, &val_mw);
> +		if (ret)
> +			return ret;
> +
> +		*val_pwr = val * 1000000 + val_mw * 1000;
> +		return 0;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return smpro_read_temp(dev, attr, channel, val);
> +	case hwmon_in:
> +		return smpro_read_in(dev, attr, channel, val);
> +	case hwmon_power:
> +		return smpro_read_power(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return smpro_read_curr(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			*str = temperature[channel].label;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_label:
> +			*str = voltage[channel].label;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_label:
> +			*str = curr_sensor[channel].label;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_label:
> +			*str = power[channel].label;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
> +				u32 attr, int channel)
> +{
> +	const struct smpro_hwmon *hwmon = data;
> +	unsigned int value;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_label:
> +		case hwmon_temp_crit:
> +			ret = regmap_read(hwmon->regmap,
> +					  hwmon->offset + temperature[channel].reg, &value);
> +			if (ret || value == 0xFFFF)
> +				return 0;
> +		break;
> +		}
> +	default:
> +		break;
> +	}
> +
> +	return 0444;
> +}
> +
> +static const struct hwmon_channel_info *smpro_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops smpro_hwmon_ops = {
> +	.is_visible = smpro_is_visible,
> +	.read = smpro_read,
> +	.read_string = smpro_read_string,
> +};
> +
> +static const struct hwmon_chip_info smpro_chip_info = {
> +	.ops = &smpro_hwmon_ops,
> +	.info = smpro_info,
> +};
> +
> +static int smpro_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct smpro_hwmon *hwmon;
> +	struct device *hwmon_dev;
> +	unsigned int val;
> +	int ret;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct smpro_hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	hwmon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!hwmon->regmap)
> +		return -ENODEV;
> +
> +	ret = device_property_read_u32(&pdev->dev, "reg", &hwmon->offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Check for valid ID */
> +	ret = regmap_read(hwmon->regmap, MANUFACTURER_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != AMPERE_MANUFACTURER_ID)
> +		return -ENODEV;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "smpro_hwmon",
> +							 hwmon, &smpro_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id smpro_hwmon_of_match[] = {
> +	{ .compatible = "ampere,ac01-hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, smpro_hwmon_of_match);
> +
> +static struct platform_driver smpro_hwmon_driver = {
> +	.probe		= smpro_hwmon_probe,
> +	.driver = {
> +		.name	= "smpro-hwmon",
> +		.of_match_table = smpro_hwmon_of_match,
> +	},
> +};
> +
> +module_platform_driver(smpro_hwmon_driver);
> +
> +MODULE_AUTHOR("Thu Nguyen <thu@os.amperecomputing.com>");
> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
> +MODULE_DESCRIPTION("Ampere Altra SMPro hwmon driver");
> +MODULE_LICENSE("GPL v2");
