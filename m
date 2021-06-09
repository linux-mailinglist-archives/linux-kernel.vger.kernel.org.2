Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3213A1799
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhFIOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFIOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:44:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E563C061574;
        Wed,  9 Jun 2021 07:42:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y7so21137784wrh.7;
        Wed, 09 Jun 2021 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IhyCu8H5WSS/E4CDjMhpArM4pXXOj0TlzCRvDB9JWNs=;
        b=FylaupbFDFZrMhi3SvSNnIe8tPXxK9fI1FeBkscPkU7HbplyXTi5mjeQl4ajeZUMjF
         3u9Y9nVjGb2t0Jl/1yP6vkekD7tk4+/juEZuLQPMu++PeIg4Rz0q+Y3HoLTPRvxlNgwm
         d/saSwDWPCECKQPpWi/mJ6GbyjOEuY9BOFCwwHxkr9bLFyuLqWhYP8LZvaPQ1YYCIL6s
         waetdHEa2R04ypG6be8Vd7k+j9eqjmmhbEldq2TdqRkoUscclY5BLVAkfx/5Dreyal2u
         gb5v7pguPCe4uVY8/JkG6lEj0nXgYj6jMz7m0CFQZbala5Oq81d+LQmqbKQOnnBaf50D
         O/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IhyCu8H5WSS/E4CDjMhpArM4pXXOj0TlzCRvDB9JWNs=;
        b=iEJ5QtiqFzsVnmLrPPb9M/cBnZHWmToJzk8HZOg/dfSQo9VILMrQu9Xrccybxdzw+8
         zcgKova2gcBxEoIJZftvs3LZfwMV7KLj0bQhKF24SOcaTw60zEM5pfoow2BHhD5xCVXi
         rHT+YYSvPBJVXV4waG27C/jBVD/LXyUt4+DO/jdokaldD7zxovH6wgSE6Cu4zCEBFQ1p
         87jyVVCnMk+M7XEfotNd/4lwk9E7AQN1OIKCFA+eZ6gQN6wO1J82++UvVPu90cbnM1TC
         1wJ36jHYGf/fU+xs4S9CLz/GTNncZWHyjOCfP/y6TRgJQdMH7xN+e0Ni+QpLrVOsZOix
         84Zw==
X-Gm-Message-State: AOAM531M/X+xIUC5fN0hRYDGf7wdetw8vwBnfsi93xwUeRIwDPSifHlM
        Pc/nvpjKg0/56LmoxObLwuQB2YWmXSb45nQb
X-Google-Smtp-Source: ABdhPJxs1AUnYHyns8XqNWnre7Ubl2p5jpkkdqatFTbqbgJrQpW3L64xpTz6S+pkS0t8gqgaaORBHg==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr171709wrr.292.1623249731120;
        Wed, 09 Jun 2021 07:42:11 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id v7sm129321wru.66.2021.06.09.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:42:10 -0700 (PDT)
Subject: Re: [PATCH v5 14/16] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org, acourbot@chromium.org
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-15-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1755fd87-a724-508f-92a8-d09b627d58ca@gmail.com>
Date:   Wed, 9 Jun 2021 16:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-15-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2021 11:11, Yong Wu wrote:
> After adding device_link between the iommu consumer and smi-larb,
> the pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. we can get rid of mtk_smi_larb_get/put.
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/memory/mtk-smi.c   | 14 --------------
>  include/soc/mediatek/smi.h | 20 --------------------
>  2 files changed, 34 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c5fb51f73b34..7c61c924e220 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -134,20 +134,6 @@ static void mtk_smi_clk_disable(const struct mtk_smi *smi)
>  	clk_disable_unprepare(smi->clk_apb);
>  }
>  
> -int mtk_smi_larb_get(struct device *larbdev)
> -{
> -	int ret = pm_runtime_resume_and_get(larbdev);
> -
> -	return (ret < 0) ? ret : 0;
> -}
> -EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
> -
> -void mtk_smi_larb_put(struct device *larbdev)
> -{
> -	pm_runtime_put_sync(larbdev);
> -}
> -EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
> -
>  static int
>  mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
>  {
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 15e3397cec58..11f7d6b59642 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -19,26 +19,6 @@ struct mtk_smi_larb_iommu {
>  	unsigned char  bank[32];
>  };
>  
> -/*
> - * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
> - *                   It also initialize some basic setting(like iommu).
> - * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
> - * Both should be called in non-atomic context.
> - *
> - * Returns 0 if successful, negative on failure.
> - */
> -int mtk_smi_larb_get(struct device *larbdev);
> -void mtk_smi_larb_put(struct device *larbdev);
> -
> -#else
> -
> -static inline int mtk_smi_larb_get(struct device *larbdev)
> -{
> -	return 0;
> -}
> -
> -static inline void mtk_smi_larb_put(struct device *larbdev) { }
> -
>  #endif
>  
>  #endif
> 
