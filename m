Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31837F340
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhEMGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:54:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46854 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:54:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D6qlkI104855;
        Thu, 13 May 2021 01:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620888767;
        bh=8zZM8kb7SdFruz8ojsVszZwRBe4/Txo2RSmaLM/9/Gs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YbR5eDwQBi1TPnwQXntfgB+J9Nx8Tx+t3s0WSSWRmCSyhUf/ReMUHAUBbcS40EbVE
         uW9TxvJQCN9kjLRph36JhPxNuUenzwLTjANr+KwQqdKPfBieUZI9S8aPcnx3c/Gi0s
         f7y1vVneA5+2NY1haVKhWkMOkLpLn64hmM2OlK2Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D6qkGq116851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 01:52:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 01:52:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 01:52:46 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D6qf87079306;
        Thu, 13 May 2021 01:52:42 -0500
Subject: Re: [PATCH 05/14] phy: cadence-torrent: Add PHY registers for DP in
 array format
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-6-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d32c3a1-7fde-d8f8-4a95-659b23f64b73@ti.com>
Date:   Thu, 13 May 2021 12:22:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-6-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Add PHY registers for single link DP in array format to simplify
> code and to improve readability.

Please mention this supports already supported frequencies of 19.2MHz
and 25MHz.

Was this tested both with 19.2MHz and 25MHz?

Thanks
Kishon

> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 450 +++++++++++++---------
>  1 file changed, 274 insertions(+), 176 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 39a26a1a4c51..4ec5909f192c 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -341,20 +341,12 @@ struct cdns_torrent_derived_refclk {
>  #define to_cdns_torrent_derived_refclk(_hw)	\
>  			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
>  
> -static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
> -				    struct cdns_torrent_inst *inst);
> -static
> -void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy);
>  static
>  void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
>  					     u32 rate, bool ssc);
>  static
> -void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
> -static
>  void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
>  					   u32 rate, bool ssc);
> -static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
> -					 unsigned int lane);
>  
>  struct cdns_reg_pairs {
>  	u32 val;
> @@ -759,9 +751,6 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>  	unsigned int hsclk_div_val = 0;
>  	unsigned int i;
>  
> -	/* 16'h0000 for single DP link configuration */
> -	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
> -
>  	switch (rate) {
>  	case 1620:
>  		clk_sel_val = 0x0f01;
> @@ -806,8 +795,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>  static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
>  					  struct phy_configure_opts_dp *dp)
>  {
> -	u32 ret;
> -	u32 read_val;
> +	u32 read_val, ret;
>  
>  	/* Disable the cmn_pll0_en before re-programming the new data rate. */
>  	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
> @@ -825,17 +813,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
>  	ndelay(200);
>  
>  	/* DP Rate Change - VCO Output settings. */
> -	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ) {
> +	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
>  		/* PMA common configuration 19.2MHz */
> -		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
> -							dp->ssc);
> -		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
> -	} else if (cdns_phy->ref_clk_rate == CLK_25_MHZ) {
> +		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate, dp->ssc);
> +	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
>  		/* PMA common configuration 25MHz */
> -		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
> -						      dp->ssc);
> -		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
> -	}
> +		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
>  	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
>  
>  	/* Enable the cmn_pll0_en. */
> @@ -1184,9 +1167,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  
>  	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
>  
> -	/* PHY PMA registers configuration function */
> -	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
> -
>  	/*
>  	 * Set lines power state to A0
>  	 * Set lines pll clk enable to 0
> @@ -1231,67 +1211,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	return ret;
>  }
>  
> -static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
> -				    struct cdns_torrent_inst *inst)
> -{
> -	unsigned int i;
> -
> -	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> -		/* PMA common configuration 19.2MHz */
> -		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
> -	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> -		/* PMA common configuration 25MHz */
> -		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
> -
> -	/* PMA lane configuration to deal with multi-link operation */
> -	for (i = 0; i < inst->num_lanes; i++)
> -		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
> -}
> -
> -static
> -void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
> -{
> -	struct regmap *regmap = cdns_phy->regmap_common_cdb;
> -
> -	/* refclock registers - assumes 19.2 MHz refclock */
> -	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
> -	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
> -	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
> -	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
> -	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
> -	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
> -	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
> -	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
> -	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
> -	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
> -
> -	/* PLL registers */
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
> -}
> -
>  /*
>   * Set registers responsible for enabling and configuring SSC, with second and
>   * third register values provided by parameters.
> @@ -1473,50 +1392,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
>  	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
>  }
>  
> -static
> -void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
> -{
> -	struct regmap *regmap = cdns_phy->regmap_common_cdb;
> -
> -	/* refclock registers - assumes 25 MHz refclock */
> -	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
> -	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
> -	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
> -	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
> -	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
> -	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
> -	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
> -	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
> -	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
> -	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
> -	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
> -	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
> -
> -	/* PLL registers */
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> -	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
> -	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
> -	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
> -}
> -
>  /*
>   * Set registers responsible for enabling and configuring SSC, with second
>   * register value provided by a parameter.
> @@ -1640,49 +1515,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
>  	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
>  }
>  
> -static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
> -					 unsigned int lane)
> -{
> -	/* Per lane, refclock-dependent receiver detection setting */
> -	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -				       TX_RCVDET_ST_TMR, 0x0780);
> -	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -				       TX_RCVDET_ST_TMR, 0x09C4);
> -
> -	/* Writing Tx/Rx Power State Controllers registers */
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       TX_PSC_A0, 0x00FB);
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       TX_PSC_A2, 0x04AA);
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       TX_PSC_A3, 0x04AA);
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_PSC_A0, 0x0000);
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_PSC_A2, 0x0000);
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_PSC_A3, 0x0000);
> -
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_PSC_CAL, 0x0000);
> -
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_REE_GCSM1_CTRL, 0x0000);
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_REE_GCSM2_CTRL, 0x0000);
> -	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
> -			       RX_REE_PERGCSM_CTRL, 0x0000);
> -
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       XCVR_DIAG_BIDI_CTRL, 0x000F);
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
> -	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> -			       XCVR_DIAG_HSCLK_SEL, 0x0000);
> -}
> -
>  static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
>  {
>  	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
> @@ -1972,9 +1804,6 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	if (cdns_phy->nsubnodes > 1)
>  		return 0;
>  
> -	if (phy_type == TYPE_DP)
> -		return cdns_torrent_dp_init(phy);
> -
>  	/**
>  	 * Spread spectrum generation is not required or supported
>  	 * for SGMII/QSGMII
> @@ -2060,6 +1889,9 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  		}
>  	}
>  
> +	if (phy_type == TYPE_DP)
> +		return cdns_torrent_dp_init(phy);
> +
>  	return 0;
>  }
>  
> @@ -2584,6 +2416,168 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/* Single DisplayPort(DP) link configuration */
> +static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
> +	{0x0000, PHY_PLL_CFG},
> +};
> +
> +static struct cdns_reg_pairs sl_dp_xcvr_diag_ln_regs[] = {
> +	{0x0000, XCVR_DIAG_HSCLK_SEL},
> +	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
> +};
> +
> +static struct cdns_torrent_vals sl_dp_link_cmn_vals = {
> +	.reg_pairs = sl_dp_link_cmn_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_link_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_xcvr_diag_ln_vals = {
> +	.reg_pairs = sl_dp_xcvr_diag_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_xcvr_diag_ln_regs),
> +};
> +
> +/* Single DP, 19.2 MHz Ref clk, no SSC */
> +static struct cdns_reg_pairs sl_dp_19_2_no_ssc_cmn_regs[] = {
> +	{0x0014, CMN_SSM_BIAS_TMR},
> +	{0x0027, CMN_PLLSM0_PLLPRE_TMR},
> +	{0x00A1, CMN_PLLSM0_PLLLOCK_TMR},
> +	{0x0027, CMN_PLLSM1_PLLPRE_TMR},
> +	{0x00A1, CMN_PLLSM1_PLLLOCK_TMR},
> +	{0x0060, CMN_BGCAL_INIT_TMR},
> +	{0x0060, CMN_BGCAL_ITER_TMR},
> +	{0x0014, CMN_IBCAL_INIT_TMR},
> +	{0x0018, CMN_TXPUCAL_INIT_TMR},
> +	{0x0005, CMN_TXPUCAL_ITER_TMR},
> +	{0x0018, CMN_TXPDCAL_INIT_TMR},
> +	{0x0005, CMN_TXPDCAL_ITER_TMR},
> +	{0x0240, CMN_RXCAL_INIT_TMR},
> +	{0x0005, CMN_RXCAL_ITER_TMR},
> +	{0x0002, CMN_SD_CAL_INIT_TMR},
> +	{0x0002, CMN_SD_CAL_ITER_TMR},
> +	{0x000B, CMN_SD_CAL_REFTIM_START},
> +	{0x0137, CMN_SD_CAL_PLLCNT_START},
> +	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
> +	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
> +	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
> +	{0x0004, CMN_PLL0_DSM_DIAG_M0},
> +	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
> +	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
> +	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
> +	{0x0004, CMN_PLL1_DSM_DIAG_M0},
> +	{0x00C0, CMN_PLL0_VCOCAL_INIT_TMR},
> +	{0x0004, CMN_PLL0_VCOCAL_ITER_TMR},
> +	{0x00C0, CMN_PLL1_VCOCAL_INIT_TMR},
> +	{0x0004, CMN_PLL1_VCOCAL_ITER_TMR},
> +	{0x0260, CMN_PLL0_VCOCAL_REFTIM_START},
> +	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
> +	{0x0260, CMN_PLL1_VCOCAL_REFTIM_START},
> +	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_19_2_no_ssc_tx_ln_regs[] = {
> +	{0x0780, TX_RCVDET_ST_TMR},
> +	{0x00FB, TX_PSC_A0},
> +	{0x04AA, TX_PSC_A2},
> +	{0x04AA, TX_PSC_A3},
> +	{0x000F, XCVR_DIAG_BIDI_CTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_19_2_no_ssc_rx_ln_regs[] = {
> +	{0x0000, RX_PSC_A0},
> +	{0x0000, RX_PSC_A2},
> +	{0x0000, RX_PSC_A3},
> +	{0x0000, RX_PSC_CAL},
> +	{0x0000, RX_REE_GCSM1_CTRL},
> +	{0x0000, RX_REE_GCSM2_CTRL},
> +	{0x0000, RX_REE_PERGCSM_CTRL}
> +};
> +
> +static struct cdns_torrent_vals sl_dp_19_2_no_ssc_cmn_vals = {
> +	.reg_pairs = sl_dp_19_2_no_ssc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_19_2_no_ssc_tx_ln_vals = {
> +	.reg_pairs = sl_dp_19_2_no_ssc_tx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_tx_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_19_2_no_ssc_rx_ln_vals = {
> +	.reg_pairs = sl_dp_19_2_no_ssc_rx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_rx_ln_regs),
> +};
> +
> +/* Single DP, 25 MHz Ref clk, no SSC */
> +static struct cdns_reg_pairs sl_dp_25_no_ssc_cmn_regs[] = {
> +	{0x0019, CMN_SSM_BIAS_TMR},
> +	{0x0032, CMN_PLLSM0_PLLPRE_TMR},
> +	{0x00D1, CMN_PLLSM0_PLLLOCK_TMR},
> +	{0x0032, CMN_PLLSM1_PLLPRE_TMR},
> +	{0x00D1, CMN_PLLSM1_PLLLOCK_TMR},
> +	{0x007D, CMN_BGCAL_INIT_TMR},
> +	{0x007D, CMN_BGCAL_ITER_TMR},
> +	{0x0019, CMN_IBCAL_INIT_TMR},
> +	{0x001E, CMN_TXPUCAL_INIT_TMR},
> +	{0x0006, CMN_TXPUCAL_ITER_TMR},
> +	{0x001E, CMN_TXPDCAL_INIT_TMR},
> +	{0x0006, CMN_TXPDCAL_ITER_TMR},
> +	{0x02EE, CMN_RXCAL_INIT_TMR},
> +	{0x0006, CMN_RXCAL_ITER_TMR},
> +	{0x0002, CMN_SD_CAL_INIT_TMR},
> +	{0x0002, CMN_SD_CAL_ITER_TMR},
> +	{0x000E, CMN_SD_CAL_REFTIM_START},
> +	{0x012B, CMN_SD_CAL_PLLCNT_START},
> +	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
> +	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
> +	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
> +	{0x0004, CMN_PLL0_DSM_DIAG_M0},
> +	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
> +	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
> +	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
> +	{0x0004, CMN_PLL1_DSM_DIAG_M0},
> +	{0x00FA, CMN_PLL0_VCOCAL_INIT_TMR},
> +	{0x0004, CMN_PLL0_VCOCAL_ITER_TMR},
> +	{0x00FA, CMN_PLL1_VCOCAL_INIT_TMR},
> +	{0x0004, CMN_PLL1_VCOCAL_ITER_TMR},
> +	{0x0317, CMN_PLL0_VCOCAL_REFTIM_START},
> +	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
> +	{0x0317, CMN_PLL1_VCOCAL_REFTIM_START},
> +	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_25_no_ssc_tx_ln_regs[] = {
> +	{0x09C4, TX_RCVDET_ST_TMR},
> +	{0x00FB, TX_PSC_A0},
> +	{0x04AA, TX_PSC_A2},
> +	{0x04AA, TX_PSC_A3},
> +	{0x000F, XCVR_DIAG_BIDI_CTRL}
> +};
> +
> +static struct cdns_reg_pairs sl_dp_25_no_ssc_rx_ln_regs[] = {
> +	{0x0000, RX_PSC_A0},
> +	{0x0000, RX_PSC_A2},
> +	{0x0000, RX_PSC_A3},
> +	{0x0000, RX_PSC_CAL},
> +	{0x0000, RX_REE_GCSM1_CTRL},
> +	{0x0000, RX_REE_GCSM2_CTRL},
> +	{0x0000, RX_REE_PERGCSM_CTRL}
> +};
> +
> +static struct cdns_torrent_vals sl_dp_25_no_ssc_cmn_vals = {
> +	.reg_pairs = sl_dp_25_no_ssc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_25_no_ssc_tx_ln_vals = {
> +	.reg_pairs = sl_dp_25_no_ssc_tx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_tx_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
> +	.reg_pairs = sl_dp_25_no_ssc_rx_ln_regs,
> +	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
> +};
> +
>  /* USB and SGMII/QSGMII link configuration */
>  static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
>  	{0x0002, PHY_PLL_CFG},
> @@ -3322,6 +3316,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  	.block_offset_shift = 0x2,
>  	.reg_offset_shift = 0x2,
>  	.link_cmn_vals = {
> +		[TYPE_DP] = {
> +			[TYPE_NONE] = {
> +				[NO_SSC] = &sl_dp_link_cmn_vals,
> +			},
> +		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = NULL,
> @@ -3398,6 +3397,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  		},
>  	},
>  	.xcvr_diag_vals = {
> +		[TYPE_DP] = {
> +			[TYPE_NONE] = {
> +				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
> +			},
> +		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = NULL,
> @@ -3498,6 +3502,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  		},
>  	},
>  	.cmn_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3576,6 +3594,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  		},
>  	},
>  	.tx_ln_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3654,6 +3686,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  		},
>  	},
>  	.rx_ln_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3737,6 +3783,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  	.block_offset_shift = 0x0,
>  	.reg_offset_shift = 0x1,
>  	.link_cmn_vals = {
> +		[TYPE_DP] = {
> +			[TYPE_NONE] = {
> +				[NO_SSC] = &sl_dp_link_cmn_vals,
> +			},
> +		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = NULL,
> @@ -3813,6 +3864,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  		},
>  	},
>  	.xcvr_diag_vals = {
> +		[TYPE_DP] = {
> +			[TYPE_NONE] = {
> +				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
> +			},
> +		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = NULL,
> @@ -3913,6 +3969,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  		},
>  	},
>  	.cmn_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3991,6 +4061,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  		},
>  	},
>  	.tx_ln_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -4069,6 +4153,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  		},
>  	},
>  	.rx_ln_vals = {
> +		[CLK_19_2_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
> +				},
> +			},
> +		},
> +		[CLK_25_MHZ] = {
> +			[TYPE_DP] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
> +				},
> +			},
> +		},
>  		[CLK_100_MHZ] = {
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> 
