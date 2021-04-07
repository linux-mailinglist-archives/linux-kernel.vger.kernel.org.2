Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53653356835
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhDGJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhDGJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:39:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B8C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:38:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so26538845ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2bcZ5SRG8Kcn+cR/yk5uRPv4IWzyomsGoAUXDtBC+gI=;
        b=I/+hvJ5+2ZdvzQVOvAwzfo52wZWdrwaMPZpwCReHxZ64d01LMaLKZiiGPpfr2jnFRr
         6xA5PZo9Gi8tDzbFHjwRzrrYqaUHx715yE3TmnHn8OMX1yuE1hcRrq6RZB4NDqqalmn3
         18GlLIXdndpX2e7AGXmXBMBxOYIaQzZ2N0oDVbyB9lm1rG8kCkxuLVcILnJHZmBqLu1i
         0C3TtxQPQHwD6Ym/LEnHFn3yIRGccbFXe6I9LuWIu/kD2yNhG48Si2fJg260PpbhsuSw
         UPp3czfkQRrsoklgVzTIsYosxOvSV6Dz/F59VERgzdnF52hjDtzWe9vUjTnLNVsShczo
         JBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2bcZ5SRG8Kcn+cR/yk5uRPv4IWzyomsGoAUXDtBC+gI=;
        b=nAKQvp9kVOTyVKRhToZzWcc3IPfcNDykNlSmX5km6mJo4HLH7GBKDNIHHjMqk6QpW7
         lQLWhWAkfq3UPX/zmx0M7OqNtzycLiZyyQktsn4l7C4WmeszmrQIKq7uLCwxGL1sakNR
         PVi6U+EuvrDp6j0u/cYlWQz4JnSpE/xL0k9GFwJ5YRefo8akeyLy1PPlVqXTB1kuou2R
         UZhSSW4ZKR5rP4tPNAP3+rucQbcRYKcngLAr2yeKbJOiAOLkVeoNEq1SgWrDWgaxb86Q
         /4g9QPB3aulvMEYyb9+16t6vAQ09sp86Nhc8cI61UhA2L32NVDW5kWfZubgkZ+4HAvXt
         ZecQ==
X-Gm-Message-State: AOAM5305nUSVY7ADfJtQiYrWamYUXKKiPzVIhubyMTdaOylCRz/3GSJI
        7HeknTpWsePaHdy0KR/8XYiBTg==
X-Google-Smtp-Source: ABdhPJx+1WYiGshLbOjjzDl1lLL4Nf3y7uWgv+NriZimKs/kdPUBao8cH6wampvqgo3rB63lgj+lUg==
X-Received: by 2002:a17:907:213a:: with SMTP id qo26mr2630506ejb.547.1617788322620;
        Wed, 07 Apr 2021 02:38:42 -0700 (PDT)
Received: from dell ([91.110.221.225])
        by smtp.gmail.com with ESMTPSA id d8sm7599021edy.83.2021.04.07.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:38:42 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:38:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 (RESEND) 4/7] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210407093840.GZ2916463@dell>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
 <de3603a366c172923771d3f01aa83b70cbba2199.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de3603a366c172923771d3f01aa83b70cbba2199.1616695231.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021, Mauro Carvalho Chehab wrote:

> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 135 ++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  16 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 297 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  18 --
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 297 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 135 --------
>  9 files changed, 456 insertions(+), 451 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml

[...]

> +config MFD_HI6421_SPMI
> +	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
> +	depends on OF
> +	depends on SPMI
> +	select MFD_CORE
> +	select REGMAP_SPMI
> +	help
> +	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
> +	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
> +	  etc.
> +
> +	  This driver includes core APIs _only_. You have to select
> +	  individual components like voltage regulators under corresponding
> +	  menus in order to enable them.
> +	  We communicate with the Hi6421v600 via a SPMI bus.
> +
>  config MFD_HI655X_PMIC
>  	tristate "HiSilicon Hi655X series PMU/Codec IC"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8a5f76..e87230fc61ac 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -232,6 +232,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
>  obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
>  obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
> +obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
> new file mode 100644
> index 000000000000..626140cb96f2
> --- /dev/null
> +++ b/drivers/mfd/hi6421-spmi-pmic.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in HISI PMIC IC
> + *
> + * Copyright (c) 2013 Linaro Ltd.
> + * Copyright (c) 2011 Hisilicon.
> + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/hi6421-spmi-pmic.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spmi.h>
> +
> +enum hi6421_spmi_pmic_irq_list {
> +	OTMP = 0,
> +	VBUS_CONNECT,
> +	VBUS_DISCONNECT,
> +	ALARMON_R,
> +	HOLD_6S,
> +	HOLD_1S,
> +	POWERKEY_UP,
> +	POWERKEY_DOWN,
> +	OCP_SCP_R,
> +	COUL_R,
> +	SIM0_HPD_R,
> +	SIM0_HPD_F,
> +	SIM1_HPD_R,
> +	SIM1_HPD_F,
> +	PMIC_IRQ_LIST_MAX,
> +};
> +
> +#define HISI_IRQ_ARRAY			2
> +#define HISI_IRQ_NUM			(HISI_IRQ_ARRAY * 8)

