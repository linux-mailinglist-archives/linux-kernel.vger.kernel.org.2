Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A23EE740
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhHQHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:31:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60825 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234402AbhHQHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:31:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2292B580AF8;
        Tue, 17 Aug 2021 03:30:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Aug 2021 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=TdDQCgbt3WT8ISUn9oc0qGDlMdw
        ifiLL3e9llk4WVz4=; b=3X0oEFxZtMo1H5enikVUS6QroHU2O8n8jBUXGsagydP
        QhYsd4UKFxVS8/GwK4tOKF2E14EuhrYVo9Xngy9njAkx42yAWQQS5uFHsscH1wiM
        vXSvlYnqbl8Km5/w2khCL3afl88AOKTdXrLVVzaBcyFkzZOeXFX1Us0/LRPAMy0d
        Vs5Z6a08YB2NzXrZljwPhQbdHankjBV75YQlpL0Z6qd5E0StulXeJtQeZH2z6v77
        PDDPbTkJQ3s7VGISKMILY5ugKmFufW/be2691EclHkkrSIuVv1GLiHf+hk43L1/f
        wV+npg+1ZL1O+c98PpVStH/cYbWhHUH+gA7fsSvPcdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TdDQCg
        bt3WT8ISUn9oc0qGDlMdwifiLL3e9llk4WVz4=; b=PZ6X30jM7wXC6XZp5MogZ7
        pyzC9BNpBNh9BFX0Fe23cEAjjQLjx6UQTLKVoDrjz464WjMH8M1EayEm0OmSrKtf
        9oEu2AAT14EKch3+awq0NUanxM3Lbs2v/QYP34F7ApI9326u2E2uHbA0jZZ+9j+M
        FBbSesCJNJgkg9skV3ZyIk/Z47qI0AyoZF5cM4ZfnrWg5SY266MUOEH9VUZa86SS
        0p6SWBZPNeq4oCcE7EZvzYLicv5fVqPsQ8nvWEwq3FHB8js3gCOlL/TkD60SeegK
        11m11jjg4QXDkIFz5oabC3GJw/1av0wtaobosRKafiIqAGqMETEYh1ERK9V85IBQ
        ==
X-ME-Sender: <xms:mmUbYfKi2q3BsSmoL56jUxI_g9qYje8PDNSTDGO6CROsbz3GHJVq8A>
    <xme:mmUbYTLpis9-CymLHpJHZap7JEWAxtqqsw2IpZ9jgpVAY-syw0tP-2XMriekh2lA5
    ppR-QolISvQAAIZipE>
X-ME-Received: <xmr:mmUbYXuOIHmboA2s22PoHF4SOjFHPGspI0Xj_cBo9wKAYIhDbqTu9lsQWc8RIbirYQTjNXvG0tb4yXYZW7Ph_iCaERZG-QXvQ1zN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:mmUbYYaYJhuOY03uRWBlVvgorNAulJS22_MkOhzWd5iqgyiWZ_7R4A>
    <xmx:mmUbYWYZQ0jMFT5-qdnYvDsI2hceQajIhnzBIRRd9qx-2tevY6P44w>
    <xmx:mmUbYcAQUmwftPkoMIgmT-0q2AxdQJLfag639_GEoAID-sb_Qd60Mw>
    <xmx:nGUbYcnmyqt6P2o2dv7tKAT2kszKUgTpvofA868jSEU_BX5HrX3mtA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Aug 2021 03:30:33 -0400 (EDT)
Date:   Tue, 17 Aug 2021 09:30:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v8 00/11] arm64: sunxi: Initial Allwinner H616 SoC support
Message-ID: <20210817073030.jcvpfipsikllursv@gilmour>
References: <20210723153838.6785-1-andre.przywara@arm.com>
 <20210726145230.uevhinsrvo7gtuty@gilmour>
 <20210802013851.13375f0f@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z5j2yzx73ws4h6ru"
Content-Disposition: inline
In-Reply-To: <20210802013851.13375f0f@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z5j2yzx73ws4h6ru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Mon, Aug 02, 2021 at 01:38:51AM +0100, Andre Przywara wrote:
> On Mon, 26 Jul 2021 16:52:30 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
> > On Fri, Jul 23, 2021 at 04:38:27PM +0100, Andre Przywara wrote:
> > > Hi,
> > >=20
> > > another try on the basic Allwinner H616 support, now on top of 5.14-r=
c1.
> > >=20
> > > This time I dropped the USB support from the basic series, to split o=
ff
> > > the discussion, and simplify the core SoC support. I will post the USB
> > > series soon, to be applied on top.
> > > I kept the RTC support in, even though this is still under discussion,
> > > because this is important to keep future DT files compatible with this
> > > kernel. =20
> >=20
> > Honestly, I don't want to support something we don't guarantee if it's
> > at the expense of making something we do guarantee more complicated.
>=20
> I don't ask for or provide guarantees, but I think we can at least *try*
> to keep this compatible. This version works at the moment, and should
> also work with future DTs - within the limits of the current driver, so
> only using the RC clock. It allows to later improve the accuracy by
> adding better input clocks - and later DT/driver combinations can make
> use of this.

Again, at the expense of having to deal with more bindings combinations
in the driver. This driver is already a nightmare to get all the one we
have to support already. You asked to keep the same driver, fair enough,
but then let's do our best to not make the situation worse there.

> > Delaying the clock tree description to sometime in the future will only
> > further complicate the probe part of the driver, and there's far too
> > many special cases already.
>=20
> I don't see how this would complicate probing beyond what Allwinner
> brought upon us already anyway: no LOSC crystal input in this package
> version, but having this pin in some other SoC sharing this die
> (according to some BSP) sources. We can't expect a super clean driver
> with those HW design choices.
>=20
> If we really cannot keep the DT compatible, fair enough: that's what
> it is (there is no guarantee!), but at least we have tried.

I mean, we didn't really try though? The whole clock tree has basically
a big TODO all over it.

I know that it can be hard to figure out. It's why I suggested to rely
on fixed clock for the moment as placeholders to get the rest of the
series in. But for some reason you don't want to do that either.

Maxime

--z5j2yzx73ws4h6ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRtllgAKCRDj7w1vZxhR
xcSqAP9v418zvkfYWEwCsLaw4/DVf7UrcSQcEUQnC82HTZxRFwD/dl0Ntal1nMak
J4dXDIunlRTAvTxQN04MlqZwpFDXvQM=
=5XVK
-----END PGP SIGNATURE-----

--z5j2yzx73ws4h6ru--
