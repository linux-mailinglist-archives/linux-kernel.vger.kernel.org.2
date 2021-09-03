Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981E2400188
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhICOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:52:24 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36255 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233407AbhICOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:52:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45DC058057C;
        Fri,  3 Sep 2021 10:51:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 03 Sep 2021 10:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1XMPe8iSVpVx8Cy4Rs+Zsn6BV24
        jRTi51ihDKEezAlg=; b=s54i0CSHC32QpU9LVaZenG7zxAeF9fqXlVzFb9rP/Jw
        GBVq8zthPFBL+qP8IAZEll5DMA6m6lbyxJYj0fLB4FnSNHnVnw682GrKhGrDyDsP
        C/1Ck/RmK6Wq/ARrEs0703xJc4ff2BH6gPP10Fgv2C2UrZfNuwoWmPjSAoj2bQ8T
        dHlaL/pPD02IZKdaF4wdLqYdc+4ADearbtA7gEA5saBTsMWYzVlzNV7gdE75gD9X
        AqpDMIaGl/iUB0zQwMII9rnVwycoSJEsl5xDYQF5biFkEKVYjUMLZjMO9aKwI4PM
        ZZZMD0Hi8h7h6x7gHb4DWaILUHZSiJexAcADdPrNj2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1XMPe8
        iSVpVx8Cy4Rs+Zsn6BV24jRTi51ihDKEezAlg=; b=q84fAIbt/P/TwRgtp63e8R
        7uk0bMq3ghd85bk2sN5Dz7RNvqW0E+qVR2/9vQ+9bqE849sm8hK8gmsaQ5/jKbyV
        yg5tU6GFTEYERyQXM4KAOaiiWRHnzxfE95GbyRjENF9AIzQX/PBcnotUP3ozA8Lp
        joDhvZKZfBVTwCf/dggUW7EaR/iiWnSHdOpdo7p/V8JsxZTVMwxV7KT2M5JaYDED
        VCvCrizRgmOHrVfPenpDj9dsKqIA5aHgrBLyePlF5kWyp9S0+GeCpP8PIUKsyePL
        Cuthulsqb8JKdyfZtvYxfOGq4s0rQkxHQrvEqw2ZvTd/wymlIV0EbkCNk2/EHX7A
        ==
X-ME-Sender: <xms:aTYyYXGLK_pCNLtPjvW2oKWopAtdZUOLblJqc_A_8f36kKVVfeWaYQ>
    <xme:aTYyYUUB9HXTRZqH_5raSIYEnDrPRmeCLMxjTNt17op9CV5YCpF3StETusi41lghJ
    _xXkVu70Qu1rwvhXD8>
X-ME-Received: <xmr:aTYyYZLgBGuTJMNEcOAAOOca-KTrKhQgM89Ka1gartveDZv-cHl6-V1mESq5djK8D8s2Cc7vfib6wJD9vrPN6UHP4qMSwj4FOgNe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aTYyYVE2Uto-gQ7Q-uZ3fogrGlrI3OMskZ66nckIH72_6E7n80Fd8g>
    <xmx:aTYyYdWqvV45M_m_e_srWttiUdlUX7nKlolnuqY7Ck2b3TFWdKWQSA>
    <xmx:aTYyYQO3f3GIDBIGkFUAQ3arNIA7zQDh_GaHjfxjGkUeUF7R4jYOpg>
    <xmx:ajYyYVSNFS15sbicpn_Z2xkpkhhI386TwXvOmcTHGbLd58ST1NsDmw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 10:51:21 -0400 (EDT)
