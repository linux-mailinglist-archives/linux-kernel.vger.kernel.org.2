Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55436814B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhDVNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:14:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBCCC06174A;
        Thu, 22 Apr 2021 06:13:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id x12so47956994ejc.1;
        Thu, 22 Apr 2021 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hsr6lCLd7JFlK9taoygzcaxUpuGrqlvJuCbv9uQLPQ=;
        b=faywr3P7WFufLom1rX2WOmWEReYjumYY9+Q6qWzuIDUblJZ2Hxu+9YJPrj+Eikd4cf
         RHkz3e/YFfIXC6Us+iaAW/hnfF7gtQ4tegZIM1gbbESI19XyOjf+9s60ZhU4khOVRGSz
         TMU4rRlg+LNAyMKzX5rNrDsMZ6AA80QzwLWnt5ac/tggOvuZN901ZZ5Ah1lUv4DWXVUB
         1pRQyRooIodQOoPK0gLLq2miQkvc1pgNe82optlJgVzv+pSvAmJzpXJU5kYuuEE0BqEF
         XVYqJJZbvEGytp0OI/5zaAbSILvPtqeY+DNHFIALp6cCINm1R5CtzQXunT4f7g7+06PB
         n9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hsr6lCLd7JFlK9taoygzcaxUpuGrqlvJuCbv9uQLPQ=;
        b=Mg9DjCt/km9aTNwgno/dtwzuDCCpsvf5ov84F8xjqKMlxtHhFeGDB5fslv9/gSosIF
         deIkQJsX0HlFD5gvqYx8jWm+BUa5QRVOKNAQq5iH/g9k7lFBiz3TgB4AwdOAt+FXRhpc
         t8yDXoPSMmZLdXQLy8SQaF3MmS4AIyHJkgZyH9eQwYEAbUWKYqmnjgGPNa/uDmEag0ti
         hVQ7VMV5xwuxUiarkHF8AlXYjKYMw7iFr4Y7gHYIaPECwwrfDcFQ0LGT1XqcslgWFCGP
         9tiDrQnbeNVt/vVrShu/uv8KcDQAMN0PLiR8kDRXCxg0mEUoJurlumufJgRSNi3F5KKT
         osbg==
X-Gm-Message-State: AOAM531CavmZm7ro1SScYD/irON/lCnEK/s0KPXo+9N6t41mQpLHaWgm
        t/A4sdfAjGyoORLEreuu0tU=
X-Google-Smtp-Source: ABdhPJzXCfbHhFUzaYpljXPt1Ch/X5HDXhU8dNkH2BmhotD1eZOoiPgxt8o6p0gUe9CTiF8IOY5I3g==
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr3312469ejb.118.1619097222388;
        Thu, 22 Apr 2021 06:13:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f22sm1828519ejr.35.2021.04.22.06.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 06:13:41 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210422072442.111070-1-benjamin.gaignard@collabora.com>
 <20210422072442.111070-2-benjamin.gaignard@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c2087946-0dfb-b66e-bcb9-5bba5fd098bf@gmail.com>
Date:   Thu, 22 Apr 2021 15:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210422072442.111070-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Please check robh/dtbs-check failed build log at

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210422072442.111070-2-benjamin.gaignard@collabora.com/

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml


make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

Test if all notifications are gone.

===

YAML also checks extra properties like "power-domains" not yet included
but needed for rk3568.
Add them in a separate patch.

===

rk3229-evb.dt.yaml: iommu@20030480: 'iommu-cells' does not match any of
the regexes

Change a rk322x.dtsi property to #iommu-cells in a separate patch.

===

rk3229-xms6.dt.yaml: iommu@20030480: reg: [[537068672, 64], [537068736,
64]] is too long

Change reg minItems maxItems.

===

Johan

On 4/22/21 9:24 AM, Benjamin Gaignard wrote:
> Convert Rockchip IOMMU to DT schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../bindings/iommu/rockchip,iommu.txt         | 38 ----------
>  .../bindings/iommu/rockchip,iommu.yaml        | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> deleted file mode 100644
> index 6ecefea1c6f9..000000000000
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Rockchip IOMMU
> -==============
> -
> -A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> -its master device.  Each slave device is bound to a single master device, and
> -shares its clocks, power domain and irq.
> -
> -Required properties:
> -- compatible      : Should be "rockchip,iommu"
> -- reg             : Address space for the configuration registers
> -- interrupts      : Interrupt specifier for the IOMMU instance
> -- interrupt-names : Interrupt name for the IOMMU instance
> -- #iommu-cells    : Should be <0>.  This indicates the iommu is a
> -                    "single-master" device, and needs no additional information
> -                    to associate with its master device.  See:
> -                    Documentation/devicetree/bindings/iommu/iommu.txt
> -- clocks          : A list of clocks required for the IOMMU to be accessible by
> -                    the host CPU.
> -- clock-names     : Should contain the following:
> -	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
> -	"aclk"  - AXI bus clock (required)
> -
> -Optional properties:
> -- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> -			       Some mmu instances may produce unexpected results
> -			       when the reset operation is used.
> -
> -Example:
> -
> -	vopl_mmu: iommu@ff940300 {
> -		compatible = "rockchip,iommu";
> -		reg = <0xff940300 0x100>;
> -		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "vopl_mmu";
> -		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> new file mode 100644
> index 000000000000..ab128f8e4c73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -0,0 +1,76 @@

> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

GPL-2.0
This is a conversion of an existing document.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip IOMMU
> +
> +maintainers:
> +  - Simon Xue <xxm@rock-chips.com>

  - Heiko Stuebner <heiko@sntech.de>

Add someone that can respond in a short time in case rob+dt wants to
delete something.

> +
> +description: |+
> +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for

> +  its master device. Each slave device is bound to a single master device, and

No comma "," before "and"

> +  shares its clocks, power domain and irq.
> +
> +  For information on assigning IOMMU controller to its peripheral devices,
> +  see generic IOMMU bindings.
> +
> +properties:
> +  compatible:
> +    const: rockchip,iommu
> +
> +  reg:

> +    maxItems: 1

minItems: 1
maxItems: 2


> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Interface clock
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: iface
> +
> +  "#iommu-cells":
> +    const: 0
> +

  power-domains:
    maxItems: 1

Add in separate patch for review by rob+bt

> +  rockchip,disable-mmu-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

> +      Don't use the mmu reset operation.

Do not use ....

The use of "'" in a YAML description gives problems in some text
highlighters. Try to avoid.

> +      Some mmu instances may produce unexpected results
> +      when the reset operation is used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    vopl_mmu: iommu@ff940300 {
> +      compatible = "rockchip,iommu";
> +      reg = <0xff940300 0x100>;
> +      interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "vopl_mmu";
> +      clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +      clock-names = "aclk", "iface";
> +      #iommu-cells = <0>;
> +    };
> 

