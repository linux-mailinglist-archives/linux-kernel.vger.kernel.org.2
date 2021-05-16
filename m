Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1417B3820E2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhEPUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhEPUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:25:15 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 May 2021 13:24:00 PDT
Received: from cascadia.aikidev.net (cascadia.aikidev.net [IPv6:2600:3c01:e000:267:0:a171:de7:c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61CF0C061573;
        Sun, 16 May 2021 13:24:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:21:21:0:100b])
        (Authenticated sender: vagrant@aikidev.net)
        by cascadia.aikidev.net (Postfix) with ESMTPSA id C567D1A904;
        Sun, 16 May 2021 13:18:48 -0700 (PDT)
From:   Vagrant Cascadian <vagrant@reproducible-builds.org>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Jernej =?utf-8?Q?=C5=A0krabe?= =?utf-8?Q?c?= 
        <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
In-Reply-To: <YKFPGC2qBMipQPbd@eldamar.lan>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop> <YKFPGC2qBMipQPbd@eldamar.lan>
Date:   Sun, 16 May 2021 13:18:44 -0700
Message-ID: <87o8dawhy3.fsf@yucca>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2021-05-16, Salvatore Bonaccorso wrote:
> On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej =C5=A0krabec wrote:
>> Let me first explain that it was oversight on my side not noticing initi=
als in=20
>> your SoB tag. But since the issue was raised by Maxime, I didn't follow =
up.
>>=20
>> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
>> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
>> > > Unfortunately we can't take this patch as is, this needs to be your =
real
>> > > name, see:
>> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml#de
>> > > veloper-s-certificate-of-origin-1-1
>> > Dear Maxime,
>> >=20
>> > Thank you very much for considering my contribution and for all your
>> > work on supporting sunxi-based hardware; I appreciate it.
>> >=20
>> > Thank you for referring me to the Developer's Certificate of Origin, b=
ut
>> > I had already read it before submitting (I had to do so in order to kn=
ow
>> > what I was saying by "Signed-off-by:") and I do certify what it says.
>> >=20
>> > Looking through recent entries in the commit log of the mainline kerne=
l,
>> > I see several patches from authors such as:
>> >=20
>> >   H.J. Lu <hjl.tools@gmail.com>
>> >   B K Karthik <karthik.bk2000@live.com>
>> >   JC Kuo <jckuo@nvidia.com>
>> >   EJ Hsu <ejh@nvidia.com>
>> >   LH Lin <lh.lin@mediatek.com>
>> >   KP Singh <kpsingh@kernel.org>
>> >   Karthik B S <karthik.b.s@intel.com>
>> >   Shreyas NC <shreyas.nc@intel.com>
>> >   Vandana BN <bnvandana@gmail.com>
>> >=20
>> > so I believe names of this form are in fact acceptable, even if the
>> > style might seem a little old-fashioned to some.
>>=20
>> Speaking generally, not only for this case, prior art arguments rarely h=
old,=20
>> because:
>> - it might be oversight,
>> - it might be a bad practice, which should not be followed in new=20
>> contributions,
>> - different maintainers have different point of view on same thing,
>> - maintainer wants to adapt new practice or steer subsystem in new direc=
tion
>>=20
>> >=20
>> > I would like to add that I have met many people with names such as C.J=
.,
>> > A A, TC, MG, etc. That is what everybody calls them and it would be
>> > natural for them to sign themselves that way. Some of them might want =
to
>> > contribute to Linux some day, and I think it would be a great shame and
>> > a loss to all of us if they were discouraged from doing so by reading
>> > our conversation in the archives and concluding that any contribution
>> > from them, however small, would be summarily refused simply because of
>> > their name. Please could you ensure that does not happen?
>>=20
>> The link you posted says following:
>> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
>>=20
>> I believe that real name means no initials, no matter what people are=20
>> accustomed to. From my point of view, CJ is pseudonym derived from real =
name.
>>=20
>> This is not the first time that fix of SoB tag was requested, you can fi=
nd such=20
>> requests in ML archives.

I'm sure this isn't the first time this sort of thing has been brought
up on this subject, but I feel obliged to mention:

  https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about=
-names/

This seems to be blocked on culturally dependent perception of what
looks like a "real name" as opposed to any technical grounds.

What is the goal of the "real name" in Signed-off-by actually trying to
achieve?


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCYKF+JQAKCRDcUY/If5cW
qsokAP9nYxJeAbCY5XVe6Mq51MJdRig2BlF4b3b5KwBHW0fy7QD/ddOU4rtOhc6s
fmXJjZNIdsqtIoXZwCygfIhnMmWoAg8=
=o8xs
-----END PGP SIGNATURE-----
--=-=-=--
