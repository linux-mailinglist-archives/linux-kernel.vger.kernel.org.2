Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178DB32A3C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379095AbhCBJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:28 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57203 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837941AbhCBJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:15:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FA445C01A5;
        Tue,  2 Mar 2021 04:14:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Mar 2021 04:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=A9mpeix8eIp2s1AceaFq/lclm0J
        BGCKdgDe9/or40Kg=; b=dyeSZxf5f31DgJriNDJSMv0u9comdhk0hWwyrx61M8d
        1RlI0b2um4bsNnbjEanyukBF2VKDEsGEZG1RuxC84iU5qhAB71vz8D8Gp/gY3dLj
        RaDgr+bjIGfF+6x2PkRS0iHEdyf3NhkXPKxdGI9Zikzq5VRFo3Yxs82SzTeRqNJE
        2FFUpkKrf957i6Au2fv8NpMWqSM2xcXnYQs7dGQ4dOAk/FL98PEc/Ijn7kTsk2Vr
        w9gBHIKYUrtVgepFavxe7TRQlbRntYBY13p3vkxoBYO3kPKI5w0JRLxINg6VBnRp
        0ylNqW2eRgoRUYxdLHcbiTyy4KfRUl48VsWOPj2p19g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=A9mpei
        x8eIp2s1AceaFq/lclm0JBGCKdgDe9/or40Kg=; b=Kbi5wDpbLPLm+5PfnDZulN
        0Lph8igiPRWZBZi5+sH5Au4ODaRJn16pXm7vtLLdWofN9jJiD+xMAzPLS8Ed/UDq
        0Ds1ULdOZ/Pd/JZbrmePwftTBT/mGnYVqzV55OS/xgh1oRx2sBtJRnb9DE/L1TJ4
        pgtm5xFrVMynDYf1SbymEPPMgrXvRi6cSaITuPWvfcQIvHAyNTjx4ZxgNv1Wg2Nj
        Ie+9fsfBq6ml7/GfLh2H6V4soz5W9yTiO7QsVz1lQwQK8OBBQoT9HG6njgD/x67A
        HP19CQ0Un9j6vMF1wxWCp8Q5M7jfVWvNOBMoyRx9SrJZz8HZnyhb5pD37+RaGeWA
        ==
X-ME-Sender: <xms:6AE-YIU39d8I3at4BDPpEiF0y4Tdw9m4WuzBQ9f59b08ws4GnuP96A>
    <xme:6AE-YMk93HdvV1LINiG_1Ur3M44QEyxGN7nicG7KhS-syMs7Q-wSWcsXBHR1aVMjF
    uk8sGVUn4_X-DGSJ4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddttdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeguden
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6AE-YMY89SLk7QD-vXU5mdDWft9nArTnJJOzRV4vjtXTpfiX7z6s0A>
    <xmx:6AE-YHUwcDahD6PMHGjh3SSxg88Q_kJ98nafkV7D9D6Abjbhhgefhg>
    <xmx:6AE-YCmEbVdodUI0j-yGSUmXGIT-ZH8APbJ1DdFsog19U4Xx_0K45Q>
    <xmx:6QE-YDDxo2XIht_QRR7gwjudoVMiY1IH-RNo60IxnLFXht4v29auTg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69C6824005C;
        Tue,  2 Mar 2021 04:14:16 -0500 (EST)
Date:   Tue, 2 Mar 2021 10:14:14 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: V3/S3: add i2s peripheral
Message-ID: <20210302091414.ueqgrrb6fnkev423@gilmour>
References: <20210226103028.729172-1-t.schramm@manjaro.org>
 <20210226103028.729172-4-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xz7e52sol4iuhn2p"
Content-Disposition: inline
In-Reply-To: <20210226103028.729172-4-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xz7e52sol4iuhn2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 26, 2021 at 11:30:28AM +0100, Tobias Schramm wrote:
> The V3 and S3 SoCs feature an i2s peripheral identical to that of the H3.
> Add it to the dts.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Why is it added to the v3 DTSI and not the global one?

> ---
>  arch/arm/boot/dts/sun8i-v3.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3=
=2Edtsi
> index c279e13583ba..17ea6b8f091f 100644
> --- a/arch/arm/boot/dts/sun8i-v3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3.dtsi
> @@ -30,3 +30,18 @@ uart1_pg_pins: uart1-pg-pins {
>  		function =3D "uart1";
>  	};
>  };
> +
> +&soc {

You don't need a label for that, you can just put it under / { soc {

> +		i2s0: i2s@1c22000 {
> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,sun8i-h3-i2s";

We should also have a v3 specific compatible here in addition to the H3
(and document it in the bindings).

Maxime

--xz7e52sol4iuhn2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYD4B5gAKCRDj7w1vZxhR
xUu/AQCuOWEK7caX1VDLjoJIm0vhVD4eR1diftDPaIkE/qnDvgD/QeIJImkxu0FR
vBYEx/1tkyYo8qzFb5WXZ5Bsj6SYOAI=
=JV2a
-----END PGP SIGNATURE-----

--xz7e52sol4iuhn2p--
