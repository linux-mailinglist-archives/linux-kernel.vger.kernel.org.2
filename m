Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBA330ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhCHNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:05:38 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55127 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhCHNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:05:16 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BC3B75C00CB;
        Mon,  8 Mar 2021 08:05:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Mar 2021 08:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=n5uQ4ynIjf1uUT0X74WfFRWLHAy
        PO/7KSH6K1r71T10=; b=E2/dDH6+BD0Kyx0lP+hL27nleZ+bUBr8CBx1iWHt9Xs
        fupSBsMIWT6h/NCH2HX5Chc0RNucqsq/tSnXwwEgobp2YGRA47XLwcxQ5UF3Iljr
        chUavwLqKnKSEx5T2mc+nEWMj3OXp5ppXH6aiBsVrS1PiJyECbdLeL7WLKp98PK2
        xeag4bKHujB8OiMB1NnEnECHVy7LtosEb6jF3OwEs/HlAN3oe3QCIkNb16BqEuW4
        3juQN1g2cKZpXcpRkfyKeVAy65XQWEJrh0wQLBsbWPuupPeh1ny9X0fonzMCGuWN
        iW2dr+J48XavdOZse5VQI4BkTn14iCy8uhJy4o1HOFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=n5uQ4y
        nIjf1uUT0X74WfFRWLHAyPO/7KSH6K1r71T10=; b=DmSIWxxaZ+hA4FssTh8zW4
        qRE/uGt0yvslwh+Joocm1Kq8UWV2N87/OX44CNReIIdZKYJ30gNOzPlfjfTivUFo
        4slKvYFDGee4hQogGe9xyGx/LrqDtwDN+a9JwQJZqFZo4beo9yT/A6qX9CYPMSYz
        zABC8ycfp2laf6Mk8kw8ebRNOLdQBX65FqVf8SmYJfAL62vSknkr9tXWteB78cmm
        aNdkS0VBXrfFNmJvTFWej8FDTySm2qBxLWKJxMVCAYFVAKy7D944mxHig56GNo3o
        myCLlPUiYYIm36frMlIuFeZnMq/OXs8hYSsOMTQgjQcxbtCVwkULJTMkjkuE+b0w
        ==
X-ME-Sender: <xms:BSFGYFSWoq9KliHsIQi1nfu0z8aOT-LY_Zm47qxsFX2jCpd4Dk11sg>
    <xme:BSFGYIYsTiTZed8kgRvVUuo7hfjaU-HuTDEs6nTm4iFf2zGhliuEMwO7GtYsflylo
    R7B5TXGlkW-dOJcD5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduvddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BSFGYK1Qo6LK2XEqCxZGj6NKnTL33Qk-UMJcqrE_vJlcjReKuRXYtQ>
    <xmx:BSFGYAXQ_pNVGRPxIPAvpr1lz8eK5oNkTL3YPS-dJY95GFLXUkuULA>
    <xmx:BSFGYMWTyfX5By7Gpyn0KEosaqvieBhqvDStwGT8YP_3ytGJ3Tp6QA>
    <xmx:BiFGYFvUUOJ2p5eJEBBwBDyBU2iDb18EmublEiswCuuw1rt8PXl-CA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC4AF1080067;
        Mon,  8 Mar 2021 08:05:08 -0500 (EST)
Date:   Mon, 8 Mar 2021 14:05:06 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add power button
Message-ID: <20210308130506.v35gjviwknr5hat5@gilmour>
References: <20210306203611.15534-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4szwrawfeqkmi5l3"
Content-Disposition: inline
In-Reply-To: <20210306203611.15534-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4szwrawfeqkmi5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Mar 06, 2021 at 09:36:11PM +0100, Jernej Skrabec wrote:
> Beelink X2 has power button. Add node for it.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
> index 62b5280ec093..4a2cb072ecf6 100644
> --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> @@ -111,6 +111,17 @@ spdif_out: spdif-out {
>  		#sound-dai-cells =3D <0>;
>  		compatible =3D "linux,spdif-dit";
>  	};
> +
> +	r_gpio_keys {

Underscores are not valid for node names (and will trigger a dtc warning
when running with W=3D1).

> +		compatible =3D "gpio-keys";
> +
> +		power {
> +			label =3D "power";

IIRC the node name is used as a fallback when the label isn't there?

Maxime

--4szwrawfeqkmi5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEYhAgAKCRDj7w1vZxhR
xTDgAQDRXvOBl1TYBDH8zSGl5dcrPsYrG4gZr4LBHSTglKCp1AD9GK+sb8Plz5EL
6SkPwWPA+t5A9mv2WlDUOH4PAAEaNgI=
=09LB
-----END PGP SIGNATURE-----

--4szwrawfeqkmi5l3--
