Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD03BE570
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGGJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:21:51 -0400
Received: from mail.thorsis.com ([92.198.35.195]:35538 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhGGJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:21:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id D85AC1C3B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:19:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JxV1eHRqU9bO for <linux-kernel@vger.kernel.org>;
        Wed,  7 Jul 2021 11:19:07 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id CAF7A1C62; Wed,  7 Jul 2021 11:19:06 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: i.mx]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Wed, 07 Jul 2021 11:18:53 +0200
Message-ID: <2691583.eailiBHnQg@ada>
In-Reply-To: <20210706181308.1aa21d00@xps13>
References: <20210625123821.207458-1-s.riedmueller@phytec.de> <20210706181308.1aa21d00@xps13>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

Am Dienstag, 6. Juli 2021, 18:13:08 CEST schrieb Miquel Raynal:
> Hi Stefan,
>=20
> Stefan Riedmueller <s.riedmueller@phytec.de> wrote on Fri, 25 Jun 2021
>=20
> 14:38:21 +0200:
> > The blocks containing the bad block table can become bad as well. So
> > make sure to skip any blocks that are marked bad when searching for the
> > bad block table.
> >=20
> > Otherwise in very rare cases where two BBT blocks wear out it might
> > happen that an obsolete BBT is used instead of a newer available
> > version.
> >=20
> > This only applies to drivers which make use of a bad block marker in
> > flash.
> > Other drivers won't be able to identify bad BBT blocks and thus can't s=
kip
> > these.
> >=20
> > Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
>=20
> Besides the alignment of the helper parameters (nitpick) the patch
> looks good to me. If we can get someone to test it before the merge
> window closes it's perfect. Otherwise I'll apply it and we'll let robots
> do the job.

Added the patch on top of v5.10.21 and booted a SAMA5D27 based board, from =
the=20
boot log:

nand: device found, Manufacturer ID: 0x01, Chip ID: 0xda
nand: AMD/Spansion S34ML02G1
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
Bad block table found at page 131008, version 0xFF
Bad block table found at page 130944, version 0xFF
6 cmdlinepart partitions found on MTD device atmel_nand
Creating 6 MTD partitions on "atmel_nand":
0x000000000000-0x000000040000 : "bootstrap"
0x000000040000-0x000000100000 : "uboot"
0x000000100000-0x000000140000 : "env1"
0x000000140000-0x000000180000 : "env2"
0x000000180000-0x000000200000 : "reserved"
0x000000200000-0x000010000000 : "UBI"
NET: Registered protocol family 17
ubi0: attaching mtd5
random: fast init done
ubi0: scanning is finished
ubi0: attached mtd5 (name "UBI", size 254 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
ubi0: good PEBs: 2028, bad PEBs: 4, corrupted PEBs: 0
ubi0: user volume: 4, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 4/1, WL threshold: 4096, image sequence numbe=
r:=20
1600812189
ubi0: available PEBs: 0, total reserved PEBs: 2028, PEBs reserved for bad P=
EB=20
handling: 36
ubi0: background thread "ubi_bgt0d" started, PID 85

No suspicious other messages.=20

Not sure if that device would be affected anyways. No bad blocks are known =
on=20
this flash, device behaves as usual.

HTH & Greets
Alex

>=20
> > ---
> >=20
> > Hi,
> >=20
> > this is the second approach of this patch. The first one [1] unfortunat=
ely
> > lead to boot failures on i.MX 27 boards [2] since the i.MX 27 driver us=
es
> > the bad block marker position for the bad block table marker which lead
> > to falsely identifying all BBT blocks as bad.
> >=20
> > This new patch now skips the check for bad BBT blocks if the BBT marker
> > position in OOB overlaps with the bad block marker position or if a dri=
ver
> > can't use bad block markers in flash at all (NAND_BBT_NO_OOB_BBM or
> > NAND_NO_BBM_QUIRK are set). This hopefully makes sure we don't break
> > drivers which cannot check for bad BBT blocks due to the limitations
> > mentioned before.
> >=20
> > I was only able to test this patch on a phyCORE-i.MX 6 and a phyCARD-i.=
MX
> > 27. Therfore would really appreciate more people testing this to make
> > sure I have not missed another use case where the bad block marker
> > position in OOB is used in a different way than for the BBM.
> >=20
> > Regards,
> > Stefan
> >=20
> > [1]
> > https://lore.kernel.org/linux-mtd/20210325102337.481172-1-s.riedmueller=
@p
> > hytec.de/ [2]
> > https://lore.kernel.org/linux-mtd/CAOMZO5DufVR=3D+EzCa1-MPUc+ZefZVTXb5K=
gu3W
> > xms7cxw9GmGg@mail.gmail.com/>=20
> >  drivers/mtd/nand/raw/nand_bbt.c | 34 +++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >=20
> > diff --git a/drivers/mtd/nand/raw/nand_bbt.c
> > b/drivers/mtd/nand/raw/nand_bbt.c index dced32a126d9..2a30714350ee 1006=
44
> > --- a/drivers/mtd/nand/raw/nand_bbt.c
> > +++ b/drivers/mtd/nand/raw/nand_bbt.c
> > @@ -447,6 +447,36 @@ static int scan_block_fast(struct nand_chip *this,
> > struct nand_bbt_descr *bd,>=20
> >  	return 0;
> > =20
> >  }
> >=20
> > +/* Check if a potential BBT block is marked as bad */
> > +static int bbt_block_checkbad(struct nand_chip *this,
> > +				      struct nand_bbt_descr *td,
> > +				      loff_t offs, uint8_t *buf)
> > +{
> > +	struct nand_bbt_descr *bd =3D this->badblock_pattern;
> > +
> > +	/*
> > +	 * No need to check for a bad BBT block if the BBM area overlaps with
> > +	 * the bad block table marker area in OOB since writing a BBM here
> > +	 * invalidates the bad block table marker anyway.
> > +	 */
> > +	if (!(td->options & NAND_BBT_NO_OOB) &&
> > +	    td->offs >=3D bd->offs && td->offs < bd->offs + bd->len)
> > +		return 0;
> > +
> > +	/*
> > +	 * There is no point in checking for a bad block marker if writing
> > +	 * such marker is not supported
> > +	 */
> > +	if (this->bbt_options & NAND_BBT_NO_OOB_BBM ||
> > +	    this->options & NAND_NO_BBM_QUIRK)
> > +		return 0;
> > +
> > +	if (scan_block_fast(this, bd, offs, buf) > 0)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >  /**
> > =20
> >   * create_bbt - [GENERIC] Create a bad block table by scanning the dev=
ice
> >   * @this: NAND chip object
> >=20
> > @@ -560,6 +590,10 @@ static int search_bbt(struct nand_chip *this, uint=
8_t
> > *buf,>=20
> >  			int actblock =3D startblock + dir * block;
> >  			loff_t offs =3D (loff_t)actblock << this->bbt_erase_shift;
> >=20
> > +			/* Check if block is marked bad */
> > +			if (bbt_block_checkbad(this, td, offs, buf))
> > +				continue;
> > +
> >=20
> >  			/* Read first page */
> >  			scan_read(this, buf, offs, mtd->writesize, td);
> >  			if (!check_pattern(buf, scanlen, mtd->writesize, td)) {
>=20
> Thanks,
> Miqu=E8l
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/




