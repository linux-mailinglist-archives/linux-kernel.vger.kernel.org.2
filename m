Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD03540D750
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhIPKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:24:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34085 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhIPKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:24:19 -0400
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7A71F40004;
        Thu, 16 Sep 2021 10:22:55 +0000 (UTC)
Date:   Thu, 16 Sep 2021 12:22:54 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YUMa/ocoQ9l3JDe6@aptenodytes>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bd8Tu5xeLZcdEGbq"
Content-Disposition: inline
In-Reply-To: <20210902185543.18875-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bd8Tu5xeLZcdEGbq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> The Cadence DPHY can be used to receive image data over the CSI-2
> protocol. Add support for Rx mode. The programming sequence differs from
> the Tx mode so it is added as a separate set of hooks to isolate the two
> paths. The mode in which the DPHY has to be used is selected based on
> the compatible.

I just realized that I didn't follow-up on a previous revision on the debate
about using the phy sub-mode to distinguish between rx/tx.

I see that you've been using a dedicated compatible, but I'm not sure this =
is a
good fit either. My understanding is that the compatible should describe a =
group
of register-compatible revisions of a hardware component, not how the hardw=
are
is used specifically. I guess the distinction between rx/tx falls under
the latter rather than the former.

I just sent out a patch in my Allwinner MIPI CSI-2+ISP series adding
a specific direction property:
- https://lists.infradead.org/pipermail/linux-phy/2021-September/001420.html
- https://lists.infradead.org/pipermail/linux-phy/2021-September/001421.html

Which I feel is a more appropriate solution to implement the distinction.

What do you think?

Cheers,

