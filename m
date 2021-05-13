Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5662837F34F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhEMHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:02:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEMHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:01:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D70hi2099772;
        Thu, 13 May 2021 02:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620889243;
        bh=ATw62jokpw3S2/vubslMDgTOmV3VoTzaiau5RmJC0dM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u/8wfn/Hy6vJeMWlpvOFGbj+vy47dZIb8kQmso0S+8EVcC9PIWuRAXdtbrL7jM50w
         mXeOAXjILIkT5YL5c780m+ZpaP+l7qfFDdvq2MLuSVNw+iSUvDSzmq61oNYIht2s58
         gJ+cSz8dQ4qv/cR/SwEYH10No3ujwGZlUa97XxBk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D70haO129012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:00:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:00:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:00:43 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D70dVO109177;
        Thu, 13 May 2021 02:00:40 -0500
Subject: Re: [PATCH 09/14] phy: cadence-torrent: Add separate functions for
 reusable code
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-10-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9d234a02-d1f4-ab09-56e0-81676ef1bf21@ti.com>
Date:   Thu, 13 May 2021 12:30:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-10-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Torrent PHY driver currently supports single link DP configuration.
> Prepare driver to support multilink DP configurations by adding
> separate functions for common initialization sequence.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 53 +++++++++++++++--------
>  1 file changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 69466481af26..e4dd8d1711a6 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -1472,24 +1472,11 @@ static int cdns_torrent_phy_off(struct phy *phy)
>  	return reset_control_assert(inst->lnk_rst);
>  }
>  
> -static int cdns_torrent_dp_init(struct phy *phy)
> +static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
> +					struct cdns_torrent_inst *inst)
>  {
> -	unsigned char lane_bits;
> -	int ret;
> -	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
> -	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> -
> -	switch (cdns_phy->ref_clk_rate) {
> -	case CLK_19_2_MHZ:
> -	case CLK_25_MHZ:
> -	case CLK_100_MHZ:
> -		/* Valid Ref Clock Rate */
> -		break;
> -	default:
> -		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
> -		return -EINVAL;
> -	}
> +	unsigned char lane_bits;
>  
>  	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
>  
> @@ -1510,8 +1497,10 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
>  	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
>  
> -	/* PHY PMA registers configuration functions */
> -	/* Initialize PHY with max supported link rate, without SSC. */
> +	/*
> +	 * PHY PMA registers configuration functions
> +	 * Initialize PHY with max supported link rate, without SSC.
> +	 */
>  	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
>  		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
>  							cdns_phy->max_bit_rate,
> @@ -1530,6 +1519,13 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  
>  	/* take out of reset */
>  	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
> +}
> +
> +static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
> +				 struct cdns_torrent_inst *inst,
> +				 struct phy *phy)
> +{
> +	int ret;
>  
>  	cdns_torrent_phy_on(phy);
>  
> @@ -1542,6 +1538,27 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	return ret;
>  }
>  
> +static int cdns_torrent_dp_init(struct phy *phy)
> +{
> +	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
> +	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
> +
> +	switch (cdns_phy->ref_clk_rate) {
> +	case CLK_19_2_MHZ:
> +	case CLK_25_MHZ:
> +	case CLK_100_MHZ:
> +		/* Valid Ref Clock Rate */
> +		break;
> +	default:
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
> 
