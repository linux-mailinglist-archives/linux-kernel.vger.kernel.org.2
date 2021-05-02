Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B93370B10
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEBKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhEBKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 06:14:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2129C06174A;
        Sun,  2 May 2021 03:13:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d14so2981860edc.12;
        Sun, 02 May 2021 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48GWeQ4QniJrKGm3JwxR/c0DzkhIGl/Ne+clIxhm6Dg=;
        b=my+r8MxxzYbb/P81J6yrJAfEmAMa2g/6PAdLn740O+zs0wytR9sLdv0L8/11nDEAB4
         G4pT1ZxtAcDxjf3tM1pAi9/AKr230muFcpDfK+ukekpaueb4W4YszxnjDDGXk9CDdmwg
         k10nByvVzJQmifJV5IhpV4rlm4Gb+GncFL6bJzxb4rD7SFLcLwPlIfPVKjMSMdSImNkQ
         HOyGwEq/8qB82wRi/osLKLPQhv1YvwLR43b9dokEdGLafwnP7zTrykk1x+Dt3a30k4Cg
         HF4TbwtwQ9xW2mf9HGzsWhc81C14+X9pKk4YVECTqycCKU73/t6gZ0wMAlaJzfNctGLB
         ElwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48GWeQ4QniJrKGm3JwxR/c0DzkhIGl/Ne+clIxhm6Dg=;
        b=MyueubzGKA75XKo3k0a2iU9D/CyJwoUbTQ+UYwQyAXYto2Qkofk0y/JAZLvDHljZwG
         pKsBmNTDQfFSVIW1raHNaHbeM4nGbNWJvZRxV5Zc7LJtxZ+ClyNlMoZx8ZYWFVLgUrgZ
         459UFIKho9WL/OcQjsPnhwRHDq3Qkwx4R9/buMU26q7wlM4hxsL+tUNY9r8GLu2ld8yb
         wVRlCUi6tJZDn+ni7i6MRBABYTySETuaP200dFsFmahKGOb+EmkY+RTdK+tmkm725rGf
         xXm9JFGY0q2+6/OiyAY1tFBrbw0FsW/+VmeuQaT47pjH130ujnO4UgvCGWYeIRnFRiLx
         5HkA==
X-Gm-Message-State: AOAM531zbwSiP99w2P7C2GrlQHAKGa9jsEfe3F5D8Vh4T64ObyAImsZM
        LrDhc2aCFTtVYwoSy66GNfFDUj6mtVcs8w==
X-Google-Smtp-Source: ABdhPJyJtO+ytghu7OOFqvWoOVxFdwTT0KLDg12T5kUCTszYqKaButm/KODD0mahWCw/90+sUErPZw==
X-Received: by 2002:aa7:d594:: with SMTP id r20mr14578107edq.242.1619950396343;
        Sun, 02 May 2021 03:13:16 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u6sm8158590ejn.14.2021.05.02.03.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 03:13:16 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: rockchip: convert grf.txt to
 YAML
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     cl@rock-chips.com, jay.xu@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        shawn.lin@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210501203520.5465-1-jbx6244@gmail.com>
Message-ID: <45d7aa00-1879-cc6e-df9b-fe1ed83a4531@gmail.com>
Date:   Sun, 2 May 2021 12:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210501203520.5465-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Heiko,

This patch relies on rockchip,power-controller.yaml, but a look in
MAINTAINERS show that no one seems responsible.
Who should apply?

===

This patch makes use of phy-rockchip-inno-usb2.yaml

Given response in:

dt-bindings: phy: convert phy-rockchip-inno-usb2 bindings to yaml
https://lore.kernel.org/linux-rockchip/20200319171305.GA19150@bogus/

'#phy-cells' was added to the example.

A proposal to add that to usb2-phy nodes was never accepted,
so dtbs_check continuous to generate notifications.

ARM: dts: rockchip: add #phy-cells to all usb2-phy nodes
https://lore.kernel.org/linux-rockchip/20200401073725.6063-1-jbx6244@gmail.com/

===

A issue was filed, but nothing fixed.

phys with subnodes and #phy-cells requirement #22
https://github.com/devicetree-org/dt-schema/issues/22

===

Please advise.

Johan

