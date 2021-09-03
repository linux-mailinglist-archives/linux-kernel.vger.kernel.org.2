Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C93FFCF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbhICJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:22:20 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40233 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348762AbhICJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:22:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 837B832001FC;
        Fri,  3 Sep 2021 05:21:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 05:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sAiRI9c4Qga0Ic/pFIIogIPRDm5
        9Php5SKSojiIRi2M=; b=GTITGcZfwHPhKcJ0YbdWs+77drjMuX+GOGL/caWx0CQ
        LB0rx8Qo49Jb6V7r3QtF+DQ1HGPLSvWwriYNZT6kSA/stV0+c5XPJ7yk6YlSiICf
        LryluppuuYWbEEgfj2EVVLIMOV2U2XnGMZwz9Ux6JAqZyHYmlCkva5m49WnVmpwr
        VB6o20E5zk11oyxgS4ylIglxqN+XhlRqxxjmi714oEqj2Z40tpuPva2zQOqYqxDj
        GP8KyX0Dv96gptg7gANyGehoh1jvQKptRbOuH0t/xs4DErGgFfo8fW2sRZIcomcK
        qnqgrJ0soGcLfr9QLrFycCfaQXpcE5PxUMvADqF/CiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sAiRI9
        c4Qga0Ic/pFIIogIPRDm59Php5SKSojiIRi2M=; b=lq56pGPZ44bjRLjn9OsJk3
        BZ1v41iIcfR//FNYxbI0Yw41yMTaJIlGok4nnJe+dQyph84JV1eioAsQEF2lYVvz
        Q9j3ivCrhD31E3w9uHebBgbPwo18varz7sfXgIYSXMpAarIxqzN1itRHM1PhBOA3
        2qiDwlL/4p1O6TO6cplD9k/PRw+2dKx0xKr8j/gpK38qO4rKuiZNlzgiN6e5DX6k
        qSuZfeiWYy5FiMbq1jgs6Wam605LpmTnkh14GFNC5uqQlqFB0AljNit3x+0DIqyC
        MwEXmGu7F2o2gPlU/foOFqM+4wGOVro7BR2Mx1/HKVKGx33mOVwjHrsUx+fDgmuw
        ==
X-ME-Sender: <xms:BekxYTVc3BWx58LfDSdLzbndC82PjPXEQ7wGzC88uyUh3QRave5MJw>
    <xme:BekxYbn8fIihL6JJ4BQNU7DZlCg5GPlYgCPJsRYGS067mnGJ16JaGSYWCqnllTd4M
    IzA5FMBfKGTDV4Le-0>
X-ME-Received: <xmr:BekxYfYoMsjM5wOhZ_vstXhGYRjjUowgRoxSjo3VhlnWHkWGDxPGOrhge4DpBm-G2QLf0qX_RlYnBH3cStM7cQOKcYllMRXIXOmz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BekxYeXg06lWWFaBCE7Cg7iEc7e0by7j6xyDWDs1Px6KWxdtZV-Y1Q>
    <xmx:BekxYdlDpNDr2Qrp_p6J-prI3fX8ltM5H4kuVhhJc2cXPDSytACIRQ>
    <xmx:BekxYbd12KVl904RzHUnnHM1Ftcp28eswHfnZtcaUhshXiQc627m9w>
    <xmx:COkxYf46NUDz4BvaEzV5o6rjPFadN0zW5Qg6yjnbxRTnRVrHSaB3KA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 05:21:09 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:21:08 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>,
        Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Message-ID: <20210903092108.62oqmqveze7usrgk@gilmour>
References: <20210830151645.18018-1-u@pkh.me>
 <1746741.3t3T1tWQfl@kista>
 <YS6WxHtJtNDaBxqz@lunn.ch>
 <6939430.QNQgkB6KyE@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mnkm2zv2dbvyw5v"
Content-Disposition: inline
In-Reply-To: <6939430.QNQgkB6KyE@kista>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mnkm2zv2dbvyw5v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2021 at 05:31:32PM +0200, Jernej =C5=A0krabec wrote:
> Dne torek, 31. avgust 2021 ob 22:53:24 CEST je Andrew Lunn napisal(a):
> > > True, but then again, DT is a bit special, since it's not used only b=
y=20
> Linux.=20
> > > It's shared at least with BSDs and U-Boot, which most likely have=20
> independent=20
> > > driver implementation. That's why it's good to have DT fixes referenc=
ing DT=20
> > > related commits. As you said, DT described HW wrong.
> > >=20
> > > Looking at past Allwinner related DT commits regarding this issue, we=
 were=20
> not=20
> > > totally consistent. Most of them reference commit where emac node was=
=20
> > > introduced in DT. But I also found a couple of commits which indeed h=
ave=20
> fixes=20
> > > tag for bbc4d71d6354.
> >=20
> > All true, and it is not a big deal if it does go back further. I don't
> > care, we can let the Allwinner Maintainer decide. Ah, that is you :-)
> >=20
> > I just want to try to keep it simple for somebody who is contributing
> > their first Linux kernel patch. If it is good enough, i say accept it,
> > and we can do a bit more education on the second contribution.
>=20
> Maxime, Chen-Yu, thoughts?
>=20
> Since there are both approaches for fixes tag already in, I guess this is=
 also=20
> fine.

I agree with you, the fixes should point at the initial Device Tree
issue. Our DT are used by other projects and even if in Linux it wasn't
causing any issue before another commit showed up, it might affect those
projects differently.

Maxime

--2mnkm2zv2dbvyw5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHpBAAKCRDj7w1vZxhR
xe77AQDS7w4amoRbxd9sNcrSODsRJ0/4gRAAoPBh7Z+Q+gDAmAEA1dXNXw9B74Bm
jH0v9R+BTKJ7wCf+9NtwDGhFFLrbCQg=
=qQ3P
-----END PGP SIGNATURE-----

--2mnkm2zv2dbvyw5v--
