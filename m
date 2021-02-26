Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5105A325DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZGsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBZGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:48:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC9C061574;
        Thu, 25 Feb 2021 22:48:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u11so647660wmq.5;
        Thu, 25 Feb 2021 22:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KF2MfP0h0ey8fV09btIjMeC2JUn7szb+GXFQCJ3kWQ=;
        b=spQS/8C0EIuB0oHuTEC4JEIgdaaWPquNa+IPb2b0o4Oia2Vo7/BUy4F1iFHKLLXxam
         3UW7j+OEOR6XPUukFbZuwvjPXsyeQFqAM3KRfXifT2xzQt/53FtEr5yxoZADa/oa4MI5
         mxTL/mUMmxgxRO1CvgMbCFG114x3v1iMWfniV3Hy09R7CWfzXq2l+rz9Uwja3Wfmkt9k
         MAJVqeZ6qU+4G8xfvpi0/NkXxVw6INkurk4WEEV7Ecd3mituVIiSf7d9ZOTpQVST/GTY
         tRb6HIzZ/gZGY+vPWkSF8DcIWZgZ2AI+iiPS4f9S7RqKwyL/SucRiMRsdR/CfNTLqvRv
         6RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KF2MfP0h0ey8fV09btIjMeC2JUn7szb+GXFQCJ3kWQ=;
        b=aJs6hK0LtFmmNCADlhSgqk5QwPc0q9a0XQ1E1eKs1PnuqKIh7yxLFIB85Z+SywUgTN
         IoDnz5qEOhzj0dO9vn2YvLXh+G+7XWRSKajkR1+ExEq60Nftc2v28dAE6KUACe+tBcce
         DGfI1M7kUMSGe47mAIh6NaSTHtIR6Ke1LNVUkPX406jSxYqB4pfRraMucJDqaHpPs9jF
         xTAkA73jvPawwPWrf082/oYok9fl13RXITB3DOmMHefPkvnPg1OKqrKBQG4vOKJ4TVvu
         FyNrg0Owqfq9DKPAuIQQirhfIoRfa5JGOXTIsk0Q2rprxwfC4mDgskijgLvZkRB9wHhy
         kKrg==
X-Gm-Message-State: AOAM533TknUQ2h6KXIaUXJUCITV8PtN7eXstGhDeN2l2cDfrxWCQNszj
        Lr1IP0R98bOxxbApVXaS8N2RGMALEo0bfsDciKY=
X-Google-Smtp-Source: ABdhPJxhtDO+zlg5kiunT7XaFHp0euGqWP7G8T1agyEapoYFjcgOayVb9pNxUmGu8P3pWhw3Z/BSycLaQPb+FvnvwHA=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr1193624wmc.43.1614322089697;
 Thu, 25 Feb 2021 22:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org> <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com> <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
In-Reply-To: <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 26 Feb 2021 14:47:33 +0800
Message-ID: <CAAfSe-swNcmKfy7set1TFMG-r_eXqZLdYY2867J=3yo=EDmmEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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

On Tue, 16 Feb 2021 at 23:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-02-10 19:21, Rob Herring wrote:
> > On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> >>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>>
> >>>> This iommu module can be used by Unisoc's multimedia devices, such as
> >>>> display, Image codec(jpeg) and a few signal processors, including
> >>>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> >>>>
> >>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>> ---
> >>>>   .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> >>>>   1 file changed, 72 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..4fc99e81fa66
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> @@ -0,0 +1,72 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +# Copyright 2020 Unisoc Inc.
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Unisoc IOMMU and Multi-media MMU
> >>>> +
> >>>> +maintainers:
> >>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    enum:
> >>>> +      - sprd,iommu-v1
> >>>> +
> >>>> +  "#iommu-cells":
> >>>> +    const: 0
> >>>> +    description:
> >>>> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> >>>> +      additional information needs to associate with its master device.
> >>>> +      Please refer to the generic bindings document for more details,
> >>>> +      Documentation/devicetree/bindings/iommu/iommu.txt
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +    description:
> >>>> +      Not required if 'sprd,iommu-regs' is defined.
> >>>> +
> >>>> +  clocks:
> >>>> +    description:
> >>>> +      Reference to a gate clock phandle, since access to some of IOMMUs are
> >>>> +      controlled by gate clock, but this is not required.
> >>>> +
> >>>> +  sprd,iommu-regs:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>> +    description:
> >>>> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> >>>> +      register range used by the iommu and the media device, the cell
> >>>> +      defines the offset for iommu registers. Since iommu module shares
> >>>> +      the same register range with the media device which uses it.
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - "#iommu-cells"
>
> OK, so apparently the hardware is not quite as trivial as my initial
> impression, and you should have interrupts as well.

