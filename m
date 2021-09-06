Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA28E401777
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbhIFIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:04:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50869 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240468AbhIFIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:04:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id F272532007F0;
        Mon,  6 Sep 2021 04:03:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 06 Sep 2021 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=PfIK/LyB51fms9Rxn1/cfuQmbJy
        ii5HP9SxYC4z14ic=; b=MZkK5McR9MRrEds2Uikwa49y+7QT8+2nFPbBFaRAcyr
        DD1rCnjXNh7M1s+JO9R8QrsbS4J4cf6IEIDN9RXws8a1nePuQHEHARe88lIAVFh6
        8/m5rImryR3NxgThnvwR74DJcgd5eRZYFyIb1PQAO61zhkSKZE+D7VwYImistQci
        rQUJo8zYQeeDwfiWDBaDp3B8kzit1QzllRbJVwS4qTn84rIAmQjHvboSvUJX03fM
        9eL6TfzZrChSokJeeKUHJLhUNzuO22oHql7LfH7wMgbqyZnoqsfUFgVMLy7YsDMu
        wGhvLmdICOzXVIk4ycRvgjle4yH0k/2Ye/NmDJqB03w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PfIK/L
        yB51fms9Rxn1/cfuQmbJyii5HP9SxYC4z14ic=; b=WzqXrDtYfUXyhD3PkhhNZz
        6dRtHCriK10i0O919SHWk/X3vd+mz18BC1SLdkUqmu3Ai2jI/bewtnF50YiJLQxv
        yzIId/wXrJAnGqHfdTtEEHw/mTbU+0keEGpSsymUZdkU5Y1zqpycYeuDTY4HuHZu
        MW8rNqiaJaxjy//OCwcvaRVuzRu6HrmLvlmg6+N5JWVzaZmC+kL95V3xnET2cAnZ
        oAv3rF96UsOkP1qANkWsYnwKGA7u54QiAqsTXxFG/glCUIAJ/VypuSx05K5zaUcp
        puB96e1gCeIzQZNkKiIWyqFnCJQ7CJQ2j+qnTrtJTT+T0i3vg7NMVQtiZO6VQEJw
        ==
X-ME-Sender: <xms:Wss1YcahEUTZK2_vUdDclXAfssy1_Apb2FARlWYTS4sQEAqt4ENAeQ>
    <xme:Wss1YXbhV_ElkDUcUajf9YzuFSVjQzmOzPIzd08-tU5hUVKu8xR0INcjTxOQxt-aW
    3c3hO-DH0T7byUawSM>
X-ME-Received: <xmr:Wss1YW9bI9tfpg7_XFloj_1gHlbsglcDehbJLzXu9QY3zXMIhnfkimAcHPMTSV-Viy3B755bv_l8gdF5ln_qIvXt8ScHVzz3frHh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
    vghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepuedtgfejueduheevgfevvdettd
    duleffgfffkeeltdffkeegudekjeeuveeigedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Wss1YWoUa-NR6ljqEXVz7HiLAJPb1bzXFfqgTT86AExDKQ0GJqhdUQ>
    <xmx:Wss1YXqx6gLZ9dhfEvBXvfsznz2TID2GXxjL5Uc_HFvoGagpept-cA>
    <xmx:Wss1YUTJvwL1EyJcpmq5Dg6sv-oC9cbTUElEQ325RWb1-QxOYq3yzA>
    <xmx:W8s1Ybf9qzBawBJQVeUXVdSMcYCxaHqeOY_dT3dVx_kE88btF55rTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Sep 2021 04:03:37 -0400 (EDT)
Date:   Mon, 6 Sep 2021 10:03:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>
Cc:     jernej.skrabec@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org, wens@csie.org,
        willy.liu@realtek.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h5: NanoPI Neo 2: Fix ethernet
 node
Message-ID: <20210906080335.xly2myzvbmtreics@gilmour>
References: <116454729.UZi3dMzWh7@jernej-laptop>
 <20210905002027.171984-1-u@pkh.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qojf5otekovswdzb"
Content-Disposition: inline
In-Reply-To: <20210905002027.171984-1-u@pkh.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qojf5otekovswdzb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 05, 2021 at 02:20:27AM +0200, Cl=C3=A9ment B=C5=93sch wrote:
> RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
> node.
>=20
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> Signed-off-by: Cl=C3=A9ment B=C5=93sch <u@pkh.me>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks
Maxime

--qojf5otekovswdzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTXLVwAKCRDj7w1vZxhR
xaSRAQDCPj4bg9BzyhsYgEU1WLuX6ot8mRNa37rNgGISvGoVGgEAnN9h9yQRqXpq
RCePzhbn/0ChVmmfuKe45+jb8/DzcgU=
=KnkT
-----END PGP SIGNATURE-----

--qojf5otekovswdzb--
