Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EA30ADEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBARch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:32:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34875 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbhBARad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:30:33 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 45B775C01A3;
        Mon,  1 Feb 2021 12:29:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Feb 2021 12:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=1IUuUKCPAXxczZPng3dD+OMdufW
        kUYU8yPZFDLY8qxA=; b=nk9xxsmaDDQfr2BHNj30Wqc/Amyb2hDdxvLQgY865L5
        WRWEwHYgTr4Gxq3zqoqdwUjKL/D5Q5Y37rGUAa+kCUog+zVAl+t6bOGsapwKb8dG
        372/dP4yh/zlSn1wyOI1O5GjhWUFppnzBxc3rGrmBEbF9sZE1iSavrljtfQuVEvD
        5GxQcbIz1N2ljxmlqeOMjq7RL7udQ8QE8RjmMRNY3D1KVNIqdWW7e8kCPsv/Fg/y
        RSyAbCBvqfZ8QyK+2mj2XUNPbQNb1CeSw57lVsTXSnu1V52bt8B+AhknogFRFV7j
        1DFgIlj2O3reYO2kVsgSyDqRxm3ORqeOTfCQDiW06Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1IUuUK
        CPAXxczZPng3dD+OMdufWkUYU8yPZFDLY8qxA=; b=M4Mf14ytHT8ThgDN2aJX8A
        qSqW27PP3IwZnIILo/mow7LmJd2t3VqifdcMxAr10iMZblyunuTVvta/KftcFYAv
        AnL6lOzOWNgOMeLeEILnN310W7vvNM+xrdPC3neFBAmHO2lFWz9xJgq6BoDpBAQp
        yjwViCqQ7RmiXVCAQRKJ/bJ9BuIIagTveeDx+Dq6uXXY6WT5sVqlc7GvOYp2NziM
        oBitYTalshMQ1oM9R8kAy6BS+6E19LvrAz+tSID/4Cc12dHnxgI+zszC2AOMIe6F
        P5LrijJuTU1D7W1pi4s2n8wXFF9wd5vNWisaQIVXbCVQ0CpAwaFuikrI+SulmoMg
        ==
X-ME-Sender: <xms:dDoYYO0ZW3mshuPH-ikglEG5BXmcLBcnM-zsDwgS2orsydsHpnAfbg>
    <xme:dDoYYBEUhznVJzvLXjRGXYWVJofB-uCGgqPFIqQuoZPKWUYcZLjF_5gmknFznTYrq
    W6lOvVBZqe1Dje4Zmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dDoYYG4plw8Rc88J1_bHVJJHZUW4TVVBPswDDj4WzVQcbA1TVE1l5g>
    <xmx:dDoYYP3j4EzVpbrgSqXiklES4XffZj8CpWqCH79pzhe-cb5bNhmpag>
    <xmx:dDoYYBElFpi8Cz-aXSN9oU-ZxW2vaflQ91RwLFR9Eh90m_ojCIismQ>
    <xmx:dToYYFi9qsXdX-9DAv0QuJQTXAdoUBhRzt8e9n1bB-THOjK4PTnGmw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD45024005A;
        Mon,  1 Feb 2021 12:29:23 -0500 (EST)
Date:   Mon, 1 Feb 2021 18:29:22 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Cc:     linux-arm-kernel@lists.infradead.org, wens@csie.org,
        jernej.skrabec@siol.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
Message-ID: <20210201172922.vnelblciqun46szk@gilmour>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
 <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
 <20210128111842.GA11919@lemon.iwr.uni-heidelberg.de>
 <20210128145937.vtdi4e2aih7milmt@gilmour>
 <20210201120803.GF15207@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zp4sfxddimiu2ffh"
Content-Disposition: inline
In-Reply-To: <20210201120803.GF15207@lemon.iwr.uni-heidelberg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zp4sfxddimiu2ffh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2021 at 01:08:03PM +0100, Hermann Lauer wrote:
> On Thu, Jan 28, 2021 at 03:59:37PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 28, 2021 at 12:18:42PM +0100, Hermann.Lauer@uni-heidelberg.=
de wrote:
> > > BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
> > > packet loss rates. The realtek phy driver overrides the settings of t=
he
> > > pull ups for the delays, so fix this for BananaPro.
> > >    =20
> > > Fix the phy-mode description to correctly reflect this so that the
> > > implementation doesn't reconfigure the delays incorrectly. This
> > > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> > > rx/tx delay config").
> > >=20
> > > Fixes: 10662a33dcd9 ("ARM: dts: sun7i: Add dts file for Bananapro boa=
rd")
> > > Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
> >=20
> > Applied since it's a fix simple enough, but please provide a changelog
> > between versions.
>=20
> v3 added the correct fixes tag, where the problem originated (initial com=
mit
> of banana pro device tree). That worked in the past until a change in
> the phy device driver for realtek phy on banana pro overrode the
> phyical configuration of the hardware pull-ups.
>=20
> v4 added the commit which implemented that driver change (shamelessly sto=
len
> from the commit of the fix of the identical problem on the banana pi)

Thanks :)

For future patches make sure to have that description either in a cover
letter or below the --- after your commit log

Maxime

--zp4sfxddimiu2ffh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBg6cgAKCRDj7w1vZxhR
xZh1AQCq36tZ5n4FdroUZgnTNa601zD0ugKC3008GoIsUQUJBAD/TFa/YIFAgisI
zGDcarCcGZBBkXx/HEiCI1i0+wIGDQA=
=gu8h
-----END PGP SIGNATURE-----

--zp4sfxddimiu2ffh--
