Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9F3BE785
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGGMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:01:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D993C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:58:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w1so316566ilg.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gz2SvUlCs2AXE2RQDr8qkXptmWjvi19lXYHyzodzOTc=;
        b=G1HxIi6tdpX67gmIqCI9QUKycAiMTOuhvEOSMdSAdZnfZQEZ4Wh5JWI6SZyzdeTRAO
         DGH/9RshAxFKGTTm882PV+U+Vo70BsEqmlV6RhPDmL0gWyBAOEgXuPMfjZ6ArDPPpSEj
         PwFFqxubu4ldPuIIbsf+HRcwbQKGOIUKQlMw8NgR2dhItxYV6i1LBOyzfvv+sp8vtxxz
         wgdrdVy55hi2uwYyezfir4BVnCTY57gsggzbxGvvoig48uJ68mflZdqw5f+FZXUPnRmm
         dMkkGSKNqGfAyqLmZZdKQm8gm34qkUO12i4l2GuoYh5a0PTK+4WcuZQQDWbx+IYVzwEC
         nCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gz2SvUlCs2AXE2RQDr8qkXptmWjvi19lXYHyzodzOTc=;
        b=U0PUCrhqKDPevejse2zSiQ9QvfHJVrFa2FFYnq3/VunAZA5YztLI46IpGZc1rsvwhY
         PlCkXimBOMQOmL8ktFAXGa4BsXayjVLRZrfRm0er3H4ebCDi2NvyajtWePD0p6uhYXgz
         TM8D5VVRq+dbYumJ5N/1Hy2MaGgQqjFXjFDTKpLcvaYiTrfp+MrSX6bKKYJX8cALJCCc
         810V7N1DYWUfp4Qv2IQzrJhMcA864iDYG3TIfQFtC8OgFYnN6fv6wumnhp5WNTYrQ+L+
         akVCx151Ep6L6ej1hK1Z/6oxCwnv9Due7lu309u5HWp+PvxFWFx1LdtHsKo4CH4oQCmB
         0z7A==
X-Gm-Message-State: AOAM532RjMsWkpcd6C1wdBghz3x1R2TWvRXpTuAPclog4tcy0o58KP35
        39CyUxprvsVoY7RSX28C31ehLXrbK1QZukcM0fI=
X-Google-Smtp-Source: ABdhPJy7CJ8rw6SS4Lx4DcNFplYdKa9xI3gp69S2JE4ODF5WW8bsIFThi1PSjURjQX+1nsW6m/nHnH+tfFsaM4qBABI=
X-Received: by 2002:a92:ce12:: with SMTP id b18mr17622075ilo.96.1625659112717;
 Wed, 07 Jul 2021 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210707101628.GA27472@pn10-Veriton-X4610> <35c2e5faa770e228bd16a2186c8caf78@walle.cc>
In-Reply-To: <35c2e5faa770e228bd16a2186c8caf78@walle.cc>
From:   MODEL WORK LST <lstfazz@gmail.com>
Date:   Wed, 7 Jul 2021 19:58:22 +0800
Message-ID: <CALEtjnoT1BP5OHmf3xGBGV4o-Xc-vfGR8eLzdM5-Udc_ujxokA@mail.gmail.com>
Subject: Re: [PATCH] mtd:spi-nor:Update Winbond SPI NOR Flash device ID
To:     Michael Walle <michael@walle.cc>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shame on me, I don't use the plain text to reply.
Please allow me send again.

Dear Michael sir:

Many thanks for your prompt response.
It is my first time update patch for Linux, please advise me if I do wrong.
We are testing these device by the NXP evaluation board.
But the running Linux revision for that board is still 4.x. To update
the latest ID,
should we prepare the system that can work with latest Linux revision?
For the test process, I was wondering to ask mount the device to UBIFS
is a good way for test?

For the ID, this time we add new ID that is not include in the flash_info[]=
.
And we would keep our device who share the same ID have compatible
with each other.
Make sure the FW or SW only need to maintain an unique for each density.
If the same density device have different behavior, Winbond would apply new=
 ID.
Or have application note for customer to aware the difference.

For the SFDP, I would check how to work and fill the information.

Thanks again for your reply and information share.

Sincerely

Steam Lin


Michael Walle <michael@walle.cc> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> Am 2021-07-07 12:16, schrieb Steam Lin:
> > This patch is to update Winbond SPI NOR device
> > ID information.
> > Add new 3.3V and 1.8V device in the ID table.
> >
> > Signed-off-by: Steam Lin <Stlin2@winbond.com>
> > ---
> >  drivers/mtd/spi-nor/winbond.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/winbond.c
> > b/drivers/mtd/spi-nor/winbond.c
> > index 9a81c67a60c6..01aa49954793 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -102,6 +102,20 @@ static const struct flash_info winbond_parts[] =3D=
 {
> >                           SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_RE=
AD) },
> >       { "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
> >                            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25h512jvm", INFO(0xef9020, 0, 64 * 1024, 1024,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25q02jvq", INFO(0xef4022, 0, 64 * 1024, 4096,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25h01jvm", INFO(0xef9021, 0, 64 * 1024, 2048,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25h02jvm", INFO(0xef9022, 0, 64 * 1024, 4096,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> > +     { "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024,
> > +                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD) },
> >  };
>
> Nice to see patches from the vendor! Did you test these devices? We
> only accept new IDs which are actually tested. And are you aware of any
> ID collisions of these chips? Eg. sometimes the JWM reused the ID of the
> FW variant. How can we distinguish these?
>
> Also, you will have to supply SFDP data for all these chips, please have
> a look at [1] how to do that.
>
> [1]
> https://lore.kernel.org/linux-mtd/7038f037de3e224016d269324517400d@walle.=
cc/
>
>
> -michael
