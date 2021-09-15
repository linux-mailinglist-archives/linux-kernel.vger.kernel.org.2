Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE540BE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhIODxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:53:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhIODxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:53:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F3pZDf019328;
        Tue, 14 Sep 2021 22:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631677895;
        bh=0/DzyW1aTj0CujHkJ0bEl7T6yiNv8PfN/vXyA4LrYtY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nUeob6WsxUrTWfaC+yKmSe3UZ7TxJJ0mx0e99paHwFBRIrx/5KRsBMTOvrE/Ylprk
         ncAi1qPmgZjvPxGtZV4WptWa2B2flHEmWSezxczzgtF5bgEDG2zVbJGvkQ7u1hVuog
         SA7pcofEkQHXhzvw33Zg1WpsuoflR+nWoPIdU1pU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F3pZw6039433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 22:51:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 22:51:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 22:51:35 -0500
Received: from [10.250.232.217] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F3pVj9109416;
        Tue, 14 Sep 2021 22:51:32 -0500
Subject: Re: [PATCH 1/5] phy: cadence-torrent: Migrate to clk_hw based
 registration and OF APIs
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>, <a-govindraju@ti.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
 <20210908182628.28364-2-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e6c0b780-d5d5-f641-7e9f-d2c917eb4b51@ti.com>
Date:   Wed, 15 Sep 2021 09:21:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908182628.28364-2-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 08/09/21 11:56 pm, Swapnil Jakhade wrote:
> Use clk_hw based provider APIs to register clks.

Please explain the reasoning for moving to clk_hw based API.

Thanks,
Kishon
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 30 ++++++++++++++---------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 415ace64adc5..ecb1aa883c05 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -235,6 +235,8 @@
>  #define PHY_PMA_CMN_CTRL2		0x0001U
>  #define PHY_PMA_PLL_RAW_CTRL		0x0003U
>  
> +#define CDNS_TORRENT_OUTPUT_CLOCKS	1
> +
>  static const char * const clk_names[] = {
>  	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
>  };
> @@ -333,8 +335,7 @@ struct cdns_torrent_phy {
>  	struct regmap_field *phy_pma_pll_raw_ctrl;
>  	struct regmap_field *phy_reset_ctrl;
>  	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
> -	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
> -	struct clk_onecell_data clk_data;
> +	struct clk_hw_onecell_data *clk_hw_data;
>  };
>  
>  enum phy_powerstate {
> @@ -1659,8 +1660,9 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
>  	const char *parent_name;
>  	struct regmap *regmap;
>  	char clk_name[100];
> +	struct clk_hw *hw;
>  	struct clk *clk;
> -	int i;
> +	int i, ret;
>  
>  	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
>  	if (!derived_refclk)
> @@ -1706,11 +1708,12 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
>  
>  	derived_refclk->hw.init = init;
>  
> -	clk = devm_clk_register(dev, &derived_refclk->hw);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	hw = &derived_refclk->hw;
> +	ret = devm_clk_hw_register(dev, hw);
> +	if (ret)
> +		return ret;
>  
> -	cdns_phy->clks[CDNS_TORRENT_REFCLK_DRIVER] = clk;
> +	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER] = hw;
>  
>  	return 0;
>  }
> @@ -2188,18 +2191,23 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
>  {
>  	struct device *dev = cdns_phy->dev;
>  	struct device_node *node = dev->of_node;
> +	struct clk_hw_onecell_data *data;
>  	int ret;
>  
> +	data = devm_kzalloc(dev, struct_size(data, hws, CDNS_TORRENT_OUTPUT_CLOCKS), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->num = CDNS_TORRENT_OUTPUT_CLOCKS;
> +	cdns_phy->clk_hw_data = data;
> +
>  	ret = cdns_torrent_derived_refclk_register(cdns_phy);
>  	if (ret) {
>  		dev_err(dev, "failed to register derived refclk\n");
>  		return ret;
>  	}
>  
> -	cdns_phy->clk_data.clks = cdns_phy->clks;
> -	cdns_phy->clk_data.clk_num = CDNS_TORRENT_REFCLK_DRIVER + 1;
> -
> -	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &cdns_phy->clk_data);
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
>  	if (ret) {
>  		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
>  		return ret;
> 
