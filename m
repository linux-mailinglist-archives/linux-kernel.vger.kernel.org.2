Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5A39936E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:23:47 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33497 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:23:46 -0400
Received: by mail-oi1-f181.google.com with SMTP id b25so3812160oic.0;
        Wed, 02 Jun 2021 12:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5NhD9ZWw+rScVfqQm15tW/HQ3ePL8Ux4U4BtY07tuM=;
        b=mG8rNWBnhEOQpYWNffLm692snooeVmERMPV18FVmF4S0mUwj0Ykh5VA2XPVY5Fg8cZ
         Ip+pVzQdVDS5cPCYSZCRjLDUUeeYB2+pqAL+CYbYn44ONZ2U1hss7HbH4WVE5x0wA5Ud
         vl3cYacuBJjLDAuWQLiYxU6/eY62yn0tD5ZWZ/FhMukjZgBYubYTQCrkf3dPsCJOSl3m
         DfseUG7ENCwMxVxDaUPqZwFa3b1ncuT4EWPnVuezZaebICYj7RYfBh15q1jRJZO7plBR
         qM48ITQSpaY7DHcV6rylETwxIOasQrTYCHRZzVnwooGirp1pwcKuMr5rqk/MiLQFyyhy
         2eGQ==
X-Gm-Message-State: AOAM530KPZHz2/iaio8RscQ7hDiy9HHjrIus1RXGP4dLmJ4uiEWPMIrA
        WH3acF3AnYRwjKXOcMHcUQ==
X-Google-Smtp-Source: ABdhPJz7WroWmM35e/2zCYtoCbJu6Wy0wBFdF2jUYKvrh0dzn0OAHymxjZTlj05A4spPcCX/dVmDbw==
X-Received: by 2002:aca:3204:: with SMTP id y4mr4696557oiy.159.1622661707273;
        Wed, 02 Jun 2021 12:21:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i133sm165714oia.2.2021.06.02.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:21:46 -0700 (PDT)
Received: (nullmailer pid 3820325 invoked by uid 1000);
        Wed, 02 Jun 2021 19:21:45 -0000
Date:   Wed, 2 Jun 2021 14:21:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <20210602192145.GA3800420@robh.at.kernel.org>
References: <20210527063906.18592-1-shruthi.sanil@intel.com>
 <20210527063906.18592-2-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527063906.18592-2-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:09:05PM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..e0152e19208f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Keem Bay SoC Timers
> +
> +maintainers:
> +  - Shruthi Sanil <shruthi.sanil@intel.com>
> +
> +description: |
> +  The Intel Keem Bay timer driver supports clocksource and clockevent
> +  features for the timer IP used in Intel Keembay SoC.
> +  The timer block supports 1 free running counter and 8 timers.
> +  The free running counter can be used as a clocksouce and
> +  the timers can be used as clockevent. Each timer is capable of
> +  generating inividual interrupt.
> +  Both the features are enabled through the timer general config register.
> +
> +  The parent node represents the common general configuration details and
> +  the child nodes represents the counter and timers.
> +
> +properties:

There's no compatible, so this schema will never be applied. You need a 
compatible to identify what the block is.

> +  reg:
> +    description: General configuration register address and length.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2

Not really any reason for 64-bits of address space in the child nodes. 
Use a non-empty ranges.

> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +patternProperties:
> +  "^counter@[0-9a-f]+$":
> +    type: object
> +    description: Properties for Intel Keem Bay counter
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - intel,keembay-counter
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +
> +  "^timer@[0-9a-f]+$":
> +    type: object
> +    description: Properties for Intel Keem Bay timer
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - intel,keembay-timer
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #define KEEM_BAY_A53_TIM
> +
> +    soc {
> +        #address-cells = <0x2>;
> +        #size-cells = <0x2>;
> +
> +        gpt@20331000 {
> +            reg = <0x0 0x20331000 0x0 0xc>;
> +            #address-cells = <0x2>;
> +            #size-cells = <0x2>;
> +            ranges;
> +
> +            counter@203300e8 {
> +                compatible = "intel,keembay-counter";
> +                reg = <0x0 0x203300e8 0x0 0x8>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";

Don't show status in examples.

> +            };
> +
> +            timer@20330010 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330010 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330020 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330020 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330030 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330030 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330040 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330040 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330050 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330050 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330060 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330060 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330070 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330070 0x0 0xc>;
> +                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +
> +            timer@20330080 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x0 0x20330080 0x0 0xc>;
> +                interrupts = <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +                status = "okay";
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