Paul
=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>=20
> ---
>=20
> Changes in v5:
> - Use the new cdns_dphy_info to specify PHY ops.
> - Re-order include in alphabetical order.
> - Make bands const.
> - Drop num_bands.
> - Make i, lanes unsigned.
> - Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
>   complete and return -EOPNOTSUPP when we reach the end.
> - Drop the "rate < bands[i].min_rate" check since the bands are in
>   ascending order.
> - Move data_lane_ctrl to start of function and make it static const.
>=20
> Changes in v4:
> - Drop the submode parts. Use a different compatible for the Rx ops.
> - Make bands and num_bands static.
>=20
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
>=20
>  drivers/phy/cadence/cdns-dphy.c | 182 ++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>=20
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-d=
phy.c
> index e2c2b27c6539..9a4c1c684e9a 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -1,11 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright: 2017-2018 Cadence Design Systems, Inc.
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.co=
m/
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -25,10 +28,14 @@
>  #define DPHY_PMA_RCLK(reg)		(0x600 + (reg))
>  #define DPHY_PMA_RDATA(lane, reg)	(0x700 + ((lane) * 0x100) + (reg))
>  #define DPHY_PCS(reg)			(0xb00 + (reg))
> +#define DPHY_ISO(reg)			(0xc00 + (reg))
> =20
>  #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
>  #define DPHY_CMN_SSM_EN			BIT(0)
> +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
>  #define DPHY_CMN_TX_MODE_EN		BIT(9)
> +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
> =20
>  #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
>  #define DPHY_CMN_PWM_DIV(x)		((x) << 20)
> @@ -45,10 +52,27 @@
>  #define DPHY_CMN_OPDIV_FROM_REG		BIT(6)
>  #define DPHY_CMN_OPDIV(x)		((x) << 7)
> =20
> +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> +
>  #define DPHY_PSM_CFG			DPHY_PCS(0x4)
>  #define DPHY_PSM_CFG_FROM_REG		BIT(0)
>  #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
> =20
> +#define DPHY_POWER_ISLAND_EN_DATA	DPHY_PCS(0x8)
> +#define DPHY_POWER_ISLAND_EN_DATA_VAL	0xaaaaaaaa
> +#define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
> +#define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> +
> +#define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
> +#define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
> +#define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> +#define DPHY_ISO_DL_CTRL_L2		DPHY_ISO(0x30)
> +#define DPHY_ISO_DL_CTRL_L3		DPHY_ISO(0x3c)
> +#define DPHY_ISO_LANE_READY_BIT		0
> +#define DPHY_ISO_LANE_READY_TIMEOUT_MS	100UL
> +
>  #define DSI_HBP_FRAME_OVERHEAD		12
>  #define DSI_HSA_FRAME_OVERHEAD		14
>  #define DSI_HFP_FRAME_OVERHEAD		6
> @@ -57,6 +81,9 @@
>  #define DSI_NULL_FRAME_OVERHEAD		6
>  #define DSI_EOT_PKT_SIZE		4
> =20
> +#define DPHY_LANES_MIN			1
> +#define DPHY_LANES_MAX			4
> +
>  struct cdns_dphy_cfg {
>  	u8 pll_ipdiv;
>  	u8 pll_opdiv;
> @@ -105,6 +132,20 @@ struct cdns_dphy {
>  	struct phy *phy;
>  };
> =20
> +struct cdns_dphy_rx_band {
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +static const struct cdns_dphy_rx_band bands[] =3D {
> +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> +	{1750, 2000}, {2000, 2250}, {2250, 2500}
> +};
> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     struct phy_configure_opts_mipi_dphy *opts,
> @@ -360,6 +401,145 @@ static const struct cdns_dphy_info tx_ref_info =3D {
>  	.tx_ops =3D &tx_ref_dphy_ops,
>  };
> =20
> +static int cdns_dphy_rx_power_on(struct phy *phy)
> +{
> +	struct cdns_dphy *dphy =3D phy_get_drvdata(phy);
> +
> +	/* Start RX state machine. */
> +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN |
> +	       FIELD_PREP(DPHY_CMN_RX_BANDGAP_TIMER_MASK,
> +			  DPHY_CMN_RX_BANDGAP_TIMER),
> +	       dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_power_off(struct phy *phy)
> +{
> +	struct cdns_dphy *dphy =3D phy_get_drvdata(phy);
> +
> +	writel(0, dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_get_band_ctrl(unsigned long hs_clk_rate)
> +{
> +	unsigned int rate, i;
> +
> +	rate =3D hs_clk_rate / 1000000UL;
> +	/* Since CSI-2 clock is DDR, the bit rate is twice the clock rate. */
> +	rate *=3D 2;
> +
> +	if (rate < bands[0].min_rate)
> +		return -EOPNOTSUPP;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(bands); i++) {
> +		if (rate < bands[i].max_rate)
> +			return i;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int cdns_dphy_rx_wait_for_bit(void __iomem *addr, unsigned int bi=
t)
> +{
> +	u32 val;
> +
> +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);
> +}
> +
> +static int cdns_dphy_rx_wait_lane_ready(struct cdns_dphy *dphy,
> +					unsigned int lanes)
> +{
> +	static const u32 data_lane_ctrl[] =3D {DPHY_ISO_DL_CTRL_L0,
> +					     DPHY_ISO_DL_CTRL_L1,
> +					     DPHY_ISO_DL_CTRL_L2,
> +					     DPHY_ISO_DL_CTRL_L3};
> +	void __iomem *reg =3D dphy->regs;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Data lanes. Minimum one lane is mandatory. */
> +	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
> +		return -EINVAL;
> +
> +	/* Clock lane */
> +	ret =3D cdns_dphy_rx_wait_for_bit(reg + DPHY_ISO_CL_CTRL_L,
> +					DPHY_ISO_LANE_READY_BIT);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < lanes; i++) {
> +		ret =3D cdns_dphy_rx_wait_for_bit(reg + data_lane_ctrl[i],
> +						DPHY_ISO_LANE_READY_BIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_configure(struct phy *phy,
> +				  union phy_configure_opts *opts)
> +{
> +	struct cdns_dphy *dphy =3D phy_get_drvdata(phy);
> +	unsigned int reg;
> +	int band_ctrl, ret;
> +
> +	band_ctrl =3D cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (band_ctrl < 0)
> +		return band_ctrl;
> +
> +	reg =3D FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
> +	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
> +	writel(reg, dphy->regs + DPHY_BAND_CFG);
> +
> +	/*
> +	 * Set the required power island phase 2 time. This is mandated by DPHY
> +	 * specs.
> +	 */
> +	reg =3D DPHY_POWER_ISLAND_EN_DATA_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_DATA);
> +	reg =3D DPHY_POWER_ISLAND_EN_CLK_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_CLK);
> +
> +	ret =3D cdns_dphy_rx_wait_lane_ready(dphy, opts->mipi_dphy.lanes);
> +	if (ret) {
> +		dev_err(dphy->dev, "DPHY wait for lane ready timeout\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_validate(struct phy *phy, enum phy_mode mode,
> +				 int submode, union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	if (mode !=3D PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	ret =3D cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +}
> +
> +static const struct phy_ops rx_ref_phy_ops =3D {
> +	.power_on =3D cdns_dphy_rx_power_on,
> +	.power_off =3D cdns_dphy_rx_power_off,
> +	.configure =3D cdns_dphy_rx_configure,
> +	.validate =3D cdns_dphy_rx_validate,
> +};
> +
> +static const struct cdns_dphy_info rx_ref_info =3D {
> +	.phy_ops =3D &rx_ref_phy_ops,
> +};
> +
>  static int cdns_dphy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
> @@ -417,6 +597,7 @@ static int cdns_dphy_remove(struct platform_device *p=
dev)
> =20
>  static const struct of_device_id cdns_dphy_of_match[] =3D {
>  	{ .compatible =3D "cdns,dphy", .data =3D &tx_ref_info },
> +	{ .compatible =3D "cdns,dphy-rx", .data =3D &rx_ref_info },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, cdns_dphy_of_match);
> @@ -432,5 +613,6 @@ static struct platform_driver cdns_dphy_platform_driv=
er =3D {
>  module_platform_driver(cdns_dphy_platform_driver);
> =20
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
>  MODULE_DESCRIPTION("Cadence MIPI D-PHY Driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.33.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Bd8Tu5xeLZcdEGbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmFDGv4ACgkQ3cLmz3+f
v9GWUgf/e7Ws3n2t3VUskH++a+unsKBA07AoxAvmm3MVdB8F2RKYTxMvDy0plU/G
ouM+iKEWKsa7sar7tKDLYGPzy/nuCaOt+pj9zETbwhdHHJf6Bxuzc9iyi/pscZvi
F5QaLbpNW3Yb0HZ157WSz4crYTlRgtua6h3vLwObQTPYeAbRHM3oarVfs5wRBT0h
OLwFle5wsCpXu6yqstxsrb7meEhykRNY8wDFt217ZohiO6yrTKKmp5wIYDjEiIEL
T1Zxroeprbl2QzFqZbbu3GfKe4EXbjqFwWPBqjeNZGp/34/B7n8MA/j2af/Z5xZw
c2FFSAeYAXronv8pKyWK+5eGETsm3w==
=BPwq
-----END PGP SIGNATURE-----

--Bd8Tu5xeLZcdEGbq--
