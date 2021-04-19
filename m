Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9763363CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhDSHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhDSHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:37:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:36:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so7507931wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0+ERtxBLAKa344j/COpxgJf/tgpBFvh5Bj4l219hncw=;
        b=qrk6vf1EOZdLHLwAxVz1yLbK4ih6Ze0oyf5aUVfqKSeGfRpRrjHCeWDhSl0aK6r0G4
         uBLiywKB0tytKu40gqqeJOkf9hpfwC0J6TGEFhZAZsNQt3ldmpVBWKUC4D7WqHH1JMTu
         C7lp/oFtxQMQ7CyuaDlrdh+auWRZItDHFPiForkAdJsU/ElCedxw98+ajBOPNccur+7d
         uricePPL9tXoIUHIGDPwnC9COfraCyMam0tUHiEhovXZfQBxRm6r4cWYWFFMLTcQMlAX
         E3CSk6AfNuqq98koEPfaulkns9/dJcV3OduT/xwJ83x4GL9+CAMRZCOxRsGqDqbPSOQn
         lMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0+ERtxBLAKa344j/COpxgJf/tgpBFvh5Bj4l219hncw=;
        b=E7/0xcVnGN0x1Ig+tEDs2HIQNLYYc75t6cO1LHxq5oyuEJND5NdQ7WbHjLZWoTxiHX
         6uu0ggbOvtrRG5/hRJvMxchmgfBVfmXXWbRjHQV7TiMTzNrhcwaMSWCodgz7Gbief6mP
         RwxlWHhKCyaRWnfkaL1vC9xCNrq52AxB1H3+kkDpMyzf5YE30jeE7kTfmqoy85RyNVIQ
         wGlr8IE7sRHV2S8NiNpXsFV2e9/erf+9/mLVKViMnacLgpT6CEdbnRjUzNj0RQ5Wn89y
         j6rHh03lEcC0cs0PHfzVwKsK2FM7fsFo1TxQYhYCXLAeYWg2tE2DxfpQZhETUJ2T8DCq
         TD9Q==
X-Gm-Message-State: AOAM531HFL6ns+l5JW/WpuXaTp4DJ/M3/whLgP7SoQ79hOw8eU5da6XO
        Q6ZzoWr0g9pVGizq7R4K6458Kw==
X-Google-Smtp-Source: ABdhPJw2g0pS+qOTAkbmbUZIhuDHi3UKmV+q/ol9tb6YWfNBVWi/V+7tn1DJrHP6PL03s7jfw/PZHw==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr20362725wmi.105.1618817800987;
        Mon, 19 Apr 2021 00:36:40 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2e82:31e6:67f1:4f33? ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id i12sm18382688wmd.3.2021.04.19.00.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 00:36:40 -0700 (PDT)
Subject: Re: [v2,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
References: <1618407316-10042-1-git-send-email-rex-bc.chen@mediatek.com>
 <1618407316-10042-2-git-send-email-rex-bc.chen@mediatek.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <a1ffcce8-621e-7493-22d4-e28ff09c31a4@baylibre.com>
Date:   Mon, 19 Apr 2021 09:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618407316-10042-2-git-send-email-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/04/2021 15:35, Rex-BC Chen wrote:
> DPI can sample on falling, rising or both edge.
> When DPI sample the data both rising and falling edge.
> It can reduce half data io pins.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index b05f900d9322..21a3a7b78835 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -83,6 +83,7 @@ struct mtk_dpi {
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pins_gpio;
>  	struct pinctrl_state *pins_dpi;
> +	bool ddr_edge_sel;
>  	int refcount;
>  };
>  
> @@ -121,6 +122,7 @@ struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
> +	bool dual_edge;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -380,6 +382,15 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  	}
>  }
>  
> +static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
> +{
> +	if (dpi->conf->dual_edge) {
> +		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +			     DDR_EN | DDR_4PHASE);
> +		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, dpi->ddr_edge_sel ? EDGE_SEL : 0, EDGE_SEL);
> +	}
> +}
> +

By using the downstream code as reference:

-       clk_set_rate(dpi->pixel_clk, vm.pixelclock);
+       clk_set_rate(dpi->pixel_clk, vm.pixelclock * (dpi->conf->dual_edge ? 2 : 1));

is missing in mtk_dpi_set_display_mode()

>  static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>  {
>  	if (WARN_ON(dpi->refcount == 0))
> @@ -518,6 +529,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
>  	mtk_dpi_config_color_format(dpi, dpi->color_format);
>  	mtk_dpi_config_2n_h_fre(dpi);
> +	mtk_dpi_dual_edge(dpi);
>  	mtk_dpi_config_disable_edge(dpi);
>  	mtk_dpi_sw_reset(dpi, false);
>  
> 

Neil