What's 8?

This is also misleading, since there are only 14 IRQs.

> +#define HISI_IRQ_KEY_NUM		0

What's this please?

> +#define HISI_BITS			8

This is not great nomenclature.

What do the 'bits' represent?

> +#define HISI_IRQ_KEY_VALUE		(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))

This should probably be with the other HISI_IRQ_KEY* variable.

Along with a short comment on what an IRQ_KEY is.

> +#define HISI_MASK			GENMASK(HISI_BITS - 1, 0)

Pair this with HISI_BITS and explain what there are 8 of.

> +/*
> + * The IRQs are mapped as:
> + *
> + *	======================  =============   ============	=====
> + *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
> + *	======================  =============   ============	=====
> + *	OTMP			0x0202		0x212		bit 0
> + *	VBUS_CONNECT		0x0202		0x212		bit 1
> + *	VBUS_DISCONNECT		0x0202		0x212		bit 2
> + *	ALARMON_R		0x0202		0x212		bit 3
> + *	HOLD_6S			0x0202		0x212		bit 4
> + *	HOLD_1S			0x0202		0x212		bit 5
> + *	POWERKEY_UP		0x0202		0x212		bit 6
> + *	POWERKEY_DOWN		0x0202		0x212		bit 7
> + *
> + *	OCP_SCP_R		0x0203		0x213		bit 0
> + *	COUL_R			0x0203		0x213		bit 1
> + *	SIM0_HPD_R		0x0203		0x213		bit 2
> + *	SIM0_HPD_F		0x0203		0x213		bit 3
> + *	SIM1_HPD_R		0x0203		0x213		bit 4
> + *	SIM1_HPD_F		0x0203		0x213		bit 5
> + *	======================  =============   ============	=====
> + */
> +#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
> +#define SOC_PMIC_IRQ0_ADDR		0x0212

Does IRQ handling not have a base?

If so, would it be worth passing the base to Regmap, instead of
mapping a large, mostly unused area?

> +#define IRQ_MASK_REGISTER(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
> +					 (irqd_to_hwirq(irq_data) >> 3))

What's 3?

The naming of this macro makes it looks generic.

Please add some namespacing to clarify.

> +#define IRQ_MASK_BIT(irq_data)		BIT(irqd_to_hwirq(irq_data) & 0x07)

More undocumented masks and bits.

> +static const struct mfd_cell hi6421v600_devs[] = {
> +	{ .name = "hi6421v600-regulator", },
> +};

Where are the rest of the devices?

> +static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
> +{
> +	struct hi6421_spmi_pmic *ddata = (struct hi6421_spmi_pmic *)priv;
> +	unsigned long pending;
> +	unsigned int in;
> +	int i, offset;
> +
> +	for (i = 0; i < HISI_IRQ_ARRAY; i++) {

This is odd nomenclature.

Do these have another name in the datasheet?  Bank maybe?

> +		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
> +		pending = HISI_MASK & in;
> +		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, pending);

Unmasking for some reason?  Comment please.

> +		if (i == HISI_IRQ_KEY_NUM &&
> +		    (pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE) {
> +			generic_handle_irq(ddata->irqs[POWERKEY_DOWN]);

Okay, so 'KEY' is actually 'POWERKEY'.

This should be made clear sooner.

> +			generic_handle_irq(ddata->irqs[POWERKEY_UP]);
> +			pending &= (~HISI_IRQ_KEY_VALUE);
> +		}

Please document what's happening here.

> +		if (!pending)
> +			continue;
> +
> +		for_each_set_bit(offset, &pending, HISI_BITS)
> +			generic_handle_irq(ddata->irqs[offset + i * HISI_BITS]);

Bracketing?

Comments throughout would make this easier to follow.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void hi6421_spmi_irq_mask(struct irq_data *d)
> +{
> +	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
> +	unsigned long flags;
> +	unsigned int data;
> +	u32 offset;
> +
> +	offset = IRQ_MASK_REGISTER(d);
> +
> +	spin_lock_irqsave(&ddata->lock, flags);
> +
> +	regmap_read(ddata->regmap, offset, &data);
> +	data |= IRQ_MASK_BIT(d);
> +	regmap_write(ddata->regmap, offset, data);
> +
> +	spin_unlock_irqrestore(&ddata->lock, flags);
> +}
> +
> +static void hi6421_spmi_irq_unmask(struct irq_data *d)
> +{
> +	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
> +	u32 data, offset;
> +	unsigned long flags;
> +
> +	offset = (irqd_to_hwirq(d) >> 3);
> +	offset += SOC_PMIC_IRQ_MASK_0_ADDR;

IRQ_MASK_REGISTER() ?

> +	spin_lock_irqsave(&ddata->lock, flags);
> +
> +	regmap_read(ddata->regmap, offset, &data);
> +	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));

BIT()?

What does the 0x07 mask represent?

> +	regmap_write(ddata->regmap, offset, data);
> +
> +	spin_unlock_irqrestore(&ddata->lock, flags);
> +}
> +
> +static struct irq_chip hi6421_spmi_pmu_irqchip = {
> +	.name		= "hisi-irq",

<vendor>-irq is very generic.

Can we be more specific?

> +	.irq_mask	= hi6421_spmi_irq_mask,
> +	.irq_unmask	= hi6421_spmi_irq_unmask,
> +	.irq_disable	= hi6421_spmi_irq_mask,
> +	.irq_enable	= hi6421_spmi_irq_unmask,
> +};
> +
> +static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
> +			       irq_hw_number_t hw)
> +{
> +	struct hi6421_spmi_pmic *ddata = d->host_data;
> +
> +	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
> +				      handle_simple_irq, "hisi");

