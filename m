Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8F3C7C06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhGNCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:50:52 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:34756 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhGNCuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:50:51 -0400
Received: by mail-il1-f178.google.com with SMTP id e13so123578ilc.1;
        Tue, 13 Jul 2021 19:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Vdibdlzv5rYDH1Iu+VB2cu80QABZ2EylGkmlCLDsMw=;
        b=kptj+nLmCIQe6XE+I47WD/3i/HhDF9/dIgIYf2ZXbijighVaD7lsue3lpblwkyc7IA
         jiQmYlo0XzGDHHuuUWr/82bIVVj9A6IEZS9GB10hiLqAAn7kakdyHAf5YSyGrqGAfNV0
         uMJhs6nFxDtZYdyQKShxyLdaI6XV30zHPsHX/uSdIKxpspeXdHbdmnTlCmeIOUEZN5Yb
         Xy0bjvi4zcdjFe3mVvVJwGLm+F0Zec31+Idi79G1alHmYzwsCXg9PbBT2saAJAym/uZR
         D5vwLFoCyaVTJjfEEDaRnxNZ7eg50yW9/+/N5csbgriMA+hq9lN8huEPO2v35Md3wRjT
         Ijtw==
X-Gm-Message-State: AOAM531dNjKUWy65vD8O61vz/IFHl6m44kgsM+B+W+CKSXdkH1kryENh
        TYtWzs2EhnLjMm4kpX2iBg==
X-Google-Smtp-Source: ABdhPJztRHwki29RWAW+hY6YfJ050sCaEl3rjgZFuQKcazg9fgO0dBkmXngFCoE8E5ZI1+Xmjc+3+A==
X-Received: by 2002:a05:6e02:f05:: with SMTP id x5mr5034884ilj.268.1626230879666;
        Tue, 13 Jul 2021 19:47:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t24sm426343ioh.24.2021.07.13.19.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:47:59 -0700 (PDT)
Received: (nullmailer pid 1362752 invoked by uid 1000);
        Wed, 14 Jul 2021 02:47:56 -0000
Date:   Tue, 13 Jul 2021 20:47:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <20210714024756.GA1355219@robh.at.kernel.org>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628061410.8009-2-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:44:09AM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..24c149a4d220
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,170 @@
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

clockevent and clocksource are Linuxisms. Don't use them in bindings.

> +  Both the features are enabled through the timer general config register.
> +
> +  The parent node represents the common general configuration details and
> +  the child nodes represents the counter and timers.

I don't think all the child nodes are necessary. Are the counters and 
timers configurable (say on another SoC)? If not, then a single node 
here would suffice.

> +
> +properties:
> +  reg:
> +    description: General configuration register address and length.
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +required:
> +  - reg
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
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
> +            ranges = <0x0 0x0 0x20330000 0xF0>;
> +            #address-cells = <0x1>;
> +            #size-cells = <0x1>;
> +
> +            counter@203300e8 {

The unit address here is wrong. Should be 'e8'.

> +                compatible = "intel,keembay-counter";
> +                reg = <0xe8 0x8>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330010 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x10 0xc>;
> +                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330020 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x20 0xc>;
> +                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330030 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x30 0xc>;
> +                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330040 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x40 0xc>;
> +                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330050 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x50 0xc>;
> +                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330060 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x60 0xc>;
> +                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330070 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x70 0xc>;
> +                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20330080 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x80 0xc>;
> +                interrupts = <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
