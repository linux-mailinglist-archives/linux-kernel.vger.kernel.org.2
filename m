Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563C3A1DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFIThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhFIThS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:37:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5464A613E7;
        Wed,  9 Jun 2021 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623267323;
        bh=Rb8w6UjuDMmlZuyHx9Ur9fRekoEfzLMt84rAQy0iXAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/Jselrgx3+ysGSiAxb5+FZNXYl81L/la3bNgHVIUoq28TUs/IUzpm2xR9irO4fB9
         d4uriMHZ+5TkxEOL3mHMy6YtM7Om/wix2c/rYJvo442T0SLuBi6oyZFdxTOKMCfAX6
         BsOKsNHEy6OI+aVkm/wFxvN3kaszNbj0rS/Rw3TLkWNx6uKy7jt6svGk1NwhG7bQTI
         MeHiotEaHSMgZt2NFF2efMQN3ZHYRBah1zq8Za13JkTie1sM1L5ps4req3LLbhkLOC
         Ji9wMyQM7U6v5yHLY80smLdOHsmvTS/75Vjw2fCh7rqI7WHniSiTM76y1b5PFLtUT9
         MtLB7gcgrXIuQ==
Received: by mail-ed1-f48.google.com with SMTP id ba2so28118509edb.2;
        Wed, 09 Jun 2021 12:35:23 -0700 (PDT)
X-Gm-Message-State: AOAM5304QQqWqzZQi2iBntGC/FUS+6rG/Mphl+59F6UmilqcJjXQ8hsI
        QZS4RlVMQ2Qwoz7Op2/Bu135fep0vJkTsbTdVg==
X-Google-Smtp-Source: ABdhPJyQAe9Rk2VNHsqANmo9SGouwrqZPoV3pKjW0S+0nYq4rEDtuK7M3muw2U4Jeg0hIGlfxhB7E+efgIo9NtqqWR4=
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr1030756edz.62.1623267321741;
 Wed, 09 Jun 2021 12:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-10-miquel.raynal@bootlin.com> <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
 <20210609153410.53eadf8e@xps13>
In-Reply-To: <20210609153410.53eadf8e@xps13>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Jun 2021 14:35:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJP2Thvehn-OfsYYdBOTqQTp_-HFoKAK6aT27JENDWWdA@mail.gmail.com>
Message-ID: <CAL_JsqJP2Thvehn-OfsYYdBOTqQTp_-HFoKAK6aT27JENDWWdA@mail.gmail.com>
Subject: Re: [PATCH v22 09/18] dt-binding: memory: pl353-smc: Convert to yaml
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helmut Grohne <helmut.grohne@intenta.de>,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 8:34 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Krzysztof,
>
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> Jun 2021 14:12:40 +0200:
>
> > On 09/06/2021 10:01, Miquel Raynal wrote:
> > > Convert this binding file to yaml schema.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
> > >  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
> > >  2 files changed, 133 insertions(+), 45 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> > > new file mode 100644
> > > index 000000000000..1de6f87d4986
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> > > @@ -0,0 +1,133 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
> > > +
> > > +maintainers:
> > > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > > +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > > +
> > > +description:
> > > +  The PL353 Static Memory Controller is a bus where you can connect two kinds
> > > +  of memory interfaces, which are NAND and memory mapped interfaces (such as
> > > +  SRAM or NOR).
> > > +
> > > +# We need a select here so we don't match all nodes with 'arm,primecell'
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - arm,pl353-smc-r2p1
> >
> > That's a const... but also I don't get the need for select.
>
> I think this is needed to ensure this binding is not enforced against
> arm,primecell compatible nodes which are not featuring the
> arm,pl353-smc-r2p1 compatible.
>
> >
> > > +  required:
> > > +    - compatible

Ah, required is there already. So only change is using 'const' for single entry.

> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^memory-controller@[0-9a-f]+$"
> > > +
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - arm,pl353-smc-r2p1
> > > +          - enum:
> > > +              - arm,primecell
> >
> > This looks unusual. Basically you change the bindings, because before
> > they required "arm,pl353-smc-r2p1", "arm,primecell".
>
> That is precisely what I try to match and I think it works. Perhaps
> this version is easier to extend when a new compatible comes in.
> However, I am fine using an alternative formula, like below if you
> think it's better:
>
> compatible:
>   items:
>     - const: arm,pl353-smc-r2p1
>     - const: arm,primecell

Yes, please.

> > Don't you want here items:
> >  - const: ...
> >  - const: ...
> > ?
> >
> > > +
> > > +  "#address-cells":
> > > +    const: 2
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: configuration registers for the host and sub-controllers
> >
> > Just maxItems. Description is obvious.
>
> I don't think it is that obvious because there are actually 4 areas
> and, because of the yaml language, we only describe one in the reg
> property while the others and defined in the ranges property, but
> that's fine by me, I'll drop the description and stick to a
> maxItems entry.

I think it is worthwhile to state what region this is AND the chip
select regions are in 'ranges'. Without the latter part, I agree it
seems like a genericish description.

> >
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: the clock for the memory device bus
> > > +      - description: the main clock of the controller
> >
> > Isn't apb_pclk the bus clock (so second item below)?
>
> The SMC has two clock domains referred as aclk and mclk. In the TRM,
> aclk is described as "Clock for the AXI domain". The AXI interface is
> used to trigger CMD/ADDR/DATA cycles on the memory bus. There is also
> an APB interface used to reach the SMC registers. I *think* that
> both APB and AXI domains are fed by the same apb_pclk source but I
> might be wrong. Hence memclk would just feed the memory bus that bonds
> the memory device (eg. the NAND flash) to the host controller.
>
> This is my current understanding but if you think it works differently
> I'm all ears because this part is not 100% clear to me.
>
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: memclk
> > > +      - const: apb_pclk
> >
> >
> > > +
> > > +  ranges:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    description: |
> > > +      Memory bus areas for interacting with the devices. Reflects
> > > +      the memory layout with four integer values following:
> > > +      <cs-number> 0 <offset> <size>
> > > +    items:
> > > +      - description: NAND bank 0
> > > +      - description: NOR/SRAM bank 0
> > > +      - description: NOR/SRAM bank 1
> > > +
> > > +  interrupts: true
> > > +
> > > +patternProperties:
> > > +  ".*@[0-9]+,[0-9]+$":
> >
> > Match with start ^. I think you cannot have 9 nodes and hex can appear
> > in address so maybe:
> > "^.*@[0-3],[a-f0-9]+$":
>
> I think Rob even now prefers to drop the ^.* prefix, but you're right on
> the two other points so I'll stick to:
>
>   "@[0-3],[a-f0-9]+$"

+1
