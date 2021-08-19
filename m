Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93503F144B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhHSHWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhHSHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:22:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:21:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id az7so6146841qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ngHcFDqQ1j+n3F31ocLMtlBEmQPg6UzMIi3K1sWBYPM=;
        b=Hxz3wXp4xkukyYcRN75ic33Wy9j/OeoWUyhYHcD8T8PrjwTQYhZSUffjx4b5UScAbj
         45blejav29JbC8dMiLpw31qu5nC3Bcrv2JdWaswgL04BS2bWlzrnNIfCnNYhvk0HRgKc
         Y+855ca8divtpuXN03KT98GvduX9L3yKeCoOZKAoh/m9UV+b1HFayFa2OlP5NUKxdh6y
         PGXRVHYOi17DYsz5UhUALl9sg+uu2/qRpLKrCqN5vgLZBtvOoG51hXCHxg1LLrJe62Dd
         pgSVYIsdNg7/drjVWpOkFsBF39Yug7YoovhgotiHU3mv5zUPuFBOUTdUqJlMgoRbTi19
         rVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ngHcFDqQ1j+n3F31ocLMtlBEmQPg6UzMIi3K1sWBYPM=;
        b=eymMgfqhxkuO8mvFd6zxHcw2d9MLnw3Zdh1w+4Le0wUe53Ni/8PWlq7JG7o38Jqp2X
         urIzraAy35vIqdL+OWYA9IWWHPQWmb//LAGdrbw/OGaBrznz7b5of9jxEk43ifSbyAEE
         c1a6eH9Q3/DJkyUJX0ig5PST7Vq8r07jm6Rh/08rSEbpGr2ImswnQ1mfvpkdn7i8/meM
         Hs1E/vhT5Wo+J6/gQ1GmsshsYJOe0qKVMTZR5oOk/klnOw1RrcgV5aHk1UtdpROQsxbu
         b/Imoi6L/PhImINh72TOH+tWRczYP8C2m/c8+778OIpZCas9uUTrwiJiuAfORdQEcK2P
         g3fQ==
X-Gm-Message-State: AOAM530IRuP1Pqb6Ss6qGlMNJRUMRlxVGMuKrGPZJ4eoZd6BU8QHSZF/
        iQQnJl6g7Edhp3/k3qJpyO5ZoNXnMEzBEqb2Awk=
X-Google-Smtp-Source: ABdhPJx0+Gd0tKYQIWj8E5Nl4J1+5LzmOfbJHPwLl1ec1YRNUfof+WFfR6rQwvwAaKe/78NTgvz7TreEfWm4Ssl0MxY=
X-Received: by 2002:a05:620a:2205:: with SMTP id m5mr2410153qkh.126.1629357713544;
 Thu, 19 Aug 2021 00:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
In-Reply-To: <20210816093126.442f74a1@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Thu, 19 Aug 2021 09:21:42 +0200
Message-ID: <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
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

Hi Miqu=C3=A8l

Am Mo., 16. Aug. 2021 um 09:31 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> Hi Daniel,
>
> Daniel Kestrel <kestrelseventyfour@gmail.com> wrote on Sun, 8 Aug 2021
> 09:26:43 +0200:
>
> > Some devices use Micron NAND chips, which use on-die ECC. The hardcoded
> > setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable, because the
> > software ECC on top of the hardware ECC produces errors for every read
> > and write access, not to mention that booting does not work, because
> > the boot loader uses the correct ECC when trying to load the kernel
> > and stops loading on severe ECC errors.
> > This patch requires the devices that currently work with the hard coded
> > setting to set the nand-ecc-mode property to soft in their device
> > tree.
> >
>
> Please add a Fixes: and Cc: stable tags, you will also need to send to
> stable@vger.kernel.org a different version of the patch for the kernel
> 5.4 IIUC.
>
> > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl> # tested on BT Home H=
ub 5A
> > ---
> >  drivers/mtd/nand/raw/xway_nand.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xw=
ay_nand.c
> > index 26751976e502..0a4b0aa7dd4c 100644
> > --- a/drivers/mtd/nand/raw/xway_nand.c
> > +++ b/drivers/mtd/nand/raw/xway_nand.c
> > @@ -148,8 +148,6 @@ static void xway_write_buf(struct nand_chip *chip, =
const u_char *buf, int len)
> >
> >  static int xway_attach_chip(struct nand_chip *chip)
> >  {
> > -     chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
> > -
> >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN)
> >               chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
>
> You also need to only set the Hamming algorithm when engine_type is
> TYPE_SOFT.
>
> Thanks,
> Miqu=C3=A8l

I am really struggling with what to do. For one of the affected
devices, they created two device
trees, one for Micron and one for all others. Which obviously had no
effect due to the
hardcoded settings, which led me to Patch 2 and I thought, so be it.
But the process to figure
out if ones device has Micron Chips is essentially flashing an image
and if it does not work,
use the stock OEM recovery and try the other image.
However, since Micron is the only chip that is treated differently, I wonde=
r
if your first proposal, even though it is hacky, is the better
approach to solve the issue
for the Micron devices not booting and throwing ECC errors. What do you thi=
nk?
Follow up first patch or this one?

Thanks, Daniel.
