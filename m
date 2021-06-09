Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE823A16AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhFIONc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 10:13:32 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38495 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbhFION1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:13:27 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B57C21BF203;
        Wed,  9 Jun 2021 14:11:29 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:11:28 +0200
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
Message-ID: <20210609161128.16cdf5ec@xps13>
In-Reply-To: <77db74d3-c44a-6aa3-1b61-f6bed565fa04@canonical.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
        <20210609080112.1753221-10-miquel.raynal@bootlin.com>
        <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
        <20210609153410.53eadf8e@xps13>
        <77db74d3-c44a-6aa3-1b61-f6bed565fa04@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Rob,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
Jun 2021 15:54:19 +0200:

> On 09/06/2021 15:34, Miquel Raynal wrote:
> > Hi Krzysztof,
> > 
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> > Jun 2021 14:12:40 +0200:
> >   
> >> On 09/06/2021 10:01, Miquel Raynal wrote:  
> >>> Convert this binding file to yaml schema.
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> ---
> >>>  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
> >>>  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
> >>>  2 files changed, 133 insertions(+), 45 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>> new file mode 100644
> >>> index 000000000000..1de6f87d4986
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> >>> @@ -0,0 +1,133 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
> >>> +
> >>> +maintainers:
> >>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> >>> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> >>> +
> >>> +description:
> >>> +  The PL353 Static Memory Controller is a bus where you can connect two kinds
> >>> +  of memory interfaces, which are NAND and memory mapped interfaces (such as
> >>> +  SRAM or NOR).
> >>> +
> >>> +# We need a select here so we don't match all nodes with 'arm,primecell'
> >>> +select:
> >>> +  properties:
> >>> +    compatible:
> >>> +      contains:
> >>> +        enum:
> >>> +          - arm,pl353-smc-r2p1    
> >>
> >> That's a const... but also I don't get the need for select.  
> > 
> > I think this is needed to ensure this binding is not enforced against
> > arm,primecell compatible nodes which are not featuring the
> > arm,pl353-smc-r2p1 compatible.  
> 
> Which seems to be result of unusual compatible match, so once you
> convert to regular match, this select is not needed.

I don't think so, I received a hint from Rob some time ago, he told
me to add this additional select line as in all other arm,primecell
binding.

Rob, any additional info regarding this?


> >>> +
> >>> +  "#address-cells":
> >>> +    const: 2
> >>> +
> >>> +  "#size-cells":
> >>> +    const: 1
> >>> +
> >>> +  reg:
> >>> +    items:
> >>> +      - description: configuration registers for the host and sub-controllers    
> >>
> >> Just maxItems. Description is obvious.  
> > 
> > I don't think it is that obvious because there are actually 4 areas
> > and, because of the yaml language, we only describe one in the reg
> > property while the others and defined in the ranges property, but
> > that's fine by me, I'll drop the description and stick to a
> > maxItems entry.  
> 
> The explanation of all four areas could have sense, but now it states
> the obvious - these are configuration registers :)

Well, that's true :)

Thanks,
Miquèl
