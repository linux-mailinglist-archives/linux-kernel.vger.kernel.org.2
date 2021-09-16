Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFF40EB37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhIPUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:01:04 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34511 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhIPUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:01:03 -0400
Received: by mail-ot1-f53.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso9845093otp.1;
        Thu, 16 Sep 2021 12:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rOX6kbLjzifF8fmG0W4Hht/o/tUMqstktKDKeNik2c=;
        b=xInAZIYNPqGIr2l7P7iXEIzx9E/UekVnK2vcRbmJz95EOLerTKHEiHinZM5gVvNFdL
         8SUleiO6rmSRIkepjWYaXioun20ajt1wZYZ3Jpn1TinsZQY/x8Lh6uLt7vBxAXTbFGVe
         kKEJIn00bveYSG9fdIHjM5tTVBIo3sJaE9UHQxCmeSI/VZePte/V5fjAX8PmjTTuDweo
         0BOiP4uN/aeKAT16hHATzCvG8k8R4nDzdythegqJvdBjktnVajs0rYmzkaal/9uvUiiL
         N+9kMmEjMh1P0Jcoo6IjkPYKy/VACUBmv7DoxAB7wmrl4q3N+B9WWY63OgZCf9xW02OR
         wfNw==
X-Gm-Message-State: AOAM53353FJ7Rf0ZkbYRdMaTHXYPOixNqPmn607xqb6W5Q4gD0flYKI1
        O4HeFIQRQRhZmZLZQETNOg==
X-Google-Smtp-Source: ABdhPJxBUjv2Ck7nzKtYMlCC/wcuDi+QeT0j/OPBANjGEMlubGOy99/RS5/JFk2KYuWUHNvFuH3hbQ==
X-Received: by 2002:a05:6830:3144:: with SMTP id c4mr6168508ots.153.1631822381944;
        Thu, 16 Sep 2021 12:59:41 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id w1sm988290ott.21.2021.09.16.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:59:41 -0700 (PDT)
Received: (nullmailer pid 1395242 invoked by uid 1000);
        Thu, 16 Sep 2021 19:59:38 -0000
Date:   Thu, 16 Sep 2021 14:59:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v7 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YUOiKjfSLm7DHoXG@robh.at.kernel.org>
References: <20210913174955.32330-1-shruthi.sanil@intel.com>
 <20210913174955.32330-2-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913174955.32330-2-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:19:54PM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which can be used as
> clocksource and clockevent device in the Intel Keem Bay SoC.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> new file mode 100644
> index 000000000000..80e7785845ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> @@ -0,0 +1,172 @@
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
> +  compatible:
> +    enum:
> +      - simple-mfd

Removing is not the right solution. What you need is:

items:
  - const: intel,keembay-gpt-creg
  - const: simple-mfd

> +
> +  reg:
> +    description: General configuration register address and length.
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +required:
> +  - compatible
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
> +            compatible = "simple-mfd";
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
