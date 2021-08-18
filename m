Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EA3EFFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhHRJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:04:14 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43773 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230391AbhHRJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:03:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id CFD34580BC3;
        Wed, 18 Aug 2021 05:03:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Aug 2021 05:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1oLfxulgP1UBLG90dU8MLOI1oWP
        w7sLiAhVxgO9QDz0=; b=D1qDctKjWkF39D+TTYnS8PAVJp4Pn5dVi+Q9GiWEwIO
        Obb9Hk4cNpvPKVR8uc4Mit1ikKC5/4pjwOP9cTUBXKc0iQffwcYkvOI76CvtByJp
        RIiSIVDJa/TDme/7EUPVi6a+KShoRu1Ef+NP6o1J91QhpUoQ0uusMlVq3zEBS/cS
        OQk1i3IU+LhqOtoFfsX6fhhHIsz9D9BJyfCeMqqzv3AAPEHYgO3UPNkd+Fiy5tnG
        7yKjqxERIQPgPEyElrpW7F91zbsAe1/DktbzpgvQrRUD1NMaLrlqVhgNfZrM352r
        g8076etf6lV6NibbKgt2x5H+t7kwnM4jriFfnAA8NJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1oLfxu
        lgP1UBLG90dU8MLOI1oWPw7sLiAhVxgO9QDz0=; b=RxRIMjtVFA808iV+xaKvE1
        7zGdpcMS0FbDGnWjoo14lpZNiar37GxNFX+9kYG5SnR5DB3uEs6TTdo0M1WKyrts
        6gP0bSlY9UT8ERW40m+5cAqPqzw7S15gaQKpYArI+GYWaLbZtWeAtEi51zto+2sv
        EuexVF7IR+9ht1ZAgFhoGTra+Nk8KCaP/rLk0hW5WWUWk21XrqCX/o2vGfyV1753
        OQRMw+XqbEz3REoXHue0PkVp3wENoCTJiQ9poenlTodZGBUlv/AL7wc2AbDp6FOH
        h8/v+8mYc4orsHHaM5CFN9m2xAiK5vitaHhkK5YKu7PDB9DOS5vfjnCuBwL2Vdnw
        ==
X-ME-Sender: <xms:18wcYbrCqRN9HB4AdgdS3VFJcYFdtcCYz9QB_L16VqStxjM08IyliQ>
    <xme:18wcYVohqfuaRrJjQ24qsU7jpumbuHpHK2ls77U4F7gTOl63KYi47XgqKcYY-SYZb
    tps2yXY_fcQ2pDOBQc>
X-ME-Received: <xmr:18wcYYNnUt01lXsdYgUapjsAwgwGsoyKvtGjlQUoewsCFB5Gcalvya7eID33LOAr9gBttPhY_OafbWfVRbtaUmKfv5-tgRTh24RD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:18wcYe4wvZB18pPZMflU-SCbhcNEXObPhakx8n5mbIhXNAwt8FJQBw>
    <xmx:18wcYa5tL1b9-3h9Yq47b6YO8D46O2FossfVtgwgMYmb0Yr9023HvQ>
    <xmx:18wcYWijCtBtKrtFnB57uUyPQ86dO9OAN9Ux7_H-93xngPauhrPr2Q>
    <xmx:2MwcYShgsDF4uBV6F6UtOx_5Zdm10LfZCAbrXbF5R9Ro14ZcqC0gsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 05:03:18 -0400 (EDT)
Date:   Wed, 18 Aug 2021 11:03:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] dt-bindings: arm: sunxi: add compatible strings
 for Sipeed MaixSense
Message-ID: <20210818090317.xqo62oy23jbc27ti@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-15-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ormuvhszpiekcbgs"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-15-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ormuvhszpiekcbgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:09PM +0800, Icenowy Zheng wrote:
> Sipeed MaixSense is an Allwinner R329 development kit based on Maix IIA
> SoM.
>=20
> Add compatible strings for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 889128acf49a..bce306908eff 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -444,6 +444,12 @@ properties:
>            - const: haoyu,a10-marsboard
>            - const: allwinner,sun4i-a10
> =20
> +      - description: Sipeed MaixSense
> +        items:
> +          - const: sipeed,maixsense
> +          - const: sipeed,maix-iia
> +          - const: allwinner,sun50i-r329
> +

This should be ordered

Maxime

--ormuvhszpiekcbgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzM1QAKCRDj7w1vZxhR
xSjaAQCzT8tHWjZy7l9ZYXLHyVRhaTmkMGSJ9SyEvLZrV7+2NAEA5p16uIIRlTLH
s/VcIaQAnSRkJ0h6DWvT44dlObEK4Aw=
=j6EF
-----END PGP SIGNATURE-----

--ormuvhszpiekcbgs--
