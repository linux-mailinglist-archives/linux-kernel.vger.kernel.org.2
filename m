Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2302330F87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:38:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47923 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbhCHNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:37:46 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ACD1A5C0098;
        Mon,  8 Mar 2021 08:37:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 08 Mar 2021 08:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=WBVCPi5PmoCTdGe9hSGYzB8eCvh
        vs5Ao6fKxix7rZQo=; b=jn86cugEKatv/md99Q08cuqt/LdWc+VsCzybH/iKhLu
        sGNUmfQ0GuPwFodT0E63MWiF8dcvhyi2EJtneoOSmiVpNqOMwlci02aQt6i8AWus
        xKFXaDYSXzNo7TTuSAAXNHc/6Mj+D9IcocwUK2TFpAsNFqnOEy3SjtvZQ6SNzD7g
        egaJ13f9SwAqz0pkBwwtjB6lyy7yOYT8d9z/jpV9cshw8/D8xFqyZBiZB2GIc3jL
        t/zkYDWa69GXvLMtVF/9JrDRERVsy7SQrty6NuscJKq8gE7rVnC3R2vR32csDIzr
        gLPM6owinquafTKdegprcfu0McU3xXCYfUyivxDuw1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WBVCPi
        5PmoCTdGe9hSGYzB8eCvhvs5Ao6fKxix7rZQo=; b=q0ejFnep/TuyNEu+5WKp2L
        2uLNWGI0Az7gqPSats3kzgPzZIKT7sDleK6lL2VTG4idb1wpEQwvfYT+7G3uipI8
        jmlfhvYzIsn/6DuSpoiRf29OFfqLfUc/uiJwNp9wp3Wc7+gBO9D/PVNdGTZmwg4p
        pTHLLcOBSBgGx0PJosjhtOkS3nmM3eHXGSyXLAER7BpucqfU55/pnJFFMADvIIfG
        Y5eaHpeytmC/0qknd6CTLKxb/oZjwhAy9eDxxfMvOBJgpFXEKIL8w4XBg7ZxesBl
        ZvqqL6DTnNN2sp3g2Z8R/aew7ogkdEAhXZFyZvELDH9UPOUqsECsdTrbQGFHw5EQ
        ==
X-ME-Sender: <xms:qShGYFfClr9aYiD5J4WGSAhfpHkLPQ6cVjBOHgkJosRxwnJfMZuq2A>
    <xme:qShGYDMF9eeoXUfovyFwnz8zM7dnItfiZ2RUyngsnWFXG6jzT9fTMLJWDaMFAFRKn
    6ItgWoyytv9_iPB3cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qShGYOhgY-LdLQtQmxYpS92I3JzLOt4dNsg-mH9nXZKwPC5pCfzDJQ>
    <xmx:qShGYO8eJHhZxi8pLrTT35MqI72XJHNOsjVABxsjIk6e9NOKyiwSpA>
    <xmx:qShGYBuqw51bcSdUitbcPyc3NVsa2EVySfDkyu5Edoa363UHYX9I0A>
    <xmx:qShGYJL6q7uDvxVGwcYzL3RDlgnsNFhwAZyjTfkY-ZTMS5Ze8riUaQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D25E1080066;
        Mon,  8 Mar 2021 08:37:45 -0500 (EST)
Date:   Mon, 8 Mar 2021 14:37:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dts: r40: add second ethernet support
Message-ID: <20210308133743.ms6wjwe5imp66c6i@gilmour>
References: <20210307031353.12643-1-boger@wirenboard.com>
 <20210307031353.12643-4-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ac2tlcqnmh2mazsi"
Content-Disposition: inline
In-Reply-To: <20210307031353.12643-4-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ac2tlcqnmh2mazsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 07, 2021 at 06:13:53AM +0300, Evgeny Boger wrote:
> R40 (aka V40, A40i, T3) has two different Ethernet IP
> called EMAC and GMAC.
> EMAC only support 10/100 Mbit in MII mode,
> while GMAC support both 10/100 (MII) and 10/100/1000 (RGMII).
>=20
> In contrast to A10/A20 where GMAC and EMAC share the same pins
> making EMAC somewhat pointless, on R40 EMAC can be routed to port H.
> Both EMAC (on port H) and GMAC (on port A)
>  can be then enabled at the same time, allowing for two ethernet ports.
>=20
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 53 ++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index d5ad3b9efd12..c102c1510012 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -217,6 +217,20 @@
>  			#size-cells =3D <1>;
>  			ranges;
> =20
> +			sram_a: sram@0 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x00000000 0xc000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x00000000 0xc000>;
> +
> +				emac_sram: sram-section@8000 {
> +					compatible =3D "allwinner,sun4i-a10-sram-a3-a4";
> +					reg =3D <0x8000 0x4000>;
> +					status =3D "okay";
> +				};
> +			};
> +
>  			sram_c: sram@1d00000 {
>  				compatible =3D "mmio-sram";
>  				reg =3D <0x01d00000 0xd0000>;
> @@ -541,6 +555,24 @@
>  				drive-strength =3D <40>;
>  			};
> =20
> +			emac_ph_pins: emac-ph-pins {
> +				pins =3D "PH8", "PH9", "PH10", "PH11",
> +				       "PH14", "PH15", "PH16", "PH17",
> +				       "PH18","PH19", "PH20", "PH21",
> +				       "PH22", "PH23", "PH24", "PH25",
> +				       "PH26", "PH27";
> +				function =3D "emac";
> +			};
> +
> +			emac_pa_pins: emac-pa-pins {
> +				pins =3D "PA0", "PA1", "PA2",
> +				       "PA3", "PA4", "PA5", "PA6",
> +				       "PA7", "PA8", "PA9", "PA10",
> +				       "PA11", "PA12", "PA13", "PA14",
> +				       "PA15", "PA16";
> +				function =3D "emac";
> +			};
> +

These nodes should be order alphabetically=20

>  			i2c0_pins: i2c0-pins {
>  				pins =3D "PB0", "PB1";
>  				function =3D "i2c0";
> @@ -885,6 +917,27 @@
>  			};
>  		};
> =20
> +		emac: ethernet@1c0b000 {
> +			syscon =3D <&ccu>;

Why is the syscon needed? You weren't using it in the driver

> +			compatible =3D "allwinner,sun4i-a10-emac";
> +			reg =3D <0x01c0b000 0x1000>;
> +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_EMAC>;
> +			resets =3D <&ccu RST_BUS_EMAC>;
> +			allwinner,sram =3D <&emac_sram 1>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&emac_ph_pins>;

If there's several options, we really can't enforce a default here, it
should be in the board DTS.

Maxime

--ac2tlcqnmh2mazsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEYopwAKCRDj7w1vZxhR
xaV3AQC2XbzI4nlth+M6nE02j/KBAzmHjbxTC/Z8lHhApU5eNQD/QTzUwsfA4kar
muaoKkX7SG4ZyXNcgr9Psi5jMZXJHAg=
=fu/I
-----END PGP SIGNATURE-----

--ac2tlcqnmh2mazsi--
