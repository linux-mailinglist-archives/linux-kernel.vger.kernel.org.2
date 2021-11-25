Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5F45DAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352357AbhKYNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351677AbhKYNTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:19:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2AC0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 05:13:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n12so16312624lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxPtdSVDRQX5bqi7JizAtmVow9MuQt/W0D86xbTHGHQ=;
        b=VHFWU0HYMzvIxYMMX3dUUCfFvp1Dj5ccaIlW85NX9C/BbApzELtGk5xLBSEWp8gRzK
         IlK0h/kr6xE0Ha4Myz889IVOFWWUa3K/Pfun2Z+m88D/UYV6wIErEHnsbRdV1LMx0QJ2
         TbxCLA1qnBrufa0NPu7FXqbgRkdfomtB/4g0vOa6k4TOMLLPgu2FxY8l4oeUrM7Ved26
         lUNgcQgpa+/iiyT2ln5Oz3DYg5p1bmuI7puKXrsn8r87aPQzK7xG38XULxjrX/dLs+XQ
         PuAdERBk0ATidB+j8eyJcf4vj4zZIN3NcAQnz4KgmNb58vEYIsqD8Nm2rXJ7wjl8Iyik
         iM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxPtdSVDRQX5bqi7JizAtmVow9MuQt/W0D86xbTHGHQ=;
        b=lRgdeuy39jj55zImSCT+8NRQeZ51YBgnj5abc993l3xzMDc4xcEhi8jOAawzKbZxYg
         mYh6dlGH6iLo/MXQhik3BpJtApv14K57mAYqZh1vwAz/pT9fa6Tg3Ug/zJ+iuDtA9aoS
         heWKF0TfJh2DmTe8pQojGRCfXdRMHT75vd7xSRiYwVNhp8CzR2O4NnVe99NMCChOWu1B
         KD/MzrmsKwXweKzuHC6+Qg8lJqt29Lo9nzPG3kG2oDBxS4C321sPiLsiapPNYJYvc4AA
         A7Xf917iCbT7Z3qmWauRyXtkqUSj32bIQj0igH1R/HRja3AJuFoE0fs32DU1ZAf+xo+X
         2FjA==
X-Gm-Message-State: AOAM531PoB9/FvvX+y6npMhRat77j6wNIfB4Uw7gh4c0uWkkYUnVeqge
        mGqsOdQUC8bkOSYBs+fIdRnjk0AEW98ypQ==
X-Google-Smtp-Source: ABdhPJyCGINht0MOg86lGl3cZMWh2pafYvGATuji6Z/rHNAQ59rwn50dOf0aPTgI9Y1weyorvVWkEQ==
X-Received: by 2002:a05:6512:104f:: with SMTP id c15mr23781125lfb.256.1637846030798;
        Thu, 25 Nov 2021 05:13:50 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e11sm262053lfq.65.2021.11.25.05.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 05:13:50 -0800 (PST)
Subject: Re: [PATCH v5 7/7] drm/msm/dp: Add sc8180x DP controllers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org>
 <20211016221843.2167329-8-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <ce19f893-d805-1285-4bc2-445853498006@linaro.org>
Date:   Thu, 25 Nov 2021 16:13:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211016221843.2167329-8-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2021 01:18, Bjorn Andersson wrote:
> The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
> DP driver.
> 
> Link: https://lore.kernel.org/linux-arm-msm/20210725042436.3967173-7-bjorn.andersson@linaro.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

It seems that SC8180x DPU support was never merged (because of 
hw_interrupt rework, because of hw_catalog TODOs and FIXMEs). Could you 
please post new iteration of that patchset, squashing this one into it?


> ---
> 
> Changes since v4:
> - Use the MSM_DP_CONTROLLER_n enums
> - const the msm_dp_desc array
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  6 +++---
>   drivers/gpu/drm/msm/dp/dp_display.c            | 11 +++++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 47d5d71eb5d3..0ac6a79e8af9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -918,13 +918,13 @@ static const struct dpu_intf_cfg sc7280_intf[] = {
>   };
>   
>   static const struct dpu_intf_cfg sc8180x_intf[] = {
> -	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> +	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>   	INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>   	/* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this is supported */
>   	INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 999, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
> -	INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, 1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
> -	INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, 2, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> +	INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
> +	INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC8180X_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>   };
>   
>   /*************************************************************
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d3c9d7273354..70dcd4e6d466 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -135,8 +135,19 @@ static const struct msm_dp_config sc7180_dp_cfg = {
>   	.num_descs = 1,
>   };
>   
> +static const struct msm_dp_config sc8180x_dp_cfg = {
> +	.descs = (const struct msm_dp_desc[]) {
> +		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +		[MSM_DP_CONTROLLER_1] = { .io_start = 0x0ae98000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +		[MSM_DP_CONTROLLER_2] = { .io_start = 0x0ae9a000, .connector_type = DRM_MODE_CONNECTOR_eDP },
> +	},
> +	.num_descs = 3,
> +};
> +
>   static const struct of_device_id dp_dt_match[] = {
>   	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
> +	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
> +	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_cfg },
>   	{}
>   };
>   
> 


-- 
With best wishes
Dmitry
