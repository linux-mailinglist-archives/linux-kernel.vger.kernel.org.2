Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349993F76E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhHYOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:08:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B81C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:07:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c10so24645663qko.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQMLTVikzSuk1GWqoYKb9CQEhIEBrcrpp56ck4PkS3c=;
        b=ZA4HCaRMncysEcfJQD3bXKZ54crDRH4ogCec2N2BXl0QFL7VmEDnTUl6m+bx7zthnZ
         vSdeJrElfQtt4X0U/fzV1c9/3yh6DP/J1UCwSQ2iPLLOkLMle8ARpn0TSXhUqJVeT6S3
         mzNukF8bbANu4k1QD98P9+MppKEArtsXMzqiGi9UsR4Mpy/2mfRCeTkFyz3eoyPPOk0l
         WzofgZ+47mUeqVrzh/RB8xmCJAJd8xGL+/76F1Cgslc80NE7FkyF3wycO3wXKkXcrxY5
         5LVRCzQCGKQ37fAyrqBkU77HFgJSK5f1GtUMTLk1Y6bnjzLOA7V30ry39mrcOE2mEIq2
         iQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQMLTVikzSuk1GWqoYKb9CQEhIEBrcrpp56ck4PkS3c=;
        b=JVzvnDUxA6dEoJPoQbgHo8sLHHKiMHfsbVTnaoXUJgPd/h7bSMkJNtqtpIBlysVbrW
         Vh9PZJcZh5gob34cLc7wJ0p39emKRdje1zd9cKABmLqpYbDvyuVZbCcUbidzuD7NJZlA
         wjfuxeK2P8QmRe4fcXHyJf4GmfUYCef+IaepckMO3a8+KXcP0g6ZZqAqueAlb0szFMFi
         gUO5koHrttcxMce8aRaVWmuQXOE7m0qWxlYUjxRyUtS3NqGkTo/8xu7cMTWB4wyo3mSa
         LxWNpBS1/7AQlfNXMNN7TTP4sSBbJC5lP4U8vIg/EoZvsQp06FQKMOP78vGsyq6bIR2x
         DWTA==
X-Gm-Message-State: AOAM531o6PCvyduLOsvxU4fafVF1hpl8FpaVk9qOSbU08JCFQS23FPOc
        kHShi1HSf31qZjNyBOdXaiuVxWZLpeWckqTCts0=
X-Google-Smtp-Source: ABdhPJwaN2pLLTePCmVXfcyEDS+qal4eL3U42VcQIOeYiM+/+mb5AJ60+dQGirb8+woEc0eiFM8C1abBMQla2WrtFb0=
X-Received: by 2002:ae9:e915:: with SMTP id x21mr31917263qkf.183.1629900436612;
 Wed, 25 Aug 2021 07:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
 <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
 <20210819100334.6af2d86e@xps13> <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
 <20210823172413.0bc4ab3a@xps13> <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
 <20210824192203.076df55e@xps13> <CAE9cyGQ9_--=+MGc4_vTV1BkR6jv2RZcixyfLtCozXo349+6KA@mail.gmail.com>
 <20210825105126.4c1c15cb@xps13>
In-Reply-To: <20210825105126.4c1c15cb@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Wed, 25 Aug 2021 16:07:05 +0200
Message-ID: <CAE9cyGRuoaiTu40Yu0po3dykk1fTq_VkqwNfrQkJq8DR6FPRpw@mail.gmail.com>
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

