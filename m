Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA4388902
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhESIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbhESIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:09:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9936FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:08:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so12960821wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/uzbHGH36Xwmci6yH8rdorfIZ5ku79GCSY2rNR5MzZI=;
        b=SYhMe3/GyH3NNKXGH0Gd0MFoO+eueDbMwNKPrnlhNu6YNApqWoK5o3FqObBBaOx3zf
         sKWw5r0VrbRK2C/MQpc6VHyYXucbE8IImpF/Z2GPNM50KN8YX3JL4ZiAVRhLXwu3rYgD
         DY+1E2bbW9H63sVBOHQMHMBwREaCSdiS5TQXfPYVJQQHCOerOrLsx6U1Qbh/nlx0XYho
         4rLobUwGzkNX0a12tbwokmdPt4CcvgRfuqdA+cbk9H4HFexPdIWQX/s/KSlWZ6KHrBrT
         VOUVW9dFY446QHVRZXUig5LVXlQDmdu0D4pEW11PBw+DLrFwe94J/WQINjRAPGArwxyg
         Bcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/uzbHGH36Xwmci6yH8rdorfIZ5ku79GCSY2rNR5MzZI=;
        b=MEwlEaeCiBfU9iGewiHbjx7nLTN1+AFO6gUvnd3kLK82f4eU3tKIoPJVdYjTmECgnl
         5QkoMMlQlHioxb8MGQqbiPa3ziCsXzj6rbnT/4WRhxq27PVdNLmJ0pfKbz5OviYq/eMI
         815IZl6kWGxO8dRLv2ZBN5r4y6h2qJEVIYW3yAv9LM6nYKZw67D8PXTiDAw+Wbyx5Meh
         KCU20d3BF+bzR0YYHhWgvDaS7Pd5OzAzsoCXpy/2ZQGgsJp34uBchtMdx4vjalpai11A
         Qh7tXRJu+OAQPOUKsxon+OEQze/ABoWyYQtmOsO85fvTXxinycyTvUev9czQ/qv1VJvB
         Fh7Q==
X-Gm-Message-State: AOAM532epwygkz8eaI0t1Lg+ZHT/kbgPeVSWQqCeVHouiigYlOI6+OB2
        aSQ3IJkUJypRTDcOLPp5QNMOAw0Y4t2oeA==
X-Google-Smtp-Source: ABdhPJxnjeijKWqymw552LGjuzaYr7aS8z1qdIxUPbut8k64iYIJ/QTich+p0zOvwIFn58d65R8buA==
X-Received: by 2002:a5d:64c6:: with SMTP id f6mr13161348wri.18.1621411690020;
        Wed, 19 May 2021 01:08:10 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id u19sm450427wmq.7.2021.05.19.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:08:09 -0700 (PDT)
Date:   Wed, 19 May 2021 09:08:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     sameo@linux.intel.com, grant.likely@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210519080807.GH805368@dell>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021, min.li.xe@renesas.com wrote:

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
>  drivers/mfd/Kconfig              |  28 ++
>  drivers/mfd/Makefile             |   3 +
>  drivers/mfd/rsmu_i2c.c           | 349 +++++++++++++++++
>  drivers/mfd/rsmu_private.h       |  32 ++
>  drivers/mfd/rsmu_spi.c           | 376 ++++++++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 116 ++++++
>  include/linux/mfd/idt8a340_reg.h | 817 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  54 +++
>  8 files changed, 1775 insertions(+)
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_private.h
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 21a131d..63b18b3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2172,5 +2172,33 @@ config MFD_INTEL_M10_BMC
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_RSMU_I2C
> +	tristate "Renesas Synchronization Management Unit with I2C"
> +	depends on I2C && OF
> +	depends on MFD_RSMU_SPI=n

Not sure I've seen a relationship like this before.

Devices capable of SPI and I2C usually have a core driver which
selects one or the other.  It will also save some code duplication you
have here.  Please take a look at some other examples in the MFD
subsystem.

> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support for the Renesas synchronization management unit, such as

As this is the name of the thing, it should be capitalised.

