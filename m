Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DED3F7870
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhHYPcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Aug 2021 11:32:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52355 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbhHYPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:32:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2819EC0002;
        Wed, 25 Aug 2021 15:31:16 +0000 (UTC)
Date:   Wed, 25 Aug 2021 17:31:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kestrel seventyfour <kestrelseventyfour@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210825173114.04ae2b20@xps13>
In-Reply-To: <CAE9cyGRuoaiTu40Yu0po3dykk1fTq_VkqwNfrQkJq8DR6FPRpw@mail.gmail.com>
References: <20210808072643.GA5084@ubuntu>
        <20210816093126.442f74a1@xps13>
        <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
        <20210819100334.6af2d86e@xps13>
        <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
        <20210823172413.0bc4ab3a@xps13>
        <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
        <20210824192203.076df55e@xps13>
        <CAE9cyGQ9_--=+MGc4_vTV1BkR6jv2RZcixyfLtCozXo349+6KA@mail.gmail.com>
        <20210825105126.4c1c15cb@xps13>
        <CAE9cyGRuoaiTu40Yu0po3dykk1fTq_VkqwNfrQkJq8DR6FPRpw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > > thank you for your response.
> > > > > > > If I remove the nand-ecc-xxx properties in the device tree, the device with
> > > > > > > the Toshiba NAND chip is working. However, the device with the Micron
> > > > > > > NAND fails with NO ECC functions supplied; hardware ECC not possible,
> > > > > > > seems to be at line 5367 or equivalent.
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L5367
> > > > > > >
> > > > > > > It looks like the micron nand driver supports on die only if its
> > > > > > > specified int the
> > > > > > > Device tree:
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_micron.c#L511
> > > > > > > The Micron NAND driver probably needs to set the ECC type to ON DIE if the
> > > > > > > variable ondie contains the supported attribute?!  
> > > > > >
> > > > > > You're right but I don't see any easy upstream-able solution here.
> > > > > > Changing the behavior in the Xway driver would certainly break users,
> > > > > > changing the behavior in the Micron driver would certainly break even
> > > > > > more users. The root cause being an absence of proper description (the
> > > > > > integration changed). Honestly I feel stuck, maybe you can try to
> > > > > > register your device, if it fails, change the integration in the driver
> > > > > > (to an ondie ecc engine) then retry?
> > > > > >
> > > > > > Thanks,
> > > > > > Miquèl  
> > > > >
> > > > > Do you think adding something like below at the following location
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/xway_nand.c#L223
> > > > > would be upstreamable (with or without device tree property?)?
> > > > >
> > > > >         err = nand_scan(&data->chip, 1);
> > > > >         if (err /* && of_property_read_bool(np, "lantiq,retry-on-die") */) {
> > > > >                 data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
> > > > >                 err = nand_scan(&data->chip, 1);
> > > > >                 if (err) return err;
> > > > >         }
> > > > >
> > > > > It still throws the kernel warning on first try, but the second try then works.  
> > > >
> > > > Can you please remind me what is xway/lantiq/your setup/how public it
> > > > is/who's using this driver?
> > > >
> > > > Thanks,
> > > > Miquèl  
> > >
> > > Its for Openwrt, I would like to add support for 3 more devices
> > > AVM fritzbox 3490/5490 and 7490. They all have varying NAND chips.
> > > I have initially created a PR to have my initial patch tested:
> > > https://github.com/openwrt/openwrt/pull/4426
> > > There is already one device supported which has two DTBs one for
> > > Micron and one for non Micron (3370), but its not very straight forward.
> > > Without having this issue solved, flashing those devices would be
> > > possibly having issues depending on NAND chip or the awkward
> > > workaround of flashing one image and if it does not boot, boot the
> > > other one. Without self soldered serial console, it would not very
> > > easy to figure out the NAND manufacturer.
> > > The AVM stock firmware is old kernel and does not use device
> > > tree for NAND, they just query all possible manufacturers and set
> > > up NAND based on manufacturer query.  
> >
> > But in this case can't you check the 'root' compatible against certain
> > values and and some kind of quirk in the ->attach() hook to update the
> > ECC engine to the right one?
> >
> > Thanks,
> > Miquèl  
> 
> maybe I wrote the wrong thing, but what do you mean with root compatible.
> The controller is always NAND xway and I think there are 4 different
> NAND chip types. But the stock firmware just queries the NAND
> manufacturer name, not a date or type/model of the devices. E.g. 7490 can
> have Micron or Macronix NAND, but querying the Micron id or Macronix
> id requires a change to the xway driver?
> Do you mean something like in the first patch do query the manufacturer
> but just for all the 4?
> 
> Thanks, Daniel.

You were talking about new boards, if, on each of these boards, you
know what is the NAND chip, you could retrieve the root compatible (by
root I mean the one at the root of the tree / { } in the DT) and
depending on it change the ECC engine that must be used from the driver
itself.


Thanks,
Miquèl
