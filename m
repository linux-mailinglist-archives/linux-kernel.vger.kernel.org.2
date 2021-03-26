Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460634A77D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCZMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:42:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9BC0613AA;
        Fri, 26 Mar 2021 05:42:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so8202124ejc.4;
        Fri, 26 Mar 2021 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZAIADYfQEQgQ6pAWYfIoUHlR7wyZP4QpglxHsThLEiE=;
        b=MCRTcp3UXDyoELLAqOdCfpsxiCrQE10eR3VQdFY9idQ18ORoeuQ3563FaQcFs63KhD
         qTru2NoYOIB4bARIumGI63VHVIzJimrvar/141VSU3QD3lL4xyxP85j1lU3Zdx2ucXn+
         3S9xvDs3zcrKiU9qu7/TXvOZiTrmRwHo/kTP9myjARDqH4YI4E59GjE83alZkBehsDh2
         pns/RAsq5clJfnfnmmIPhxaCJj4voa4dxaQMKF/cx6ZmbbPEGiIeNrySWubljSst8dxZ
         g8ig/n5pRSyaq2H53HSyQM671Nm+hd42mC+E1k5TyUOUFakZHflS8wwh0icm4Yg3k5Qk
         OfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZAIADYfQEQgQ6pAWYfIoUHlR7wyZP4QpglxHsThLEiE=;
        b=YTyIaQl6ZsMySNQTRXXZK+90/q2MciD0AF+Plz8kpMwkfP+q45c2VF/gaQK8wVMJ5c
         FC1lNdO/xJCoiDA2l1pQ81XbIhFqfkNoMs/WrBdL7jC3PecMJWl8Rlgqzlcq3jdli0ne
         HrgSuoe9g5Z62pf5Ka6WprO0O8JVcCHN/n5EqVZb6QqGTw9hgYsjH0eQcredkPxr+Zwl
         LawrVAGHfT7gy4S0z657z3KFtVZMFXf0+kGPH+K67Bzgs0J6lb1FhtGenSxiV7mp/LTp
         Kf0yGrhUSpXEBXqgItvb2pu1ZOiwv/8X5MWFhduAIXSbKiYBXEdL87ozCw3ht188FeP2
         DMgg==
X-Gm-Message-State: AOAM531FZisvY9UTE4L4HapvHiAw1D/HKTUDZDvDDRUd69JD9f5Wxjuu
        I6JCYLfEA+zaL2lw7vaIa6Lb6X4U6Rs7Fw==
X-Google-Smtp-Source: ABdhPJyAF04tIYZCdJ23bEC+iPqN6mxjerkI5RU7SCEEYcJci1Z1UiFYtNQd1rMFi+crISris8BOzg==
X-Received: by 2002:a17:906:b297:: with SMTP id q23mr15273263ejz.315.1616762558603;
        Fri, 26 Mar 2021 05:42:38 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r19sm3853768ejr.55.2021.03.26.05.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 05:42:38 -0700 (PDT)
Subject: Re: [PATCH v6 09/11] dt-bindings: power: rockchip: Convert to
 json-schema
To:     Elaine Zhang <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
References: <20210326102738.14767-1-zhangqing@rock-chips.com>
 <20210326103036.15173-1-zhangqing@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e481e295-0427-045a-7b13-137a7538057e@gmail.com>
Date:   Fri, 26 Mar 2021 13:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210326103036.15173-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 11:30 AM, Elaine Zhang wrote:
> Convert the soc/rockchip/power_domain.txt binding document to
> json-schema and move to the power bindings directory.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Not sure if 'From:' is save to use here at this position for news readers ??

> Link:https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/
> ---
>  .../power/rockchip,power-controller.yaml      | 291 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 --------
>  2 files changed, 291 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000000..9fec9e227432
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -0,0 +1,291 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Power Domains
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenarios to save power.
> +
> +  Power domains contained within power-controller node are generic power domain
> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +  IP cores belonging to a power domain should contain a "power-domains"
> +  property that is a phandle for the power domain node representing the domain.
> +
> +properties:
> +  $nodename:
> +    const: power-controller
> +
> +  compatible:
> +    enum:
> +      - rockchip,px30-power-controller
> +      - rockchip,rk3036-power-controller
> +      - rockchip,rk3066-power-controller
> +      - rockchip,rk3128-power-controller
> +      - rockchip,rk3188-power-controller
> +      - rockchip,rk3228-power-controller
> +      - rockchip,rk3288-power-controller
> +      - rockchip,rk3328-power-controller
> +      - rockchip,rk3366-power-controller
> +      - rockchip,rk3368-power-controller
> +      - rockchip,rk3399-power-controller
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  clocks: true
> +

> +  assigned-clocks:

> +    minItems: 1

