Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C930F0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhBDKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhBDKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:32:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBBC0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:31:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so2543310wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=onpa/C0dcxyHgX/R49Q3twyQ9Sp6EljN6o+bIystVXY=;
        b=KvoU7TcDm1YgLHahMzsdOndZjUmAzwQB7phItUifvzRZtrzQDZ/TWWEkcMYrux6Ry7
         NxCP4cKpPiIvhRA0shw4Pnz75Z58H9s2PfayfQEySaqq+o9HPTcWEjUgshlQ7Zxmrp1h
         L877NpeudloBhHEqLuvBq3QO4wb+Z7yiGVBx4t46bdhSJlJu92/ZrektFEd1BXMXeW+l
         0mHL4O2cyOp8CVgfi52rLicw+hKss3U/NiMsv2tz4JuSYnAQqpqRzyluBBWKNYZq+Ybk
         iSMlcZ7URo5i3U3rDehV0Im1hGlfAxrivxxEMTuacfEt0TonMvODQwinkyhtsn0amMEQ
         PUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=onpa/C0dcxyHgX/R49Q3twyQ9Sp6EljN6o+bIystVXY=;
        b=K14PlVfZMeP8Ip+lhAJQyG4ukeAs/4fbUEC6hRi8wQT20cUoeFqLtfT1pxl91twbwx
         a1x7NYLg9AxAtcqgzhlPJinREwRehqAblPXDSvoGVViNCdXlmbmNf6iwLmun36n9OD3r
         VTgMrRBnzwsLMnj1hUN+++ZmcUPyE3mX2sr/cUTiK3h2z4IIL+Cn6rCHTEL1blxEKQxx
         u/E0oALlNOJvyE9Fmbg9WVJ67/L5fYZ4RHFiYqWiEG4a2vinGFt+353YiBTS+YY4J7fr
         f+y4XR4MZNLT8m4jtpVjwt3NewuLa7FhLXJxmd1Mo3cb5BtNtiXkOUXlYo/iIg9KBlad
         iWxg==
X-Gm-Message-State: AOAM532pPP5aiEqwdGrE+gdvyvSNed9/jaGAAM+H1MxFGVcevJG+BqFU
        tt74f0z7Kl7BqxJHjwYgdo5hlw==
X-Google-Smtp-Source: ABdhPJylA+i2uUf08de998B8DpdCmQjZpV9oYaDyJbUX7CTlbvtk01c15fp+Y0hvPTX+nTpJHCmvqg==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr6887240wmc.100.1612434688894;
        Thu, 04 Feb 2021 02:31:28 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id v6sm7705348wrx.32.2021.02.04.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:31:28 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:31:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH 2/6] mfd: Initial commit of sy7636a
Message-ID: <20210204103126.GA2789116@dell>
References: <20210117042539.1609-1-alistair@alistair23.me>
 <20210117042539.1609-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210117042539.1609-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021, Alistair Francis wrote:

> Initial support for the Silergy SY7636A Power Management chip
> driver.

Please remove "driver", as this is not support for the driver, it *is*
the driver which supports the chip.

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig         |  10 ++
>  drivers/mfd/Makefile        |   2 +
>  drivers/mfd/sy7636a.c       | 252 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sy7636a.h |  50 +++++++
>  4 files changed, 314 insertions(+)
>  create mode 100644 drivers/mfd/sy7636a.c
>  create mode 100644 include/linux/mfd/sy7636a.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index bdfce7b15621..c8c62d92433c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1360,6 +1360,16 @@ config MFD_SYSCON
>  	  Select this option to enable accessing system control registers
>  	  via regmap.
>  
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management chip driver"

Again, please remove the word "driver" here.

> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y
> +	help
> +	  Select this option to enable support for the Silergy SY7636A
> +	  Power Management chip driver.

And again.

>  config MFD_DAVINCI_VOICECODEC
>  	tristate
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 14fdb188af02..1fa1e635f506 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -265,6 +265,8 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  
> +obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
> +

Why does this have to be segregated?

>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> new file mode 100644
> index 000000000000..39aac965d854
> --- /dev/null
> +++ b/drivers/mfd/sy7636a.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MFD driver for SY7636A chip

"Parent driver".

> + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/

This is quite out of date.  Please update.

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

This test is replaced by the SPDX header above.

> + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static const struct regmap_config sy7636a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct mfd_cell sy7636a_cells[] = {
> +	{ .name = "sy7636a-regulator", },
> +	{ .name = "sy7636a-temperature", },
> +	{ .name = "sy7636a-thermal", },
> +};
> +
> +static const struct of_device_id of_sy7636a_match_table[] = {
> +	{ .compatible = "silergy,sy7636a", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);

Please move this to where it is used i.e. at the bottom of the file.

> +static const char * const states[] = {
> +	"no fault event",
> +	"UVP at VP rail",
> +	"UVP at VN rail",
> +	"UVP at VPOS rail",
> +	"UVP at VNEG rail",
> +	"UVP at VDDH rail",
> +	"UVP at VEE rail",
> +	"SCP at VP rail",
> +	"SCP at VN rail",
> +	"SCP at VPOS rail",
> +	"SCP at VNEG rail",
> +	"SCP at VDDH rail",
> +	"SCP at VEE rail",
> +	"SCP at V COM rail",
> +	"UVLO",
> +	"Thermal shutdown",
> +};
> +
> +int get_vcom_voltage_mv(struct regmap *regmap)
> +{
> +	int ret;
> +	unsigned int val, val_h;
> +
> +	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, &val_h);
> +	if (ret)
> +		return ret;
> +
> +	val |= (val_h << 8);

Please define the shifts and masks.

> +	return (val & 0x1FF) * 10;

What's 10?

> +}
> +
> +int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	if (vcom < 0 || vcom > 5000)

