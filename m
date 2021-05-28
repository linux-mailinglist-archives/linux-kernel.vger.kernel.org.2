Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E726394045
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhE1JtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:49:10 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42985 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1JtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:49:05 -0400
Received: by mail-lj1-f179.google.com with SMTP id t17so4460317ljd.9;
        Fri, 28 May 2021 02:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=HMAlHDj4ePTErDvM0hFu599gQzGsMX29bYVJGj9PGdM=;
        b=Laq4JkvrZCno6ttZFurPp/sMRnCi+XCn+Co/zWfeGqG22rPZkmHgnIY7KB0qplbfBu
         PO76cUEZKbxvpD0tRZLfPa07b5h2KFvY9OBm5ZbBI+cGhRydHUwsWjLNCotKr3xSBO0R
         xIecoVG/SrJrlhzpz7NtUY8Wl4DMGlXfIkETtBFyfvs5enLfbniNBWiq5NtzSpTIWW/h
         Rs8onupya47KKTAKJkj04uqwOs00a3jWdaDr2nqWE5aDvbiB/aTlcdcQyXSyikf3ACa6
         YbEUts7kcEn0KuVEu8y5etxF8WgEpElss6/O5jWVvaagfYpdDEIuwPCv3mVJrkH2VZZG
         EUfw==
X-Gm-Message-State: AOAM531awqMW757t2MMbeovNdZDW3kkdNtTQ2jKEQ7AOZLXWezNWMjeq
        8o8DhMuEzUdrNfUMbEBFoG4=
X-Google-Smtp-Source: ABdhPJx5UI8BwO677/8LjhpF0F1mlGB1lMmMD33y+3ZEJAqXXoXKW4yZWqVVYq6GlYepitZ3nmUSGA==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr5692054lje.167.1622195248496;
        Fri, 28 May 2021 02:47:28 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id e17sm507442ljl.73.2021.05.28.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:47:28 -0700 (PDT)
Message-ID: <62cdd2d18839e16686f35f0cf08080e2cb3b1768.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v5 3/3] power: supply: mt6360_charger: add MT6360
 charger support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        matthias.bgg@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
In-Reply-To: <20210528081300.64759-4-gene.chen.richtek@gmail.com>
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
         <20210528081300.64759-4-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 28 May 2021 12:47:21 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2021-05-28 at 16:13 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add basic support for the battery charger for MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/mt6360_charger.c | 856
