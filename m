Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE494376FD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 07:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhEHFsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEHFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 01:48:00 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D45C061574;
        Fri,  7 May 2021 22:46:59 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso9842609oti.2;
        Fri, 07 May 2021 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFqC/lz4MJmYxRW+AODc04kNcj15ywFtCaqr13k7NSk=;
        b=bsCCpEwLcgWKOfyMDuHgb346sTQ1ATb3ebGQ1BkOY9bozcq1rJX75LwzKdWQi+oW/x
         TdE+v8boZI/2oQb86aqeCaZki4dg4faKgBMVOWOB8ui+t67BfxxUSNsNerMOfw3QQoff
         CeQQ4WYgpE9c3Y+CpvEZHIjQ4wvzX9a1JJCdSq2qZGNDPdhwSoN6LLyr+qCtvKpm2h42
         zLyaK7Cja8bMGubOpqJbPCftl24uN5pWkLgy75u5HuQ2HbLLHhS9iyo0MANqQ0ycUjgT
         XAhkyCksgdHc8WXwFSvfIe3jH2KIDms/VCUOWx6mYjPjPtdN9geeiMofEL5aVVbo57IP
         AnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFqC/lz4MJmYxRW+AODc04kNcj15ywFtCaqr13k7NSk=;
        b=gKVGALieyY/oD8OgSkmeAc7uWq/VgdE3hkUUVs0SMVemcrSp8/d658CoTIDmOgsPW/
         YstOKSWl+uGrXtmdy5cIPjhmn2nz+pHNswaSjS0atNriDXgJLoq/PKKXNm7PewA4DVtB
         /WQj2TPH/PIKnQcpziNHGUiQoHETgEJ7G8wFhSmBSklJp+lvUjJuwN1/k3htUVj5xRzn
         dqC82NVCJyDqOHksOv0s8/E1UWm0sYiQh7ZdKTswJLcdeU5U2x7YZiJYt1a1z6jDB0v+
         W3Go4tXb7TDX2/4wvSb1RIEFsMNdAFgRpPht1QPMxNSBNZXWcLpCmixaHslxjfzXqpep
         c0vw==
X-Gm-Message-State: AOAM5314JOAjkMm0RB9v+kyjQXBIelqsD2hPTvQxiCqNnMxC2D2kcxgK
        LeLWay0SLdQDGh/QmEWk3Me/Q0rUqfEMVzOdSeafZwMFlE0HPMLH
X-Google-Smtp-Source: ABdhPJyxUQqAiSH7i4Fm9pDs/qU7EWQVrEgubwEgLHgZzLHkiU0JhFUWHJe4FMA6DFtyS/bjXcvFV/7NduvnRHmB8qo=
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr11460488otk.74.1620452818925;
 Fri, 07 May 2021 22:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210501133647.14350-1-sergio.paracuellos@gmail.com>
 <20210506151839.GA322729@robh.at.kernel.org> <CAMhs-H_Ae4Erx06j2fGSiZXpGo9UWRAkSPPQhFGnZ1D8=NM8cg@mail.gmail.com>
 <CAL_JsqKBH=QK8V+fv-ehQZ_+cL1+Da-9PLEbwPzqR4LodKw3aw@mail.gmail.com>
In-Reply-To: <CAL_JsqKBH=QK8V+fv-ehQZ_+cL1+Da-9PLEbwPzqR4LodKw3aw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 8 May 2021 07:46:48 +0200
Message-ID: <CAMhs-H-DO9CkAnq=w3DSi2u6GFoQ5K8OPw110d36KZKOrq0aOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: staging: mt7621-pci: PCIe binding
 documentation for MT76721 SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, May 7, 2021 at 10:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 6, 2021 at 11:41 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > Thanks for the review.
