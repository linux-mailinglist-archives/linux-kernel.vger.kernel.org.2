Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31B459B43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhKWEgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhKWEgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:36:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EFD86104F;
        Tue, 23 Nov 2021 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637641986;
        bh=WMJ0SUwHiEh+5VwvYdRoIq8Y62uB4ILz7Td2erOQqiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQw8Dl+gg+/dtJFb+l1ps+/4npWKzUKcHobsgkSiCS4CioAnl3nsxjgC80H4tZmc7
         UgqmUfrqQq3v5Us6I5ehHDWLlakZwQUiMkApV4tjO7sMrSiHFV91fTEP5RmBLmXNJL
         wDb1QQ1pty0JC3vPIUEsk35QOwSMz/RHpY3o9BnVAnYsROcD1oLFcZxIFsfRM9xwkg
         q5bwBxKNb42Z5osk2VLRA0AUgeC0unK2ZjAB4H7ByHeNj5p3OIUoJ4HELKB1ciMjsG
         Csxvk+2ZzVoXmslJYtUNH+KpBqIyRA/UV5oZnjA/4ZELXnLohnyoyuS6lEKHHzNHpL
         Uwneq6zvUI4gg==
Date:   Tue, 23 Nov 2021 10:03:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, a-govindraju@ti.com
Subject: Re: [PATCH v3 02/15] phy: cadence: Sierra: Prepare driver to add
 support for multilink configurations
