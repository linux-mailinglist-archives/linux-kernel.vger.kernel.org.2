Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF46C3F4322
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhHWBiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhHWBiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:38:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977DBC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:38:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E30714A3;
        Mon, 23 Aug 2021 03:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629682688;
        bh=PP76d4HJZ4tmnoNU+amuBhKZukMUCE0j2k5zu4kAHFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHJx8k6Pi3Y4g2OzlwyoDmw47OSxMXigOs7WedhveJlArpaNpwx0vXukO54+wPXe4
         tX1kN4FwekJ4G98uos042UObkIKrtyG9i6iaD+blxVFBmisy64zThJTnOJNddtTjU1
         2JtDILnPNbqu/X3HfxiH0VM+2GaFd3bYjME0/hPo=
Date:   Mon, 23 Aug 2021 04:37:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YSL79vtTGsK+zwTQ@pendragon.ideasonboard.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820190346.18550-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Sat, Aug 21, 2021 at 12:33:42AM +0530, Pratyush Yadav wrote:
> The Cadence DPHY can be used to receive image data over the CSI-2
> protocol. Add support for Rx mode. The programming sequence differs from
> the Tx mode so it is added as a separate set of hooks to isolate the two
> paths. The mode in which the DPHY has to be used is selected based on
> the compatible.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v4:
> - Drop the submode parts. Use a different compatible for the Rx ops.
> - Make bands and num_bands static.
> 
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
> 
>  drivers/phy/cadence/cdns-dphy.c | 171 ++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index 0a169d649216..149fccdfad38 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -1,11 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright: 2017-2018 Cadence Design Systems, Inc.
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>

