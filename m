Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B53110E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhBERd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:33:29 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60415 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhBEP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:58:39 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1AC733C4CA8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:10:43 +0000 (UTC)
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6F07B40015;
        Fri,  5 Feb 2021 15:10:18 +0000 (UTC)
Date:   Fri, 5 Feb 2021 16:10:18 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: BOG: commit 89c7cb1608ac3 ("of/device: Update dma_range_map only
 when dev has valid dma-ranges") seems to break Pinephone display or LCDC
Message-ID: <YB1f2kYMtHnM5ye1@aptenodytes>
References: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
 <YBkh6IZfmzaLWYPp@aptenodytes>
 <E45AE13E-6A74-43E6-A7AE-B0D425B10344@goldelico.com>
 <YBlW3ES1E5SwUOpJ@aptenodytes>
 <13D0EFBB-E2A1-4BA3-9F99-CF2B85127074@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NhpUC++SYlbyNDNM"
Content-Disposition: inline
In-Reply-To: <13D0EFBB-E2A1-4BA3-9F99-CF2B85127074@goldelico.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NhpUC++SYlbyNDNM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue 02 Feb 21, 16:07, H. Nikolaus Schaller wrote:
> Hi Paul,
>=20
> > Am 02.02.2021 um 14:42 schrieb Paul Kocialkowski <paul.kocialkowski@boo=
tlin.com>:
> >=20
> > Hi Nikolaus,
> >=20
> > On Tue 02 Feb 21, 11:50, H. Nikolaus Schaller wrote:
> >> Hi Paul,
> >>=20
> >>> Am 02.02.2021 um 10:56 schrieb Paul Kocialkowski <paul.kocialkowski@b=
ootlin.com>:
> >>>=20
> >>> Hi Nikolaus,
> >>>=20
> >>> On Tue 02 Feb 21, 10:18, H. Nikolaus Schaller wrote:
> >>>> Hi,
> >>>> since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.
> >>>>=20
> >>>> I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
> >>>> the commit mentioned in the subject is the reason.
> >>>>=20
> >>>> Reverting it makes the display work again and re-reverting fail agai=
n.
> >>>>=20
> >>>> IMHO it seems as if the display DMA of the pinephone (allwinner suni=
-a54)
> >>>> got influenced and stopped to scan the framebuffer.
> >>>>=20
> >>>> The only dma-ranges I could find are defined here:
> >>>>=20
> >>>> 	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>=20
> >>>> 	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
> >>>>=20
> >>>> but I can't tell if they are "valid" or not.
> >>>>=20
> >>>> Any insights are welcome. And please direct to the right people/mail=
ing lists
> >>>> if they are missing.
> >>>=20
> >>> This may not be strictly the same thing, but is this patch in your tr=
ee:
> >>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/202101151=
75831.1184260-2-paul.kocialkowski@bootlin.com/
> >>>=20
> >>> If not, it's worth a try to add it.
> >>=20
> >> No, it hasn't arrived in v5.11-rc6 (or linux-next) yet.
> >>=20
> >> But it fixes the issue.
> >=20
> > Great! The patch should already be on its way to the next RC.
>=20
> Fine!
>=20
> >=20
> > And nice to see you're active on Pinephone as well!
>=20
> I have a developer unit and the LetuxOS kernel already supports it a litt=
le. This is why I observed the issue with -rc6
>=20
> > You might remember me from
> > the Replicant project, as I've worked a bit on the GTA04 :)
>=20
> Sure, you are well remembered :)
>=20
> I still have the dream to revitalize Replicant 4.2 for the GTA04 just for=
 fun. I can already boot to Replicant touch screen with a v5.4 kernel. v5.1=
0 fails when trying to spawn zygote...

Oh I see! I think Android has made some significant progress is its ability
to use mainline (4.2 was an early stage and I remember having to backport
patches to use some mainline features back then).

Maybe it would be easier with Replicant 6, but you'd have to go through the
device bringup phase again, which is never nice.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--NhpUC++SYlbyNDNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAdX9kACgkQ3cLmz3+f
v9GFMAgAnqzb02bU1xw4W/ZQTV4u/H+RjuIscu8QyAmTJQ4RJc7Nggl5VEJsPqed
PUpdFkySE74+mKOAVCbv72LNE75VowT40avbmDqqPY+IZ0ddohasFOTNawQ8dPFf
ZeS5kkRJj72AzdKuUIeboRXi2LjPmKgFDtAq7WSzjb8GG2sGSkjgpLNA5/c59l5O
s5LLkrWDC5VyR0NXViBMb8ICLPS3mM4MgoyYs5NMRWDkj8wXadaKebl0+/TBEqZz
m6fltCsuEpCGJmWMTvme1ixujhJQXqOlWr95OaJ4gNdF85kmRrT10P/zqJldOCGN
KJP9QtzHP08Xvd7rSwaTzX5XtP48Rw==
=ESK6
-----END PGP SIGNATURE-----

--NhpUC++SYlbyNDNM--
