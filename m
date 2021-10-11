Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84BA4291AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbhJKOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:24:31 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:31250 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238919AbhJKOYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633962143; x=1665498143;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=XVUaL/mIzEcWddp3yKONwc+r9ZvulEHeNquCCYXN8f0=;
  b=SkkPLqsskWpBfDExQNV70TSeXE7HRwru4Y3hWuuhFPXCl6cas25/IWMp
   bZ2WbvSYMZbE2dWix4B8PLsw48yEdczkVgP2vXo8UdM1CUdZTH0g2C8N6
   qDy5GAF8Kdb/4c5vh0V7UX3njhXUe53ObBsmuTtxC9e9/eyNdDDSNAgFx
   JwITI7P/Q1cRZBxjdCDxv0tNl8Nvt7UzXLDOXU/pDQB4Zjl7EEChK7kvp
   Nayd+bvxu1rg57jomu/r4qbC4BM8yk38PGxcroH2w03I71nXzmEfaMq61
   sizb9LAo81wCq3idH9e8Ffx3LWmEytdLPPqGxs9mx6FUuM4RvlBY/LtYj
   A==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624312800"; 
   d="scan'208";a="19974711"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Oct 2021 16:22:21 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 11 Oct 2021 16:22:21 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 11 Oct 2021 16:22:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633962141; x=1665498141;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=XVUaL/mIzEcWddp3yKONwc+r9ZvulEHeNquCCYXN8f0=;
  b=MOD1oJ7LaXKDwdH0u5UYA0qSqPq5KBTkJcuUEjhfqvK3Ku2d1gL0J1Nn
   JxcGvAmHGIJpnP+gQoVHHb+lfsg1JLFspWOEX6driNNL1eoc2fLUPGiA/
   whoqnTfF7vJS7iIA5XOIdvkvpihGHUg89sZjaQ78QJMQqD7bQ14jfeExR
   CRqADW0HmxfUYQ80KS0jKjqw9EGWmEtDNOc+UXmjiXZlm8EhzYhWuL6Oh
   9A7Xn5vNbeyCarFCID7MfhmaIkCNrwbUrCh2GBCNNfVKCwyIjxPYgogEg
   ccLO0ojOdmOZ79Ol8bD96RfBce6/y2HThx9quIYJmYQzBqJRCzVeLvJ6v
   g==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624312800"; 
   d="scan'208";a="19974710"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Oct 2021 16:22:21 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id 81E49280065;
        Mon, 11 Oct 2021 16:22:21 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Mon, 11 Oct 2021 16:22:21
 +0200
Subject: AW: (EXT) Re: [PATCH 2/2] mtd: spi-nor: micron-st: Add support for
 output-driver-strength
From:   "Alexander Stein" <Alexander.Stein@ew.tq-group.com>
To:     "Pratyush Yadav" <p.yadav@ti.com>,
        "Alexander Stein" <Alexander.Stein@tq-systems.com>
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Rob Herring" <robh@kernel.org>,
        "Michael Walle" <michael@walle.cc>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        =?us-ascii?Q?linux-mtd=40lists=2Einfrad?= =?us-ascii?Q?ead=2Eorg?= 
        <linux-mtd@lists.infradead.org>,
        =?us-ascii?Q?devicetree=40vger=2Ekernel=2Eorg?= 
        <devicetree@vger.kernel.org>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Oct 2021 14:22:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.K51pswPLSRK1NpSyVG7WYA.gMwmZ6u+1wE@vtuxmail01.tq-net.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pratyush,

> On 08/10/21 01:18PM, Pratyush Yadav wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > Micron flashes support this by the Bits [2:0] in the Enhanced Volatile
> > Configuration Register.
> > Checked datasheets:
> > - n25q_128mb_3v_65nm.pdf
> > - mt25t-qljs-L512-xBA-xxT.pdf
>=20
> What does changing the impedance do=3F Does it improve latency=3F If we use=20
> suboptimal impedance, will the flash still keep working correctly=3F
>=20
> In other words, you need to justify why this patch is needed.

Hardware guys told me this will affect the signal qualitiy when the flash is
sending data. This depends among others on line length. If set incorrectly
voltage overshoots upon 0->1 or 1-> switch might occur. To answer to your
question if the flash will work with incorrect settings: It depends. It might
working the short term, but might fail in the long term.
Also this is completly unrelated to latency.

> > +static int micron_read_evcr(struct spi_nor *nor)
> > +{
> > +=09int ret;
> > +
> > +=09if (nor->spimem) {
> > +=09=09struct spi_mem_op op =3D
> > +=09=09=09SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_EVCR, 1),
> > +=09=09=09=09   SPI_MEM_OP_NO_ADDR,
> > +=09=09=09=09   SPI_MEM_OP_NO_DUMMY,
> > +=09=09=09=09   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>=20
> Are you always guaranteed to be in 1S-1S-1S mode during register write=3F
>=20
> I would suggest calling spi_nor_spimem_setup_op() before this so that it=20
> sets up all the buswidths correctly based on nor->reg_proto.

Thanks, I wasn't aware of that. I'll do that.

> > +
> > +=09=09ret =3D spi_mem_exec_op(nor->spimem, &op);
> > +=09} else {
> > +=09=09ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RD_EVCR, nor->bouncebuf,
> 1);
>=20
> Split into 2 lines=3F

