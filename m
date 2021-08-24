Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794093F66BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhHXR1D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Aug 2021 13:27:03 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58603 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhHXRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:22:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0A9BF200003;
        Tue, 24 Aug 2021 17:22:04 +0000 (UTC)
Date:   Tue, 24 Aug 2021 19:22:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kestrel seventyfour <kestrelseventyfour@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210824192203.076df55e@xps13>
In-Reply-To: <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
References: <20210808072643.GA5084@ubuntu>
        <20210816093126.442f74a1@xps13>
        <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
        <20210819100334.6af2d86e@xps13>
        <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
        <20210823172413.0bc4ab3a@xps13>
        <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Tue, 24 Aug
2021 09:15:49 +0200:

> Hi Miquèl,
> 
> Am Mo., 23. Aug. 2021 um 17:24 Uhr schrieb Miquel Raynal
> <miquel.raynal@bootlin.com>:
> >
> > Hi Kestrel,
> >
> > Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Mon, 23 Aug
> > 2021 13:19:43 +0200:
> >  
> > > Hi Miquèl,
> > >
> > > Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
> > > <miquel.raynal@bootlin.com>:  
> ...
> > >
> > > thank you for your response.
> > > If I remove the nand-ecc-xxx properties in the device tree, the device with
> > > the Toshiba NAND chip is working. However, the device with the Micron
> > > NAND fails with NO ECC functions supplied; hardware ECC not possible,
> > > seems to be at line 5367 or equivalent.
> > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L5367
> > >
> > > It looks like the micron nand driver supports on die only if its
> > > specified int the
> > > Device tree:
> > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_micron.c#L511
> > > The Micron NAND driver probably needs to set the ECC type to ON DIE if the
> > > variable ondie contains the supported attribute?!  
> >
> > You're right but I don't see any easy upstream-able solution here.
> > Changing the behavior in the Xway driver would certainly break users,
> > changing the behavior in the Micron driver would certainly break even
> > more users. The root cause being an absence of proper description (the
> > integration changed). Honestly I feel stuck, maybe you can try to
> > register your device, if it fails, change the integration in the driver
> > (to an ondie ecc engine) then retry?
> >
> > Thanks,
> > Miquèl  
> 
> Do you think adding something like below at the following location
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/xway_nand.c#L223
> would be upstreamable (with or without device tree property?)?
> 
>         err = nand_scan(&data->chip, 1);
>         if (err /* && of_property_read_bool(np, "lantiq,retry-on-die") */) {
>                 data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
>                 err = nand_scan(&data->chip, 1);
>                 if (err) return err;
>         }
> 
> It still throws the kernel warning on first try, but the second try then works.

Can you please remind me what is xway/lantiq/your setup/how public it
is/who's using this driver?

Thanks,
Miquèl