On 5/1/21 10:35 PM, Johan Jonker wrote:
> Current dts files with 'grf' nodes are manually verified.
> In order to automate this process grf.txt has to be
> converted to YAML.
> 
> Most compatibility strings are in use with "simple-mfd" added.
> 
> Add description already in use:
> "rockchip,rv1108-pmugrf", "syscon"
> 
> Add new descriptions for:
> "rockchip,rk3568-grf", "syscon", "simple-mfd"
> "rockchip,rk3568-pmugrf", "syscon", "simple-mfd"
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/soc/rockchip/grf.txt       |  61 -----
>  .../devicetree/bindings/soc/rockchip/grf.yaml      | 277 +++++++++++++++++++++
>  2 files changed, 277 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
> deleted file mode 100644
> index f96511aa3..000000000
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -* Rockchip General Register Files (GRF)
> -
> -The general register file will be used to do static set by software, which
> -is composed of many registers for system control.
> -
> -From RK3368 SoCs, the GRF is divided into two sections,
> -- GRF, used for general non-secure system,
> -- SGRF, used for general secure system,
> -- PMUGRF, used for always on system
> -
> -On RK3328 SoCs, the GRF adds a section for USB2PHYGRF,
> -
> -ON RK3308 SoC, the GRF is divided into four sections:
> -- GRF, used for general non-secure system,
> -- SGRF, used for general secure system,
> -- DETECTGRF, used for audio codec system,
> -- COREGRF, used for pvtm,
> -
> -Required Properties:
> -
> -- compatible: GRF should be one of the following:
> -   - "rockchip,px30-grf", "syscon": for px30
> -   - "rockchip,rk3036-grf", "syscon": for rk3036
> -   - "rockchip,rk3066-grf", "syscon": for rk3066
> -   - "rockchip,rk3188-grf", "syscon": for rk3188
> -   - "rockchip,rk3228-grf", "syscon": for rk3228
> -   - "rockchip,rk3288-grf", "syscon": for rk3288
> -   - "rockchip,rk3308-grf", "syscon": for rk3308
> -   - "rockchip,rk3328-grf", "syscon": for rk3328
> -   - "rockchip,rk3368-grf", "syscon": for rk3368
> -   - "rockchip,rk3399-grf", "syscon": for rk3399
> -   - "rockchip,rv1108-grf", "syscon": for rv1108
> -- compatible: DETECTGRF should be one of the following:
> -   - "rockchip,rk3308-detect-grf", "syscon": for rk3308
> -- compatilbe: COREGRF should be one of the following:
> -   - "rockchip,rk3308-core-grf", "syscon": for rk3308
> -- compatible: PMUGRF should be one of the following:
> -   - "rockchip,px30-pmugrf", "syscon": for px30
> -   - "rockchip,rk3368-pmugrf", "syscon": for rk3368
> -   - "rockchip,rk3399-pmugrf", "syscon": for rk3399
> -- compatible: SGRF should be one of the following:
> -   - "rockchip,rk3288-sgrf", "syscon": for rk3288
> -- compatible: USB2PHYGRF should be one of the following:
> -   - "rockchip,px30-usb2phy-grf", "syscon": for px30
> -   - "rockchip,rk3328-usb2phy-grf", "syscon": for rk3328
> -- compatible: USBGRF should be one of the following:
> -   - "rockchip,rv1108-usbgrf", "syscon": for rv1108
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -
> -Example: GRF and PMUGRF of RK3399 SoCs
> -
> -	pmugrf: syscon@ff320000 {
> -		compatible = "rockchip,rk3399-pmugrf", "syscon";
> -		reg = <0x0 0xff320000 0x0 0x1000>;
> -	};
> -
> -	grf: syscon@ff770000 {
> -		compatible = "rockchip,rk3399-grf", "syscon";
> -		reg = <0x0 0xff770000 0x0 0x10000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> new file mode 100644
> index 000000000..3f66328a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -0,0 +1,277 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip General Register Files (GRF)
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,px30-grf
> +          - rockchip,px30-pmugrf
> +          - rockchip,px30-usb2phy-grf
> +          - rockchip,rk3036-grf
> +          - rockchip,rk3066-grf
> +          - rockchip,rk3188-grf
> +          - rockchip,rk3228-grf
> +          - rockchip,rk3288-grf
> +          - rockchip,rk3288-sgrf
> +          - rockchip,rk3308-core-grf
> +          - rockchip,rk3308-detect-grf
> +          - rockchip,rk3308-grf
> +          - rockchip,rk3328-grf
> +          - rockchip,rk3328-usb2phy-grf
> +          - rockchip,rk3368-grf
> +          - rockchip,rk3368-pmugrf
> +          - rockchip,rk3399-grf
> +          - rockchip,rk3399-pmugrf
> +          - rockchip,rk3568-grf
> +          - rockchip,rk3568-pmugrf
> +          - rockchip,rv1108-grf
> +          - rockchip,rv1108-pmugrf
> +          - rockchip,rv1108-usbgrf
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - rockchip,rk3066-grf
> +              - rockchip,rk3188-grf
> +              - rockchip,rk3288-sgrf
> +              - rockchip,rv1108-pmugrf
> +              - rockchip,rv1108-usbgrf
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - rockchip,px30-grf
> +              - rockchip,px30-pmugrf
> +              - rockchip,px30-usb2phy-grf
> +              - rockchip,rk3036-grf
> +              - rockchip,rk3228-grf
> +              - rockchip,rk3288-grf
> +              - rockchip,rk3308-core-grf
> +              - rockchip,rk3308-detect-grf
> +              - rockchip,rk3308-grf
> +              - rockchip,rk3328-grf
> +              - rockchip,rk3328-usb2phy-grf
> +              - rockchip,rk3368-grf
> +              - rockchip,rk3368-pmugrf
> +              - rockchip,rk3399-grf
> +              - rockchip,rk3399-pmugrf
> +              - rockchip,rk3568-grf
> +              - rockchip,rk3568-pmugrf
> +              - rockchip,rv1108-grf
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,px30-grf
> +
> +    then:
> +      properties:
> +        lvds:
> +          description:
> +            Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3288-grf
> +
> +    then:
> +      properties:
> +        edp-phy:
> +          description:
> +            Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> +
> +        usbphy:
> +          description:
> +            Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3328-grf
> +
> +    then:
> +      properties:
> +        grf-gpio:
> +          description:
> +            Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt
> +
> +        power-controller:
> +          type: object
> +
> +          $ref: "/schemas/power/rockchip,power-controller.yaml#"
> +
> +          unevaluatedProperties: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3399-grf
> +
> +    then:
> +      properties:
> +        mipi-dphy-rx0:
> +          type: object
> +
> +          $ref: "/schemas/phy/rockchip-mipi-dphy-rx0.yaml#"
> +
> +          unevaluatedProperties: false
> +
> +        pcie-phy:
> +          description:
> +            Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
> +
> +      patternProperties:
> +        "phy@[0-9a-f]+$":
> +          description:
> +            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-pmugrf
> +              - rockchip,rk3036-grf
> +              - rockchip,rk3308-grf
> +              - rockchip,rk3368-pmugrf
> +
> +    then:
> +      properties:
> +        reboot-mode:
> +          type: object
> +
> +          $ref: "/schemas/power/reset/syscon-reboot-mode.yaml#"
> +
> +          unevaluatedProperties: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-usb2phy-grf
> +              - rockchip,rk3228-grf
> +              - rockchip,rk3328-usb2phy-grf
> +              - rockchip,rk3399-grf
> +              - rockchip,rv1108-grf
> +
> +    then:
> +      properties:
> +        "#address-cells":
> +          const: 1
> +
> +        "#size-cells":
> +          const: 1
> +
> +      required:
> +        - "#address-cells"
> +        - "#size-cells"
> +
> +      patternProperties:
> +        "usb2-phy@[0-9a-f]+$":
> +          type: object
> +
> +          $ref: "/schemas/phy/phy-rockchip-inno-usb2.yaml#"
> +
> +          unevaluatedProperties: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-pmugrf
> +              - rockchip,px30-grf
> +              - rockchip,rk3228-grf
> +              - rockchip,rk3288-grf
> +              - rockchip,rk3328-grf
> +              - rockchip,rk3368-pmugrf
> +              - rockchip,rk3368-grf
> +              - rockchip,rk3399-pmugrf
> +              - rockchip,rk3399-grf
> +
> +    then:
> +      properties:
> +        io-domains:
> +          description:
> +            Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> +
> +          unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +    grf: syscon@ff770000 {
> +      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
> +      reg = <0xff770000 0x10000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      mipi_dphy_rx0: mipi-dphy-rx0 {
> +        compatible = "rockchip,rk3399-mipi-dphy-rx0";
> +        clocks = <&cru SCLK_MIPIDPHY_REF>,
> +                 <&cru SCLK_DPHY_RX0_CFG>,
> +                 <&cru PCLK_VIO_GRF>;
> +        clock-names = "dphy-ref", "dphy-cfg", "grf";
> +        power-domains = <&power RK3399_PD_VIO>;
> +        #phy-cells = <0>;
> +      };
> +
> +      u2phy0: usb2-phy@e450 {
> +        compatible = "rockchip,rk3399-usb2phy";
> +        reg = <0xe450 0x10>;
> +        clocks = <&cru SCLK_USB2PHY0_REF>;
> +        clock-names = "phyclk";
> +        #clock-cells = <0>;
> +        clock-output-names = "clk_usbphy0_480m";
> +        #phy-cells = <0>;
> +
> +        u2phy0_host: host-port {
> +          #phy-cells = <0>;
> +          interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
> +          interrupt-names = "linestate";
> +         };
> +
> +        u2phy0_otg: otg-port {
> +          #phy-cells = <0>;
> +          interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
> +                       <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
> +                       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
> +          interrupt-names = "otg-bvalid", "otg-id",
> +                            "linestate";
> +        };
> +      };
> +    };
> 
