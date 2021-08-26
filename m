Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B83F8207
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 07:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhHZF2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 01:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHZF2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 01:28:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FFEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 22:27:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so2136195qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 22:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z0kqO64XqRwJ93SOQZVMf7bi4x3MG0LrGr/el2bek3E=;
        b=XC08SiJFTXCsGo0l1acy5AJeO0kFfMLmkWq1hp54YHhwK0oZQx6jMxKcoqWrXq1R89
         HyrdfmEmyI6qXhalHGTFZlYQQZvlAI7BPuE/3T5Lx6vavU44MkybOyCY9kqbXoSB5kCg
         94uQ9j/DwbFXbaiwOQnrfp/gxizFR9OzHowe15c8tfdNG6So4n1FsT99NQopbmv5Q3Wl
         nLcprxghxROPyxM1A7eDZnTRo7n1BkD5nO5xcpukfWe6OV4GyC6qHq3NfgJWxciCcg8u
         8aisqEaMbE3eFVWofBivsKMIzMCV/peFmrinvrjrRkAcOtuzV0SZu22XtD+34DyTFJvz
         cJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z0kqO64XqRwJ93SOQZVMf7bi4x3MG0LrGr/el2bek3E=;
        b=GxM/QBiQBbbk1cgIpkpWTrnUWvm6Ie9FpJ75+fBDRTUMXaZkF/JpuYYZZEOgByOW2m
         mt7J6bFQcEhgetV3mHSE+w5t+gYPgCPm0WNOX84/tpGz+5ItRvSGX6Dx43DQFLmSOWYz
         8aOadQ4a8J3BwNE0bv7BN+qpg+SEj6XVSd+PRLNCa6WJDYletCAQVYuPhnWtOC6TYh5O
         yMOaJtsnUbyPunSj5s4tMtHYON73CCLIGpAnaXPEfTqF5Z4i4sBp36GjTW4dMjtDrjKL
         Y62sxGoOTmBUMEJri6rFgXehLdq9tNwZNyRIdi/c4x6Xj0vKGcdPuokZGiu0dw6sLCQR
         8cng==
X-Gm-Message-State: AOAM530Do+e70xEoz7AvSqN8PyQbItb2mF4v2yD/WQ4lY0fhX8Qwc7Ft
        hd5BWYZ/VsXoyoNeu4NRSTs/HPrJaRXF0tJvxlnSwh/E0Rw5vw==
X-Google-Smtp-Source: ABdhPJwdmCIXBfygIj0M2gb6CeRPApEGKRXmEUqDifAohMCQW5SnS2pnmtv61z93mUrpXa7eZuSrsHFy7LXljbE/aPo=
X-Received: by 2002:a05:620a:1655:: with SMTP id c21mr2099183qko.187.1629955664312;
 Wed, 25 Aug 2021 22:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
 <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
 <20210819100334.6af2d86e@xps13> <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
 <20210823172413.0bc4ab3a@xps13> <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
 <20210824192203.076df55e@xps13> <CAE9cyGQ9_--=+MGc4_vTV1BkR6jv2RZcixyfLtCozXo349+6KA@mail.gmail.com>
 <20210825105126.4c1c15cb@xps13> <CAE9cyGRuoaiTu40Yu0po3dykk1fTq_VkqwNfrQkJq8DR6FPRpw@mail.gmail.com>
 <20210825173114.04ae2b20@xps13>
In-Reply-To: <20210825173114.04ae2b20@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Thu, 26 Aug 2021 07:27:33 +0200
Message-ID: <CAE9cyGS8iYHqPYmG1nOFoJ=gi-PBtmz_Y37EZRU9jYJwjf-gvA@mail.gmail.com>
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

Am Mi., 25. Aug. 2021 um 17:31 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> > > > > > > > thank you for your response.
> > > > > > > > If I remove the nand-ecc-xxx properties in the device tree,=
 the device with
> > > > > > > > the Toshiba NAND chip is working. However, the device with =
the Micron
> > > > > > > > NAND fails with NO ECC functions supplied; hardware ECC not=
 possible,
