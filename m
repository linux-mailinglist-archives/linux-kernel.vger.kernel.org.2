Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC03B30F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFXOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:10:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:08:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so6815635wrf.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mlcvq7trBAQ4ieIqjYkUiWQFgphJHX8UM6h2jQ/gBa4=;
        b=GF3V0A851nRuViJG29SeFpR+fkV5vHDxkkl96tctRDlE/gtyiKQxJRzgwhVAMLU5wS
         ouKZ3hjs+ZVgZnmjknMkGm2VsjCBe73W0jRFJIhNJ3uMLc4MVk29O6xlxuVKX+JRnHS5
         cF1Bb/IAAx6RMvQz9Ez38ZZeZOzMJTDUmlLG3oEapKbxFAjsJpae583dVDvwrBQR79Iu
         dVJnhH6RSjwbMwBJGccv7slkFdklG/DC57+g265M1SUDCfnXtiXrYamWvsVWlOQjihP3
         e/jVdLMixfwUKVO0mSd1Q/VIt3bd224tvI3mpfl/0H4uEFS/vP9jR86Q1aQ40eHY8Q5p
         N/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mlcvq7trBAQ4ieIqjYkUiWQFgphJHX8UM6h2jQ/gBa4=;
        b=JR2qVO+9gq7EOKFC6uTDsBSl4TxFVfOZNoB3OKA2pMQOSX1qzvfmBJa9WUSWnaJCcs
         +WbH4vnhMHB/TacabMugGBacrlGfT9Yo8sVVAUHykyg2J2tH9gzkeIoEpjy2i42Ajbx3
         v5xKXtMCa8GamBSmnoibcEj5IaYP6b/MQU1gEOXXLTg1Reveuq3VaY61bX6fTkEIx0Tg
         iQYEN2OYI7x8gqIy6wlwDEAY6jn8WOJqxDe4H1IskoTk6h+akszlO9mMCtIGvszjVHYq
         85W8LXoWpyqwvUe+3YIUdY8agjAwLrkedRnqLhLMgHFof5h0nCS+98M/nO75Hog2cSOY
         9c6w==
X-Gm-Message-State: AOAM533I+i2FErJ5pNv6HHSpgMG6CvDUC1DQVbCZvCqTuRfFeSKh2PY/
        FXE4G9VvA5nz/PqXWWO7v8a3qg==
X-Google-Smtp-Source: ABdhPJzs3AEKMmE9ena4lab/LH/5SVDsSk86+t2yBbBtLhuwpSb6SD2mXMJpl4duXMEXucjnasmW/A==
X-Received: by 2002:a05:6000:18a8:: with SMTP id b8mr4697909wri.208.1624543683269;
        Thu, 24 Jun 2021 07:08:03 -0700 (PDT)
Received: from dell (92.40.181.110.threembb.co.uk. [92.40.181.110])
        by smtp.gmail.com with ESMTPSA id 22sm3010735wmi.4.2021.06.24.07.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:08:02 -0700 (PDT)
Date:   Thu, 24 Jun 2021 15:08:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <YNSRwIMr8+m9Sxk3@dell>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
 <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
 <YNRrISOGujxcJAGR@dell>
 <20210624143605.153e1e34@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624143605.153e1e34@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:

