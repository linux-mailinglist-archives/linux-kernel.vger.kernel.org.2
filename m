Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8AC3E3935
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhHHGqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 02:46:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D04C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 23:45:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 3so7370925qvd.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tTr7bym8tUrpPCFwduAaM979B5G/RgeBTkS/tlZUYrQ=;
        b=UyNkXQUQbMTasRGQCxSCdaQh7zIytVMM5l4RO4u+6fP9K3A+Y3s1FY0aOPhr/Xk0HL
         6jmkiOnSO8LreNFeRfuh17Xc8sgotFMS+Nn18K6iQHZacWNrTv+87nhNxujTgW78rTbI
         QWMa4qr6AN3StATPs1BW/ocjbMiddPFnAUAnHJISuFWlRbAt+ANft8fRHkRtM8619XE5
         copfnMRlG86eFUTryLnLP/xf4aRVqz+feJ7Tfe5AdiKGD5z96TXgSl/AAgZybcXrKSTM
         O9t+6a0G3QgoK2n3TtlwQYEanWHOIolZMPgcKTm1FH06kq1aAnGJiXalZfC7829P2GLK
         Kx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tTr7bym8tUrpPCFwduAaM979B5G/RgeBTkS/tlZUYrQ=;
        b=Npb8UstECnXGXIBrI2aEX0goOiFne63re3frjSMQAQg2UfVbOYNA7BkobVeR868WvY
         svEkSrwDpsDajU7R1xqSBldBdJQ7albjK3LJ8XDTn2ROxvbXz1gvEn06ccZ4jg2875Mh
         M05CraZA3Pk3XqWq+yZrMaBqDr+pGF2L9ShLAE90/XFlG6WnSFUCg7nir1qW14PsthTK
         c066ACCeZOihnC3oiwlsHajgmr8S8hbHC0nbfAxDGd4SME1hfdFqV0lCZXap0MDdEhuM
         hfaabN1bdmS2eNT/fGWSMno/83pKxjeg7nTX5ERQgisxhH+ILvHG1F6/aTP79MhrG8XS
         qOUg==
X-Gm-Message-State: AOAM531geskDhT1u1xJW4oOFzSy65tyBTP0lJwL6lVj6Van/8T0EwPpx
        g3mZ0eXIwiE+4htUD5hEIHCnuInhqI0Ttpsq6Z8FDTEY/pc=
X-Google-Smtp-Source: ABdhPJzgC9AzpSlrwHQDqaq4seYKiFp5V+Jcw4MbumfjR9I99XshG67RT3pWb1yXTNysO9sh9MQbwc9ZgqBQvGDBouw=
X-Received: by 2002:ad4:44aa:: with SMTP id n10mr18513329qvt.18.1628405149339;
 Sat, 07 Aug 2021 23:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210803143256.GA5209@ubuntu> <20210806185658.5b4772a7@xps13>
In-Reply-To: <20210806185658.5b4772a7@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Sun, 8 Aug 2021 08:45:38 +0200
Message-ID: <CAE9cyGQwQKp83y0cBoH1akRyHo9ipgBHaeWMjtCLVP77vRir=g@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: xway: No hardcoded ECC engine for Micron Chips
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Kestrel <kestrelseventyfour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 6. Aug. 2021 um 18:57 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> Hi Daniel,
>
> Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Tue, 3 Aug 2021
> 16:32:56 +0200:
>
> > Some lantiq xway devices use Micron NAND chips, which use on-die ECC.
> > The hardcoded setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable,
> > because the software ECC on top of the hardware ECC produces errors for
> > every read and write access, not to mention that booting does not work,
> > because the boot loader uses the correct ECC when trying to load the
> > kernel and stops loading on severe ECC errors.
> > Removing the hardcoded settings would break a number of devices that
> > work with those settings.
> > Adding a DTB property was considered, but did not work, because devices
> > of the same type but from different manufacture dates have different
> > NAND chips and as such it is not possible to determine the NAND chip
> > in advance or device specific.
>
> I understand the problem and it is a very crappy situation.
>
> >
> > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/xway_nand.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xw=
ay_nand.c
> > index 26751976e502..20cb5ce2f3b0 100644
> > --- a/drivers/mtd/nand/raw/xway_nand.c
> > +++ b/drivers/mtd/nand/raw/xway_nand.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/of_platform.h>
> >
> >  #include <lantiq_soc.h>
> > +#include "internals.h"
> >
> >  /* nand registers */
> >  #define EBU_ADDSEL1          0x24
> > @@ -148,7 +149,8 @@ static void xway_write_buf(struct nand_chip *chip, =
const u_char *buf, int len)
> >
> >  static int xway_attach_chip(struct nand_chip *chip)
> >  {
> > -     chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
> > +     if (chip->manufacturer.desc->id !=3D NAND_MFR_MICRON)
> > +             chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
>
> Could we make this a little bit clever with something like this:
> https://elixir.bootlin.com/linux/v5.13-rc7/source/drivers/mtd/nand/raw/na=
nd_micron.c#L434
>
> This is far from ideal, there should definitely be a change in the DT.
> But given your initial comments I guess it is not possible.
>
> Anyway I don't find a better way as, during the attach() call, we don't
> yet ran the manufacturer code, hence we don't know if on-die ECC is
> actually available or not.
>
> Thanks,
> Miqu=C3=A8l

Hi Miqu=C3=A8l,

I have worked with an other owner of lantiq hardware and he has successfull=
y
tested adding nand-ecc-mode =3D "soft" in the device tree and removing the =
one
line of code that sets the engine type to soft.
I will send another patch version that just removes this line of code.
This change
is required for kernel 5.4 as well, but the setting is in the xway_nand_pro=
be
method at line 237.

Thanks, Daniel.
