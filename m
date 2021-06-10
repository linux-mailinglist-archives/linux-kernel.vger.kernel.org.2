Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148FA3A2BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFJMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:54:11 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40255 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230136AbhFJMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:54:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 58E5A2101;
        Thu, 10 Jun 2021 08:52:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 10 Jun 2021 08:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=E5Pc7fipEbBuER2SNRqORMg07Xg
        /kjPfCBgdeNOwwzM=; b=uq6gkHgO9P4locKPO6euSQbmudLsOCueuxjgrVcQzUn
        jIuPRd0L2ilYFUJM5fDYevFoxX3Q5mZT4EHcO2eeYX/nhzN6C/Bbk5udF9bOecCX
        IF3ogEnb6EQE9ee8fZfCKU51fxPf1gtLymjRvGXaeSNgZB4jupKyUcK91WFUeY1h
        C7YQW66FVS8agu5Nf6J3OUodV5qKCNdNlVe/NG7vfcNmUgYFzVTNp+/TeaGL3L/k
        sn1hCtz9v6+4Up4fLxAnNb7mNqFJA80feYZEe3VdTZFnrthHtWn2m5UwxKDace+M
        6xqgi0tqDyxn65Px5GpD4g3Qg2n6D1Pi5o1XTkHzeMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=E5Pc7f
        ipEbBuER2SNRqORMg07Xg/kjPfCBgdeNOwwzM=; b=ZqXhRvdLv45r+chVTO/7Gn
        4rkTQyCMncwDlexzWTVXLDnhXkbbSKs5Xe9MxCsVqpd0TVjcyvUfK4xAtRjSzLRI
        gl7uAgr9e2S2Ocr9XjLPRkSG6SH1NrKWpp5s3ES8NS5S7CKays9SWhpyBFE4hS77
        KVplRntLY+OkP0sUlE0jPpQUnnOuBv3dk87lBosI12nZe2mZKu4kEiYFA7cvzJhf
        ufH89d4ym7eV5GD8XfnCA0RexPkqAcNKmIfl3Ejr0FeCTncX9O0Y8ybAvyh1xYCe
        ctIL6Xbo2Ei1SHgo2h9Y7fRF2s0XB19aapdramN8/FEKyvPZQj0SMssjYB8zZPuw
        ==
X-ME-Sender: <xms:-grCYIpZbk5lCYj5uIN1DWB4fQsO8JVtMIPqmV1WF0BXFVndtZiI4g>
    <xme:-grCYOo3nAhFXjOAHrf3GQVv00tNDtviMzBCYRZEoeluqolcj37rIcPBiKZFTYIRk
    ZEBd0-OkqrArdUvJc8>
X-ME-Received: <xmr:-grCYNNi2HN3uwtsvbhZBGogEDdiC_tn2F4TBDmI_46TB2aM14r7e9TM_QHQrAXDOggB8AytUl9rhM6hc9PnFAZB-MkfML50IzvX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-grCYP4RUxWvahUH6bjMQyTyFo7s_d5zqATDaS6mrGP7hYEDPhuADQ>
    <xmx:-grCYH6h9MyvrQghSck7vrbCmTz9Mva5GdXqYe7m8QpgnUyWJmTSqA>
    <xmx:-grCYPiSTrLLLOf4_U1B4WhOym-nAdceCSX-CrQreObSrp6nRr0eQA>
    <xmx:-wrCYEs1rcT8oVyHC_bxhQL45xKAEUpsBzsH6sJAbrobiqh3DWVlTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 08:52:10 -0400 (EDT)
Date:   Thu, 10 Jun 2021 14:52:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64-sopine-baseboard: change
 RGMII mode to TXID
Message-ID: <20210610125209.glrd2qlpwqiha24h@gilmour>
References: <20210609083843.463750-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="io7uwxozpxpfiet4"
Content-Disposition: inline
In-Reply-To: <20210609083843.463750-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--io7uwxozpxpfiet4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 04:38:43PM +0800, Icenowy Zheng wrote:
> Although the schematics of Pine A64-LTS and SoPine Baseboard shows both
> the RX and TX internal delay are enabled, they're using the same broken
> RTL8211E chip batch with Pine A64+, so they should use TXID instead, not
> ID.
>=20
> In addition, by checking the real components soldered on both a SoPine
> Baseboard and a Pine A64-LTS, RX delay is not enabled (GR69 soldered and
> GR70 NC) despite the schematics says it's enabled. It's a common
> situation for Pine64 boards that the NC information on schematics is not
> the same with the board.
>=20
> So the RGMII delay mode should be TXID on these boards.
>=20
> Fixes: c2b111e59a7b ("arm64: dts: allwinner: A64 Sopine: phy-mode rgmii-i=
d")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks
Maxime

--io7uwxozpxpfiet4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMIK+QAKCRDj7w1vZxhR
xdspAP9uCPofAxHimp/PmBqZWpgDIoj9Jm6i11JcI3I8w29RPQEAl/hyxPgO52Bq
BJlk9Q56TTqTCDsAPS0wOl8F0unSGAg=
=DvGq
-----END PGP SIGNATURE-----

--io7uwxozpxpfiet4--
