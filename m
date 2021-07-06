Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22583BDC75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhGFRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhGFRom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:44:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC8C061574;
        Tue,  6 Jul 2021 10:42:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso22363735otu.10;
        Tue, 06 Jul 2021 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xn7spTYjtRFLwbJPnPY660ZiXsNkdmZFFDGxKrlshso=;
        b=IURc2kWispv4y0DFcdY6H6Zly0nNgO+rbHPquB7opSLpqWesryJfzl+8MVUHm50LSb
         rZBEuviy7BI9h8p6i1MvoE/bvAjPfNONY7NfArYRho/9YFIQEafoKWWLUh03LlapJuSZ
         lFmaAtiGU1hLa0fxqN6eTUpDfo9Hku/4ZbEdWDJ9meowyQFUsQ4cvbq1Tkix+5VDzP4q
         ufs4OudtZ0fL+FchTkrGsWuKFWv728vI+o7NEU7jxtqqlb/a0KrXccUyarAeo4cVERdV
         J3E+HfCv2PY7D3KW7pmgJLcCg8EBccFfX+ISfAeB9ojNwCw/JEg3G+apG1lciiW5wIZt
         Pnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xn7spTYjtRFLwbJPnPY660ZiXsNkdmZFFDGxKrlshso=;
        b=W4BQA4439HTna4KMNLCuBhqjoxrmr1GfThGIlCXtUdP2solle2wYb0UpoJlko7MxPY
         nTQw/X7W818lQvC60NK+VSMdfP7YLiSjuJ/NT8Cgh0CzY+UZh0kp6Gxs4vJPuF1KSgkL
         TsxRyz409PV7FWS+p8qQrfXHAaLo+Lv7mCDuINFJVBKrsvdwZICrhRQTW6sYDLD4suK/
         ucK14DYeU70HmR0GxPFgNlV9IgRrGSW7J2ozJLrWTRkUVMiDWO1/YXV0EoSXpIezav6d
         DE/kbyrD/iWu7GASmVZgMzwAKZxjfgU6Ra0srXUiNgJqQ5Q1nt7kGjDYwvY0euLv89gP
         3RRA==
X-Gm-Message-State: AOAM53031+WCkuBIpJiMrJHQA7fTMVRrR/wTF9KMstbuvzyMzcH4F8U4
        uhoXCLDzUtG+3eihpPdz3ac=
X-Google-Smtp-Source: ABdhPJwEzFWctfriZlOWnNXvVvQWggJ0YHvBztfQZ7olIWYmGb6XqCDp+TuOltJrc6VEpn/kdV26NQ==
X-Received: by 2002:a9d:7f91:: with SMTP id t17mr15523437otp.22.1625593323450;
        Tue, 06 Jul 2021 10:42:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i133sm3580303oia.2.2021.07.06.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:42:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jul 2021 10:42:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210706174201.GC943349@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
 <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:34:48PM +0000, Vincent Pelletier wrote:
> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Add the HWMON driver for DA9063
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Simplify and modernise the code a bit.
> Fix logic inversion in detecting conversion end.
> Drop support for ADCIN: these are multi-purpose channels and must not
> be reconfigured unless explicitly authorised by the board description.
> 
That is a bit too much information to be after the first Signed-off-by:
tag, and the code changes are too substantial to warrant Steve's
Signed-off-by: without his explicit permission. I'd suggest to drop
the change log and change Steve's Signed-off-by: to something like
Originally-from: or similar.

> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> Changes in v2:
> - drop of_match_table: this should be meaningless in such sub-function
>   driver (at least judging by other sub-function drivers for the da9063)
> - sort includes
> - switch to devm_hwmon_device_register_with_info
> - registers.h changes moved to patch 1
> - add SPDX header
> 
> This patch depends on patch 1/3.

FWIW, that is implied by having a patch series.

