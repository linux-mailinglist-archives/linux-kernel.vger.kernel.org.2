Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8254547B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhKQNuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Nov 2021 08:50:17 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55783 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhKQNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:50:16 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43FB6E0003;
        Wed, 17 Nov 2021 13:47:16 +0000 (UTC)
Date:   Wed, 17 Nov 2021 14:47:15 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] mtd: rawnand: fsmc: Force to use 8 bits access when
 expected
Message-ID: <20211117144715.731a9856@bootlin.com>
In-Reply-To: <20211112163859.23a2487a@xps13>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
        <20211112143855.2678989-3-herve.codina@bootlin.com>
        <20211112163859.23a2487a@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Nov 2021 16:38:59 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Hervé,
> 
> herve.codina@bootlin.com wrote on Fri, 12 Nov 2021 15:38:53 +0100:
> 
> > Some data transfers are expected on 8 bits by the nand core.
> > The fsmc driver did not check this constraint and these transfers
> > can be done on 32 bits depending on buffer alignment and transfers
> > data size.
> > 
> > This patch ensures that these transfers will be 8bits transfers in
> > all cases.  
> 
> I believe there is a misunderstanding here: NAND buses -between the
> NAND controller and the NAND chip- are either 8-bit or 16-bit wide and
> the amount of bytes that you will retrieve per register read is not
> related to it.
> 
> When the controller supports 16-bit accesses, there are certain
> operations that must be performed using only the lowest 8 bits of the
> NAND bus, such as reading a status [1]. In this case, the controller
> must have a way to disable the 16-bit mode temporarily. See [2] and [3]
> for an example. Reading with readb() or readl() will IMHO not impact the
> amount of data lines used for the operation.
> 

Indeed, I misunderstood the force_8bit usage.
This patch is not needed and will be simply removed in v2 series.

Thanks,
Hervé
