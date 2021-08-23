Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB13F4D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhHWPZB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 11:25:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35105 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:25:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4D2206000C;
        Mon, 23 Aug 2021 15:24:14 +0000 (UTC)
Date:   Mon, 23 Aug 2021 17:24:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kestrel seventyfour <kestrelseventyfour@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210823172413.0bc4ab3a@xps13>
In-Reply-To: <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
References: <20210808072643.GA5084@ubuntu>
        <20210816093126.442f74a1@xps13>
        <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
        <20210819100334.6af2d86e@xps13>
        <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kestrel,

Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Mon, 23 Aug
2021 13:19:43 +0200:

> Hi Miquèl,
> 
> Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
> <miquel.raynal@bootlin.com>:
> >
> > Hello,
> >
> > Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Thu, 19 Aug
> > 2021 09:21:42 +0200:
> >  
> > > Hi Miquèl
> > >
> > > Am Mo., 16. Aug. 2021 um 09:31 Uhr schrieb Miquel Raynal
> > > <miquel.raynal@bootlin.com>:  
> > > >
> > > > Hi Daniel,
> > > >
> > > > Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Sun, 8 Aug 2021
> > > > 09:26:43 +0200:
> > > >  
> > > > > Some devices use Micron NAND chips, which use on-die ECC. The hardcoded
> > > > > setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable, because the
> > > > > software ECC on top of the hardware ECC produces errors for every read
> > > > > and write access, not to mention that booting does not work, because
> > > > > the boot loader uses the correct ECC when trying to load the kernel
> > > > > and stops loading on severe ECC errors.
> > > > > This patch requires the devices that currently work with the hard coded
> > > > > setting to set the nand-ecc-mode property to soft in their device
> > > > > tree.
> > > > >  
> > > >
> > > > Please add a Fixes: and Cc: stable tags, you will also need to send to
> > > > stable@vger.kernel.org a different version of the patch for the kernel
> > > > 5.4 IIUC.
> > > >  
> > > > > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > > > > Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl> # tested on BT Home Hub 5A
> > > > > ---
> > > > >  drivers/mtd/nand/raw/xway_nand.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
> > > > > index 26751976e502..0a4b0aa7dd4c 100644
> > > > > --- a/drivers/mtd/nand/raw/xway_nand.c
> > > > > +++ b/drivers/mtd/nand/raw/xway_nand.c
> > > > > @@ -148,8 +148,6 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
> > > > >
> > > > >  static int xway_attach_chip(struct nand_chip *chip)
> > > > >  {
> > > > > -     chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
> > > > > -
> > > > >       if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> > > > >               chip->ecc.algo = NAND_ECC_ALGO_HAMMING;  
> > > >
> > > > You also need to only set the Hamming algorithm when engine_type is
> > > > TYPE_SOFT.
> > > >
> > > > Thanks,
> > > > Miquèl  
> > >
> > > I am really struggling with what to do. For one of the affected
> > > devices, they created two device
> > > trees, one for Micron and one for all others. Which obviously had no
> > > effect due to the
> > > hardcoded settings, which led me to Patch 2 and I thought, so be it.
> > > But the process to figure
> > > out if ones device has Micron Chips is essentially flashing an image
> > > and if it does not work,
> > > use the stock OEM recovery and try the other image.
> > > However, since Micron is the only chip that is treated differently, I wonder
> > > if your first proposal, even though it is hacky, is the better
> > > approach to solve the issue
> > > for the Micron devices not booting and throwing ECC errors. What do you think?
> > > Follow up first patch or this one?  
> >
> > I am not sure we understood each other, your patch is fine, but you
> > need to do something like:
> >
> > static int xway_attach_chip(struct nand_chip *chip)
> > {
> >     if (chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT &&
> >         chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> >          chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
> >
> > In the DT you should not force any ECC engine (drop the nand-ecc-xxx
> > properties) and let the core handle it. It will probably choose the
> > most suitable engines for you.
> >
> > Thanks,
> > Miquèl  
> 
> thank you for your response.
> If I remove the nand-ecc-xxx properties in the device tree, the device with
> the Toshiba NAND chip is working. However, the device with the Micron
> NAND fails with NO ECC functions supplied; hardware ECC not possible,
> seems to be at line 5367 or equivalent.
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L5367
> 
> It looks like the micron nand driver supports on die only if its
> specified int the
> Device tree:
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_micron.c#L511
> The Micron NAND driver probably needs to set the ECC type to ON DIE if the
> variable ondie contains the supported attribute?!

You're right but I don't see any easy upstream-able solution here.
Changing the behavior in the Xway driver would certainly break users,
changing the behavior in the Micron driver would certainly break even
more users. The root cause being an absence of proper description (the
integration changed). Honestly I feel stuck, maybe you can try to
register your device, if it fails, change the integration in the driver
(to an ondie ecc engine) then retry?

Thanks,
Miquèl
