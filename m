Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7431E7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhBRJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:14:46 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52769 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhBRIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:01:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ED64E9A7;
        Thu, 18 Feb 2021 02:58:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Feb 2021 02:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=8o/m5OJPItfrGDLkKjJ6a/AXkvF
        mxcbN4FoGW2HUgRU=; b=OFEzlboBVzy/p1Z2s+wZXvS7qqKe7zppXjm8Wv0cYIx
        I9DDGv7K0sDdOOD74454Q0zp3gIo1E2s8+TqK6Gq+2vIg57f7QQuyjaYRDmtd6nX
        1Nx38TmJZiKN1ianXllkD6EtnFA9YlKPVR5NYT4CtVfvaO8CNx38D9/5Vt5k77MS
        oDVwmugHQYuIQeI7lELe4OTBlru5I6W+lz2ejJ74kAJ7bNhESQNdXjCfGBysPcTc
        KMcXNzljODJtXdXsm5kozRtQI5mappiwNHR0fmyjNYvLruWe2GvpsDzDYHrdYk7/
        i4xKkSPjlAqiQMT9TqQJkc/czWekK9y5ZAnkf4bIz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8o/m5O
        JPItfrGDLkKjJ6a/AXkvFmxcbN4FoGW2HUgRU=; b=BiDzekodkeJZpcAg/Ekuqt
        RyzB5SqH4dv85fZiVOgL1AKgJCb2/iEWNRNKD4OF84E5uzOxhCIKfF5SuKJHW+YZ
        KwhcQ9srJJaPke/VkkGdOrcFOJAdvnb0B/tiWPnK4hR2USrJ93F7QOSgIzsT6O2K
        xiR9evsvxf/abOQGJ/Q5w5RYIm5/QGc5SoKaHtAvwZqu/WvsSc+pjWKOSCDJzEaM
        HWZ/FfRuduvqgcMuJQtjYmJWmlPjGTKvWNjl0oO9fgp2j7eQrLyztLV1d0RM7fbe
        2TdQk1eYlPCD3h5CoVrNMPNdFnF6oG2GyqSUWYoqpkU6oD5UbLlciboRjeo75c4w
        ==
X-ME-Sender: <xms:Lh4uYHP4O43IydryLhnidczXbOnoEvGQk5Me6Y4zk3-DlFDB6NUoLQ>
    <xme:Lh4uYB83ug-rs35tljtug8RxS9q_lW6kODW9oyF1h28dAIa_7I4kg2YpE3mAqmckg
    J6Ox8S9kf9RqIYZJ8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Lh4uYGSqw6l1lZCgeG96NUxmKTTuGK4XJzTs7ze5LGC3wnQWZnVb6Q>
    <xmx:Lh4uYLvQeCSh7FQiDHOO62chMihK9Jrazj-NXveFyQCX9avbyVjd2Q>
    <xmx:Lh4uYPeloOUC0TQUWjCDayffBbs-xM0TmGXkomWbacM2Tyow76KDCw>
    <xmx:Lx4uYHRgtLMoOgOsBsRFpfkPXgXqsYv6BNW_G01t0A3LSdDe13rUSw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEF3A1080057;
        Thu, 18 Feb 2021 02:58:37 -0500 (EST)
Date:   Thu, 18 Feb 2021 08:58:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio
 pll output
Message-ID: <20210218075835.o43tyarpimrcwbvk@gilmour>
References: <20210212135725.283877-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eajg6aowebrbouve"
Content-Disposition: inline
In-Reply-To: <20210212135725.283877-1-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eajg6aowebrbouve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 12, 2021 at 02:57:25PM +0100, Tobias Schramm wrote:
> Previously the variable rate audio pll output was fixed to a divider of
> four. This is unfortunately incompatible with generating commonly used
> I2S core clock rates like 24.576MHz from the 24MHz parent clock.
> This commit adds support for arbitrary audio pll output dividers to fix
> that.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

It's not really clear to me how that would help.

The closest frequency we can provide for 24.576MHz would be 24580645 Hz,
with N =3D 127, M =3D 31 and P =3D 4, so it would work with what we have
already?

Maxime

--eajg6aowebrbouve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYC4eKwAKCRDj7w1vZxhR
xY7sAP9EMNcUCVMrqJAuITaMVv3u75Oy0e7v493CUjwhWNZLTwD/ThCNEGxNkpoE
2vggeshrvzbJePDtvl021bFNAJjxWws=
=BmSU
-----END PGP SIGNATURE-----

--eajg6aowebrbouve--
