Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6D30F288
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhBDLi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:38:28 -0500
Received: from foss.arm.com ([217.140.110.172]:56600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235857AbhBDLgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6787411FB;
        Thu,  4 Feb 2021 03:35:46 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4C483F73B;
        Thu,  4 Feb 2021 03:35:44 -0800 (PST)
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: convert rockchip,dwc3.txt to
 yaml
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210203165233.22177-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <41efd28c-ff64-2b9f-2cdc-ac4aaaeb4611@arm.com>
Date:   Thu, 4 Feb 2021 11:35:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-03 16:52, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> Remove node wrapper.
> 
> Added properties for rk3399 are:
>    power-domains
>    resets
>    reset-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>   .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 103 +++++++++++++++++++++
>   2 files changed, 103 insertions(+), 56 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>   create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
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
> index 000000000..fdf9497bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -0,0 +1,103 @@
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
> +      The common content of the node is defined in snps,dwc3.yaml.
> +
> +      Phy documentation is provided in the following places.
> +
> +      USB2.0 PHY
> +      Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +
> +      Type-C PHY
> +      Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
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
> +          Controller aclk_usb3_rksoc_axi_perf clock

I'm pretty sure these last 3 don't belong to the controller itself, 
hence why they were in the glue layer node to being with.

> +      - description:
> +          Controller aclk_usb3 clock

Does anything in the USB3 block actually consume this clock directly? If 
not, then I don't think it needs to be specified since it's already the 
parent of the controller's required bus_clk.

I'm similarly suspicious of ACLK_USB3_NOC which is currently marked as 
CLK_IGNORE_UNUSED - if that's necessary for USB3 to function then it 
probably *should* be specified as part of the glue layer binding here.

Robin.

> +      - description:
> +          Controller grf clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: suspend_clk
> +      - const: bus_clk
> +      - const: aclk_usb3_rksoc_axi_perf
> +      - const: aclk_usb3
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
> +                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +                 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> +        clock-names = "ref_clk", "suspend_clk",
> +                      "bus_clk", "aclk_usb3_rksoc_axi_perf",
> +                      "aclk_usb3", "grf_clk";
> +        dr_mode = "otg";
> +      };
> +    };
> 
