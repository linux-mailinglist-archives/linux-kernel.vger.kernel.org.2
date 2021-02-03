Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230D30E451
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhBCUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBCUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:46:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39671C06178A;
        Wed,  3 Feb 2021 12:45:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q2so1315303edi.4;
        Wed, 03 Feb 2021 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMmfcO/AZRyYFfYSGaN+T619JHB1KRYF9FquTjBISLc=;
        b=kyIilSPW7nOlg/PaY1n5KUud5IPBsZimQfmhqkZfK8qI8I/gUAB0FDoY/6dHW9qoVo
         O5S4BQJ6PuyliWi7SnLgMshXNz9GVXvswyxmc4wXDDYXud0By2lvdBIp3417h8a5SLCz
         fAFfIaaM8nRNxKXaXJN9aLyM9cp34ZAm0MRpRTOMN+q/m6JICnOzVqMxAR0eeLCfqThq
         GB20139o5V19wYpc8GNHDBjxlJ8ej0gNXlwMj7nMqHRrtyaAD/2XlE1lbHaVA3MsDbas
         LVqyRzhTQ2XCLDCXydUk27gK7iU0HyksHyqo4Zcbu8YRN00yZqxRwZl0lUe/Phb0hszu
         5KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMmfcO/AZRyYFfYSGaN+T619JHB1KRYF9FquTjBISLc=;
        b=ae0xT+b1OKpKHn4QAjP0H7wVYFidohd6qHSPruJoTkA4eIcUk4AesncdJb+wbO/vmI
         RvoCYZzw8Pj031Z/RKdwXEMAQgK2mIcJhFGxYb7VUumHodGsxTC0SqZZsl0x16tOinWN
         GTndsRETTHLyhf/BSEpdkhXLxdtedQN+2NIpi3U2OrkUEfJOjw1EHd4l8YFFWwSCAQk4
         8Rj3WFQnmd+VO7VJ/Cb1SdTR6w7ROS8iMSPeVztVvohJC1iSL0zdkAaiJWCJ21T9hJLD
         1lgnWnXlrcHey9Devuc+gCg6aVySIvXrWBCy4lpiH9HqOh1P6+YzxLHmp5JVI52PmYRa
         36Wg==
X-Gm-Message-State: AOAM533z62SQDJt5Gsdl7OZS3fyJdpziByyjTdprGad9hIpGOqUXR9mP
        f82jKxHQDQA5hSOFNBcOUcq8+KY0fr0=
X-Google-Smtp-Source: ABdhPJyIM0iDtjZHLtqWxu2EzV907xvDuhKhWtz7iCuvodfHQp2cDGjU8WMfIBsw2OVzuyaoxkd22Q==
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr4984026edb.233.1612385112898;
        Wed, 03 Feb 2021 12:45:12 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r9sm1452666eju.74.2021.02.03.12.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 12:45:12 -0800 (PST)
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: convert rockchip,dwc3.txt to
 yaml
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210203165233.22177-1-jbx6244@gmail.com>
Message-ID: <597269b3-3fc4-85a1-fecd-7ee2816e228b@gmail.com>
Date:   Wed, 3 Feb 2021 21:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Heiko,

Version 2 without node wrapper.
Is that OK for backwards compatibility?
New SoC rk3568 and rk3566 in the manufacturer tree also seem to use dwc3
usb, so now only a rk3399 node restyle in mainline with conversion to yaml.

On 2/3/21 5:52 PM, Johan Jonker wrote:
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
>  .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 103 +++++++++++++++++++++
>  2 files changed, 103 insertions(+), 56 deletions(-)
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

wrong indentation: expected 2 but found 6  (indentation)

yamllint ./Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml


This warning doesn't seem to show up with the command below.

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml

> +
> +allOf:

> +  - $ref: snps,dwc3.yaml#

No warning is given here with dt_binding_check.

From patchwork log:
Unknown file referenced: [Errno 2] No such file or directory:
'/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'

/////

What's the correct format?

- $ref: snps,dwc3.yaml#

or

- $ref: "snps,dwc3.yaml#"

/////

This serie is for linux-next.
What kernel version does patchwork work test with?

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210203165233.22177-1-jbx6244@gmail.com/

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
> +      - description:
> +          Controller aclk_usb3 clock
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

