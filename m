Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31D53DE2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhHBWn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:43:58 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:44771 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:43:54 -0400
Received: by mail-io1-f53.google.com with SMTP id l18so22137650ioh.11;
        Mon, 02 Aug 2021 15:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZQeOSXFojQ/l1coeyz3v+7kw8mcB04qq43zWtA+pMw=;
        b=qZ7/ye2bjvmbD8GUum3SzhG/lJ6cRVsHC6Zw8AD2pTsXF1X1b7BrVA9cr2ded3HCf8
         /ajazY+JyqsJzqqz5lqs3d25TfIxCXWO9A17kMFZSW/22KZWMgu+L6fiqll1hXqGsNCo
         40lGbDdMLdREKIlPIRtNMe/enlaHt1RL6VMWKI46yFPVlCxNUxrwq8bByrdgMHG1AvML
         SGOhv5Kg959hOJIJErpptnxthBuO2YCrsJxLSbespD0ukSJIsAi2HsU/Z6IgyQgJ0dB1
         vExO0X+3f1v+uU92bnRDBtGNri5h6sKj6HAvRTBE7D+s5cuvuTA7O7XgD3EEq/h5+aE3
         EKxw==
X-Gm-Message-State: AOAM531yQchyQLoRAKPDpMV3iWFyolNXBWqol4dXNvfqmqk87/770C29
        EqNtzxIEOFYfROozlqXp7Q==
X-Google-Smtp-Source: ABdhPJzdYveVfBh6D9LQLlOIs/01MNBaaTgLMR6kAzQmBq3kcjvUwXmFQCrwbYglsuJAVrmMgx27KA==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr17116289jag.53.1627944223297;
        Mon, 02 Aug 2021 15:43:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b13sm456691ilc.33.2021.08.02.15.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:43:42 -0700 (PDT)
Received: (nullmailer pid 1760143 invoked by uid 1000);
        Mon, 02 Aug 2021 22:43:40 -0000
Date:   Mon, 2 Aug 2021 16:43:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
References: <20210729053937.20281-1-shruthi.sanil@intel.com>
 <20210729053937.20281-2-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729053937.20281-2-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:09:36AM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..b2eb2459d09b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,166 @@
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
> +  The Intel Keem Bay timer driver supports 1 free running counter and 8 timers.
> +  Each timer is capable of generating inividual interrupt.
> +  Both the features are enabled through the timer general config register.
> +
> +  The parent node represents the common general configuration details and
> +  the child nodes represents the counter and timers.
> +
> +properties:

You need a 'compatible' here. Otherwise, how does one know what 
'reg' contains. Also, without it, this schema will never be applied.

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
> +            counter@e8 {
> +                compatible = "intel,keembay-counter";
> +                reg = <0xe8 0x8>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@10 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x10 0xc>;
> +                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@20 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x20 0xc>;
> +                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@30 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x30 0xc>;
> +                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@40 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x40 0xc>;
> +                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@50 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x50 0xc>;
> +                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@60 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x60 0xc>;
> +                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@70 {
> +                compatible = "intel,keembay-timer";
> +                reg = <0x70 0xc>;
> +                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> +            };
> +
> +            timer@80 {
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
