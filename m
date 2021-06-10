Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEF3A3004
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJQDJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Jun 2021 12:03:09 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34639 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFJQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:03:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B313C20010;
        Thu, 10 Jun 2021 16:01:08 +0000 (UTC)
Date:   Thu, 10 Jun 2021 18:01:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: Re: [PATCH v23 08/18] dt-binding: memory: pl353-smc: Enhance the
 description of the reg property
Message-ID: <20210610180107.1cc889f3@xps13>
In-Reply-To: <20210610155345.GA1873816@robh.at.kernel.org>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
        <20210610082040.2075611-9-miquel.raynal@bootlin.com>
        <20210610155345.GA1873816@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Krzysztof,

Rob Herring <robh@kernel.org> wrote on Thu, 10 Jun 2021 10:53:45 -0500:

> On Thu, Jun 10, 2021 at 10:20:30AM +0200, Miquel Raynal wrote:
> > The SMC bus controller features several register sets. The one pointed
> > by the reg property is for the SMC configuration (impacts the
> > sub-controllers configuration), while the others are meant to be used to
> > send regular cycles on the memory bus (eg. CMD, ADDR, DATA for a NAND
> > device). Detail this a little bit for the sake of clarity.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../devicetree/bindings/memory-controllers/pl353-smc.txt       | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > index ecd46856f139..ba6a5426f62b 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > @@ -5,7 +5,8 @@ of memory interfaces: NAND and memory mapped interfaces (such as SRAM or NOR).
> >  
> >  Required properties:
> >  - compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
> > -- reg			: Controller registers map and length.
> > +- reg			: SMC controller and sub-controllers configuration
> > +			  registers.  
> 
> I think you could just drop this patch. Otherwise, this doesn't match 
> what's now in the yaml file.

Fine.

Krzysztof, if it's still time you can just take patch 9 which Rob
just acked and forget about this one. I think we'll be good. Otherwise
that will be for the next MW ;)

Thanks,
Miquèl
