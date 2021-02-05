Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9E3119DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhBFDWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:22:04 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35381 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhBFCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:09 -0500
Received: by mail-ot1-f54.google.com with SMTP id k10so6508936otl.2;
        Fri, 05 Feb 2021 18:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FU+UCOFQQYVXfS0+LCrISl1mGUUH7pHKT1RulCQQqCk=;
        b=lRJ7rKFrYJNPcL2fAV7PVPqNPRHQ+ks4xHyuUBFrOxWlLI3+yyMdj5lWWCUUwAZ7og
         EFfwAotUhNZUkoaCtbJfJxlHHHIzz4mAgaMEyJU68POJLscPBzwt1MWgHlLydO+zAw4e
         pSzxy0fLqR8ZSbswn6qeb+K1p19B0zrfWuY8/NlebXCUAynyhBtf6pLYimJ1CFmmY6td
         xKI+Ynxem/1wAuCcruUZmxpLxiOXCHARQuJYPCigwl3eQtz/c6VwXc6vW/0BTocMhuBF
         Q9ULkmDDnBYyL+9J3Mow6kkCauSB1hnfrR2llWPWh0zEccMm2ydxDSDs8XkaJ81cLwJb
         lK5w==
X-Gm-Message-State: AOAM531ToE63J7mBR1+QKJ4UoT4HH/VQev+iR1LLIFkx/SBTbI9Hm5LE
        qW92apQHpn27ofceG5SAqYfCf2peSg==
X-Google-Smtp-Source: ABdhPJyr1AlIFE4ExmRHCvX9qNXq8/sjd9wV24kKZcLUt9dS+ovyZrQ6nuiOsTAaglcyp92xF8HXfg==
X-Received: by 2002:a9d:37c4:: with SMTP id x62mr5065131otb.87.1612563968681;
        Fri, 05 Feb 2021 14:26:08 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a63sm2097188otc.75.2021.02.05.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:26:07 -0800 (PST)
Received: (nullmailer pid 3866684 invoked by uid 1000);
        Fri, 05 Feb 2021 22:26:06 -0000
Date:   Fri, 5 Feb 2021 16:26:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/21] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210205222606.GA3857395@robh.at.kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
 <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:10:44PM +0100, Mauro Carvalho Chehab wrote:
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

'-spmi' is redundant.

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

Don't need a description here.

Don't you need 'interrupts' here to get the interrupts to the host?

> +
> +  gpios:
> +    maxItems: 1

GPIO for what? It's preferred to have a named gpio.

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

       additionalProperties: false

Which will give you errors in the example.

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

LDO3: ldo3  {

is preferred and closer to what you defined above.

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
