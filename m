Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E703E96E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhHKReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:34:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38232 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:34:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BHXd6Q065439;
        Wed, 11 Aug 2021 12:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628703219;
        bh=jCRIDe9QQKhtLw6g6OT1V4EEeU0fj0X1geCk79hTYi8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=y/IEQjAQuGU4HkasYthDYpgPyTF8LehdSxGG0HgdOIrSPix6MW1KEn5ieL4argU5/
         1zJmB097AAYAlfvPemnecablD2yjgoK2GVUoegsVpbJjV3bACEHa64zJq/CRSyffif
         Emv5HXoSwuZd0bDNKXr+rF90YdkxCKgwxTjaCtG8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BHXdw5085739
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 12:33:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 12:33:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 12:33:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BHXbwu104060;
        Wed, 11 Aug 2021 12:33:38 -0500
Date:   Wed, 11 Aug 2021 23:03:37 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v3 4/7] phy: cdns-dphy: Add Rx support
Message-ID: <20210811173335.ndrlzgepradfj4ij@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
 <20210624184108.21312-5-p.yadav@ti.com>
 <YQ0Z2wYQYAFn2KCY@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YQ0Z2wYQYAFn2KCY@matsya>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 04:45PM, Vinod Koul wrote:
> On 25-06-21, 00:11, Pratyush Yadav wrote:
> > The Cadence DPHY can be used to receive image data over the CSI-2
> > protocol. Add support for Rx mode. The programming sequence differs from
> > the Tx mode so it is added as a separate set of hooks to isolate the two
> > paths.
> > 
> > The PHY is in Tx mode by default and it needs to be set in Rx mode by
> > setting the submode to PHY_MIPI_DPHY_SUBMODE_RX in the set_mode()
> > callback.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - Use a table to select the band.
> > - Use a table to poll the data lane ready bits.
> > - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
> >   clock is DDR.
> > 
> >  drivers/phy/cadence/cdns-dphy.c | 174 ++++++++++++++++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> > 
> > diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> > index 7d5f7b333893..7534ec957dc5 100644
> > --- a/drivers/phy/cadence/cdns-dphy.c
> > +++ b/drivers/phy/cadence/cdns-dphy.c
> > @@ -1,11 +1,14 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * Copyright: 2017-2018 Cadence Design Systems, Inc.
> > + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> >   */
> >  
> >  #include <linux/bitops.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > @@ -25,10 +28,14 @@
> >  #define DPHY_PMA_RCLK(reg)		(0x600 + (reg))
> >  #define DPHY_PMA_RDATA(lane, reg)	(0x700 + ((lane) * 0x100) + (reg))
> >  #define DPHY_PCS(reg)			(0xb00 + (reg))
> > +#define DPHY_ISO(reg)			(0xc00 + (reg))
> >  
> >  #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
> >  #define DPHY_CMN_SSM_EN			BIT(0)
> > +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
> >  #define DPHY_CMN_TX_MODE_EN		BIT(9)
> > +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> > +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
> >  
> >  #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
> >  #define DPHY_CMN_PWM_DIV(x)		((x) << 20)
> > @@ -45,10 +52,27 @@
> >  #define DPHY_CMN_OPDIV_FROM_REG		BIT(6)
> >  #define DPHY_CMN_OPDIV(x)		((x) << 7)
> >  
> > +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> > +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> > +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> > +
> >  #define DPHY_PSM_CFG			DPHY_PCS(0x4)
> >  #define DPHY_PSM_CFG_FROM_REG		BIT(0)
> >  #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
> >  
> > +#define DPHY_POWER_ISLAND_EN_DATA	DPHY_PCS(0x8)
> > +#define DPHY_POWER_ISLAND_EN_DATA_VAL	0xaaaaaaaa
> > +#define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
> > +#define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> > +
> > +#define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
> > +#define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
> > +#define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> > +#define DPHY_ISO_DL_CTRL_L2		DPHY_ISO(0x30)
> > +#define DPHY_ISO_DL_CTRL_L3		DPHY_ISO(0x3c)
> > +#define DPHY_ISO_LANE_READY_BIT		0
> > +#define DPHY_ISO_LANE_READY_TIMEOUT_MS	100UL
> > +
> >  #define DSI_HBP_FRAME_OVERHEAD		12
> >  #define DSI_HSA_FRAME_OVERHEAD		14
> >  #define DSI_HFP_FRAME_OVERHEAD		6
> > @@ -57,6 +81,9 @@
> >  #define DSI_NULL_FRAME_OVERHEAD		6
> >  #define DSI_EOT_PKT_SIZE		4
> >  
> > +#define DPHY_LANES_MIN			1
> > +#define DPHY_LANES_MAX			4
> > +
> >  struct cdns_dphy_cfg {
> >  	u8 pll_ipdiv;
> >  	u8 pll_opdiv;
> > @@ -103,6 +130,22 @@ struct cdns_dphy_driver_data {
> >  	const struct cdns_dphy_ops *rx;
> >  };
> >  
> > +struct cdns_dphy_rx_band {
> > +	unsigned int min_rate;
> > +	unsigned int max_rate;
> > +};
> > +
> > +/* Order of bands is important since the index is the band number. */
> > +struct cdns_dphy_rx_band bands[] = {
> > +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> > +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> > +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> > +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> > +	{1750, 2000}, {2000, 2250}, {2250, 2500}
> > +};
> > +
> > +int num_bands = ARRAY_SIZE(bands);
> > +
> >  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
> >  				     struct cdns_dphy_cfg *cfg,
> >  				     struct phy_configure_opts_mipi_dphy *opts,
> > @@ -312,6 +355,135 @@ static const struct cdns_dphy_ops tx_ref_dphy_ops = {
> >  	.set_psm_div = cdns_dphy_ref_set_psm_div,
> >  };
> >  
> > +static int cdns_dphy_rx_power_on(struct cdns_dphy *dphy)
> > +{
> > +	/* Start RX state machine. */
> > +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN |
> > +	       FIELD_PREP(DPHY_CMN_RX_BANDGAP_TIMER_MASK,
> > +			  DPHY_CMN_RX_BANDGAP_TIMER),
> > +	       dphy->regs + DPHY_CMN_SSM);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cdns_dphy_rx_power_off(struct cdns_dphy *dphy)
> > +{
> > +	writel(0, dphy->regs + DPHY_CMN_SSM);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cdns_dphy_rx_get_band_ctrl(unsigned long hs_clk_rate)
> > +{
> > +	unsigned int rate;
> > +	int i;
> > +
> > +	rate = hs_clk_rate / 1000000UL;
> > +	/* Since CSI-2 clock is DDR, the bit rate is twice the clock rate. */
> > +	rate *= 2;
> > +
> > +	if (rate < bands[0].min_rate || rate >= bands[num_bands - 1].max_rate)
> > +		return -EOPNOTSUPP;
> > +
> > +	for (i = 0; i < num_bands; i++) {
> > +		if (rate >= bands[i].min_rate && rate < bands[i].max_rate)
> > +			return i;
> > +	}
> > +
> > +	/* Unreachable. */
> > +	WARN(1, "Reached unreachable code.");
> > +	return -EINVAL;
> > +}
> > +
> > +static int cdns_dphy_rx_wait_for_bit(void __iomem *addr, unsigned int bit)
> > +{
> > +	u32 val;
> > +
> > +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> > +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);
> 
> this looks wrong, val is not initialized, so what/when is condition to
> be met..?

The readl_relaxed_poll_timeout() macro puts the value returned by 
readl() into val. That value is then used for testing the condition. See 
read_poll_timeout() in iopoll.h to see what the macro eventually expands 
to.

> -- 
> ~Vinod

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