Currently rk3288.dtsi has some 'extra' properties.
One of the purposes of this document is to filter bogus properties in dt
files.
With "minItems: 1" you have 1 to 'endless' options.
Better restrict with:

    maxItems: 1

Given this from rk3288.dtsi:
			assigned-clocks = <&cru SCLK_EDP_24M>;
			assigned-clock-parents = <&xin24m>;

Introduced with patch:

ARM: dts: rockchip: Assign RK3288 EDP_24M input centrally

Moved from rk3288-veyron.dtsi
Please advise if they still are needed or not.

Adding new minor properties should be added as note in the commit
message for review by Rob, because it isn't an exact conversion of the
original.

> +
> +  assigned-clock-parents:

> +    minItems: 1

dito

> +
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node as documented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +
> +      "#power-domain-cells":
> +        description:
> +          Must be 0 for nodes representing a single PM domain and 1 for nodes
> +          providing multiple PM domains.
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +        description: |
> +          Power domain index. Valid values are defined in
> +          "include/dt-bindings/power/px30-power.h"
> +          "include/dt-bindings/power/rk3036-power.h"
> +          "include/dt-bindings/power/rk3066-power.h"
> +          "include/dt-bindings/power/rk3128-power.h"
> +          "include/dt-bindings/power/rk3188-power.h"
> +          "include/dt-bindings/power/rk3228-power.h"
> +          "include/dt-bindings/power/rk3288-power.h"
> +          "include/dt-bindings/power/rk3328-power.h"
> +          "include/dt-bindings/power/rk3366-power.h"
> +          "include/dt-bindings/power/rk3368-power.h"
> +          "include/dt-bindings/power/rk3399-power.h"
> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled while power domain
> +          switches state.
> +
> +      pm_qos:
> +        description: |
> +          A number of phandles to qos blocks which need to be saved and restored
> +          while power domain switches state.
> +
> +    patternProperties:
> +      "^power-domain@[0-9a-f]+$":
> +        type: object
> +        description: |
> +          Represents a power domain child within a power domain parent node.
> +
> +        properties:
> +
> +          "#power-domain-cells":
> +            description:
> +              Must be 0 for nodes representing a single PM domain and 1 for nodes
> +              providing multiple PM domains.
> +
> +          "#address-cells":
> +            const: 1
> +
> +          "#size-cells":
> +            const: 0
> +
> +          reg:
> +            maxItems: 1
> +
> +          clocks:
> +            description: |
> +              A number of phandles to clocks that need to be enabled while power domain
> +              switches state.
> +
> +          pm_qos:
> +            description: |
> +              A number of phandles to qos blocks which need to be saved and restored
> +              while power domain switches state.
> +
> +        patternProperties:
> +          "^power-domain@[0-9a-f]+$":
> +            type: object
> +            description: |
> +              Represents a power domain child within a power domain parent node.
> +
> +            properties:
> +
> +              "#power-domain-cells":
> +                description:
> +                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> +                  providing multiple PM domains.
> +
> +              "#address-cells":
> +                const: 1
> +
> +              "#size-cells":
> +                const: 0
> +
> +              reg:
> +                maxItems: 1
> +
> +              clocks:
> +                description: |
> +                  A number of phandles to clocks that need to be enabled while power domain
> +                  switches state.
> +
> +              pm_qos:
> +                description: |
> +                  A number of phandles to qos blocks which need to be saved and restored
> +                  while power domain switches state.
> +
> +            required:
> +              - reg
> +
> +            additionalProperties: false
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        qos_hdcp: qos@ffa90000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffa90000 0x0 0x20>;
> +        };
> +
> +        qos_iep: qos@ffa98000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffa98000 0x0 0x20>;
> +        };
> +
> +        qos_rga_r: qos@ffab0000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab0000 0x0 0x20>;
> +        };
> +
> +        qos_rga_w: qos@ffab0080 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab0080 0x0 0x20>;
> +        };
> +
> +        qos_video_m0: qos@ffab8000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab8000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_r: qos@ffac0000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffac0000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_w: qos@ffac0080 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffac0080 0x0 0x20>;
> +        };
> +
> +        power-management@ff310000 {
> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
> +            reg = <0x0 0xff310000 0x0 0x1000>;
> +
> +            power-controller {
> +                compatible = "rockchip,rk3399-power-controller";
> +                #power-domain-cells = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* These power domains are grouped by VD_CENTER */
> +                 power-domain@RK3399_PD_IEP {
> +                    reg = <RK3399_PD_IEP>;
> +                    clocks = <&cru ACLK_IEP>,
> +                             <&cru HCLK_IEP>;
> +                    pm_qos = <&qos_iep>;
> +                    #power-domain-cells = <0>;
> +                };
> +                 power-domain@RK3399_PD_RGA {
> +                    reg = <RK3399_PD_RGA>;
> +                    clocks = <&cru ACLK_RGA>,
> +                             <&cru HCLK_RGA>;
> +                    pm_qos = <&qos_rga_r>,
> +                             <&qos_rga_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                 power-domain@RK3399_PD_VCODEC {
> +                    reg = <RK3399_PD_VCODEC>;
> +                    clocks = <&cru ACLK_VCODEC>,
> +                             <&cru HCLK_VCODEC>;
> +                    pm_qos = <&qos_video_m0>;
> +                    #power-domain-cells = <0>;
> +                };
> +                 power-domain@RK3399_PD_VDU {
> +                    reg = <RK3399_PD_VDU>;
> +                    clocks = <&cru ACLK_VDU>,
> +                             <&cru HCLK_VDU>;
> +                    pm_qos = <&qos_video_m1_r>,
> +                             <&qos_video_m1_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                 power-domain@RK3399_PD_VIO {
> +                    reg = <RK3399_PD_VIO>;
> +                    #power-domain-cells = <1>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                     power-domain@RK3399_PD_HDCP {
> +                        reg = <RK3399_PD_HDCP>;
> +                        clocks = <&cru ACLK_HDCP>,
> +                                 <&cru HCLK_HDCP>,
> +                                 <&cru PCLK_HDCP>;
> +                        pm_qos = <&qos_hdcp>;
> +                        #power-domain-cells = <0>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> deleted file mode 100644
> index 8304eceb62e4..000000000000
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -* Rockchip Power Domains
> -
> -Rockchip processors include support for multiple power domains which can be
> -powered up/down by software based on different application scenes to save power.
> -
> -Required properties for power domain controller:
> -- compatible: Should be one of the following.
> -	"rockchip,px30-power-controller" - for PX30 SoCs.
> -	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
> -	"rockchip,rk3066-power-controller" - for RK3066 SoCs.
> -	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
> -	"rockchip,rk3188-power-controller" - for RK3188 SoCs.
> -	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
> -	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
> -	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
> -	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
> -	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
> -	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
> -- #power-domain-cells: Number of cells in a power-domain specifier.
> -	Should be 1 for multiple PM domains.
> -- #address-cells: Should be 1.
> -- #size-cells: Should be 0.
> -
> -Required properties for power domain sub nodes:
> -- reg: index of the power domain, should use macros in:
> -	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
> -	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
> -	"include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
> -	"include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
> -	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
> -	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
> -	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
> -	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
> -	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
> -	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
> -- clocks (optional): phandles to clocks which need to be enabled while power domain
> -	switches state.
> -- pm_qos (optional): phandles to qos blocks which need to be saved and restored
> -	while power domain switches state.
> -
> -Qos Example:
> -
> -	qos_gpu: qos_gpu@ffaf0000 {
> -		compatible ="syscon";
> -		reg = <0x0 0xffaf0000 0x0 0x20>;
> -	};
> -
> -Example:
> -
> -	power: power-controller {
> -		compatible = "rockchip,rk3288-power-controller";
> -		#power-domain-cells = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pd_gpu {
> -			reg = <RK3288_PD_GPU>;
> -			clocks = <&cru ACLK_GPU>;
> -			pm_qos = <&qos_gpu>;
> -		};
> -	};
> -
> -	 power: power-controller {
> -                compatible = "rockchip,rk3368-power-controller";
> -                #power-domain-cells = <1>;
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> -
> -                pd_gpu_1 {
> -                        reg = <RK3368_PD_GPU_1>;
> -                        clocks = <&cru ACLK_GPU_CFG>;
> -                };
> -        };
> -
> -Example 2:
> -		power: power-controller {
> -			compatible = "rockchip,rk3399-power-controller";
> -			#power-domain-cells = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			pd_vio {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <RK3399_PD_VIO>;
> -
> -				pd_vo {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -					reg = <RK3399_PD_VO>;
> -
> -					pd_vopb {
> -						reg = <RK3399_PD_VOPB>;
> -					};
> -
> -					pd_vopl {
> -						reg = <RK3399_PD_VOPL>;
> -					};
> -				};
> -			};
> -		};
> -
> -Node of a device using power domains must have a power-domains property,
> -containing a phandle to the power device node and an index specifying which
> -power domain to use.
> -The index should use macros in:
> -	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
> -	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
> -	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
> -	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
> -	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
> -	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
> -	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
> -
> -Example of the node using power domain:
> -
> -	node {
> -		/* ... */
> -		power-domains = <&power RK3288_PD_GPU>;
> -		/* ... */
> -	};
> -
> -	node {
> -                /* ... */
> -                power-domains = <&power RK3368_PD_GPU_1>;
> -                /* ... */
> -        };
> -
> -	node {
> -		/* ... */
> -		power-domains = <&power RK3399_PD_VOPB>;
> -		/* ... */
> -	};
> 

