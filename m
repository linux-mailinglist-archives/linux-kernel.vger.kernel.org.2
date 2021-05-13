Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAE37F3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhEMHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:55:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhEMHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:55:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14D7s6dP124778;
        Thu, 13 May 2021 02:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620892446;
        bh=KOaZp8AouIw7/U9UfC3TvXkrf0bQyCwsPWcKiEM/Ny4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZTkiBauAHeh1DHNPw4F6cR/AltxIjUYgdMm2oEkZQ/lHhOpLyQ7uz11dArwLJ6wm7
         8cSWUfZPQiT9kv/jcSU8Gfb7xvMpQi+rC5GcewkwnAD28HF68ZuhwXDgKCgg+Fs9Ax
         FNzS1aLSCZlQfMcVlHRoMs8khU1QYQCNVJQQXotI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14D7s667069809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 02:54:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 02:54:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 02:54:05 -0500
Received: from [10.250.232.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14D7s13F054719;
        Thu, 13 May 2021 02:54:02 -0500
Subject: Re: [PATCH 13/14] phy: cadence-torrent: Add debug information for PHY
 configuration
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
 <1617946456-27773-14-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <24ec95cd-aa7c-6262-4065-7281788ab684@ti.com>
Date:   Thu, 13 May 2021 13:24:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617946456-27773-14-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 09/04/21 11:04 am, Swapnil Jakhade wrote:
> Display information in probe regarding PHY configuration parameters like
> single link or multilink protocol information along with number of lanes
> used for each protocol link.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 32 +++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index bf37569c6c51..39145e56e061 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -574,6 +574,24 @@ static const struct coefficients vltg_coeff[4][4] = {
>  	}
>  };
>  
> +static const char *cdns_torrent_get_phy_type(enum cdns_torrent_phy_type phy_type)
> +{
> +	switch (phy_type) {
> +	case TYPE_DP:
> +		return "DisplayPort";
> +	case TYPE_PCIE:
> +		return "PCIe";
> +	case TYPE_SGMII:
> +		return "SGMII";
> +	case TYPE_QSGMII:
> +		return "QSGMII";
> +	case TYPE_USB:
> +		return "USB";
> +	default:
> +		return "None";
> +	}
> +}
> +
>  /*
>   * Set registers responsible for enabling and configuring SSC, with second and
>   * third register values provided by parameters.
> @@ -2504,8 +2522,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  				init_dp_regmap++;
>  			}
>  
> -			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
> -				 cdns_phy->phys[node].num_lanes,
> +			dev_info(dev, "DP max bit rate %d.%03d Gbps\n",
>  				 cdns_phy->max_bit_rate / 1000,
>  				 cdns_phy->max_bit_rate % 1000);
>  
> @@ -2539,6 +2556,17 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  		goto put_lnk_rst;
>  	}
>  
> +	if (cdns_phy->nsubnodes > 1)
> +		dev_info(dev, "%s (%d lanes) & %s (%d lanes)",
> +			 cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
> +			 cdns_phy->phys[0].num_lanes,
> +			 cdns_torrent_get_phy_type(cdns_phy->phys[1].phy_type),
> +			 cdns_phy->phys[1].num_lanes);
> +	else
> +		dev_info(dev, "%s (%d lanes)",
> +			 cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
> +			 cdns_phy->phys[0].num_lanes);

Make all of this dev_dbg() or dev_vdbg() and avoid noisy boot log.

Thanks
Kishon
