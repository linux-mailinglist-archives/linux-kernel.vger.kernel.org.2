Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1A3A15BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhFINgS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 09:36:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47895 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhFINgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:36:13 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F05A6C0006;
        Wed,  9 Jun 2021 13:34:11 +0000 (UTC)
Date:   Wed, 9 Jun 2021 15:34:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: Re: [PATCH v22 09/18] dt-binding: memory: pl353-smc: Convert to
 yaml
Message-ID: <20210609153410.53eadf8e@xps13>
In-Reply-To: <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
        <20210609080112.1753221-10-miquel.raynal@bootlin.com>
        <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
Jun 2021 14:12:40 +0200:

> On 09/06/2021 10:01, Miquel Raynal wrote:
> > Convert this binding file to yaml schema.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
> >  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
> >  2 files changed, 133 insertions(+), 45 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> > new file mode 100644
> > index 000000000000..1de6f87d4986
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > +
> > +description:
> > +  The PL353 Static Memory Controller is a bus where you can connect two kinds
> > +  of memory interfaces, which are NAND and memory mapped interfaces (such as
> > +  SRAM or NOR).
> > +
> > +# We need a select here so we don't match all nodes with 'arm,primecell'
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - arm,pl353-smc-r2p1  
> 
> That's a const... but also I don't get the need for select.

I think this is needed to ensure this binding is not enforced against
arm,primecell compatible nodes which are not featuring the
arm,pl353-smc-r2p1 compatible.

> 
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^memory-controller@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - arm,pl353-smc-r2p1
> > +          - enum:
> > +              - arm,primecell  
> 
> This looks unusual. Basically you change the bindings, because before
> they required "arm,pl353-smc-r2p1", "arm,primecell".

That is precisely what I try to match and I think it works. Perhaps
this version is easier to extend when a new compatible comes in.
However, I am fine using an alternative formula, like below if you
think it's better:

compatible:
  items:
    - const: arm,pl353-smc-r2p1
    - const: arm,primecell

> Don't you want here items:
>  - const: ...
>  - const: ...
> ?
> 
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  reg:
> > +    items:
> > +      - description: configuration registers for the host and sub-controllers  
> 
> Just maxItems. Description is obvious.

I don't think it is that obvious because there are actually 4 areas
and, because of the yaml language, we only describe one in the reg
property while the others and defined in the ranges property, but
that's fine by me, I'll drop the description and stick to a
maxItems entry.

> 
> > +
> > +  clocks:
> > +    items:
> > +      - description: the clock for the memory device bus
> > +      - description: the main clock of the controller  
> 
> Isn't apb_pclk the bus clock (so second item below)?

The SMC has two clock domains referred as aclk and mclk. In the TRM,
aclk is described as "Clock for the AXI domain". The AXI interface is
used to trigger CMD/ADDR/DATA cycles on the memory bus. There is also
an APB interface used to reach the SMC registers. I *think* that
both APB and AXI domains are fed by the same apb_pclk source but I
might be wrong. Hence memclk would just feed the memory bus that bonds
the memory device (eg. the NAND flash) to the host controller.

This is my current understanding but if you think it works differently
I'm all ears because this part is not 100% clear to me.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: memclk
> > +      - const: apb_pclk  
> 
> 
> > +
> > +  ranges:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
> > +      Memory bus areas for interacting with the devices. Reflects
> > +      the memory layout with four integer values following:
> > +      <cs-number> 0 <offset> <size>
> > +    items:
> > +      - description: NAND bank 0
> > +      - description: NOR/SRAM bank 0
> > +      - description: NOR/SRAM bank 1
> > +
> > +  interrupts: true
> > +
> > +patternProperties:
> > +  ".*@[0-9]+,[0-9]+$":  
> 
> Match with start ^. I think you cannot have 9 nodes and hex can appear
> in address so maybe:
> "^.*@[0-3],[a-f0-9]+$":

I think Rob even now prefers to drop the ^.* prefix, but you're right on
the two other points so I'll stick to:

  "@[0-3],[a-f0-9]+$"

> 
> 
> > +    type: object
> > +    description: |
> > +      The child device node represents the controller connected to the SMC
> > +      bus. The controller can be a NAND controller or a pair of any memory
> > +      mapped controllers such as NOR and SRAM controllers.
> > +  
> 
> Best regards,
> Krzysztof

Thanks,
Miquèl
