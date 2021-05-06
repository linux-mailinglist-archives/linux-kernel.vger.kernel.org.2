Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311D375C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhEFUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:36:23 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:42808 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhEFUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:36:20 -0400
Received: by mail-oo1-f42.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so1531983ooj.9;
        Thu, 06 May 2021 13:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onrgqNhsc6VTUYv6U1qfk40eTxmzLwGljQWarb0zJmY=;
        b=ShscZkT3TpekH/Id9rhPW02lyOLAN6PJOgH+8basAnz3ECLdogeIGsRIqmk5dTRuF+
         R8QW1sgxE6dxcrEo7wyghCbbRFqzAktg3cgpcyUqLzh48t2I2xq/txik5VfahuHP3Hp3
         YJ8VzK5epXbxCwLqfkk9VV+dIRMoE9q7eG5XFaROUv4bD7vIs2dnXVb7Q2i7Qra25G9Y
         SPTIyx1u5zph67ExINliqNnHsswE/uOJu8rS88RtwiWFuAzX19JBVN1rFoyMnPKL7m30
         Xep9tiuDEZIzHxxKTKhEsQANkfFbtTk74G1mRdegdwJfS6FcG5zWxVAWm2/L96PMdIu4
         fqZA==
X-Gm-Message-State: AOAM53287dOWuylGTttN5kbJZZAUFxOrKdE3Qcj6Bf2QIUQZkFoCHk7+
        I3JjfXFRLU4Zb/tkn3qWpA==
X-Google-Smtp-Source: ABdhPJxC+96lwNJ6hOaKSxCJ2EIvAf6AIHpT5UmpFzFPB2Ee5lOKBHu+ZStfrF/jlLvXdGUVCBj/FQ==
X-Received: by 2002:a4a:dc84:: with SMTP id g4mr5012064oou.24.1620333321458;
        Thu, 06 May 2021 13:35:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h59sm787947otb.29.2021.05.06.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:35:20 -0700 (PDT)
Received: (nullmailer pid 758912 invoked by uid 1000);
        Thu, 06 May 2021 20:35:19 -0000
Date:   Thu, 6 May 2021 15:35:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     joro@8bytes.org, will@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
Message-ID: <20210506203519.GA754007@robh.at.kernel.org>
References: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
 <20210504084124.131884-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504084124.131884-2-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 10:41:21AM +0200, Benjamin Gaignard wrote:
> Convert Rockchip IOMMU to DT schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
>  - Change maintainer
>  - Change reg maxItems
>  - Change interrupt maxItems
> 
>  .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
>  .../bindings/iommu/rockchip,iommu.yaml        | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 38 deletions(-)
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
> index 000000000000..0db208cf724a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip IOMMU
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |+
> +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> +  its master device. Each slave device is bound to a single master device and
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
> +    minItems: 1
> +    maxItems: 2

What's the 2nd entry? If there's only 1 entry, then you don't have to 
describe what it is. If more than 1, then each entry has to be defined.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

Same here, though if interrupt-names defines them, that's good enough.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2

Here we need the values.

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
> +  rockchip,disable-mmu-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Do not use the mmu reset operation.
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
> -- 
> 2.25.1
> 
