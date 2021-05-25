Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C269938FC24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhEYIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:09:35 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57745 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhEYIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:08:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 27F1D135E;
        Tue, 25 May 2021 04:06:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 May 2021 04:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=8k3ZcwwCrUhnCAPBECI4Cdp3Eo2
        +fjctzRPcl25CSiY=; b=MtpM8SBtS0koCHlQP26V5ZRF8afylL8Ih62Bx8OpvwP
        +4NfyRi2WaGU5RQybD5SHgo6GizLItLDpv8h6Gx9b3Z3xBQAy6GYfst3p/i3DVGS
        EXRU481ySpmTbWi4Aq+6M63Csgf52Y25hsgVib4K3DAnnzLKlyaAJ0dmKo7K/Uq6
        WUWwDi6WtSI/zw2B+WEYekRg/EbZ5AzyakNQmoUSh21hvDvDwx8owPer1Q5hc1WD
        q2DFuhy+IIDcXu+xo26bl5kVax8hfCP/6JFyeif+XpdoZe6TJzzi3cHwUntzl1be
        Ah3WMj2fpmKxAMLuXBVbss67oA0NWb3RxfaTgVbJ7EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8k3Zcw
        wCrUhnCAPBECI4Cdp3Eo2+fjctzRPcl25CSiY=; b=NgP8PG/QciXN5ywZ+OXQ7x
        kCwIEa2LdEw+mjPMq22zV54kk74GqJfyJqiW9jj+TEMTG4Jyh0dt62sn16rJzYSI
        eSjOnuHKvijGbVEsgL8NV/9jmZluz2RWQhHViQbWv47GYCorggL5dtMc2svklpAb
        dYwaGJQzCtH8V0BkAVJLAHbrsn227jw3DTC1sv1PMnXMiNw4LzFJRuvPBVDSxM8i
        orrAMfP3UfohU7yapahlfuDQE8aOTJyNmntbXf8+JO2p37454/AcFgPPyg7iEZWH
        gUUTMJqMg8/Q3eWw14J9zIxJiDjw7QIjtFRg86eY3gz/HPmwMbW3AM1Pew4a371A
        ==
X-ME-Sender: <xms:AbCsYHkn0S3JlCpdQVwYRrTdNjwfL0JpJ7ZIzxmrpNyYCQZ6MWGJHQ>
    <xme:AbCsYK2gBgX6k_3VKu7XbONtkm5T2h1cgGChjF6AUOu0xkEpggHo0IJ_kjjNAEo2n
    EghfAApcM8F82uaiXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdektddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AbCsYNovCjXyrRd2MR_bSqCtYWjkk6NSFyRpC55sn12TTYythBLNDQ>
    <xmx:AbCsYPmnLyrDbK4rfAgkKSZOWcyifpeOyl1SXWGaeCavC9NtWjXXvQ>
    <xmx:AbCsYF3_A8vPmXuoIbQ5NnueIJGnvZ8MBePhBnPPXey_gTtvQWsIbw>
    <xmx:AbCsYDC7Wg8ujZfnzAnfanOoJXXSbjNLmdO2EX1AzLpOufejoQEsTA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 04:06:24 -0400 (EDT)
Date:   Tue, 25 May 2021 10:06:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andreas Rehn <rehn.andreas86@gmail.com>
Cc:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i: v3s: enable emac for zero Dock
Message-ID: <20210525080621.m7qpnfdarkrg3vn5@gilmour>
References: <20210522205039.179486-1-rehn.andreas86@gmail.com>
 <20210522222329.192367-1-rehn.andreas86@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t7yycpvode2l6eut"
Content-Disposition: inline
In-Reply-To: <20210522222329.192367-1-rehn.andreas86@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7yycpvode2l6eut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Sun, May 23, 2021 at 12:23:29AM +0200, Andreas Rehn wrote:
> dwmac-sun8i supports v3s and
> Licheepi-zero Dock provides an ethernet port
>=20
> Signed-off-by: Andreas Rehn <rehn.andreas86@gmail.com>
> ---
> Changes in v2:
> 	- add ethernet0 alias.
>=20
>  arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/ar=
m/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> index db5cd0b8574b..4d564028f286 100644
> --- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> +++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> @@ -49,6 +49,10 @@ / {
>  	compatible =3D "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
>  		     "allwinner,sun8i-v3s";
> =20
> +	aliases {
> +		ethernet0 =3D &emac;
> +	};
> +
>  	leds {
>  		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
>  		status =3D "disabled";
> @@ -94,3 +98,8 @@ button-800 {
>  		voltage =3D <800000>;
>  	};
>  };
> +
> +&emac {
> +	allwinner,leds-active-low;
> +	status =3D "okay";
> +};

We use alphabetical order for phandle derefences

Maxime

--t7yycpvode2l6eut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKyv/QAKCRDj7w1vZxhR
xewJAQDXELCjkFOUxFRq2pu+bL1yfeskQnRSjBNxlX8qnVgjwAEA30NEfJ6zUiK7
BoYFguB7rqGtXysSCn3SSnVzsEFMzQc=
=85T9
-----END PGP SIGNATURE-----

--t7yycpvode2l6eut--
