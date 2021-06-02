Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53485398929
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFBMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:17:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:16:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so2057576wrz.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YWSY2cvkvidrGJauSm19Qmn4FgCLAu02zP7qkPvv6YY=;
        b=kQQsl2UpBlB6F2Fk5+FuEtjEbKlu1rn2IDj2N3IsksURVjrcDfzgw0akVFK2ZJrium
         7B9DHOzOfhCN1pHe+R7wqs9Bwy7HFnI6PeLGLEQN+Bz/YlJ2qPWQf2QIk2gt/siQyP66
         kx0pTnpoUKSqZ1bVspuqO00aRF+mZ/e6mpEipknqziVjKuxTHTbYkNY9JJy9I8vmBM6V
         8zrOmG5ohKCSYLrZQbXQpN0iTSHwaqv6Vdug5QTyZHKv4BonHDYQSWF4EG4L/i4j7sYa
         W8QgIgOPl6GG3UDgukR4o6+gnS8RO2MzJuMI4EMhtQ4hY0EykvhjeaustbCZLYXOBjdP
         KGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YWSY2cvkvidrGJauSm19Qmn4FgCLAu02zP7qkPvv6YY=;
        b=aO0o3LTH8MoxUdI8XHeDqjPM/NsPe/Ylew0GTLM8RABN2s3Zkhw1ozkoy0EJc3G2Py
         LiRGrOFhFHmM0g5HtR1X4HXFNxYbqEt/YAP5FXljZZro7dmsLh8xDZ+lOzUxau2vjjMI
         2mrx46EE8+gPlfQZuyhO4K/WDVg3P9ILYvQIx7jGMI7Y+DRXGV7XZJIqdK1JqzAwdcUV
         6M7rPWIa5OXStSoChvm5miSwfHYTVbx6ADw+gl6UafJgqxsX4GIzBCtsHoS+9QlFyRNh
         wX0XjH2UWgKog+IUv54jscuVeciPq3h/ca+sPYpz45zHuEJgEa6V7z3JKd4TMG3HfnFC
         v18w==
X-Gm-Message-State: AOAM532FY2TqgBJ6LffieY+CgXj7eKvnoBS8RFGdGp/tlYPqTgc4TWTs
        y56L1pZVIMAP8fndxIfIw/8uP5DfR3I=
X-Google-Smtp-Source: ABdhPJx5bX8sIxUb03oSEQ/bL4H3N6FDIFHL2loduI+1H+Ag//xzJ8LAxuqAT2oUTbeKxIxzvqX1PA==
X-Received: by 2002:adf:a193:: with SMTP id u19mr17638169wru.9.1622636158691;
        Wed, 02 Jun 2021 05:15:58 -0700 (PDT)
Received: from ziggy.stardust ([37.223.145.68])
        by smtp.gmail.com with ESMTPSA id s7sm7187825wrf.91.2021.06.02.05.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 05:15:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] soc: mtk-pm-domains: Fix the clock prepared issue
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
References: <20210601035905.2970384-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d13c74d7-845f-40bc-1969-2e419d49e78e@gmail.com>
Date:   Wed, 2 Jun 2021 14:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601035905.2970384-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2021 05:59, Hsin-Yi Wang wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> In this new power domain driver, when adding one power domain
> it will prepare the dependent clocks at the same.
> So we only do clk_bulk_enable/disable control during power ON/OFF.
> When system suspend, the pm runtime framework will forcely power off
> power domains. However, the dependent clocks are disabled but kept
> prepared.
> 
> In MediaTek clock drivers, PLL would be turned ON when we do
> clk_bulk_prepare control.
> 
> Clock hierarchy:
> PLL -->
>        DIV_CK -->
>                  CLK_MUX
>                  (may be dependent clocks)
>                          -->
>                              SUBSYS_CG
>                              (may be dependent clocks)
> 
> It will lead some unexpected clock states during system suspend.
> This patch will fix by doing prepare_enable/disable_unprepare on
> dependent clocks at the same time while we are going to power on/off
> any power domain.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: chun-jie.chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Both patches applied to v5.13-next/soc

Thanks!

> ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 31 +++++++--------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 0af00efa0ef8..536d8c64b2b4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -211,7 +211,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
>  	if (ret)
>  		goto err_reg;
>  
> @@ -229,7 +229,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>  	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>  
> -	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
> +	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
>  	if (ret)
>  		goto err_pwr_ack;
>  
> @@ -246,9 +246,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  err_disable_sram:
>  	scpsys_sram_disable(pd);
>  err_disable_subsys_clks:
> -	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> +	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>  err_pwr_ack:
> -	clk_bulk_disable(pd->num_clks, pd->clks);
> +	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>  err_reg:
>  	scpsys_regulator_disable(pd->supply);
>  	return ret;
> @@ -269,7 +269,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	if (ret < 0)
>  		return ret;
>  
> -	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> +	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>  
>  	/* subsys power off */
>  	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> @@ -284,7 +284,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	if (ret < 0)
>  		return ret;
>  
> -	clk_bulk_disable(pd->num_clks, pd->clks);
> +	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>  
>  	scpsys_regulator_disable(pd->supply);
>  
> @@ -405,14 +405,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  		pd->subsys_clks[i].clk = clk;
>  	}
>  
> -	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
> -	if (ret)
> -		goto err_put_subsys_clocks;
> -
> -	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
> -	if (ret)
> -		goto err_unprepare_clocks;
> -
>  	/*
>  	 * Initially turn on all domains to make the domains usable
>  	 * with !CONFIG_PM and to get the hardware in sync with the
> @@ -427,7 +419,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  		ret = scpsys_power_on(&pd->genpd);
>  		if (ret < 0) {
>  			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
> -			goto err_unprepare_clocks;
> +			goto err_put_subsys_clocks;
>  		}
>  	}
>  
> @@ -435,7 +427,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  		ret = -EINVAL;
>  		dev_err(scpsys->dev,
>  			"power domain with id %d already exists, check your device-tree\n", id);
> -		goto err_unprepare_subsys_clocks;
> +		goto err_put_subsys_clocks;
>  	}
>  
>  	if (!pd->data->name)
> @@ -455,10 +447,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  
>  	return scpsys->pd_data.domains[id];
>  
> -err_unprepare_subsys_clocks:
> -	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> -err_unprepare_clocks:
> -	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_subsys_clocks:
>  	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  err_put_clocks:
> @@ -537,10 +525,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>  			"failed to remove domain '%s' : %d - state may be inconsistent\n",
>  			pd->genpd.name, ret);
>  
> -	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);
> -
> -	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>  	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  }
>  
> 
