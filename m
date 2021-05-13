Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7937F3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhEMH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:57:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEMH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:57:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D7tsmS003169;
        Thu, 13 May 2021 02:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620892554;
        bh=+zVUSUkg/G0NNU3XL9lDbVgZBOyUL+C7wchqqWrHSyo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D9jhZ2InWu+ff/0bVS93nIVuE1TNYJdF2GzQA0suf1tnx4rWS9pZ9UIaFviIJgI5R
         zWcwtSjbpjGxrN0gY0ehKL2zjpMTBeVgrAtr4wKTpiLNkPMeUyXJHyQvQNoD7L4Wp5
         jcGvWUHskrTBdT7YZ2zPKXChELW04xzpbD0poSB4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D7tsEW093833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:55:54 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:55:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:55:54 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D7tod9069248;
        Thu, 13 May 2021 02:55:51 -0500
Subject: Re: [PATCH 14/14] phy: cadence-torrent: Check PIPE mode PHY status to
 be ready for operation
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-15-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1527d8b6-6976-e37e-746f-88ea0f8f7688@ti.com>
Date:   Thu, 13 May 2021 13:25:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-15-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> PIPE PHY status is used to communicate the completion of several PHY
> functions. Check if PHY is ready for operation while configured for
> PIPE mode during startup.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 60 +++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 39145e56e061..42a1bdfd18d5 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -51,6 +51,10 @@
>  #define TORRENT_PHY_PCS_COMMON_OFFSET(block_offset)	\
>  				(0xC000 << (block_offset))
>  
> +#define TORRENT_PHY_PCS_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
> +				((0xD000 << (block_offset)) +		\
> +				(((ln) << 9) << (reg_offset)))
> +
>  #define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
>  				(0xE000 << (block_offset))
>  
> @@ -218,6 +222,9 @@
>  #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
>  #define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
>  
> +/* PHY PCS lane registers */
> +#define PHY_PCS_ISO_LINK_CTRL		0x000BU
> +
>  /* PHY PMA common registers */
>  #define PHY_PMA_CMN_CTRL1		0x0000U
>  #define PHY_PMA_CMN_CTRL2		0x0001U
> @@ -242,6 +249,9 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
>  static const struct reg_field phy_reset_ctrl =
>  				REG_FIELD(PHY_RESET, 8, 8);
>  
> +static const struct reg_field phy_pcs_iso_link_ctrl_1 =
> +				REG_FIELD(PHY_PCS_ISO_LINK_CTRL, 1, 1);
> +
>  static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
>  
>  #define REFCLK_OUT_NUM_CMN_CONFIG	5
> @@ -316,12 +326,14 @@ struct cdns_torrent_phy {
>  	struct regmap *regmap_phy_pma_common_cdb;
>  	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
>  	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
> +	struct regmap *regmap_phy_pcs_lane_cdb[MAX_NUM_LANES];
>  	struct regmap *regmap_dptx_phy_reg;
>  	struct regmap_field *phy_pll_cfg;
>  	struct regmap_field *phy_pma_cmn_ctrl_1;
>  	struct regmap_field *phy_pma_cmn_ctrl_2;
>  	struct regmap_field *phy_pma_pll_raw_ctrl;
>  	struct regmap_field *phy_reset_ctrl;
> +	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
>  	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
>  	struct clk_onecell_data clk_data;
>  };
> @@ -456,6 +468,22 @@ static const struct regmap_config cdns_torrent_common_cdb_config = {
>  	.reg_read = cdns_regmap_read,
>  };
>  
> +#define TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF(n) \
> +{ \
> +	.name = "torrent_phy_pcs_lane" n "_cdb", \
> +	.reg_stride = 1, \
> +	.fast_io = true, \
> +	.reg_write = cdns_regmap_write, \
> +	.reg_read = cdns_regmap_read, \
> +}
> +
> +static const struct regmap_config cdns_torrent_phy_pcs_lane_cdb_config[] = {
> +	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("0"),
> +	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("1"),
> +	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("2"),
> +	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("3"),
> +};
> +
>  static const struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
>  	.name = "torrent_phy_pcs_cmn_cdb",
>  	.reg_stride = 1,
> @@ -1546,6 +1574,16 @@ static int cdns_torrent_phy_on(struct phy *phy)
>  		return ret;
>  	}
>  
> +	if (inst->phy_type == TYPE_PCIE || inst->phy_type == TYPE_USB) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pcs_iso_link_ctrl_1[inst->mlane],
> +						     read_val, !read_val, 1000,
> +						     PLL_LOCK_TIMEOUT);
> +		if (ret == -ETIMEDOUT) {
> +			dev_err(cdns_phy->dev, "Timeout waiting for PHY status ready\n");
> +			return ret;
> +		}
> +	}
> +
>  	mdelay(10);

With the above polling, this mdelay() shouldn't be required.

Thanks
Kishon
