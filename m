Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4137F338
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhEMGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:49:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46242 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:49:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D6mT8U103781;
        Thu, 13 May 2021 01:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620888509;
        bh=YM9jQqwJ6ARigSutj6Ij3NgjDZfo4dlj4EN8wKI6yXU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EDAW4s2qQUeGJiqdGIoxW9ndL8SFdtVilzwUl39NMaA3Ev3zdppyURZE5j7H/t5WK
         xqnrLa/1s2mVUCJOVt/wzsVZjfI0lM587Y6LWsG7oKEhgHuRYYot4F/X9QAGkG6CeV
         ErMO/MMbEfh2Eqdvh5B5OdsrinMB0vZyCyfr6LyE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D6mTsa111623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 01:48:29 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 01:48:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 01:48:29 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D6mODO088816;
        Thu, 13 May 2021 01:48:25 -0500
Subject: Re: [PATCH 04/14] phy: cadence-torrent: Select register configuration
 based on PHY reference clock
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-5-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bec56d27-8646-dd19-8bc3-1e8cb108f6d1@ti.com>
Date:   Thu, 13 May 2021 12:18:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-5-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Add PHY input reference clock frequency as a new dimension to select proper
> register configuration.

Please add additional details in the commit message here as to why you
are doing this change and also mention you don't expect any functional
change with this patch.

Thanks
Kishon
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 830 +++++++++++-----------
>  1 file changed, 422 insertions(+), 408 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 252920ea7fdf..39a26a1a4c51 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -375,12 +375,12 @@ struct cdns_torrent_data {
>  						[NUM_SSC_MODE];
>  	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
>  					      [NUM_SSC_MODE];
> -	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> -					  [NUM_SSC_MODE];
> -	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> -					    [NUM_SSC_MODE];
> -	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> -					    [NUM_SSC_MODE];
> +	struct cdns_torrent_vals *cmn_vals[NUM_REF_CLK][NUM_PHY_TYPE]
> +					  [NUM_PHY_TYPE][NUM_SSC_MODE];
> +	struct cdns_torrent_vals *tx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
> +					    [NUM_PHY_TYPE][NUM_SSC_MODE];
> +	struct cdns_torrent_vals *rx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
> +					    [NUM_PHY_TYPE][NUM_SSC_MODE];
>  };
>  
>  struct cdns_regmap_cdb_context {
> @@ -1958,6 +1958,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
>  	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
>  	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
> +	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
>  	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
>  	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
>  	enum cdns_torrent_phy_type phy_type = inst->phy_type;
> @@ -2023,7 +2024,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	}
>  
>  	/* PMA common registers configurations */
> -	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
> +	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
>  	if (cmn_vals) {
>  		reg_pairs = cmn_vals->reg_pairs;
>  		num_regs = cmn_vals->num_regs;
> @@ -2034,7 +2035,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	}
>  
>  	/* PMA TX lane registers configurations */
> -	tx_ln_vals = init_data->tx_ln_vals[phy_type][TYPE_NONE][ssc];
> +	tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
>  	if (tx_ln_vals) {
>  		reg_pairs = tx_ln_vals->reg_pairs;
>  		num_regs = tx_ln_vals->num_regs;
> @@ -2047,7 +2048,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
>  	}
>  
>  	/* PMA RX lane registers configurations */
> -	rx_ln_vals = init_data->rx_ln_vals[phy_type][TYPE_NONE][ssc];
> +	rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
>  	if (rx_ln_vals) {
>  		reg_pairs = rx_ln_vals->reg_pairs;
>  		num_regs = rx_ln_vals->num_regs;
> @@ -2088,6 +2089,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  {
>  	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
>  	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
> +	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
>  	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
>  	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
>  	struct cdns_torrent_vals *pcs_cmn_vals;
> @@ -2176,7 +2178,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  		}
>  
>  		/* PMA common registers configurations */
> -		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
> +		cmn_vals = init_data->cmn_vals[ref_clk][phy_t1][phy_t2][ssc];
>  		if (cmn_vals) {
>  			reg_pairs = cmn_vals->reg_pairs;
>  			num_regs = cmn_vals->num_regs;
> @@ -2187,7 +2189,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  		}
>  
>  		/* PMA TX lane registers configurations */
> -		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
> +		tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
>  		if (tx_ln_vals) {
>  			reg_pairs = tx_ln_vals->reg_pairs;
>  			num_regs = tx_ln_vals->num_regs;
> @@ -2200,7 +2202,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  		}
>  
>  		/* PMA RX lane registers configurations */
> -		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
> +		rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
>  		if (rx_ln_vals) {
>  			reg_pairs = rx_ln_vals->reg_pairs;
>  			num_regs = rx_ln_vals->num_regs;
> @@ -3496,230 +3498,236 @@ static const struct cdns_torrent_data cdns_map_torrent = {
>  		},
>  	},
>  	.cmn_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
>  			},
>  		},
>  	},
>  	.tx_ln_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  		},
>  	},
>  	.rx_ln_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  		},
>  	},
> @@ -3905,230 +3913,236 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
>  		},
>  	},
>  	.cmn_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> -				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
> +					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
> +				},
>  			},
>  		},
>  	},
>  	.tx_ln_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = NULL,
> +					[EXTERNAL_SSC] = NULL,
> +					[INTERNAL_SSC] = NULL,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = NULL,
> -				[EXTERNAL_SSC] = NULL,
> -				[INTERNAL_SSC] = NULL,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
> +				},
>  			},
>  		},
>  	},
>  	.rx_ln_vals = {
> -		[TYPE_PCIE] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +		[CLK_100_MHZ] = {
> +			[TYPE_PCIE] = {
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_SGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_QSGMII] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_SGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_USB] = {
> +					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  			[TYPE_USB] = {
> -				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_QSGMII] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_USB] = {
> -				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
> -			},
> -		},
> -		[TYPE_USB] = {
> -			[TYPE_NONE] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_PCIE] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_SGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -			},
> -			[TYPE_QSGMII] = {
> -				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> -				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				[TYPE_NONE] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_PCIE] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_SGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
> +				[TYPE_QSGMII] = {
> +					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
> +				},
>  			},
>  		},
>  	},
> 
