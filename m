Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BED309C5E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhAaNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhAaMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:06:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8D6C061786;
        Sun, 31 Jan 2021 04:04:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so13550479wrz.0;
        Sun, 31 Jan 2021 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FK0KIuL3uywgxUNWoEzzV/4pEUdANjUEq0Q5N1SiQsU=;
        b=r74NYeChFegwu2yLVvYHYJNXwzeaKy4X9fu8oB3CH7jfdnMTxr0BPxM8FdXZ0OfhFE
         xWYsydofMdCcuMka5Lw4koz91GeD4lFVNJESw7XA6ronhXma7y61KjEa4ByMi7G0kElX
         RAUBoOErxkZihRW92+hL3RJg5uyz92Cndjg4+13kqdXIHxl6J+cYOk7HmoIsQoXgXo3Y
         xMY7zF0pCdshfK3405okus+q/+riazKAtC8NUVhYALTJU78i9wr+wPwiLu4GqcqlaVE2
         hZbIIonFrg9wI4Asz2iN82vGd4uzPVAn7Gea2YPVN4yJMs7tT86Zib7QYxXLjZTe1ICx
         +JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FK0KIuL3uywgxUNWoEzzV/4pEUdANjUEq0Q5N1SiQsU=;
        b=PwjLl/KVjb6iq0kf1tvhEPWJN/S04y0QmWdXkwxlkPAV7gnZU6SBI+qxq9oa2giEvH
         UeW6NkPkAbFpufD2TiGdMvc7IhtY3+eBVlq42lCOGMh+1HtHNSHJ3unlKPGsLXVyvig7
         OS9Jck/IB+Y60Qp457qCq1MWzG4uxl0S75tWTngPlKf0aLsSK65BPTEoJKo0GQ76aZQV
         ps2HBfgI2sqlEFvPewuubV8PnK9+ybeEynJ/ezN29WlAIIpvDJspMgVij0Q+0bqk0fDQ
         ogqlGo8rkc33VywLTuL7b8Zj5LC7o4F+EZGQFB8ZFIQ0qdiWHUU8Cdb9VlZ4ZjodcbBK
         6XEA==
X-Gm-Message-State: AOAM530hDMLgnbkhUIbhhzQWn651jDxS2p0pis45qIDEZuBtIeKiM9VR
        BgGqEE8eYOlI6R+AQGo6eGQ=
X-Google-Smtp-Source: ABdhPJxTZgBQo1yEVP5uhEzN7O8GKq629ZwmDrVBFA1/I/B9F1dERvqhimhPgCUEVNXiKf6aGrlOKw==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr13376531wrx.230.1612094686166;
        Sun, 31 Jan 2021 04:04:46 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o18sm17481781wmh.20.2021.01.31.04.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 04:04:45 -0800 (PST)
Subject: Re: [PATCH v2 2/3] soc: mediatek: pm-domains: Add domain regulator
 supply
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20210129101208.2625249-1-hsinyi@chromium.org>
 <20210129101208.2625249-3-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d778f209-e1c5-b2be-19f3-8f0e4d2e53c7@gmail.com>
Date:   Sun, 31 Jan 2021 13:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129101208.2625249-3-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 11:12, Hsin-Yi Wang wrote:
> Some power domains (eg. mfg) needs to turn on power supply before power
> on.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.11-next/soc

Thanks

> ---
>  drivers/soc/mediatek/mt8183-pm-domains.h |  1 +
>  drivers/soc/mediatek/mtk-pm-domains.c    | 42 +++++++++++++++++++++++-
>  drivers/soc/mediatek/mtk-pm-domains.h    |  1 +
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
> index 8d996c5d2682d..aa5230e6c12f8 100644
> --- a/drivers/soc/mediatek/mt8183-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8183-pm-domains.h
> @@ -38,6 +38,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>  		.ctl_offs = 0x0338,
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.caps = MTK_SCPD_DOMAIN_SUPPLY,
>  	},
>  	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
>  		.sta_mask = BIT(7),
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index fb70cb3b07b36..1e0a65fbce1db 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
>  
>  #include "mt8173-pm-domains.h"
> @@ -40,6 +41,7 @@ struct scpsys_domain {
>  	struct clk_bulk_data *subsys_clks;
>  	struct regmap *infracfg;
>  	struct regmap *smi;
> +	struct regulator *supply;
>  };
>  
>  struct scpsys {
> @@ -187,6 +189,16 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>  	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
>  }
>  
> +static int scpsys_regulator_enable(struct regulator *supply)
> +{
> +	return supply ? regulator_enable(supply) : 0;
> +}
> +
> +static int scpsys_regulator_disable(struct regulator *supply)
> +{
> +	return supply ? regulator_disable(supply) : 0;
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> @@ -194,10 +206,14 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	bool tmp;
>  	int ret;
>  
> -	ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +	ret = scpsys_regulator_enable(pd->supply);
>  	if (ret)
>  		return ret;
>  
> +	ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +	if (ret)
> +		goto err_reg;
> +
>  	/* subsys power on */
>  	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
>  	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
> @@ -232,6 +248,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>  err_pwr_ack:
>  	clk_bulk_disable(pd->num_clks, pd->clks);
> +err_reg:
> +	scpsys_regulator_disable(pd->supply);
>  	return ret;
>  }
>  
> @@ -267,6 +285,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  
>  	clk_bulk_disable(pd->num_clks, pd->clks);
>  
> +	scpsys_regulator_disable(pd->supply);
> +
>  	return 0;
>  }
>  
> @@ -275,6 +295,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  {
>  	const struct scpsys_domain_data *domain_data;
>  	struct scpsys_domain *pd;
> +	struct device_node *root_node = scpsys->dev->of_node;
>  	struct property *prop;
>  	const char *clk_name;
>  	int i, ret, num_clks;
> @@ -307,6 +328,25 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  	pd->data = domain_data;
>  	pd->scpsys = scpsys;
>  
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
> +		/*
> +		 * Find regulator in current power domain node.
> +		 * devm_regulator_get() finds regulator in a node and its child
> +		 * node, so set of_node to current power domain node then change
> +		 * back to original node after regulator is found for current
> +		 * power domain node.
> +		 */
> +		scpsys->dev->of_node = node;
> +		pd->supply = devm_regulator_get(scpsys->dev, "domain");
> +		scpsys->dev->of_node = root_node;
> +		if (IS_ERR(pd->supply)) {
> +			dev_err_probe(scpsys->dev, PTR_ERR(pd->supply),
> +				      "%pOF: failed to get power supply.\n",
> +				      node);
> +			return ERR_CAST(pd->supply);
> +		}
> +	}
> +
>  	pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
>  	if (IS_ERR(pd->infracfg))
>  		return ERR_CAST(pd->infracfg);
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a2f4d8f97e058..b2770b5266dba 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -7,6 +7,7 @@
>  #define MTK_SCPD_FWAIT_SRAM		BIT(1)
>  #define MTK_SCPD_SRAM_ISO		BIT(2)
>  #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
> +#define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
>  #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>  
>  #define SPM_VDE_PWR_CON			0x0210
> 
