Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB263E294C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245372AbhHFLQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240038AbhHFLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:15:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 119EE601FD;
        Fri,  6 Aug 2021 11:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628248543;
        bh=wRWDcF2YvttmXXcK3mW0+9W5kfOoLugUDOW/UaWhK/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFfadV2wZfUfftS3tuNCS3lDCRxqy0SIxSA7Pd3Na7gyPSfqrr+73Q22PCgXbtowU
         BsmhB8kV1szXFyghUE8sotwL8y5F2LaQ9l+F9hRc4oxDLYN9QbFJWB4xFdS3Xykmzs
         ydsERGOAGgw56NIyrWtqpvdF/mSRSzEhPj5wo2LQQ3JsjB2rrnQxI+n2tJluq8qHoz
         eXOLxF0fI4XiRYT2ey8J2UpTzsCymIqUL2epYxRe45N31oZtMNJscdatxENnJesvya
         nMyJueJmj9inE8RcsrUqLYZc0lc9HU7EqdF+yMQdDNYNDEA1m806m/I6h5VAD8zpAS
         VFNj8KiBfOG+g==
Date:   Fri, 6 Aug 2021 16:45:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/7] phy: cdns-dphy: Add Rx support
Message-ID: <YQ0Z2wYQYAFn2KCY@matsya>
References: <20210624184108.21312-1-p.yadav@ti.com>
 <20210624184108.21312-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624184108.21312-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-21, 00:11, Pratyush Yadav wrote:
> The Cadence DPHY can be used to receive image data over the CSI-2
> protocol. Add support for Rx mode. The programming sequence differs from
> the Tx mode so it is added as a separate set of hooks to isolate the two
> paths.
> 
> The PHY is in Tx mode by default and it needs to be set in Rx mode by
> setting the submode to PHY_MIPI_DPHY_SUBMODE_RX in the set_mode()
> callback.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
> 
>  drivers/phy/cadence/cdns-dphy.c | 174 ++++++++++++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index 7d5f7b333893..7534ec957dc5 100644
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
> @@ -103,6 +130,22 @@ struct cdns_dphy_driver_data {
>  	const struct cdns_dphy_ops *rx;
>  };
>  
> +struct cdns_dphy_rx_band {
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +struct cdns_dphy_rx_band bands[] = {
> +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> +	{1750, 2000}, {2000, 2250}, {2250, 2500}
> +};
> +
> +int num_bands = ARRAY_SIZE(bands);
> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     struct phy_configure_opts_mipi_dphy *opts,
> @@ -312,6 +355,135 @@ static const struct cdns_dphy_ops tx_ref_dphy_ops = {
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
> +			return i;
> +	}
> +
> +	/* Unreachable. */
> +	WARN(1, "Reached unreachable code.");
> +	return -EINVAL;
> +}
> +
> +static int cdns_dphy_rx_wait_for_bit(void __iomem *addr, unsigned int bit)
> +{
> +	u32 val;
> +
> +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);

this looks wrong, val is not initialized, so what/when is condition to
be met..?
-- 
~Vinod
