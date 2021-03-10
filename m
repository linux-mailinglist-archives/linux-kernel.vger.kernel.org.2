Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2C33378F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhCJIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:41:03 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59411 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232378AbhCJIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:40:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id ACF435C011A;
        Wed, 10 Mar 2021 03:40:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Mar 2021 03:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4aFa8ajfrfPGsMoJ6jBruT/ef0k
        /BrtB121ENQhgRqs=; b=lvCqxqrBgD2OH6YcUh8VIANSBBliqX6juN0F7iyviO5
        1oKt9HE9jn3y/C+wRvzkHsG5dTNWhMQB7KyAhPtA4WMmtPStNk3oOWYl66/rxkNy
        5ZnuGJWwogjL8wDkxa0kE7UigEBEmP3t4U7gTHcfORYAhj/MJak7ZsnNDubjA1gJ
        O5tsRL2feNOpcR1LNuzgg5n3Wilu2xYjFovKq1d5fTaENJtQnpCflswz/BY1DlkA
        oWlw2mr0L/fE+fRfG34Bl3IBTB6rg7s5vrtsBijHaKxkLA5ZaH/3vFqUSKJWyNQQ
        jtNPbqQD9i5wpKYrRrpk9nIZIoCpBY2R2TsjFevjJ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4aFa8a
        jfrfPGsMoJ6jBruT/ef0k/BrtB121ENQhgRqs=; b=Tz/nthDkogD567Uyx4ij9t
        cu4P8ZTsDnIpAzRd/6ongJmdw1AFhCF+UEG7kZ5KwDh0d3Z9JplGaVSZeaMYWk1E
        36ZnhMCdTnuT1QaiLySGhgSccVsCJ3rkO6dvVrIsCag2TDtu5d9hmEC4+MehaSH1
        en8X17uCl+mLBuQJTrAvASR1d419cwSZan82My7QL8yAaPJvoFtdWEW3p2DnkpnD
        aW31kJ9yvHOX/aoscp8BWL+RDsYB5wleZenn1nlJuh8mq32vtTffNJpfHRXmxC8M
        QQF/flRKUwvxhwUHQHDN+mUbg40qigKzX0JYe3N741wftx/H6PEpK4KErKSDCwUA
        ==
X-ME-Sender: <xms:D4ZIYDtSK2qChVCViNGViZsR0xb7dGirih1wX2LYYcNbkB3ic5kVxQ>
    <xme:D4ZIYIv627nU8HOx9MkA5_d63LL6-x7dDjXXLCynKWLy148hCffRPCltsTrNftkdz
    G7PMs25HqCTAHaxY_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:D4ZIYBx8kQlCvBIQoAhtmTUj2I8BVpOKZD3BKs9035nHb8As2x7efA>
    <xmx:D4ZIYGgJQomVhog4i0cVVkyD4vg4DIxl1JZFL0ZXmvETSadVGh7C-w>
    <xmx:D4ZIYNAQBXrnYu0KoYgpklGCKZqLrpImT5HJBWDlXHUzBWVCuJWJ1A>
    <xmx:EIZIYKkYTjDfOPq5WQAiMQ5PA-stzU_v5okASlcEIQmzxDcLztt07Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60A65240054;
        Wed, 10 Mar 2021 03:40:47 -0500 (EST)
Date:   Wed, 10 Mar 2021 09:40:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dts: r40: add second ethernet support
Message-ID: <20210310084044.gopd6hh5qbfhe7sk@gilmour>
References: <20210309012116.2944-1-boger@wirenboard.com>
 <20210309012116.2944-3-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4lnpgufg5h5jmxfr"
Content-Disposition: inline
In-Reply-To: <20210309012116.2944-3-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4lnpgufg5h5jmxfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 09, 2021 at 04:21:16AM +0300, Evgeny Boger wrote:
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
>  arch/arm/boot/dts/sun8i-r40.dtsi | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index d5ad3b9efd12..c31386e421b1 100644
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
> @@ -541,6 +555,33 @@
>  				drive-strength =3D <40>;
>  			};
> =20
> +			emac_pa_pins: emac-pa-pins {
> +				pins =3D "PA0", "PA1", "PA2",
> +				       "PA3", "PA4", "PA5", "PA6",
> +				       "PA7", "PA8", "PA9", "PA10",
> +				       "PA11", "PA12", "PA13", "PA14",
> +				       "PA15", "PA16";
> +				function =3D "emac";
> +			};
> +
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

I guess you forgot to remove that node?

Maxime

--4lnpgufg5h5jmxfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEiGDAAKCRDj7w1vZxhR
xRsKAQDQY/99RhS0OARN4qMmT2cMbn2EKyhjTO5RHm60LwcoVAEA83a8MXg06wW2
Y5Mq/YOkAYF4dwOPCstPyZHjZnwMRQ0=
=uU/P
-----END PGP SIGNATURE-----

--4lnpgufg5h5jmxfr--