> > > > > > > > seems to be at line 5367 or equivalent.
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/=
nand/raw/nand_base.c#L5367
> > > > > > > >
> > > > > > > > It looks like the micron nand driver supports on die only i=
f its
> > > > > > > > specified int the
> > > > > > > > Device tree:
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/=
nand/raw/nand_micron.c#L511
> > > > > > > > The Micron NAND driver probably needs to set the ECC type t=
o ON DIE if the
> > > > > > > > variable ondie contains the supported attribute?!
> > > > > > >
> > > > > > > You're right but I don't see any easy upstream-able solution =
here.
> > > > > > > Changing the behavior in the Xway driver would certainly brea=
k users,
> > > > > > > changing the behavior in the Micron driver would certainly br=
eak even
> > > > > > > more users. The root cause being an absence of proper descrip=
tion (the
> > > > > > > integration changed). Honestly I feel stuck, maybe you can tr=
y to
> > > > > > > register your device, if it fails, change the integration in =
the driver
> > > > > > > (to an ondie ecc engine) then retry?
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Miqu=C3=A8l
> > > > > >
> > > > > > Do you think adding something like below at the following locat=
ion
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand=
/raw/xway_nand.c#L223
> > > > > > would be upstreamable (with or without device tree property?)?
> > > > > >
> > > > > >         err =3D nand_scan(&data->chip, 1);
> > > > > >         if (err /* && of_property_read_bool(np, "lantiq,retry-o=
n-die") */) {
> > > > > >                 data->chip.ecc.engine_type =3D NAND_ECC_ENGINE_=
TYPE_ON_DIE;
> > > > > >                 err =3D nand_scan(&data->chip, 1);
> > > > > >                 if (err) return err;
> > > > > >         }
> > > > > >
> > > > > > It still throws the kernel warning on first try, but the second=
 try then works.
> > > > >
> > > > > Can you please remind me what is xway/lantiq/your setup/how publi=
c it
> > > > > is/who's using this driver?
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l
> > > >
> > > > Its for Openwrt, I would like to add support for 3 more devices
> > > > AVM fritzbox 3490/5490 and 7490. They all have varying NAND chips.
> > > > I have initially created a PR to have my initial patch tested:
> > > > https://github.com/openwrt/openwrt/pull/4426
> > > > There is already one device supported which has two DTBs one for
> > > > Micron and one for non Micron (3370), but its not very straight for=
ward.
> > > > Without having this issue solved, flashing those devices would be
> > > > possibly having issues depending on NAND chip or the awkward
> > > > workaround of flashing one image and if it does not boot, boot the
> > > > other one. Without self soldered serial console, it would not very
> > > > easy to figure out the NAND manufacturer.
> > > > The AVM stock firmware is old kernel and does not use device
> > > > tree for NAND, they just query all possible manufacturers and set
> > > > up NAND based on manufacturer query.
> > >
> > > But in this case can't you check the 'root' compatible against certai=
n
> > > values and and some kind of quirk in the ->attach() hook to update th=
e
> > > ECC engine to the right one?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > maybe I wrote the wrong thing, but what do you mean with root compatibl=
e.
> > The controller is always NAND xway and I think there are 4 different
> > NAND chip types. But the stock firmware just queries the NAND
> > manufacturer name, not a date or type/model of the devices. E.g. 7490 c=
an
> > have Micron or Macronix NAND, but querying the Micron id or Macronix
> > id requires a change to the xway driver?
> > Do you mean something like in the first patch do query the manufacturer
> > but just for all the 4?
> >
> > Thanks, Daniel.
>
> You were talking about new boards, if, on each of these boards, you
> know what is the NAND chip, you could retrieve the root compatible (by
> root I mean the one at the root of the tree / { } in the DT) and
> depending on it change the ECC engine that must be used from the driver
> itself.
>
>
> Thanks,
> Miqu=C3=A8l

The boards are not supported yet in OpenWrt and there is the
existing fritzbox 3370. Fritzbox 7490 first manufacture date was 2013.
As I stated the 7490 can have either Micron or Macronix NAND with
no indicator. I was just hoping there is a dynamic way to support
both NAND chips without having to build two different images with two
different DTBs. For this case, DTB is too static.

Thanks, Daniel.
