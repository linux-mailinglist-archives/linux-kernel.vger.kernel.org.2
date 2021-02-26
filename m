Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0206325D71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:13:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A1C061574;
        Thu, 25 Feb 2021 22:12:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n4so7466502wrx.1;
        Thu, 25 Feb 2021 22:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zo55mBo3m4Uke2mk+X1npLwGmzEk63Firuv6qer8Fw=;
        b=mWSpZYZCWd7pJFziAgN9srzEloyViWSX8sX0gWYeY3XOzLdp4BeOL0ae4hFzdTUUse
         Kv+UW1r3lwO8wYCXDHBoizeshtps2BJN1tEqE8PpOKWNN7AKffmNagOs/NQtTnZSJS6Z
         rfuMMDszkeVe+sw2PFVc5sA7RKWfzHiTYpdoqCEVc2bK//A+NTWS5h9bH7M15YGRna9P
         3uUiWbHR386Xt8fuEqPXDLrvkyL414K6rxE9rIuQyzTpfp74XgdCIOpJv0NVcvhaO8QS
         Edvn/uocBRNM7AU2YcMklKhJHDUDVb5W2FTEFhtcgVad4kbphAp01+DRPt5BZ/clwSUm
         rr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zo55mBo3m4Uke2mk+X1npLwGmzEk63Firuv6qer8Fw=;
        b=Aay71jp0eA1yT4K0FKvBvefrv+tze7MTvqxk0W9gJ/2LA/lmnTaBEH9c9ryrIMt7AW
         JsQyE5XtUEeu8PrsvpnHJetkbEyOWPt03GA+2qYl5zZp5NE6yssSGo675nDNW2JGlZ8X
         qSlBY23vfY1jtqjbGbR14lVeXvkaaWrvryOaqKq2Im7Ovtbw0EjTiYRmbvPDJLFhVEST
         NdrH8xhyk8++DAQUsfjrFgonIf+QlmHGvCYpy/zsdy5xvkogq+dA+5XqE/r1QkJ23+0s
         Mk1gn5oTIi+J9ToCJ3i+E/Z19/Z/lHkvT7Bi3VSBLKe7l1BSlCUQkW/mtIgtp0H9D/5z
         KS/Q==
X-Gm-Message-State: AOAM532N6pvxFNSDL9EO5g/+e/t3Kw12pvavSGDaMD5A1pPc6+qEopIL
        DQ2Xzt1PvZavCi8k74OyIyKxMAHtkZy8MP8imcc061SAVsYmrA==
X-Google-Smtp-Source: ABdhPJxKzLEZ3xO/S2BzR5WJV668wwfXYZulkobX79JcXqbCAN5gDzPqlzOC3EGbvgC8deMTZ3JQPvzq3sO3C68B5wE=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1365250wrq.201.1614319941250;
 Thu, 25 Feb 2021 22:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com> <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org> <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
In-Reply-To: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 26 Feb 2021 14:11:44 +0800
Message-ID: <CAAfSe-sDgrpzL+yo7KAXFeEfEh+9F22cbiUv8BqQTG7gtO5bzQ@mail.gmail.com>
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

On Thu, 11 Feb 2021 at 03:21, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > This iommu module can be used by Unisoc's multimedia devices, such as
> > > > display, Image codec(jpeg) and a few signal processors, including
> > > > VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > new file mode 100644
> > > > index 000000000000..4fc99e81fa66
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > @@ -0,0 +1,72 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2020 Unisoc Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Unisoc IOMMU and Multi-media MMU
> > > > +
> > > > +maintainers:
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - sprd,iommu-v1
> > > > +
> > > > +  "#iommu-cells":
> > > > +    const: 0
> > > > +    description:
> > > > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > > > +      additional information needs to associate with its master device.
> > > > +      Please refer to the generic bindings document for more details,
> > > > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Not required if 'sprd,iommu-regs' is defined.
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      Reference to a gate clock phandle, since access to some of IOMMUs are
> > > > +      controlled by gate clock, but this is not required.
> > > > +
> > > > +  sprd,iommu-regs:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> > > > +      register range used by the iommu and the media device, the cell
> > > > +      defines the offset for iommu registers. Since iommu module shares
> > > > +      the same register range with the media device which uses it.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - "#iommu-cells"
> > > > +
> > > > +oneOf:
> > > > +  - required:
> > > > +      - reg
> > > > +  - required:
> > > > +      - sprd,iommu-regs
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    iommu_disp: iommu-disp {
> > > > +      compatible = "sprd,iommu-v1";
> > > > +      sprd,iommu-regs = <&dpu_regs 0x800>;
> > >
> > > If the IOMMU is contained within another device, then it should just be
> > > a child node of that device.
> >
> > Yes, actually IOMMU can be seen as a child of multimedia devices, I
> > considered moving IOMMU under into multimedia device node, but
> > multimedia devices need IOMMU when probe[1], so I dropped that idea.
>
> Don't design your binding around working-around linux issues.
>
> > And they share the same register base, e.g.
> >
> > +               mm {
> > +                       compatible = "simple-bus";
> > +                       #address-cells = <2>;
> > +                       #size-cells = <2>;
> > +                       ranges;
> > +
> > +                       dpu_regs: syscon@63000000 {
>
> Drop this node.
>
> > +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
> > +                               reg = <0 0x63000000 0 0x1000>;
> > +                       };
> > +
> > +                       dpu: dpu@63000000 {
> > +                               compatible = "sprd,sharkl3-dpu";
> > +                               sprd,disp-regs = <&dpu_regs>;
>
> reg = <0 0x63000000 0 0x800>;
>
> > +                               iommus = <&iommu_dispc>;
> > +                       };
> > +
> > +                       iommu_dispc: iommu@63000000 {
> > +                               compatible = "sprd,iommu-v1";
> > +                               sprd,iommu-regs = <&dpu_regs 0x800>;
>
> reg = <0 0x63000800 0 0x800>;

Alright, considering you deprecate using syscon to map registers here,
I will drop that.
But that would cause the same physical address to be mapped two times at least.
And this is not a single case, since there are a few media devices and
their IOMMUs which all have this issue.

Thanks,
Chunyan

>
> > +                               #iommu-cells = <0>;
>
> Though given it seems there is only 1 client and this might really be
> just 1 h/w block, you don't really need to use the iommu binding at
> all. The DPU should be able to instantiate it's own IOMMU device.
> There's other examples of this such as mali GPU though that is all one
> driver, but that's a Linux implementation detail.
>
> Rob
