Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590AD330F75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCHNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:36:46 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50287 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhCHNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:36:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 664655C0068;
        Mon,  8 Mar 2021 08:36:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Mar 2021 08:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TTahe+wXAe5+AmDWe9ALzhxYcrf
        llGdYAx4mFMAY3U4=; b=wBL8Efh/hN/S3EdW+ydUkJw6prLzavvukZpP7uxSNSJ
        Tuhqh3+Kl69a3O6iopw1sGfbccjCOtmilcXp34kqBFVCWvcGBOiz7wzehkOt9Z33
        822bJyvC2rvpEL/JBZEexv1hcSoMv+cn6x1s9nws5llTJISWB2lEI1g6AtAop7Yh
        cqpaKrj6MpGHLktmqNcDzwoOxa+8mUYNsXJQZapt+16W4cz0B0lBNJwDludHTh7z
        B9d+APPE0Cp8wqSJ8ljdYl8LYisz4ooyDqYV7wVz54JI3z8CrTtPSMdqGAsdYV/u
        kp3wsA+UjhmaV0obtcXsZu7m5einQ01O8x6lSXJAsoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TTahe+
        wXAe5+AmDWe9ALzhxYcrfllGdYAx4mFMAY3U4=; b=W3NlReHgtEbICdq3rDkIvU
        sKuGSKffHyINIE5kFVGfEAh3OYfw/EeNDTL/u4nRSW9H0nnJJL5znq+ZK74LxOGl
        QVdD7+HzXvknhcrbI8G7lXV44G5qJ3jCtbfxzZ4R5y7YlxLvwTMqQyEAViBe8ip9
        QcI5haYhEZoddYq7P7OLpOyLE/HTmArui0/pKs2RhF4T6qCPrvL1o8b1sIJ+0Oeu
        mXEU4X1sw/8drC+99EUocgM3trzwdHQFJ6QUp59L0PYZt0Fs5dS5RuA8Dxo5VoXc
        +XlkjQcZkGovA3DWNoRjUoNv0lwf9xI92Dj6uWklSAMYWNTir7LyuJ9a8ddUOHHA
        ==
X-ME-Sender: <xms:UyhGYLJRRKKurPahvrB6wuujSCWF_lypQqSSOF_3J7smvIOOQio3VA>
    <xme:UyhGYPLQimzjBjVz7YDVrDJ3U_YBR99d0K7yhBaIEzJTHXDHxBkaCWmCf4T6WugJm
    VqDZ66bRvqW6W1JLt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UyhGYDu7TGFs3XdTU8WXbgYwqEsUVTxP_o24sP4NpNBQi20mKhoKcA>
    <xmx:UyhGYEYmKmf2SRWDnQmY8Pi1W-efnKM_RYQUIGYZIKM3TUa8lI2LVQ>
    <xmx:UyhGYCb0IASPxr6HePrT_YA80192Eq94FU2XiRnaIT-1AEunBkkw-g>
    <xmx:VChGYCEqqyvh5ys5UDdSe9zb9tO1zpNe833jg5fUgdcw5D4jg-blHA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 608FD24005D;
        Mon,  8 Mar 2021 08:36:19 -0500 (EST)
Date:   Mon, 8 Mar 2021 14:36:17 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] net: allwinner: reset control support
Message-ID: <20210308133617.xqbjv7jybxbbqa27@gilmour>
References: <20210307031353.12643-1-boger@wirenboard.com>
 <20210307031353.12643-2-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ewe555g6kvoja7ml"
Content-Disposition: inline
In-Reply-To: <20210307031353.12643-2-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewe555g6kvoja7ml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 07, 2021 at 06:13:51AM +0300, Evgeny Boger wrote:
> R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
> However, on R40 the EMAC is gated by default.
>=20
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>

On which device was it tested?

> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/et=
hernet/allwinner/sun4i-emac.c
> index 5ed80d9a6b9f..c0ae06dd922c 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
> +#include <linux/reset.h>
>  #include <linux/soc/sunxi/sunxi_sram.h>
> =20
>  #include "sun4i-emac.h"
> @@ -85,6 +86,7 @@ struct emac_board_info {
>  	unsigned int		link;
>  	unsigned int		speed;
>  	unsigned int		duplex;
> +	struct reset_control *reset;

You should align this with the rest of the other fields=20

> =20
>  	phy_interface_t		phy_interface;
>  };
> @@ -791,6 +793,7 @@ static int emac_probe(struct platform_device *pdev)
>  	struct net_device *ndev;
>  	int ret =3D 0;
>  	const char *mac_addr;
> +	struct reset_control *reset;
> =20
>  	ndev =3D alloc_etherdev(sizeof(struct emac_board_info));
>  	if (!ndev) {
> @@ -852,6 +855,19 @@ static int emac_probe(struct platform_device *pdev)
>  		goto out_release_sram;
>  	}
> =20
> +	reset =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(reset)) {
> +		dev_err(&pdev->dev, "unable to request reset\n");
> +		ret =3D -ENODEV;
> +		goto out_release_sram;
> +	}

Judging from your commit log, it's not really optional for the R40. The
way we usually deal with this is to have a structure associated with a
new compatible and have a flag tell if that compatible requires a reset
line or not.

The dt binding should also be amended to allow the reset property

> +	db->reset =3D reset;
> +	ret =3D reset_control_deassert(db->reset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not deassert EMAC reset\n");
> +		goto out_release_sram;
> +	}
> +

The programming guidelines in the datasheet ask that the reset line must
be deasserted before the clock in enabled.

Maxime

--ewe555g6kvoja7ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEYoUQAKCRDj7w1vZxhR
xfiWAQCmzG8cWMGjCBXi5j9wpuuEfYactSHbKResEOSEXVP79QEAl8UpKf5diHue
LQQ9yJ9t3bab6YlcQkAt5TV6jLqPRwM=
=/Tfm
-----END PGP SIGNATURE-----

--ewe555g6kvoja7ml--