> Originally submitted by Steve Twiss in 2014:
>   https://marc.info/?l=linux-kernel&m=139560868309857&w=2
> 
>  drivers/hwmon/Kconfig        |  10 ++
>  drivers/hwmon/Makefile       |   1 +
>  drivers/hwmon/da9063-hwmon.c | 275 +++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/hwmon/da9063-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 87624902ea80..17244cfaa855 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -515,6 +515,16 @@ config SENSORS_DA9055
>  	  This driver can also be built as a module. If so, the module
>  	  will be called da9055-hwmon.
>  
> +config SENSORS_DA9063
> +	tristate "Dialog Semiconductor DA9063"
> +	depends on MFD_DA9063
> +	help
> +	  If you say yes here you get support for the hardware
> +	  monitoring features of the DA9063 Power Management IC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called da9063-hwmon.
> +
>  config SENSORS_I5K_AMB
>  	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
>  	depends on PCI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 59e78bc212cf..6855711ed9ec 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
>  obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
> +obj-$(CONFIG_SENSORS_DA9063)	+= da9063-hwmon.o
>  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
>  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
>  obj-$(CONFIG_SENSORS_DRIVETEMP)	+= drivetemp.o
> diff --git a/drivers/hwmon/da9063-hwmon.c b/drivers/hwmon/da9063-hwmon.c
> new file mode 100644
> index 000000000000..f020be5d5d6b
> --- /dev/null
> +++ b/drivers/hwmon/da9063-hwmon.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* da9063-hwmon.c - Hardware monitor support for DA9063
> + * Copyright (C) 2014 Dialog Semiconductor Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Library General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Library General Public License for more details.

