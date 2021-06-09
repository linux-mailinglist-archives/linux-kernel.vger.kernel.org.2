Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C23A1392
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhFIL7O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 07:59:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43267 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbhFIL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:59:07 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B398724000B;
        Wed,  9 Jun 2021 11:57:08 +0000 (UTC)
Date:   Wed, 9 Jun 2021 13:57:07 +0200
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
Subject: Re: [PATCH v22 12/18] memory: pl353-smc: Let lower level controller
 drivers handle inits
Message-ID: <20210609135707.6c9c67cc@xps13>
In-Reply-To: <b9be2ca0-7d62-c5fd-6aa8-e04c57b0f75c@canonical.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
        <20210609080112.1753221-13-miquel.raynal@bootlin.com>
        <b9be2ca0-7d62-c5fd-6aa8-e04c57b0f75c@canonical.com>
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
Jun 2021 13:54:24 +0200:

> On 09/06/2021 10:01, Miquel Raynal wrote:
> > There is no point in having all these definitions at the SMC bus level,
> > these are extremely tight to the NAND controller driver implementation,
> > are not particularly generic, imply more boilerplate than needed, do
> > not really follow the device model by receiving no argument and some of
> > them are actually buggy.
> > 
> > Let's get rid of these right now as there is no current user and keep
> > this driver at a simple level: only the SMC bare initializations.
> > 
> > The NAND controller driver which I am going to introduce will take care
> > of redefining properly all these helpers and using them directly.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/memory/pl353-smc.c | 294 -------------------------------------
> >  include/linux/pl353-smc.h  |  30 ----
> >  2 files changed, 324 deletions(-)
> >  delete mode 100644 include/linux/pl353-smc.h
> >   
> 
> I see you remove here a bunch of code. Are the series still fully
> bisectable?

Absolutely, yes, because this code is currently unused.

Thanks,
Miquèl
