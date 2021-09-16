Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8240DBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhIPNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:43 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41043 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236515AbhIPNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A3A6A3200970;
        Thu, 16 Sep 2021 09:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 Sep 2021 09:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=P6BBuNiEaEPiNV/0YQaIad18nlp
        DySRjD154k7UbZYc=; b=bK1jS/5jZsW7UA+FeJJue/+F5NJ9OZ9BTMd+AwYlRmH
        dbXSFsqncpg4kbmMdGjNjAY0J5t/OSAB/UD5/b1KO45Qln3GLhrnP4ARED5BcNtn
        I4QG8NPm2bJCtacmsJoPnjYFiXF/Izo7+/65YCx86z6SXIg6ZbOXICm6vuw4PBoZ
        T3YBffMOOVHzYQaf/TleejdnkTXaP8QJ6DQKZPvCYZHj9JleWKjBhisk5+hpZ0Xd
        eKhuvY/SehAJ1cJXyuX4jvwMYYU0OkFiplJbxj7FMB0WVkLz7o1rM76kNBBTS5on
        2GpGBhBebugkaOhZH8O7shwC6WqFgXbnCVCmHTFLz7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=P6BBuN
        iEaEPiNV/0YQaIad18nlpDySRjD154k7UbZYc=; b=dHSaDsYcGUJ0voilJhRVV/
        gDMJRe6anFnn0s3lIy1LuZ9bhctzXIKyYVVaF/8TOinUyrZhjt2qIqJD7QmV8GMm
        OBzGJHuizQmxVzV1yrb+o7OuZ6qmcrk9ubzeSUgChQhoBrmTA0aeNnoogLD57/fV
        zK11JrzJC/aXkaojOOj0NJOv4V8BqEhsRC1JOmZ2bI/p/wQauLDFBHT/ZOrY9MyK
        28to/BLzKjMsUj3RtoCcxKJR6n0tpmFdxKDIxQ6PT04rAwtvEfuSKjjcnc/0F890
        VhgO23rSXpHcFkVMG8dHP4npujTD3D44nW8S0lk2gIZT4JWcjRuFwnycX/nGsrRA
        ==
X-ME-Sender: <xms:DExDYffpws5TT8ktwwJdbP34nSPElgehUCCZgXNd4IMur-IA0e11TA>
    <xme:DExDYVOk21DNX-1NFT0-Y8LG9QZI0AT0vv10bdmMZBRyfjBMfBeeOqLXv74oH4rIT
    QRlj31eKejncFJrnL4>
X-ME-Received: <xmr:DExDYYjhCzHxO9LrqAU-iVUDbRF84YT5XDg_9a9kXkVjWr7qrOpwKbFnFXwfrIhvlWc7S2X-x6ntVyWPd_zmfQr9cspKnqsRiFf9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DExDYQ-j8qz1JbGNEKJ_zS6CKX918C4UBa4bEEfPFqg6bvUGynsyUw>
    <xmx:DExDYbur5jFaY0w2MtyQaK4CG8lgGbmaRrfO-GPK9fVpXXIFvEt3SQ>
    <xmx:DExDYfG8y3hn2WSfKSjwVkZ_eOcQIlggN5QvhzyRvfGrVhinvwWbXA>
    <xmx:D0xDYfi6qlSWUaSx5qLTQWZxsMr2VhqexiILdDjm_S_0taEpf6tR4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 09:52:12 -0400 (EDT)
Date:   Thu, 16 Sep 2021 15:52:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dang Huynh <danct12@disroot.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: pinetab: Add HDMI support
Message-ID: <20210916135209.giscejyyratasjdg@gilmour>
References: <20210914193732.3047668-1-danct12@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nkqxigxo62xn7yj4"
Content-Disposition: inline
In-Reply-To: <20210914193732.3047668-1-danct12@disroot.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nkqxigxo62xn7yj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 02:37:32AM +0700, Dang Huynh wrote:
> This patch enables HDMI display on PINE64 PineTab.
>=20
> The PineTab has a HDMI Type C (mini) port.
>=20
> Signed-off-by: Dang Huynh <danct12@disroot.org>

Applied, thanks
Maxime

--nkqxigxo62xn7yj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUNMCQAKCRDj7w1vZxhR
xTEqAP9ro5D53+31qOxH8kBn5T6Ou9v/necu0PAF6j7FTKjoqgEAnrx+No2LMAoz
PO2bFzKODx0r5ulxuskCxduClVqMpwY=
=+jtd
-----END PGP SIGNATURE-----

--nkqxigxo62xn7yj4--
