Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9C3A2786
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJI7B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Jun 2021 04:59:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65075 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:59:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9633340010;
        Thu, 10 Jun 2021 08:56:54 +0000 (UTC)
Date:   Thu, 10 Jun 2021 10:56:53 +0200
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
Subject: Re: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
Message-ID: <20210610105653.2d732c4b@xps13>
In-Reply-To: <ce97c460-14eb-a758-31f6-124585e733f1@canonical.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
        <20210610082040.2075611-18-miquel.raynal@bootlin.com>
        <ce97c460-14eb-a758-31f6-124585e733f1@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Thu,
10 Jun 2021 10:48:16 +0200:

> On 10/06/2021 10:20, Miquel Raynal wrote:
> > Add a yaml description of this NAND controller which is described as a
> > subnode of the SMC bus.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > new file mode 100644
> > index 000000000000..5f126bb9b202
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > @@ -0,0 +1,53 @@
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
> 
> I think you can skip the "items" here and leave only "const: foo".

Crap, I missed that one, you're right. I'll wait a bit for Rob's
feedback and eventually fix it when applying or resend (hopefully) only
the NAND bits.

Thanks,
Miquèl