Ok, I will have a look.

>
> >>>> +
> >>>> +oneOf:
> >>>> +  - required:
> >>>> +      - reg
> >>>> +  - required:
> >>>> +      - sprd,iommu-regs
> >>>> +
> >>>> +additionalProperties: false
> >>>> +
> >>>> +examples:
> >>>> +  - |
> >>>> +    iommu_disp: iommu-disp {
> >>>> +      compatible = "sprd,iommu-v1";
> >>>> +      sprd,iommu-regs = <&dpu_regs 0x800>;
> >>>
> >>> If the IOMMU is contained within another device, then it should just be
> >>> a child node of that device.
> >>
> >> Yes, actually IOMMU can be seen as a child of multimedia devices, I
> >> considered moving IOMMU under into multimedia device node, but
> >> multimedia devices need IOMMU when probe[1], so I dropped that idea.
> >
> > Don't design your binding around working-around linux issues.
>
> Having stumbled across the DRM driver patches the other day, I now see
> where this is coming from, and it's even worse than that - this whole
> binding seems to be largely working around bad driver design.
>

I guess you mean bad h/w design (not bad driver design)?
Having this syscon node just because I don't want a same register
range to be mapped to multiple virtual address ranges, and that's the
case for many media devices and their IOMMUs. If this issue exsists
for one device only, I can even endure, but that's not unfortunately.
But anyway, as you all think this is not a good way, I will change to
use reg property.

> >> And they share the same register base, e.g.
> >>
> >> +               mm {
> >> +                       compatible = "simple-bus";
> >> +                       #address-cells = <2>;
> >> +                       #size-cells = <2>;
> >> +                       ranges;
> >> +
> >> +                       dpu_regs: syscon@63000000 {
> >
> > Drop this node.
> >
> >> +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
> >> +                               reg = <0 0x63000000 0 0x1000>;
> >> +                       };
> >> +
> >> +                       dpu: dpu@63000000 {
> >> +                               compatible = "sprd,sharkl3-dpu";
> >> +                               sprd,disp-regs = <&dpu_regs>;
> >
> > reg = <0 0x63000000 0 0x800>;
>
> In fact judging by the other driver it looks like the length only needs
> to be 0x200 here (but maybe there's more to come in future).
>
> >> +                               iommus = <&iommu_dispc>;
> >> +                       };
> >> +
> >> +                       iommu_dispc: iommu@63000000 {
> >> +                               compatible = "sprd,iommu-v1";
> >> +                               sprd,iommu-regs = <&dpu_regs 0x800>;
> >
> > reg = <0 0x63000800 0 0x800>;
>
> ...and this one looks to need less than 0x80, even :)

There're some registers not be added in the current driver indeed. The
specification defines registers up to 0x7c.

>
> >
> >> +                               #iommu-cells = <0>;
> >
> > Though given it seems there is only 1 client and this might really be
> > just 1 h/w block, you don't really need to use the iommu binding at
> > all. The DPU should be able to instantiate it's own IOMMU device.
> > There's other examples of this such as mali GPU though that is all one
> > driver, but that's a Linux implementation detail.
>
> FWIW that's really a very different situation - the MMUs in a Mali GPU
> are fundamental parts of its internal pipelines and would never make
> sense to handle as separate devices (if it were even feasible to try).
> An IOMMU like this one is typically a logically-distinct block stuck to
> the external bus interface of any old device, rewriting transactions
> that said device has already issued - it's telling that it needs to
> allocate the prot_page scratchpad for "faulting" transactions to still
> flow somewhere, implying that it's not even involved enough to be able
> to terminate them.
>
> As such I think it *does* make complete sense to describe even
> "dedicated" IOMMUs like this one, Rockchip, Exynos, etc. in DT.
> Otherwise you'd be effectively forcing OSes to turn half their
> display/media drivers into mini board files with secret knowledge of
> which blocks are integrated with IOMMUs on which SoCs.
>

 Thanks for helping me explain the situation.

Regards,
Chunyan

> Robin.
