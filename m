Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113863685A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhDVRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhDVRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:17:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3932FC06174A;
        Thu, 22 Apr 2021 10:17:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A3A6B1F4359E
Message-ID: <7557bc8aaaa1924ad39676b32ba6a3f6474a3722.camel@collabora.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to
 DT schema
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
Date:   Thu, 22 Apr 2021 14:16:53 -0300
In-Reply-To: <20210422141602.350746-2-benjamin.gaignard@collabora.com>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
         <20210422141602.350746-2-benjamin.gaignard@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Kever)

Hi Benjamin,

Thanks a lot for working on this, it looks amazing. Together with the great work
that Rockchip is doing, it seems RK3566/RK3568 will have decent support very soon.

One comment here:

On Thu, 2021-04-22 at 16:15 +0200, Benjamin Gaignard wrote:
> Convert Rockchip IOMMU to DT schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
>  - Change maintainer
>  - Change reg maxItems
>  - Change interrupt maxItems
> 
>  .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
>  .../bindings/iommu/rockchip,iommu.yaml        | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
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
> -its master device.  Each slave device is bound to a single master device, and
> -shares its clocks, power domain and irq.
> -
> -Required properties:
> -- compatible      : Should be "rockchip,iommu"
> -- reg             : Address space for the configuration registers
> -- interrupts      : Interrupt specifier for the IOMMU instance
> -- interrupt-names : Interrupt name for the IOMMU instance
> -- #iommu-cells    : Should be <0>.  This indicates the iommu is a
> -                    "single-master" device, and needs no additional information
> -                    to associate with its master device.  See:
> -                    Documentation/devicetree/bindings/iommu/iommu.txt
> -- clocks          : A list of clocks required for the IOMMU to be accessible by
> -                    the host CPU.
> -- clock-names     : Should contain the following:
> -       "iface" - Main peripheral bus clock (PCLK/HCL) (required)
> -       "aclk"  - AXI bus clock (required)
> -
> -Optional properties:
> -- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> -                              Some mmu instances may produce unexpected results
> -                              when the reset operation is used.
> -
> -Example:
> -
> -       vopl_mmu: iommu@ff940300 {
> -               compatible = "rockchip,iommu";
> -               reg = <0xff940300 0x100>;
> -               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -               interrupt-names = "vopl_mmu";
> -               clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -               clock-names = "aclk", "iface";
> -               #iommu-cells = <0>;
> -       };
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
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |+
> +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> +  its master device. Each slave device is bound to a single master device and
> +  shares its clocks, power domain and irq.
> +
> +  For information on assigning IOMMU controller to its peripheral devices,
> +  see generic IOMMU bindings.
> +
> +properties:
> +  compatible:
> +    const: rockchip,iommu
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +

AFAICS, the driver supports handling multiple MMUs, and there's one reg and
interrupt cell for each MMU. IOW, there's no requirement that maxItems is 2.

Is there any way we can describe that? Or maybe just allow a bigger maximum?

Thanks,
Ezequiel