> ++++++++++++++++++++++++++
>  3 files changed, 868 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
> 
> diff --git a/drivers/power/supply/Kconfig
> b/drivers/power/supply/Kconfig
> index e696364126f1..3257b1ad5e36 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -577,6 +577,17 @@ config CHARGER_MP2629
>  	  Battery charger. This driver provides Battery charger power
> management
>  	  functions on the systems.
>  
> +config CHARGER_MT6360
> +	tristate "Mediatek MT6360 Charger Driver"
> +	depends on MFD_MT6360
> +	depends on REGULATOR
> +	select LINEAR_RANGES
> +	help
> +	  Say Y here to enable MT6360 Charger Part.
> +	  The device supports High-Accuracy Voltage/Current Regulation,
> +	  Average Input Current Regulation, Battery Tempature Sensing,
> +	  Over-Temperature Protection, DPDM Detection for BC1.2
> +
>  config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile
> b/drivers/power/supply/Makefile
> index a7309a3d1a47..5317fe787149 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_CHARGER_MAX77693)	+=
> max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
> +obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
> diff --git a/drivers/power/supply/mt6360_charger.c
> b/drivers/power/supply/mt6360_charger.c
> new file mode 100644
> index 000000000000..07fa0b3870e0
> --- /dev/null
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -0,0 +1,856 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/linear_range.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +
> +#define MT6360_PMU_CHG_CTRL1	0x311
> +#define MT6360_PMU_CHG_CTRL2	0x312
> +#define MT6360_PMU_CHG_CTRL3	0x313
> +#define MT6360_PMU_CHG_CTRL4	0x314
> +#define MT6360_PMU_CHG_CTRL5	0x315
> +#define MT6360_PMU_CHG_CTRL6	0x316
> +#define MT6360_PMU_CHG_CTRL7	0x317
> +#define MT6360_PMU_CHG_CTRL8	0x318
> +#define MT6360_PMU_CHG_CTRL9	0x319
> +#define MT6360_PMU_CHG_CTRL10	0x31A
> +#define MT6360_PMU_DEVICE_TYPE	0x322
> +#define MT6360_PMU_USB_STATUS1	0x327
> +#define MT6360_PMU_CHG_STAT	0x34A
> +#define MT6360_PMU_CHG_CTRL19	0x361
> +#define MT6360_PMU_FOD_STAT	0x3E7
> +
> +/* MT6360_PMU_CHG_CTRL1 */
> +#define MT6360_FSLP_SHFT	(3)
> +#define MT6360_FSLP_MASK	BIT(MT6360_FSLP_SHFT)
> +#define MT6360_OPA_MODE_SHFT	(0)
> +#define MT6360_OPA_MODE_MASK	BIT(MT6360_OPA_MODE_SHFT)
> +/* MT6360_PMU_CHG_CTRL2 */
> +#define MT6360_IINLMTSEL_SHFT	(2)
> +#define MT6360_IINLMTSEL_MASK	GENMASK(3, 2)
> +/* MT6360_PMU_CHG_CTRL3 */
> +#define MT6360_IAICR_SHFT	(2)
> +#define MT6360_IAICR_MASK	GENMASK(7, 2)
> +#define MT6360_ILIM_EN_MASK	BIT(0)
> +/* MT6360_PMU_CHG_CTRL4 */
> +#define MT6360_VOREG_SHFT	(1)
> +#define MT6360_VOREG_MASK	GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL5 */
> +#define MT6360_VOBST_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL6 */
> +#define MT6360_VMIVR_SHFT      (1)
> +#define MT6360_VMIVR_MASK      GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL7 */
> +#define MT6360_ICHG_SHFT	(2)
> +#define MT6360_ICHG_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL8 */
> +#define MT6360_IPREC_SHFT	(0)
> +#define MT6360_IPREC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL9 */
> +#define MT6360_IEOC_SHFT	(4)
> +#define MT6360_IEOC_MASK	GENMASK(7, 4)
> +/* MT6360_PMU_CHG_CTRL10 */
> +#define MT6360_OTG_OC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_DEVICE_TYPE */
> +#define MT6360_USBCHGEN_MASK	BIT(7)
> +/* MT6360_PMU_USB_STATUS1 */
> +#define MT6360_USB_STATUS_SHFT	(4)
> +#define MT6360_USB_STATUS_MASK	GENMASK(6, 4)
> +/* MT6360_PMU_CHG_STAT */
> +#define MT6360_CHG_STAT_SHFT	(6)
> +#define MT6360_CHG_STAT_MASK	GENMASK(7, 6)
> +#define MT6360_VBAT_LVL_MASK	BIT(5)
> +/* MT6360_PMU_CHG_CTRL19 */
> +#define MT6360_VINOVP_SHFT	(5)
> +#define MT6360_VINOVP_MASK	GENMASK(6, 5)
> +/* MT6360_PMU_FOD_STAT */
> +#define MT6360_CHRDET_EXT_MASK	BIT(4)
> +
> +enum {
> +	MT6360_RANGE_VMIVR,
> +	MT6360_RANGE_ICHG,
> +	MT6360_RANGE_VOREG,
> +	MT6360_RANGE_AICR,
> +	MT6360_RANGE_IPREC,
> +	MT6360_RANGE_IEOC,
> +	MT6360_RANGE_MAX,
> +};
> +
> +#define MT6360_LINEAR_RANGE(idx, _min, _min_sel, _max_sel, _step)	
> \
> +	[idx] = {							\
> +		.min = _min,						
> \
> +		.min_sel = _min_sel,					
> \
> +		.max_sel = _max_sel,					
> \
> +		.step = _step,						
> \
> +	}
> 

Do you think REGULATOR_LINEAR_RANGE() would fit this? Or is the naming
a problem there? (Just a minor thing, no need to re-spin for this)

//snip

> +static int mt6360_charger_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci;
> +	struct power_supply_config charger_cfg = {};
> +	struct regulator_config config = { };
> +	int ret;
> +
> +	mci = devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	mci->dev = &pdev->dev;
> +	mci->vinovp = 6500000;
> +	mutex_init(&mci->chgdet_lock);
> +	platform_set_drvdata(pdev, mci);
> +	INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);

//snip

> +
> +static int mt6360_charger_remove(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci = platform_get_drvdata(pdev);
> +
> +	cancel_work_sync(&mci->chrdet_work);
> +
> +	return 0;
> +}

Just as a note, devm_work_autocancel() should hopefully be included at
next cycle. Then you might be able to drop the .remove().

FWIW:
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Best Regards
	Matti Vaittinen

