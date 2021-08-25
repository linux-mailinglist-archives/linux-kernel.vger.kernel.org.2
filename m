Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2672A3F7143
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhHYIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhHYIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:48:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:47:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a66so7466343qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=utvwaDtqiuzdYnqZLvGiSSQNitaqJgqrwf7/GnryxS8=;
        b=OBekRaKU3Bx1jjoWQpUl9EQYlFrgpb2pZGz9B7ndyce+B/FgUoU7XzebTTmSj5fU4i
         fReUfTnqhdquSAhAk7RGfXCT1hMtZZaW+7kGmR/yi4VjeOtblQvXJni7R4jaBjqImWAl
         xKp4TSNUeMVvTDyYGrno1xg8rqaGBEZ3vJhiQU8UcBgVDzw3sd5WZXLsTatsAgDdJiml
         KlO74SJpp2yUk/9ZaazfZsntE44tDVyMQBF6bjaXOOnf3XhPYrYF5UOpZ3Len1OoQaa4
         2jtlehK9Si3iAdSCexnh32MDUdbMo5mz5+xmmrZ8Ks2zPY/+rWdcJF7+SoneZ0lRjaVZ
         Tfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=utvwaDtqiuzdYnqZLvGiSSQNitaqJgqrwf7/GnryxS8=;
        b=n6iQ3v6gLFroQ5JQvo/vMUMIz0Rzz8i2W0GJ3cyY9fq/vDoaWo10mfOyWvhIuiBLzJ
         O7o0IMoPKZKgc5S0AJyhzrj/2uMYL60EX3BN4CZHMk76ngvaSe7hv1CqIEaJdp4IpzBA
         IHkSXjAHwYyc+etcUzdr9ShGHH7b1mwESHw8uGSRYiKh59kkJUN3fSP5Csa9Vaq9t6SS
         8TwqFvdn/rgg5cu4sTCjbjS/LIChjfU5D56w3SQ3/d8DAuI2VwJV/VfdjcOR2m5BXhUc
         DD/nQ2e+ueJdoX+CB00jQqQtqLPoEmfNYTrgx5OSxguq3/kCBLNGmUUZvxEhTeUfsNQl
         lkRw==
X-Gm-Message-State: AOAM530uTf7MivZlvdyxyO4S8s331goipjtFblicOt2is0TKzIbhXnVY
        1AWHoL+PXUCo/rfGwvsiBNYED1N2HEbj3sUpzwc=
X-Google-Smtp-Source: ABdhPJz6k8CyRZmfeTsBewdLSHdb+a5JQbfYt7URFG1PxLH912k2H6q+UNrRszg9yY00WRKSXACwhgn4UROAG5A2q/A=
X-Received: by 2002:a05:620a:318c:: with SMTP id bi12mr11285336qkb.263.1629881270979;
 Wed, 25 Aug 2021 01:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
 <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
 <20210819100334.6af2d86e@xps13> <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
 <20210823172413.0bc4ab3a@xps13> <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
 <20210824192203.076df55e@xps13>
In-Reply-To: <20210824192203.076df55e@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Wed, 25 Aug 2021 10:47:40 +0200
Message-ID: <CAE9cyGQ9_--=+MGc4_vTV1BkR6jv2RZcixyfLtCozXo349+6KA@mail.gmail.com>
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

Am Di., 24. Aug. 2021 um 19:22 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> Hello,
>
> Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Tue, 24 Aug
> 2021 09:15:49 +0200:
>
> > Hi Miqu=C3=A8l,
> >
> > Am Mo., 23. Aug. 2021 um 17:24 Uhr schrieb Miquel Raynal
> > <miquel.raynal@bootlin.com>:
> > >
> > > Hi Kestrel,
> > >
> > > Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Mon, 23 A=
ug
> > > 2021 13:19:43 +0200:
> > >
> > > > Hi Miqu=C3=A8l,
> > > >
> > > > Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
> > > > <miquel.raynal@bootlin.com>:
> > ...
> > > >
> > > > thank you for your response.
> > > > If I remove the nand-ecc-xxx properties in the device tree, the dev=
ice with
> > > > the Toshiba NAND chip is working. However, the device with the Micr=
on
> > > > NAND fails with NO ECC functions supplied; hardware ECC not possibl=
e,
> > > > seems to be at line 5367 or equivalent.
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw=
/nand_base.c#L5367
> > > >
> > > > It looks like the micron nand driver supports on die only if its
> > > > specified int the
> > > > Device tree:
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw=
/nand_micron.c#L511
> > > > The Micron NAND driver probably needs to set the ECC type to ON DIE=
 if the
> > > > variable ondie contains the supported attribute?!
> > >
> > > You're right but I don't see any easy upstream-able solution here.
> > > Changing the behavior in the Xway driver would certainly break users,
> > > changing the behavior in the Micron driver would certainly break even
> > > more users. The root cause being an absence of proper description (th=
e
> > > integration changed). Honestly I feel stuck, maybe you can try to
> > > register your device, if it fails, change the integration in the driv=
er
> > > (to an ondie ecc engine) then retry?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Do you think adding something like below at the following location
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/xwa=
y_nand.c#L223
> > would be upstreamable (with or without device tree property?)?
> >
> >         err =3D nand_scan(&data->chip, 1);
> >         if (err /* && of_property_read_bool(np, "lantiq,retry-on-die") =
*/) {
> >                 data->chip.ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_=
DIE;
> >                 err =3D nand_scan(&data->chip, 1);
> >                 if (err) return err;
> >         }
> >
> > It still throws the kernel warning on first try, but the second try the=
n works.
>
> Can you please remind me what is xway/lantiq/your setup/how public it
> is/who's using this driver?
>
> Thanks,
> Miqu=C3=A8l

Its for Openwrt, I would like to add support for 3 more devices
AVM fritzbox 3490/5490 and 7490. They all have varying NAND chips.
I have initially created a PR to have my initial patch tested:
https://github.com/openwrt/openwrt/pull/4426
There is already one device supported which has two DTBs one for
Micron and one for non Micron (3370), but its not very straight forward.
Without having this issue solved, flashing those devices would be
possibly having issues depending on NAND chip or the awkward
workaround of flashing one image and if it does not boot, boot the
other one. Without self soldered serial console, it would not very
easy to figure out the NAND manufacturer.
The AVM stock firmware is old kernel and does not use device
tree for NAND, they just query all possible manufacturers and set
up NAND based on manufacturer query.

Thanks, Daniel.
