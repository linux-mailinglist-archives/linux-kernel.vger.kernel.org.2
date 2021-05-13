Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00737F370
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEMHOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:14:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36784 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhEMHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:14:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D7D16h104495;
        Thu, 13 May 2021 02:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620889981;
        bh=8Emt8yaug9sAwfbGHDn+bykKf7UdgXDvn5LNTYk4u0s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YkG9Xwu8I6V0rTb+5trfVZCZW2vmh4af0PUi5A6e0gPw3FKTNyLbL80kwi64IWFkQ
         IwbOs9YK/8AyEI0eNCrhp4iN8I67ke/7HezJUFd1vYmyICC3M2/FiNFGffv4/CCGZX
         falugY4VqN84mB86nrQhDCF8STRwGIvhizb4vRhY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D7D15K073394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:13:01 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:13:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:13:01 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D7CuxJ098766;
        Thu, 13 May 2021 02:12:57 -0500
Subject: Re: [PATCH 10/14] phy: cadence-torrent: Add function to get PLL to be
 configured for DP
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-11-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b5e1cf48-7a19-4f5e-8530-e28e98a16e6a@ti.com>
Date:   Thu, 13 May 2021 12:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-11-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Torrent PHY PLL0 or PLL1 is used for DP depending on the single link or
> multilink protocol configuration for which PHY is configured. In multilink
> configurations with other protocols, either PLL0 or PLL1 will be used
> for DP. For single link DP, both PLLs need to be configured at POR.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index e4dd8d1711a6..44e28ea8ffa7 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -288,6 +288,11 @@ enum cdns_torrent_ssc_mode {
>  	INTERNAL_SSC
>  };
>  
> +enum cdns_torrent_dp_pll {
> +	DP_PLL0 = 0x1,
> +	DP_PLL1 = 0x2

Using BIT() macro might be better since you are using this as bitfield.
> +};
> +
>  struct cdns_torrent_inst {
>  	struct phy *phy;
>  	u32 mlane;
> @@ -301,6 +306,7 @@ struct cdns_torrent_phy {
>  	void __iomem *base;	/* DPTX registers base */
>  	void __iomem *sd_base; /* SD0801 registers base */
>  	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
> +	u32 dp_pll;

enum cdns_torrent_dp_pll?

Thanks
Kishon

>  	struct reset_control *phy_rst;
>  	struct reset_control *apb_rst;
>  	struct device *dev;
> @@ -900,6 +906,30 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
>  	}
>  }
>  
> +/* Set PLL used for DP configuration */
> +static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
> +				   enum cdns_torrent_phy_type phy_t2)
> +{
> +	switch (phy_t2) {
> +	case TYPE_PCIE:
> +	case TYPE_USB:
> +		cdns_phy->dp_pll = DP_PLL1;
> +		break;
> +	case TYPE_SGMII:
> +	case TYPE_QSGMII:
> +		cdns_phy->dp_pll = DP_PLL0;
> +		break;
> +	case TYPE_NONE:
> +		cdns_phy->dp_pll = DP_PLL0 | DP_PLL1;
> +		break;
> +	default:
> +		dev_err(cdns_phy->dev, "Unsupported PHY configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Enable or disable PLL for selected lanes.
>   */
> @@ -1554,6 +1584,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  		return -EINVAL;
>  	}
>  
> +	cdns_torrent_dp_get_pll(cdns_phy, TYPE_NONE);
> +
>  	cdns_torrent_dp_common_init(cdns_phy, inst);
>  
>  	return cdns_torrent_dp_start(cdns_phy, inst, phy);
> 