> +	  Clockmatrix and 82P33XXX series. This option supports I2C as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device,

Nit: This should be a '.'

> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
> +config MFD_RSMU_SPI
> +	tristate "Renesas Synchronization Management Unit with SPI"
> +	depends on SPI && OF
> +	select MFD_CORE
> +	help
> +	  Support for the Renesas synchronization management unit, such as

As above.

> +	  Clockmatrix and 82P33XXX series. This option supports SPI as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device,

As above.

> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8..4ab32ef 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -271,3 +271,6 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> +
> +obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o
> +obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> new file mode 100644
> index 0000000..2349f6d
> --- /dev/null
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Multi-function driver for the IDT ClockMatrix(TM) and 82P33xxx families of

No such thing as a "Multi-function driver".  That is a Linux
implementation detail.  Please describe the device instead.

> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.

This is 2 years out of date.

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

'\n'

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
> +static bool rsmu_cm_volatile_reg(struct device *dev, unsigned int reg);
> +static bool rsmu_sabre_volatile_reg(struct device *dev, unsigned int reg);

No forward declarations please.

Better to reorder the functions themselves.

> +/* Current mfd device index */
> +static atomic_t rsmu_ndevs = ATOMIC_INIT(0);

Counting/indexing this way is generally not good/required.

> +/* Platform data */
> +static struct rsmu_pdata rsmu_pdata[RSMU_MAX_MFD_DEV];

Please create this dynamically using the *alloc() helpers.

> +/* clockmatrix phc devices */

Improve the naming, then these comments become redundant.

> +static struct mfd_cell rsmu_cm_pdev[RSMU_MAX_MFD_DEV] = {

If you're populating, you don't need to specify a size.

> +	[0] = {

If you need to index these, you should do it with defines.

> +		.name = "idtcm-ptp0",

That's terrible nomenclature.

What is an 'idtcm-ptp'?

> +		.of_compatible	= "renesas,idtcm-ptp0",

We don't usually allow device indexing in device tree.

Compatibles for the same device are usually identical.

> +	},
> +	[1] = {
> +		.name = "idtcm-ptp1",
> +		.of_compatible	= "renesas,idtcm-ptp1",
> +	},
> +	[2] = {
> +		.name = "idtcm-ptp2",
> +		.of_compatible	= "renesas,idtcm-ptp2",
> +	},
> +	[3] = {
> +		.name = "idtcm-ptp3",
> +		.of_compatible	= "renesas,idtcm-ptp3",
> +	},
> +};
> +
> +/* sabre phc devices */
> +static struct mfd_cell rsmu_sabre_pdev[RSMU_MAX_MFD_DEV] = {
> +	[0] = {
> +		.name = "idt82p33-ptp0",
> +		.of_compatible	= "renesas,idt82p33-ptp0",
> +	},
> +	[1] = {
> +		.name = "idt82p33-ptp1",
> +		.of_compatible	= "renesas,idt82p33-ptp1",
> +	},
> +	[2] = {
> +		.name = "idt82p33-ptp2",
> +		.of_compatible	= "renesas,idt82p33-ptp2",
> +	},
> +	[3] = {
> +		.name = "idt82p33-ptp3",
> +		.of_compatible	= "renesas,idt82p33-ptp3",
> +	},
> +};

As above.

> +/* rsmu character devices */
> +static struct mfd_cell rsmu_cdev[RSMU_MAX_MFD_DEV] = {
> +	[0] = {
> +		.name = "rsmu-cdev0",
> +		.of_compatible	= "renesas,rsmu-cdev0",
> +	},
> +	[1] = {
> +		.name = "rsmu-cdev1",
> +		.of_compatible	= "renesas,rsmu-cdev1",
> +	},
> +	[2] = {
> +		.name = "rsmu-cdev2",
> +		.of_compatible	= "renesas,rsmu-cdev2",
> +	},
> +	[3] = {
> +		.name = "rsmu-cdev3",
> +		.of_compatible	= "renesas,rsmu-cdev3",
> +	},
> +};