> Em Thu, 24 Jun 2021 12:33:28 +0100
> Lee Jones <lee.jones@linaro.org> escreveu:
> 
> > On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:
> > 
> > > This driver is ready for mainstream. So, move it out of staging.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/mfd/Kconfig                           |  16 +
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/hi6421-spmi-pmic.c                | 316 ++++++++++++++++++
> > >  drivers/staging/Kconfig                       |   2 -
> > >  drivers/staging/Makefile                      |   1 -
> > >  drivers/staging/hikey9xx/Kconfig              |  19 --
> > >  drivers/staging/hikey9xx/Makefile             |   3 -
> > >  drivers/staging/hikey9xx/TODO                 |   5 -
> > >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 316 ------------------
> > >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 --------
> > >  12 files changed, 474 insertions(+), 480 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > >  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
> > >  delete mode 100644 drivers/staging/hikey9xx/Kconfig
> > >  delete mode 100644 drivers/staging/hikey9xx/Makefile
> > >  delete mode 100644 drivers/staging/hikey9xx/TODO
> > >  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > >  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > > new file mode 100644
> > > index 000000000000..8e355cddd437
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > > @@ -0,0 +1,134 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HiSilicon 6421v600 SPMI PMIC
> > > +
> > > +maintainers:
> > > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +
> > > +description: |
> > > +  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
> > > +  (SPMI) bus. It provides interrupts and power supply.
> > > +
> > > +  The GPIO and interrupt settings are represented as part of the top-level PMIC
> > > +  node.
> > > +
> > > +  The SPMI controller part is provided by
> > > +  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "pmic@[0-9a-f]"
> > > +
> > > +  compatible:
> > > +    const: hisilicon,hi6421v600-spmi
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#interrupt-cells':
> > > +    const: 2
> > > +
> > > +  interrupt-controller: true
> > > +
> > > +  gpios:
> > > +    maxItems: 1
> > > +    description: GPIO used for IRQs
> > > +
> > > +  regulators:
> > > +    type: object
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^ldo[0-9]+@[0-9a-f]$':
> > > +        type: object
> > > +
> > > +        $ref: "/schemas/regulator/regulator.yaml#"
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - regulators
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    /* pmic properties */
> > > +
> > > +    pmic: pmic@0 {
> > > +      compatible = "hisilicon,hi6421-spmi";
> > > +      reg = <0 0>;
> > > +
> > > +      #interrupt-cells = <2>;
> > > +      interrupt-controller;
> > > +      gpios = <&gpio28 0 0>;
> > > +
> > > +      regulators {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        ldo3: LDO3 {
> > > +          regulator-name = "ldo3";
> > > +          regulator-min-microvolt = <1500000>;
> > > +          regulator-max-microvolt = <2000000>;
> > > +          regulator-boot-on;
> > > +        };
> > > +
> > > +        ldo4: LDO4 {
> > > +          regulator-name = "ldo4";
> > > +          regulator-min-microvolt = <1725000>;
> > > +          regulator-max-microvolt = <1900000>;
> > > +          regulator-boot-on;
> > > +        };
> > > +
> > > +        ldo9: LDO9 {
> > > +          regulator-name = "ldo9";
> > > +          regulator-min-microvolt = <1750000>;
> > > +          regulator-max-microvolt = <3300000>;
> > > +          regulator-boot-on;
> > > +        };
> > > +
> > > +        ldo15: LDO15 {
> > > +          regulator-name = "ldo15";
> > > +          regulator-min-microvolt = <1800000>;
> > > +          regulator-max-microvolt = <3000000>;
> > > +          regulator-always-on;
> > > +        };
> > > +
> > > +        ldo16: LDO16 {
> > > +          regulator-name = "ldo16";
> > > +          regulator-min-microvolt = <1800000>;
> > > +          regulator-max-microvolt = <3000000>;
> > > +          regulator-boot-on;
> > > +        };
> > > +
> > > +        ldo17: LDO17 {
> > > +          regulator-name = "ldo17";
> > > +          regulator-min-microvolt = <2500000>;
> > > +          regulator-max-microvolt = <3300000>;
> > > +        };
> > > +
> > > +        ldo33: LDO33 {
> > > +          regulator-name = "ldo33";
> > > +          regulator-min-microvolt = <2500000>;
> > > +          regulator-max-microvolt = <3300000>;
> > > +          regulator-boot-on;
> > > +        };
> > > +
> > > +        ldo34: LDO34 {
> > > +          regulator-name = "ldo34";
> > > +          regulator-min-microvolt = <2600000>;
> > > +          regulator-max-microvolt = <3300000>;
> > > +        };
> > > +      };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9a69e3810964..89e84b050de6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8291,6 +8291,13 @@ S:	Maintained
> > >  F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> > >  F:	drivers/spmi/hisi-spmi-controller.c
> > >  
> > > +HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
> > > +M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +L:	linux-kernel@vger.kernel.org
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > > +F:	drivers/mfd/hi6421-spmi-pmic.c
> > > +
> > >  HISILICON STAGING DRIVERS FOR HIKEY 960/970
> > >  M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > >  S:	Maintained
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 5c7f2b100191..99b8da2548b5 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -509,6 +509,22 @@ config MFD_HI6421_PMIC
> > >  	  menus in order to enable them.
> > >  	  We communicate with the Hi6421 via memory-mapped I/O.
> > >  
> > > +config MFD_HI6421_SPMI
> > > +	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
> > > +	depends on OF
> > > +	depends on SPMI
> > > +	select MFD_CORE
> > > +	select REGMAP_SPMI
> > > +	help
> > > +	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
> > > +	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
> > > +	  etc.
> > > +
> > > +	  This driver includes core APIs _only_. You have to select
> > > +	  individual components like voltage regulators under corresponding
> > > +	  menus in order to enable them.
> > > +	  We communicate with the Hi6421v600 via a SPMI bus.
> > > +
> > >  config MFD_HI655X_PMIC
> > >  	tristate "HiSilicon Hi655X series PMU/Codec IC"
> > >  	depends on ARCH_HISI || COMPILE_TEST
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 4f6d2b8a5f76..e87230fc61ac 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -232,6 +232,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
> > >  obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
> > >  obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
> > >  obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
> > > +obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
> > >  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
> > >  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
> > >  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> > > diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
> > > new file mode 100644
> > > index 000000000000..2b7172560df7
> > > --- /dev/null
> > > +++ b/drivers/mfd/hi6421-spmi-pmic.c
> > > @@ -0,0 +1,316 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device driver for regulators in HISI PMIC IC
> > > + *
> > > + * Copyright (c) 2013 Linaro Ltd.
> > > + * Copyright (c) 2011 Hisilicon.
> > > + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> > 
> > Can this be updated?
> 
> Do you mean updating the copyrights to cover this year? E.g.
> something like this:
> 
> 	 * Copyright (c) 2013-2021 Linaro Ltd.
> 	 * Copyright (c) 2011-2021 Hisilicon.
> 	 * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> 
> Right? Or are you meaning something else?

Yes, that's it.  I know this is just a move, but to MFD, it's new.

> Btw, this device is a variant of the already-existing devices
> provided by the hi6421-pmic-core, which has:
> 
> 	 * Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
> 	 *              http://www.hisilicon.com
> 	 * Copyright (c) <2013-2017> Linaro Ltd.
> 	 *              https://www.linaro.org
> 	 *
> 
> The main difference is that this device is connected via a 
> SPMI bus (there are other differences on register settings and
> LDO/BUCK regulators).
> 
> > 
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/hi6421-spmi-pmic.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spmi.h>
> > > +
> > > +enum hi6421_spmi_pmic_irq_list {
> > > +	OTMP = 0,
> > > +	VBUS_CONNECT,
> > > +	VBUS_DISCONNECT,
> > > +	ALARMON_R,
> > > +	HOLD_6S,
> > > +	HOLD_1S,
> > > +	POWERKEY_UP,
> > > +	POWERKEY_DOWN,
> > > +	OCP_SCP_R,
> > > +	COUL_R,
> > > +	SIM0_HPD_R,
> > > +	SIM0_HPD_F,
> > > +	SIM1_HPD_R,
> > > +	SIM1_HPD_F,
> > > +
> > > +	PMIC_IRQ_LIST_MAX
> > > +};
> > > +
> > > +#define HISI_IRQ_BANK_SIZE		2
> > > +
> > > +/*
> > > + * IRQ number for the power key button and mask for both UP and DOWN IRQs
> > > + */
> > > +#define HISI_POWERKEY_IRQ_NUM		0
> > > +#define HISI_IRQ_POWERKEY_UP_DOWN	(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
> > > +
> > > +/*
> > > + * Registers for IRQ address and IRQ mask bits
> > > + *
> > > + * Please notice that we need to regmap a larger region, as other
> > > + * registers are used by the regulators.
> > > + * See drivers/regulator/hi6421-regulator.c.
> > > + */
> > > +#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
> > > +#define SOC_PMIC_IRQ0_ADDR		0x0212
> > > +
> > > +/*
> > > + * The IRQs are mapped as:
> > > + *
> > > + *	======================  =============   ============	=====
> > > + *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
> > > + *	======================  =============   ============	=====
> > > + *	OTMP			0x0202		0x212		bit 0
> > > + *	VBUS_CONNECT		0x0202		0x212		bit 1
> > > + *	VBUS_DISCONNECT		0x0202		0x212		bit 2
> > > + *	ALARMON_R		0x0202		0x212		bit 3
> > > + *	HOLD_6S			0x0202		0x212		bit 4
> > > + *	HOLD_1S			0x0202		0x212		bit 5
> > > + *	POWERKEY_UP		0x0202		0x212		bit 6
> > > + *	POWERKEY_DOWN		0x0202		0x212		bit 7
> > > + *
> > > + *	OCP_SCP_R		0x0203		0x213		bit 0
> > > + *	COUL_R			0x0203		0x213		bit 1
> > > + *	SIM0_HPD_R		0x0203		0x213		bit 2
> > > + *	SIM0_HPD_F		0x0203		0x213		bit 3
> > > + *	SIM1_HPD_R		0x0203		0x213		bit 4
> > > + *	SIM1_HPD_F		0x0203		0x213		bit 5
> > > + *	======================  =============   ============	=====
> > > + *
> > > + * Each mask register contains 8 bits. The ancillary macros below
> > > + * convert a number from 0 to 14 into a register address and a bit mask
> > > + */
> > > +#define HISI_IRQ_MASK_REG(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
> > > +					 (irqd_to_hwirq(irq_data) / BITS_PER_BYTE))
> > > +#define HISI_IRQ_MASK_BIT(irq_data)	BIT(irqd_to_hwirq(irq_data) & (BITS_PER_BYTE - 1))
> > > +#define HISI_8BITS_MASK			GENMASK(BITS_PER_BYTE - 1, 0)  
> > 
> > Are these lines up in real code?  Looks like they're not in the diff.
> 
> Weird. The changes to use those are at patch 3/8. All the above
> macros are used at the patch.