Am Mi., 25. Aug. 2021 um 10:51 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
>
> Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Wed, 25 Aug
> 2021 10:47:40 +0200:
>
> > Hi Miqu=C3=A8l,
> >
> > Am Di., 24. Aug. 2021 um 19:22 Uhr schrieb Miquel Raynal
> > <miquel.raynal@bootlin.com>:
> > >
> > > Hello,
> > >
> > > Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Tue, 24 A=
ug
> > > 2021 09:15:49 +0200:
> > >
> > > > Hi Miqu=C3=A8l,
> > > >
> > > > Am Mo., 23. Aug. 2021 um 17:24 Uhr schrieb Miquel Raynal
> > > > <miquel.raynal@bootlin.com>:
> > > > >
> > > > > Hi Kestrel,
> > > > >
> > > > > Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Mon, =
23 Aug
> > > > > 2021 13:19:43 +0200:
> > > > >
> > > > > > Hi Miqu=C3=A8l,
> > > > > >
> > > > > > Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
> > > > > > <miquel.raynal@bootlin.com>:
> > > > ...
> > > > > >
> > > > > > thank you for your response.
> > > > > > If I remove the nand-ecc-xxx properties in the device tree, the=
 device with
> > > > > > the Toshiba NAND chip is working. However, the device with the =
Micron
> > > > > > NAND fails with NO ECC functions supplied; hardware ECC not pos=
sible,
> > > > > > seems to be at line 5367 or equivalent.
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand=
/raw/nand_base.c#L5367
> > > > > >
> > > > > > It looks like the micron nand driver supports on die only if it=
s
> > > > > > specified int the
> > > > > > Device tree:
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand=
/raw/nand_micron.c#L511
> > > > > > The Micron NAND driver probably needs to set the ECC type to ON=
 DIE if the
> > > > > > variable ondie contains the supported attribute?!
> > > > >
> > > > > You're right but I don't see any easy upstream-able solution here=
.
> > > > > Changing the behavior in the Xway driver would certainly break us=
ers,
> > > > > changing the behavior in the Micron driver would certainly break =
even
> > > > > more users. The root cause being an absence of proper description=
 (the
> > > > > integration changed). Honestly I feel stuck, maybe you can try to
> > > > > register your device, if it fails, change the integration in the =
driver
> > > > > (to an ondie ecc engine) then retry?
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l
> > > >
> > > > Do you think adding something like below at the following location
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw=
/xway_nand.c#L223
> > > > would be upstreamable (with or without device tree property?)?
> > > >
> > > >         err =3D nand_scan(&data->chip, 1);
> > > >         if (err /* && of_property_read_bool(np, "lantiq,retry-on-di=
e") */) {
> > > >                 data->chip.ecc.engine_type =3D NAND_ECC_ENGINE_TYPE=
_ON_DIE;
> > > >                 err =3D nand_scan(&data->chip, 1);
> > > >                 if (err) return err;
> > > >         }
> > > >
> > > > It still throws the kernel warning on first try, but the second try=
 then works.
> > >
> > > Can you please remind me what is xway/lantiq/your setup/how public it
> > > is/who's using this driver?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Its for Openwrt, I would like to add support for 3 more devices
> > AVM fritzbox 3490/5490 and 7490. They all have varying NAND chips.
> > I have initially created a PR to have my initial patch tested:
> > https://github.com/openwrt/openwrt/pull/4426
> > There is already one device supported which has two DTBs one for
> > Micron and one for non Micron (3370), but its not very straight forward=
.
> > Without having this issue solved, flashing those devices would be
> > possibly having issues depending on NAND chip or the awkward
> > workaround of flashing one image and if it does not boot, boot the
> > other one. Without self soldered serial console, it would not very
> > easy to figure out the NAND manufacturer.
> > The AVM stock firmware is old kernel and does not use device
> > tree for NAND, they just query all possible manufacturers and set
> > up NAND based on manufacturer query.
>
> But in this case can't you check the 'root' compatible against certain
> values and and some kind of quirk in the ->attach() hook to update the
> ECC engine to the right one?
>
> Thanks,
> Miqu=C3=A8l

maybe I wrote the wrong thing, but what do you mean with root compatible.
The controller is always NAND xway and I think there are 4 different
NAND chip types. But the stock firmware just queries the NAND
manufacturer name, not a date or type/model of the devices. E.g. 7490 can
have Micron or Macronix NAND, but querying the Micron id or Macronix
id requires a change to the xway driver?
Do you mean something like in the first patch do query the manufacturer
but just for all the 4?

Thanks, Daniel.