As above.

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
> +static const struct regmap_config rsmu_regmap_configs[] = {
> +	[RSMU_CM] = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0xD000,
> +		.ranges = rsmu_cm_range_cfg,
> +		.num_ranges = ARRAY_SIZE(rsmu_cm_range_cfg),
> +		.volatile_reg = rsmu_cm_volatile_reg,
> +		.cache_type = REGCACHE_RBTREE,
> +		.can_multi_write = true,
> +	},
> +	[RSMU_SABRE] = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x400,
> +		.ranges = rsmu_sabre_range_cfg,
> +		.num_ranges = ARRAY_SIZE(rsmu_sabre_range_cfg),
> +		.volatile_reg = rsmu_sabre_volatile_reg,
> +		.cache_type = REGCACHE_RBTREE,
> +		.can_multi_write = true,
> +	},
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
> +
> +static int rsmu_mfd_init(struct rsmu_dev *rsmu, struct mfd_cell *mfd,
> +			 struct rsmu_pdata *pdata)

This is not an init function

> +{
> +	int ret;
> +
> +	mfd->platform_data = pdata;
> +	mfd->pdata_size = sizeof(struct rsmu_pdata);
> +
> +	ret = mfd_add_devices(rsmu->dev, -1, mfd, 1, NULL, 0, NULL);
> +	if (ret < 0) {
> +		dev_err(rsmu->dev, "mfd_add_devices failed with %s\n",
> +			mfd->name);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int rsmu_dev_init(struct rsmu_dev *rsmu)
> +{
> +	struct rsmu_pdata *pdata;
> +	struct mfd_cell *pmfd;
> +	struct mfd_cell *cmfd;
> +	int ret;
> +
> +	/* Initialize regmap */

This is superfluous.

> +	rsmu->regmap = devm_regmap_init_i2c(rsmu->client,
> +					    &rsmu_regmap_configs[rsmu->type]);
> +	if (IS_ERR(rsmu->regmap)) {
> +		ret = PTR_ERR(rsmu->regmap);
> +		dev_err(rsmu->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Initialize device index */
> +	rsmu->index = atomic_read(&rsmu_ndevs);
> +	if (rsmu->index >= RSMU_MAX_MFD_DEV)
> +		return -ENODEV;
> +
> +	/* Initialize platform data */
> +	pdata = &rsmu_pdata[rsmu->index];
> +	pdata->lock = &rsmu->lock;

What is this protecting?  Regmap will have it's own locking.

> +	pdata->type = rsmu->type;

What does the child use this for?

> +	pdata->index = rsmu->index;

What does the child use this for?

> +	/* Initialize MFD devices */
> +	cmfd = &rsmu_cdev[rsmu->index];
> +	if (rsmu->type == RSMU_CM)
> +		pmfd = &rsmu_cm_pdev[rsmu->index];
> +	else if (rsmu->type == RSMU_SABRE)
> +		pmfd = &rsmu_sabre_pdev[rsmu->index];
> +	else
> +		return -EINVAL;
> +
> +	ret = rsmu_mfd_init(rsmu, pmfd, pdata);
> +	if (ret)
> +		return ret;
> +
> +	ret = rsmu_mfd_init(rsmu, cmfd, pdata);
> +	if (ret)
> +		return ret;

The code would be much clearer and readable if you just called
mfd_add_device() twice here instead.  Breaking it out only serves to
obfuscate what you're trying to achieve here.

> +	atomic_inc(&rsmu_ndevs);
> +	return 0;
> +}
> +
> +static int rsmu_dt_init(struct rsmu_dev *rsmu)

This isn't initialising anything.

This should probably be called rsmu_dev_type_get()

Better still, move the type into the table's .data. (see below).

> +{
> +	struct device_node *np = rsmu->dev->of_node;
> +
> +	rsmu->type = RSMU_NONE;
> +	if (of_device_is_compatible(np, "idt,8a34000")) {

I'd give these a secondary, more forthcoming, compatible string.

One which is less, well, like this!

> +		rsmu->type = RSMU_CM;
> +	} else if (of_device_is_compatible(np, "idt,82p33810")) {
> +		rsmu->type = RSMU_SABRE;
> +	} else {
> +		dev_err(rsmu->dev, "unknown RSMU device\n");

"Unknown RSMU device type"

> +		return -EINVAL;

Not sure this is even possible, but should probably be -ENODEV.

> +	}
> +
> +	return 0;
> +}
> +
> +static int rsmu_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct rsmu_dev *rsmu;
> +	int ret;
> +
> +	rsmu = devm_kzalloc(&client->dev, sizeof(struct rsmu_dev),
> +			       GFP_KERNEL);
> +	if (rsmu == NULL)

if (!rsmu)

> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, rsmu);
> +	mutex_init(&rsmu->lock);
> +	rsmu->dev = &client->dev;
> +	rsmu->client = client;
> +
> +	ret = rsmu_dt_init(rsmu);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&rsmu->lock);

Pretty sure you don't need mutexes in .probe()

> +	ret = rsmu_dev_init(rsmu);
> +	mutex_unlock(&rsmu->lock);
> +
> +	if (ret == 0)
> +		dev_info(rsmu->dev, "Probe %s successful\n",
> +			 rsmu_name(rsmu->type));

No thank you.  Please remove this.

> +	return ret;
> +}
> +
> +static int rsmu_remove(struct i2c_client *client)
> +{
> +	struct rsmu_dev *rsmu = i2c_get_clientdata(client);
> +
> +	mfd_remove_devices(&client->dev);

Use devm_*()

> +	mutex_destroy(&rsmu->lock);

Don't mutexes are required in this driver.

> +	atomic_dec(&rsmu_ndevs);

Nor this.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id rsmu_id[] = {
> +	{ "8a34000", 0 },
> +	{ "82p33810", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rsmu_id);

Use .probe_new, then you can delete this table.

> +static const struct of_device_id rsmu_of_match[] = {
> +	{.compatible = "idt,8a34000", },
> +	{.compatible = "idt,82p33810", },

Missing ' ' after the '{'.

Put the device type in .data instead of matching later on.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_of_match);
> +
> +static struct i2c_driver rsmu_driver = {
> +	.driver = {
> +		   .name = "rsmu-i2c",
> +		   .of_match_table = of_match_ptr(rsmu_of_match),
> +	},
> +	.probe = rsmu_probe,
> +	.remove	= rsmu_remove,
> +	.id_table = rsmu_id,
> +};
> +
> +static int __init rsmu_init(void)
> +{
> +	return i2c_add_driver(&rsmu_driver);
> +}
> +/* init early so consumer devices can complete system boot */
> +subsys_initcall(rsmu_init);
> +
> +static void __exit rsmu_exit(void)
> +{
> +	i2c_del_driver(&rsmu_driver);
> +}
> +module_exit(rsmu_exit);
> +
> +MODULE_DESCRIPTION("Renesas SMU I2C multi-function driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/rsmu_private.h b/drivers/mfd/rsmu_private.h
> new file mode 100644
> index 0000000..8841a24
> --- /dev/null
> +++ b/drivers/mfd/rsmu_private.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Multi-function driver for the IDT ClockMatrix(TM) and 82p33xxx families of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +
> +#ifndef __RSMU_MFD_PRIVATE_H
> +#define __RSMU_MFD_PRIVATE_H
> +
> +#include <linux/mfd/rsmu.h>
> +
> +/* Maximum number of mfd devices */
> +#define RSMU_MAX_MFD_DEV		4
> +
> +struct rsmu_dev {
> +	struct device *dev;
> +	void *client;

What is in client?

> +	struct regmap *regmap;

> +	struct mutex lock;
> +	enum rsmu_type type;

Why are these in 'dev' and 'pdata'?

> +	u8 index;
> +	u16 page;

Seems odd to pass this in as ddata.

> +};
> +
> +enum rsmu_mfd_type {
> +	RSMU_MFD_PTP		= 0,
> +	RSMU_MFD_CDEV		= 1,
> +	RSMU_MFD_NUM		= 2,
> +};
> +#endif /*  __LINUX_MFD_RSMU_H */
> diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c

Stopping here, as most of this is duplicated.

Please create a core driver instead.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
