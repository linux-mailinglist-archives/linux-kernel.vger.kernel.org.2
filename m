Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED2387BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbhERPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:08:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41593 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343837AbhERPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:08:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A9CCB5C0154;
        Tue, 18 May 2021 11:06:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 18 May 2021 11:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=UtZnScApeETjyLyNRFDWSVh+wz6
        +gPca+YgDd6VPR5E=; b=Vrx4mu49F+jjLkO3TymHrB0XV72VRYt0gEwF4vR2Rqe
        XNq+hTB2XBpnmCaMG+/HwNQZFhX8iRSQH6D/Wnta09KnJMOqb1ZHGOIiUMKrOba5
        SKvMe9f07evWK5NOoS+IHqKLQvYkoInlRLnGz0uWk7HWs7yq5u4rCkcrj44eAwDr
        iLbRK8waq0X9oT63zsjyY6z6bkZzSf/F8IPCgLkv18JxL/re8jXemd+/ttGk8+PA
        lcErDSmt09MZJPg9ejwNuJhx1N2gmkajZ3ZmRReXLsj2bbH+kLH7UZg40Q5xJlTR
        Xy0NzbbmtPDR/256wL6MS43RN8pXctRtMRfqZHU/apA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UtZnSc
        ApeETjyLyNRFDWSVh+wz6+gPca+YgDd6VPR5E=; b=hUjZZKYFtiOWtlef0HiIOm
        /9IgrR27rkAvQehkAPdMy1Lo5shMOj3/s8bDdKzWawQ8jfXUNemRW60ocX47u5yC
        LTiXrdv6bK68yVzwGFSC4cseMDXauHWAaL/iqlibQU2E6Q2Jm1l3I5Nwkk9yvktc
        bsoirodCq8+nVo4Kk691q3ltuHuf4RdbXiJuJ9Y0L1rBnD57ND6VvycLx/NXDfON
        bEqecQf8pYPXaaB1lB+RQFXZcpmFMu+tzsHlGt2utTX+6EcpGRjy0DwaZS1KhDn3
        5Z9VME55vdMZGARAGuChfkWGgJdQDPQeqSO7huue/jldylYcm4WQabXBUZjq8EHQ
        ==
X-ME-Sender: <xms:D9ijYJg0ZDZoDCy5u_NzUZiReq2XDCy6iFj3nvMczDe_3gGxmOF2Vw>
    <xme:D9ijYOAQAcQvcyg1U9JyRt_C8lHQgSdxhiMqFbBI4Zk6F2SvYIkTdn6y3KkPLmVJa
    e6P6X6ejxWS0ed5sGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhephfeutddvuedthfdtffeltefhudfhgeekueffhfefveehjeethfelffevfedt
    veegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpkhgrlhiiuhhmvghushdrtghomh
    enucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:D9ijYJHHfS-6dhRNV3mPiE27pRHiwspVFMy2Xq0F8_xs1d116A3Tuw>
    <xmx:D9ijYOSqaTa0sAO9lgfOl6dFffDHJ7w9DbTq5csiryA3ddlH7cYBCQ>
    <xmx:D9ijYGxf-phLAaMF6orCGBKadaewhGCGg143nezImMHT06hVAXKJNQ>
    <xmx:ENijYByTUF4wjTxcVrZ4Lv7jr4DzU5pivtPypnIwaI2NUGo0P2iJ6Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 11:06:55 -0400 (EDT)
Date:   Tue, 18 May 2021 17:06:52 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Vagrant Cascadian <vagrant@reproducible-builds.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <20210518150652.zxj56bljjeq3ogln@gilmour>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
 <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqqwqasxaqgopl6t"
