Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD841FDED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhJBTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhJBTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 15:50:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2127C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 12:48:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b20so53299078lfv.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3iD8ut9T1OePPVNgxRODW+TG74L9ph+sNjofBkFX9mg=;
        b=wG2lRoHDQCTj6Halp/cZ2LtDN2u5uTWjX8eziYcpJA9DdBOXDvnWbMnA5ShXMxQ2kH
         dowbU15I0QIc8vNDqpWEAgJqHONlHsmFFidkGSOF4Q/PXteyOh9DnQk39fMIOvMyDluc
         +um3v4Xcar05hv8fPklhZ62KtTvW/mGWTqY5uBCFXBAENZlpxtFT4n+ck9n/UljVX8yp
         +CqUbWxJxMhXeolXBMhRcDtzm1Bt6mDO9Tt8g8H8gDfnSZhG453yumALo7yPZ9Z+/9M2
         EdtewggioCxQ1pgdEWvlOZzbPTYitIt3aTR+iEStuhnmm6EhGighfFiwxbz9vjZ5rHGN
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3iD8ut9T1OePPVNgxRODW+TG74L9ph+sNjofBkFX9mg=;
        b=I4Eap7TZ8YoIbgb0Maoaq7xOSBHie17xuAbwGy0MsiGYnvK5aSgXCe2o3ZHbv3Mupz
         DF1/KbPbWq16wvf7YmOb99gaWD4mRHTia5H1Emb0/YpXDELAd66WhrlwKHzY3C97qwCf
         5QUGa4t75Ys88JPGbED20nS9ll1in7FWVbLTgaXJNgElFyoE13/Lw3aqQeGAq/i6Paje
         uM0VlBBpkf27orI3HUrIdyURSq1hZnXt2k2RkxTxStXG16Yw/4TjVqE7YKXxwC+mEebm
         YUxrAdzPH5/afH7aJKKgB0nDu0oFhfxPlK/a/oH3IenEkLXXeQ6z+GMtwSlVg/2AK1N0
         ywqw==
X-Gm-Message-State: AOAM532ke1mUZMWyG7S4XCtqmfuMD8JPNT00KhqcBGZe9KWevfIMS76d
        ab+A1FiYpoPwmfgQnxX67nrTipNcXLgE8Q==
X-Google-Smtp-Source: ABdhPJy0g6pZkiwHE0oFUqRTjGu57K8i4MMyLOxOgQQmBEd1NUDk2GlFyW5BjqmnEINAiGmmJijFnQ==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr5393812ljg.127.1633204126011;
        Sat, 02 Oct 2021 12:48:46 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r23sm491197lfe.268.2021.10.02.12.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 12:48:45 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/mdp5: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
To:     Xu Wang <vulab@iscas.ac.cn>, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, jcrouse@codeaurora.org,
        tzimmermann@suse.de, abhinavk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201231094935.25737-1-vulab@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <b8e7ca23-b8aa-18ef-c4a9-2fcaec0f52f6@linaro.org>
Date:   Sat, 2 Oct 2021 22:48:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20201231094935.25737-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2020 12:49, Xu Wang wrote:
> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c  | 18 ++++++------------
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c | 12 ++++--------
>   2 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 15aed45022bc..8d373d2ffd51 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -303,15 +303,12 @@ static int mdp5_disable(struct mdp5_kms *mdp5_kms)
>   	mdp5_kms->enable_count--;
>   	WARN_ON(mdp5_kms->enable_count < 0);
>   
> -	if (mdp5_kms->tbu_rt_clk)
> -		clk_disable_unprepare(mdp5_kms->tbu_rt_clk);
> -	if (mdp5_kms->tbu_clk)
> -		clk_disable_unprepare(mdp5_kms->tbu_clk);
> +	clk_disable_unprepare(mdp5_kms->tbu_rt_clk);
> +	clk_disable_unprepare(mdp5_kms->tbu_clk);
>   	clk_disable_unprepare(mdp5_kms->ahb_clk);
>   	clk_disable_unprepare(mdp5_kms->axi_clk);
>   	clk_disable_unprepare(mdp5_kms->core_clk);
> -	if (mdp5_kms->lut_clk)
> -		clk_disable_unprepare(mdp5_kms->lut_clk);
> +	clk_disable_unprepare(mdp5_kms->lut_clk);
>   
>   	return 0;
>   }
> @@ -325,12 +322,9 @@ static int mdp5_enable(struct mdp5_kms *mdp5_kms)
>   	clk_prepare_enable(mdp5_kms->ahb_clk);
>   	clk_prepare_enable(mdp5_kms->axi_clk);
>   	clk_prepare_enable(mdp5_kms->core_clk);
> -	if (mdp5_kms->lut_clk)
> -		clk_prepare_enable(mdp5_kms->lut_clk);
> -	if (mdp5_kms->tbu_clk)
> -		clk_prepare_enable(mdp5_kms->tbu_clk);
> -	if (mdp5_kms->tbu_rt_clk)
> -		clk_prepare_enable(mdp5_kms->tbu_rt_clk);
> +	clk_prepare_enable(mdp5_kms->lut_clk);
> +	clk_prepare_enable(mdp5_kms->tbu_clk);
> +	clk_prepare_enable(mdp5_kms->tbu_rt_clk);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
> index 09bd46ad820b..02c6c4b68c68 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
> @@ -137,10 +137,8 @@ static int mdp5_mdss_enable(struct msm_mdss *mdss)
>   	DBG("");
>   
>   	clk_prepare_enable(mdp5_mdss->ahb_clk);
> -	if (mdp5_mdss->axi_clk)
> -		clk_prepare_enable(mdp5_mdss->axi_clk);
> -	if (mdp5_mdss->vsync_clk)
> -		clk_prepare_enable(mdp5_mdss->vsync_clk);
> +	clk_prepare_enable(mdp5_mdss->axi_clk);
> +	clk_prepare_enable(mdp5_mdss->vsync_clk);
>   
>   	return 0;
>   }
> @@ -150,10 +148,8 @@ static int mdp5_mdss_disable(struct msm_mdss *mdss)
>   	struct mdp5_mdss *mdp5_mdss = to_mdp5_mdss(mdss);
>   	DBG("");
>   
> -	if (mdp5_mdss->vsync_clk)
> -		clk_disable_unprepare(mdp5_mdss->vsync_clk);
> -	if (mdp5_mdss->axi_clk)
> -		clk_disable_unprepare(mdp5_mdss->axi_clk);
> +	clk_disable_unprepare(mdp5_mdss->vsync_clk);
> +	clk_disable_unprepare(mdp5_mdss->axi_clk);
>   	clk_disable_unprepare(mdp5_mdss->ahb_clk);
>   
>   	return 0;
> 


-- 
With best wishes
Dmitry
