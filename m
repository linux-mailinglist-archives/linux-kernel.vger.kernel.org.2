Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13A437589D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhEFQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbhEFQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:42:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8068EC061574;
        Thu,  6 May 2021 09:41:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso5408488otg.9;
        Thu, 06 May 2021 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htiCxuZshJkux8cbRyREXQ3BRqeGVd2tm3LHKemMtAA=;
        b=UI4a5ZAGFDxxCUpbiBiH2ojMcl+b3ouaTbiK9ODHoPJctkx/aWuG2vGo4nPia7z//L
         jQhEq54fYJLV/4/7Y9Ix1L1DbaITKS1DYU8kSH+Qx6mbiTcPgBySzj9hxlmsDGETtOJR
         J8NxVln9Y0fpopHTLqpajjru5MXkYYen2ZYWY4Bb/3ZrsgSoKPJqhGksdVPRH8ALLHSN
         WZ27SxZuCjJLqUCjVja8mjh0tXN73VY/FnoAkp+KWBKX/IopWXwLPo24HPtrEj3GErnc
         g2h7Lj0WYr0WavhtoYeUMevTERmNpWXjC6ROEp9dCOTR2BCuAo0OenGuVxhBH8Fajosp
         0twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htiCxuZshJkux8cbRyREXQ3BRqeGVd2tm3LHKemMtAA=;
        b=ramZglHNLl6loA+tfUSG6ukMPMUnhcKLK2qqkKdIxOv4gcoznGvKtfTZcGqVj+VoG4
         x8dz0/djU4wyQq+D+0apUkiJ1VoMruKFv0k91JUkoDq4jd+srDvj03GKzdKGaBv/0Jvp
         iNgAFLems8rsw21Jku9l7ONbAS7hlGytfJU8XiJHrPXCQxBtprx5XvE9vswKXyjp24W5
         rC0UDQaCjqTTMOXgcTjk3zCTz32Y1S+eoTTgjL/ODjTYK4sX9dqGNF6SIFh8mwJnNSMP
         mKHF6uGM28SB6ukUThdmC60HhdYSoSldwo46GWkmjwSHGy68APql5upaCWGyDg64jHk6
         rO2g==
X-Gm-Message-State: AOAM532/iddDeoVs2ox8pRnfj7zobgZArRCBkquiQA8mzLIvEoHc+BK9
        BEVen5sjIsL+X6BbopwvQvVd+6Ms8G1LL1w7Z20=
X-Google-Smtp-Source: ABdhPJxb+TJnfSbdW/n0EBWvchvI28tIs8PFhZTcYhFDatEMrrFy80ojNdfn3GvDihmUcyK7A4dgSeEiwF/NPiH+H38=
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr4482846otk.74.1620319308829;
 Thu, 06 May 2021 09:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210501133647.14350-1-sergio.paracuellos@gmail.com> <20210506151839.GA322729@robh.at.kernel.org>
In-Reply-To: <20210506151839.GA322729@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 6 May 2021 18:41:36 +0200
Message-ID: <CAMhs-H_Ae4Erx06j2fGSiZXpGo9UWRAkSPPQhFGnZ1D8=NM8cg@mail.gmail.com>
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

Thanks for the review.

On Thu, May 6, 2021 at 5:18 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, May 01, 2021 at 03:36:46PM +0200, Sergio Paracuellos wrote:
> > Add device tree binding documentation for PCIe in MT7621 SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >
> > Hi Rob,
> >
> > Some concerns here. I was not be able to found any case similar to
> > this binding where sub-nodes describing each pcie port interface
> > are needed. I added them to the 'examples' directly without saying
> > anything about properties in any other place since its properties
> > seems to be covered in 'pci-bus.yaml' schema definition. I don't
> > know if this is the way, I have checked against schema and I noticed
> > I am forced to add 'device_type' property in each subnode because
> > schema checker complains that this is mandatory. So I have added
> > it and schema is properly being validated:
> >
> > Before add the 'device_type' in each subnode:
> > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
> > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
> > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> > /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
> > >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>
> Each port is a PCI bridge, right? If so, then 'pcie' for the node name
> and 'device_type = "pci";' are correct.

Yes it is, thanks for clarification.