Alphabetical order please.

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
>  
>  #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
>  #define DPHY_CMN_SSM_EN			BIT(0)
> +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
>  #define DPHY_CMN_TX_MODE_EN		BIT(9)
> +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
>  
>  #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
>  #define DPHY_CMN_PWM_DIV(x)		((x) << 20)
> @@ -45,10 +52,27 @@
>  #define DPHY_CMN_OPDIV_FROM_REG		BIT(6)
>  #define DPHY_CMN_OPDIV(x)		((x) << 7)
>  
> +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> +
>  #define DPHY_PSM_CFG			DPHY_PCS(0x4)
>  #define DPHY_PSM_CFG_FROM_REG		BIT(0)
>  #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
>  
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
>  
> +#define DPHY_LANES_MIN			1
> +#define DPHY_LANES_MAX			4
> +
>  struct cdns_dphy_cfg {
>  	u8 pll_ipdiv;
>  	u8 pll_opdiv;
> @@ -98,6 +125,22 @@ struct cdns_dphy {
>  	struct phy *phy;
>  };
>  
> +struct cdns_dphy_rx_band {
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +static struct cdns_dphy_rx_band bands[] = {

static const

> +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> +	{1750, 2000}, {2000, 2250}, {2250, 2500}
> +};
> +
> +static int num_bands = ARRAY_SIZE(bands);

No need for a variable (which should be const otherwise), you can use
ARRAY_SIZE(bands) where needed.

> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     struct phy_configure_opts_mipi_dphy *opts,
> @@ -309,6 +352,132 @@ static const struct cdns_dphy_ops tx_ref_dphy_ops = {
>  	.set_psm_div = cdns_dphy_ref_set_psm_div,
>  };
>  
> +static int cdns_dphy_rx_power_on(struct cdns_dphy *dphy)
> +{
> +	/* Start RX state machine. */
> +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN |
> +	       FIELD_PREP(DPHY_CMN_RX_BANDGAP_TIMER_MASK,
> +			  DPHY_CMN_RX_BANDGAP_TIMER),
> +	       dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_power_off(struct cdns_dphy *dphy)
> +{
> +	writel(0, dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_get_band_ctrl(unsigned long hs_clk_rate)
> +{
> +	unsigned int rate;
> +	int i;

i is never negative, you can make it an unsigned int.

> +
> +	rate = hs_clk_rate / 1000000UL;
> +	/* Since CSI-2 clock is DDR, the bit rate is twice the clock rate. */
> +	rate *= 2;
> +
> +	if (rate < bands[0].min_rate || rate >= bands[num_bands - 1].max_rate)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < num_bands; i++) {
> +		if (rate >= bands[i].min_rate && rate < bands[i].max_rate)

You can replace this with

		if (rate < bands[i].max_rate)

as the bands are in increasing order.

> +			return i;
> +	}
> +
> +	/* Unreachable. */
> +	WARN(1, "Reached unreachable code.");
> +	return -EINVAL;

That's not very nice.

As a clock rate higher than the maximum isn't supposed to happen, you
could drop that initial check (it won't affect performance) and return
-EOPNOTSUPP here without a WARN().

> +}
> +
> +static int cdns_dphy_rx_wait_for_bit(void __iomem *addr, unsigned int bit)
> +{
> +	u32 val;
> +
> +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);

A busy wait for one second is quite long. How long does it typically
take for the condition to be true ?

> +}
> +
> +static int cdns_dphy_rx_wait_lane_ready(struct cdns_dphy *dphy, int lanes)

lanes should be an unsigned int.

> +{
> +	void __iomem *reg = dphy->regs;

You can use dphy->regs directly in the code below.

> +	u32 data_lane_ctrl[] = {DPHY_ISO_DL_CTRL_L0, DPHY_ISO_DL_CTRL_L1,
> +				DPHY_ISO_DL_CTRL_L2, DPHY_ISO_DL_CTRL_L3};

static const, and move it first in the function.

> +	int ret, i;

i is never negative here either.

> +
> +	/* Data lanes. Minimum one lane is mandatory. */
> +	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
> +		return -EINVAL;
> +
> +	/* Clock lane */
> +	ret = cdns_dphy_rx_wait_for_bit(reg + DPHY_ISO_CL_CTRL_L,
> +					DPHY_ISO_LANE_READY_BIT);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < lanes; i++) {
> +		ret = cdns_dphy_rx_wait_for_bit(reg + data_lane_ctrl[i],
> +						DPHY_ISO_LANE_READY_BIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_configure(struct cdns_dphy *dphy,
> +				  union phy_configure_opts *opts)
> +{
> +	unsigned int reg;
> +	int band_ctrl, ret;
> +
> +	band_ctrl = cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (band_ctrl < 0)
> +		return band_ctrl;
> +
> +	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
> +	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
> +	writel(reg, dphy->regs + DPHY_BAND_CFG);
> +
> +	/*
> +	 * Set the required power island phase 2 time. This is mandated by DPHY
> +	 * specs.
> +	 */
> +	reg = DPHY_POWER_ISLAND_EN_DATA_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_DATA);
> +	reg = DPHY_POWER_ISLAND_EN_CLK_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_CLK);
> +
> +	ret = cdns_dphy_rx_wait_lane_ready(dphy, opts->mipi_dphy.lanes);
> +	if (ret) {
> +		dev_err(dphy->dev, "DPHY wait for lane ready timeout\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_validate(struct cdns_dphy *dphy, enum phy_mode mode,
> +				 int submode, union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	ret = cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +}
> +
> +static const struct cdns_dphy_ops rx_ref_dphy_ops = {
> +	.power_on = cdns_dphy_rx_power_on,
> +	.power_off = cdns_dphy_rx_power_off,
> +	.configure = cdns_dphy_rx_configure,
> +	.validate = cdns_dphy_rx_validate,
> +};
> +
>  static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
>  			      union phy_configure_opts *opts)
>  {
> @@ -421,6 +590,7 @@ static int cdns_dphy_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id cdns_dphy_of_match[] = {
>  	{ .compatible = "cdns,dphy", .data = &tx_ref_dphy_ops },
> +	{ .compatible = "cdns,dphy-rx", .data = &rx_ref_dphy_ops },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, cdns_dphy_of_match);
> @@ -436,5 +606,6 @@ static struct platform_driver cdns_dphy_platform_driver = {
>  module_platform_driver(cdns_dphy_platform_driver);
>  
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
>  MODULE_DESCRIPTION("Cadence MIPI D-PHY Driver");
>  MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