<vendor> is very generic.

> +	irq_set_chip_data(virq, ddata);
> +	irq_set_irq_type(virq, IRQ_TYPE_NONE);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops hi6421_spmi_domain_ops = {
> +	.map	= hi6421_spmi_irq_map,
> +	.xlate	= irq_domain_xlate_twocell,
> +};
> +
> +static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
> +{
> +	int i;
> +	unsigned int pending;
> +
> +	for (i = 0; i < HISI_IRQ_ARRAY; i++)
> +		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
> +			     HISI_MASK);
> +
> +	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
> +		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
> +		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i,
> +			     HISI_MASK);
> +	}

Comments please?

Why do these loops need to be separate?

> +}
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits		= 16,
> +	.val_bits		= HISI_BITS,
> +	.max_register		= 0xffff,

Do you need to map from 0 to 0xffff?

> +	.fast_io		= true
> +};
> +
> +static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct hi6421_spmi_pmic *ddata;
> +	unsigned int virq;
> +	int ret, i;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
> +	if (IS_ERR(ddata->regmap))
> +		return PTR_ERR(ddata->regmap);
> +
> +	spin_lock_init(&ddata->lock);
> +
> +	ddata->dev = dev;
> +
> +	ddata->gpio = of_get_gpio(np, 0);
> +	if (ddata->gpio < 0)
> +		return ddata->gpio;
> +
> +	if (!gpio_is_valid(ddata->gpio))
> +		return -EINVAL;
> +
> +	ret = devm_gpio_request_one(dev, ddata->gpio, GPIOF_IN, "pmic");
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request gpio%d\n", ddata->gpio);
> +		return ret;
> +	}
> +
> +	ddata->irq = gpio_to_irq(ddata->gpio);
> +
> +	hi6421_spmi_pmic_irq_init(ddata);
> +
> +	ddata->irqs = devm_kzalloc(dev, HISI_IRQ_NUM * sizeof(int), GFP_KERNEL);
> +	if (!ddata->irqs)
> +		return -ENOMEM;
> +
> +	ddata->domain = irq_domain_add_simple(np, HISI_IRQ_NUM, 0,
> +					      &hi6421_spmi_domain_ops, ddata);
> +	if (!ddata->domain) {
> +		dev_err(dev, "Failed to create IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < HISI_IRQ_NUM; i++) {
> +		virq = irq_create_mapping(ddata->domain, i);

What happens when this requests IRQ 15 and 16?

> +		if (!virq) {
> +			dev_err(dev, "Failed to map H/W IRQ\n");
> +			return -ENOSPC;
> +		}
> +		ddata->irqs[i] = virq;
> +	}
> +
> +	ret = request_threaded_irq(ddata->irq, hi6421_spmi_irq_handler, NULL,
> +				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
> +				   "pmic", ddata);

Is this the only 'pmic' on the platform?

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
> +			ret);

Does checkpatch complain if this is just one long line?

> +		return ret;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, ddata);
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
> +				   NULL, 0, NULL);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to add child devices: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
> +{
> +	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
> +
> +	free_irq(ddata->irq, ddata);
> +}
> +
> +static const struct of_device_id pmic_spmi_id_table[] = {
> +	{ .compatible = "hisilicon,hi6421-spmi" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
> +
> +static struct spmi_driver hi6421_spmi_pmic_driver = {
> +	.driver = {
> +		.name	= "hi6421-spmi-pmic",

Odd spacing.  Does this line up with the other '='?

> +		.of_match_table = pmic_spmi_id_table,
> +	},
> +	.probe	= hi6421_spmi_pmic_probe,
> +	.remove	= hi6421_spmi_pmic_remove,
> +};
> +module_spmi_driver(hi6421_spmi_pmic_driver);
> +
> +MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
