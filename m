Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA16F305939
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhA0LHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhA0LGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:06:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:05:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so1169075wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BlnuW33wcZ18mPXthit6DuOlKEWSQeDSxjB9TPtzQUI=;
        b=bMJ6WLM7In8L9bQQfPsAPRbn/Vq346+/QjJ1gNQ7TcbyVVUYDdi7UQrnBsDfqdWoMF
         VuU/1YIGfS63favkNKwL4SJQrPnTdnEvPrSaX4FNtSIT6dYZbGce0PlJKCQmngfCm1fM
         tcYjeRNIkqb53w1fq7GdbdfD8OP31zOGYXv3viYKtkGE9P2+sc5XnN0qxxybr4Ixw26y
         SwX7KFDwkNqc6F3K/O6N8JEj5w9DAtvuxjwm/rluuuKeegfqYGhMstl9fjfrptYG8mEl
         P7AlGqveqWquNBd1bq6V/RqhFBK9rSAfGjph4ccxzLRvekJoz37bMOQRr2mNQ7AP+qfx
         dmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BlnuW33wcZ18mPXthit6DuOlKEWSQeDSxjB9TPtzQUI=;
        b=FSrihD8zcOBk2kF/bRdfR0lUv79AizceyG5lngstFFugJvELPDMae/uVh/0um4VAh6
         PNwc2MsxmX+oqzS8Lqs6E3zEnHBdM3HZ/a1DbH2qdELOoainKmjP94v4FsJsMSCfD3jL
         JCGot9vCiNATQKLtFmob7VYVoICPxYPXRnTkgBkKaR3FG4lIN0RPJyZNL0+G+lWiLpQf
         Rpsomlh49kGJtieT6sGbl1g9B1mO9VXIcFEihpXbsnhHwC2LAfbjWlZUdhvy2SNE9VnK
         Sx3kxRVUAEnWVn+YVJBseaGK/sgHxrzo4R0WrUO7mxScnnRU+ncJlibU4fmDNqtzgnOp
         x7eA==
X-Gm-Message-State: AOAM532Jzu38eBGdKi4N0xsFjjP5a0C8x0FNKvrNPvkca6PqbqchfZY+
        Hx6fEtI8SxNzi0+dwkCo/TKeaA==
X-Google-Smtp-Source: ABdhPJyipEAIDJ0LMTB5VELdGgUO1pY3nD2R0UCqdZPdpjwvcwTjhoxgRbOPTVICfkr0QLxk7O4Oow==
X-Received: by 2002:a05:600c:2110:: with SMTP id u16mr3775597wml.65.1611745540415;
        Wed, 27 Jan 2021 03:05:40 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id e12sm2414829wrs.67.2021.01.27.03.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:05:39 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:05:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/21] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210127110537.GI4903@dell>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
 <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021, Mauro Carvalho Chehab wrote:

> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 135 +++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  15 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 281 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  16 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 281 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 135 ---------
>  9 files changed, 439 insertions(+), 433 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> new file mode 100644
> index 000000000000..3b23ad56b31a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon 6421v600 SPMI PMIC
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |
> +  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
> +  (SPMI) bus. It provides interrupts and power supply.
> +
> +  The GPIO and interrupt settings are represented as part of the top-level PMIC
> +  node.
> +
> +  The SPMI controller part is provided by
> +  drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml.
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]"
> +
> +  compatible:
> +    const: hisilicon,hi6421v600-spmi
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupt-controller:
> +    description:
> +      Identify that the PMIC is capable of behaving as an interrupt controller.
> +
> +  gpios:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^ldo[0-9]+@[0-9a-f]$':
> +        type: object
> +
> +        $ref: "/schemas/regulator/regulator.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* pmic properties */
> +
> +    pmic: pmic@0 {
> +      compatible = "hisilicon,hi6421-spmi";
> +      reg = <0 0>;
> +
> +      #interrupt-cells = <2>;
> +      interrupt-controller;
> +      gpios = <&gpio28 0 0>;
> +
> +      regulators {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ldo3: LDO3 {
> +          regulator-name = "ldo3";
> +          regulator-min-microvolt = <1500000>;
> +          regulator-max-microvolt = <2000000>;
> +          regulator-boot-on;
> +        };
> +
> +        ldo4: LDO4 {
> +          regulator-name = "ldo4";
> +          regulator-min-microvolt = <1725000>;
> +          regulator-max-microvolt = <1900000>;
> +          regulator-boot-on;
> +        };
> +
> +        ldo9: LDO9 {
> +          regulator-name = "ldo9";
> +          regulator-min-microvolt = <1750000>;
> +          regulator-max-microvolt = <3300000>;
> +          regulator-boot-on;
> +        };
> +
> +        ldo15: LDO15 {
> +          regulator-name = "ldo15";
> +          regulator-min-microvolt = <1800000>;
> +          regulator-max-microvolt = <3000000>;
> +          regulator-always-on;
> +        };
> +
> +        ldo16: LDO16 {
> +          regulator-name = "ldo16";
> +          regulator-min-microvolt = <1800000>;
> +          regulator-max-microvolt = <3000000>;
> +          regulator-boot-on;
> +        };
> +
> +        ldo17: LDO17 {
> +          regulator-name = "ldo17";
> +          regulator-min-microvolt = <2500000>;
> +          regulator-max-microvolt = <3300000>;
> +        };
> +
> +        ldo33: LDO33 {
> +          regulator-name = "ldo33";
> +          regulator-min-microvolt = <2500000>;
> +          regulator-max-microvolt = <3300000>;
> +          regulator-boot-on;
> +        };
> +
> +        ldo34: LDO34 {
> +          regulator-name = "ldo34";
> +          regulator-min-microvolt = <2600000>;
> +          regulator-max-microvolt = <3300000>;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85e5b6ab57ca..c5b36a58ede5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8006,6 +8006,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
>  F:	drivers/spmi/hisi-spmi-controller.c
>  
> +HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
> +M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> +F:	drivers/mfd/hi6421-spmi-pmic.c
> +
>  HISILICON STAGING DRIVERS FOR HIKEY 960/970
>  M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>  L:	devel@driverdev.osuosl.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13669bf..c04c2f6be1d9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -509,6 +509,21 @@ config MFD_HI6421_PMIC
>  	  menus in order to enable them.
>  	  We communicate with the Hi6421 via memory-mapped I/O.
>  
> +config MFD_HI6421_SPMI
> +	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
> +	depends on OF
> +	depends on SPMI
> +	select MFD_CORE
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
> index 1780019d2474..7744993c42bc 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -233,6 +233,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
>  obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
>  obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
> +obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
> new file mode 100644
> index 000000000000..99c4f3359f71
> --- /dev/null
> +++ b/drivers/mfd/hi6421-spmi-pmic.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Device driver for regulators in HISI PMIC IC
> +//
> +// Copyright (c) 2013 Linaro Ltd.
> +// Copyright (c) 2011 Hisilicon.
> +//

No need for this blank line.

> +// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd

Only the SPDX line as C++ comments please.

'\n' here.

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
> +/* 8-bit register offset in PMIC */
> +#define HISI_MASK_STATE			0xff
> +
> +#define HISI_IRQ_ARRAY			2
> +#define HISI_IRQ_NUM			(HISI_IRQ_ARRAY * 8)
> +
> +#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
> +#define SOC_PMIC_IRQ0_ADDR		0x0212
> +
> +#define HISI_IRQ_KEY_NUM		0
> +#define HISI_IRQ_KEY_VALUE		0xc0
> +#define HISI_IRQ_KEY_DOWN		7
> +#define HISI_IRQ_KEY_UP			6
> +
> +#define HISI_MASK_FIELD			0xFF
> +#define HISI_BITS			8
> +
> +/*define the first group interrupt register number*/

I think the nomenclature is forthcoming enough for this to be omitted.

It's also in the wrong format.

> +#define HISI_PMIC_FIRST_GROUP_INT_NUM	2
> +
> +static const struct mfd_cell hi6421v600_devs[] = {
> +	{ .name = "hi6421v600-regulator", },
> +};

Where are the reset of the devices?

> +static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
> +{
> +	struct hi6421_spmi_pmic *pmic = (struct hi6421_spmi_pmic *)priv;
> +	unsigned long pending;
> +	unsigned int data;
> +	int i, offset;
> +
> +	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
> +		regmap_read(pmic->map, offset, &data);

"map" is ambiguous.  Please rename this to 'regamp'.

What exactly is this reading?

Offset looks decidedly unassigned to me.

> +		data &= HISI_MASK_FIELD;
> +		if (data != 0)
> +			pr_debug("data[%d]=0x%d\n\r", i, data);

How useful is this, really?

> +		regmap_write(pmic->map, i + SOC_PMIC_IRQ0_ADDR, data);

Nit: I can't help feeling this would read better as the address plus
the offset.

> +		/* for_each_set_bit() macro requires unsigned long */

Not sure this requires a comment?

> +		pending = data;

Would a cast work better?

> +		/* solve powerkey order */

What does this mean?  Please elaborate.

Please use English grammar in comments i.e. begin with a capital letter.

> +		if ((i == HISI_IRQ_KEY_NUM) &&
> +		    ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {

Excessive bracketing used here.

> +			generic_handle_irq(pmic->irqs[HISI_IRQ_KEY_DOWN]);
> +			generic_handle_irq(pmic->irqs[HISI_IRQ_KEY_UP]);
> +			pending &= (~HISI_IRQ_KEY_VALUE);
> +		}
> +
> +		if (pending) {
> +			for_each_set_bit(offset, &pending, HISI_BITS)
> +				generic_handle_irq(pmic->irqs[offset + i * HISI_BITS]);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void hi6421_spmi_irq_mask(struct irq_data *d)
> +{
> +	struct hi6421_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
> +	unsigned long flags;
> +	unsigned int data;
> +	u32 offset;
> +
> +	offset = (irqd_to_hwirq(d) >> 3);

Why 3?  Probably better to define these shifts/masks rather than use
magic numbers with no comments.

> +	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
> +
> +	spin_lock_irqsave(&pmic->lock, flags);
> +

Keep these symmetrical for ease of reading.

Either add a '\n' before the unlock or remove this one.

> +	regmap_read(pmic->map, offset, &data);
> +	data |= (1 << (irqd_to_hwirq(d) & 0x07));

What are you doing here?

Maybe improved defines will be enough.  If not, please supply a
suitable comment.

> +	regmap_write(pmic->map, offset, data);
> +	spin_unlock_irqrestore(&pmic->lock, flags);
> +}
> +
> +static void hi6421_spmi_irq_unmask(struct irq_data *d)
> +{
> +	struct hi6421_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
> +	u32 data, offset;
> +	unsigned long flags;
> +
> +	offset = (irqd_to_hwirq(d) >> 3);
> +	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
> +
> +	spin_lock_irqsave(&pmic->lock, flags);
> +	regmap_read(pmic->map, offset, &data);
> +	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
> +	regmap_write(pmic->map, offset, data);
> +	spin_unlock_irqrestore(&pmic->lock, flags);
> +}
> +
> +static struct irq_chip hi6421_spmi_pmu_irqchip = {
> +	.name		= "hisi-irq",
> +	.irq_mask	= hi6421_spmi_irq_mask,
> +	.irq_unmask	= hi6421_spmi_irq_unmask,
> +	.irq_disable	= hi6421_spmi_irq_mask,
> +	.irq_enable	= hi6421_spmi_irq_unmask,
> +};
> +
> +static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
> +			       irq_hw_number_t hw)
> +{
> +	struct hi6421_spmi_pmic *pmic = d->host_data;
> +
> +	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
> +				      handle_simple_irq, "hisi");
> +	irq_set_chip_data(virq, pmic);
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
> +static void hi6421_spmi_pmic_irq_prc(struct hi6421_spmi_pmic *pmic)
> +{
> +	int i;
> +	unsigned int pending;
> +
> +	for (i = 0 ; i < HISI_IRQ_ARRAY; i++)

Misplaced ' '.

> +		regmap_write(pmic->map, SOC_PMIC_IRQ_MASK_0_ADDR + i,
> +				       HISI_MASK_STATE);
> +
> +	for (i = 0 ; i < HISI_IRQ_ARRAY; i++) {
> +		regmap_read(pmic->map, SOC_PMIC_IRQ0_ADDR + i, &pending);
> +
> +		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n",
> +			 SOC_PMIC_IRQ0_ADDR + i, pending);

Again, is this actually useful to anyone now that the driver is nearly
10 years old.  Particularly anyone who can't add a quick printk()
during a debug session?

> +		regmap_write(pmic->map, SOC_PMIC_IRQ0_ADDR + i,
> +			     HISI_MASK_STATE);
> +	}
> +}
> +
> +static const struct regmap_config spmi_regmap_config = {
> +	.reg_bits		= 16,
> +	.val_bits		= 8,
> +	.max_register		= 0xffff,
> +	.fast_io		= true
> +};
> +
> +static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct hi6421_spmi_pmic *pmic;
> +	struct regmap *map;
> +	unsigned int virq;
> +	int ret, i;
> +
> +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);

Nit: My personal preference for local driver data is 'ddata'.

> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	map = devm_regmap_init_spmi_ext(pdev, &spmi_regmap_config);

We talk about IRQ maps above.  'regmap' would be better here.

> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	spin_lock_init(&pmic->lock);
> +
> +	pmic->dev = dev;
> +	pmic->map = map;
> +
> +	pmic->gpio = of_get_gpio(np, 0);

Why do you use local variable 'map' above and just assign the ddata
value directly here?  I think the latter would be better throughout.

> +	if (pmic->gpio < 0)
> +		return pmic->gpio;
> +
> +	if (!gpio_is_valid(pmic->gpio))
> +		return -EINVAL;
> +
> +	ret = devm_gpio_request_one(dev, pmic->gpio, GPIOF_IN, "pmic");
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request gpio%d\n", pmic->gpio);
> +		return ret;
> +	}
> +
> +	pmic->irq = gpio_to_irq(pmic->gpio);
> +
> +	hi6421_spmi_pmic_irq_prc(pmic);

What does prc mean?

> +	pmic->irqs = devm_kzalloc(dev, HISI_IRQ_NUM * sizeof(int), GFP_KERNEL);
> +	if (!pmic->irqs)
> +		goto irq_malloc;

malloc?

> +	pmic->domain = irq_domain_add_simple(np, HISI_IRQ_NUM, 0,
> +					     &hi6421_spmi_domain_ops, pmic);
> +	if (!pmic->domain) {
> +		dev_err(dev, "failed irq domain add simple!\n");

Too specific in my opinion.  No need to mention the call.

"Failed to create IRQ domain" would be better IMHO.

> +		ret = -ENODEV;
> +		goto irq_malloc;
> +	}
> +
> +	for (i = 0; i < HISI_IRQ_NUM; i++) {
> +		virq = irq_create_mapping(pmic->domain, i);
> +		if (!virq) {
> +			dev_err(dev, "Failed mapping hwirq\n");

"Failed to map H/W IRQ"

> +			ret = -ENOSPC;
> +			goto irq_malloc;
> +		}
> +		pmic->irqs[i] = virq;
> +		dev_dbg(dev, "%s: pmic->irqs[%d] = %d\n",
> +			__func__, i, pmic->irqs[i]);

This is ugly.  Please remove it.

> +	}
> +
> +	ret = request_threaded_irq(pmic->irq, hi6421_spmi_irq_handler, NULL,
> +				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
> +				   "pmic", pmic);
> +	if (ret < 0) {
> +		dev_err(dev, "could not claim pmic IRQ: error %d\n", ret);

This is inconsistent with other prints.  Better to start with a
capital I think.  Also, it should be "PMIC", as it's an abbreviation.

> +		goto irq_malloc;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, pmic);
> +
> +	/*
> +	 * The logic below will rely that the pmic is already stored at
> +	 * drvdata.
> +	 */

Which logic?

> +	dev_dbg(&pdev->dev, "SPMI-PMIC: adding children for %pOF\n",
> +		pdev->dev.of_node);

Please remove this.

> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
> +				   NULL, 0, NULL);
> +	if (!ret)
> +		return 0;
> +
> +	dev_err(dev, "Failed to add child devices: %d\n", ret);
> +
> +irq_malloc:
> +	free_irq(pmic->irq, pmic);

Does gpio_to_irq() need freeing?

> +	return ret;
> +}
> +
> +static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
> +{
> +	struct hi6421_spmi_pmic *pmic = dev_get_drvdata(&pdev->dev);
> +
> +	free_irq(pmic->irq, pmic);
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

Odd spacing.  Just use one ' ' please.

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
