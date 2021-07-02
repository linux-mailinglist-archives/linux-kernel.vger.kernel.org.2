Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC853BA513
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhGBVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:38:49 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:36468 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:38:48 -0400
Received: by mail-il1-f176.google.com with SMTP id k6so3149420ilo.3;
        Fri, 02 Jul 2021 14:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FNfogAuUZ+o4dsPokESYKtv0tShy/P05G3l9bvhxCU=;
        b=Lim7iYvLBYhG66uOlvG4CvBeYzgp0Wt4wHM7Gp6+elzvPJnh5RIvREdrNPxY35Nuf9
         EoadhGP8WglCJQ7Fxt0xV/SDTke5jkHUhY565p6GTijjHh8NCpfdOWtK7JOjoxzwthBH
         SCIeyRD7iH8VKLrpbZ2Q2Io4det6daHkZG+woLMqEsY3q/1/qYAkXJmjU7uFyNIyMIMT
         QNQpvNT7xsRpjHAupUjSxAM1If25flq40ejlMtTWj/FdKyCRG/jnqJ+LivHsD285yJw4
         nmuajvdMqCeh6YfF0HtOKDDyp7iVPx8SQ2UioMRGFqiNRiZ4oBoyTG7pd6A4pRHdt6Qb
         /PvQ==
X-Gm-Message-State: AOAM5336PshLrTMgE44uK4dFAS0+u/8mDH6NgltDgn2G6oO6ZuTpIulK
        US3e4TM+Xv92S2ztenmaHA==
X-Google-Smtp-Source: ABdhPJz57iTclTfZqt1Lo59e47Mtj4/Y0dopTWVOQi1wDAqYLl5eJSeOtC9mjVcXrJGcamyFAhE/Lw==
X-Received: by 2002:a92:c045:: with SMTP id o5mr1303808ilf.223.1625261774409;
        Fri, 02 Jul 2021 14:36:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t8sm2497468iog.21.2021.07.02.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:36:13 -0700 (PDT)
Received: (nullmailer pid 1059451 invoked by uid 1000);
        Fri, 02 Jul 2021 21:36:11 -0000
Date:   Fri, 2 Jul 2021 15:36:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Axel Lin <axel.lin@ingics.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v11 6/8] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210702213611.GA1050378@robh.at.kernel.org>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
 <9dc21f0833b9b2b36fed7a6c7f3761d8e49bfaae.1625211021.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc21f0833b9b2b36fed7a6c7f3761d8e49bfaae.1625211021.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:37:21AM +0200, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  16 +++
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                |  66 +++++++++
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/hikey9xx/Kconfig              |  19 ---
>  drivers/staging/hikey9xx/Makefile             |   3 -
>  drivers/staging/hikey9xx/TODO                 |   5 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   |  66 ---------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 ------------------
>  12 files changed, 224 insertions(+), 230 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/Kconfig
>  delete mode 100644 drivers/staging/hikey9xx/Makefile
>  delete mode 100644 drivers/staging/hikey9xx/TODO
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> new file mode 100644
> index 000000000000..8e355cddd437
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> @@ -0,0 +1,134 @@
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
> +  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]"
> +
> +  compatible:
> +    const: hisilicon,hi6421v600-spmi

Doesn't match the example.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO used for IRQs

