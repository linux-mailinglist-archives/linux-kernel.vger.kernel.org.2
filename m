Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF7376B35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhEGUjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhEGUjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:39:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E02B16145D;
        Fri,  7 May 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620419901;
        bh=hrASAZVkDIioAhyyZHzYMy82DUnmzBHVMSMsTq9DZDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qhu8eOmlNMPNt0j8M+fceDp3tnr4Igi6V3mz/8EXDE9KP0T0XLWVpsr6AsoYcNjI8
         /2h8QlI2iYgU4T3g059W5l7F/8apnG9FB/liShmdepuuLcYgENyq1h5XL4FHdZKOmD
         TzraDNO8XrZjHq3nSLwLUvOHU8mW2kCT/N0RIdcLQh7yl1OIOU4wRexyKJscBDOI+r
         MRfthXYOE70qXJDiar0/cQGP8A78w1O03WfYjzmi4bdK/FOWzQdB7iQ4z3Ir+uYza6
         EztulOAVBYrarWAxczRp5UxLjt7d74LlIQT8snxspiK6b2kPl9DDJfrdL155rt+34P
         LbTQVl0kFy6sA==
Received: by mail-ed1-f53.google.com with SMTP id c22so11662110edn.7;
        Fri, 07 May 2021 13:38:21 -0700 (PDT)
X-Gm-Message-State: AOAM530vd5EskaALiVjGK0co8E3ge0gwQrr/O65NFFWTTr2uy3oA1cUW
        OLxMb1iHRgLOgUlH/hrAytsdblFJGDu0aaI7eg==
X-Google-Smtp-Source: ABdhPJyu5zyoW++LFChadj09PU067WEsO1tO6y0xSQtqkyLhEyRkrOv9bZmfaSKjm168r7xXYWnk8Y5pCt8CLvaXiaY=
X-Received: by 2002:a05:6402:c7:: with SMTP id i7mr14008405edu.194.1620419900275;
 Fri, 07 May 2021 13:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210501133647.14350-1-sergio.paracuellos@gmail.com>
 <20210506151839.GA322729@robh.at.kernel.org> <CAMhs-H_Ae4Erx06j2fGSiZXpGo9UWRAkSPPQhFGnZ1D8=NM8cg@mail.gmail.com>
In-Reply-To: <CAMhs-H_Ae4Erx06j2fGSiZXpGo9UWRAkSPPQhFGnZ1D8=NM8cg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 May 2021 15:38:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBH=QK8V+fv-ehQZ_+cL1+Da-9PLEbwPzqR4LodKw3aw@mail.gmail.com>
Message-ID: <CAL_JsqKBH=QK8V+fv-ehQZ_+cL1+Da-9PLEbwPzqR4LodKw3aw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: staging: mt7621-pci: PCIe binding
 documentation for MT76721 SoCs
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 11:41 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for the review.
>
> On Thu, May 6, 2021 at 5:18 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, May 01, 2021 at 03:36:46PM +0200, Sergio Paracuellos wrote:
> > > Add device tree binding documentation for PCIe in MT7621 SoCs.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >
> > > Hi Rob,
> > >
> > > Some concerns here. I was not be able to found any case similar to
> > > this binding where sub-nodes describing each pcie port interface
> > > are needed. I added them to the 'examples' directly without saying
> > > anything about properties in any other place since its properties
> > > seems to be covered in 'pci-bus.yaml' schema definition. I don't
> > > know if this is the way, I have checked against schema and I noticed
> > > I am forced to add 'device_type' property in each subnode because
> > > schema checker complains that this is mandatory. So I have added
> > > it and schema is properly being validated:
> > >
> > > Before add the 'device_type' in each subnode:
> > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
> > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
> > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
> > > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> >
> > Each port is a PCI bridge, right? If so, then 'pcie' for the node name
> > and 'device_type = "pci";' are correct.
>
> Yes it is, thanks for clarification.
>
> >
> > >
> > > After adding it:
> > > CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >
> > Validates all the schema
> >
> > > SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >
> > Preprocesses all the schema
> >
> > > DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts
> >
> > Extracts the example to dts file
> >
> > > DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
> >
> > Converts the example to yaml
> >
> > > CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
> >
> > Runs the checks.
> >
> > >
> > > Looks a bit redundant and maybe I am doing something wrong...
>
> I meant redundant the 'device_type=pci' in all of the child nodes, not
> the messages I got when check against the schema but thanks also for
> explanation :).
>
> > >
> > > Thanks in advance for clarification.
> > >
> > > Best regards,
> > >     Sergio Paracuellos
> > >
> > >
> > >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 144 ++++++++++++++++++
> > >  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
> > >  2 files changed, 144 insertions(+), 104 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > >  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > new file mode 100644
> > > index 000000000000..9c1d05d929a2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > @@ -0,0 +1,144 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek MT7621 PCIe controller
> > > +
> > > +maintainers:
> > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > +
> > > +description: |+
> > > +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > > +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,mt7621-pci
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: host-pci bridge registers
> > > +      - description: pcie port 0 RC control registers
> > > +      - description: pcie port 1 RC control registers
> > > +      - description: pcie port 2 RC control registers
> >
> > Are these config space registers or MT7621 specific?
>
> All of them are MT7621 specific.
>
> >
> > > +
> > > +  ranges:
> > > +    maxItems: 2
> > > +
> > > +  interrupts:
> > > +    maxItems: 3
> >
> > What are the 3 interrupts?
>
> These are one interrupt per root port. In next version this will
> change in favour of using interrupt-map and interrupt-map-mask instead
> of use interrupts and a custom 'map_irq' callback in driver code.
> Please see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=aed0b711cc791d075e716c397ff6b26bf50345a6
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=3e278e3064511b1606d406db0e26b2fee593fb55
>
> This is the way used in mt7623 already mainlined binding.
>
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: pcie port 0 reset.
> > > +      - description: pcie port 1 reset.
> > > +      - description: pcie port 2 reset.
> >
> > This and clocks should perhaps be in each child node.
>
> I followed here style in mt7623 already mainlined bindings which are
> in the main node. Is there a strong reason to be changed into child
> nodes or can I maintain this as it is?

Okay, I had no idea because you didn't mention it. Why are you
creating a new binding then? Looks like they are pretty similar. At
least don't invent new *-names.

However, you should be aware of this pending change:

https://lore.kernel.org/linux-pci/20210406034410.24381-1-chuanjia.liu@mediatek.com/

So perhaps mt7621 should follow that?

Rob