> >
> > On Thu, May 6, 2021 at 5:18 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sat, May 01, 2021 at 03:36:46PM +0200, Sergio Paracuellos wrote:
> > > > Add device tree binding documentation for PCIe in MT7621 SoCs.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >
> > > > Hi Rob,
> > > >
> > > > Some concerns here. I was not be able to found any case similar to
> > > > this binding where sub-nodes describing each pcie port interface
> > > > are needed. I added them to the 'examples' directly without saying
> > > > anything about properties in any other place since its properties
> > > > seems to be covered in 'pci-bus.yaml' schema definition. I don't
> > > > know if this is the way, I have checked against schema and I noticed
> > > > I am forced to add 'device_type' property in each subnode because
> > > > schema checker complains that this is mandatory. So I have added
> > > > it and schema is properly being validated:
> > > >
> > > > Before add the 'device_type' in each subnode:
> > > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
> > > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
> > > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
> > > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > >
> > > Each port is a PCI bridge, right? If so, then 'pcie' for the node name
> > > and 'device_type = "pci";' are correct.
> >
> > Yes it is, thanks for clarification.
> >
> > >
> > > >
> > > > After adding it:
> > > > CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > >
> > > Validates all the schema
> > >
> > > > SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > >
> > > Preprocesses all the schema
> > >
> > > > DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts
> > >
> > > Extracts the example to dts file
> > >
> > > > DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
> > >
> > > Converts the example to yaml
> > >
> > > > CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
> > >
> > > Runs the checks.
> > >
> > > >
> > > > Looks a bit redundant and maybe I am doing something wrong...
> >
> > I meant redundant the 'device_type=pci' in all of the child nodes, not
> > the messages I got when check against the schema but thanks also for
> > explanation :).
> >
> > > >
> > > > Thanks in advance for clarification.
> > > >
> > > > Best regards,
> > > >     Sergio Paracuellos
> > > >
> > > >
> > > >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 144 ++++++++++++++++++
> > > >  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
> > > >  2 files changed, 144 insertions(+), 104 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > >  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > > new file mode 100644
> > > > index 000000000000..9c1d05d929a2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > > @@ -0,0 +1,144 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: MediaTek MT7621 PCIe controller
> > > > +
> > > > +maintainers:
> > > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > +
> > > > +description: |+
> > > > +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > > > +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: mediatek,mt7621-pci
> > > > +
> > > > +  reg:
> > > > +    items:
> > > > +      - description: host-pci bridge registers
> > > > +      - description: pcie port 0 RC control registers
> > > > +      - description: pcie port 1 RC control registers
> > > > +      - description: pcie port 2 RC control registers
> > >
> > > Are these config space registers or MT7621 specific?
> >
> > All of them are MT7621 specific.
> >
> > >
> > > > +
> > > > +  ranges:
> > > > +    maxItems: 2
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 3
> > >
> > > What are the 3 interrupts?
> >
> > These are one interrupt per root port. In next version this will
> > change in favour of using interrupt-map and interrupt-map-mask instead
> > of use interrupts and a custom 'map_irq' callback in driver code.
> > Please see:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=aed0b711cc791d075e716c397ff6b26bf50345a6
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=3e278e3064511b1606d406db0e26b2fee593fb55
> >
> > This is the way used in mt7623 already mainlined binding.
> >
> > > > +
> > > > +  resets:
> > > > +    items:
> > > > +      - description: pcie port 0 reset.
> > > > +      - description: pcie port 1 reset.
> > > > +      - description: pcie port 2 reset.
> > >
> > > This and clocks should perhaps be in each child node.
> >
> > I followed here style in mt7623 already mainlined bindings which are
> > in the main node. Is there a strong reason to be changed into child
> > nodes or can I maintain this as it is?
>
> Okay, I had no idea because you didn't mention it. Why are you
> creating a new binding then? Looks like they are pretty similar. At
> least don't invent new *-names.

Old ramips based SoCs like mt7621 are not really maintained by
mediatek. They are focused in arm-based stuff (like mentioned mt7623
SoC). Ramips drivers and so on normally comes from openwrt community
based on SDK driver code. Until now (near to three years?) no comments
from mediatek have come from any of my changes and new drivers for
this SoC (like the clock one I recently be able to mainline) I am
trying to maintain. That is why if there is not a real problem I do
think is better this to have its own binding.

What do you mean with "don't invent new *-names" part?

>
> However, you should be aware of this pending change:
>
> https://lore.kernel.org/linux-pci/20210406034410.24381-1-chuanjia.liu@mediatek.com/
>
> So perhaps mt7621 should follow that?

Thanks for the link. Because there is no documentation at all for the
Pcie in MT7621 SoCs, and old drivers I have been cleaning and
maintaining from a while now had nothing MSI related I think I cannot
suppose anything and don't really know if mt7621 should follow that.
Both Mt7622 and Mt7612 SocS seem to be arm64 based architectures. All
the ramips stuff and this kind of SoCs are not really maintained,
AFAICT, but are supported because of openwrt people use them a lot.



>
> Rob

Thanks for the review and comments.

Best regards,
    Sergio Paracuellos