>
> >
> > After adding it:
> > CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>
> Validates all the schema
>
> > SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>
> Preprocesses all the schema
>
> > DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts
>
> Extracts the example to dts file
>
> > DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
>
> Converts the example to yaml
>
> > CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
>
> Runs the checks.
>
> >
> > Looks a bit redundant and maybe I am doing something wrong...

I meant redundant the 'device_type=pci' in all of the child nodes, not
the messages I got when check against the schema but thanks also for
explanation :).

> >
> > Thanks in advance for clarification.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> >
> >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 144 ++++++++++++++++++
> >  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
> >  2 files changed, 144 insertions(+), 104 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> >  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > new file mode 100644
> > index 000000000000..9c1d05d929a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > @@ -0,0 +1,144 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7621 PCIe controller
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +description: |+
> > +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt7621-pci
> > +
> > +  reg:
> > +    items:
> > +      - description: host-pci bridge registers
> > +      - description: pcie port 0 RC control registers
> > +      - description: pcie port 1 RC control registers
> > +      - description: pcie port 2 RC control registers
>
> Are these config space registers or MT7621 specific?

All of them are MT7621 specific.

>
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    maxItems: 3
>
> What are the 3 interrupts?

These are one interrupt per root port. In next version this will
change in favour of using interrupt-map and interrupt-map-mask instead
of use interrupts and a custom 'map_irq' callback in driver code.
Please see:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=aed0b711cc791d075e716c397ff6b26bf50345a6
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=3e278e3064511b1606d406db0e26b2fee593fb55

This is the way used in mt7623 already mainlined binding.

> > +
> > +  resets:
> > +    items:
> > +      - description: pcie port 0 reset.
> > +      - description: pcie port 1 reset.
> > +      - description: pcie port 2 reset.
>
> This and clocks should perhaps be in each child node.

I followed here style in mt7623 already mainlined bindings which are
in the main node. Is there a strong reason to be changed into child
nodes or can I maintain this as it is?

>
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pcie0
> > +      - const: pcie1
> > +      - const: pcie2
> > +
> > +  clocks:
> > +    items:
> > +      - description: pcie port 0 clock.
> > +      - description: pcie port 1 clock.
> > +      - description: pcie port 2 clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie0
> > +      - const: pcie1
> > +      - const: pcie2
> > +
> > +  phys:
> > +    items:
> > +      - description: Dual-ported phy for pcie port 0 and 1.
> > +      - description: Phy for pcie port 2.
> > +
> > +  phy-names:
> > +    items:
> > +      - const: pcie-phy0
> > +      - const: pcie-phy2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - interrupts
> > +  - resets
> > +  - reset-names
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
> > +  - reset-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> > +
> > +    pcie: pcie@1e140000 {
> > +        compatible = "mediatek,mt7621-pci";
> > +        reg = <0x1e140000 0x100>,
> > +              <0x1e142000 0x100>,
> > +              <0x1e143000 0x100>,
> > +              <0x1e144000 0x100>;
> > +
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&pcie_pins>;
> > +        device_type = "pci";
> > +        bus-range = <0 255>;
>
> That's the default, so not needed.

Ok, will drop this.

>
> > +        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
> > +                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
> > +        interrupt-parent = <&gic>;
> > +        interrupts = <GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > +        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
> > +        reset-names = "pcie0", "pcie1", "pcie2";
> > +        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
> > +        clock-names = "pcie0", "pcie1", "pcie2";
> > +        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
> > +        phy-names = "pcie-phy0", "pcie-phy2";
> > +        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> > +
> > +        pcie@0,0 {
> > +            reg = <0x0000 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges;
> > +            bus-range = <0x00 0xff>;
>
> Besides being the default, I don't think this makes sense here as it
> belongs in the parent unless you had some subset of bus numbers allowed
> by the parent.

That's not the case so I will drop bus-ranges property from all the
child nodes also.
>
> > +        };
> > +
> > +        pcie@1,0 {
> > +            reg = <0x0800 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges;
> > +            bus-range = <0x00 0xff>;
> > +        };
> > +
> > +        pcie@2,0 {
> > +            reg = <0x1000 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            ranges;
> > +            bus-range = <0x00 0xff>;
> > +        };
> > +    };
> > +...

Best regards,
    Sergio Paracuellos
