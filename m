Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E737F3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhEMHrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:47:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhEMHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:46:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D7iiWU128468;
        Thu, 13 May 2021 02:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620891884;
        bh=KejcD8AulnyDP75z7toQQsbSrdhM8Kg8v2TzTwuMmSw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q5T44LxWiIz1/qXnER5VHeSSIPWDlLsF+jfbDdNWb9yllJcVZ26ZIvvph7+MYTzh4
         Sm5UK18/6H+8RHo4rlta6prOdC3JjW+AfkVtNV/B9Nb4aso+icbo1myQLjFB7+z+qc
         qcCliEEAAIz67lS7p0+xw9JZMzYhg+eaWC4tH5oo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D7iiVe116857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:44:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:44:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:44:43 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D7icH3005581;
        Thu, 13 May 2021 02:44:39 -0500
Subject: Re: [PATCH 11/14] phy: cadence-torrent: Add multilink DP support
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-12-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d7b8a1eb-678c-134a-1fcb-1678c7aed134@ti.com>
Date:   Thu, 13 May 2021 13:14:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-12-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Add multilink support for DP. This needs changes in functions
> configuring default single link DP with master lane 0 to support
> non-zero master lane values and associated PLL configurations.
>

It's better to mention here you are adding multi-link DP support only
for 100MHz reference clock.

> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 498 +++++++++++++---------
>  1 file changed, 289 insertions(+), 209 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 44e28ea8ffa7..becbf8456b2d 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -62,16 +62,11 @@
>   */
>  #define PHY_AUX_CTRL			0x04
>  #define PHY_RESET			0x20
> -#define PMA_TX_ELEC_IDLE_MASK		0xF0U
>  #define PMA_TX_ELEC_IDLE_SHIFT		4
> -#define PHY_L00_RESET_N_MASK		0x01U
>  #define PHY_PMA_XCVR_PLLCLK_EN		0x24
>  #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
>  #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
> -#define PHY_POWER_STATE_LN_0	0x0000
> -#define PHY_POWER_STATE_LN_1	0x0008
> -#define PHY_POWER_STATE_LN_2	0x0010
> -#define PHY_POWER_STATE_LN_3	0x0018
> +#define PHY_POWER_STATE_LN(ln)		((ln) * 8)
>  #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
>  #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
>  #define PHY_PMA_CMN_READY		0x34
> @@ -834,74 +829,90 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
>  	/* Setting VCO for 10.8GHz */
>  	case 2700:
>  	case 5400:
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
> +		if (cdns_phy->dp_pll & DP_PLL0)
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
> +
> +		if (cdns_phy->dp_pll & DP_PLL1) {
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
> +		}
>  		break;
>  	/* Setting VCO for 9.72GHz */
>  	case 1620:
>  	case 2430:
>  	case 3240:
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		if (cdns_phy->dp_pll & DP_PLL0) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		}
> +		if (cdns_phy->dp_pll & DP_PLL1) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		}
>  		break;
>  	/* Setting VCO for 8.64GHz */
>  	case 2160:
>  	case 4320:
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		if (cdns_phy->dp_pll & DP_PLL0) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		}
> +		if (cdns_phy->dp_pll & DP_PLL1) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		}
>  		break;
>  	/* Setting VCO for 8.1GHz */
>  	case 8100:
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
> -		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> -		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		if (cdns_phy->dp_pll & DP_PLL0) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
> +		}
> +		if (cdns_phy->dp_pll & DP_PLL1) {
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
> +			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
> +			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
> +		}
>  		break;
>  	}
>  }
> @@ -934,43 +945,36 @@ static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
>   * Enable or disable PLL for selected lanes.
>   */
>  static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
> +				      struct cdns_torrent_inst *inst,
>  				      struct phy_configure_opts_dp *dp,
>  				      bool enable)
>  {
> -	u32 rd_val;
> -	u32 ret;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> +	u32 rd_val, i, pll_ack_val;
> +	int ret;
>  
>  	/*
>  	 * Used to determine, which bits to check for or enable in
>  	 * PHY_PMA_XCVR_PLLCLK_EN register.
>  	 */
> -	u32 pll_bits;
> +	u32 pll_bits = 0;
>  	/* Used to enable or disable lanes. */
>  	u32 pll_val;
>  
> -	/* Select values of registers and mask, depending on enabled lane
> -	 * count.
> -	 */
> -	switch (dp->lanes) {
> -	/* lane 0 */
> -	case (1):
> -		pll_bits = 0x00000001;
> -		break;
> -	/* lanes 0-1 */
> -	case (2):
> -		pll_bits = 0x00000003;
> -		break;
> -	/* lanes 0-3, all */
> -	default:
> -		pll_bits = 0x0000000F;
> -		break;
> -	}
> +	/* Select values of registers and mask, depending on enabled lane count. */
> +	pll_val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
>  
> -	if (enable)
> -		pll_val = pll_bits;
> -	else
> -		pll_val = 0x00000000;
> +	if (enable) {
> +		for (i = 0; i < dp->lanes; i++)
> +			pll_bits |= (0x01U << (inst->mlane + i));
> +		pll_val |= pll_bits;
> +		pll_ack_val = pll_bits;
> +	} else {
> +		for (i = 0; i < inst->num_lanes; i++)
> +			pll_bits |= (0x01U << (inst->mlane + i));
> +		pll_val &= (~pll_bits);
> +		pll_ack_val = 0;
> +	}
>  
>  	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
>  
> @@ -978,22 +982,24 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
>  	ret = regmap_read_poll_timeout(regmap,
>  				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
>  				       rd_val,
> -				       (rd_val & pll_bits) == pll_val,
> +				       (rd_val & pll_bits) == pll_ack_val,
>  				       0, POLL_TIMEOUT_US);
>  	ndelay(100);
>  	return ret;
>  }
>  
>  static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
> +					   struct cdns_torrent_inst *inst,
>  					   u32 num_lanes,
>  					   enum phy_powerstate powerstate)
>  {
>  	/* Register value for power state for a single byte. */
>  	u32 value_part;
>  	u32 value;
> -	u32 mask;
> +	u32 mask = 0;
>  	u32 read_val;
> -	u32 ret;
> +	int ret;
> +	u32 i;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  
>  	switch (powerstate) {
> @@ -1009,29 +1015,12 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
>  		break;
>  	}
>  
> -	/* Select values of registers and mask, depending on enabled
> -	 * lane count.
> -	 */
> -	switch (num_lanes) {
> -	/* lane 0 */
> -	case (1):
> -		value = value_part;
> -		mask = 0x0000003FU;
> -		break;
> -	/* lanes 0-1 */
> -	case (2):
> -		value = (value_part
> -			 | (value_part << 8));
> -		mask = 0x00003F3FU;
> -		break;
> -	/* lanes 0-3, all */
> -	default:
> -		value = (value_part
> -			 | (value_part << 8)
> -			 | (value_part << 16)
> -			 | (value_part << 24));
> -		mask = 0x3F3F3F3FU;
> -		break;
> +	/* Select values of registers and mask, depending on enabled lane count. */
> +	value = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_POWER_STATE_REQ);
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		value |= (value_part << PHY_POWER_STATE_LN(inst->mlane + i));
> +		mask |= (PMA_XCVR_POWER_STATE_REQ_LN_MASK << PHY_POWER_STATE_LN(inst->mlane + i));
>  	}
>  
>  	/* Set power state A<n>. */
> @@ -1046,7 +1035,8 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
>  	return ret;
>  }
>  
> -static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
> +static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
> +			       struct cdns_torrent_inst *inst, u32 num_lanes)
>  {
>  	unsigned int read_val;
>  	int ret;
> @@ -1057,7 +1047,7 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
>  	 * master lane
>  	 */
>  	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
> -				       read_val, read_val & 1,
> +				       read_val, (read_val & (1 << inst->mlane)),
>  				       0, POLL_TIMEOUT_US);
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(cdns_phy->dev,
> @@ -1067,12 +1057,12 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
>  
>  	ndelay(100);
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
>  					      POWERSTATE_A2);
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
>  					      POWERSTATE_A0);
>  
>  	return ret;
> @@ -1096,6 +1086,7 @@ static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
>  }
>  
>  static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
> +					 struct cdns_torrent_inst *inst,
>  					 u32 rate, u32 num_lanes)
>  {
>  	unsigned int clk_sel_val = 0;
> @@ -1128,14 +1119,17 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>  		break;
>  	}
>  
> -	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> -			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
> -	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> -			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
> +	if (cdns_phy->dp_pll & DP_PLL0)
> +		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> +				       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
> +
> +	if (cdns_phy->dp_pll & DP_PLL1)
> +		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> +				       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
>  
>  	/* PMA lane configuration to deal with multi-link operation */
>  	for (i = 0; i < num_lanes; i++)
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + i],
>  				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
>  }
>  
> @@ -1144,49 +1138,89 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>   * set and PLL disable request was processed.
>   */
>  static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
> +					  struct cdns_torrent_inst *inst,
>  					  struct phy_configure_opts_dp *dp)
>  {
> -	u32 read_val, ret;
> +	u32 read_val, field_val;
> +	int ret;
>  
> -	/* Disable the cmn_pll0_en before re-programming the new data rate. */
> -	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
> +	/*
> +	 * Disable the associated PLL (cmn_pll0_en or cmn_pll1_en) before
> +	 * re-programming the new data rate.
> +	 */
> +	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
> +	if (ret)
> +		return ret;
> +	field_val &= ~(cdns_phy->dp_pll);
> +	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
>  
>  	/*
>  	 * Wait for PLL ready de-assertion.
>  	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
> +	 * For PLL1 - PHY_PMA_CMN_CTRL2[3] == 1
>  	 */
> -	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> -					     read_val,
> -					     ((read_val >> 2) & 0x01) != 0,
> -					     0, POLL_TIMEOUT_US);
> -	if (ret)
> -		return ret;
> +	if (cdns_phy->dp_pll & DP_PLL0) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 2) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 3) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
>  	ndelay(200);
>  
>  	/* DP Rate Change - VCO Output settings. */
> -	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> -		/* PMA common configuration 19.2MHz */
> -		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate, dp->ssc);
> -	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> -		/* PMA common configuration 25MHz */
> -		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
> -	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
> +	if (cdns_phy->nsubnodes == 1) {

I think this condition is not required here. You are adding this since
you are not adding multi-link support except for 100MHz.

Ideally all this chech should be done somewhere during the initialization.
> +		if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> +			/* PMA common configuration 19.2MHz */
> +			cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate, dp->ssc);
> +		else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> +			/* PMA common configuration 25MHz */
> +			cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
> +	}
> +
> +	if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
>  		/* PMA common configuration 100MHz */
>  		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
>  
> -	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
> +	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, dp->link_rate, dp->lanes);
>  
> -	/* Enable the cmn_pll0_en. */
> -	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
> +	/* Enable the associated PLL (cmn_pll0_en or cmn_pll1_en) */
> +	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
> +	if (ret)
> +		return ret;
> +	field_val |= cdns_phy->dp_pll;
> +	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
>  
>  	/*
>  	 * Wait for PLL ready assertion.
>  	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
> +	 * For PLL1 - PHY_PMA_CMN_CTRL2[1] == 1
>  	 */
> -	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> -					     read_val,
> -					     (read_val & 0x01) != 0,
> -					     0, POLL_TIMEOUT_US);
> +	if (cdns_phy->dp_pll & DP_PLL0) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     (read_val & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1)
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 1) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +
>  	return ret;
>  }
>  
> @@ -1254,6 +1288,7 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
>  
>  /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
>  static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
> +				       struct cdns_torrent_inst *inst,
>  				       u32 num_lanes)
>  {
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> @@ -1261,27 +1296,13 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
>  					     PHY_PMA_XCVR_POWER_STATE_REQ);
>  	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
>  					      PHY_PMA_XCVR_PLLCLK_EN);
> +	u32 i;
>  
> -	/* Lane 0 is always enabled. */
> -	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -		       PHY_POWER_STATE_LN_0);
> -	pll_clk_en &= ~0x01U;
> -
> -	if (num_lanes > 1) {
> -		/* lane 1 */
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_1);
> -		pll_clk_en &= ~(0x01U << 1);
> -	}
> +	for (i = 0; i < num_lanes; i++) {
> +		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK
> +			     << PHY_POWER_STATE_LN(inst->mlane + i));
>  
> -	if (num_lanes > 2) {
> -		/* lanes 2 and 3 */
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_2);
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_3);
> -		pll_clk_en &= ~(0x01U << 2);
> -		pll_clk_en &= ~(0x01U << 3);
> +		pll_clk_en &= ~(0x01U << (inst->mlane + i));
>  	}
>  
>  	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
> @@ -1290,36 +1311,58 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
>  
>  /* Configure lane count as required. */
>  static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
> +				     struct cdns_torrent_inst *inst,
>  				     struct phy_configure_opts_dp *dp)
>  {
> -	u32 value;
> -	u32 ret;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  	u8 lane_mask = (1 << dp->lanes) - 1;
> +	u8 pma_tx_elec_idle_mask = 0;
> +	u32 value, i;
> +	int ret;
> +
> +	lane_mask <<= inst->mlane;
>  
>  	value = cdns_torrent_dp_read(regmap, PHY_RESET);
> +
>  	/* clear pma_tx_elec_idle_ln_* bits. */
> -	value &= ~PMA_TX_ELEC_IDLE_MASK;
> +	for (i = 0; i < inst->num_lanes; i++)
> +		pma_tx_elec_idle_mask |= 1 << (inst->mlane + i);
> +
> +	pma_tx_elec_idle_mask <<= PMA_TX_ELEC_IDLE_SHIFT;
> +
> +	value &= ~pma_tx_elec_idle_mask;
> +
>  	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
>  	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
> -		 PMA_TX_ELEC_IDLE_MASK;
> +		 pma_tx_elec_idle_mask;
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
> -	/* reset the link by asserting phy_l00_reset_n low */
> +	/* reset the link by asserting master lane phy_l0*_reset_n low */
>  	cdns_torrent_dp_write(regmap, PHY_RESET,
> -			      value & (~PHY_L00_RESET_N_MASK));
> +			      value & (~(1 << inst->mlane)));
>  
>  	/*
> -	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
> +	 * Assert lane reset on unused lanes and master lane so they remain in reset
>  	 * and powered down when re-enabling the link
>  	 */
> -	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value &= (~(1 << (inst->mlane + i)));
> +
> +	for (i = 1; i < inst->num_lanes; i++)
> +		value |= ((1 << (inst->mlane + i)) & lane_mask);
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
> -	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
> +	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, inst->num_lanes);
>  
>  	/* release phy_l0*_reset_n based on used laneCount */
> -	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value &= (~(1 << (inst->mlane + i)));
> +
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value |= ((1 << (inst->mlane + i)) & lane_mask);
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
>  	/* Wait, until PHY gets ready after releasing PHY reset signal. */
> @@ -1330,41 +1373,44 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
>  	ndelay(100);
>  
>  	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
> -	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
> +	value = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
> +	value |= (1 << inst->mlane);
> +	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, value);
>  
> -	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
> +	ret = cdns_torrent_dp_run(cdns_phy, inst, dp->lanes);
>  
>  	return ret;
>  }
>  
>  /* Configure link rate as required. */
>  static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
> +				    struct cdns_torrent_inst *inst,
>  				    struct phy_configure_opts_dp *dp)
>  {
> -	u32 ret;
> +	int ret;
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A3);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
> +	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, false);
>  	if (ret)
>  		return ret;
>  	ndelay(200);
>  
> -	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
> +	ret = cdns_torrent_dp_configure_rate(cdns_phy, inst, dp);
>  	if (ret)
>  		return ret;
>  	ndelay(200);
>  
> -	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
> +	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, true);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A2);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A0);
>  	if (ret)
>  		return ret;
> @@ -1375,44 +1421,45 @@ static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
>  
>  /* Configure voltage swing and pre-emphasis for all enabled lanes. */
>  static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
> +					 struct cdns_torrent_inst *inst,
>  					 struct phy_configure_opts_dp *dp)
>  {
>  	u8 lane;
>  	u16 val;
>  
>  	for (lane = 0; lane < dp->lanes; lane++) {
> -		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
> +		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  					    TX_DIAG_ACYA);
>  		/*
>  		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
>  		 * current state of the analog TX driver.
>  		 */
>  		val |= TX_DIAG_ACYA_HBDC_MASK;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_DIAG_ACYA, val);
>  
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_CTRL, 0x08A4);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       DRV_DIAG_TX_DRV, val);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_MGNFS_MULT_000,
>  				       val);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_CPOST_MULT_00,
>  				       val);
>  
> -		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
> +		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  					    TX_DIAG_ACYA);
>  		/*
>  		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
>  		 * analog TX driver to reflect the new programmed one.
>  		 */
>  		val &= ~TX_DIAG_ACYA_HBDC_MASK;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_DIAG_ACYA, val);
>  	}
>  };
> @@ -1431,7 +1478,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_lanes) {
> -		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
> +		ret = cdns_torrent_dp_set_lanes(cdns_phy, inst, &opts->dp);
>  		if (ret) {
>  			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
>  			return ret;
> @@ -1439,7 +1486,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_rate) {
> -		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
> +		ret = cdns_torrent_dp_set_rate(cdns_phy, inst, &opts->dp);
>  		if (ret) {
>  			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
>  			return ret;
> @@ -1447,7 +1494,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_voltages)
> -		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
> +		cdns_torrent_dp_set_voltages(cdns_phy, inst, &opts->dp);
>  
>  	return ret;
>  }
> @@ -1507,6 +1554,7 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
>  {
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  	unsigned char lane_bits;
> +	u32 val;
>  
>  	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
>  
> @@ -1514,37 +1562,46 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
>  	 * Set lines power state to A0
>  	 * Set lines pll clk enable to 0
>  	 */
> -	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
> +	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, inst->num_lanes);
>  
>  	/*
>  	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
>  	 * used lanes
>  	 */
>  	lane_bits = (1 << inst->num_lanes) - 1;
> -	cdns_torrent_dp_write(regmap, PHY_RESET,
> -			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
> +	lane_bits <<= inst->mlane;
> +
> +	val = cdns_torrent_dp_read(regmap, PHY_RESET);
> +	val |= (0xF & lane_bits);
> +	val &= ~(lane_bits << 4);
> +	cdns_torrent_dp_write(regmap, PHY_RESET, val);
>  
>  	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
> -	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
> +	val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
> +	val |= (1 << inst->mlane);
> +	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, val);
>  
>  	/*
>  	 * PHY PMA registers configuration functions
>  	 * Initialize PHY with max supported link rate, without SSC.
>  	 */
> -	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> -		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
> -							cdns_phy->max_bit_rate,
> -							false);
> -	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> -		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
> -						      cdns_phy->max_bit_rate,
> -						      false);
> -	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
> +	if (cdns_phy->nsubnodes == 1) {

same comment here..
> +		if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
> +			cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
> +								cdns_phy->max_bit_rate,
> +								false);
> +		else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
> +			cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
> +							      cdns_phy->max_bit_rate,
> +							      false);
> +	}
> +
> +	if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
>  		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy,
>  						       cdns_phy->max_bit_rate,
>  						       false);
>  
> -	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
> +	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, cdns_phy->max_bit_rate,
>  				     inst->num_lanes);
>  
>  	/* take out of reset */
> @@ -1563,7 +1620,7 @@ static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
> +	ret = cdns_torrent_dp_run(cdns_phy, inst, inst->num_lanes);
>  
>  	return ret;
>  }
> @@ -1591,6 +1648,20 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	return cdns_torrent_dp_start(cdns_phy, inst, phy);
>  }
>  
> +static int cdns_torrent_dp_multilink_init(struct cdns_torrent_phy *cdns_phy,
> +					  struct cdns_torrent_inst *inst,
> +					  struct phy *phy)
> +{
> +	if (cdns_phy->ref_clk_rate != CLK_100_MHZ) {
> +		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
> +		return -EINVAL;
> +	}
> +
> +	cdns_torrent_dp_common_init(cdns_phy, inst);
> +
> +	return cdns_torrent_dp_start(cdns_phy, inst, phy);
> +}
> +
>  static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
>  {
>  	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
> @@ -1877,8 +1948,11 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	u32 num_regs;
>  	int i, j;
>  
> -	if (cdns_phy->nsubnodes > 1)
> +	if (cdns_phy->nsubnodes > 1) {
> +		if (phy_type == TYPE_DP)
> +			return cdns_torrent_dp_multilink_init(cdns_phy, inst, phy);
>  		return 0;
> +	}
>  
>  	/**
>  	 * Spread spectrum generation is not required or supported
> @@ -2122,6 +2196,12 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  			}
>  		}
>  
> +		if (phy_t1 == TYPE_DP) {
> +			ret = cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
>  	}

Swapnil, IMO this patch should be split. one to support non zero master
lane for DP and the other for 100MHz DP multilink.

Later when say 19.2MHz DP multilink support is added, it should look
similar to how it's added for 100MHz DP multilink patch.

Please also provide the details of testing (here or in the cover letter).

Thanks
Kishon
