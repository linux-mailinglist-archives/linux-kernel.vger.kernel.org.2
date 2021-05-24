Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFA38E5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhEXL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:57:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51119 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhEXL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:57:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 72DA85C00AD;
        Mon, 24 May 2021 07:55:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 May 2021 07:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TGf3/oCWT0pbsYlwL8Nuak/tyBp
        PVqs+w+S94yX8l3U=; b=HoiZ8vN0DGc4ijqIS2MUNWd1+UsVuqBfFyqQwUX+tqE
        5hOmyPMitLlqAAIXkLrvjqv057AsZ3I2Hfc4yS9ullOOGp6MGDKzC89aOtfOM1Uh
        4jSoIxTEg7MViR3vKUhIkqH5UxqBUhGgByQ8RbREBDew2zQDXWXV8A8emzeQiB/m
        Jny+PFiQLSNXshs6CR1//ockU87okw5CiNaFYaCw2iPZcV9lMncdtEAVdyYdPMM2
        EEJPlDnDDp3vJAHt0d3Su+9nZiKFrEeGXJeyp9Nt7GG4UQloMYYcL45P7rEX5Alc
        Y/CBsv+CZCJwaxXgR1/g1Nm87JGsQ+K5pHZATLYeoUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TGf3/o
        CWT0pbsYlwL8Nuak/tyBpPVqs+w+S94yX8l3U=; b=d+QLMsvG3nb1ALr4eZIRST
        Ilbc3eGwPDVeks4jAomm7geT1PbNh/BzQozCx9AZzXHquX2LdH9qSPKjJsBEckSB
        eCTna8r29a4VX6B9fs3R22ZRDQJD1EVU9BIhEPmAc8E5V651Poeas+q7u/DS5stB
        iwYVpHGxSrliUwd63S887uq3KoYqSzQjvwKjtuPdYeNqdHYars5zyAptg8Q5pgyo
        mMdnEzlvUtH1/+xy8NRDzB8UCJhatMlbyc5lhSqUQrUK3Edir6cU8+izxBgaz/t8
        WjfrjXXlgxlu3MOYBHkfv3l005d3Hq6oN1SmYSLAtiIaL6oWF8ie0jbtFZnKSceA
        ==
X-ME-Sender: <xms:OJSrYOTnpV82N_m8fyAhPhR811_ojgvoVTWGIXdU7JM2l_bSMEoDwA>
    <xme:OJSrYDywII7bHPQvyhsL8PZB3N_4kL9-bKBsXWC-_2hhF5ePOnTOF_PidK_SwMFJq
    x_JXwVjq_tW5QBZTFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvefftdfgteehkedukeejueffgfelkeeuhfeigffgtdeikeevieegjefggfff
    udeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpkhgrlhiiuhhmvghushdrtghomh
    dpuggvsghirghnrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:OJSrYL1J8ViyG4djkKHCSR0aMsItar_IEoDmHE_7kMvnqIApP0v7rw>
    <xmx:OJSrYKCfG8x3jV56wYFrCiym0OjFh9xQ2qd8RDKjExmGG1xdI2iGcw>
    <xmx:OJSrYHh78NxDNi30UmDttldtKF3CzA5em0SV28nCLgVDow01NFijVA>
    <xmx:OZSrYHjBRqUNM9e2ycU_QU7vAXwLTBFHQZ7jPj3fza38nBNWvz_LBA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 07:55:36 -0400 (EDT)
Date:   Mon, 24 May 2021 13:55:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Vagrant Cascadian <vagrant@reproducible-builds.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <20210524115534.rw25uc6ao6e4yjye@gilmour>
References: <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
 <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca>
 <20210518150652.zxj56bljjeq3ogln@gilmour>
 <YKQiws6yP35QIpJd@eldamar.lan>
 <YKQm/F+JIjf/YUHm@eldamar.lan>
 <87a6opqn59.fsf@ponder>
 <YKavWaIEH/SdzT4m@eldamar.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4pitqzhauihxftv5"
