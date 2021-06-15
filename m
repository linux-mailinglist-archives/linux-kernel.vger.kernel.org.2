Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009723A815A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFONwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFONwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:52:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01623C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:50:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so2096258wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fg/U5h9CRv6Zjne9ztyEdR1kIQkmcMq19ryuS5/lhbI=;
        b=S1qfS/ls7YkaL5/CYVbQ2Q0nE+Ua2NvCV36y8yeorWQh5yGLzuQsozgrRhFblHClyi
         y0qIohrhLXL33PH+7JD/7niF/wLxDUxztehLHDpmMKCmRij9I2AtyFBdBEll6UCD6VU5
         FNiiYiDGZ5VbdAo0Ejvw3dzN+QNFu9pwg/uVmcoC6V7o6A8JEfySZ7/vmph8FmIrkata
         sK5d41ckzVS6Y6YLz/C2u0qoh6YaV9w83wpK+oowUCxG3h32pIA1bz0wl4sCe9dvgHHL
         e6GInTdyyhQCFFnM4EGxzy2r5gyufA9f4omG3m5cKSdAdF1xEKWNBkGqFKFu6dBi9Vrt
         AaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fg/U5h9CRv6Zjne9ztyEdR1kIQkmcMq19ryuS5/lhbI=;
        b=FwN65ObAx2IHjexRu88WOjecU3g7hZ6zgnBZhm66W8OyhrTTjmQG2Ug8j6elfpV45Q
         jbneSj/2KqWyvyaQQnkRdthidQW+IAJC8ELJbhr93h3+hnV/1R91YsSCKCAM3UMvrh5N
         AgWEU5SpEj/u03eIWOFOkBXaMF1lRIR2QpdVb3HAqMBtYDGXZLR6h+BYy+Tg5GMz0Xk1
         nwOQZ+ryKFrO9lgZCU1cUVs1vtdzPv5d2yLzgWwPUl+k0ecMj5aecwHT0wnJ9AeCoB9L
         0Y06fVNB01PwFsQt43gO1nnQTs3B2K4XzwpzEiqF9UfI8HlHJc/7hRMRzHkbRiCCDG+O
         D+EA==
X-Gm-Message-State: AOAM532WSNJUgy8jvu4SYdFwsxn/n7oXHMiw9p7QetgravYsyRyxZXma
        s+qqGApq6DSyZSLwigKMkmfZDg==
X-Google-Smtp-Source: ABdhPJzTB7veXFHwQ9jjnFz6HHiSexYkd4NqujX75vJF4yyNfpT4/xvNvc1+/Mm1nIROThWXXI/ayw==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr5360802wmj.99.1623765014105;
        Tue, 15 Jun 2021 06:50:14 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id m6sm22848020wrw.9.2021.06.15.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:50:13 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:50:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     sameo@linux.intel.com, grant.likely@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YMiwEYLkbKocs8ux@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -create the core driver suggested by Lee Jones
> 
>  drivers/mfd/Kconfig              |  28 ++
>  drivers/mfd/Makefile             |   5 +
>  drivers/mfd/rsmu_core.c          | 106 +++++
>  drivers/mfd/rsmu_i2c.c           | 190 +++++++++
>  drivers/mfd/rsmu_private.h       |  24 ++
>  drivers/mfd/rsmu_spi.c           | 265 +++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 112 ++++++
>  include/linux/mfd/idt8a340_reg.h | 817 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  35 ++
>  9 files changed, 1582 insertions(+)
>  create mode 100644 drivers/mfd/rsmu_core.c
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_private.h
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 21a131d..b919267 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2172,5 +2172,33 @@ config MFD_INTEL_M10_BMC
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_RSMU_I2C
> +	tristate "Renesas Synchronization Management Unit with I2C"
> +	depends on I2C && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support for the Renesas Synchronization Management Unit, such as
> +	  Clockmatrix and 82P33XXX series. This option supports I2C as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
> +config MFD_RSMU_SPI
> +	tristate "Renesas Synchronization Management Unit with SPI"
> +	depends on SPI && OF
> +	select MFD_CORE
> +	select REGMAP_SPI
> +	help
> +	  Support for the Renesas Synchronization Management Unit, such as
> +	  Clockmatrix and 82P33XXX series. This option supports SPI as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8..8739043 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -271,3 +271,8 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> +
> +rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
> +rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
> +obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
> +obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
> new file mode 100644
> index 0000000..ee57d12
> --- /dev/null
> +++ b/drivers/mfd/rsmu_core.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core driver for the Renesas ClockMatrix(TM) and 82P33xxx families of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>
> +#include "rsmu_private.h"

Alphabetical.

'\n'

(Why do I feel like I'm repeating myself!?)

> +enum {
> +	RSMU_PHC = 0,
> +	RSMU_CDEV = 1,
> +	RSMU_N_DEVS = 2,
> +};
> +
> +/* clockmatrix devices */

Nicer to have this in the name and omit the comment.

I'm definitely repeating myself.

No more submissions until you satisfy *all* of my review comments.

> +static struct mfd_cell rsmu_cm_devs[] = {
> +	[RSMU_PHC] = {
> +		.name = "idtcm-phc",

Can't you have a nicer name?

> +		.pdata_size = sizeof(struct rsmu_pdata),

This seems to come out of nowhere.

Probably nicer to set this when you set the platform_data.

> +	},
> +	[RSMU_CDEV] = {
> +		.name = "idtcm-cdev",
> +		.pdata_size = sizeof(struct rsmu_pdata),
> +	},
> +};
> +
> +/* sabre devices */

This is superfluous as it's in the variable name.

Maybe you can tell us what 'sabre' is instead?

> +static struct mfd_cell rsmu_sabre_devs[] = {
> +	[RSMU_PHC] = {
> +		.name = "idt82p33-phc",
> +		.pdata_size = sizeof(struct rsmu_pdata),
> +	},
> +	[RSMU_CDEV] = {
> +		.name = "idt82p33-cdev",
> +		.pdata_size = sizeof(struct rsmu_pdata),
> +	},
> +};
> +
> +int rsmu_read(struct device *dev, u16 reg, u8 *buf, u16 size)
> +{
> +	struct rsmu_dev *rsmu = dev_get_drvdata(dev);
> +
> +	return regmap_bulk_read(rsmu->regmap, reg, buf, size);
> +}
> +EXPORT_SYMBOL_GPL(rsmu_read);
> +
> +int rsmu_write(struct device *dev, u16 reg, u8 *buf, u16 size)
> +{
> +	struct rsmu_dev *rsmu = dev_get_drvdata(dev);
> +
> +	return regmap_bulk_write(rsmu->regmap, reg, buf, size);
> +}
> +EXPORT_SYMBOL_GPL(rsmu_write);

Why are you wrapping core APIs?

Just use the directly on-site.

> +int rsmu_device_init(struct rsmu_dev *rsmu)

This does not do any device initialisation.

Perhaps rsmu_probe() or rsmu_core_probe() instead.

> +{
> +	struct rsmu_pdata *pdata;
> +	struct mfd_cell *cells;
> +	int ret;
> +
> +	pdata = devm_kzalloc(rsmu->dev, sizeof(struct rsmu_pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cells = rsmu_cm_devs;
> +		break;
> +	case RSMU_SABRE:
> +		cells = rsmu_sabre_devs;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Invalid rsmu device type: %d\n", rsmu->type);

I feel like RSMU should be capitalised.

Instead of 'invalid', how about 'unsupported'?

> +		return -ENODEV;
> +	}
> +
> +	cells[RSMU_PHC].platform_data = pdata;
> +	cells[RSMU_CDEV].platform_data = pdata;
> +	mutex_init(&rsmu->lock);

> +	pdata->lock = &rsmu->lock;

Heh?  You don't need pdata at all then.

Just get the lock from ddata i.e. 'struct rsmu_dev'

> +	ret = devm_mfd_add_devices(rsmu->dev, PLATFORM_DEVID_AUTO, cells,
> +				   RSMU_N_DEVS, NULL, 0, NULL);
> +	if (ret < 0)

if (ret)

> +		dev_err(rsmu->dev, "Add mfd devices failed: %d\n", ret);

"Failed to register sub-devices"

> +
> +	return ret;
> +}
> +
> +void rsmu_device_exit(struct rsmu_dev *rsmu)
> +{
> +	mutex_destroy(&rsmu->lock);
> +}
> +
> +MODULE_DESCRIPTION("Core driver for Renesas Synchronization Management Unit");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> new file mode 100644
> index 0000000..f8bf0ea
> --- /dev/null
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * I2C driver for the IDT ClockMatrix(TM) and 82P33xxx families of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.

This is out of date.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>

Alphabetical.

'\n'.

> +#include "rsmu_private.h"
> +
> +/*
> + * 16-bit register address: the lower 8 bits of the register address come
> + * from the offset addr byte and the upper 8 bits come from the page register.
> + */
> +#define	RSMU_CM_PAGE_ADDR		0xFD
> +#define	RSMU_CM_PAGE_WINDOW		256
> +
> +/*
> + * 15-bit register address: the lower 7 bits of the register address come
> + * from the offset addr byte and the upper 8 bits come from the page register.
> + */
> +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> +#define	RSMU_SABRE_PAGE_WINDOW		128
> +
> +static const struct regmap_range_cfg rsmu_cm_range_cfg[] = {
> +	{
> +		.range_min = 0,
> +		.range_max = 0xD000,
> +		.selector_reg = RSMU_CM_PAGE_ADDR,
> +		.selector_mask = 0xFF,
> +		.selector_shift = 0,
> +		.window_start = 0,
> +		.window_len = RSMU_CM_PAGE_WINDOW,
> +	}
> +};
> +
> +static const struct regmap_range_cfg rsmu_sabre_range_cfg[] = {
> +	{
> +		.range_min = 0,
> +		.range_max = 0x400,
> +		.selector_reg = RSMU_SABRE_PAGE_ADDR,
> +		.selector_mask = 0xFF,
> +		.selector_shift = 0,
> +		.window_start = 0,
> +		.window_len = RSMU_SABRE_PAGE_WINDOW,
> +	}
> +};
> +
> +static bool rsmu_cm_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case RSMU_CM_PAGE_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static bool rsmu_sabre_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case RSMU_SABRE_PAGE_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config rsmu_cm_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xD000,
> +	.ranges = rsmu_cm_range_cfg,
> +	.num_ranges = ARRAY_SIZE(rsmu_cm_range_cfg),
> +	.volatile_reg = rsmu_cm_volatile_reg,
> +	.cache_type = REGCACHE_RBTREE,
> +	.can_multi_write = true,
> +};
> +
> +static const struct regmap_config rsmu_sabre_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x400,
> +	.ranges = rsmu_sabre_range_cfg,
> +	.num_ranges = ARRAY_SIZE(rsmu_sabre_range_cfg),
> +	.volatile_reg = rsmu_sabre_volatile_reg,
> +	.cache_type = REGCACHE_RBTREE,
> +	.can_multi_write = true,
> +};
> +
> +static int rsmu_i2c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	const struct regmap_config *cfg;
> +	struct rsmu_dev *rsmu;
> +	int ret;
> +
> +	rsmu = devm_kzalloc(&client->dev, sizeof(struct rsmu_dev), GFP_KERNEL);

