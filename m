Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5737035E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhD3WPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:15:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37876 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhD3WPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:15:33 -0400
Received: by mail-ot1-f45.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso51691377otm.4;
        Fri, 30 Apr 2021 15:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7SSvv02TsbkrWOwWlBM9seTIZP42kaPiNEe9dizb4ew=;
        b=hm9jYwBoMcaV2ol559bImj4OjLzGp7t9+hn/V9bDsN05TUSK39Zx2F1G30VjUBoyUx
         rkodwc/b9MJmdmqUEzSlz7M+FntAhnNrqAIhr1YL0MqU/NSMDJrtejGmJepO7DByPs1h
         3o1DON7fvEpXzVHkjBk4rfkDWDcWlbVp2Lu2jGfZqHcDrb8FMO6S35PXwapG893qdDIj
         QvEpxfp0kc8NUSn3U2gLeyJlPI6//TeJd88Z+fTSKMSMkDjzgVHgJfstetpbrn8mpiM+
         5PBljYHVM+FvuyG5VPUxhyOdJt725PqVuY/rn8FrhOMUvK+o1wiGIuly+bBFoQFhEdvv
         cI6w==
X-Gm-Message-State: AOAM531psffEKMgNX+waQHhQ4nQItAUM/UB2VYmNg7jl1Ekdikfls5VX
        514rk7uRnS87fqDWgqlrXA==
X-Google-Smtp-Source: ABdhPJybcXW/btKHlVv6/oMKk9lt8LC61n8INzSUoyfrM2mjKCMtaL7sricjsJZqmqqq5BQ8Q/rsZA==
X-Received: by 2002:a05:6830:1103:: with SMTP id w3mr5343380otq.304.1619820884331;
        Fri, 30 Apr 2021 15:14:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b64sm215922oii.12.2021.04.30.15.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 15:14:43 -0700 (PDT)
Received: (nullmailer pid 4001411 invoked by uid 1000);
        Fri, 30 Apr 2021 22:14:42 -0000
Date:   Fri, 30 Apr 2021 17:14:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
Message-ID: <20210430221442.GA3970483@robh.at.kernel.org>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
 <20210422141602.350746-2-benjamin.gaignard@collabora.com>
 <7557bc8aaaa1924ad39676b32ba6a3f6474a3722.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7557bc8aaaa1924ad39676b32ba6a3f6474a3722.camel@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:16:53PM -0300, Ezequiel Garcia wrote:
> (Adding Kever)
> 
> Hi Benjamin,
> 
> Thanks a lot for working on this, it looks amazing. Together with the great work
> that Rockchip is doing, it seems RK3566/RK3568 will have decent support very soon.
> 
> One comment here:
> 
> On Thu, 2021-04-22 at 16:15 +0200, Benjamin Gaignard wrote:
> > Convert Rockchip IOMMU to DT schema
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > version 2:
> >  - Change maintainer
> >  - Change reg maxItems
> >  - Change interrupt maxItems
> > 
> >  .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
> >  .../bindings/iommu/rockchip,iommu.yaml        | 79 +++++++++++++++++++
> >  2 files changed, 79 insertions(+), 38 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> >  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> > deleted file mode 100644
> > index 6ecefea1c6f9..000000000000
> > --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> > +++ /dev/null
> > @@ -1,38 +0,0 @@
> > -Rockchip IOMMU
> > -==============
> > -
> > -A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> > -its master device.  Each slave device is bound to a single master device, and
> > -shares its clocks, power domain and irq.
> > -
> > -Required properties:
> > -- compatible      : Should be "rockchip,iommu"
> > -- reg             : Address space for the configuration registers
> > -- interrupts      : Interrupt specifier for the IOMMU instance
> > -- interrupt-names : Interrupt name for the IOMMU instance
> > -- #iommu-cells    : Should be <0>.  This indicates the iommu is a
> > -                    "single-master" device, and needs no additional information
> > -                    to associate with its master device.  See:
> > -                    Documentation/devicetree/bindings/iommu/iommu.txt
> > -- clocks          : A list of clocks required for the IOMMU to be accessible by
> > -                    the host CPU.
> > -- clock-names     : Should contain the following:
> > -       "iface" - Main peripheral bus clock (PCLK/HCL) (required)
> > -       "aclk"  - AXI bus clock (required)
> > -
> > -Optional properties:
> > -- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> > -                              Some mmu instances may produce unexpected results
> > -                              when the reset operation is used.
> > -
> > -Example:
> > -
> > -       vopl_mmu: iommu@ff940300 {
> > -               compatible = "rockchip,iommu";
> > -               reg = <0xff940300 0x100>;
> > -               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > -               interrupt-names = "vopl_mmu";
> > -               clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> > -               clock-names = "aclk", "iface";
> > -               #iommu-cells = <0>;
> > -       };
> > diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > new file mode 100644
> > index 000000000000..0db208cf724a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip IOMMU
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +description: |+
> > +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> > +  its master device. Each slave device is bound to a single master device and
> > +  shares its clocks, power domain and irq.
> > +
> > +  For information on assigning IOMMU controller to its peripheral devices,
> > +  see generic IOMMU bindings.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,iommu
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> 
> AFAICS, the driver supports handling multiple MMUs, and there's one reg and
> interrupt cell for each MMU. IOW, there's no requirement that maxItems is 2.
> 
> Is there any way we can describe that? Or maybe just allow a bigger maximum?

With #iommu-cells == 0, how would one distinguish which IOMMU is 
associated with a device? IOW, is more that 1 really usable?

If you need more just pick a maxItems value that's either the most seen 
or 'should be enough'TM. If the entries are just multiple instances of 
the same thing, please note that here.

Rob
