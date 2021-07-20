Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1AF3CFCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhGTOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbhGTORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC4C0613BC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:53:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d12so26284166wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h5pw6Hw85LtxqMYTdSvmyZOsNFgDVIuFjAaTUGE17KI=;
        b=IOsg4MoBL4XxGUHkgD37c2f94qTbinI6GPeJkFp0CWkZcXhApbmU7/AR5kg4VOpkA5
         EJWwJHJ+qf87R9JvQ0qFkySaaH4ratnQgxojh7/KnCpQXRs4U8fRLCV7agJ/o4IEuejK
         KzJepsOwQV5tXJ0ZIjsV5liJB5m/U0SaTRQ5WWNmMgoIt0HTa5bErx2sGDahnSoWO5hZ
         0xs2D3I7JdJmrgtWMUoG86ouVS3CcbDhPVmfu/icVTNJY1IHbZkFqA088CcNheMVNama
         lsnPiBSLNqyjeYenNY1WoSAezWNAQ652I+D4NTdNkWzw0BIc6x1xvZxodXJY5yhQaZfG
         5J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h5pw6Hw85LtxqMYTdSvmyZOsNFgDVIuFjAaTUGE17KI=;
        b=cgKgnj9S8oKU4lYACK4nz/oAnjp8knC1YVgEJs0YnJTftnV7XjC4z4gCiNfx5bqIhN
         h6N4VwMdABwgvAh5tzEg6tybAq+2LttekdBqJruqja0vAGz6qvzsKgHhmvGZPN1Fgn4H
         nLgp9vWkfcrDXAVipZIpeyxbTx4ySSTvfAKQV2TcQ63f13UqEhobvOuLIaqWr0msXu3r
         VnWinODBY0g6gE4pyj92qeidij7zZ4LH0Tc+9wfyb8kr8MhDDA+Hvshp/Zc5I+Wx5nni
         FhVxiDgLdhRAZnwjFP+0USQiK1cgvrTqBM3rE67Dpy9OCdQ6hGL9kSE/na4rvvRcVp5N
         Qpdw==
X-Gm-Message-State: AOAM532FeKBj/0qISYI/8evVEoKslDvPZGmWqa5S9AP5btYlWkxTZJiX
        KUtAxT8KKXsPFqBqWOiaM8Zdww==
X-Google-Smtp-Source: ABdhPJwfSWim+BUEh7nEAZYCh54dako+lSXE+6nj3DYycWTx9+HOZIzWSWoGnPs4h7oo161dDqjIIw==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr16400859wrq.95.1626792807609;
        Tue, 20 Jul 2021 07:53:27 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id w18sm1751179wrs.44.2021.07.20.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:53:27 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:53:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Message-ID: <YPbjZdu7T9wFcvNz@google.com>
References: <20210708115804.212-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021, Alistair Francis wrote:

> Initial support for the Silergy SY7636A Power Management chip.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig         |  9 +++++
>  drivers/mfd/Makefile        |  1 +
>  drivers/mfd/sy7636a.c       | 81 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 drivers/mfd/sy7636a.c
>  create mode 100644 include/linux/mfd/sy7636a.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..7b59aa0fd3f2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1352,6 +1352,15 @@ config MFD_SYSCON
>  	  Select this option to enable accessing system control registers
>  	  via regmap.
>  
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management chip"

s/chip/IC/

> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Select this option to enable support for the Silergy SY7636A
> +	  Power Management chip.

As above.

>  config MFD_DAVINCI_VOICECODEC
>  	tristate
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8116c19d5fd4..cbe581e87fa9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
> +obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> new file mode 100644
> index 000000000000..345892e11221
> --- /dev/null
> +++ b/drivers/mfd/sy7636a.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// MFD parent driver for SY7636A chip
> +//
> +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> +//
> +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> +//          Alistair Francis <alistair@alistair23.me>

Only C++ comments for the SPDX please.

> +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
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

If you put these in the Device Tree, you can use "simple-mfd-i2c"

> +static const struct of_device_id of_sy7636a_match_table[] = {
> +	{ .compatible = "silergy,sy7636a", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);

Place this near the i2c_device_id table please.

> +static int sy7636a_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *ids)
> +{
> +	struct sy7636a *sy7636a;

Please call this ddata.

> +	int ret;
> +
> +	sy7636a = devm_kzalloc(&client->dev, sizeof(*sy7636a), GFP_KERNEL);
> +	if (!sy7636a)
> +		return -ENOMEM;
> +
> +	sy7636a->dev = &client->dev;

What are you using 'dev' for?

You can normally just use 'dev->parent' from the child device.

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
> +	return devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
> +					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
> +					NULL, 0, NULL);
> +}
> +
> +static const struct i2c_device_id sy7636a_id_table[] = {
> +	{ "sy7636a", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);

Use probe_new below, then you can omit this table.

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
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> new file mode 100644
> index 000000000000..b6845a3572b8
> --- /dev/null
> +++ b/include/linux/mfd/sy7636a.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Functions to access SY3686A power management chip.
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + */
> +
> +#ifndef __MFD_SY7636A_H
> +#define __MFD_SY7636A_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +#define SY7636A_REG_OPERATION_MODE_CRL		0x00
> +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
> +#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
> +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
> +#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
> +#define SY7636A_REG_FAULT_FLAG			0x07
> +#define SY7636A_FAULT_FLAG_PG			BIT(0)
> +#define SY7636A_REG_TERMISTOR_READOUT		0x08
> +
> +#define SY7636A_REG_MAX				0x08
> +
> +#define VCOM_MIN		0
> +#define VCOM_MAX		5000
> +
> +#define VCOM_ADJUST_CTRL_MASK	0x1ff
> +// Used to shift the high byte
> +#define VCOM_ADJUST_CTRL_SHIFT	8
> +// Used to scale from VCOM_ADJUST_CTRL to mv
> +#define VCOM_ADJUST_CTRL_SCAL	10000
> +
> +#define FAULT_FLAG_SHIFT	1
> +
> +struct sy7636a {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct gpio_desc *pgood_gpio;

This looks unused?

> +};
> +
> +#endif /* __LINUX_MFD_SY7636A_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
