Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6132AAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444919AbhCBTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:53:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38587 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239630AbhCBRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:23:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 21040166B;
        Tue,  2 Mar 2021 12:22:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Mar 2021 12:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=n/ryt3OhhTC2QCbydemsESmfflk
        TtRlovBZzUn8I8HM=; b=S5Cr6s6NTpuWN7JNU+4LZcHsHfI1zMR//yHrxrQCzSW
        d+3VndYpcWS9T3WEmoJ5e1lSiibEDcHYYCHBlB7xpiSN25N4BphWu34W+m1VeFfv
        tsmVeR2MhscfWyoD8YnoHO1/FVi/HfG5IHxtqlcbqnbVDQhlTHsfJgYF7TDInWu1
        d4rMr0CQXp7n4YkxlrYTI/DfQ98A+aTLQkGzAr/ePOMyHAcxbeav2AT8WoSWd6XK
        1FrPLgvuqHexaDqfSjpbG0GdlBsupbwnfzZoNckLr/7BYmVstSYxCOX4gO52/XPM
        Vs+B0SpDH43q20pjzHmB/t4sb8wI0sbLxvKYeYShRsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=n/ryt3
        OhhTC2QCbydemsESmfflkTtRlovBZzUn8I8HM=; b=hMFw2dC+/R3+ZO484LVvKL
        7+a8M1gzUSutQ/8Q3bvYKCu1hKNOOlg7IF7sA61voWgk0zZTR44znHzvc79/RtaF
        05llWOHpswnODNN/c0o+/P1K0dFTR3kqiVzsDumTE27f97cTDd/KS5rCpdmqPA4k
        wPv0eGTa5keEk2lS+JDbCXKsWGGcMKTKbyZHCgRWcC3dLSNbQoKZozv+NxzoWcMh
        fr1qRnuyJY0tHp2yrQI6wmg/NY9Pjpc/SWsPkk2fJfjQu8z3tOjsbCwW8DMtBWDh
        rZqxnbdAra/7uXRYqmlcpHaPcEx77/q3J+P31ayKayQ0lP60I7a1spLnIjo2QOnQ
        ==
X-ME-Sender: <xms:W3Q-YDwlv4zRDcqxB9K9aYTy2OwV1TD0g6vC_5yHtZp2-DO-gHqYJg>
    <xme:W3Q-YNQtSYCuXMl1an9P6bYLP6lIB7RA1vBCzvY8OWIjPS3ha18j6heriZYSlVP09
    0WJNhByxZZki3O4IxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddttddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:W3Q-YGt8Ot5nf4zbFJkSmM_-R0AszmkwXwj7qyldRDDFgOWmAG64_w>
    <xmx:W3Q-YPsQeEjAfK9uIFBYNLsXsZJeufIYpqa6NGRau2Nq-44-pHsQLA>
    <xmx:W3Q-YMypb80M3WJx4FeEoR4Db4HDIga9gmbWCu7CpWdD5bz7b68ytw>
    <xmx:XHQ-YBlk6baMMH3Hox6h-S2oJVZjBpHeRtbWQUdFgn-y-1L2eFNpbw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 503A824005C;
        Tue,  2 Mar 2021 12:22:35 -0500 (EST)
Date:   Tue, 2 Mar 2021 18:22:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210302172233.yn6iharipua5ykct@gilmour>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
 <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
 <20210301131244.otn7vzhgstufjts2@hendrix>
 <20210301150635.480934a8@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sw5372ehujb5efr2"
Content-Disposition: inline
In-Reply-To: <20210301150635.480934a8@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sw5372ehujb5efr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 03:06:35PM +0100, Wilken Gottwalt wrote:
> On Mon, 1 Mar 2021 14:12:44 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Sat, Feb 27, 2021 at 02:03:28PM +0100, Wilken Gottwalt wrote:
> > > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > > compatible series SoCs.
> > >
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > ---
> > > Changes in v6:
> > >   - fixed formating and name issues in dt documentation
> > >
> > > Changes in v5:
> > >   - changed binding to earliest known supported SoC sun6i-a31
> > >   - dropped unnecessary entries
> > >
> > > Changes in v4:
> > >   - changed binding to sun8i-a33-hwpinlock
> > >   - added changes suggested by Maxime Ripard
> > >
> > > Changes in v3:
> > >   - changed symbols from sunxi to sun8i
> > >
> > > Changes in v2:
> > >   - fixed memory ranges
> > > ---
> > >  .../hwlock/allwinner,sun6i-hwspinlock.yaml    | 45 +++++++++++++++++=
++
> >=20
> > The name of the file doesn't match the compatible, once fixed:
> > Acked-by: Maxime Ripard <mripard@kernel.org>
>=20
> This is something that still confuses me. What if you have more than one
> compatible string?

In this case, it's fairly easy there's only one :)

But we're following the same rule than the compatible: the first SoC
that got the compatible wins=20

> This won't be solvable. See the qcom binding for example,
> there are two strings and none matches. In the omap bindings are also two
> strings and only one matches. In all cases, including mine, the bindings
> check script is fine with that.

If other platforms want to follow other rules, good for them :)

> So, you basically want it to be called
> "allwinner,sun6i-a31-hwspinlock.yaml"?

Yes

Maxime

--sw5372ehujb5efr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYD50WQAKCRDj7w1vZxhR
xcdPAP9tzTlvxjihOoXUo/I/ZCFo53W91vxdNey9dArIobAXCQEAlJzbsU/81lkY
0W6mlFveICHKCrvvIvM95phgehldMgU=
=gcPq
-----END PGP SIGNATURE-----

--sw5372ehujb5efr2--