Message-ID: <YZxu/Tzo4fdiHKtR@matsya>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-3-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022170236.18839-3-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-21, 19:02, Swapnil Jakhade wrote:
> Sierra driver currently supports single link configurations only. Prepare
> driver to support multilink multiprotocol configurations along with
> different SSC modes.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 195 ++++++++++++++++-------
>  1 file changed, 139 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index 54d1c63932ac..c82ac6716f5e 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -23,6 +23,9 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/phy/phy-cadence.h>
>  
> +#define NUM_SSC_MODE		3
> +#define NUM_PHY_TYPE		3
> +
>  /* PHY register offsets */
>  #define SIERRA_COMMON_CDB_OFFSET			0x0
>  #define SIERRA_MACRO_ID_REG				0x0
> @@ -217,9 +220,21 @@ static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
>  
>  static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
>  
> +enum cdns_sierra_phy_type {
> +	TYPE_NONE,

What does NONE type mean?

> +	TYPE_PCIE,
> +	TYPE_USB
> +};
> +
> +enum cdns_sierra_ssc_mode {
> +	NO_SSC,
> +	EXTERNAL_SSC,
> +	INTERNAL_SSC
> +};
> +
>  struct cdns_sierra_inst {
>  	struct phy *phy;
> -	u32 phy_type;
> +	enum cdns_sierra_phy_type phy_type;
>  	u32 num_lanes;
>  	u32 mlane;
>  	struct reset_control *lnk_rst;
> @@ -230,18 +245,19 @@ struct cdns_reg_pairs {
>  	u32 off;
>  };
>  
> +struct cdns_sierra_vals {
> +	const struct cdns_reg_pairs *reg_pairs;
> +	u32 num_regs;
> +};
> +
>  struct cdns_sierra_data {
> -		u32 id_value;
> -		u8 block_offset_shift;
> -		u8 reg_offset_shift;
> -		u32 pcie_cmn_regs;
> -		u32 pcie_ln_regs;
> -		u32 usb_cmn_regs;
> -		u32 usb_ln_regs;
> -		const struct cdns_reg_pairs *pcie_cmn_vals;
> -		const struct cdns_reg_pairs *pcie_ln_vals;
> -		const struct cdns_reg_pairs *usb_cmn_vals;
> -		const struct cdns_reg_pairs *usb_ln_vals;
> +	u32 id_value;
> +	u8 block_offset_shift;
> +	u8 reg_offset_shift;
> +	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> +					     [NUM_SSC_MODE];
> +	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> +					    [NUM_SSC_MODE];

You have defined phy type and ssc, that sounds fine, I am not sure why
you need a third dimension here? What purpose does it solve?

>  };
>  
>  struct cdns_regmap_cdb_context {
> @@ -341,10 +357,14 @@ static int cdns_sierra_phy_init(struct phy *gphy)
>  {
>  	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
>  	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
> +	const struct cdns_sierra_data *init_data = phy->init_data;
> +	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
> +	enum cdns_sierra_phy_type phy_type = ins->phy_type;
> +	enum cdns_sierra_ssc_mode ssc = EXTERNAL_SSC;
> +	const struct cdns_reg_pairs *reg_pairs;
>  	struct regmap *regmap;
> +	u32 num_regs;
>  	int i, j;
> -	const struct cdns_reg_pairs *cmn_vals, *ln_vals;
> -	u32 num_cmn_regs, num_ln_regs;
>  
>  	/* Initialise the PHY registers, unless auto configured */
>  	if (phy->autoconf)
> @@ -352,28 +372,26 @@ static int cdns_sierra_phy_init(struct phy *gphy)
>  
>  	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
>  	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
> -	if (ins->phy_type == PHY_TYPE_PCIE) {
> -		num_cmn_regs = phy->init_data->pcie_cmn_regs;
> -		num_ln_regs = phy->init_data->pcie_ln_regs;
> -		cmn_vals = phy->init_data->pcie_cmn_vals;
> -		ln_vals = phy->init_data->pcie_ln_vals;
> -	} else if (ins->phy_type == PHY_TYPE_USB3) {
> -		num_cmn_regs = phy->init_data->usb_cmn_regs;
> -		num_ln_regs = phy->init_data->usb_ln_regs;
> -		cmn_vals = phy->init_data->usb_cmn_vals;
> -		ln_vals = phy->init_data->usb_ln_vals;
> -	} else {
> -		return -EINVAL;
> -	}
>  
> -	regmap = phy->regmap_common_cdb;
> -	for (j = 0; j < num_cmn_regs ; j++)
> -		regmap_write(regmap, cmn_vals[j].off, cmn_vals[j].val);
> +	/* PMA common registers configurations */
> +	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
> +	if (pma_cmn_vals) {
> +		reg_pairs = pma_cmn_vals->reg_pairs;
> +		num_regs = pma_cmn_vals->num_regs;
> +		regmap = phy->regmap_common_cdb;
> +		for (i = 0; i < num_regs; i++)
> +			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
> +	}
>  
> -	for (i = 0; i < ins->num_lanes; i++) {
> -		for (j = 0; j < num_ln_regs ; j++) {
> +	/* PMA lane registers configurations */
> +	pma_ln_vals = init_data->pma_ln_vals[phy_type][TYPE_NONE][ssc];
> +	if (pma_ln_vals) {
> +		reg_pairs = pma_ln_vals->reg_pairs;
> +		num_regs = pma_ln_vals->num_regs;
> +		for (i = 0; i < ins->num_lanes; i++) {
>  			regmap = phy->regmap_lane_cdb[i + ins->mlane];
> -			regmap_write(regmap, ln_vals[j].off, ln_vals[j].val);
> +			for (j = 0; j < num_regs; j++)
> +				regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
>  		}
>  	}
>  
> @@ -583,15 +601,28 @@ static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
>  static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
>  				    struct device_node *child)
>  {
> +	u32 phy_type;
> +
>  	if (of_property_read_u32(child, "reg", &inst->mlane))
>  		return -EINVAL;
>  
>  	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
>  		return -EINVAL;
>  
> -	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
> +	if (of_property_read_u32(child, "cdns,phy-type", &phy_type))
>  		return -EINVAL;
>  
> +	switch (phy_type) {
> +	case PHY_TYPE_PCIE:
> +		inst->phy_type = TYPE_PCIE;
> +		break;
> +	case PHY_TYPE_USB3:
> +		inst->phy_type = TYPE_USB;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1006,6 +1037,16 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
>  	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
>  };
>  
> +static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
> +	.reg_pairs = cdns_pcie_cmn_regs_ext_ssc,
> +	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> +};
> +
> +static struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals = {
> +	.reg_pairs = cdns_pcie_ln_regs_ext_ssc,
> +	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> +};
> +
>  /* refclk100MHz_20b_USB_cmn_pll_ext_ssc */
>  static const struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
>  	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> @@ -1113,32 +1154,74 @@ static const struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
>  	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}
>  };
>  
> +static struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals = {
> +	.reg_pairs = cdns_usb_cmn_regs_ext_ssc,
> +	.num_regs = ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> +};
> +
> +static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
> +	.reg_pairs = cdns_usb_ln_regs_ext_ssc,
> +	.num_regs = ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> +};
> +
>  static const struct cdns_sierra_data cdns_map_sierra = {
> -	SIERRA_MACRO_ID,
> -	0x2,
> -	0x2,
> -	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> -	cdns_pcie_cmn_regs_ext_ssc,
> -	cdns_pcie_ln_regs_ext_ssc,
> -	cdns_usb_cmn_regs_ext_ssc,
> -	cdns_usb_ln_regs_ext_ssc,
> +	.id_value = SIERRA_MACRO_ID,
> +	.block_offset_shift = 0x2,
> +	.reg_offset_shift = 0x2,
> +	.pma_cmn_vals = {
> +		[TYPE_PCIE] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
> +			},
> +		},
> +		[TYPE_USB] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
> +			},
> +		},
> +	},
> +	.pma_ln_vals = {
> +		[TYPE_PCIE] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
> +			},
> +		},
> +		[TYPE_USB] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
> +			},
> +		},
> +	},
>  };
>  
>  static const struct cdns_sierra_data cdns_ti_map_sierra = {
> -	SIERRA_MACRO_ID,
> -	0x0,
> -	0x1,
> -	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> -	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> -	cdns_pcie_cmn_regs_ext_ssc,
> -	cdns_pcie_ln_regs_ext_ssc,
> -	cdns_usb_cmn_regs_ext_ssc,
> -	cdns_usb_ln_regs_ext_ssc,
> +	.id_value = SIERRA_MACRO_ID,
> +	.block_offset_shift = 0x0,
> +	.reg_offset_shift = 0x1,
> +	.pma_cmn_vals = {
> +		[TYPE_PCIE] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
> +			},
> +		},
> +		[TYPE_USB] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
> +			},
> +		},
> +	},
> +	.pma_ln_vals = {
> +		[TYPE_PCIE] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
> +			},
> +		},
> +		[TYPE_USB] = {
> +			[TYPE_NONE] = {
> +				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
> +			},
> +		},
> +	},
>  };
>  
>  static const struct of_device_id cdns_sierra_id_table[] = {
> -- 
> 2.26.1

-- 
~Vinod