Sorry, that made no sense - it's been a long few days!

I meant to say "do these (the tabs) line up?"

> > > +static const struct mfd_cell hi6421v600_devs[] = {
> > > +	{ .name = "hi6421v600-regulator", },
> > > +};  
> > 
> > Where are the other devices?
> 
> While this is a MFD device, as it has regulators, ADC and other
> stuff, right now, only the regulator and the IRQs are implemented. 
> 
> The IRQs are at the core of this driver, while the regulator 
> is at the separate regulator driver.

The rule usually goes:

 Drivers don't qualify as MFDs until you register >1 device.

[...]

> > > +	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
> > > +		virq = irq_create_mapping(ddata->domain, i);
> > > +		if (!virq) {
> > > +			dev_err(dev, "Failed to map H/W IRQ\n");
> > > +			return -ENOSPC;  
> > 
> > -ENOSPC doesn't seem right here.
> > 
> > Can't find any other uses of it for irq_create_mapping() either.
> 
> There are two drivers returning -ENOSPC:
> 
> 	arch/powerpc/platforms/pseries/msi.c
> 	arch/powerpc/sysdev/mpic_u3msi.c

I only looked in drivers/

> But others return -EIO, -EINVAL, -ENOMEM, -ENODEV, -ENXIO.
> 
> I think that -ENODEV would fit better here.

I think -ENXIO is the most common, followed by -EINVAL.

This doesn't have anything to do with devices per say.

> > > +static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
> > > +{
> > > +	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
> > > +
> > > +	free_irq(ddata->irq, ddata);  
> > 
> > No devm_* version?
> 
> Are there a devm_* variant for gpio_to_irq()?

Please refer to Dan's response.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
