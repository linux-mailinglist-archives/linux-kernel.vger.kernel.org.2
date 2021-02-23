Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28022322322
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 01:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhBWAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:34:28 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39537 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBWAeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:34:25 -0500
Received: by mail-ot1-f46.google.com with SMTP id h22so5600740otr.6;
        Mon, 22 Feb 2021 16:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6e8ECt4GzdZmX7hPURu48fJ5VbBlFHvxfZRdK81DHLU=;
        b=LKyUl2d7gRZfOghefw5tBT465RWFNMhxaSnIYyToZ0wgIEuFH3AtDNtd8OiVZVCF3O
         dh1lZq9vrQ6rH3BQ2vVdOTe3pDd4/jOhizgPlmcA/Rn/FAAzemSfobDhr3mLHvq8Pwvr
         K4yS0ewTwUxT3dybzGXNTY3zm3eLHGW+BxyoObkjoy/YSHNZ5BhVhlVY0z/jvayDEPWP
         FQhXrBTpUqDNk4z68jm2Qb81wRt5VyzYf28eFrkTZ/HXZsa6g8W+jtIaoRG8SuKejsLS
         jI3IeBC7DF0lrxrEjg0J2CX3cEyUUmLHYXbrIznFnRSMtc0klnbINdcn5Ic4mHt6tCa1
         57iA==
X-Gm-Message-State: AOAM532jbcSvM51WKM0oqBJozVUAEr7q7Avc/xO8+9ZntRLLLFVjRcJ6
        rrZrAKIo8TWIz81lNP+XAQ==
X-Google-Smtp-Source: ABdhPJzQpl8jcy/4kKSm+M3B4xzRQ3U5PpZJM0aYWFttE8oKPaSATXderKu5LYK+Z+wvRzYen0g/xw==
X-Received: by 2002:a9d:1429:: with SMTP id h38mr18799676oth.135.1614040423415;
        Mon, 22 Feb 2021 16:33:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm4036084oib.15.2021.02.22.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 16:33:42 -0800 (PST)
Received: (nullmailer pid 2515881 invoked by uid 1000);
        Tue, 23 Feb 2021 00:33:41 -0000
Date:   Mon, 22 Feb 2021 18:33:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: add support for the lmk04832
Message-ID: <20210223003341.GA2508557@robh.at.kernel.org>
References: <20210221194427.1184208-1-liambeguin@gmail.com>
 <20210221194427.1184208-2-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221194427.1184208-2-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 02:44:26PM -0500, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The LMK04832 is an ultra-high performance clock conditioner with JEDEC
> JESD204B support and is also pin compatible with the LMK0482x family of
> devices.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/clock/ti,lmk04832.yaml           |  201 +++

Bindings should be their own patch.

>  drivers/clk/Kconfig                           |    7 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-lmk04832.c                    | 1286 +++++++++++++++++
>  4 files changed, 1495 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
>  create mode 100644 drivers/clk/clk-lmk04832.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> new file mode 100644
> index 000000000000..9c56e37214e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> @@ -0,0 +1,201 @@
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
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +    items:
> +      - description: PLL2 reference clock.
> +
> +  clock-names:
> +    maxItems: 1
> +    items:
> +      - const: oscin
> +
> +  reset-gpios:
> +    description: A connection of the 'reset' gpio line.

That's every 'reset-gpios'. Drop.

> +    maxItems: 1
> +
> +  lmk,spi-4wire-rdbk:

'lmk' is not a vendor. 'ti' is the vendor.

> +    description: |
> +      Select SPI 4wire readback pin configuration.
> +      Available readback pins are,
> +        CLKin_SEL0 0
> +        CLKin_SEL1 1
> +        RESET 2
> +    allOf:

Don't need allOf.

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2]
> +      - default: 1
> +
> +  lmk,vco-rate:
> +    description: VCO rate to use (in Hz).

Use a standard unit suffix (-hz).

> +    $ref: /schemas/types.yaml#/definitions/uint32

Then you can drop the type.

> +
> +  lmk,sysref-ddly:
> +    description: SYSREF digital delay value.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 8
> +      - maximum: 8191
> +      - default: 8
> +
> +  lmk,sysref-mux:
> +    description: |
> +      SYSREF Mux configuration.
> +      Available options are,
> +        Normal SYNC 0
> +        Re-clocked 1
> +        SYSREF Pulser 2
> +        SYSREF Continuous 3
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +      - default: 3
> +
> +  lmk,sync-mode:
> +    description: SYNC pin configuration.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2]
> +      - default: 1
> +
> +  lmk,sysref-pulse-count:
> +    description:
> +      Number of SYSREF pulses to send when SYSREF is not in continuous mode.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 4, 8]
> +      - default: 4
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":

"@[0-9a-d]$"

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
> +      lmk,clkout-fmt:
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
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +          - maximum: 15
> +
> +      lmk,clkout-sysref:
> +        description:
> +          Select SYSREF clock path for output clock.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
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
> +    lmk04832: lmk04832@0 {

clock-controller@0

> +        reg = <0>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        compatible = "ti,lmk04832";
> +        spi-max-frequency = <781250>;
> +
> +        reset-gpios = <&gpio_lmk 0 0 0>;
> +
> +        #clock-cells = <1>;
> +        clocks = <&lmk04832_oscin>;
> +        clock-names = "oscin";
> +
> +        lmk,spi-4wire-rdbk = <0>;
> +        lmk,vco-rate = <2457600000>;
> +
> +        assigned-clocks =
> +            <&lmk04832 0>, <&lmk04832 1>,
> +            <&lmk04832 2>, <&lmk04832 3>,
> +            <&lmk04832 4>,
> +            <&lmk04832 6>, <&lmk04832 7>,
> +            <&lmk04832 10>, <&lmk04832 11>;
> +      assigned-clock-rates =
> +            <122880000>, <384000>,
> +            <122880000>, <384000>,
> +            <122880000>,
> +            <153600000>, <384000>,
> +            <614400000>, <384000>;
> +
> +      clkout0@0 {
> +          reg = <0>;
> +          lmk,clkout-fmt = <0x01>; // LVDS
> +      };
> +
> +      clkout1@1 {
> +          reg = <1>;
> +          lmk,clkout-fmt = <0x01>; // LVDS
> +          lmk,clkout-sysref;
> +      };
> +  };
> +
