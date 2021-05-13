Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582FE37F34D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhEMHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:00:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33506 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhEMHAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:00:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D6xUa1098873;
        Thu, 13 May 2021 01:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620889170;
        bh=iHD37ZiR3+VsCe+OEbuAZx73QXq1rzNq7UTDkvvKSsg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jyxOf6wDlbAiIWFHj9adH4/d89DFchIrikTOzLrGE3AC665FcbACYzFEZYppMAqCb
         vDxvBBnPrQsojGYpcepUQ1ayPyYpElpjaQmnKAQwqoUtYRbT0ZgcpUWP3HjyHq0YRk
         Wcm66gFR7pZjUYu8od9rraw/b4R74LSyNCi3F5TQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D6xUbK020362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 01:59:30 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 01:59:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 01:59:29 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D6xQGL060569;
        Thu, 13 May 2021 01:59:27 -0500
Subject: Re: [PATCH 08/14] phy: cadence-torrent: Add PHY configuration for DP
 with 100MHz ref clock
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-9-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5e0c00f8-593a-59a5-0ae5-417cd64370ed@ti.com>
Date:   Thu, 13 May 2021 12:29:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-9-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Add PHY configuration registers for DP with 100MHz ref clock and NO_SSC.

Looks neat! Thanks!

> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 162 ++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index a6331927d775..69466481af26 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -103,6 +103,7 @@
>  #define CMN_PLL0_FRACDIVH_M0		0x0092U
>  #define CMN_PLL0_HIGH_THR_M0		0x0093U
>  #define CMN_PLL0_DSM_DIAG_M0		0x0094U
> +#define CMN_PLL0_DSM_FBH_OVRD_M0	0x0095U
>  #define CMN_PLL0_SS_CTRL1_M0		0x0098U
>  #define CMN_PLL0_SS_CTRL2_M0            0x0099U
>  #define CMN_PLL0_SS_CTRL3_M0            0x009AU
> @@ -816,6 +817,89 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
>  	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
>  }
>  
> +static
> +void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
> +					    u32 rate, bool ssc)
> +{
> +	struct regmap *regmap = cdns_phy->regmap_common_cdb;
> +
> +	/* Assumes 100 MHz refclock */
> +	switch (rate) {
> +	/* Setting VCO for 10.8GHz */
> +	case 2700:
> +	case 5400:
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
> +		break;
> +	/* Setting VCO for 9.72GHz */
> +	case 1620:
> +	case 2430:
> +	case 3240:
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		break;
> +	/* Setting VCO for 8.64GHz */
> +	case 2160:
> +	case 4320:
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		break;
> +	/* Setting VCO for 8.1GHz */
> +	case 8100:
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
> +		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);


We could think of having DP specific separate arrays for the above
configurations. Might help us to avoid having separate functions for
each of the required frequencies.

Thanks
Kishon

> +		break;
> +	}
> +}
> +
>  /*
>   * Enable or disable PLL for selected lanes.
>   */
> @@ -1056,6 +1140,10 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
>  	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
>  		/* PMA common configuration 25MHz */
>  		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
> +	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
> +		/* PMA common configuration 100MHz */
> +		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
> +
>  	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
>  
>  	/* Enable the cmn_pll0_en. */
> @@ -1395,6 +1483,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	switch (cdns_phy->ref_clk_rate) {
>  	case CLK_19_2_MHZ:
>  	case CLK_25_MHZ:
> +	case CLK_100_MHZ:
>  		/* Valid Ref Clock Rate */
>  		break;
>  	default:
> @@ -1431,6 +1520,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
>  						      cdns_phy->max_bit_rate,
>  						      false);
> +	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
> +		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy,
> +						       cdns_phy->max_bit_rate,
> +						       false);
> +
>  	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
>  				     inst->num_lanes);
>  
> @@ -2511,6 +2605,44 @@ static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
>  	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
>  };
>  
> +/* Single DP, 100 MHz Ref clk, no SSC */
> +static struct cdns_reg_pairs sl_dp_100_no_ssc_cmn_regs[] = {
> +	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
> +	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_100_no_ssc_tx_ln_regs[] = {
> +	{0x00FB, TX_PSC_A0},
> +	{0x04AA, TX_PSC_A2},
> +	{0x04AA, TX_PSC_A3},
> +	{0x000F, XCVR_DIAG_BIDI_CTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_100_no_ssc_rx_ln_regs[] = {
> +	{0x0000, RX_PSC_A0},
> +	{0x0000, RX_PSC_A2},
> +	{0x0000, RX_PSC_A3},
> +	{0x0000, RX_PSC_CAL},
> +	{0x0000, RX_REE_GCSM1_CTRL},
> +	{0x0000, RX_REE_GCSM2_CTRL},
> +	{0x0000, RX_REE_PERGCSM_CTRL}
> +};
> +
> +static struct cdns_torrent_vals sl_dp_100_no_ssc_cmn_vals = {
> +	.reg_pairs = sl_dp_100_no_ssc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_100_no_ssc_tx_ln_vals = {
> +	.reg_pairs = sl_dp_100_no_ssc_tx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_tx_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_100_no_ssc_rx_ln_vals = {
> +	.reg_pairs = sl_dp_100_no_ssc_rx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_rx_ln_regs),
> +};
> +
>  /* USB and SGMII/QSGMII link configuration */
>  static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
>  	{0x0002, PHY_PLL_CFG},
> @@ -3450,6 +3582,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = NULL,
> @@ -3542,6 +3679,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = NULL,
> @@ -3634,6 +3776,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> @@ -3917,6 +4064,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = NULL,
> @@ -4009,6 +4161,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = NULL,
> @@ -4101,6 +4258,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  			},
>  		},
>  		[CLK_100_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
> +				},
> +			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> 
