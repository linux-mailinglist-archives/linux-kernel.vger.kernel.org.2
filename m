Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B303152C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhBIP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:26:04 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38465 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBIPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:23:29 -0500
Received: by mail-oi1-f181.google.com with SMTP id h6so19811474oie.5;
        Tue, 09 Feb 2021 07:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdkRS3Vib+f99aAuZIkfmdf8/nBjJhm3iilrBoLKCLg=;
        b=R4EBlJI05P7XYkE8v+k3ma4bL3fus3q+niQpOAcqAF26sK6agxb7ME+ILScKgyJ6sL
         srk85burPAz1ZG53rsh7L3i8rK0y9adHwrIqSbVi3R8pXRPkddUtPl1xhFM6JeC5E8Ip
         9JcbPdySWP7J2K0O9cMSUU480zV0hydF4qYH0K61IhAECrPTp8xOR7AkHDwxTEgl09bk
         ZBs+6dJtweSP08kdW8o7QwYO43c2aI5DhM9U0yUl/v0kyAHvgTlQlWuXbUk/P2bZDHHe
         +4cWzHHE64mghfXrA/d6AgfWFOj9vfc8wjcyCvDc633YwQqL6c22wcev3Y044difGevq
         R07w==
X-Gm-Message-State: AOAM531Gfjf8VuknCk2Ra0Av0nHOOGIblO9om0aWU6YgXAf1WRuGmi4I
        w7qqC+5JKt6fg0KkxjvkD0A5IJ41cw==
X-Google-Smtp-Source: ABdhPJweWkg0RNGbRHkrsVHVJP6WqRao/H++c8lbgNFtsQTEv65JqaYBMw8rlSV8B5biYBI3ZoU84Q==
X-Received: by 2002:a05:6808:bc3:: with SMTP id o3mr2795912oik.134.1612884167565;
        Tue, 09 Feb 2021 07:22:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s1sm1517007ooj.30.2021.02.09.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:22:45 -0800 (PST)
Received: (nullmailer pid 3781070 invoked by uid 1000);
        Tue, 09 Feb 2021 15:22:44 -0000
Date:   Tue, 9 Feb 2021 09:22:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: usb: convert rockchip,dwc3.txt to
 yaml
Message-ID: <20210209152244.GA3769707@robh.at.kernel.org>
References: <20210206185017.1817-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 07:50:10PM +0100, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> Remove node wrapper.
> 
> Added properties for rk3399 are:
>   power-domains
>   resets
>   reset-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V3:
>   remove aclk_usb3_rksoc_axi_perf
>   remove aclk_usb3
> 
> Changed V2:
>   remove node wrapper
> ---
>  .../devicetree/bindings/usb/rockchip,dwc3.txt      | 56 -------------
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 95 ++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> deleted file mode 100644
> index 945204932..000000000
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Rockchip SuperSpeed DWC3 USB SoC controller
> -
> -Required properties:
> -- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
> -- clocks:	A list of phandle + clock-specifier pairs for the
> -		clocks listed in clock-names
> -- clock-names:	Should contain the following:
> -  "ref_clk"	Controller reference clk, have to be 24 MHz
> -  "suspend_clk"	Controller suspend clk, have to be 24 MHz or 32 KHz
> -  "bus_clk"	Master/Core clock, have to be >= 62.5 MHz for SS
> -		operation and >= 30MHz for HS operation
> -  "grf_clk"	Controller grf clk
> -
> -Required child node:
> -A child node must exist to represent the core DWC3 IP block. The name of
> -the node is not important. The content of the node is defined in dwc3.txt.
> -
> -Phy documentation is provided in the following places:
> -Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml - USB2.0 PHY
> -Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     - Type-C PHY
> -
> -Example device nodes:
> -
> -	usbdrd3_0: usb@fe800000 {
> -		compatible = "rockchip,rk3399-dwc3";
> -		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> -			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk", "grf_clk";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		usbdrd_dwc3_0: dwc3@fe800000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0xfe800000 0x0 0x100000>;
> -			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> -			dr_mode = "otg";
> -		};
> -	};
> -
> -	usbdrd3_1: usb@fe900000 {
> -		compatible = "rockchip,rk3399-dwc3";
> -		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> -			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk", "grf_clk";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		usbdrd_dwc3_1: dwc3@fe900000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0xfe900000 0x0 0x100000>;
> -			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> -			dr_mode = "otg";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> new file mode 100644
> index 000000000..d815aacfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/rockchip,dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SuperSpeed DWC3 USB SoC controller
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description:
> +  The common content of the node is defined in snps,dwc3.yaml.
> +
> +  Phy documentation is provided in the following places.
> +
> +  USB2.0 PHY
> +  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +
> +  Type-C PHY
> +  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +
> +allOf:
> +  - $ref: snps,dwc3.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rk3399-dwc3
> +      - const: snps,dwc3

This will match on all 'snps,dwc3' nodes. You will need a custom 
'select' to only match on rockchip,rk3399-dwc3.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description:
> +          Controller reference clock, must to be 24 MHz
> +      - description:
> +          Controller suspend clock, must to be 24 MHz or 32 KHz
> +      - description:
> +          Master/Core clock, must to be >= 62.5 MHz for SS
> +          operation and >= 30MHz for HS operation
> +      - description:
> +          Controller grf clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: suspend_clk
> +      - const: bus_clk
> +      - const: grf_clk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: usb3-otg
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      usbdrd3_0: usb@fe800000 {
> +        compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
> +        reg = <0x0 0xfe800000 0x0 0x100000>;
> +        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> +                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
> +        clock-names = "ref_clk", "suspend_clk",
> +                      "bus_clk", "grf_clk";
> +        dr_mode = "otg";
> +      };
> +    };
> -- 
> 2.11.0
> 