Content-Disposition: inline
In-Reply-To: <87o8dawhy3.fsf@yucca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqqwqasxaqgopl6t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
> On 2021-05-16, Salvatore Bonaccorso wrote:
> > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej =C5=A0krabec wrote:
> >> Let me first explain that it was oversight on my side not noticing ini=
tials in=20
> >> your SoB tag. But since the issue was raised by Maxime, I didn't follo=
w up.
> >>=20
> >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> >> > > Unfortunately we can't take this patch as is, this needs to be you=
r real
> >> > > name, see:
> >> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#de
> >> > > veloper-s-certificate-of-origin-1-1
> >> > Dear Maxime,
> >> >=20
> >> > Thank you very much for considering my contribution and for all your
> >> > work on supporting sunxi-based hardware; I appreciate it.
> >> >=20
> >> > Thank you for referring me to the Developer's Certificate of Origin,=
 but
> >> > I had already read it before submitting (I had to do so in order to =
know
> >> > what I was saying by "Signed-off-by:") and I do certify what it says.
> >> >=20
> >> > Looking through recent entries in the commit log of the mainline ker=
nel,
> >> > I see several patches from authors such as:
> >> >=20
> >> >   H.J. Lu <hjl.tools@gmail.com>
> >> >   B K Karthik <karthik.bk2000@live.com>
> >> >   JC Kuo <jckuo@nvidia.com>
> >> >   EJ Hsu <ejh@nvidia.com>
> >> >   LH Lin <lh.lin@mediatek.com>
> >> >   KP Singh <kpsingh@kernel.org>
> >> >   Karthik B S <karthik.b.s@intel.com>
> >> >   Shreyas NC <shreyas.nc@intel.com>
> >> >   Vandana BN <bnvandana@gmail.com>
> >> >=20
> >> > so I believe names of this form are in fact acceptable, even if the
> >> > style might seem a little old-fashioned to some.
> >>=20
> >> Speaking generally, not only for this case, prior art arguments rarely=
 hold,=20
> >> because:
> >> - it might be oversight,
> >> - it might be a bad practice, which should not be followed in new=20
> >> contributions,
> >> - different maintainers have different point of view on same thing,
> >> - maintainer wants to adapt new practice or steer subsystem in new dir=
ection
> >>=20
> >> >=20
> >> > I would like to add that I have met many people with names such as C=
=2EJ.,
> >> > A A, TC, MG, etc. That is what everybody calls them and it would be
> >> > natural for them to sign themselves that way. Some of them might wan=
t to
> >> > contribute to Linux some day, and I think it would be a great shame =
and
> >> > a loss to all of us if they were discouraged from doing so by reading
> >> > our conversation in the archives and concluding that any contribution
> >> > from them, however small, would be summarily refused simply because =
of
> >> > their name. Please could you ensure that does not happen?
> >>=20
> >> The link you posted says following:
> >> "using your real name (sorry, no pseudonyms or anonymous contributions=
=2E)"
> >>=20
> >> I believe that real name means no initials, no matter what people are=
=20
> >> accustomed to. From my point of view, CJ is pseudonym derived from rea=
l name.
> >>=20
> >> This is not the first time that fix of SoB tag was requested, you can =
find such=20
> >> requests in ML archives.
>=20
> I'm sure this isn't the first time this sort of thing has been brought
> up on this subject, but I feel obliged to mention:
>=20
>   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-abo=
ut-names/
>=20
> This seems to be blocked on culturally dependent perception of what
> looks like a "real name" as opposed to any technical grounds.
>=20
> What is the goal of the "real name" in Signed-off-by actually trying to
> achieve?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#deve=
loper-s-certificate-of-origin-1-1

I'm not the one making the rules, sorry

Maxime

--qqqwqasxaqgopl6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPYDAAKCRDj7w1vZxhR
xXECAPwPQPuDwA61Q2rSL92rcSESsZsduUWrz98QLINr377e+gD9HXsf9H7P36qZ
DleU5wX9rkQ417ncngbQxsmmAH/6pwA=
=ayow
-----END PGP SIGNATURE-----

--qqqwqasxaqgopl6t--
