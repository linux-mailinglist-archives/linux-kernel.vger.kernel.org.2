Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753F23DA015
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhG2JK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhG2JK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:10:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71742C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:10:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so9661584lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1oTdGaEQ77wKFt5yMUzZqXg44oVq6MHBdIKvRtKHso=;
        b=xiRwb6lr+yN2TvAWWqnnWrrLDB723jy82nWZmOQ8iowGgp/4xpqEERcNg7aNe5TMiu
         /KXTATfbuD5j1Pnh2+TbZ9CCZp9PqZ1qebUtJQK8wDsCEIJGEQpJzKE4QRNKY6utUDp+
         BEapaAqUXw0T9DqgL1mfwrMFNCtjgrduBVYu4KMH8cNbOfU19ti5pTFvRPbHaPSExcRi
         sDvrhiOGF3CsPKysGtGFELNvONsDuI9ZtUQNFJqBxo4dEFtvnLBCPZeL1bDsdrzaXI83
         tlLWKf3j89ECUP6m2GVoDiYRclqxVqrwepriFE/bcX8AsIAsQNCGRV4OhKlx2xjzuXKV
         QqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1oTdGaEQ77wKFt5yMUzZqXg44oVq6MHBdIKvRtKHso=;
        b=V3JdXOUXNoUYz7FOUbjR2kpyKaU72UuFyvV7jbM2geO1AAMhqNsq3266LUfhcOgK3o
         qgDAMh49GoHcQoVzk0K3+hqW74w/G2Xr6ncghvqcRlpLn9n8E0ZRNBNwheVPQQXsTcSF
         pH9XpTj0k1JqEurMjfPZUlOpJIXl/cHRt9nEnvQhKJio9gs6nf5iUcy2etf1pkZ5In5v
         TCHXU8oayYdTOaW8s0wjhfN9FsiR7AEN+sTQpxlpZx8M5xdlo+15aJVBDiqjEVx1wuI6
         i7veQj+mYazFsVyH/3Q4vvGHJzewIs6FG/nsLicpPmW+dMaujfATyaX+WxZSyc8/9V+q
         vXYw==
X-Gm-Message-State: AOAM532mEXQZ+jd0r3uTo5gSkirZqGmx9TgEE6UVgFttWy5Uv/T3zI1V
        4dYtxvhk5FgGdc0LFTTQTl/9VZXpynhqGg==
X-Google-Smtp-Source: ABdhPJwibZhgd98KMXz/38f1bi6OLY99Lu6tvHg+uIoC2n0wFaLTXoWHoZpl/kqoKRgpcmyUUWlhJw==
X-Received: by 2002:a05:6512:131d:: with SMTP id x29mr3220085lfu.655.1627549822611;
        Thu, 29 Jul 2021 02:10:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v130sm243109lfa.284.2021.07.29.02.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:10:22 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/dsi: Fix DSI and DSI PHY regulator config from
 SDM660
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210728222057.52641-1-konrad.dybcio@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <f19a9368-1d51-9e1a-dfe8-04d6970e149f@linaro.org>
Date:   Thu, 29 Jul 2021 12:10:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728222057.52641-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2021 01:20, Konrad Dybcio wrote:
> VDDA is not present and the specified load value is wrong. Fix it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c          | 1 -
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index f3f1c03c7db9..763f127e4621 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -154,7 +154,6 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>   	.reg_cfg = {
>   		.num = 2,
>   		.regs = {
> -			{"vdd", 73400, 32 },	/* 0.9 V */
>   			{"vdda", 12560, 4 },	/* 1.2 V */
>   		},
>   	},
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> index a34cf151c517..bb31230721bd 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> @@ -1050,7 +1050,7 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs = {
>   	.reg_cfg = {
>   		.num = 1,
>   		.regs = {
> -			{"vcca", 17000, 32},
> +			{"vcca", 73400, 32},
>   		},
>   	},
>   	.ops = {
> 


-- 
With best wishes
Dmitry
