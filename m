Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFC459B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhKWEv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhKWEvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:51:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C43A61038;
        Tue, 23 Nov 2021 04:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637642898;
        bh=FkOu3Dt3TH8WPLxyLnZt6/I3w6/iR7f3J5aWGoEJawA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoWQM3nRZu7hi8mmLLE6+PaF8Ne3/G+6W3Jimne3OS7tKSgJuvovw23YFQVL9Wc/T
         M+EmZckrevQh0ZK1UjGt5AbrKjaAGnNJFAd3O5NG9knlJ6dWRNS8MPQd3h1U3IA0XR
         kWzIxPQs//RyZs1ur9IhlyyvUw6Jb5iwLKGAQQQy1o0oioK31IsM9SY9Mvs0mmFjUH
         5ohFgzIhXdATA9zdtB6WClgumJKok53HugFfcQzqZrSV2zZj74D++JSy95+NqHDycw
         sV2sN1MnvKxCzmggeE3p7dGyaTw2Lxb3LM06N00s/tVKRU7IAx/JtN8NhbksErdFoC
         1P2B+oRpUswOA==
Date:   Tue, 23 Nov 2021 10:18:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, a-govindraju@ti.com
Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Message-ID: <YZxyja2xEkpWvStR@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022170236.18839-14-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-21, 19:02, Swapnil Jakhade wrote:
> Add register sequences for PCIe + QSGMII PHY multilink configuration.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 377 ++++++++++++++++++++++-
>  1 file changed, 376 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index a39be67424a1..0deb627845b1 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -45,6 +45,9 @@
>  #define SIERRA_CMN_REFRCV_PREG				0x98
>  #define SIERRA_CMN_REFRCV1_PREG				0xB8
>  #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
> +#define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
> +#define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
> +#define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
>  
>  #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
>  				((0x4000 << (block_offset)) + \
> @@ -59,6 +62,9 @@
>  #define SIERRA_PSM_A0IN_TMR_PREG			0x009
>  #define SIERRA_PSM_A3IN_TMR_PREG			0x00C
>  #define SIERRA_PSM_DIAG_PREG				0x015
> +#define SIERRA_PSC_LN_A3_PREG				0x023
> +#define SIERRA_PSC_LN_A4_PREG				0x024
> +#define SIERRA_PSC_LN_IDLE_PREG				0x026
>  #define SIERRA_PSC_TX_A0_PREG				0x028
>  #define SIERRA_PSC_TX_A1_PREG				0x029
>  #define SIERRA_PSC_TX_A2_PREG				0x02A
> @@ -68,6 +74,7 @@
>  #define SIERRA_PSC_RX_A2_PREG				0x032
>  #define SIERRA_PSC_RX_A3_PREG				0x033
>  #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
> +#define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
>  #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
>  #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
>  #define SIERRA_PLLCTRL_STATUS_PREG			0x044
> @@ -150,6 +157,7 @@
>  #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
>  #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
>  #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
> +#define SIERRA_CPI_RESBIAS_BIN_PREG			0x17E
>  #define SIERRA_CPI_TRIM_PREG				0x17F
>  #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
>  #define SIERRA_EPI_CTRL_PREG				0x187
> @@ -272,7 +280,8 @@ static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
>  enum cdns_sierra_phy_type {
>  	TYPE_NONE,
>  	TYPE_PCIE,
> -	TYPE_USB
> +	TYPE_USB,
> +	TYPE_QSGMII
>  };
>  
>  enum cdns_sierra_ssc_mode {
> @@ -807,6 +816,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
>  	case PHY_TYPE_USB3:
>  		inst->phy_type = TYPE_USB;
>  		break;
> +	case PHY_TYPE_QSGMII:
> +		inst->phy_type = TYPE_QSGMII;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1186,6 +1198,9 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
>  					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
>  			}
>  		}
> +
> +		if (phy_t1 == TYPE_QSGMII)
> +			reset_control_deassert(sp->phys[node].lnk_rst);
>  	}
>  
>  	/* Take the PHY out of reset */
> @@ -1363,6 +1378,72 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/* QSGMII PHY PMA lane configuration */
> +static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
> +	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
> +};
> +
> +static struct cdns_sierra_vals qsgmii_phy_pma_ln_vals = {
> +	.reg_pairs = qsgmii_phy_pma_ln_regs,
> +	.num_regs = ARRAY_SIZE(qsgmii_phy_pma_ln_regs),
> +};
> +
> +/* QSGMII refclk 100MHz, 20b, opt1, No BW cal, no ssc, PLL LC1 */
> +static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_cmn_regs[] = {
> +	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
> +	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
> +	{0x0000, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
> +};
> +
> +static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_ln_regs[] = {
> +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> +	{0x0252, SIERRA_DET_STANDEC_E_PREG},
> +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> +	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
> +	{0x0011, SIERRA_PLLCTRL_SUBRATE_PREG},
> +	{0x0001, SIERRA_PLLCTRL_GEN_A_PREG},
> +	{0x5233, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
> +	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
> +	{0x0089, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> +	{0x3C3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
> +	{0x3222, SIERRA_CREQ_FSMCLK_SEL_PREG},
> +	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
> +	{0x8422, SIERRA_CTLELUT_CTRL_PREG},
> +	{0x4111, SIERRA_DFE_ECMP_RATESEL_PREG},
> +	{0x4111, SIERRA_DFE_SMP_RATESEL_PREG},
> +	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
> +	{0x9595, SIERRA_DEQ_VGATUNE_CTRL_PREG},
> +	{0x0186, SIERRA_DEQ_GLUT0},
> +	{0x0186, SIERRA_DEQ_GLUT1},
> +	{0x0186, SIERRA_DEQ_GLUT2},
> +	{0x0186, SIERRA_DEQ_GLUT3},
> +	{0x0186, SIERRA_DEQ_GLUT4},
> +	{0x0861, SIERRA_DEQ_ALUT0},
> +	{0x07E0, SIERRA_DEQ_ALUT1},
> +	{0x079E, SIERRA_DEQ_ALUT2},
> +	{0x071D, SIERRA_DEQ_ALUT3},
> +	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
> +	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
> +	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> +	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
> +	{0x0033, SIERRA_DEQ_PICTRL_PREG},
> +	{0x0660, SIERRA_CPICAL_TMRVAL_MODE0_PREG},
> +	{0x00D5, SIERRA_CPI_OUTBUF_RATESEL_PREG},
> +	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
> +	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
> +	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
> +};
> +
> +static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals = {
> +	.reg_pairs = qsgmii_100_no_ssc_plllc1_cmn_regs,
> +	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_cmn_regs),
> +};
> +
> +static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals = {
> +	.reg_pairs = qsgmii_100_no_ssc_plllc1_ln_regs,
> +	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_ln_regs),
> +};
> +
>  /* PCIE PHY PCS common configuration */
>  static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
>  	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
> @@ -1373,6 +1454,233 @@ static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
>  	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
>  };
>  
> +/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc, pcie_links_using_plllc, pipe_bw_3 */
> +static const struct cdns_reg_pairs pcie_100_no_ssc_plllc_cmn_regs[] = {
> +	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> +	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
> +};
> +
> +/*
> + * refclk100MHz_32b_PCIe_ln_no_ssc, multilink, using_plllc,
> + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
> + */
> +static const struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] = {
> +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> +	{0x8055, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> +	{0x80BB, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> +	{0x8351, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> +	{0x8349, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> +	{0x0041, SIERRA_DEQ_GLUT0},
> +	{0x0082, SIERRA_DEQ_GLUT1},
> +	{0x00C3, SIERRA_DEQ_GLUT2},
> +	{0x0145, SIERRA_DEQ_GLUT3},
> +	{0x0186, SIERRA_DEQ_GLUT4},
> +	{0x09E7, SIERRA_DEQ_ALUT0},
> +	{0x09A6, SIERRA_DEQ_ALUT1},
> +	{0x0965, SIERRA_DEQ_ALUT2},
> +	{0x08E3, SIERRA_DEQ_ALUT3},
> +	{0x00FA, SIERRA_DEQ_DFETAP0},
> +	{0x00FA, SIERRA_DEQ_DFETAP1},
> +	{0x00FA, SIERRA_DEQ_DFETAP2},
> +	{0x00FA, SIERRA_DEQ_DFETAP3},
> +	{0x00FA, SIERRA_DEQ_DFETAP4},
> +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> +	{0x002B, SIERRA_CPI_TRIM_PREG},
> +	{0x0003, SIERRA_EPI_CTRL_PREG},
> +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
> +};
> +
> +static struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals = {
> +	.reg_pairs = pcie_100_no_ssc_plllc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(pcie_100_no_ssc_plllc_cmn_regs),
> +};
> +
> +static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
> +	.reg_pairs = ml_pcie_100_no_ssc_ln_regs,
> +	.num_regs = ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
> +};
> +
> +/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc, pcie_links_using_plllc, pipe_bw_3 */
> +static const struct cdns_reg_pairs pcie_100_int_ssc_plllc_cmn_regs[] = {
> +	{0x000E, SIERRA_CMN_PLLLC_MODE_PREG},
> +	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> +	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> +	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> +	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
> +	{0x0581, SIERRA_CMN_PLLLC_DSMCORR_PREG},
> +	{0x7F80, SIERRA_CMN_PLLLC_SS_PREG},
> +	{0x0041, SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG},
> +	{0x0464, SIERRA_CMN_PLLLC_SSTWOPT_PREG},
> +	{0x0D0D, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG},
> +	{0x0060, SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG}
> +};
> +
> +/*
> + * refclk100MHz_32b_PCIe_ln_int_ssc, multilink, using_plllc,
> + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
> + */
> +static const struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] = {
> +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> +	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
> +	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> +	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
> +	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
> +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> +	{0x0041, SIERRA_DEQ_GLUT0},
> +	{0x0082, SIERRA_DEQ_GLUT1},
> +	{0x00C3, SIERRA_DEQ_GLUT2},
> +	{0x0145, SIERRA_DEQ_GLUT3},
> +	{0x0186, SIERRA_DEQ_GLUT4},
> +	{0x09E7, SIERRA_DEQ_ALUT0},
> +	{0x09A6, SIERRA_DEQ_ALUT1},
> +	{0x0965, SIERRA_DEQ_ALUT2},
> +	{0x08E3, SIERRA_DEQ_ALUT3},
> +	{0x00FA, SIERRA_DEQ_DFETAP0},
> +	{0x00FA, SIERRA_DEQ_DFETAP1},
> +	{0x00FA, SIERRA_DEQ_DFETAP2},
> +	{0x00FA, SIERRA_DEQ_DFETAP3},
> +	{0x00FA, SIERRA_DEQ_DFETAP4},
> +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> +	{0x002B, SIERRA_CPI_TRIM_PREG},
> +	{0x0003, SIERRA_EPI_CTRL_PREG},
> +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
> +};
> +
> +static struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals = {
> +	.reg_pairs = pcie_100_int_ssc_plllc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_plllc_cmn_regs),
> +};
> +
> +static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
> +	.reg_pairs = ml_pcie_100_int_ssc_ln_regs,
> +	.num_regs = ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
> +};
> +
> +/* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc, pcie_links_using_plllc, pipe_bw_3 */
> +static const struct cdns_reg_pairs pcie_100_ext_ssc_plllc_cmn_regs[] = {
> +	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> +	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
> +	{0x1B1B, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
> +};
> +
> +/*
> + * refclk100MHz_32b_PCIe_ln_ext_ssc, multilink, using_plllc,
> + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
> + */
> +static const struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] = {
> +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> +	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
> +	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> +	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
> +	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
> +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> +	{0x0041, SIERRA_DEQ_GLUT0},
> +	{0x0082, SIERRA_DEQ_GLUT1},
> +	{0x00C3, SIERRA_DEQ_GLUT2},
> +	{0x0145, SIERRA_DEQ_GLUT3},
> +	{0x0186, SIERRA_DEQ_GLUT4},
> +	{0x09E7, SIERRA_DEQ_ALUT0},
> +	{0x09A6, SIERRA_DEQ_ALUT1},
> +	{0x0965, SIERRA_DEQ_ALUT2},
> +	{0x08E3, SIERRA_DEQ_ALUT3},
> +	{0x00FA, SIERRA_DEQ_DFETAP0},
> +	{0x00FA, SIERRA_DEQ_DFETAP1},
> +	{0x00FA, SIERRA_DEQ_DFETAP2},
> +	{0x00FA, SIERRA_DEQ_DFETAP3},
> +	{0x00FA, SIERRA_DEQ_DFETAP4},
> +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> +	{0x002B, SIERRA_CPI_TRIM_PREG},
> +	{0x0003, SIERRA_EPI_CTRL_PREG},
> +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
> +};
> +
> +static struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals = {
> +	.reg_pairs = pcie_100_ext_ssc_plllc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(pcie_100_ext_ssc_plllc_cmn_regs),
> +};
> +
> +static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
> +	.reg_pairs = ml_pcie_100_ext_ssc_ln_regs,
> +	.num_regs = ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
> +};
> +
>  /* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
>  static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
>  	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> @@ -1710,6 +2018,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
>  				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
>  				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
>  			},
> +			[TYPE_QSGMII] = {
> +				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
> +				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
> +				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
> +			},
>  		},
>  	},
>  	.pma_cmn_vals = {
> @@ -1719,12 +2032,24 @@ static const struct cdns_sierra_data cdns_map_sierra = {
>  				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
>  				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
>  			},
> +			[TYPE_QSGMII] = {

so this is pcie->qsgmii ->ssc/external/internal ... ok

> +				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
> +				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
> +				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
> +			},
>  		},
>  		[TYPE_USB] = {
>  			[TYPE_NONE] = {
>  				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
>  			},
>  		},
> +		[TYPE_QSGMII] = {
> +			[TYPE_PCIE] = {

now it is reverse! qsgmii -> pcie -> ... why?

what is meant by pcie->qsgmii and qsgmii-> pcie?

-- 
~Vinod
