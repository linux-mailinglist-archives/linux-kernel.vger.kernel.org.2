Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3B03A15C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhFINiZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 09:38:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60681 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhFINiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:38:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E115C6000B;
        Wed,  9 Jun 2021 13:36:22 +0000 (UTC)
Date:   Wed, 9 Jun 2021 15:36:21 +0200
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
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
Message-ID: <20210609153621.1303bc4d@xps13>
In-Reply-To: <57ef16cd-33e7-6c16-3a24-9634f47831b3@canonical.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
        <20210609080112.1753221-18-miquel.raynal@bootlin.com>
        <57ef16cd-33e7-6c16-3a24-9634f47831b3@canonical.com>
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
Jun 2021 14:01:10 +0200:

> On 09/06/2021 10:01, Miquel Raynal wrote:
> > Add a yaml description of this NAND controller which is described as a
> > subnode of the SMC bus.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > new file mode 100644
> > index 000000000000..e72fa14b4385
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PL353 NAND Controller device tree bindings
> > +
> > +allOf:
> > +  - $ref: "nand-controller.yaml"
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:  
> 
> That's not an enum, but simple const without items.

Ok.

> 
> > +          - arm,pl353-nand-r2p1
> > +
> > +  reg:
> > +    items:
> > +      - items:
> > +          - description: CS with regard to the parent ranges property
> > +          - description: Offset of the memory region requested by the device
> > +          - description: Length of the memory region requested by the device  
> 
> Doesn't it depend on parent's address/size cells?

Yes, but as the child nodes are not defined in the parent's binding
(ie. the SMC) I think it's interesting to have them defined here, no?

> > +
> > +  "#address-cells": true
> > +  "#size-cells": true  
> 
> These should come from nand-controller.yaml

Right, I'll drop these, they are probably redundant.

Thanks,
Miquèl