Date:   Fri, 3 Sep 2021 16:51:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] [DO NOT MERGE] clk: sunxi-ng: Add support for H6
Message-ID: <20210903145120.lfb3dkq66m7fpfcv@gilmour>
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210901053951.60952-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uovaxtoufzzanesn"
Content-Disposition: inline
In-Reply-To: <20210901053951.60952-7-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uovaxtoufzzanesn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2021 at 12:39:50AM -0500, Samuel Holland wrote:
> H6 has IOSC calibration and an ext-osc32k input.
>=20
> H6 has the osc32k mux and the rtc-32k mux, but no fanout mux.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clk/sunxi-ng/sun50i-rtc-ccu.c | 49 +++++++++++++++++++++++++++
>  drivers/rtc/rtc-sun6i.c               | 17 ----------
>  2 files changed, 49 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c b/drivers/clk/sunxi-ng=
/sun50i-rtc-ccu.c
> index 1dfa05c2f0e9..9603dc0d3d7b 100644
> --- a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
> +++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
> @@ -227,6 +227,16 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(osc32k_fanout_cl=
k, "rtc-32k-fanout",
>  static SUNXI_CCU_M_FW_WITH_GATE(rtc_spi_clk, "rtc-spi", "ahb",
>  				0x310, 0, 5, BIT(31), 0);
> =20
> +static struct ccu_common *sun50i_h6_rtc_ccu_clks[] =3D {
> +	&iosc_clk,
> +	&iosc_32k_clk,
> +	&ext_osc32k_gate_clk.common,
> +	&osc32k_clk.common,
> +	&osc24M_32k_clk.common,
> +	&rtc_32k_mux_clk.common,
> +	&osc32k_fanout_clk.common,
> +};
> +
>  static struct ccu_common *sun50i_h616_rtc_ccu_clks[] =3D {
>  	&iosc_clk,
>  	&iosc_32k_clk,
> @@ -246,6 +256,21 @@ static struct ccu_common *sun50i_r329_rtc_ccu_clks[]=
 =3D {
>  	&rtc_spi_clk.common,
>  };
> =20
> +static struct clk_hw_onecell_data sun50i_h6_rtc_ccu_hw_clks =3D {
> +	.num =3D CLK_NUMBER,
> +	.hws =3D {
> +		[CLK_OSC32K]		=3D &osc32k_clk.common.hw,
> +		[CLK_OSC32K_FANOUT]	=3D &osc32k_fanout_clk.common.hw,
> +		[CLK_IOSC]		=3D &iosc_clk.hw,
> +
> +		[CLK_IOSC_32K]		=3D &iosc_32k_clk.hw,
> +		[CLK_EXT_OSC32K_GATE]	=3D &ext_osc32k_gate_clk.common.hw,
> +		[CLK_OSC24M_32K]	=3D &osc24M_32k_clk.common.hw,
> +		[CLK_RTC_32K]		=3D &rtc_32k_mux_clk.common.hw,
> +		[CLK_RTC_SPI]		=3D NULL,
> +	},
> +};
> +
>  static struct clk_hw_onecell_data sun50i_h616_rtc_ccu_hw_clks =3D {
>  	.num =3D CLK_NUMBER,
>  	.hws =3D {
> @@ -276,6 +301,13 @@ static struct clk_hw_onecell_data sun50i_r329_rtc_cc=
u_hw_clks =3D {
>  	},
>  };
> =20
> +static const struct sunxi_ccu_desc sun50i_h6_rtc_ccu_desc =3D {
> +	.ccu_clks	=3D sun50i_h6_rtc_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_rtc_ccu_clks),
> +
> +	.hw_clks	=3D &sun50i_h6_rtc_ccu_hw_clks,
> +};
> +
>  static const struct sunxi_ccu_desc sun50i_h616_rtc_ccu_desc =3D {
>  	.ccu_clks	=3D sun50i_h616_rtc_ccu_clks,
>  	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_h616_rtc_ccu_clks),
> @@ -318,6 +350,23 @@ static void __init sunxi_rtc_ccu_init(struct device_=
node *node,
>  	of_sunxi_ccu_probe(node, reg, desc);
>  }
> =20
> +static void __init sun50i_h6_rtc_ccu_setup(struct device_node *node)
> +{
> +	struct clk_init_data *init;
> +
> +	have_iosc_calib =3D 1;
> +
> +	/* Casting away the const from a pointer to a non-const anonymous objec=
t... */
> +	init =3D (struct clk_init_data *)osc32k_fanout_clk.common.hw.init;
> +
> +	/* Fanout only has one parent: osc32k. */
> +	init->num_parents =3D 1;
> +
> +	sunxi_rtc_ccu_init(node, &sun50i_h6_rtc_ccu_desc);
> +}

Indeed, that's not great.

Maybe we should just duplicate the sun50i_h6_rtc_ccu_desc (and
osc32k_fanout_clk) to cover both cases?

Maxime

--uovaxtoufzzanesn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTI2aAAKCRDj7w1vZxhR
xecbAP49H+UG4ucpEKF2f2+KbiVaGqfAk3QM8f3wrdf1wZDvggEA2UBSAM93M7QS
KdumcYrBi5U57kkpIAChWZxuy29cRAg=
=VzBj
-----END PGP SIGNATURE-----

--uovaxtoufzzanesn--