Drop boilerplate; that is what SPDX is for.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/da9063/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#define DA9063_ADC_RES	(1 << (DA9063_ADC_RES_L_BITS + DA9063_ADC_RES_M_BITS))
> +#define DA9063_ADC_MAX	(DA9063_ADC_RES - 1)
> +#define DA9063_2V5	2500
> +#define DA9063_5V0	5000
> +#define DA9063_5V5	5500
> +#define DA9063_TJUNC_M	-398
> +#define DA9063_TJUNC_O	330000
> +#define DA9063_VBBAT_M	2048
> +
> +enum da9063_adc {
> +	DA9063_CHAN_VSYS = DA9063_ADC_MUX_VSYS,
> +	DA9063_CHAN_ADCIN1 = DA9063_ADC_MUX_ADCIN1,
> +	DA9063_CHAN_ADCIN2 = DA9063_ADC_MUX_ADCIN2,
> +	DA9063_CHAN_ADCIN3 = DA9063_ADC_MUX_ADCIN3,
> +	DA9063_CHAN_TJUNC = DA9063_ADC_MUX_T_SENSE,
> +	DA9063_CHAN_VBBAT = DA9063_ADC_MUX_VBBAT,
> +	DA9063_CHAN_LDO_G1 = DA9063_ADC_MUX_LDO_G1,
> +	DA9063_CHAN_LDO_G2 = DA9063_ADC_MUX_LDO_G2,
> +	DA9063_CHAN_LDO_G3 = DA9063_ADC_MUX_LDO_G3
> +};
> +
> +struct da9063_hwmon {
> +	struct da9063 *da9063;
> +	struct mutex hwmon_mutex;
> +	struct completion adc_ready;
> +	signed char tjunc_offset;
> +};
> +
> +static int da9063_adc_manual_read(struct da9063_hwmon *hwmon, int channel)
> +{
> +	int ret;
> +	unsigned char val;
> +	unsigned char data[2];
> +	int adc_man;
> +
> +	mutex_lock(&hwmon->hwmon_mutex);
> +
> +	init_completion(&hwmon->adc_ready);
> +
> +	val = (channel & DA9063_ADC_MUX_MASK) | DA9063_ADC_MAN;
> +	ret = regmap_update_bits(hwmon->da9063->regmap, DA9063_REG_ADC_MAN,
> +				 DA9063_ADC_MUX_MASK | DA9063_ADC_MAN, val);
> +	if (ret < 0)
> +		goto err_mread;
> +
> +	ret = wait_for_completion_timeout(&hwmon->adc_ready,
> +					  msecs_to_jiffies(1000));
> +	if (ret == 0) {
> +		ret = -ETIMEDOUT;
> +		goto err_mread;
> +	}
> +
> +	ret = regmap_read(hwmon->da9063->regmap, DA9063_REG_ADC_MAN, &adc_man);
> +	if (ret < 0)
> +		goto err_mread;
> +
> +	/* data value is not ready */
> +	if (adc_man & DA9063_ADC_MAN) {
> +		ret = -EINVAL;

-EINVAL seems wrong. Maybe -EIO or -ETIMEDOUT.

> +		goto err_mread;
> +	}
> +
> +	ret = regmap_bulk_read(hwmon->da9063->regmap,
> +			       DA9063_REG_ADC_RES_L, data, 2);
> +	if (ret < 0)
> +		goto err_mread;
> +
> +	ret = (data[0] & DA9063_ADC_RES_L_MASK) >> DA9063_ADC_RES_L_SHIFT;
> +	ret |= data[1] << DA9063_ADC_RES_L_BITS;
> +err_mread:
> +	mutex_unlock(&hwmon->hwmon_mutex);
> +	return ret;
> +}
> +
> +static irqreturn_t da9063_hwmon_irq_handler(int irq, void *irq_data)
> +{
> +	struct da9063_hwmon *hwmon = irq_data;
> +
> +	complete(&hwmon->adc_ready);
> +	return IRQ_HANDLED;
> +}
> +
> +static umode_t da9063_is_visible(const void *drvdata, enum
> +				 hwmon_sensor_types type, u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static const enum da9063_adc da9063_in_index[] = {
> +	DA9063_CHAN_VSYS, DA9063_CHAN_VBBAT
> +};
> +
> +static const enum da9063_adc da9063_temp_index[] = {
> +	DA9063_CHAN_TJUNC
> +};
> +
> +static int da9063_read(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long *val)
> +{
> +	struct da9063_hwmon *hwmon = dev_get_drvdata(dev);
> +	enum da9063_adc adc_channel;
> +	int tmp;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		if (attr != hwmon_in_input)
> +			return -EOPNOTSUPP;
> +		adc_channel = da9063_in_index[channel];
> +		break;
> +	case hwmon_temp:
> +		if (attr != hwmon_temp_input)
> +			return -EOPNOTSUPP;
> +		adc_channel = da9063_temp_index[channel];

There is only one channel for temperatures. I don't see value
in reading that value from an array of size 1.

> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	tmp = da9063_adc_manual_read(hwmon, adc_channel);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	switch (adc_channel) {
> +	case DA9063_CHAN_VSYS:
> +		*val = ((DA9063_5V5 - DA9063_2V5) * tmp) / DA9063_ADC_MAX +
> +			DA9063_2V5;
> +		break;
> +	case DA9063_CHAN_TJUNC:
> +		tmp -= hwmon->tjunc_offset;
> +		*val = DA9063_TJUNC_M * tmp + DA9063_TJUNC_O;
> +		break;
> +	case DA9063_CHAN_VBBAT:
> +		*val = (DA9063_5V0 * tmp) / DA9063_ADC_MAX;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const char * const da9063_in_name[] = {
> +	"VSYS", "VBBAT"
> +};
> +
> +static const char * const da9063_temp_name[] = {
> +	"TJUNC"
> +};
> +
> +static int da9063_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		if (attr != hwmon_in_label)
> +			return -EOPNOTSUPP;
> +		*str = da9063_in_name[channel];
> +		break;
> +	case hwmon_temp:
> +		if (attr != hwmon_temp_label)
> +			return -EOPNOTSUPP;
> +		*str = da9063_temp_name[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops da9063_ops = {
> +	.is_visible = da9063_is_visible,
> +	.read = da9063_read,
> +	.read_string = da9063_read_string,
> +};
> +
> +static const struct hwmon_channel_info *da9063_channel_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info da9063_chip_info = {
> +	.ops = &da9063_ops,
> +	.info = da9063_channel_info,
> +};
> +
> +static int da9063_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> +	struct da9063_hwmon *hwmon;
> +	struct device *hwmon_dev;
> +	int irq;
> +	int ret;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9063_hwmon),
> +			     GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	mutex_init(&hwmon->hwmon_mutex);
> +	init_completion(&hwmon->adc_ready);

Does this have a useful purpose ? It is initialized again prior to actually
waiting. Or is this to address the potential race with an interrupt firing
prior to hwmon registration ?

> +	hwmon->da9063 = da9063;
> +
> +	irq = platform_get_irq_byname(pdev, DA9063_DRVNAME_HWMON);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					da9063_hwmon_irq_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,

Is that correct ? The trigger condition is normally provided by
devicetree.

> +					"HWMON", hwmon);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request IRQ.\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, hwmon);

Where is this used ?

> +
> +	/* set trim temperature offset to value read at startup */
> +	hwmon->tjunc_offset = (signed char)hwmon->da9063->t_offset;

Can you explain why this is read in and passed from the mfd driver
and not here ?

> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "da9063",
> +							 hwmon,
> +							 &da9063_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver da9063_hwmon_driver = {
> +	.probe = da9063_hwmon_probe,
> +	.driver = {
> +		.name = DA9063_DRVNAME_HWMON,
> +	},
> +};
> +module_platform_driver(da9063_hwmon_driver);
> +
> +MODULE_DESCRIPTION("Hardware monitor support device driver for Dialog DA9063");
> +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DA9063_DRVNAME_HWMON);
> -- 
> 2.32.0
> 
