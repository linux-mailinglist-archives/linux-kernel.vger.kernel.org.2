Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6763555EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbhDFOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbhDFOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:01:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C3C06174A;
        Tue,  6 Apr 2021 07:01:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a6so8354402wrw.8;
        Tue, 06 Apr 2021 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lyaJC5idQzW8tJ00oZwa0i4EGsa2UYRBAw/y1mTUSfY=;
        b=ayUWJz1LljY43oBsHUV2fquC0dOfHIGx1sozNYGS0hOden2eG1tTbmdRZ24+HaFfwS
         TKA5FsaPt3kNZXBlzZf5tPzwmKh5+kY2w5NHOPNYkZe49H8CzjH01ZA/KfEb8pfF3KMR
         JSJ7zjIEPxv2kXW6r4wtKJHqcj9VPGRH8IudZ3oktd6Oi31Rqdt/liyO7L/pEiHaxAs4
         NiO1hvtb91hPJosaBlC8I63MZ4htwA9v/5TV0RaOdYOucxorwiiggrk3ahPL9nwL7NLi
         5ZJjKnvsgjrqsOKWk+Zyq+GgLj9kVtX2VW+fk3RyeAd3lP3bw85655aaDiMh7ttNzOOy
         0xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lyaJC5idQzW8tJ00oZwa0i4EGsa2UYRBAw/y1mTUSfY=;
        b=mz5gEuaYpwxxIrmqWpmzrF+JRXLwye9DkZYpKSnJQ+EK7quCHi4kmNsUCHgnrtl/Yv
         WzOMUClEyhjnV2yaNLCqKb7qN2sRIyHLj3ApezkyZTmd/5Xq74mJ6VSkCyFJHNTVnxi5
         2thypbqp1VLdEDOJsve0SK7N/8aQSWFuvqtv7tQ+lk3WDHbpz6pMQpI9hmAx3Mfa9+jV
         P3f4kaB3PIU1a1om1UoRvqixO8F7byKa5RtqoCXV/Syl7Qmykts6sO2d2M+TZiqFbsx5
         /s4N7kc+C15Vur3FSreSXXhdWmc20sdYBA9ZTc+n832a++aY4V8y+KZWdcrAXBubzDRU
         6SIA==
X-Gm-Message-State: AOAM530OMdXj23xT69mLyIQOE+o/uczPREB9cSwv9bUp2X2XF0sFic78
        tn9zZFL19oTgI5d946AMrkU=
X-Google-Smtp-Source: ABdhPJwhqDdKl7A1F5aod5ie1kaC7iSZB3TCVH2ClVuonHpZIk/vJdtZM1hqBpP18KFVj1FaDIxEAw==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr35631965wrz.77.1617717665570;
        Tue, 06 Apr 2021 07:01:05 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id f2sm3051522wmp.20.2021.04.06.07.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 07:01:05 -0700 (PDT)
Subject: Re: [PATCH v8 2/4] soc: mediatek: add MT6765 scpsys and subdomain
 support
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
 <1582279929-11535-3-git-send-email-macpaul.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c9cefb0b-2394-e48c-f140-3dab55af2369@gmail.com>
Date:   Tue, 6 Apr 2021 16:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1582279929-11535-3-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2020 11:12, Macpaul Lin wrote:
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
>  drivers/soc/mediatek/mtk-scpsys.c |  130 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 

Unfortunately scpsys is deprecated in the meantime. Please port you patches to
the new mtk-pm-domains.c driver. The biggest difference is, that the domain and
subdomain structure of the pm domains is describe in device tree instead of
hard-coded in the driver.

Regards,
Matthias

> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d37..9940c6d 100644
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
> @@ -750,6 +751,120 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  };
>  
>  /*
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
> +		.subsys_clk_prefix = "isp",
> +		.bp_table = {
> +			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
> +				BIT(20), BIT(20)),
> +			BUS_PROT(SMI_TYPE, 0x3C4, 0x3C8, 0, 0x3C0,
> +				BIT(2), BIT(2)),
> +		},
> +	},
> +	[MT6765_POWER_DOMAIN_MM] = {
> +		.name = "mm",
> +		.sta_mask = BIT(3),
> +		.ctl_offs = 0x30C,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.basic_clk_id = {"mm"},
> +		.subsys_clk_prefix = "mm",
> +		.bp_table = {
> +			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
> +				BIT(16) | BIT(17), BIT(16) | BIT(17)),
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(10) | BIT(11), BIT(10) | BIT(11)),
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(1) | BIT(2), BIT(1) | BIT(2)),
> +		},
> +	},
> +	[MT6765_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = BIT(1),
> +		.ctl_offs = 0x32C,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_table = {
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(13), BIT(13)),
> +			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
> +				BIT(18), BIT(18)),
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(14) | BIT(16), BIT(14) | BIT(16)),
> +		},
> +	},
> +	[MT6765_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x334,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.basic_clk_id = {"mfg"},
> +	},
> +	[MT6765_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = BIT(4),
> +		.ctl_offs = 0x338,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_table = {
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(25), BIT(25)),
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(21) | BIT(22), BIT(21) | BIT(22)),
> +		}
> +	},
> +	[MT6765_POWER_DOMAIN_CAM] = {
> +		.name = "cam",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x344,
> +		.sram_pdn_bits = GENMASK(8, 9),
> +		.sram_pdn_ack_bits = GENMASK(12, 13),
> +		.subsys_clk_prefix = "cam",
> +		.bp_table = {
> +			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
> +				BIT(19) | BIT(21), BIT(19) | BIT(21)),
> +			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
> +				BIT(20), BIT(20)),
> +			BUS_PROT(SMI_TYPE, 0x3C4, 0x3C8, 0, 0x3C0,
> +				BIT(3), BIT(3)),
> +		}
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
> +/*
>   * MT6797 power domain support
>   */
>  
> @@ -1032,6 +1147,18 @@ static void mtk_register_power_domains(struct platform_device *pdev,
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
> @@ -1088,6 +1215,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.compatible = "mediatek,mt2712-scpsys",
>  		.data = &mt2712_data,
>  	}, {
> +		.compatible = "mediatek,mt6765-scpsys",
> +		.data = &mt6765_data,
> +	}, {
>  		.compatible = "mediatek,mt6797-scpsys",
>  		.data = &mt6797_data,
>  	}, {
> 