Content-Disposition: inline
In-Reply-To: <YKavWaIEH/SdzT4m@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4pitqzhauihxftv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 20, 2021 at 08:50:01PM +0200, Salvatore Bonaccorso wrote:
> Hi,
>=20
> On Thu, May 20, 2021 at 11:24:18AM -0700, Vagrant Cascadian wrote:
> > On 2021-05-18, Salvatore Bonaccorso wrote:
> > > On Tue, May 18, 2021 at 10:25:40PM +0200, Salvatore Bonaccorso wrote:
> > >> On Tue, May 18, 2021 at 05:06:52PM +0200, Maxime Ripard wrote:
> > >> > On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
> > >> > > On 2021-05-16, Salvatore Bonaccorso wrote:
> > >> > > > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej =C5=A0krabec =
wrote:
> > >> > > >> Let me first explain that it was oversight on my side not not=
icing initials in=20
> > >> > > >> your SoB tag. But since the issue was raised by Maxime, I did=
n't follow up.
> > >> > > >>=20
> > >> > > >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake nap=
isal(a):
> > >> > > >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > >> > > >> > > Unfortunately we can't take this patch as is, this needs =
to be your real
> > >> > > >> > > name, see:
> > >> > > >> > > https://www.kernel.org/doc/html/latest/process/submitting=
-patches.html#de
> > >> > > >> > > veloper-s-certificate-of-origin-1-1
> > >> > > >> > Dear Maxime,
> > >> > > >> >=20
> > >> > > >> > Thank you very much for considering my contribution and for=
 all your
> > >> > > >> > work on supporting sunxi-based hardware; I appreciate it.
> > >> > > >> >=20
> > >> > > >> > Thank you for referring me to the Developer's Certificate o=
f Origin, but
> > >> > > >> > I had already read it before submitting (I had to do so in =
order to know
> > >> > > >> > what I was saying by "Signed-off-by:") and I do certify wha=
t it says.
> > >> > > >> >=20
> > >> > > >> > Looking through recent entries in the commit log of the mai=
nline kernel,
> > >> > > >> > I see several patches from authors such as:
> > >> > > >> >=20
> > >> > > >> >   H.J. Lu <hjl.tools@gmail.com>
> > >> > > >> >   B K Karthik <karthik.bk2000@live.com>
> > >> > > >> >   JC Kuo <jckuo@nvidia.com>
> > >> > > >> >   EJ Hsu <ejh@nvidia.com>
> > >> > > >> >   LH Lin <lh.lin@mediatek.com>
> > >> > > >> >   KP Singh <kpsingh@kernel.org>
> > >> > > >> >   Karthik B S <karthik.b.s@intel.com>
> > >> > > >> >   Shreyas NC <shreyas.nc@intel.com>
> > >> > > >> >   Vandana BN <bnvandana@gmail.com>
> > >> > > >> >=20
> > >> > > >> > so I believe names of this form are in fact acceptable, eve=
n if the
> > >> > > >> > style might seem a little old-fashioned to some.
> > >> > > >>=20
> > >> > > >> Speaking generally, not only for this case, prior art argumen=
ts rarely hold,=20
> > >> > > >> because:
> > >> > > >> - it might be oversight,
> > >> > > >> - it might be a bad practice, which should not be followed in=
 new=20
> > >> > > >> contributions,
> > >> > > >> - different maintainers have different point of view on same =
thing,
> > >> > > >> - maintainer wants to adapt new practice or steer subsystem i=
n new direction
> > >> > > >>=20
> > >> > > >> >=20
> > >> > > >> > I would like to add that I have met many people with names =
such as C.J.,
> > >> > > >> > A A, TC, MG, etc. That is what everybody calls them and it =
would be
> > >> > > >> > natural for them to sign themselves that way. Some of them =
might want to
> > >> > > >> > contribute to Linux some day, and I think it would be a gre=
at shame and
> > >> > > >> > a loss to all of us if they were discouraged from doing so =
by reading
> > >> > > >> > our conversation in the archives and concluding that any co=
ntribution
> > >> > > >> > from them, however small, would be summarily refused simply=
 because of