sizeof(*rsmu)

> +	if (!rsmu)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, rsmu);
> +
> +	rsmu->dev = &client->dev;
> +	rsmu->type = (enum rsmu_type)id->driver_data;
> +
> +	/* Initialize regmap */

You *still* don't need this.

> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cfg = &rsmu_cm_regmap_config;
> +		break;
> +	case RSMU_SABRE:
> +		cfg = &rsmu_sabre_regmap_config;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Invalid rsmu device type: %d\n", rsmu->type);

"Unsupported RSMU"

> +		return -EINVAL;

-ENODEV, as above.

> +	}
> +	rsmu->regmap = devm_regmap_init_i2c(client, cfg);
> +	if (IS_ERR(rsmu->regmap)) {
> +		ret = PTR_ERR(rsmu->regmap);
> +		dev_err(rsmu->dev, "Failed to allocate register map: %d\n",
> +			ret);

Pop this on the line above.

No need to break like this for lines <100 chars.

> +		return ret;
> +	}
> +
> +	return rsmu_device_init(rsmu);
> +}
> +
> +static int rsmu_i2c_remove(struct i2c_client *client)
> +{
> +	struct rsmu_dev *rsmu = i2c_get_clientdata(client);
> +
> +	rsmu_device_exit(rsmu);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rsmu_i2c_id[] = {
> +	{ "8a34000", RSMU_CM },
> +	{ "8a34001", RSMU_CM },
> +	{ "82p33810", RSMU_SABRE },
> +	{ "82p33811", RSMU_SABRE },
> +	{ }

Close this up please (as below).

> +};
> +MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
> +
> +static const struct of_device_id rsmu_i2c_of_match[] = {
> +	{.compatible = "idt,8a34000", .data = (void *)RSMU_CM},
> +	{.compatible = "idt,8a34001", .data = (void *)RSMU_CM},
> +	{.compatible = "idt,82p33810", .data = (void *)RSMU_SABRE},
> +	{.compatible = "idt,82p33811", .data = (void *)RSMU_SABRE},

Spaces after the '{'s and before the '}' please.

It'll also look nicer if you line the .datas up.

Same with the i2c_device_id above.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
> +
> +static struct i2c_driver rsmu_i2c_driver = {
> +	.driver = {
> +		   .name = "rsmu-i2c",
> +		   .of_match_table = of_match_ptr(rsmu_i2c_of_match),

You've over-tabbed here.

> +	},
> +	.probe = rsmu_i2c_probe,
> +	.remove	= rsmu_i2c_remove,
> +	.id_table = rsmu_i2c_id,
> +};
> +
> +static int __init rsmu_i2c_init(void)
> +{
> +	return i2c_add_driver(&rsmu_i2c_driver);
> +}
> +/* init early so consumer devices can complete system boot */

Remove this comment please.

> +subsys_initcall(rsmu_i2c_init);
> +
> +static void __exit rsmu_i2c_exit(void)
> +{
> +	i2c_del_driver(&rsmu_i2c_driver);
> +}
> +module_exit(rsmu_i2c_exit);
> +
> +MODULE_DESCRIPTION("Renesas SMU I2C multi-function driver");

It's not a multi-function driver - those don't exist.

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/rsmu_private.h b/drivers/mfd/rsmu_private.h
> new file mode 100644
> index 0000000..c242dfc
> --- /dev/null
> +++ b/drivers/mfd/rsmu_private.h

Drop the private part please.

It's not in 'include'.

> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Multi-function driver for the IDT ClockMatrix(TM) and 82p33xxx families of

Not MFD.  Tell us what the device is please.

> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.

Out of date.

> + */
> +
> +#ifndef __RSMU_MFD_PRIVATE_H
> +#define __RSMU_MFD_PRIVATE_H
> +
> +#include <linux/mfd/rsmu.h>
> +
> +struct rsmu_dev {

Please call this rsmu_ddata.

> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	enum rsmu_type type;
> +	u16 page;
> +};

You're going to need to share this with the sub-devices.

Thus, this whole header is likely to be superflouous.

> +int rsmu_device_init(struct rsmu_dev *rsmu);
> +void rsmu_device_exit(struct rsmu_dev *rsmu);

'\n'

> +#endif /*  __LINUX_MFD_RSMU_H */

This does not match the line above.

Though, this one looks like the correct one.

> diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
> new file mode 100644
> index 0000000..f3a087b
> --- /dev/null
> +++ b/drivers/mfd/rsmu_spi.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SPI driver for the IDT ClockMatrix(TM) and 82P33xxx families of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>
> +#include "rsmu_private.h"
> +
> +/*
> + * 16-bit register address: the lower 7 bits of the register address come
> + * from the offset addr byte and the upper 9 bits come from the page register.
> + */
> +#define	RSMU_CM_PAGE_ADDR		0x7C
> +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> +#define	RSMU_HIGHER_ADDR_MASK		0xFF80
> +#define	RSMU_HIGHER_ADDR_SHIFT		7
> +#define	RSMU_LOWER_ADDR_MASK		0x7F
> +
> +static int rsmu_read_device(struct rsmu_dev *rsmu, u8 reg, u8 *buf, u16 bytes)
> +{
> +	struct spi_device *client = to_spi_device(rsmu->dev);
> +	struct spi_transfer xfer = {0};
> +	struct spi_message msg;
> +	u8 cmd[256] = {0};
> +	u8 rsp[256] = {0};
> +	int ret;
> +
> +	cmd[0] = reg | 0x80;
> +	xfer.rx_buf = rsp;
> +	xfer.len = bytes + 1;
> +	xfer.tx_buf = cmd;
> +	xfer.bits_per_word = client->bits_per_word;
> +	xfer.speed_hz = client->max_speed_hz;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	ret = spi_sync(client, &msg);
> +	if (ret >= 0)
> +		memcpy(buf, &rsp[1], xfer.len-1);

What's at rsp[0]?  Worth a comment?

> +
> +	return ret;
> +}
> +
> +static int rsmu_write_device(struct rsmu_dev *rsmu, u8 reg, u8 *buf, u16 bytes)
> +{
> +	struct spi_device *client = to_spi_device(rsmu->dev);
> +	struct spi_transfer xfer = {0};
> +	struct spi_message msg;
> +	u8 cmd[256] = {0};
> +	int ret = -1;
> +
> +	cmd[0] = reg;
> +	memcpy(&cmd[1], buf, bytes);
> +
> +	xfer.len = bytes + 1;
> +	xfer.tx_buf = cmd;
> +	xfer.bits_per_word = client->bits_per_word;
> +	xfer.speed_hz = client->max_speed_hz;
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	ret = spi_sync(client, &msg);
> +	return ret;
> +}
> +
> +static int rsmu_write_page_register(struct rsmu_dev *rsmu, u16 reg)
> +{
> +	u8 buf[2];
> +	u16 bytes;
> +	u16 page;
> +	u8 preg;

What is preg?

Please use a more forthcoming name page_addr maybe?

> +	int err;
> +
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		preg = RSMU_CM_PAGE_ADDR;
> +		page = reg & RSMU_HIGHER_ADDR_MASK;
> +		buf[0] = (u8)(page & 0xff);
> +		buf[1] = (u8)((page >> 8) & 0xff);
> +		bytes = 2;
> +		break;
> +	case RSMU_SABRE:
> +		preg = RSMU_SABRE_PAGE_ADDR;
> +		page = reg >> RSMU_HIGHER_ADDR_SHIFT;
> +		buf[0] = (u8)(page & 0xff);
> +		bytes = 1;
> +		break;
> +	default:
> +		return -EINVAL;

You used -ENODEV before.

No error message?

> +	}
> +
> +	if (rsmu->page == page)
> +		return 0;

What's this doing?  Needs a comment I think.

> +	err = rsmu_write_device(rsmu, preg, buf, bytes);
> +

Remove this line.

> +	if (err) {
> +		rsmu->page = 0xffff;

Comment.

> +		dev_err(rsmu->dev,
> +			"failed to set page offset 0x%x\n", page);

No need to wrap.

> +	} else {
> +		rsmu->page = page;
> +	}
> +
> +	return err;
> +}
> +
> +static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct rsmu_dev *rsmu = spi_get_drvdata((struct spi_device *)context);
> +	u8 addr = (u8)(reg & RSMU_LOWER_ADDR_MASK);
> +	int err;
> +
> +	err = rsmu_write_page_register(rsmu, reg);
> +	if (err)
> +		return err;
> +
> +	err = rsmu_read_device(rsmu, addr, (u8 *)val, 1);
> +	if (err)
> +		dev_err(rsmu->dev,
> +			"failed to read offset address 0x%x\n", addr);

As above regarding wrapping and from here on in.

> +	return err;
> +}
> +
> +static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct rsmu_dev *rsmu = spi_get_drvdata((struct spi_device *)context);
> +	u8 addr = (u8)(reg & RSMU_LOWER_ADDR_MASK);
> +	u8 data = (u8)val;
> +	int err;
> +
> +	err = rsmu_write_page_register(rsmu, reg);
> +	if (err)
> +		return err;
> +
> +	err = rsmu_write_device(rsmu, addr, &data, 1);
> +	if (err)
> +		dev_err(rsmu->dev,
> +			"failed to write offset address 0x%x\n", addr);
> +
> +	return err;
> +}
> +
> +static const struct regmap_config rsmu_cm_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = 0xD000,
> +	.reg_read = rsmu_reg_read,
> +	.reg_write = rsmu_reg_write,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct regmap_config rsmu_sabre_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = 0x400,
> +	.reg_read = rsmu_reg_read,
> +	.reg_write = rsmu_reg_write,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static int rsmu_spi_probe(struct spi_device *client)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(client);
> +	const struct regmap_config *cfg;
> +	struct rsmu_dev *rsmu;
> +	int ret;
> +
> +	rsmu = devm_kzalloc(&client->dev, sizeof(struct rsmu_dev), GFP_KERNEL);

