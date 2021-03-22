Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8494F344F94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhCVTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhCVTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:03:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31304C061574;
        Mon, 22 Mar 2021 12:03:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so4861036ejz.11;
        Mon, 22 Mar 2021 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nS7FRgbdv9jzkLNC53gBu26ppeGL60bI1cJEtoSx6Q4=;
        b=cy84B8AuA2CqCaMmNm1zSllxGdADGcNXpbhdemnIUroofKmE+81iCJRRQ3uheQdzlu
         TddoX+ru/grVclcYiN5+VpICZ0lg/wdSuP5I/4hmXcLiaEDZMpCuqmzel3tdri5v6Q5e
         rSog0kKkbI2FYd8LmnhtBP3avfl2SCuWwrc87zImU7Gx7T1mK3bWcesQ77Pn8jUOP8IE
         0dLZ66uSWY5waEVNw/EhOgRh+nsbRWVST+GlwijTsDr7U+rmQbm7MrMmIn21hlc2rqBO
         AP+7eRgVKq63Q6uL/NnToR9UaUzO21XQhaCResJHxqfOeUOirICc6VcQK0CtDDpX+9vu
         61FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nS7FRgbdv9jzkLNC53gBu26ppeGL60bI1cJEtoSx6Q4=;
        b=VRzbBuDqpP083NcFfN2a16E8Plhd1PI42r0lh+XKBvEIlsjeq/r14ycbXeTGK1F2CL
         ZDbwGrwjduH9Z0gGiVGd3K58pru2/fwhK3ZFRIRcStLAdN7CII0Usw3PMEXntQvxO4+2
         0hXgw1C5t+mCP6NNDy7B/PQKRm+DPHwFH1+26p/rovNJ3GblpRROIzc0GJqfIpuk0Eyl
         B5D7oGZrKC/IRjjeiooqel+moH0ulyUmyPbz3WAE/OR0mjXtcEtlmlaqL823P+jF+guu
         kQQBChqkJGGE001Rkb2iZ11XeQxTAQtPwL9FOmqDEOBrymDmRVCNnDq8p5PDemZ5juI6
         VYdA==
X-Gm-Message-State: AOAM532CSWFnh29LaDzlnWe0AJOAl+gYWRWkkf0NbgE40ms1bL2Rx7XK
        mHC7Nl2dDnQuSUIpxVCA1GM=
X-Google-Smtp-Source: ABdhPJx+VYqzaOlZ8muPmDOzZLCW3YLYfps8nZreDgEpD0r5b/SxK92p5oynRs5wr6ly6o1dnfW3rw==
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr1296044ejb.244.1616439822903;
        Mon, 22 Mar 2021 12:03:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d1sm10059728eje.26.2021.03.22.12.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 12:03:42 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] dt-bindings: Convert the rockchip power_domain to
 YAML and extend
To:     Elaine Zhang <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
References: <20210317025159.2248-1-zhangqing@rock-chips.com>
 <20210317025159.2248-3-zhangqing@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <79a19747-0dcf-5bc7-6c1f-3a76df9b1002@gmail.com>
Date:   Mon, 22 Mar 2021 20:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210317025159.2248-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Some comments. Have a look if it's useful or that you disagree with...

On 3/17/21 3:51 AM, Elaine Zhang wrote:
> This converts the rockchip power domain family bindings to YAML schema,
> and add binding documentation for the power domains found on Rockchip
> RK3568 SoCs.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>  .../rockchip/rockchip,power-controller.yaml   | 196 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 136 deletions(-)
>  delete mode 100644
Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>  create mode 100644
Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
>
> diff --git
a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> deleted file mode 100644
> index 8304eceb62e4..000000000000
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ /dev/null
> @@ -1,136 +0,0 @@
> -* Rockchip Power Domains
> -
> -Rockchip processors include support for multiple power domains which
can be
> -powered up/down by software based on different application scenes to
save power.
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
> -	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power
domain.
> -	"include/dt-bindings/power/rk3066-power.h" - for RK3066 type power
domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power
domain.
> -	"include/dt-bindings/power/rk3188-power.h" - for RK3188 type power
domain.
> -	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power
domain.
> -	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power
domain.
> -	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power
domain.
> -	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power
domain.
> -	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power
domain.
> -	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power
domain.
> -- clocks (optional): phandles to clocks which need to be enabled
while power domain
> -	switches state.
> -- pm_qos (optional): phandles to qos blocks which need to be saved
and restored
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
> -containing a phandle to the power device node and an index specifying
which
> -power domain to use.
> -The index should use macros in:
> -	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
> -	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power
domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power
domain.
> -	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power
domain.
> -	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power
domain.
> -	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power
domain.
> -	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power
domain.
> -	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power
domain.
> -	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power
domain.
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
> diff --git
a/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000000..c9c8058d17ab
> --- /dev/null
> +++
b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# %YAML 1.2
> +---
> +$id: http://devicetree.org/soc/rockchip/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rcokchip Generic PM domains
Rockchip
Maybe use correct company name?

> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains
which can be
> +  powered up/down by software based on different application scenes
to save power.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for SCPSYS node representing the domain.
what's SCPSYS?
Maybe reword phrase?

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
> +      - rockchip,rk3568-power-controller
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node
as documented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +
> +      '#power-domain-cells':
> +        description:
> +          Must be 0 for nodes representing a single PM domain and 1
for nodes
> +          providing multiple PM domains.
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
in the files with the SoC name as prefix in the file name below.
improve phrase

