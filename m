Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD237F31D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhEMGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:37:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43274 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhEMGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:37:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D6ZvWF099031;
        Thu, 13 May 2021 01:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620887757;
        bh=pd8BkFDwQHZHNLYzodafkan6ZZGBf5KN/Hd/GxNBdpk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qfnmISxRv5EggH8t9WDL83UK1Atm1nprRs5YhIG4Iknb7P58PgwKC6upaTPtEDTPb
         2NnsKkNh07aqi9J6hcvFHArwFb0sp/1jSk7z9X2cIa3ALTpXYMd2f8bnTWvxcZaKpL
         leFTMnhRNkhAPkg4ExUjDcDfLD28FKIklhMr0zx4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D6ZvqP095975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 01:35:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 01:35:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 01:35:57 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D6ZreZ023388;
        Thu, 13 May 2021 01:35:54 -0500
Subject: Re: [PATCH 01/14] phy: cadence-torrent: Remove use of CamelCase to
 fix checkpatch CHECK message
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-2-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <286c7937-d426-c50e-21b0-3fc24b6e367a@ti.com>
Date:   Thu, 13 May 2021 12:05:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-2-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Script checkpatch with --strict option gives message:
> CHECK: Avoid CamelCase: <REF_CLK_19_2MHz>
> CHECK: Avoid CamelCase: <REF_CLK_25MHz>
> Fix this by removing CamelCase usage. No functional change.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 24 +++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 0477e7beebbf..ff647669f1a3 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -24,8 +24,8 @@
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
>  
> -#define REF_CLK_19_2MHz		19200000
> -#define REF_CLK_25MHz		25000000
> +#define REF_CLK_19_2MHZ		19200000
> +#define REF_CLK_25MHZ		25000000
>  
>  #define MAX_NUM_LANES		4
>  #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
> @@ -695,12 +695,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
>  	ndelay(200);
>  
>  	/* DP Rate Change - VCO Output settings. */
> -	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz) {
> +	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ) {
>  		/* PMA common configuration 19.2MHz */
>  		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
>  							dp->ssc);
>  		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
> -	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz) {
> +	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ) {
>  		/* PMA common configuration 25MHz */
>  		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
>  						      dp->ssc);
> @@ -993,8 +993,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  
>  	switch (cdns_phy->ref_clk_rate) {
> -	case REF_CLK_19_2MHz:
> -	case REF_CLK_25MHz:
> +	case REF_CLK_19_2MHZ:
> +	case REF_CLK_25MHZ:
>  		/* Valid Ref Clock Rate */
>  		break;
>  	default:
> @@ -1026,11 +1026,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  
>  	/* PHY PMA registers configuration functions */
>  	/* Initialize PHY with max supported link rate, without SSC. */
> -	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
> +	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
>  		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
>  							cdns_phy->max_bit_rate,
>  							false);
> -	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
> +	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
>  		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
>  						      cdns_phy->max_bit_rate,
>  						      false);
> @@ -1074,10 +1074,10 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
>  {
>  	unsigned int i;
>  
> -	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
> +	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
>  		/* PMA common configuration 19.2MHz */
>  		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
> -	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
> +	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
>  		/* PMA common configuration 25MHz */
>  		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
>  
> @@ -1529,10 +1529,10 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
>  					 unsigned int lane)
>  {
>  	/* Per lane, refclock-dependent receiver detection setting */
> -	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
> +	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
>  		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
>  				       TX_RCVDET_ST_TMR, 0x0780);
> -	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
> +	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
>  		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
>  				       TX_RCVDET_ST_TMR, 0x09C4);
>  
> 
