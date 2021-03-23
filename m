Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B171345C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCWLFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCWLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:05:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A423C061574;
        Tue, 23 Mar 2021 04:05:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k10so26393679ejg.0;
        Tue, 23 Mar 2021 04:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7lUS95kl+5p2p5WQfSN3zbCzt2WF1LGSNJ+ArV3aV6g=;
        b=XTJ2QMlvb6KMp0GoaubjkELxl4z32z8ryi6BEnj2uob64u95FGUerOtW14jrK5l5yx
         yhbZjKwsbSj/lTcet5yml72zzeOWprVMUUI6k7oTVSi99RXDVvK2zFlcwHJ9ad8BmFmM
         yv20jnVGUxfZAn1Uu0L+8fry2CqiglWJpTLsHsfG6DMhgwGbK3dJM7nd1wdsE5kLrYir
         dc64uWxZLWaU0qnqAwC7AP7IlnKFLnBWkjMWiNFKIDtVXUOW5dE+TJWj1QguhIcnsAkm
         NB8EgDdPSgg26R+i7W7gQTiruqEhRmWkiE8exkeRB+yxP1APmV1n1XnBKN40qGC6NL/0
         c6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lUS95kl+5p2p5WQfSN3zbCzt2WF1LGSNJ+ArV3aV6g=;
        b=IQSkkQKP+Q/qX5iVCqBS5nEGVSPjQGXzEcbQsNSBJ5Z7kf+i8SA7h+phDd9MThLgYV
         sM3c7am6CQA2Hel2MKIsrjejbCMLe/7N5mf9JvcHRfO5DCYxut+k02kqhd9fxDh1fX4Z
         CKyhuftv/ilK3lZrrBc8usBhDFDqAlD3FnM+zF7yr7o5PgTpZB8a8j86yH3LYZGi7rgi
         cy1fUcOrWyYVGxCksAgHe8xDtUtMe3QAS0+QJjnubzslY7uEPbkgSy3dAJtDYCDN1+wb
         uEWNwIBBgA1ysc6sJqwlMn6mkSBPf8RsGZkZazI+VSRJuQdKumbM8wRjmP9i+4v9wWV/
         2zEg==
X-Gm-Message-State: AOAM533SscQTIKaC07k5/x/qDruNY4h52I9WnjKBbEaFadc51IEMdKR8
        1q8YW3qT+0yofp8+uhf18/WWpLDa2gKDcQ==
X-Google-Smtp-Source: ABdhPJwmxCgd0+kirarU8gjL9sfQK8c6LVVdlx4lXanqjJihcBZsuUimHVXhefv0IlAan40JNxQxkA==
X-Received: by 2002:a17:906:9509:: with SMTP id u9mr4341196ejx.225.1616497535898;
        Tue, 23 Mar 2021 04:05:35 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm10914169ejd.15.2021.03.23.04.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:05:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] dt-bindings: Convert the rockchip power_domain to
 YAML and extend
To:     Elaine Zhang <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
 <20210323082410.22818-3-zhangqing@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <87e50d5b-604b-508c-f3cb-ee07fcf15241@gmail.com>
Date:   Tue, 23 Mar 2021 12:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210323082410.22818-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Some comments. Have a look if it's useful or that you disagree
with...(part 1)

======
There is currently already a patch proposal that does the same.
Could you read that review history and port the good things to your own
patch serie?

Re: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/

Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/

======
The kernel scripts checks expects that patches still have approx. 79-80
characters per line. Please keep the YAML descriptions max length < 80
and restyle.

On 3/23/21 9:24 AM, Elaine Zhang wrote:
> This converts the rockchip power domain family bindings to YAML schema,
> and add binding documentation for the power domains found on Rockchip
> RK3568 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>  .../rockchip/rockchip,power-controller.yaml   | 259 ++++++++++++++++++
>  2 files changed, 259 insertions(+), 136 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> 
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
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000000..6a7c3e25f3b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> @@ -0,0 +1,259 @@

> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

This is a conversion of an existing document, so GPL-2.0 only.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/rockchip/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Generic PM domains
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains which can be

> +  powered up/down by software based on different application scenes to save power.

scenes > scenarios ??

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

Use separate patches for a YAML conversion and adding new compatibility
strings.

> +
> +  '#power-domain-cells':

Use "" instead of '' like in the rest of the YAML files.
Change them all in this document.

> +    const: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  

"(pd_npu|pd_gpu|pd_vi|pd_vo|pd_rga|pd_vpu|pd_rkvdec|pd_rkvenc|pd_pipe|pd_edp|pd_emmc|pd_gmac|pd_iep|pd_sdioaudio|pd_usb3|pd_vcodec|pd_vdu|pd_vio|pd_mmc_nand|pd_sdcard|pd_usb|pd_hevc|pd_video|pd_perihp|pd_sd|pd_tcpc0|pd_tcpc1)@[0-9a-f]+$":

use a regex

======
Comment by Rob in review:
https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/

Which in turn means the nested power domains will throw an error, so you
can do:

       patternProperties:
	 "^power-domain@[0-9a-f]+$":
           $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'
======
Comment by Rob in review:
https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/

