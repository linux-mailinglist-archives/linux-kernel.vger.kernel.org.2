Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4D0317008
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhBJTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhBJTWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:22:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB18564E76;
        Wed, 10 Feb 2021 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612984912;
        bh=CHueUMIMBD3GE7Looz6rSUXBk635o0bKJjvrSZmh/t0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUrvUlB85euQ4N/sJBKAwuv6Ncp95ojkWdXDak05eJ/dqgN5kGD/q+uN5oZl7zC+o
         y8Ew3TiYa0GDuChsNQcObLl42RHlna8oPHVyhV6cdrxp+EmyhDgINhT1OdSwIchzGG
         Xin4HsifB3odO7dy+VN0KkLsVdXTXy5Gk355dRmOvvHDWndynYlyZbRDXc+UUFyYah
         TRNHtiscqfGY+kiJLqqJ8rCRSTZ8TXozoHasPQpDxh/rPKV3VHxYORZoCkgVwbrj4U
         9reL4fqRCP8JcKx4GpWduyc/t5lHx2EysByvE6CmiAtNj4tXlnRbVpe/5gAS2rzRpx
         mpMzxuJL3WP2A==
Received: by mail-ed1-f47.google.com with SMTP id v7so4323653eds.10;
        Wed, 10 Feb 2021 11:21:51 -0800 (PST)
X-Gm-Message-State: AOAM531Hpvl4aYvR1JtMUjwwiGPADYoNPYd7XkCjwNek8dPmyCOFPMA5
        OBRhQFq77P5r4rX5DnFWaClWRSZ71BsU9QYPpw==
X-Google-Smtp-Source: ABdhPJxfacP93Q4hCUHSoCae7cx6yfMBjBpwpgV4kLOag14o+4JLbnm+6bzfXkudj0Q6zozjHn8hEL7D/0LMfffGTC8=
X-Received: by 2002:aa7:c7c8:: with SMTP id o8mr4669819eds.137.1612984910399;
 Wed, 10 Feb 2021 11:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org> <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
In-Reply-To: <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Feb 2021 13:21:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
Message-ID: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Rob,
>
> On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > This iommu module can be used by Unisoc's multimedia devices, such as
> > > display, Image codec(jpeg) and a few signal processors, including
> > > VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> > >  1 file changed, 72 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > new file mode 100644
> > > index 000000000000..4fc99e81fa66
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2020 Unisoc Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Unisoc IOMMU and Multi-media MMU
> > > +
> > > +maintainers:
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sprd,iommu-v1
> > > +
> > > +  "#iommu-cells":
> > > +    const: 0
> > > +    description:
> > > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > > +      additional information needs to associate with its master device.
> > > +      Please refer to the generic bindings document for more details,
> > > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description:
> > > +      Not required if 'sprd,iommu-regs' is defined.
> > > +
> > > +  clocks:
> > > +    description:
> > > +      Reference to a gate clock phandle, since access to some of IOMMUs are
> > > +      controlled by gate clock, but this is not required.
> > > +
> > > +  sprd,iommu-regs:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> > > +      register range used by the iommu and the media device, the cell
> > > +      defines the offset for iommu registers. Since iommu module shares
> > > +      the same register range with the media device which uses it.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - "#iommu-cells"
> > > +
> > > +oneOf:
> > > +  - required:
> > > +      - reg
> > > +  - required:
> > > +      - sprd,iommu-regs
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    iommu_disp: iommu-disp {
> > > +      compatible = "sprd,iommu-v1";
> > > +      sprd,iommu-regs = <&dpu_regs 0x800>;
> >
> > If the IOMMU is contained within another device, then it should just be
> > a child node of that device.
>
> Yes, actually IOMMU can be seen as a child of multimedia devices, I
> considered moving IOMMU under into multimedia device node, but
> multimedia devices need IOMMU when probe[1], so I dropped that idea.

Don't design your binding around working-around linux issues.

> And they share the same register base, e.g.
>
> +               mm {
> +                       compatible = "simple-bus";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       dpu_regs: syscon@63000000 {

Drop this node.

> +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
> +                               reg = <0 0x63000000 0 0x1000>;
> +                       };
> +
> +                       dpu: dpu@63000000 {
> +                               compatible = "sprd,sharkl3-dpu";
> +                               sprd,disp-regs = <&dpu_regs>;

reg = <0 0x63000000 0 0x800>;

> +                               iommus = <&iommu_dispc>;
> +                       };
> +
> +                       iommu_dispc: iommu@63000000 {
> +                               compatible = "sprd,iommu-v1";
> +                               sprd,iommu-regs = <&dpu_regs 0x800>;

reg = <0 0x63000800 0 0x800>;

> +                               #iommu-cells = <0>;

Though given it seems there is only 1 client and this might really be
just 1 h/w block, you don't really need to use the iommu binding at
all. The DPU should be able to instantiate it's own IOMMU device.
There's other examples of this such as mali GPU though that is all one
driver, but that's a Linux implementation detail.

Rob
