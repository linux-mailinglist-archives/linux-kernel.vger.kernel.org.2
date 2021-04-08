Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83B2358E29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhDHUNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:13:47 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37793 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhDHUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:13:46 -0400
Received: by mail-ot1-f48.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so3563067otr.4;
        Thu, 08 Apr 2021 13:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2R+5jHVXPCke6baZgs2LAtymZLLKIbJs/pgqd8CKtGg=;
        b=RlfjHddvXfZ/oX7ibNQwFMdwJvLxFVsFOhHVAOnhgOYZwOwnBn4Z4tNDD9Xme8K6Zr
         ZFHddIbJvJytAM06GuZPuInGr8QsAo1xRyZbyMDqoytu6IAoLsfAQ0GIgjnJ1u9cBEfT
         dMyldX5T6DDqnwZMcvjs7Avg5csPUq+1saYwylpgk6GGgmclzLm0VRQnopG83E22RtOG
         47uKii+XfkcVYjdw+1eb9LNu8nKxWGR/re/P88wlW0ouLMYI5LAx3Rawst9TYEw0nadH
         sslCpUnJwbhoedx8CGQXaA/qRm1EUz9y9+lUzpvF5iM7W+vFlvbGS+y1fRu19Vk1cVIB
         f3cw==
X-Gm-Message-State: AOAM530j/3lvQJKJN4tdavPnLiAQvpHCRSZK6Qyu/1jApyhmhUTFXBoT
        OUmbeqUqPEeoPgSIsf1JoQ==
X-Google-Smtp-Source: ABdhPJzskC+PtCqzySPTtPCLkU0rw2XGaGqjns26ng7vNknaKYyxzVArbfQEwxYPg7Kw3FUkDi+XTA==
X-Received: by 2002:a9d:4d0d:: with SMTP id n13mr1909840otf.294.1617912814724;
        Thu, 08 Apr 2021 13:13:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm92459oto.60.2021.04.08.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:13:34 -0700 (PDT)
Received: (nullmailer pid 1886277 invoked by uid 1000);
        Thu, 08 Apr 2021 20:13:33 -0000
Date:   Thu, 8 Apr 2021 15:13:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: clock: add ti,lmk04832 bindings
Message-ID: <20210408201333.GA1882021@robh.at.kernel.org>
References: <20210407005330.2890430-1-liambeguin@gmail.com>
 <20210407005330.2890430-4-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407005330.2890430-4-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:53:30PM -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Document devicetree bindings for Texas Instruments' LMK04832.
> The LMK04208 is a high performance clock conditioner with superior clock
> jitter cleaning, generation, and distribution with JEDEC JESD204B
> support.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/clock/ti,lmk04832.yaml           | 209 ++++++++++++++++++
>  1 file changed, 209 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> new file mode 100644
> index 000000000000..a9f8b9b720fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> @@ -0,0 +1,209 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,lmk04832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for the Texas Instruments LMK04832
> +
> +maintainers:
> +  - Liam Beguin <liambeguin@gmail.com>
> +
> +description: |
> +  Devicetree binding for the LMK04832, a clock conditioner with JEDEC JESD204B
> +  support. The LMK04832 is pin compatible with the LMK0482x family.
> +
> +  Link to datasheet, https://www.ti.com/lit/ds/symlink/lmk04832.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,lmk04832
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum SPI clocking speed of the device in Hz.

Already has a type and description, just need:

spi-max-frequency: true

(Or a range of values if you know the maximum).

> +
> +  clocks:
> +    items:
> +      - description: PLL2 reference clock.
> +
> +  clock-names:
> +    items:
> +      - const: oscin
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ti,spi-4wire-rdbk:
> +    description: |
> +      Select SPI 4wire readback pin configuration.
> +      Available readback pins are,
> +        CLKin_SEL0 0
> +        CLKin_SEL1 1
> +        RESET 2
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 1
> +
> +  ti,vco-hz:
> +    description: Optional to set VCO frequency of the PLL in Hertz.
> +
> +  ti,sysref-ddly:
> +    description: SYSREF digital delay value.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 8191
> +    default: 8
> +
> +  ti,sysref-mux:
> +    description: |
> +      SYSREF Mux configuration.
> +      Available options are,
> +        Normal SYNC 0
> +        Re-clocked 1
> +        SYSREF Pulser 2
> +        SYSREF Continuous 3
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 3
> +
> +  ti,sync-mode:
> +    description: SYNC pin configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 1
> +
> +  ti,sysref-pulse-count:
> +    description:
> +      Number of SYSREF pulses to send when SYSREF is not in continuous mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    default: 4
> +
> +patternProperties:
> +  "@[0-9a-d]+$":
> +    type: object
> +    description:
> +      Child nodes used to configure output clocks.
> +
> +    properties:
> +      reg:
> +        description:
> +          clock output identifier.
> +        minimum: 0
> +        maximum: 13
> +
> +      ti,clkout-fmt:
> +        description:
> +          Clock output format.
> +          Available options are,
> +            Powerdown 0x00
> +            LVDS 0x01
> +            HSDS 6 mA 0x02
> +            HSDS 8 mA 0x03
> +            LVPECL 1600 mV 0x04
> +            LVPECL 2000 mV 0x05
> +            LCPECL 0x06
> +            CML 16 mA 0x07
> +            CML 24 mA 0x08
> +            CML 32 mA 0x09
> +            CMOS (Off/Inverted) 0x0a
> +            CMOS (Normal/Off) 0x0b
> +            CMOS (Inverted/Inverted) 0x0c
> +            CMOS (Inverted/Normal) 0x0d
> +            CMOS (Normal/Inverted) 0x0e
> +            CMOS (Normal/Normal) 0x0f
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 15
> +
> +      ti,clkout-sysref:
> +        description:
> +          Select SYSREF clock path for output clock.
> +        type: boolean
> +
> +    required:
> +      - reg

       additionalProperties: false

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clocks {
> +        lmk04832_oscin: oscin {
> +            compatible = "fixed-clock";
> +
> +            #clock-cells = <0>;
> +            clock-frequency = <122880000>;
> +            clock-output-names = "lmk04832-oscin";
> +        };
> +    };
> +
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lmk04832: clock-controller@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reg = <0>;
> +
> +            compatible = "ti,lmk04832";
> +            spi-max-frequency = <781250>;
> +
> +            reset-gpios = <&gpio_lmk 0 0 0>;
> +
> +            #clock-cells = <1>;
> +            clocks = <&lmk04832_oscin>;
> +            clock-names = "oscin";
> +
> +            ti,spi-4wire-rdbk = <0>;
> +            ti,vco-hz = <2457600000>;
> +
> +            assigned-clocks =
> +                <&lmk04832 0>, <&lmk04832 1>,
> +                <&lmk04832 2>, <&lmk04832 3>,
> +                <&lmk04832 4>,
> +                <&lmk04832 6>, <&lmk04832 7>,
> +                <&lmk04832 10>, <&lmk04832 11>;
> +            assigned-clock-rates =
> +                <122880000>, <384000>,
> +                <122880000>, <384000>,
> +                <122880000>,
> +                <153600000>, <384000>,
> +                <614400000>, <384000>;
> +
> +            clkout0@0 {
> +                reg = <0>;
> +                ti,clkout-fmt = <0x01>; // LVDS
> +            };
> +
> +            clkout1@1 {
> +                reg = <1>;
> +                ti,clkout-fmt = <0x01>; // LVDS
> +                ti,clkout-sysref;
> +            };
> +        };
> +    };
> -- 
> 2.30.1.489.g328c10930387
> 