(with indentation). Then you will get a bunch of errors as you are
missing a level of nodes. The 'power-controller' node doesn't have
'reg' for example. You'll need to use 'patternProperties' with '^pd_'.

And to describe the nested power domains, you have to describe yet
another level. You can do a $ref with something like:

$ref: '#/properties/power-controller/patternProperties/^pd_'

That creates a circular reference though and I'm not sure what will
happen. :)
======
My version 2 comment:

Instead of using regex "^power-domain@[0-9a-f]+$" could you experiment
with something like "^pd_[a-z]@[0-9a-f]+$" to prevent that all existing
dtsi files generate notifications and have to be changed.

> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node as documented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +        description: |

> +          Power domain index. Valid values are defined in:

The ":" charecter should maybe not be used in the description to prevent
misinterpretation.

> +            "include/dt-bindings/power/px30-power.h"
> +            "include/dt-bindings/power/rk3036-power.h"
> +            "include/dt-bindings/power/rk3066-power.h"
> +            "include/dt-bindings/power/rk3128-power.h"
> +            "include/dt-bindings/power/rk3188-power.h"
> +            "include/dt-bindings/power/rk3228-power.h"
> +            "include/dt-bindings/power/rk3288-power.h"
> +            "include/dt-bindings/power/rk3328-power.h"
> +            "include/dt-bindings/power/rk3366-power.h"
> +            "include/dt-bindings/power/rk3368-power.h"
> +            "include/dt-bindings/power/rk3399-power.h"
> +            "include/dt-bindings/power/rk3568-power.h"
> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled during domain
> +          power-up sequencing.
> +
> +      clock-names:
> +        description: |
> +          List of names of clocks, in order to match the power-up sequencing
> +          for each power domain we need to group the clocks by name. BASIC
> +          clocks need to be enabled before enabling the corresponding power
> +          domain.
> +
> +      pm_qos:
> +        description: |

> +          QoS is an abriviation saved restored.

My previous comment was not clear enough I think... ;)
Please correct your spelling.
======
The original text:

- pm_qos (optional): phandles to qos blocks which need to be saved and
restored while power domain switches state.
======
Your version 1 text:

         A number of phandles for qos registers that need to be save and
restor during domain
         power-up sequencing.
======
My version 1 comment:

QoS is an abriviation
saved
restored
======
My version 2 comment:

Could you recheck the spelling?
QoS is an abbreviation which is normally written with capital letters.
Explain the meaning of QoS blocks.(Quality of Service ??)
Are they just memory regs?

qos > QoS (Is that correct ?? Please check!)
save > saved
restor > restored


> +
> +    patternProperties:

> +      "(pd_vo|pd_tcpc0|pd_tcpc1|pd_hdcp|pd_isp0|pd_isp1|pd_sd)@[0-9a-f]+$":

use a regex

> +        type: object
> +        description: |
> +          Represents a power domain child within a power domain parent node.
> +
> +        properties:
> +
> +          '#address-cells':
> +            const: 1
> +
> +          '#size-cells':
> +            const: 0
> +
> +          reg:
> +            maxItems: 1
> +
> +          clocks:
> +            description: |
> +              A number of phandles to clocks that need to be enabled during domain
> +              power-up sequencing.
> +
> +          clock-names:
> +            description: |
> +              List of names of clocks, in order to match the power-up sequencing
> +              for each power domain we need to group the clocks by name. BASIC
> +              clocks need to be enabled before enabling the corresponding power
> +              domain.
> +
> +          pm_qos:
> +            description: |

> +              QoS is an abriviation saved restored.

dito

> +
> +        patternProperties:

> +          "(pd_vopb|pd_vopl)@[0-9a-f]+$":

use a regex

> +            type: object
> +            description: |
> +              Represents a power domain child within a power domain parent node.
> +
> +            properties:
> +
> +              '#address-cells':
> +                const: 1
> +
> +              '#size-cells':
> +                const: 0
> +
> +              reg:
> +                maxItems: 1
> +
> +              clocks:
> +                description: |
> +                  A number of phandles to clocks that need to be enabled during domain
> +                  power-up sequencing.
> +
> +              clock-names:
> +                description: |
> +                  List of names of clocks, in order to match the power-up sequencing
> +                  for each power domain we need to group the clocks by name. BASIC
> +                  clocks need to be enabled before enabling the corresponding power
> +                  domain.
> +
> +              pm_qos:
> +                description: |

> +                  QoS is an abriviation saved restored.

dito

> +
> +            additionalProperties: false
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

====

+            required:
+              - reg
+
+            additionalProperties: false
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false

The patch link below adds more required things.
Could you recheck your patch?

https://lore.kernel.org/linux-rockchip/20210225102643.653095-1-enric.balletbo@collabora.com/

====
> +
> +examples:
> +  - |

> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/power/rk3568-power.h>

rk3568 still has no full support in the mainline kernel.
Rob's script will generate errors.
Could you change to a rk3399 example for which all includes are already
there?

> +
> +    pmu: power-management@fdd90000 {
> +        compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
> +        reg = <0xfdd90000 0x1000>;
> +
> +        power: power-controller {
> +            compatible = "rockchip,rk3568-power-controller";
> +            #power-domain-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
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

