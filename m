Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB031E8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBRLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:05:55 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50345 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhBRJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:57:14 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4980EA03;
        Thu, 18 Feb 2021 04:44:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Feb 2021 04:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=w1PoDIWgQW7Pnc0d8x/oY9HL+TO
        PZO54gO2/oq7o+rQ=; b=EyI4CFiU4mlhBprcx8r716cStAFgBWzqok0PrdoEyx8
        LzD/J5WNqQYE3VWtoP+8UX262+NbavYIluaWCsxYrA3/rSc9xOWJM6mq8JdOdrWp
        3Q+SSPUclYSU91yVPIaKgFyxAzV0gQGB7EYoQZML8Wc4eTHfdB8qcJAb2tzfL+6/
        1ceQCkfBoPoNtTHItD23iF9cPOYLjV28TD6yIt2Z3ME0xGmUy+ZhkAH3/WIr8sKY
        OjMgjK1C7YQpXjliK4FHabVT3Z3QC8G0PJmjBzaxoB+WF9sngwI0FRCF8j73phnS
        Fy8Bdjcf8WaZxR4iH/PIFPu4A2uMPZrpFUWsT8wotSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=w1PoDI
        WgQW7Pnc0d8x/oY9HL+TOPZO54gO2/oq7o+rQ=; b=ZQZ02BTNn0hNhuccSdihMC
        Xde8dIT9OII00Dmt4DWX5actuQVzmr876B2AKkEutfm2t5msHhseCBqyeMoqGvHZ
        ZzVf779e2GzJUra0auic9eUSDJ3RPzUtSnM504Ng3oWuXiKVysGn/eHiDjUDgkkZ
        8DBBzXHKAiUK1T2DdlsdQzomiBj1S+b/Zoo7cLd/2xo0Qd8zt2P6Ll9kL6CStehD
        VJeBVUlW7F6Rt3EEIj7xTdiAdcG/hsU1CxloOWa2+UD+C5+7AT7d+MoOxGqEOg8L
        Ku+XyOhJFoboyk1U56S7/kYHnUqE7Jzt1OWSPiqUqwZ+qH7piQpgxUidZVwCNtXw
        ==
X-ME-Sender: <xms:_DYuYM3dw9COK_ZlwmpFNjKqtX2hEAVJQsNPDMUCfr0upztkF95-MQ>
    <xme:_DYuYJEJypcSvv9UZD_nStioKy7wLf0yKbESF1SmhxDMaI4sfUkBWiw1PtCUPr0cU
    3NpK_rE5643zfUwivw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_DYuYOTZvx0nSDlA1RngPNFQKbjPb6ppzTSdfYVBZFOp6SuBslAEqw>
    <xmx:_DYuYICTxz9S6q9FHzuKUNvciyLeqxRYS6QV_xIqtNNNG9D3_ZbvYg>
    <xmx:_DYuYG26KTLXz7qTLTKTerSOjqNPBoPFUSFRi3qglonev8wfe3yv8g>
    <xmx:_TYuYKCUQ-HdIWI6xmCzEzJbm5MYzlDWyWhiQvWRFOLWCic-600ocg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F85C108005B;
        Thu, 18 Feb 2021 04:44:28 -0500 (EST)
Date:   Thu, 18 Feb 2021 10:44:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Tobias Schramm <t.schramm@manjaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio
 pll output
Message-ID: <20210218094426.fc5pxmz463fivm2w@gilmour>
References: <20210212135725.283877-1-t.schramm@manjaro.org>
 <20210218075835.o43tyarpimrcwbvk@gilmour>
 <C1E55B65-370F-4875-B7D6-7CD7A82A91DD@aosc.io>
 <914aeb08-0534-48aa-2c2e-4e87d4360e29@manjaro.org>
 <2BA0A0C7-DA37-486B-B12F-C485F1000F8E@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ctgxoqjsojtrgad"
Content-Disposition: inline
In-Reply-To: <2BA0A0C7-DA37-486B-B12F-C485F1000F8E@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ctgxoqjsojtrgad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2021 at 05:21:16PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2021=E5=B9=B42=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
5:18:39, Tobias Schramm <t.schramm@manjaro.org> =E5=86=99=E5=88=B0:
> >Hi Icenowy,
> >
> > > We have introducee SDM-based accurate audio PLL on several
> >> other SoCs. Some people is quite sensitive about audio-related
> >things.
> > >
> >While it is possible to support 24MHz * 128 / 25 / 5 =3D 24.576MHz
> >without=20
> >delta sigma modulation, matching 22.5792MHz is indeed not possible. I=20
> >read you'd prefer me to use SDM like the other SoCs though? Shall I
> >send=20
> >a v2 utilizing SDM?
>=20
> Yes, I think so.

Yes I'd rather have consistency about how we deal with this across all SoCs

Maxime

--4ctgxoqjsojtrgad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYC42+gAKCRDj7w1vZxhR
xZxBAP9dKCA17V+qSvm042nyhkVHUunMyflINeOwh3yCYdyhqQD+MzDg43jXOhct
NAH7moms0HCKwcFJeE70q/AIlXGyUAg=
=sjsw
-----END PGP SIGNATURE-----

--4ctgxoqjsojtrgad--