Please define min/max values.

> +		return -EINVAL;
> +
> +	val = (unsigned int)(vcom / 10) & 0x1ff;

As above.

> +	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, val >> 8);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Who calls these?

> +static ssize_t state_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct sy7636a *sy7636a = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to read from device\n");
> +		return ret;
> +	}
> +
> +	val = val >> 1;

Why 1?

> +	if (val >= ARRAY_SIZE(states)) {
> +		dev_err(sy7636a->dev, "Unexpected value read from device: %u\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", states[val]);
> +}
> +static DEVICE_ATTR(state, 0444, state_show, NULL);

You need to document new sysfs entries.

> +static ssize_t power_good_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct sy7636a *sy7636a = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to read from device\n");
> +		return ret;
> +	}
> +
> +	val &= 0x01;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", val ? "ON" : "OFF");

Doesn't 0 just mean "no fault event"?

> +}
> +static DEVICE_ATTR(power_good, 0444, power_good_show, NULL);
> +
> +static ssize_t vcom_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret;
> +	struct sy7636a *sy7636a = dev_get_drvdata(dev);
> +
> +	ret = get_vcom_voltage_mv(sy7636a->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", -ret);
> +}
> +

Remove this line please.

> +static ssize_t vcom_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret;
> +	int vcom;
> +	struct sy7636a *sy7636a = dev_get_drvdata(dev);
> +
> +	ret = kstrtoint(buf, 0, &vcom);
> +	if (ret)
> +		return ret;
> +
> +	if (vcom > 0 || vcom < -5000)
> +		return -EINVAL;
> +
> +	ret = set_vcom_voltage_mv(sy7636a->regmap, (unsigned int)(-vcom));
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR(vcom, 0644, vcom_show, vcom_store);
> +
> +static struct attribute *sy7636a_sysfs_attrs[] = {
> +	&dev_attr_state.attr,
> +	&dev_attr_power_good.attr,
> +	&dev_attr_vcom.attr,
> +	NULL,
> +};

These all look like power options?  Do they really belong here?

> +static const struct attribute_group sy7636a_sysfs_attr_group = {
> +	.attrs = sy7636a_sysfs_attrs,
> +};
> +
> +static int sy7636a_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *ids)
> +{
> +	struct sy7636a *sy7636a;
> +	int ret;
> +
> +	sy7636a = devm_kzalloc(&client->dev, sizeof(struct sy7636a), GFP_KERNEL);

sizeof(*sy7636a)

> +	if (sy7636a == NULL)

if (!sy7636a)

> +		return -ENOMEM;
> +
> +	sy7636a->dev = &client->dev;
> +
> +	sy7636a->regmap = devm_regmap_init_i2c(client, &sy7636a_regmap_config);
> +	if (IS_ERR(sy7636a->regmap)) {
> +		ret = PTR_ERR(sy7636a->regmap);
> +		dev_err(sy7636a->dev,
> +			"Failed to initialize register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, sy7636a);
> +
> +	ret = sysfs_create_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to create sysfs attributes\n");
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
> +					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
> +					NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to add mfd devices\n");

"Failed to add child devices"

> +		sysfs_remove_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id sy7636a_id_table[] = {
> +	{ "sy7636a", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);

If you use .probe2, you can omit this table.

> +static struct i2c_driver sy7636a_driver = {
> +	.driver	= {
> +		.name	= "sy7636a",
> +		.of_match_table = of_sy7636a_match_table,
> +	},
> +	.probe = sy7636a_probe,
> +	.id_table = sy7636a_id_table,
> +};
> +module_i2c_driver(sy7636a_driver);
> +
> +MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
> +MODULE_DESCRIPTION("Silergy SY7636A Multi-Function Device Driver");

s/Multi-Function Device Driver/Power Management Chip/

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> new file mode 100644
> index 000000000000..642789c4d0a9
> --- /dev/null
> +++ b/include/linux/mfd/sy7636a.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Functions to access SY3686A power management chip.
> + *
> + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Same issues as mentioned above.

> +#ifndef __LINUX_MFD_SY7636A_H
> +#define __LINUX_MFD_SY7636A_H

Just MFD is fine.

> +#include <linux/i2c.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regmap.h>

Alphabetical.

> +#define SY7636A_REG_OPERATION_MODE_CRL 0x00
> +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL (1 << 6)
> +#define SY7636A_OPERATION_MODE_CRL_ONOFF (1 << 7)
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_L 0x01
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_H 0x02
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK 0x01ff
> +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL 0x03
> +#define SY7636A_REG_POWER_ON_DELAY_TIME 0x06
> +#define SY7636A_REG_FAULT_FLAG 0x07
> +#define SY7636A_FAULT_FLAG_PG (1 << 0)
> +#define SY7636A_REG_TERMISTOR_READOUT 0x08

Tab out the values please.

Use BIT()

> +#define SY7636A_REG_MAX 0x08
> +
> +struct sy7636a {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	unsigned int vcom;

Where is this used?

> +	struct gpio_desc *pgood_gpio;

Where is this used?

> +	struct mutex reglock;

Where is this used?

> +};
> +
> +int get_vcom_voltage_mv(struct regmap *regmap);
> +int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom);

What calls these?

> +#endif /* __LINUX_MFD_SY7636A_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
