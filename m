Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691EE37F3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhEMHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:48:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhEMHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:48:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D7lCV7129730;
        Thu, 13 May 2021 02:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620892032;
        bh=QDWqwx1gf8f3V7AtFn1vm/kiWoZ6TPo3awiUQv8OkPs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AiHgsg5HbzLRgunBQZn9eMhR5VtCDYzCFA5gh9dhszQoXsg6bJOTyHPQUa4aUinCn
         BErDZq5oirl520JBLI4CN8ieYXrqsq6g98N3CRFZUwhBtSNwq3ropWDmEWp+rk3Tan
         KA4zN1CvBqeeqjiwD8U1oI7T5wFREqv9Q+OGJnE0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D7lBHs061314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:47:11 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:47:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:47:11 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D7l8WY056199;
        Thu, 13 May 2021 02:47:09 -0500
Subject: Re: [PATCH 12/14] phy: cadence-torrent: Add PCIe + DP multilink
 configuration
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-13-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58a18b90-9062-a44c-f712-977025142de5@ti.com>
Date:   Thu, 13 May 2021 13:17:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-13-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Add PCIe + DP no SSC multilink configuration sequences.

Looks neat! Exactly how it was all intended to look like. Thanks!

I would defer merging this till it gets tested in a platform though.

Thanks
Kishon

> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 131 ++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index becbf8456b2d..bf37569c6c51 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -2572,6 +2572,77 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/* PCIe and DP link configuration */
> +static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
> +	{0x0003, PHY_PLL_CFG},
> +	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
> +	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1}
> +};
> +
> +static struct cdns_reg_pairs pcie_dp_xcvr_diag_ln_regs[] = {
> +	{0x0000, XCVR_DIAG_HSCLK_SEL},
> +	{0x0001, XCVR_DIAG_HSCLK_DIV},
> +	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
> +};
> +
> +static struct cdns_reg_pairs dp_pcie_xcvr_diag_ln_regs[] = {
> +	{0x0001, XCVR_DIAG_HSCLK_SEL},
> +	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
> +};
> +
> +static struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
> +	.reg_pairs = pcie_dp_link_cmn_regs,
> +	.num_regs = ARRAY_SIZE(pcie_dp_link_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
> +	.reg_pairs = pcie_dp_xcvr_diag_ln_regs,
> +	.num_regs = ARRAY_SIZE(pcie_dp_xcvr_diag_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
> +	.reg_pairs = dp_pcie_xcvr_diag_ln_regs,
> +	.num_regs = ARRAY_SIZE(dp_pcie_xcvr_diag_ln_regs),
> +};
> +
> +/* DP Multilink, 100 MHz Ref clk, no SSC */
> +static struct cdns_reg_pairs dp_100_no_ssc_cmn_regs[] = {
> +	{0x007F, CMN_TXPUCAL_TUNE},
> +	{0x007F, CMN_TXPDCAL_TUNE}
> +};
> +
> +static struct cdns_reg_pairs dp_100_no_ssc_tx_ln_regs[] = {
> +	{0x00FB, TX_PSC_A0},
> +	{0x04AA, TX_PSC_A2},
> +	{0x04AA, TX_PSC_A3},
> +	{0x000F, XCVR_DIAG_BIDI_CTRL}
> +};
> +
> +static struct cdns_reg_pairs dp_100_no_ssc_rx_ln_regs[] = {
> +	{0x0000, RX_PSC_A0},
> +	{0x0000, RX_PSC_A2},
> +	{0x0000, RX_PSC_A3},
> +	{0x0000, RX_PSC_CAL},
> +	{0x0000, RX_REE_GCSM1_CTRL},
> +	{0x0000, RX_REE_GCSM2_CTRL},
> +	{0x0000, RX_REE_PERGCSM_CTRL}
> +};
> +
> +static struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
> +	.reg_pairs = dp_100_no_ssc_cmn_regs,
> +	.num_regs = ARRAY_SIZE(dp_100_no_ssc_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
> +	.reg_pairs = dp_100_no_ssc_tx_ln_regs,
> +	.num_regs = ARRAY_SIZE(dp_100_no_ssc_tx_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
> +	.reg_pairs = dp_100_no_ssc_rx_ln_regs,
> +	.num_regs = ARRAY_SIZE(dp_100_no_ssc_rx_ln_regs),
> +};
> +
>  /* Single DisplayPort(DP) link configuration */
>  static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
>  	{0x0000, PHY_PLL_CFG},
> @@ -3514,6 +3585,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = &sl_dp_link_cmn_vals,
>  			},
> +			[TYPE_PCIE] = {
> +				[NO_SSC] = &pcie_dp_link_cmn_vals,
> +			},
>  		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
> @@ -3536,6 +3610,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
>  				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
>  			},
> +			[TYPE_DP] = {
> +				[NO_SSC] = &pcie_dp_link_cmn_vals,
> +			},
>  		},
>  		[TYPE_SGMII] = {
>  			[TYPE_NONE] = {
> @@ -3595,6 +3672,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
>  			},
> +			[TYPE_PCIE] = {
> +				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
> +			},
>  		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
> @@ -3617,6 +3697,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
>  				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
>  			},
> +			[TYPE_DP] = {
> +				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
> +			},
>  		},
>  		[TYPE_SGMII] = {
>  			[TYPE_NONE] = {
> @@ -3715,6 +3798,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3737,6 +3823,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
>  					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> @@ -3812,6 +3901,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3834,6 +3926,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  					[EXTERNAL_SSC] = NULL,
>  					[INTERNAL_SSC] = NULL,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> @@ -3909,6 +4004,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -3931,6 +4029,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
>  					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> @@ -3996,6 +4097,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = &sl_dp_link_cmn_vals,
>  			},
> +			[TYPE_PCIE] = {
> +				[NO_SSC] = &pcie_dp_link_cmn_vals,
> +			},
>  		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
> @@ -4018,6 +4122,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
>  				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
>  			},
> +			[TYPE_DP] = {
> +				[NO_SSC] = &pcie_dp_link_cmn_vals,
> +			},
>  		},
>  		[TYPE_SGMII] = {
>  			[TYPE_NONE] = {
> @@ -4077,6 +4184,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  			[TYPE_NONE] = {
>  				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
>  			},
> +			[TYPE_PCIE] = {
> +				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
> +			},
>  		},
>  		[TYPE_PCIE] = {
>  			[TYPE_NONE] = {
> @@ -4099,6 +4209,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
>  				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
>  			},
> +			[TYPE_DP] = {
> +				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
> +			},
>  		},
>  		[TYPE_SGMII] = {
>  			[TYPE_NONE] = {
> @@ -4197,6 +4310,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -4219,6 +4335,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
>  					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> @@ -4294,6 +4413,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -4316,6 +4438,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  					[EXTERNAL_SSC] = NULL,
>  					[INTERNAL_SSC] = NULL,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> @@ -4391,6 +4516,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  				[TYPE_NONE] = {
>  					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
>  				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_PCIE] = {
>  				[TYPE_NONE] = {
> @@ -4413,6 +4541,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
>  					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
>  				},
> +				[TYPE_DP] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
>  				[TYPE_NONE] = {
> 
