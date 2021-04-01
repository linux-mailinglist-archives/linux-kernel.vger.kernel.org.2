Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A586335122B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDAJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhDAJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:24:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B18C0613E6;
        Thu,  1 Apr 2021 02:24:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so1097937wrn.4;
        Thu, 01 Apr 2021 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QOZ406BEEbEWHKFv25vOlBMps7sISsv3QFK8sS1MwtA=;
        b=SWab0PZ7BrG7ikUp/9BfwfF65yALwYpjPDfYWda+cCXfJR8UIxbUA30Clh6LoSKHVx
         qp2BJ4aXaiyYw5IhnZJRGrt0OqFJ79M8GEKybnzBLjwTNDwjgF04Z1Nxp+R8b5r24yvv
         hr3HMXaR0L29Ok2nRkRdD9vC/8Ek/07WsG14e95CrGFthD7V8OdD3GGsU+//2CW4B1vG
         qsZs9jKpKm99reBy4uCkCtjeoJOS7p7c5RiwJyn3mDNobGyPikADdAU4JEy5Xj7AtVCU
         64qLTbqH4DY1QJgnb5sDmU1DSzngtMlXbHwBhWSh0WWDHCTw3+qaUiPne1I5sOwU0a86
         aV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QOZ406BEEbEWHKFv25vOlBMps7sISsv3QFK8sS1MwtA=;
        b=N5UeKVSISAH3v57h4SPNFYIWlSwTsLA5qVnLyNjLAd2R+w9u8uVTsCz9Hn9ehzWr5O
         GAcuqzKM+lgWBWaBvq2sQ2/KgArvd+TiH6DrwXZLbH9/BMd1/4pJBHoZTPF9+9+jXykj
         gb5Kz/bczmw4/eYG7sOzl4NS00skqhfK7MT6Bfm93XMEiLlJczYWys12gYFhkbahzBYq
         ynrWS8M7McQIxpqkNjcWTTbh0hZxnsg1yTuAWmczrG1k6LvxeLOqDg0FnVHwlGrG+wwb
         J8+xjAGlUUJ/cjPFh496I2NpQV7qFnnPyutZTUW1kytlHmaPdQ8v01qN0WDOMeMYhbrz
         hAxg==
X-Gm-Message-State: AOAM531jczrxFWzE5TGrunQ5w/JwShT6zkaKO9SjlGAGNOzyspcJL6IT
        MIlMSkcZ7oK1SfY1EimL+Ac=
X-Google-Smtp-Source: ABdhPJxF7BHzMuUefc6Ht1IZf5VWDYA0aKA8LyX3aVJq/Cl/cTdsqEvTdPzMz3hnFIGM1PNtysKvFA==
X-Received: by 2002:adf:f851:: with SMTP id d17mr8396821wrq.267.1617269070552;
        Thu, 01 Apr 2021 02:24:30 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id s9sm8153450wmh.31.2021.04.01.02.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:24:29 -0700 (PDT)
Subject: Re: [PATCH v10 2/4] soc: mediatek: add MT6765 scpsys and subdomain
 support
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wendell Lin <Wendell.Lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Evan Green <evgreen@chromium.org>, Yong.Wu@mediatek.com,
        Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
References: <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
 <1615358218-6540-1-git-send-email-macpaul.lin@mediatek.com>
 <1615358218-6540-3-git-send-email-macpaul.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <da80f06b-31d6-b728-43ab-e543f3f6d038@gmail.com>
Date:   Thu, 1 Apr 2021 11:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615358218-6540-3-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Macpaul,

On 10/03/2021 07:36, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> This adds scpsys support for MT6765
> Add subdomain support for MT6765:
> isp, mm, connsys, mfg, and cam.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 91 +++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c

the mtk-scpsys is the old version of the driver. Please port your code to the
new driver: mtk-pm-domains.c

The biggest difference for you will be to describe the power domain hierarchy in
DT instead as in the driver.

Regards,
Matthias

> index ca75b14931ec..fc8d3858f1b4 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -15,6 +15,7 @@
>  
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> +#include <dt-bindings/power/mt6765-power.h>
>  #include <dt-bindings/power/mt6797-power.h>
>  #include <dt-bindings/power/mt7622-power.h>
>  #include <dt-bindings/power/mt7623a-power.h>
> @@ -750,6 +751,81 @@ static const struct scp_subdomain scp_subdomain_mt2712[] = {
>  	{MT2712_POWER_DOMAIN_MFG_SC2, MT2712_POWER_DOMAIN_MFG_SC3},
>  };
>  
> +/*
> + * MT6765 power domain support
> + */
> +#define SPM_PWR_STATUS_MT6765			0x0180
> +#define SPM_PWR_STATUS_2ND_MT6765		0x0184
> +
> +static const struct scp_domain_data scp_domain_data_mt6765[] = {
> +	[MT6765_POWER_DOMAIN_VCODEC] = {
> +		.name = "vcodec",
> +		.sta_mask = BIT(26),
> +		.ctl_offs = 0x300,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = BIT(5),
> +		.ctl_offs = 0x308,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_MM] = {
> +		.name = "mm",
> +		.sta_mask = BIT(3),
> +		.ctl_offs = 0x30C,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.clk_id = {CLK_MM},
> +	},
> +	[MT6765_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = BIT(1),
> +		.ctl_offs = 0x32C,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +	},
> +	[MT6765_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x334,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.clk_id = {CLK_MFG},
> +	},
> +	[MT6765_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = BIT(4),
> +		.ctl_offs = 0x338,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_CAM] = {
> +		.name = "cam",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x344,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_MFG_CORE0] = {
> +		.name = "mfg_core0",
> +		.sta_mask = BIT(7),
> +		.ctl_offs = 0x34C,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt6765[] = {
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_CAM},
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_ISP},
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_VCODEC},
> +	{MT6765_POWER_DOMAIN_MFG_ASYNC, MT6765_POWER_DOMAIN_MFG},
> +	{MT6765_POWER_DOMAIN_MFG, MT6765_POWER_DOMAIN_MFG_CORE0},
> +};
> +
>  /*
>   * MT6797 power domain support
>   */
> @@ -1033,6 +1109,18 @@ static const struct scp_soc_data mt2712_data = {
>  	.bus_prot_reg_update = false,
>  };
>  
> +static const struct scp_soc_data mt6765_data = {
> +	.domains = scp_domain_data_mt6765,
> +	.num_domains = ARRAY_SIZE(scp_domain_data_mt6765),
> +	.subdomains = scp_subdomain_mt6765,
> +	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt6765),
> +	.regs = {
> +		.pwr_sta_offs = SPM_PWR_STATUS_MT6765,
> +		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6765,
> +	},
> +	.bus_prot_reg_update = true,
> +};
> +
>  static const struct scp_soc_data mt6797_data = {
>  	.domains = scp_domain_data_mt6797,
>  	.num_domains = ARRAY_SIZE(scp_domain_data_mt6797),
> @@ -1088,6 +1176,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt2712-scpsys",
>  		.data = &mt2712_data,
> +	}, {
> +		.compatible = "mediatek,mt6765-scpsys",
> +		.data = &mt6765_data,
>  	}, {
>  		.compatible = "mediatek,mt6797-scpsys",
>  		.data = &mt6797_data,
> 