> > >> > > >> > their name. Please could you ensure that does not happen?
> > >> > > >>=20
> > >> > > >> The link you posted says following:
> > >> > > >> "using your real name (sorry, no pseudonyms or anonymous cont=
ributions.)"
> > >> > > >>=20
> > >> > > >> I believe that real name means no initials, no matter what pe=
ople are=20
> > >> > > >> accustomed to. From my point of view, CJ is pseudonym derived=
 from real name.
> > >> > > >>=20
> > >> > > >> This is not the first time that fix of SoB tag was requested,=
 you can find such=20
> > >> > > >> requests in ML archives.
> > >> > >=20
> > >> > > I'm sure this isn't the first time this sort of thing has been b=
rought
> > >> > > up on this subject, but I feel obliged to mention:
> > >> > >=20
> > >> > >   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-be=
lieve-about-names/
> > >> > >=20
> > >> > > This seems to be blocked on culturally dependent perception of w=
hat
> > >> > > looks like a "real name" as opposed to any technical grounds.
> > >> > >=20
> > >> > > What is the goal of the "real name" in Signed-off-by actually tr=
ying to
> > >> > > achieve?
> > >> >=20
> > >> > https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#developer-s-certificate-of-origin-1-1
> > >> >=20
> > >> > I'm not the one making the rules, sorry
> > >>=20
> > >> Would it be technically possible to do the following: Based on the
> > >> downstream report we receved in Debian in
> > >> https://bugs.debian.org/988574 wrap up the same patch (I guess I will
> > >> need to use another commit message wording) and resubmit with my own
> > >> SoB with my downstream hat on and say a Tested-by from Vagrant? So we
> > >> are not blocked on the SoB issue from this original post of the chan=
ge
> > >> to apply to arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts ?
> > >
> > > Here is an attempt to do that and coming from
> > > https://bugs.debian.org/988574 for the change change submission.
> > >
> > > Regards,
> > > Salvatore
> > >
> > > From 93c335c997d6386fc5cb7b9c5621b9b9725de20e Mon Sep 17 00:00:00 2001
> > > From: Salvatore Bonaccorso <carnil@debian.org>
> > > Date: Tue, 18 May 2021 22:33:49 +0200
> > > Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy=
-mode
> > >
> > > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > > config") sets the RX/TX delay according to the phy-mode property in t=
he
> > > device tree. For the Orange Pi Plus board this is "rgmii", which is t=
he
> > > wrong setting.
> > >
> > > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananap=
ro:
> > > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which g=
ets
> > > the Ethernet working again on this board.
> > >
> > > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay con=
fig")
> > > Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> > > Link: https://bugs.debian.org/988574
> > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> >=20
> > Seems worth crediting the original reporter "B.R. Oake"
> > <broake@mailfence.com> with a Reported-by as well?
>=20
> Right, very good point, attached a revisited patch.
>=20
> Regards,
> Salvatore
>=20
> From 886f1e5cf477f5e2b5a88718b47d11a9d78325d2 Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Tue, 18 May 2021 22:33:49 +0200
> Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
>=20
> Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> config") sets the RX/TX delay according to the phy-mode property in the
> device tree. For the Orange Pi Plus board this is "rgmii", which is the
> wrong setting.
>=20
> Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> the Ethernet working again on this board.
>=20
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Reported-by: "B.R. Oake" <broake@mailfence.com>
> Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> Link: https://bugs.debian.org/988574
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>=20
> v2:
>  - Add a Reported-by for "B.R. Oake" <broake@mailfence.com>

It looks good to me, can  you resend it using git send-email?

Thanks!
Maxime

--4pitqzhauihxftv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuUNgAKCRDj7w1vZxhR
xYqsAP0bFsGi+O+ZmD/BOtJr2PC+1PSR7o5r/3r4WPlGo1X6lAD/Zs0RmEO4nGOL
zZpgh0/bn2G0eEzJBfaCuVrD/TGfEwg=
=yuhP
-----END PGP SIGNATURE-----

--4pitqzhauihxftv5--