> +              "include/dt-bindings/power/px30-power.h" - for PX30
type power domain.
> +              "include/dt-bindings/power/rk3036-power.h" - for RK3036
type power domain.
> +              "include/dt-bindings/power/rk3066-power.h" - for RK3066
type power domain.
> +              "include/dt-bindings/power/rk3128-power.h" - for RK3128
type power domain.
> +              "include/dt-bindings/power/rk3188-power.h" - for RK3188
type power domain.
> +              "include/dt-bindings/power/rk3228-power.h" - for RK3228
type power domain.
> +              "include/dt-bindings/power/rk3288-power.h" - for RK3288
type power domain.
> +              "include/dt-bindings/power/rk3328-power.h" - for RK3328
type power domain.
> +              "include/dt-bindings/power/rk3366-power.h" - for RK3366
type power domain.
> +              "include/dt-bindings/power/rk3368-power.h" - for RK3368
type power domain.
> +              "include/dt-bindings/power/rk3399-power.h" - for RK3399
type power domain.
> +              "include/dt-bindings/power/rk3568-power.h" - for RK3568
type power domain.
The phrase "for RK3568 type power domain" repeats the file name.
Maybe reduce a little bit of text?

> +        maxItems: 1
move up below reg:

> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled
during domain
> +          power-up sequencing.
> +
> +      clock-names:
> +        description: |
> +          List of names of clocks, in order to match the power-up
sequencing
> +          for each power domain we need to group the clocks by name.
BASIC
> +          clocks need to be enabled before enabling the corresponding
power
> +          domain.
> +
> +      pm_qos:
> +        description: |
> +          A number of phandles for qos registers that need to be save
and restor during domain
QoS is an abriviation
saved
restored

> +          power-up sequencing.
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
#include <dt-bindings/clock/rk3568-cru.h>
#include <dt-bindings/power/rk3568-power.h>

Please check example with script before submitting and fix!

> +    pmu: power-management@fdd90000 {
> +        compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
> +        reg = <0xfdd90000 0x1000>;
> +
> +        power: power-controller {
> +            compatible = "rockchip,rk3568-power-controller";
> +            #power-domain-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            status = "okay";
no status in examples

> +
> +            /* These power domains are grouped by VD_NPU */
> +            pd_npu@RK3568_PD_NPU {
> +                reg = <RK3568_PD_NPU>;
> +                clocks = <&cru ACLK_NPU_PRE>,
> +                         <&cru HCLK_NPU_PRE>,
> +                         <&cru PCLK_NPU_PRE>;
> +                pm_qos = <&qos_npu>;
> +            };
> +            /* These power domains are grouped by VD_GPU */
> +            pd_gpu@RK3568_PD_GPU {
> +                reg = <RK3568_PD_GPU>;
> +                clocks = <&cru ACLK_GPU_PRE>,
> +                         <&cru PCLK_GPU_PRE>;
> +                pm_qos = <&qos_gpu>;
> +            };
> +            /* These power domains are grouped by VD_LOGIC */
> +            pd_vi@RK3568_PD_VI {
> +                reg = <RK3568_PD_VI>;
> +                clocks = <&cru HCLK_VI>,
> +                         <&cru PCLK_VI>;
> +                pm_qos = <&qos_isp>,
> +                         <&qos_vicap0>,
> +                         <&qos_vicap1>;
> +            };
> +            pd_vo@RK3568_PD_VO {
> +                reg = <RK3568_PD_VO>;
> +                clocks = <&cru HCLK_VO>,
> +                         <&cru PCLK_VO>,
> +                         <&cru ACLK_VOP_PRE>;
> +                pm_qos = <&qos_hdcp>,
> +                         <&qos_vop_m0>,
> +                         <&qos_vop_m1>;
> +            };
> +            pd_rga@RK3568_PD_RGA {
> +                reg = <RK3568_PD_RGA>;
> +                clocks = <&cru HCLK_RGA_PRE>,
> +                         <&cru PCLK_RGA_PRE>;
> +                pm_qos = <&qos_ebc>,
> +                         <&qos_iep>,
> +                         <&qos_jpeg_dec>,
> +                         <&qos_jpeg_enc>,
> +                         <&qos_rga_rd>,
> +                         <&qos_rga_wr>;
> +            };
> +            pd_vpu@RK3568_PD_VPU {
> +                reg = <RK3568_PD_VPU>;
> +                clocks = <&cru HCLK_VPU_PRE>;
> +                pm_qos = <&qos_vpu>;
> +            };
> +            pd_rkvdec@RK3568_PD_RKVDEC {
> +                clocks = <&cru HCLK_RKVDEC_PRE>;
> +                reg = <RK3568_PD_RKVDEC>;
> +                pm_qos = <&qos_rkvdec>;
> +            };
> +            pd_rkvenc@RK3568_PD_RKVENC {
> +                reg = <RK3568_PD_RKVENC>;
> +                clocks = <&cru HCLK_RKVENC_PRE>;
> +                pm_qos = <&qos_rkvenc_rd_m0>,
> +                <&qos_rkvenc_rd_m1>,
> +                <&qos_rkvenc_wr_m0>;
> +            };
> +            pd_pipe@RK3568_PD_PIPE {
> +                reg = <RK3568_PD_PIPE>;
> +                clocks = <&cru PCLK_PIPE>;
> +                pm_qos = <&qos_pcie2x1>,
> +                         <&qos_pcie3x1>,
> +                         <&qos_pcie3x2>,
> +                         <&qos_sata0>,
> +                         <&qos_sata1>,
> +                         <&qos_sata2>,
> +                         <&qos_usb3_0>,
> +                         <&qos_usb3_1>;
> +            };
> +        };
> +    };
>
