Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C633BF63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhCOPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:04:01 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51795 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239019AbhCOPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:03:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 373C02385;
        Mon, 15 Mar 2021 11:03:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 11:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=imv4IetqNlL67VMIjffr1KT6NlK
        C85EkumX2HdaLpqQ=; b=iLddbCBnHq2pKqGeEzFQaj68uwOm2kDuuedkz6fwWrI
        xlFIpqIOgF/E4HeeYiKmLuOYqW5rx22rHwX1kgRYKGZ3gXMTnopODCXuse6Jr+Sa
        MnOYMwl9NkAdmOwl5j8NqDLqgbwhAnJJId+cEOxeJjGAZrjyMzQSYO/L+apAOLV9
        OUnOEoTroWFxEBjY6fpYmcnucwM1tCNljN9ttUcZaGkes+32f5pO5C+VojfA66V4
        98uebtcO20452m+kM3xcbpYIHlnzXLqA0d2LVsHpw43aKXIGyDwAfCqKKC548Fuj
        1lVE4PQO3aLGpO7juduPMA0gwCq4WN8q6BuQGfMod+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=imv4Ie
        tqNlL67VMIjffr1KT6NlKC85EkumX2HdaLpqQ=; b=D7oG4rMpBZSgdfyypVnnrU
        Um7i+BemRlI+fPRMioITdWTfqeBDICwVebIXIyswa0xRiA0KuVkdm+FMhq+5OFVJ
        We//tLopWcv1IIq+DTKApUO9bAXiOMyh2CQgQKlsd0zjH1sDYSlLnKENGAK3OUP/
        1gceNs4qel8JsQba72pO5/rhh+h3e62nCxqAz4crJymg5LgAQs1cqCkL25hlcfpz
        I5jfpMFN5XAIgrsnz/RF/zbezkQZ7Vv7sh81a4iaL/Q+oN8dDQu1Hrtexve5TAn0
        q2SEFGfBKyqeroJjx/QIX4V56jSS1W+Ln2i+Rkz2bN1unVpftrXeGQxAqNRe6bVg
        ==
X-ME-Sender: <xms:UXdPYJFS5MDvL6Q216fhJJttxPIYIu4YPMMcO8UEaF1BoR2KZkalDw>
    <xme:UXdPYOTuhoed_Jf7kK9ARIyKT9ehBI43lJTbZv1QXK5tb10e-VwtWh4YOQQiPmjvf
    MHKRDB2YAt5c5_GimQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UXdPYICEaYJjvJ5gCM4qYBhXUnJ5OOjwbo1gdWcj6om8fxQidyETOw>
    <xmx:UXdPYG1Xozsliz2O950mfgjMC5XJdypsgMslTRysggOcEg205apSeg>
    <xmx:UXdPYOUwk1JVsax-YkmKfZ5wAEeDEUPVUGNqi5SgqPT9Q44KrIO4aQ>
    <xmx:UndPYI6QFFnThVOFKpXrASgXvIE5IlD9agnR0TY4V0Aag2TAeBIg4A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F9EB1080063;
        Mon, 15 Mar 2021 11:03:45 -0400 (EDT)
Date:   Mon, 15 Mar 2021 16:03:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add power button
Message-ID: <20210315150343.uzq46th6eecdr4e2@gilmour>
References: <20210306203611.15534-1-jernej.skrabec@siol.net>
 <20210308130506.v35gjviwknr5hat5@gilmour>
 <2517400.0zBCEEo8qi@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mfhruzbnsooaoye6"
Content-Disposition: inline
In-Reply-To: <2517400.0zBCEEo8qi@kista>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfhruzbnsooaoye6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 11, 2021 at 10:59:35PM +0100, Jernej =C5=A0krabec wrote:
> Hi!
>=20
> Dne ponedeljek, 08. marec 2021 ob 14:05:06 CET je Maxime Ripard napisal(a=
):
> > Hi
> >=20
> > On Sat, Mar 06, 2021 at 09:36:11PM +0100, Jernej Skrabec wrote:
> > > Beelink X2 has power button. Add node for it.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boo=
t/dts/
> sun8i-h3-beelink-x2.dts
> > > index 62b5280ec093..4a2cb072ecf6 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > @@ -111,6 +111,17 @@ spdif_out: spdif-out {
> > >  		#sound-dai-cells =3D <0>;
> > >  		compatible =3D "linux,spdif-dit";
> > >  	};
> > > +
> > > +	r_gpio_keys {
> >=20
> > Underscores are not valid for node names (and will trigger a dtc warning
> > when running with W=3D1).
>=20
> Unless I'm doing something wrong, I didn't get any warning with "make dtb=
s=20
> W=3D1". In fact many H3 boards have a node with this name and not a singl=
e=20
> warning is produced with this command for underscores (there are other=20
> warnings though).

It looks like I've been remembering it wrong, and it's actually W=3D2 that
reports it, but it's here nonetheless :)

Maxime

--mfhruzbnsooaoye6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE93TwAKCRDj7w1vZxhR
xYexAQDb6dkfEktXz1olTmB8ij8tEMvdw1+q+P4jn663TrYYlAEAwOCcYZI9M/W4
PYGJSL4AaL7FgNeesPXOs7AB7A0KygU=
=znPS
-----END PGP SIGNATURE-----

--mfhruzbnsooaoye6--