sizeof(*rsmu)

> +	if (!rsmu)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(client, rsmu);
> +
> +	rsmu->dev = &client->dev;
> +	rsmu->type = (enum rsmu_type)id->driver_data;
> +
> +	/* Initialize regmap */
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cfg = &rsmu_cm_regmap_config;
> +		break;
> +	case RSMU_SABRE:
> +		cfg = &rsmu_sabre_regmap_config;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Invalid rsmu device type: %d\n", rsmu->type);
> +		return -EINVAL;

Same as before

> +	}

'\n'

> +	rsmu->regmap = devm_regmap_init(&client->dev, NULL, client, cfg);
> +	if (IS_ERR(rsmu->regmap)) {
> +		ret = PTR_ERR(rsmu->regmap);
> +		dev_err(rsmu->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return rsmu_device_init(rsmu);
> +}
> +
> +static int rsmu_spi_remove(struct spi_device *client)
> +{
> +	struct rsmu_dev *rsmu = spi_get_drvdata(client);
> +
> +	rsmu_device_exit(rsmu);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id rsmu_spi_id[] = {
> +	{ "8a34000", RSMU_CM },
> +	{ "8a34001", RSMU_CM },
> +	{ "82p33810", RSMU_SABRE },
> +	{ "82p33811", RSMU_SABRE },
> +	{ }

Close this up please.

> +};
> +MODULE_DEVICE_TABLE(spi, rsmu_spi_id);
> +
> +static const struct of_device_id rsmu_spi_of_match[] = {
> +	{.compatible = "idt,8a34000", .data = (void *)RSMU_CM},
> +	{.compatible = "idt,8a34001", .data = (void *)RSMU_CM},
> +	{.compatible = "idt,82p33810", .data = (void *)RSMU_SABRE},
> +	{.compatible = "idt,82p33811", .data = (void *)RSMU_SABRE},

Missing spaces.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_spi_of_match);
> +
> +static struct spi_driver rsmu_spi_driver = {
> +	.driver = {
> +		   .name = "rsmu-spi",
> +		   .of_match_table = of_match_ptr(rsmu_spi_of_match),

Over-tabbing.

> +	},
> +	.probe = rsmu_spi_probe,
> +	.remove	= rsmu_spi_remove,
> +	.id_table = rsmu_spi_id,
> +};
> +
> +static int __init rsmu_spi_init(void)
> +{
> +	return spi_register_driver(&rsmu_spi_driver);
> +}
> +/* init early so consumer devices can complete system boot */

As before.

> +subsys_initcall(rsmu_spi_init);
> +
> +static void __exit rsmu_spi_exit(void)
> +{
> +	spi_unregister_driver(&rsmu_spi_driver);
> +}
> +module_exit(rsmu_spi_exit);
> +
> +MODULE_DESCRIPTION("Renesas SMU SPI multi-function driver");

As before.

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/idt82p33_reg.h b/include/linux/mfd/idt82p33_reg.h
> new file mode 100644
> index 0000000..fb41ab0
> --- /dev/null
> +++ b/include/linux/mfd/idt82p33_reg.h
> @@ -0,0 +1,112 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* idt82p33_reg.h

Remove the filename, they have a habit of becoming out of date.

> + *
> + * Register Map - AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf
> + *
> + */

Copyright.

> +#ifndef HAVE_IDT82P33_REG
> +#define HAVE_IDT82P33_REG
> +
> +/* Register address */
> +#define DPLL1_TOD_CNFG 0x134
> +#define DPLL2_TOD_CNFG 0x1B4
> +
> +#define DPLL1_TOD_STS 0x10B
> +#define DPLL2_TOD_STS 0x18B
> +
> +#define DPLL1_TOD_TRIGGER 0x115
> +#define DPLL2_TOD_TRIGGER 0x195
> +
> +#define DPLL1_OPERATING_MODE_CNFG 0x120
> +#define DPLL2_OPERATING_MODE_CNFG 0x1A0
> +
> +#define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
> +#define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
> +
> +#define DPLL1_PHASE_OFFSET_CNFG 0x143
> +#define DPLL2_PHASE_OFFSET_CNFG 0x1C3
> +
> +#define DPLL1_SYNC_EDGE_CNFG 0x140
> +#define DPLL2_SYNC_EDGE_CNFG 0x1C0
> +
> +#define DPLL1_INPUT_MODE_CNFG 0x116
> +#define DPLL2_INPUT_MODE_CNFG 0x196
> +
> +#define DPLL1_OPERATING_STS 0x102
> +#define DPLL2_OPERATING_STS 0x182
> +
> +#define DPLL1_CURRENT_FREQ_STS 0x103
> +#define DPLL2_CURRENT_FREQ_STS 0x183
> +
> +#define REG_SOFT_RESET 0X381
> +
> +#define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
> +
> +/* Register bit definitions */
> +#define SYNC_TOD BIT(1)
> +#define PH_OFFSET_EN BIT(7)
> +#define SQUELCH_ENABLE BIT(5)
> +
> +/* Bit definitions for the DPLL_MODE register */
> +#define PLL_MODE_SHIFT		(0)
> +#define PLL_MODE_MASK		(0x1F)
> +#define COMBO_MODE_EN		BIT(5)
> +#define COMBO_MODE_SHIFT	(6)
> +#define COMBO_MODE_MASK		(0x3)
> +
> +/* Bit definitions for DPLL_OPERATING_STS register */
> +#define OPERATING_STS_MASK	(0x7)
> +#define OPERATING_STS_SHIFT	(0x0)
> +
> +/* Bit definitions for DPLL_TOD_TRIGGER register */
> +#define READ_TRIGGER_MASK	(0xF)
> +#define READ_TRIGGER_SHIFT	(0x0)
> +#define WRITE_TRIGGER_MASK	(0xF0)
> +#define WRITE_TRIGGER_SHIFT	(0x4)
> +
> +/* Bit definitions for REG_SOFT_RESET register */
> +#define SOFT_RESET_EN		BIT(7)
> +
> +enum pll_mode {
> +	PLL_MODE_MIN = 0,
> +	PLL_MODE_AUTOMATIC = PLL_MODE_MIN,
> +	PLL_MODE_FORCE_FREERUN = 1,
> +	PLL_MODE_FORCE_HOLDOVER = 2,
> +	PLL_MODE_FORCE_LOCKED = 4,
> +	PLL_MODE_FORCE_PRE_LOCKED2 = 5,
> +	PLL_MODE_FORCE_PRE_LOCKED = 6,
> +	PLL_MODE_FORCE_LOST_PHASE = 7,
> +	PLL_MODE_DCO = 10,
> +	PLL_MODE_WPH = 18,
> +	PLL_MODE_MAX = PLL_MODE_WPH,
> +};
> +
> +enum hw_tod_trig_sel {
> +	HW_TOD_TRIG_SEL_MIN = 0,
> +	HW_TOD_TRIG_SEL_NO_WRITE = HW_TOD_TRIG_SEL_MIN,
> +	HW_TOD_TRIG_SEL_NO_READ = HW_TOD_TRIG_SEL_MIN,
> +	HW_TOD_TRIG_SEL_SYNC_SEL = 1,
> +	HW_TOD_TRIG_SEL_IN12 = 2,
> +	HW_TOD_TRIG_SEL_IN13 = 3,
> +	HW_TOD_TRIG_SEL_IN14 = 4,
> +	HW_TOD_TRIG_SEL_TOD_PPS = 5,
> +	HW_TOD_TRIG_SEL_TIMER_INTERVAL = 6,
> +	HW_TOD_TRIG_SEL_MSB_PHASE_OFFSET_CNFG = 7,
> +	HW_TOD_TRIG_SEL_MSB_HOLDOVER_FREQ_CNFG = 8,
> +	HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG = 9,
> +	HW_TOD_RD_TRIG_SEL_LSB_TOD_STS = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +};
> +
> +/** @brief Enumerated type listing DPLL operational modes */
> +enum dpll_state {
> +	DPLL_STATE_FREERUN = 1,
> +	DPLL_STATE_HOLDOVER = 2,
> +	DPLL_STATE_LOCKED = 4,
> +	DPLL_STATE_PRELOCKED2 = 5,
> +	DPLL_STATE_PRELOCKED = 6,
> +	DPLL_STATE_LOSTPHASE = 7,
> +	DPLL_STATE_MAX
> +};
> +
> +#endif
> diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
> new file mode 100644
> index 0000000..e8868cd
> --- /dev/null
> +++ b/include/linux/mfd/idt8a340_reg.h
> @@ -0,0 +1,817 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* idt8a340_reg.h
> + *
> + * Originally generated by regen.tcl on Thu Feb 14 19:23:44 PST 2019
> + * https://github.com/richardcochran/regen
> + *
> + * Hand modified to include some HW registers.
> + * Based on 4.8.0, SCSR rev C commit a03c7ae5

What's this?

> + */
> +#ifndef HAVE_IDT8A340_REG
> +#define HAVE_IDT8A340_REG
> +
> +#define PAGE_ADDR_BASE                    0x0000
> +#define PAGE_ADDR                         0x00fc
> +
> +#define HW_REVISION                       0x8180
> +#define REV_ID                            0x007a
> +
> +#define HW_DPLL_0                         (0x8a00)
> +#define HW_DPLL_1                         (0x8b00)
> +#define HW_DPLL_2                         (0x8c00)
> +#define HW_DPLL_3                         (0x8d00)
> +#define HW_DPLL_4                         (0x8e00)
> +#define HW_DPLL_5                         (0x8f00)
> +#define HW_DPLL_6                         (0x9000)
> +#define HW_DPLL_7                         (0x9100)
> +
> +#define HW_DPLL_TOD_SW_TRIG_ADDR__0       (0x080)
> +#define HW_DPLL_TOD_CTRL_1                (0x089)
> +#define HW_DPLL_TOD_CTRL_2                (0x08A)
> +#define HW_DPLL_TOD_OVR__0                (0x098)
> +#define HW_DPLL_TOD_OUT_0__0              (0x0B0)
> +
> +#define HW_Q0_Q1_CH_SYNC_CTRL_0           (0xa740)
> +#define HW_Q0_Q1_CH_SYNC_CTRL_1           (0xa741)
> +#define HW_Q2_Q3_CH_SYNC_CTRL_0           (0xa742)
> +#define HW_Q2_Q3_CH_SYNC_CTRL_1           (0xa743)
> +#define HW_Q4_Q5_CH_SYNC_CTRL_0           (0xa744)
> +#define HW_Q4_Q5_CH_SYNC_CTRL_1           (0xa745)
> +#define HW_Q6_Q7_CH_SYNC_CTRL_0           (0xa746)
> +#define HW_Q6_Q7_CH_SYNC_CTRL_1           (0xa747)
> +#define HW_Q8_CH_SYNC_CTRL_0              (0xa748)
> +#define HW_Q8_CH_SYNC_CTRL_1              (0xa749)
> +#define HW_Q9_CH_SYNC_CTRL_0              (0xa74a)
> +#define HW_Q9_CH_SYNC_CTRL_1              (0xa74b)
> +#define HW_Q10_CH_SYNC_CTRL_0             (0xa74c)
> +#define HW_Q10_CH_SYNC_CTRL_1             (0xa74d)
> +#define HW_Q11_CH_SYNC_CTRL_0             (0xa74e)
> +#define HW_Q11_CH_SYNC_CTRL_1             (0xa74f)
> +
> +#define SYNC_SOURCE_DPLL0_TOD_PPS	0x14
> +#define SYNC_SOURCE_DPLL1_TOD_PPS	0x15
> +#define SYNC_SOURCE_DPLL2_TOD_PPS	0x16
> +#define SYNC_SOURCE_DPLL3_TOD_PPS	0x17
> +
> +#define SYNCTRL1_MASTER_SYNC_RST	BIT(7)
> +#define SYNCTRL1_MASTER_SYNC_TRIG	BIT(5)
> +#define SYNCTRL1_TOD_SYNC_TRIG		BIT(4)
> +#define SYNCTRL1_FBDIV_FRAME_SYNC_TRIG	BIT(3)
> +#define SYNCTRL1_FBDIV_SYNC_TRIG	BIT(2)
> +#define SYNCTRL1_Q1_DIV_SYNC_TRIG	BIT(1)
> +#define SYNCTRL1_Q0_DIV_SYNC_TRIG	BIT(0)
> +
> +#define HW_Q8_CTRL_SPARE  (0xa7d4)
> +#define HW_Q11_CTRL_SPARE (0xa7ec)
> +
> +/**
> + * Select FOD5 as sync_trigger for Q8 divider.
> + * Transition from logic zero to one
> + * sets trigger to sync Q8 divider.
> + *
> + * Unused when FOD4 is driving Q8 divider (normal operation).
> + */
> +#define Q9_TO_Q8_SYNC_TRIG  BIT(1)
> +
> +/**
> + * Enable FOD5 as driver for clock and sync for Q8 divider.
> + * Enable fanout buffer for FOD5.
> + *
> + * Unused when FOD4 is driving Q8 divider (normal operation).
> + */
> +#define Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
> +
> +/**
> + * Select FOD6 as sync_trigger for Q11 divider.
> + * Transition from logic zero to one
> + * sets trigger to sync Q11 divider.
> + *
> + * Unused when FOD7 is driving Q11 divider (normal operation).
> + */
> +#define Q10_TO_Q11_SYNC_TRIG  BIT(1)
> +
> +/**
> + * Enable FOD6 as driver for clock and sync for Q11 divider.
> + * Enable fanout buffer for FOD6.
> + *
> + * Unused when FOD7 is driving Q11 divider (normal operation).
> + */
> +#define Q10_TO_Q11_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
> +
> +#define RESET_CTRL                        0xc000
> +#define SM_RESET                          0x0012
> +#define SM_RESET_CMD                      0x5A
> +
> +#define GENERAL_STATUS                    0xc014
> +#define BOOT_STATUS                       0x0000
> +#define HW_REV_ID                         0x000A
> +#define BOND_ID                           0x000B
> +#define HW_CSR_ID                         0x000C
> +#define HW_IRQ_ID                         0x000E
> +
> +#define MAJ_REL                           0x0010
> +#define MIN_REL                           0x0011
> +#define HOTFIX_REL                        0x0012
> +
> +#define PIPELINE_ID                       0x0014
> +#define BUILD_ID                          0x0018
> +
> +#define JTAG_DEVICE_ID                    0x001c
> +#define PRODUCT_ID                        0x001e
> +
> +#define OTP_SCSR_CONFIG_SELECT            0x0022
> +
> +#define STATUS                            0xc03c
> +#define DPLL0_STATUS			  0x0018
> +#define DPLL1_STATUS			  0x0019
> +#define DPLL2_STATUS			  0x001a
> +#define DPLL3_STATUS			  0x001b
> +#define DPLL4_STATUS			  0x001c
> +#define DPLL5_STATUS			  0x001d
> +#define DPLL6_STATUS			  0x001e
> +#define DPLL7_STATUS			  0x001f
> +#define DPLL_SYS_STATUS                   0x0020
> +#define DPLL_SYS_APLL_STATUS              0x0021
> +#define DPLL0_FILTER_STATUS               0x0044
> +#define DPLL1_FILTER_STATUS               0x004c
> +#define DPLL2_FILTER_STATUS               0x0054
> +#define DPLL3_FILTER_STATUS               0x005c
> +#define DPLL4_FILTER_STATUS               0x0064
> +#define DPLL5_FILTER_STATUS               0x006c
> +#define DPLL6_FILTER_STATUS               0x0074
> +#define DPLL7_FILTER_STATUS               0x007c
> +#define DPLLSYS_FILTER_STATUS             0x0084
> +#define USER_GPIO0_TO_7_STATUS            0x008a
> +#define USER_GPIO8_TO_15_STATUS           0x008b
> +
> +#define GPIO_USER_CONTROL                 0xc160
> +#define GPIO0_TO_7_OUT                    0x0000
> +#define GPIO8_TO_15_OUT                   0x0001
> +
> +#define STICKY_STATUS_CLEAR               0xc164
> +
> +#define GPIO_TOD_NOTIFICATION_CLEAR       0xc16c
> +
> +#define ALERT_CFG                         0xc188
> +
> +#define SYS_DPLL_XO                       0xc194
> +

Omit all of these blank lines please.

> +#define SYS_APLL                          0xc19c
> +
> +#define INPUT_0                           0xc1b0
> +
> +#define INPUT_1                           0xc1c0
> +
> +#define INPUT_2                           0xc1d0
> +
> +#define INPUT_3                           0xc200
> +
> +#define INPUT_4                           0xc210
> +
> +#define INPUT_5                           0xc220
> +
> +#define INPUT_6                           0xc230
> +
> +#define INPUT_7                           0xc240
> +
> +#define INPUT_8                           0xc250
> +
> +#define INPUT_9                           0xc260
> +
> +#define INPUT_10                          0xc280
> +
> +#define INPUT_11                          0xc290
> +
> +#define INPUT_12                          0xc2a0
> +
> +#define INPUT_13                          0xc2b0
> +
> +#define INPUT_14                          0xc2c0
> +
> +#define INPUT_15                          0xc2d0
> +
> +#define REF_MON_0                         0xc2e0
> +
> +#define REF_MON_1                         0xc2ec
> +
> +#define REF_MON_2                         0xc300
> +
> +#define REF_MON_3                         0xc30c
> +
> +#define REF_MON_4                         0xc318
> +
> +#define REF_MON_5                         0xc324
> +
> +#define REF_MON_6                         0xc330
> +
> +#define REF_MON_7                         0xc33c
> +
> +#define REF_MON_8                         0xc348
> +
> +#define REF_MON_9                         0xc354
> +
> +#define REF_MON_10                        0xc360
> +
> +#define REF_MON_11                        0xc36c
> +
> +#define REF_MON_12                        0xc380
> +
> +#define REF_MON_13                        0xc38c
> +
> +#define REF_MON_14                        0xc398
> +
> +#define REF_MON_15                        0xc3a4
> +
> +#define DPLL_0                            0xc3b0
> +#define DPLL_CTRL_REG_0                   0x0002
> +#define DPLL_CTRL_REG_1                   0x0003
> +#define DPLL_CTRL_REG_2                   0x0004
> +#define DPLL_TOD_SYNC_CFG                 0x0031
> +#define DPLL_COMBO_SLAVE_CFG_0            0x0032
> +#define DPLL_COMBO_SLAVE_CFG_1            0x0033
> +#define DPLL_SLAVE_REF_CFG                0x0034
> +#define DPLL_REF_MODE                     0x0035
> +#define DPLL_PHASE_MEASUREMENT_CFG        0x0036
> +#define DPLL_MODE                         0x0037
> +
> +#define DPLL_1                            0xc400
> +
> +#define DPLL_2                            0xc438
> +
> +#define DPLL_3                            0xc480
> +
> +#define DPLL_4                            0xc4b8
> +
> +#define DPLL_5                            0xc500
> +
> +#define DPLL_6                            0xc538
> +
> +#define DPLL_7                            0xc580
> +
> +#define SYS_DPLL                          0xc5b8
> +
> +#define DPLL_CTRL_0                       0xc600
> +#define DPLL_CTRL_DPLL_MANU_REF_CFG       0x0001
> +#define DPLL_CTRL_DPLL_FOD_FREQ           0x001c
> +#define DPLL_CTRL_COMBO_MASTER_CFG        0x003a
> +
> +#define DPLL_CTRL_1                       0xc63c
> +
> +#define DPLL_CTRL_2                       0xc680
> +
> +#define DPLL_CTRL_3                       0xc6bc
> +
> +#define DPLL_CTRL_4                       0xc700
> +
> +#define DPLL_CTRL_5                       0xc73c
> +
> +#define DPLL_CTRL_6                       0xc780
> +
> +#define DPLL_CTRL_7                       0xc7bc
> +
> +#define SYS_DPLL_CTRL                     0xc800
> +
> +#define DPLL_PHASE_0                      0xc818
> +
> +/* Signed 42-bit FFO in units of 2^(-53) */
> +#define DPLL_WR_PHASE                     0x0000
> +
> +#define DPLL_PHASE_1                      0xc81c
> +
> +#define DPLL_PHASE_2                      0xc820
> +
> +#define DPLL_PHASE_3                      0xc824
> +
> +#define DPLL_PHASE_4                      0xc828
> +
> +#define DPLL_PHASE_5                      0xc82c
> +
> +#define DPLL_PHASE_6                      0xc830
> +
> +#define DPLL_PHASE_7                      0xc834
> +
> +#define DPLL_FREQ_0                       0xc838
> +
> +/* Signed 42-bit FFO in units of 2^(-53) */
> +#define DPLL_WR_FREQ                      0x0000
> +
> +#define DPLL_FREQ_1                       0xc840
> +
> +#define DPLL_FREQ_2                       0xc848
> +
> +#define DPLL_FREQ_3                       0xc850
> +
> +#define DPLL_FREQ_4                       0xc858
> +
> +#define DPLL_FREQ_5                       0xc860
> +
> +#define DPLL_FREQ_6                       0xc868
> +
> +#define DPLL_FREQ_7                       0xc870
> +
> +#define DPLL_PHASE_PULL_IN_0              0xc880
> +#define PULL_IN_OFFSET                    0x0000 /* Signed 32 bit */
> +#define PULL_IN_SLOPE_LIMIT               0x0004 /* Unsigned 24 bit */
> +#define PULL_IN_CTRL                      0x0007
> +
> +#define DPLL_PHASE_PULL_IN_1              0xc888
> +
> +#define DPLL_PHASE_PULL_IN_2              0xc890
> +
> +#define DPLL_PHASE_PULL_IN_3              0xc898
> +
> +#define DPLL_PHASE_PULL_IN_4              0xc8a0
> +
> +#define DPLL_PHASE_PULL_IN_5              0xc8a8
> +
> +#define DPLL_PHASE_PULL_IN_6              0xc8b0
> +
> +#define DPLL_PHASE_PULL_IN_7              0xc8b8
> +
> +#define GPIO_CFG                          0xc8c0
> +#define GPIO_CFG_GBL                      0x0000
> +
> +#define GPIO_0                            0xc8c2
> +#define GPIO_DCO_INC_DEC                  0x0000
> +#define GPIO_OUT_CTRL_0                   0x0001
> +#define GPIO_OUT_CTRL_1                   0x0002
> +#define GPIO_TOD_TRIG                     0x0003
> +#define GPIO_DPLL_INDICATOR               0x0004
> +#define GPIO_LOS_INDICATOR                0x0005
> +#define GPIO_REF_INPUT_DSQ_0              0x0006
> +#define GPIO_REF_INPUT_DSQ_1              0x0007
> +#define GPIO_REF_INPUT_DSQ_2              0x0008
> +#define GPIO_REF_INPUT_DSQ_3              0x0009
> +#define GPIO_MAN_CLK_SEL_0                0x000a
> +#define GPIO_MAN_CLK_SEL_1                0x000b
> +#define GPIO_MAN_CLK_SEL_2                0x000c
> +#define GPIO_SLAVE                        0x000d
> +#define GPIO_ALERT_OUT_CFG                0x000e
> +#define GPIO_TOD_NOTIFICATION_CFG         0x000f
> +#define GPIO_CTRL                         0x0010
> +
> +#define GPIO_1                            0xc8d4
> +
> +#define GPIO_2                            0xc8e6
> +
> +#define GPIO_3                            0xc900
> +
> +#define GPIO_4                            0xc912
> +
> +#define GPIO_5                            0xc924
> +
> +#define GPIO_6                            0xc936
> +
> +#define GPIO_7                            0xc948
> +
> +#define GPIO_8                            0xc95a
> +
> +#define GPIO_9                            0xc980
> +
> +#define GPIO_10                           0xc992
> +
> +#define GPIO_11                           0xc9a4
> +
> +#define GPIO_12                           0xc9b6
> +
> +#define GPIO_13                           0xc9c8
> +
> +#define GPIO_14                           0xc9da
> +
> +#define GPIO_15                           0xca00
> +
> +#define OUT_DIV_MUX                       0xca12
> +
> +#define OUTPUT_0                          0xca14
> +/* FOD frequency output divider value */
> +#define OUT_DIV                           0x0000
> +#define OUT_DUTY_CYCLE_HIGH               0x0004
> +#define OUT_CTRL_0                        0x0008
> +#define OUT_CTRL_1                        0x0009
> +/* Phase adjustment in FOD cycles */
> +#define OUT_PHASE_ADJ                     0x000c
> +
> +#define OUTPUT_1                          0xca24
> +
> +#define OUTPUT_2                          0xca34
> +
> +#define OUTPUT_3                          0xca44
> +
> +#define OUTPUT_4                          0xca54
> +
> +#define OUTPUT_5                          0xca64
> +
> +#define OUTPUT_6                          0xca80
> +
> +#define OUTPUT_7                          0xca90
> +
> +#define OUTPUT_8                          0xcaa0
> +
> +#define OUTPUT_9                          0xcab0
> +
> +#define OUTPUT_10                         0xcac0
> +
> +#define OUTPUT_11                         0xcad0
> +
> +#define SERIAL                            0xcae0
> +
> +#define PWM_ENCODER_0                     0xcb00
> +
> +#define PWM_ENCODER_1                     0xcb08
> +
> +#define PWM_ENCODER_2                     0xcb10
> +
> +#define PWM_ENCODER_3                     0xcb18
> +
> +#define PWM_ENCODER_4                     0xcb20
> +
> +#define PWM_ENCODER_5                     0xcb28
> +
> +#define PWM_ENCODER_6                     0xcb30
> +
> +#define PWM_ENCODER_7                     0xcb38
> +
> +#define PWM_DECODER_0                     0xcb40
> +
> +#define PWM_DECODER_1                     0xcb48
> +
> +#define PWM_DECODER_2                     0xcb50
> +
> +#define PWM_DECODER_3                     0xcb58
> +
> +#define PWM_DECODER_4                     0xcb60
> +
> +#define PWM_DECODER_5                     0xcb68
> +
> +#define PWM_DECODER_6                     0xcb70
> +
> +#define PWM_DECODER_7                     0xcb80
> +
> +#define PWM_DECODER_8                     0xcb88
> +
> +#define PWM_DECODER_9                     0xcb90
> +
> +#define PWM_DECODER_10                    0xcb98
> +
> +#define PWM_DECODER_11                    0xcba0
> +
> +#define PWM_DECODER_12                    0xcba8
> +
> +#define PWM_DECODER_13                    0xcbb0
> +
> +#define PWM_DECODER_14                    0xcbb8
> +
> +#define PWM_DECODER_15                    0xcbc0
> +
> +#define PWM_USER_DATA                     0xcbc8
> +
> +#define TOD_0                             0xcbcc
> +
> +/* Enable TOD counter, output channel sync and even-PPS mode */
> +#define TOD_CFG                           0x0000
> +
> +#define TOD_1                             0xcbce
> +
> +#define TOD_2                             0xcbd0
> +
> +#define TOD_3                             0xcbd2
> +
> +
> +#define TOD_WRITE_0                       0xcc00
> +/* 8-bit subns, 32-bit ns, 48-bit seconds */
> +#define TOD_WRITE                         0x0000
> +/* Counter increments after TOD write is completed */
> +#define TOD_WRITE_COUNTER                 0x000c
> +/* TOD write trigger configuration */
> +#define TOD_WRITE_SELECT_CFG_0            0x000d
> +/* TOD write trigger selection */
> +#define TOD_WRITE_CMD                     0x000f
> +
> +#define TOD_WRITE_1                       0xcc10
> +
> +#define TOD_WRITE_2                       0xcc20
> +
> +#define TOD_WRITE_3                       0xcc30
> +
> +#define TOD_READ_PRIMARY_0                0xcc40
> +/* 8-bit subns, 32-bit ns, 48-bit seconds */
> +#define TOD_READ_PRIMARY                  0x0000
> +/* Counter increments after TOD write is completed */
> +#define TOD_READ_PRIMARY_COUNTER          0x000b
> +/* Read trigger configuration */
> +#define TOD_READ_PRIMARY_SEL_CFG_0        0x000c
> +/* Read trigger selection */
> +#define TOD_READ_PRIMARY_CMD              0x000e
> +
> +#define TOD_READ_PRIMARY_1                0xcc50
> +
> +#define TOD_READ_PRIMARY_2                0xcc60
> +
> +#define TOD_READ_PRIMARY_3                0xcc80
> +
> +#define TOD_READ_SECONDARY_0              0xcc90
> +
> +#define TOD_READ_SECONDARY_1              0xcca0
> +
> +#define TOD_READ_SECONDARY_2              0xccb0
> +
> +#define TOD_READ_SECONDARY_3              0xccc0
> +
> +#define OUTPUT_TDC_CFG                    0xccd0
> +
> +#define OUTPUT_TDC_0                      0xcd00
> +
> +#define OUTPUT_TDC_1                      0xcd08
> +
> +#define OUTPUT_TDC_2                      0xcd10
> +
> +#define OUTPUT_TDC_3                      0xcd18
> +
> +#define INPUT_TDC                         0xcd20
> +
> +#define SCRATCH                           0xcf50
> +
> +#define EEPROM                            0xcf68
> +
> +#define OTP                               0xcf70
> +
> +#define BYTE                              0xcf80
> +
> +/* Bit definitions for the MAJ_REL register */
> +#define MAJOR_SHIFT                       (1)
> +#define MAJOR_MASK                        (0x7f)
> +#define PR_BUILD                          BIT(0)
> +
> +/* Bit definitions for the USER_GPIO0_TO_7_STATUS register */
> +#define GPIO0_LEVEL                       BIT(0)
> +#define GPIO1_LEVEL                       BIT(1)
> +#define GPIO2_LEVEL                       BIT(2)
> +#define GPIO3_LEVEL                       BIT(3)
> +#define GPIO4_LEVEL                       BIT(4)
> +#define GPIO5_LEVEL                       BIT(5)
> +#define GPIO6_LEVEL                       BIT(6)
> +#define GPIO7_LEVEL                       BIT(7)
> +
> +/* Bit definitions for the USER_GPIO8_TO_15_STATUS register */
> +#define GPIO8_LEVEL                       BIT(0)
> +#define GPIO9_LEVEL                       BIT(1)
> +#define GPIO10_LEVEL                      BIT(2)
> +#define GPIO11_LEVEL                      BIT(3)
> +#define GPIO12_LEVEL                      BIT(4)
> +#define GPIO13_LEVEL                      BIT(5)
> +#define GPIO14_LEVEL                      BIT(6)
> +#define GPIO15_LEVEL                      BIT(7)
> +
> +/* Bit definitions for the GPIO0_TO_7_OUT register */
> +#define GPIO0_DRIVE_LEVEL                 BIT(0)
> +#define GPIO1_DRIVE_LEVEL                 BIT(1)
> +#define GPIO2_DRIVE_LEVEL                 BIT(2)
> +#define GPIO3_DRIVE_LEVEL                 BIT(3)
> +#define GPIO4_DRIVE_LEVEL                 BIT(4)
> +#define GPIO5_DRIVE_LEVEL                 BIT(5)
> +#define GPIO6_DRIVE_LEVEL                 BIT(6)
> +#define GPIO7_DRIVE_LEVEL                 BIT(7)
> +
> +/* Bit definitions for the GPIO8_TO_15_OUT register */
> +#define GPIO8_DRIVE_LEVEL                 BIT(0)
> +#define GPIO9_DRIVE_LEVEL                 BIT(1)
> +#define GPIO10_DRIVE_LEVEL                BIT(2)
> +#define GPIO11_DRIVE_LEVEL                BIT(3)
> +#define GPIO12_DRIVE_LEVEL                BIT(4)
> +#define GPIO13_DRIVE_LEVEL                BIT(5)
> +#define GPIO14_DRIVE_LEVEL                BIT(6)
> +#define GPIO15_DRIVE_LEVEL                BIT(7)
> +
> +/* Bit definitions for the DPLL_TOD_SYNC_CFG register */
> +#define TOD_SYNC_SOURCE_SHIFT             (1)
> +#define TOD_SYNC_SOURCE_MASK              (0x3)
> +#define TOD_SYNC_EN                       BIT(0)
> +
> +/* Bit definitions for the DPLL_MODE register */
> +#define WRITE_TIMER_MODE                  BIT(6)
> +#define PLL_MODE_SHIFT                    (3)
> +#define PLL_MODE_MASK                     (0x7)
> +#define STATE_MODE_SHIFT                  (0)
> +#define STATE_MODE_MASK                   (0x7)
> +
> +/* Bit definitions for the GPIO_CFG_GBL register */
> +#define SUPPLY_MODE_SHIFT                 (0)
> +#define SUPPLY_MODE_MASK                  (0x3)
> +
> +/* Bit definitions for the GPIO_DCO_INC_DEC register */
> +#define INCDEC_DPLL_INDEX_SHIFT           (0)
> +#define INCDEC_DPLL_INDEX_MASK            (0x7)
> +
> +/* Bit definitions for the GPIO_OUT_CTRL_0 register */
> +#define CTRL_OUT_0                        BIT(0)
> +#define CTRL_OUT_1                        BIT(1)
> +#define CTRL_OUT_2                        BIT(2)
> +#define CTRL_OUT_3                        BIT(3)
> +#define CTRL_OUT_4                        BIT(4)
> +#define CTRL_OUT_5                        BIT(5)
> +#define CTRL_OUT_6                        BIT(6)
> +#define CTRL_OUT_7                        BIT(7)
> +
> +/* Bit definitions for the GPIO_OUT_CTRL_1 register */
> +#define CTRL_OUT_8                        BIT(0)
> +#define CTRL_OUT_9                        BIT(1)
> +#define CTRL_OUT_10                       BIT(2)
> +#define CTRL_OUT_11                       BIT(3)
> +#define CTRL_OUT_12                       BIT(4)
> +#define CTRL_OUT_13                       BIT(5)
> +#define CTRL_OUT_14                       BIT(6)
> +#define CTRL_OUT_15                       BIT(7)
> +
> +/* Bit definitions for the GPIO_TOD_TRIG register */
> +#define TOD_TRIG_0                        BIT(0)
> +#define TOD_TRIG_1                        BIT(1)
> +#define TOD_TRIG_2                        BIT(2)
> +#define TOD_TRIG_3                        BIT(3)
> +
> +/* Bit definitions for the GPIO_DPLL_INDICATOR register */
> +#define IND_DPLL_INDEX_SHIFT              (0)
> +#define IND_DPLL_INDEX_MASK               (0x7)
> +
> +/* Bit definitions for the GPIO_LOS_INDICATOR register */
> +#define REFMON_INDEX_SHIFT                (0)
> +#define REFMON_INDEX_MASK                 (0xf)
> +/* Active level of LOS indicator, 0=low 1=high */
> +#define ACTIVE_LEVEL                      BIT(4)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_0 register */
> +#define DSQ_INP_0                         BIT(0)
> +#define DSQ_INP_1                         BIT(1)
> +#define DSQ_INP_2                         BIT(2)
> +#define DSQ_INP_3                         BIT(3)
> +#define DSQ_INP_4                         BIT(4)
> +#define DSQ_INP_5                         BIT(5)
> +#define DSQ_INP_6                         BIT(6)
> +#define DSQ_INP_7                         BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_1 register */
> +#define DSQ_INP_8                         BIT(0)
> +#define DSQ_INP_9                         BIT(1)
> +#define DSQ_INP_10                        BIT(2)
> +#define DSQ_INP_11                        BIT(3)
> +#define DSQ_INP_12                        BIT(4)
> +#define DSQ_INP_13                        BIT(5)
> +#define DSQ_INP_14                        BIT(6)
> +#define DSQ_INP_15                        BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_2 register */
> +#define DSQ_DPLL_0                        BIT(0)
> +#define DSQ_DPLL_1                        BIT(1)
> +#define DSQ_DPLL_2                        BIT(2)
> +#define DSQ_DPLL_3                        BIT(3)
> +#define DSQ_DPLL_4                        BIT(4)
> +#define DSQ_DPLL_5                        BIT(5)
> +#define DSQ_DPLL_6                        BIT(6)
> +#define DSQ_DPLL_7                        BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_3 register */
> +#define DSQ_DPLL_SYS                      BIT(0)
> +#define GPIO_DSQ_LEVEL                    BIT(1)
> +
> +/* Bit definitions for the GPIO_TOD_NOTIFICATION_CFG register */
> +#define DPLL_TOD_SHIFT                    (0)
> +#define DPLL_TOD_MASK                     (0x3)
> +#define TOD_READ_SECONDARY                BIT(2)
> +#define GPIO_ASSERT_LEVEL                 BIT(3)
> +
> +/* Bit definitions for the GPIO_CTRL register */
> +#define GPIO_FUNCTION_EN                  BIT(0)
> +#define GPIO_CMOS_OD_MODE                 BIT(1)
> +#define GPIO_CONTROL_DIR                  BIT(2)
> +#define GPIO_PU_PD_MODE                   BIT(3)
> +#define GPIO_FUNCTION_SHIFT               (4)
> +#define GPIO_FUNCTION_MASK                (0xf)
> +
> +/* Bit definitions for the OUT_CTRL_1 register */
> +#define OUT_SYNC_DISABLE                  BIT(7)
> +#define SQUELCH_VALUE                     BIT(6)
> +#define SQUELCH_DISABLE                   BIT(5)
> +#define PAD_VDDO_SHIFT                    (2)
> +#define PAD_VDDO_MASK                     (0x7)
> +#define PAD_CMOSDRV_SHIFT                 (0)
> +#define PAD_CMOSDRV_MASK                  (0x3)
> +
> +/* Bit definitions for the TOD_CFG register */
> +#define TOD_EVEN_PPS_MODE                 BIT(2)
> +#define TOD_OUT_SYNC_ENABLE               BIT(1)
> +#define TOD_ENABLE                        BIT(0)
> +
> +/* Bit definitions for the TOD_WRITE_SELECT_CFG_0 register */
> +#define WR_PWM_DECODER_INDEX_SHIFT        (4)
> +#define WR_PWM_DECODER_INDEX_MASK         (0xf)
> +#define WR_REF_INDEX_SHIFT                (0)
> +#define WR_REF_INDEX_MASK                 (0xf)
> +
> +/* Bit definitions for the TOD_WRITE_CMD register */
> +#define TOD_WRITE_SELECTION_SHIFT         (0)
> +#define TOD_WRITE_SELECTION_MASK          (0xf)
> +/* 4.8.7 */
> +#define TOD_WRITE_TYPE_SHIFT              (4)
> +#define TOD_WRITE_TYPE_MASK               (0x3)
> +
> +/* Bit definitions for the TOD_READ_PRIMARY_SEL_CFG_0 register */
> +#define RD_PWM_DECODER_INDEX_SHIFT        (4)
> +#define RD_PWM_DECODER_INDEX_MASK         (0xf)
> +#define RD_REF_INDEX_SHIFT                (0)
> +#define RD_REF_INDEX_MASK                 (0xf)
> +
> +/* Bit definitions for the TOD_READ_PRIMARY_CMD register */
> +#define TOD_READ_TRIGGER_MODE             BIT(4)
> +#define TOD_READ_TRIGGER_SHIFT            (0)
> +#define TOD_READ_TRIGGER_MASK             (0xf)
> +
> +/* Bit definitions for the DPLL_CTRL_COMBO_MASTER_CFG register */
> +#define COMBO_MASTER_HOLD                 BIT(0)
> +
> +/* Bit definitions for DPLL_SYS_STATUS register */
> +#define DPLL_SYS_STATE_MASK               (0xf)
> +
> +/* Bit definitions for SYS_APLL_STATUS register */
> +#define SYS_APLL_LOSS_LOCK_LIVE_MASK       BIT(0)
> +#define SYS_APLL_LOSS_LOCK_LIVE_LOCKED     0
> +#define SYS_APLL_LOSS_LOCK_LIVE_UNLOCKED   1
> +
> +/* Bit definitions for the DPLL0_STATUS register */
> +#define DPLL_STATE_MASK                   (0xf)
> +#define DPLL_STATE_SHIFT                  (0x0)
> +
> +/* Values of DPLL_N.DPLL_MODE.PLL_MODE */
> +enum pll_mode {
> +	PLL_MODE_MIN = 0,
> +	PLL_MODE_NORMAL = PLL_MODE_MIN,
> +	PLL_MODE_WRITE_PHASE = 1,
> +	PLL_MODE_WRITE_FREQUENCY = 2,
> +	PLL_MODE_GPIO_INC_DEC = 3,
> +	PLL_MODE_SYNTHESIS = 4,
> +	PLL_MODE_PHASE_MEASUREMENT = 5,
> +	PLL_MODE_DISABLED = 6,
> +	PLL_MODE_MAX = PLL_MODE_DISABLED,
> +};
> +
> +enum hw_tod_write_trig_sel {
> +	HW_TOD_WR_TRIG_SEL_MIN = 0,
> +	HW_TOD_WR_TRIG_SEL_MSB = HW_TOD_WR_TRIG_SEL_MIN,
> +	HW_TOD_WR_TRIG_SEL_RESERVED = 1,
> +	HW_TOD_WR_TRIG_SEL_TOD_PPS = 2,
> +	HW_TOD_WR_TRIG_SEL_IRIGB_PPS = 3,
> +	HW_TOD_WR_TRIG_SEL_PWM_PPS = 4,
> +	HW_TOD_WR_TRIG_SEL_GPIO = 5,
> +	HW_TOD_WR_TRIG_SEL_FOD_SYNC = 6,
> +	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_FOD_SYNC,
> +};
> +
> +enum scsr_read_trig_sel {
> +	/* CANCEL CURRENT TOD READ; MODULE BECOMES IDLE - NO TRIGGER OCCURS */
> +	SCSR_TOD_READ_TRIG_SEL_DISABLE = 0,
> +	/* TRIGGER IMMEDIATELY */
> +	SCSR_TOD_READ_TRIG_SEL_IMMEDIATE = 1,
> +	/* TRIGGER ON RISING EDGE OF INTERNAL TOD PPS SIGNAL */
> +	SCSR_TOD_READ_TRIG_SEL_TODPPS = 2,
> +	/* TRGGER ON RISING EDGE OF SELECTED REFERENCE INPUT */
> +	SCSR_TOD_READ_TRIG_SEL_REFCLK = 3,
> +	/* TRIGGER ON RISING EDGE OF SELECTED PWM DECODER 1PPS OUTPUT */
> +	SCSR_TOD_READ_TRIG_SEL_PWMPPS = 4,
> +	SCSR_TOD_READ_TRIG_SEL_RESERVED = 5,
> +	/* TRIGGER WHEN WRITE FREQUENCY EVENT OCCURS  */
> +	SCSR_TOD_READ_TRIG_SEL_WRITEFREQUENCYEVENT = 6,
> +	/* TRIGGER ON SELECTED GPIO */
> +	SCSR_TOD_READ_TRIG_SEL_GPIO = 7,
> +	SCSR_TOD_READ_TRIG_SEL_MAX = SCSR_TOD_READ_TRIG_SEL_GPIO,
> +};
> +
> +/* Values STATUS.DPLL_SYS_STATUS.DPLL_SYS_STATE */
> +enum dpll_state {
> +	DPLL_STATE_MIN = 0,
> +	DPLL_STATE_FREERUN = DPLL_STATE_MIN,
> +	DPLL_STATE_LOCKACQ = 1,
> +	DPLL_STATE_LOCKREC = 2,
> +	DPLL_STATE_LOCKED = 3,
> +	DPLL_STATE_HOLDOVER = 4,
> +	DPLL_STATE_OPEN_LOOP = 5,
> +	DPLL_STATE_MAX = DPLL_STATE_OPEN_LOOP,
> +};
> +
> +/* 4.8.7 only */
> +enum scsr_tod_write_trig_sel {
> +	SCSR_TOD_WR_TRIG_SEL_DISABLE = 0,
> +	SCSR_TOD_WR_TRIG_SEL_IMMEDIATE = 1,
> +	SCSR_TOD_WR_TRIG_SEL_REFCLK = 2,
> +	SCSR_TOD_WR_TRIG_SEL_PWMPPS = 3,
> +	SCSR_TOD_WR_TRIG_SEL_TODPPS = 4,
> +	SCSR_TOD_WR_TRIG_SEL_SYNCFOD = 5,
> +	SCSR_TOD_WR_TRIG_SEL_GPIO = 6,
> +	SCSR_TOD_WR_TRIG_SEL_MAX = SCSR_TOD_WR_TRIG_SEL_GPIO,
> +};
> +
> +/* 4.8.7 only */
> +enum scsr_tod_write_type_sel {
> +	SCSR_TOD_WR_TYPE_SEL_ABSOLUTE = 0,
> +	SCSR_TOD_WR_TYPE_SEL_DELTA_PLUS = 1,
> +	SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS = 2,
> +	SCSR_TOD_WR_TYPE_SEL_MAX = SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS,
> +};
> +#endif
> diff --git a/include/linux/mfd/rsmu.h b/include/linux/mfd/rsmu.h
> new file mode 100644
> index 0000000..1dc6cef
> --- /dev/null
> +++ b/include/linux/mfd/rsmu.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Multi-function driver for the IDT ClockMatrix(TM) and 82p33xxx families of

As before.

> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.

As before.

> + */
> +
> +#ifndef __LINUX_MFD_RSMU_H
> +#define __LINUX_MFD_RSMU_H
> +
> +/* We only support Clockmatrix and Sabre now */
> +enum rsmu_type {
> +	RSMU_CM		= 0x34000,
> +	RSMU_SABRE	= 0x33810,
> +};
> +
> +/**
> + *
> + * struct rsmu_pdata - platform data structure for MFD cell devices.
> + *
> + * @lock: Mutex used by devices to make sure a series of bus access requests
> + *        are not interrupted.
> + */
> +struct rsmu_pdata {
> +	struct mutex *lock;
> +};

You can remove this.  Just pass in ddata instead.

> +/**
> + * NOTE: the functions below are not intended for use outside
> + * of the IDT synchronization management unit drivers
> + */
> +extern int rsmu_write(struct device *dev, u16 reg, u8 *buf, u16 size);
> +extern int rsmu_read(struct device *dev, u16 reg, u8 *buf, u16 size);

I think you can remove them.  Use Regmap instead.

> +#endif /*  __LINUX_MFD_RSMU_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