Use 'interrupts' instead if this is an interrupt.

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
> index 31a8cc819c0d..61bdd887d72f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8311,6 +8311,13 @@ S:	Maintained
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
>  S:	Maintained
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 5c7f2b100191..99b8da2548b5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -509,6 +509,22 @@ config MFD_HI6421_PMIC
>  	  menus in order to enable them.
>  	  We communicate with the Hi6421 via memory-mapped I/O.
>  
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
> index 000000000000..c9c0c3d7011f
> --- /dev/null
> +++ b/drivers/mfd/hi6421-spmi-pmic.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in HISI PMIC IC
> + *
> + * Copyright (c) 2013 Linaro Ltd.
> + * Copyright (c) 2011 Hisilicon.
> + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
> + */
> +
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spmi.h>
> +
> +static const struct mfd_cell hi6421v600_devs[] = {
> +	{ .name = "hi6421v600-irq", },
> +	{ .name = "hi6421v600-regulator", },
> +};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits	= 16,
> +	.val_bits	= BITS_PER_BYTE,
> +	.max_register	= 0xffff,
> +	.fast_io	= true
> +};
> +
> +static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
> +{
> +	struct device *dev = &sdev->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	dev_set_drvdata(&sdev->dev, regmap);
> +
> +	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
> +				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
> +				   NULL, 0, NULL);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to add child devices: %d\n", ret);
> +
> +	return ret;
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
> +		.of_match_table = pmic_spmi_id_table,
> +	},
> +	.probe	= hi6421_spmi_pmic_probe,
> +};
> +module_spmi_driver(hi6421_spmi_pmic_driver);
> +
> +MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index b7ae5bdc4eb5..5b4267d3ed6b 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -104,6 +104,4 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/wfx/Kconfig"
>  
> -source "drivers/staging/hikey9xx/Kconfig"
> -
>  endif # STAGING
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 075c979bfe7c..7179cdcaafe7 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -42,4 +42,3 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
>  obj-$(CONFIG_KPC2000)		+= kpc2000/
>  obj-$(CONFIG_QLGE)		+= qlge/
>  obj-$(CONFIG_WFX)		+= wfx/
> -obj-y				+= hikey9xx/
> diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
> deleted file mode 100644
> index 9f53df9068fe..000000000000
> --- a/drivers/staging/hikey9xx/Kconfig
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# to be placed at drivers/mfd
> -config MFD_HI6421_SPMI
> -	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
> -	depends on HAS_IOMEM
> -	depends on OF
> -	depends on SPMI
> -	select MFD_CORE
> -	select REGMAP_SPMI
> -	help
> -	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
> -	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
> -	  etc.
> -
> -	  This driver includes core APIs _only_. You have to select
> -	  individual components like voltage regulators under corresponding
> -	  menus in order to enable them.
> -	  We communicate with the Hi6421v600 via a SPMI bus.
> diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
> deleted file mode 100644
> index e3108d7dd849..000000000000
> --- a/drivers/staging/hikey9xx/Makefile
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
> diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
> deleted file mode 100644
> index 65e7996a3066..000000000000
> --- a/drivers/staging/hikey9xx/TODO
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -ToDo list:
> -
> -- Port other drivers needed by Hikey 960/970;
> -- Test drivers on Hikey 960;
> -- Validate device tree bindings.
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> deleted file mode 100644
> index c9c0c3d7011f..000000000000
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device driver for regulators in HISI PMIC IC
> - *
> - * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2011 Hisilicon.
> - * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
> - */
> -
> -#include <linux/mfd/core.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/regmap.h>
> -#include <linux/slab.h>
> -#include <linux/spmi.h>
> -
> -static const struct mfd_cell hi6421v600_devs[] = {
> -	{ .name = "hi6421v600-irq", },
> -	{ .name = "hi6421v600-regulator", },
> -};
> -
> -static const struct regmap_config regmap_config = {
> -	.reg_bits	= 16,
> -	.val_bits	= BITS_PER_BYTE,
> -	.max_register	= 0xffff,
> -	.fast_io	= true
> -};
> -
> -static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
> -{
> -	struct device *dev = &sdev->dev;
> -	struct regmap *regmap;
> -	int ret;
> -
> -	regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> -
> -	dev_set_drvdata(&sdev->dev, regmap);
> -
> -	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
> -				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
> -				   NULL, 0, NULL);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to add child devices: %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static const struct of_device_id pmic_spmi_id_table[] = {
> -	{ .compatible = "hisilicon,hi6421-spmi" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
> -
> -static struct spmi_driver hi6421_spmi_pmic_driver = {
> -	.driver = {
> -		.name	= "hi6421-spmi-pmic",
> -		.of_match_table = pmic_spmi_id_table,
> -	},
> -	.probe	= hi6421_spmi_pmic_probe,
> -};
> -module_spmi_driver(hi6421_spmi_pmic_driver);
> -
> -MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> deleted file mode 100644
> index 8e355cddd437..000000000000
> --- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: HiSilicon 6421v600 SPMI PMIC
> -
> -maintainers:
> -  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> -
> -description: |
> -  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
> -  (SPMI) bus. It provides interrupts and power supply.
> -
> -  The GPIO and interrupt settings are represented as part of the top-level PMIC
> -  node.
> -
> -  The SPMI controller part is provided by
> -  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> -
> -properties:
> -  $nodename:
> -    pattern: "pmic@[0-9a-f]"
> -
> -  compatible:
> -    const: hisilicon,hi6421v600-spmi
> -
> -  reg:
> -    maxItems: 1
> -
> -  '#interrupt-cells':
> -    const: 2
> -
> -  interrupt-controller: true
> -
> -  gpios:
> -    maxItems: 1
> -    description: GPIO used for IRQs
> -
> -  regulators:
> -    type: object
> -
> -    properties:
> -      '#address-cells':
> -        const: 1
> -
> -      '#size-cells':
> -        const: 0
> -
> -    patternProperties:
> -      '^ldo[0-9]+@[0-9a-f]$':
> -        type: object
> -
> -        $ref: "/schemas/regulator/regulator.yaml#"
> -
> -required:
> -  - compatible
> -  - reg
> -  - regulators
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -    /* pmic properties */
> -
> -    pmic: pmic@0 {
> -      compatible = "hisilicon,hi6421-spmi";
> -      reg = <0 0>;
> -
> -      #interrupt-cells = <2>;
> -      interrupt-controller;
> -      gpios = <&gpio28 0 0>;
> -
> -      regulators {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -
> -        ldo3: LDO3 {
> -          regulator-name = "ldo3";
> -          regulator-min-microvolt = <1500000>;
> -          regulator-max-microvolt = <2000000>;
> -          regulator-boot-on;
> -        };
> -
> -        ldo4: LDO4 {
> -          regulator-name = "ldo4";
> -          regulator-min-microvolt = <1725000>;
> -          regulator-max-microvolt = <1900000>;
> -          regulator-boot-on;
> -        };
> -
> -        ldo9: LDO9 {
> -          regulator-name = "ldo9";
> -          regulator-min-microvolt = <1750000>;
> -          regulator-max-microvolt = <3300000>;
> -          regulator-boot-on;
> -        };
> -
> -        ldo15: LDO15 {
> -          regulator-name = "ldo15";
> -          regulator-min-microvolt = <1800000>;
> -          regulator-max-microvolt = <3000000>;
> -          regulator-always-on;
> -        };
> -
> -        ldo16: LDO16 {
> -          regulator-name = "ldo16";
> -          regulator-min-microvolt = <1800000>;
> -          regulator-max-microvolt = <3000000>;
> -          regulator-boot-on;
> -        };
> -
> -        ldo17: LDO17 {
> -          regulator-name = "ldo17";
> -          regulator-min-microvolt = <2500000>;
> -          regulator-max-microvolt = <3300000>;
> -        };
> -
> -        ldo33: LDO33 {
> -          regulator-name = "ldo33";
> -          regulator-min-microvolt = <2500000>;
> -          regulator-max-microvolt = <3300000>;
> -          regulator-boot-on;
> -        };
> -
> -        ldo34: LDO34 {
> -          regulator-name = "ldo34";
> -          regulator-min-microvolt = <2600000>;
> -          regulator-max-microvolt = <3300000>;
> -        };
> -      };
> -    };
> -- 
> 2.31.1
> 
> 
