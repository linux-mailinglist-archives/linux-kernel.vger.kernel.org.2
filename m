Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74233475A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhCXKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:14:53 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:39402 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhCXKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:14:29 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 6460BD68;
        Wed, 24 Mar 2021 18:14:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1826T139669733877504S1616580848215820_;
        Wed, 24 Mar 2021 18:14:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f22c26093101f93084f537449d599e29>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: enric.balletbo@collabora.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v4 2/4] dt-bindings: power: rockchip: Convert to
 json-schema
To:     Johan Jonker <jbx6244@gmail.com>, robh+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210324071609.7531-1-zhangqing@rock-chips.com>
 <20210324071609.7531-3-zhangqing@rock-chips.com>
 <be921bd8-a878-3131-15a7-27400786e67a@gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <42489358-8a3e-698e-7d10-816899de75cd@rock-chips.com>
Date:   Wed, 24 Mar 2021 18:14:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <be921bd8-a878-3131-15a7-27400786e67a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Johan:

在 2021/3/24 下午5:17, Johan Jonker 写道:
> Hi Elaine,
>
> >From Rob's build log it turns out that 2 more properties must be added.
> Add these new properties in separate patch.
> Retest with commands below.
> ====
> See rk3288.dtsi
>
> 			assigned-clocks = <&cru SCLK_EDP_24M>;
> 			assigned-clock-parents = <&xin24m>;
This should not be in the power node.
It should be on the CRU node, or on the EDP's own node.
I could have added it just to solve dtbs_check .
> ====
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210324071609.7531-3-zhangqing@rock-chips.com/
>
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>
> On 3/24/21 8:16 AM, Elaine Zhang wrote:
>> Convert the soc/rockchip/power_domain.txt binding document to
>> json-schema and move to the power bindings directory.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../power/rockchip,power-controller.yaml      | 284 ++++++++++++++++++
>>   .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>>   2 files changed, 284 insertions(+), 136 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> new file mode 100644
>> index 000000000000..a220322c5139
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>> @@ -0,0 +1,284 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip Power Domains
>> +
>> +maintainers:
>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>> +  - Rob Herring <robh+dt@kernel.org>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |
>> +  Rockchip processors include support for multiple power domains which can be
>> +  powered up/down by software based on different application scenarios to save power.
>> +
>> +  Power domains contained within power-controller node are generic power domain
>> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +  IP cores belonging to a power domain should contain a "power-domains"
>> +  property that is a phandle for the power domain node representing the domain.
>> +
>> +properties:
>> +  $nodename:
>> +    const: power-controller
>> +
>> +  compatible:
>> +    enum:
>> +      - rockchip,px30-power-controller
>> +      - rockchip,rk3036-power-controller
>> +      - rockchip,rk3066-power-controller
>> +      - rockchip,rk3128-power-controller
>> +      - rockchip,rk3188-power-controller
>> +      - rockchip,rk3228-power-controller
>> +      - rockchip,rk3288-power-controller
>> +      - rockchip,rk3328-power-controller
>> +      - rockchip,rk3366-power-controller
>> +      - rockchip,rk3368-power-controller
>> +      - rockchip,rk3399-power-controller
>> +
>> +  "#power-domain-cells":
>> +    const: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>
> assigned-clocks:
>    maxItems: 1
>
> assigned-clock-parents:
>    maxItems: 1
>
>> +
>> +patternProperties:
>> +  "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
>> +    type: object
>> +    description: |
>> +      Represents the power domains within the power controller node as documented
>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +    properties:
>> +
>> +      "#power-domain-cells":
>> +        description:
>> +          Must be 0 for nodes representing a single PM domain and 1 for nodes
>> +          providing multiple PM domains.
>> +
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +      reg:
>> +        maxItems: 1
>> +        description: |
>> +          Power domain index. Valid values are defined in
>> +          "include/dt-bindings/power/px30-power.h"
>> +          "include/dt-bindings/power/rk3036-power.h"
>> +          "include/dt-bindings/power/rk3066-power.h"
>> +          "include/dt-bindings/power/rk3128-power.h"
>> +          "include/dt-bindings/power/rk3188-power.h"
>> +          "include/dt-bindings/power/rk3228-power.h"
>> +          "include/dt-bindings/power/rk3288-power.h"
>> +          "include/dt-bindings/power/rk3328-power.h"
>> +          "include/dt-bindings/power/rk3366-power.h"
>> +          "include/dt-bindings/power/rk3368-power.h"
>> +          "include/dt-bindings/power/rk3399-power.h"
>> +
>> +      clocks:
>> +        description: |
>> +          A number of phandles to clocks that need to be enabled while power domain
>> +          switches state.
>> +
>> +      pm_qos:
>> +        description: |
>> +          A number of phandles to qos blocks which need to be saved and restored
>> +          while power domain switches state.
>> +
>> +    patternProperties:
>> +      "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
>> +        type: object
>> +        description: |
>> +          Represents a power domain child within a power domain parent node.
>> +
>> +        properties:
>> +
>> +          "#power-domain-cells":
>> +            description:
>> +              Must be 0 for nodes representing a single PM domain and 1 for nodes
>> +              providing multiple PM domains.
>> +
>> +          "#address-cells":
>> +            const: 1
>> +
>> +          "#size-cells":
>> +            const: 0
>> +
>> +          reg:
>> +            maxItems: 1
>> +
>> +          clocks:
>> +            description: |
>> +              A number of phandles to clocks that need to be enabled while power domain
>> +              switches state.
>> +
>> +          pm_qos:
>> +            description: |
>> +              A number of phandles to qos blocks which need to be saved and restored
>> +              while power domain switches state.
>> +
>> +        patternProperties:
>> +          "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
>> +            type: object
>> +            description: |
>> +              Represents a power domain child within a power domain parent node.
>> +
>> +            properties:
>> +
>> +              "#power-domain-cells":
>> +                description:
>> +                  Must be 0 for nodes representing a single PM domain and 1 for nodes
>> +                  providing multiple PM domains.
>> +
>> +              "#address-cells":
>> +                const: 1
>> +
>> +              "#size-cells":
>> +                const: 0
>> +
>> +              reg:
>> +                maxItems: 1
>> +
>> +              clocks:
>> +                description: |
>> +                  A number of phandles to clocks that need to be enabled while power domain
>> +                  switches state.
>> +
>> +              pm_qos:
>> +                description: |
>> +                  A number of phandles to qos blocks which need to be saved and restored
>> +                  while power domain switches state.
>> +
>> +            required:
>> +              - reg
>> +
>> +            additionalProperties: false
>> +
>> +        required:
>> +          - reg
>> +
>> +        additionalProperties: false
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - "#power-domain-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3399-cru.h>
>> +    #include <dt-bindings/power/rk3399-power.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        qos_hdcp: qos@ffa90000 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffa90000 0x0 0x20>;
>> +        };
>> +
>> +        qos_iep: qos@ffa98000 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffa98000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_r: qos@ffab0000 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffab0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_rga_w: qos@ffab0080 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffab0080 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m0: qos@ffab8000 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffab8000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_r: qos@ffac0000 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffac0000 0x0 0x20>;
>> +        };
>> +
>> +        qos_video_m1_w: qos@ffac0080 {
>> +            compatible = "rockchip,rk3399-qos", "syscon";
>> +            reg = <0x0 0xffac0080 0x0 0x20>;
>> +        };
>> +
>> +        power-management@ff310000 {
>> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
>> +            reg = <0x0 0xff310000 0x0 0x1000>;
>> +
>> +            power-controller {
>> +                compatible = "rockchip,rk3399-power-controller";
>> +                #power-domain-cells = <1>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                /* These power domains are grouped by VD_CENTER */
>> +                pd_iep@RK3399_PD_IEP {
>> +                    reg = <RK3399_PD_IEP>;
>> +                    clocks = <&cru ACLK_IEP>,
>> +                             <&cru HCLK_IEP>;
>> +                    pm_qos = <&qos_iep>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                pd_rga@RK3399_PD_RGA {
>> +                    reg = <RK3399_PD_RGA>;
>> +                    clocks = <&cru ACLK_RGA>,
>> +                             <&cru HCLK_RGA>;
>> +                    pm_qos = <&qos_rga_r>,
>> +                             <&qos_rga_w>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                pd_vcodec@RK3399_PD_VCODEC {
>> +                    reg = <RK3399_PD_VCODEC>;
>> +                    clocks = <&cru ACLK_VCODEC>,
>> +                             <&cru HCLK_VCODEC>;
>> +                    pm_qos = <&qos_video_m0>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                pd_vdu@RK3399_PD_VDU {
>> +                    reg = <RK3399_PD_VDU>;
>> +                    clocks = <&cru ACLK_VDU>,
>> +                             <&cru HCLK_VDU>;
>> +                    pm_qos = <&qos_video_m1_r>,
>> +                             <&qos_video_m1_w>;
>> +                    #power-domain-cells = <0>;
>> +                };
>> +                pd_vio@RK3399_PD_VIO {
>> +                    reg = <RK3399_PD_VIO>;
>> +                    #power-domain-cells = <1>;
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    pd_hdcp@RK3399_PD_HDCP {
>> +                        reg = <RK3399_PD_HDCP>;
>> +                        clocks = <&cru ACLK_HDCP>,
>> +                                 <&cru HCLK_HDCP>,
>> +                                 <&cru PCLK_HDCP>;
>> +                        pm_qos = <&qos_hdcp>;
>> +                        #power-domain-cells = <0>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> deleted file mode 100644
>> index 8304eceb62e4..000000000000
>> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> +++ /dev/null
>> @@ -1,136 +0,0 @@
>> -* Rockchip Power Domains
>> -
>> -Rockchip processors include support for multiple power domains which can be
>> -powered up/down by software based on different application scenes to save power.
>> -
>> -Required properties for power domain controller:
>> -- compatible: Should be one of the following.
>> -	"rockchip,px30-power-controller" - for PX30 SoCs.
>> -	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
>> -	"rockchip,rk3066-power-controller" - for RK3066 SoCs.
>> -	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
>> -	"rockchip,rk3188-power-controller" - for RK3188 SoCs.
>> -	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
>> -	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
>> -	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
>> -	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
>> -	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
>> -	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
>> -- #power-domain-cells: Number of cells in a power-domain specifier.
>> -	Should be 1 for multiple PM domains.
>> -- #address-cells: Should be 1.
>> -- #size-cells: Should be 0.
>> -
>> -Required properties for power domain sub nodes:
>> -- reg: index of the power domain, should use macros in:
>> -	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
>> -	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
>> -	"include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
>> -	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
>> -	"include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
>> -	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
>> -	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
>> -	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
>> -	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
>> -	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
>> -	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
>> -- clocks (optional): phandles to clocks which need to be enabled while power domain
>> -	switches state.
>> -- pm_qos (optional): phandles to qos blocks which need to be saved and restored
>> -	while power domain switches state.
>> -
>> -Qos Example:
>> -
>> -	qos_gpu: qos_gpu@ffaf0000 {
>> -		compatible ="syscon";
>> -		reg = <0x0 0xffaf0000 0x0 0x20>;
>> -	};
>> -
>> -Example:
>> -
>> -	power: power-controller {
>> -		compatible = "rockchip,rk3288-power-controller";
>> -		#power-domain-cells = <1>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -
>> -		pd_gpu {
>> -			reg = <RK3288_PD_GPU>;
>> -			clocks = <&cru ACLK_GPU>;
>> -			pm_qos = <&qos_gpu>;
>> -		};
>> -	};
>> -
>> -	 power: power-controller {
>> -                compatible = "rockchip,rk3368-power-controller";
>> -                #power-domain-cells = <1>;
>> -                #address-cells = <1>;
>> -                #size-cells = <0>;
>> -
>> -                pd_gpu_1 {
>> -                        reg = <RK3368_PD_GPU_1>;
>> -                        clocks = <&cru ACLK_GPU_CFG>;
>> -                };
>> -        };
>> -
>> -Example 2:
>> -		power: power-controller {
>> -			compatible = "rockchip,rk3399-power-controller";
>> -			#power-domain-cells = <1>;
>> -			#address-cells = <1>;
>> -			#size-cells = <0>;
>> -
>> -			pd_vio {
>> -				#address-cells = <1>;
>> -				#size-cells = <0>;
>> -				reg = <RK3399_PD_VIO>;
>> -
>> -				pd_vo {
>> -					#address-cells = <1>;
>> -					#size-cells = <0>;
>> -					reg = <RK3399_PD_VO>;
>> -
>> -					pd_vopb {
>> -						reg = <RK3399_PD_VOPB>;
>> -					};
>> -
>> -					pd_vopl {
>> -						reg = <RK3399_PD_VOPL>;
>> -					};
>> -				};
>> -			};
>> -		};
>> -
>> -Node of a device using power domains must have a power-domains property,
>> -containing a phandle to the power device node and an index specifying which
>> -power domain to use.
>> -The index should use macros in:
>> -	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
>> -	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
>> -	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
>> -	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
>> -	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
>> -	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
>> -	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
>> -	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
>> -	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
>> -
>> -Example of the node using power domain:
>> -
>> -	node {
>> -		/* ... */
>> -		power-domains = <&power RK3288_PD_GPU>;
>> -		/* ... */
>> -	};
>> -
>> -	node {
>> -                /* ... */
>> -                power-domains = <&power RK3368_PD_GPU_1>;
>> -                /* ... */
>> -        };
>> -
>> -	node {
>> -		/* ... */
>> -		power-domains = <&power RK3399_PD_VOPB>;
>> -		/* ... */
>> -	};
>>
>
>


