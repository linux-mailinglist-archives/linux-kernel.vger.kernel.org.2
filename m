Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009B73CFD40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbhGTOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbhGTOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB7C0613BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:59:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so26322869wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yFw9eCa6Yne8aD7x0KVLhGUOTjvf7zj2sXgUNOQ7EoQ=;
        b=lnDwOFP/w4qRNu7DKYbiNcOut8iXuRqZdeZrF1qP4BUKqaZXjlUecicSzRGKJuiYcZ
         BGQQpv2AlY+oXDuEfa+JVJdYtG46bgeoUGeLAs37MquPIdgW1LlsJo98ZUYhN5Nfm+xp
         4bVaudt5ocNibBhKlDcqs49Is8TklSbz3JU/Lf8SPUnU/DSF5so1NTpoEy6DVGrpyvoC
         WPrpyDEiL46FQlNshftNuyRYzrx/c1uXXgmLdjCUdkojMMU3tLFxpHF0CHn/UHDsG3t3
         vA95JUUARAfD3fC0gH9GEVPTDYbnYLoH4xhx754eYrrgJcse2gxFJetCcJ/FghTsLurZ
         4FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yFw9eCa6Yne8aD7x0KVLhGUOTjvf7zj2sXgUNOQ7EoQ=;
        b=fNjIR7Q27NnJFdgd9m/Iyt18/+gSJLCJa3D6KUM9tYfkmqsYjsaTXHRHYlF8IJmwds
         C+29ToLiej+wQ1fszOEGUWhiXFm/obCnP/csAa1o9LVtxvY4ob5LyQiBKC5AFetivrwn
         4PNW2QATEacGuj3NU59GiCDdpIqtpTlZTdDHYI9M72q/DaQ3D6rcrUDvmy5aiOr9fsXW
         LRTw5vXP1/mWBaIQUoCbZu5pt7uusemRYBk4D9DQBkZikg69OuG7oHEBan0hEtFQcyQQ
         QIGwwkfcSuO/NyaRy28/QKtD+peMJ2JgqFdJSpniTSDnq+J9/Jm1dy5r8DWgMpYNCBV6
         SZSA==
X-Gm-Message-State: AOAM530+giahZmYSIucIC1Hyj3kjf94+VJM/4NLlnacfa3SgPr9wvB56
        bSB6dViRjY/QeUS99rJ2FwtHRQ==
X-Google-Smtp-Source: ABdhPJzRAEg73fsmlXd91uCR2B7OKhXw45WsCeVgHpVLIyBMX6mbzxqxHGKXWadi45wr3PMXehrDsg==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr18813197wru.311.1626793169935;
        Tue, 20 Jul 2021 07:59:29 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id u16sm28890639wrw.36.2021.07.20.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:59:29 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:59:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v7 3/6] hwmon: sy7636a: Add temperature driver for sy7636a
Message-ID: <YPbkz/qpgWe8rvi5@google.com>
References: <20210708115804.212-1-alistair@alistair23.me>
 <20210708115804.212-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708115804.212-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021, Alistair Francis wrote:

> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |   1 +
>  drivers/hwmon/Kconfig                |  10 +++
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/sy7636a-hwmon.c        | 106 +++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>  create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index cd80e85d37cf..e9c0be5629c6 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -227,6 +227,7 @@ CONFIG_RN5T618_POWER=m
>  CONFIG_SENSORS_MC13783_ADC=y
>  CONFIG_SENSORS_GPIO_FAN=y
>  CONFIG_SENSORS_IIO_HWMON=y
> +CONFIG_SENSORS_SY7636A=y
>  CONFIG_THERMAL_STATISTICS=y
>  CONFIG_THERMAL_WRITABLE_TRIPS=y
>  CONFIG_CPU_THERMAL=y
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e3675377bc5d..6cae12de59cd 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1631,6 +1631,16 @@ config SENSORS_SIS5595
>  	  This driver can also be built as a module. If so, the module
>  	  will be called sis5595.
>  
> +config SENSORS_SY7636A
> +	tristate "Silergy SY7636A"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the thermistor readout of
> +	  the Silergy SY7636A PMIC.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sy7636a-hwmon.
> +
>  config SENSORS_DME1737
>  	tristate "SMSC DME1737, SCH311x and compatibles"
>  	depends on I2C && !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index d712c61c1f5e..8b2e09e25b24 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -180,6 +180,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>  obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>  obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>  obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>  obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
>  obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> new file mode 100644
> index 000000000000..4edbee99b693
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,106 @@
> +/*
> + * Functions to access SY3686A power management chip temperature
> + *
> + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> + *
> + * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The long form isn't usually accepted anymore.

Please replace with SPDX.

> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +struct sy7636a_data {
> +	struct sy7636a *sy7636a;
> +	struct device *hwmon_dev;
> +};
> +
> +static ssize_t show_temp(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	unsigned int reg_val;
> +	signed char temp;
> +	int ret;
> +	struct sy7636a_data *data = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(data->sy7636a->regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	temp = *((signed char*)&reg_val);

Whoa!  What's going on here?

You also need to run checkpatch.pl.

> +	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp0, S_IRUGO, show_temp, NULL, 0);
> +
> +static struct attribute *sy7636a_attrs[] = {
> +	&sensor_dev_attr_temp0.dev_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(sy7636a);
> +
> +static int sy7636a_sensor_probe(struct platform_device *pdev)
> +{
> +	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
> +	struct sy7636a_data *data;
> +	int err;
> +
> +	if (!sy7636a)
> +		return -EPROBE_DEFER;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);

Where is this used, outside of this function?

Not sure I see a good reason for having it around?

> +	if (!data) {
> +		return -ENOMEM;
> +	}
> +
> +	data->sy7636a = sy7636a;
> +	data->hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,

Why is this being stored into a struct?

> +			"sy7636a_temperature", data, sy7636a_groups);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sy7636a_sensor_id[] = {
> +	{ "sy7636a-temperature", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, sy7636a_sensor_id);
> +
> +static struct platform_driver sy7636a_sensor_driver = {
> +	.probe = sy7636a_sensor_probe,
> +	.id_table = sy7636a_sensor_id,

What does this do?

Where is the 'device' being registered?

> +	.driver = {
> +		.name = "sy7636a-temperature",
> +	},
> +};
> +module_platform_driver(sy7636a_sensor_driver);
> +
> +MODULE_DESCRIPTION("SY7636A sensor driver");
> +MODULE_LICENSE("GPL");
> +

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
