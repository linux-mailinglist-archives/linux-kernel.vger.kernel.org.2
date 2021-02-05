Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA743105C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhBEHWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhBEHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:22:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C6C0613D6;
        Thu,  4 Feb 2021 23:21:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z6so6413870wrq.10;
        Thu, 04 Feb 2021 23:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H79UJ7A3jnJge1ZByZIpyGYG+WvOyCM/gIg+Y6s4uQ4=;
        b=Q9975I2OIZkWV6liCLdq+fabMpQvp7wQjWmkmFkyQo2iY+bTPIAoItGUKhxh8kkOHv
         tJkLF4pQBdoF2WcclZMmqhBJnshRD9lU2pk5J5aP8G7L54eWktwnruEnoVfPCsn+x/Dh
         6wa24315QeM9D4NpT+4Lzr2LUI85Han1LMn9NgHWrIGQfHCxaXSMPJW+bt0Wd+hucPcy
         282SAhHkzLNg9GnS2nWcxEx22ZQ4oqhJQ8GbVRvPsFuNAM0KMozQqm9JJUNqYIVU+681
         GiIJ58OeiXyVwneG3qoIC41E3qkqCX0NuqvyB+KsPUyGLGb2dD+FpFhtWplPbb8H6Xi1
         mFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H79UJ7A3jnJge1ZByZIpyGYG+WvOyCM/gIg+Y6s4uQ4=;
        b=q96CFE5mDndL4GwPi299k6MxgcuqzMRUcGY1e+iJU12Wlz/mVThWeIxUArEYoPQ+w6
         QYxUM8LQ3/FgYT7xKnuvXpxhnfeiomZirisZfiA1nLC5GWxDKhXU99aF5/AtuWB/r3HN
         pspNhM4FrNDxGd/GDVfhevcvSYrtJ3nkFhyke6tsaAJ5DA3gxxQ3AbRX0mXmBlvHaYet
         hYsr+FIAR3f5XMnTkw6Nwkjm2myw2zxaBIDrDl4oI71b2xPaEoKaBWrcWrpkEUAL9nKm
         ZdTSlETf9+SylM0ho8sQMxOcC269LLrQXwxAZ0OFQocpi79TaC/6GJOu0AnSgckxJHMW
         GszQ==
X-Gm-Message-State: AOAM5326BJsnhhKktNObYXLQOhOmo7EkBf3tdk7OwxLqEw270uTZLKgf
        YzTj1RWYYtZh8ExqW2//rtOiOQl28gUebm0wCl42Hbla64sidImC
X-Google-Smtp-Source: ABdhPJyUetrlzzDb6KZ/NqRvakx0Th2g3QKyT9xRnTrDgAVuaFUTDddwQrDk5IaxSwqRhyztO7THbE54Guc2su8E8CA=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr3597662wrw.244.1612509695538;
 Thu, 04 Feb 2021 23:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org>
In-Reply-To: <20210204232549.GA1305874@robh.at.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 5 Feb 2021 15:20:57 +0800
Message-ID: <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Rob Herring <robh@kernel.org>
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

Hi Rob,

On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > This iommu module can be used by Unisoc's multimedia devices, such as
> > display, Image codec(jpeg) and a few signal processors, including
> > VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > new file mode 100644
> > index 000000000000..4fc99e81fa66
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2020 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc IOMMU and Multi-media MMU
> > +
> > +maintainers:
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,iommu-v1
> > +
> > +  "#iommu-cells":
> > +    const: 0
> > +    description:
> > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > +      additional information needs to associate with its master device.
> > +      Please refer to the generic bindings document for more details,
> > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Not required if 'sprd,iommu-regs' is defined.
> > +
> > +  clocks:
> > +    description:
> > +      Reference to a gate clock phandle, since access to some of IOMMUs are
> > +      controlled by gate clock, but this is not required.
> > +
> > +  sprd,iommu-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> > +      register range used by the iommu and the media device, the cell
> > +      defines the offset for iommu registers. Since iommu module shares
> > +      the same register range with the media device which uses it.
> > +
> > +required:
> > +  - compatible
> > +  - "#iommu-cells"
> > +
> > +oneOf:
> > +  - required:
> > +      - reg
> > +  - required:
> > +      - sprd,iommu-regs
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    iommu_disp: iommu-disp {
> > +      compatible = "sprd,iommu-v1";
> > +      sprd,iommu-regs = <&dpu_regs 0x800>;
>
> If the IOMMU is contained within another device, then it should just be
> a child node of that device.

Yes, actually IOMMU can be seen as a child of multimedia devices, I
considered moving IOMMU under into multimedia device node, but
multimedia devices need IOMMU when probe[1], so I dropped that idea.

And they share the same register base, e.g.

+               mm {
+                       compatible = "simple-bus";
+                       #address-cells = <2>;
+                       #size-cells = <2>;
+                       ranges;
+
+                       dpu_regs: syscon@63000000 {
+                               compatible = "sprd,sc9863a-dpuregs", "syscon";
+                               reg = <0 0x63000000 0 0x1000>;
+                       };
+
+                       dpu: dpu@63000000 {
+                               compatible = "sprd,sharkl3-dpu";
+                               sprd,disp-regs = <&dpu_regs>;
+                               iommus = <&iommu_dispc>;
+                       };
+
+                       iommu_dispc: iommu@63000000 {
+                               compatible = "sprd,iommu-v1";
+                               sprd,iommu-regs = <&dpu_regs 0x800>;
+                               #iommu-cells = <0>;
+                        };

DPU use the registers from 0, IOMMU from 0x800, the purpose of using
syscon node was to avoid remapping register physical address.

> Or just make 'dpu_regs' an IOMMU provider
> (i.e. just add #iommu-cells to it).

xxx_regs(syscon node) defines the register range for IOMMU and a
multimedia device (such as dpu, image codec, etc.)

Hope I've explained the relationship of xxx_regs, multimedia device,
and iommu clearly :)

Any suggestion for this kind of cases?

Thanks,
Chunyan

[1] https://elixir.bootlin.com/linux/v5.11-rc6/source/drivers/iommu/of_iommu.c#L145
>
> > +      #iommu-cells = <0>;
> > +    };
> > +
> > +  - |
> > +    iommu_jpg: iommu-jpg {
> > +      compatible = "sprd,iommu-v1";
> > +      sprd,iommu-regs = <&jpg_regs 0x300>;
> > +      #iommu-cells = <0>;
> > +      clocks = <&mm_gate 1>;
> > +    };
> > +
> > +...
> > --
> > 2.25.1
> >
