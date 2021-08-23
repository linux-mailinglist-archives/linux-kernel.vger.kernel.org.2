Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AD3F4994
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhHWLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhHWLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:20:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:19:54 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e15so13443818qtx.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4PbfMieHLNy2oJjY0XJuBOyImh9wvo44rr+tmqHI2Ug=;
        b=L6DISO0PrFOv7mJZL1glU0wLACXUv/vMMn+QWZA+uKq24fu7BeUXsn/WMb3Ub95vv9
         kJfmVgvOZAhEeyk6Em0z6muRmB24rwGlC5em0HylG9ywNi7sLzF50mqx33UFs1nBjAQO
         6m2W9Oo7opSL4CKetgsK6eeh9eskTCsbmjX0VbJFjkubczdhhDijclGJU6WEwhnmuwga
         hGrMjAqcl5Xk14xeV0U2KyD1EB4W/tS4EgYjkFqCSKk7cLqw80W0WlaMdetSTOyTWfpn
         q+3ZpagUrW/E4oxsodqkYHPA/7YJMyWjsfKyTWaTF57VR5unswA9yVzFueT/uf36rSpX
         jwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4PbfMieHLNy2oJjY0XJuBOyImh9wvo44rr+tmqHI2Ug=;
        b=eSqVV5Wp7QB09aJADVqCNhFUK1cB4XNUU2Xlj/y/xFLZwsb0wzCG7CYWCl3r7pgyUr
         2QDhgt/UwttNiLtRkYUrveT3ArjlYm2PTvQFsF4WI0yKGq3dMS8s7AKtzbXuHH1SQ3yD
         XKyWfVTzUxHJBKZ6zYjSyJ9rx8wS02Zs9d31GSaIwZO4Q56zqJMZQWjpqlHOomso3RA9
         LutITEmxiooBvvNpi/pNGelp9W4/Rsod2L74yAH5GBE4R+ZK8ZooMfS6vxin4Wyw+tSz
         4MIH9FIi/PlbigZOB0vNV5slC9FBI3gh0uIYkNcAmUKh9VeWZaLxcpIVKARSXR3KWwPW
         DdDA==
X-Gm-Message-State: AOAM533IAw9CxRjZQj5PrgB5sLapwyEU5oAPgVPEypw2td2R5pFIRo6s
        lTEK4yUfaPXbblz9Sbi+41+nV80wSbcL7Ou8QIVPU5e6dpwD4Q==
X-Google-Smtp-Source: ABdhPJxNOdiHFNFi2SBTgDO9cbaeKvTB2Al5uJpnNNsuc5Da1tSvh4BtxRuOrUMOaZSEkY2XjzI+nlaFm9emkn2qbRQ=
X-Received: by 2002:a05:622a:1387:: with SMTP id o7mr29468276qtk.19.1629717593780;
 Mon, 23 Aug 2021 04:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
 <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com> <20210819100334.6af2d86e@xps13>
In-Reply-To: <20210819100334.6af2d86e@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Mon, 23 Aug 2021 13:19:43 +0200
Message-ID: <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> Hello,
>
> Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Thu, 19 Aug
> 2021 09:21:42 +0200:
>
> > Hi Miqu=C3=A8l
> >
> > Am Mo., 16. Aug. 2021 um 09:31 Uhr schrieb Miquel Raynal
> > <miquel.raynal@bootlin.com>:
> > >
> > > Hi Daniel,
> > >
> > > Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Sun, 8 Aug 202=
1
> > > 09:26:43 +0200:
> > >
> > > > Some devices use Micron NAND chips, which use on-die ECC. The hardc=
oded
> > > > setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable, because t=
he
> > > > software ECC on top of the hardware ECC produces errors for every r=
ead
> > > > and write access, not to mention that booting does not work, becaus=
e
> > > > the boot loader uses the correct ECC when trying to load the kernel
> > > > and stops loading on severe ECC errors.
> > > > This patch requires the devices that currently work with the hard c=
oded
> > > > setting to set the nand-ecc-mode property to soft in their device
> > > > tree.
> > > >
> > >
> > > Please add a Fixes: and Cc: stable tags, you will also need to send t=
o
> > > stable@vger.kernel.org a different version of the patch for the kerne=
l
> > > 5.4 IIUC.
> > >
> > > > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > > > Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl> # tested on BT Ho=
me Hub 5A
> > > > ---
> > > >  drivers/mtd/nand/raw/xway_nand.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/ra=
w/xway_nand.c
> > > > index 26751976e502..0a4b0aa7dd4c 100644
> > > > --- a/drivers/mtd/nand/raw/xway_nand.c
> > > > +++ b/drivers/mtd/nand/raw/xway_nand.c
> > > > @@ -148,8 +148,6 @@ static void xway_write_buf(struct nand_chip *ch=
ip, const u_char *buf, int len)
> > > >
> > > >  static int xway_attach_chip(struct nand_chip *chip)
> > > >  {
> > > > -     chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
> > > > -
> > > >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN)
> > > >               chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
> > >
> > > You also need to only set the Hamming algorithm when engine_type is
> > > TYPE_SOFT.
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > I am really struggling with what to do. For one of the affected
> > devices, they created two device
> > trees, one for Micron and one for all others. Which obviously had no
> > effect due to the
> > hardcoded settings, which led me to Patch 2 and I thought, so be it.
> > But the process to figure
> > out if ones device has Micron Chips is essentially flashing an image
> > and if it does not work,
> > use the stock OEM recovery and try the other image.
> > However, since Micron is the only chip that is treated differently, I w=
onder
> > if your first proposal, even though it is hacky, is the better
> > approach to solve the issue
> > for the Micron devices not booting and throwing ECC errors. What do you=
 think?
> > Follow up first patch or this one?
>
> I am not sure we understood each other, your patch is fine, but you
> need to do something like:
>
> static int xway_attach_chip(struct nand_chip *chip)
> {
>     if (chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT &&
>         chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN)
>          chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
>
> In the DT you should not force any ECC engine (drop the nand-ecc-xxx
> properties) and let the core handle it. It will probably choose the
> most suitable engines for you.
>
> Thanks,
> Miqu=C3=A8l

thank you for your response.
If I remove the nand-ecc-xxx properties in the device tree, the device with
the Toshiba NAND chip is working. However, the device with the Micron
NAND fails with NO ECC functions supplied; hardware ECC not possible,
seems to be at line 5367 or equivalent.
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_ba=
se.c#L5367

It looks like the micron nand driver supports on die only if its
specified int the
Device tree:
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_mi=
cron.c#L511
The Micron NAND driver probably needs to set the ECC type to ON DIE if the
variable ondie contains the supported attribute?!

Any ideas? Second patch?

Thanks, Daniel.