Will do.

> > +=09}
> > +
> > +=09if (ret < 0) {
> > +=09=09dev_err(nor->dev, "error %d reading EVCR\n", ret);
> > +=09=09return ret;
> > +=09}
> > +
> > +=09return nor->bouncebuf[0];
> > +}
> > +
> > +/*
> > + * Write Micron enhanced volatile configuration register
> > + * Return negative if error occurred or configuration register value
> > + */
> > +static int micron_write_evcr(struct spi_nor *nor, u8 evcr)
> > +{
> > +=09nor->bouncebuf[0] =3D evcr;
> > +
> > +=09spi_nor_write_enable(nor);
>=20
> Check return code.

Will do.

> > +
> > +=09if (nor->spimem) {
> > +=09=09struct spi_mem_op op =3D
> > +=09=09=09SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WD_EVCR, 1),
> > +=09=09=09=09   SPI_MEM_OP_NO_ADDR,
> > +=09=09=09=09   SPI_MEM_OP_NO_DUMMY,
> > +=09=09=09=09   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>=20
> Same as above.

Will do.

> > +
> > +=09=09return spi_mem_exec_op(nor->spimem, &op);
> > +=09}
> > +
> > +=09return nor->controller_ops->write_reg(nor, SPINOR_OP_WD_EVCR, nor->bouncebuf,
> 1);
>=20
> Same as above. Split into 2 lines=3F

Will do.

> > +}
> > +
> > +/*
> > + * Supported values from Enahanced Volatile COnfiguration Register (Bits
> 2:0)
> > + */
> > +static const struct micron_drive_strength drive_strength_data[] =3D {
> > +=09{ .ohms =3D 90, .val =3D 1 },
> > +=09{ .ohms =3D 45, .val =3D 3 },
> > +=09{ .ohms =3D 20, .val =3D 5 },
> > +=09{ .ohms =3D 30, .val =3D 7 },
> > +};
> > +
> > +static struct micron_drive_strength const *micron_st_find_drive_strength_entry(u32
> ohms)
> > +{
> > +=09int i;
> > +
> > +=09for (i =3D 0; i < ARRAY_SIZE(drive_strength_data); i++) {
> > +=09=09if (ohms =3D=3D drive_strength_data[i].ohms)
> > +=09=09=09return &drive_strength_data[i];
> > +=09}
> > +=09return NULL;
> > +}
> > +
> > +static void micron_st_post_sfdp(struct spi_nor *nor)
> > +{
> > +=09struct device_node *np =3D spi_nor_get_flash_node(nor);
> > +=09u32 ohms;
> > +
> > +=09if (!np)
> > +=09=09return;
> > +
> > +=09if (!of_property_read_u32(np, "output-driver-strength", &ohms)) {
> > +=09=09struct micron_drive_strength const *entry =3D
> > +=09=09=09micron_st_find_drive_strength_entry(ohms);
> > +
> > +=09=09if (entry) {
> > +=09=09=09int evcrr =3D micron_read_evcr(nor);
> > +
> > +=09=09=09if (evcrr >=3D 0) {
>=20
> This is a bit confusing. Can you instead do:
>=20
> if (evcrr < 0)
> =09return evcrr;
>=20
> ...

Will do.

> > +=09=09=09=09u8 evcr =3D (u8)(evcrr & 0xf8) | entry->val;
>=20
> Don't use magic numbers. Define a bitmask, preferably using GENMASK().

Will do.

> > +
> > +=09=09=09=09micron_write_evcr(nor, evcr);
>=20
> Check return code. Do we need to abort flash probe if this fails, or can=20
> we live with it, despite the suboptimal impedance=3F

Well, it's hard to say. It might work, see above. At least this should raise a warning
if setting the driver strength for some reason.

> > +=09=09=09=09dev_dbg(nor->dev, "%s: EVCR 0x%x\n", __func__,
> > +=09=09=09=09=09(u32)micron_read_evcr(nor));
> > +=09=09=09}
> > +=09=09} else {
> > +=09=09=09dev_warn(nor->dev,
> > +=09=09=09=09"Invalid output-driver-strength property specified: %u",
> > +=09=09=09=09ohms);
> > +=09=09}
> > +=09}
> > +}
> > +
> >  static const struct spi_nor_fixups micron_st_fixups =3D {
> >  =09.default_init =3D micron_st_default_init,
> > +=09.post_sfdp =3D micron_st_post_sfdp,
>=20
> NACK. Not every Micron flash has the EVCR register. For example, the=20
> Micron MT35 flash family does not have an EVCR and the output drive=20
> strength is programmed in a separate register. Set this only for the=20
> flashes that need this.

Thanks for that information. I do not have the MT35 datasheet, so I wasn't aware of it.
I'll stick to MT25Q for now, which is the part number my datasheet is for.

Thanks for your feedback.

Best regards,
Alexander

