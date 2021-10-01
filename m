Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94441F712
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355630AbhJAVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhJAVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:47:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E192C06177F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:45:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y26so44043037lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/3QM+JWeDJkTe4t3CtmCDkFs9BoPpAtgcYva2gyfDlw=;
        b=pB5FIZYV+BREE/kNjfkIrKBciv7pI7+03MvHIx12OEzfaXErvh15RwP6E4Yk9Z3iXq
         Y0CutAM4QjWI7YVk4GT2mgln5Fg1QDDIOCSTbk6sfPiQbyTDTaG8Cl8Bnig4FvqnXBzO
         AyetwfEYYSdp6bqH6zuJ9r5u3KvqvqgmdSsakGxCh5cp2eWifGRTXwDd6gmcavGkqT91
         9Mc1cW9c1W6G2AVcU/BB3qCM3hQLeYt/ZkG7VdxWTelg2SIEQMV5QCEL8SneCxxvem81
         WIELhyeyScTgMdN0kSQQA8BboX3b4C1k6ArQB0PWsI/GPHlvGDPUEiIU2QfU7CqiFgAL
         FDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3QM+JWeDJkTe4t3CtmCDkFs9BoPpAtgcYva2gyfDlw=;
        b=lOpvRB6vMKS8tTh3yGwFRyZTSrnDSKs19lEfteBaSel21+g4n9Tg/nzFZHztqdrr8U
         Du6+UiG36icpO/uFODdv4ukwCbH/zDiM9FKlwHP+4coF7ZU1W22aew9DUUCWZR7ph0qq
         pvhzmmdzL8Oa6y3edSlsrh8DyZnw8nYgHtj18yRj/Dv2pztxa2LgE78je9I430dRjXHt
         D7sGeFrb1TukwbaDjbZJK774+sLyTHu/onPLz7zsdVAWLQqG/T2qQGOKIskuhki19sVe
         TX6PzSTRG1j0y++XdJB6AVzwsvverFwy5gpJ/SFhoKHPZhWSkV1EoGUqD//SD2JH1cTL
         azHQ==
X-Gm-Message-State: AOAM532ZbFPuOTsIf+kh+c2RnlNdM34z7KFZwPoiNuarcys+MBI5qFPI
        8XQBdeM6SmYYialy+KOKN70qmqykzmkdDQ==
X-Google-Smtp-Source: ABdhPJw6MWBrdW/oxXgWl6yPDf7EjHUf1K+v4NhgkOTmf9ESfQWJ8lvv4sfudi5dhIHnJ3bY9LClGA==
X-Received: by 2002:a2e:bc27:: with SMTP id b39mr331770ljf.438.1633124743260;
        Fri, 01 Oct 2021 14:45:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c5sm772982ljd.94.2021.10.01.14.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 14:45:42 -0700 (PDT)
Subject: Re: [PATCH][V2] drm/msm: Fix potential integer overflow on 32 bit
 multiply
To:     Colin King <colin.king@canonical.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210929115352.212849-1-colin.king@canonical.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <e1d66d58-7bfa-ec21-9c19-5c81c071932a@linaro.org>
Date:   Sat, 2 Oct 2021 00:45:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929115352.212849-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2021 14:53, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where clock is 2147485 or greater the 32 bit multiplication
> by 1000 will cause an integer overflow. Fix this by making the constant
> 1000 an unsigned long to ensure a long multiply occurs to avoid the

You are talking about 'unsigned long' here, however in the patch you've 
used just 'unsigned' suffix. So, which one should be used?

I suspect that wanted to use UL here, since mode->clock is int, so it is 
int * unsigned.

Also I'd suggest to define a helper function macro in the drm_modes.h(?) 
that would take struct drm_display_mode pointer and return proper clock. 
See icc_units_to_bps() for the inspiration.


> overflow before assigning the result to the long result in variable
> requested.  Most probably a theoretical overflow issue, but worth fixing
> to clear up static analysis warnings.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
> Fixes: 3e87599b68e7 ("drm/msm/mdp4: add LVDS panel support")
> Fixes: 937f941ca06f ("drm/msm/dp: Use qmp phy for DP PLL and PHY")
> Fixes: ab5b0107ccf3 ("drm/msm: Initial add eDP support in msm drm driver (v5)")
> Fixes: a3376e3ec81c ("drm/msm: convert to drm_bridge")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> V2: Find and fix all unintentional integer overflows that match this
>      overflow pattern.
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c    | 2 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c   | 2 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c | 2 +-
>   drivers/gpu/drm/msm/dp/dp_ctrl.c                    | 4 ++--
>   drivers/gpu/drm/msm/edp/edp_connector.c             | 2 +-
>   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c              | 2 +-
>   drivers/gpu/drm/msm/hdmi/hdmi_connector.c           | 2 +-
>   7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> index 88645dbc3785..83140066441e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> @@ -50,7 +50,7 @@ static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
>   
>   	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>   
> -	mdp4_dtv_encoder->pixclock = mode->clock * 1000;
> +	mdp4_dtv_encoder->pixclock = mode->clock * 1000U;
>   
>   	DBG("pixclock=%lu", mdp4_dtv_encoder->pixclock);
>   
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> index 10eb3e5b218e..d90dc0a39855 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> @@ -225,7 +225,7 @@ static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
>   
>   	DBG("set mode: " DRM_MODE_FMT, DRM_MODE_ARG(mode));
>   
> -	mdp4_lcdc_encoder->pixclock = mode->clock * 1000;
> +	mdp4_lcdc_encoder->pixclock = mode->clock * 1000U;
>   
>   	DBG("pixclock=%lu", mdp4_lcdc_encoder->pixclock);
>   
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> index 7288041dd86a..a965e7962a7f 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> @@ -64,7 +64,7 @@ static int mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
>   	struct drm_encoder *encoder = mdp4_lvds_connector->encoder;
>   	long actual, requested;
>   
> -	requested = 1000 * mode->clock;
> +	requested = 1000U * mode->clock;
>   	actual = mdp4_lcdc_round_pixclk(encoder, requested);
>   
>   	DBG("requested=%ld, actual=%ld", requested, actual);
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 62e75dc8afc6..6babeb79aeb0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1316,7 +1316,7 @@ static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl)
>   	opts_dp->lanes = ctrl->link->link_params.num_lanes;
>   	opts_dp->link_rate = ctrl->link->link_params.rate / 100;
>   	dp_ctrl_set_clock_rate(ctrl, DP_CTRL_PM, "ctrl_link",
> -					ctrl->link->link_params.rate * 1000);
> +					ctrl->link->link_params.rate * 1000U);
>   
>   	phy_configure(phy, &dp_io->phy_opts);
>   	phy_power_on(phy);
> @@ -1336,7 +1336,7 @@ static int dp_ctrl_enable_stream_clocks(struct dp_ctrl_private *ctrl)
>   	int ret = 0;
>   
>   	dp_ctrl_set_clock_rate(ctrl, DP_STREAM_PM, "stream_pixel",
> -					ctrl->dp_ctrl.pixel_rate * 1000);
> +					ctrl->dp_ctrl.pixel_rate * 1000U);
>   
>   	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, true);
>   	if (ret)
> diff --git a/drivers/gpu/drm/msm/edp/edp_connector.c b/drivers/gpu/drm/msm/edp/edp_connector.c
> index 73cb5fd97a5a..837e7873141f 100644
> --- a/drivers/gpu/drm/msm/edp/edp_connector.c
> +++ b/drivers/gpu/drm/msm/edp/edp_connector.c
> @@ -64,7 +64,7 @@ static int edp_connector_mode_valid(struct drm_connector *connector,
>   	struct msm_kms *kms = priv->kms;
>   	long actual, requested;
>   
> -	requested = 1000 * mode->clock;
> +	requested = 1000L * mode->clock;
>   	actual = kms->funcs->round_pixclk(kms,
>   			requested, edp_connector->edp->encoder);
>   
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> index 6e380db9287b..e4c68a59772a 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -209,7 +209,7 @@ static void msm_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	mode = adjusted_mode;
>   
> -	hdmi->pixclock = mode->clock * 1000;
> +	hdmi->pixclock = mode->clock * 1000U;
>   
>   	hstart = mode->htotal - mode->hsync_start;
>   	hend   = mode->htotal - mode->hsync_start + mode->hdisplay;
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
> index 58707a1f3878..ce116a7b1bba 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
> @@ -385,7 +385,7 @@ static int msm_hdmi_connector_mode_valid(struct drm_connector *connector,
>   	struct msm_kms *kms = priv->kms;
>   	long actual, requested;
>   
> -	requested = 1000 * mode->clock;
> +	requested = 1000U * mode->clock;
>   	actual = kms->funcs->round_pixclk(kms,
>   			requested, hdmi_connector->hdmi->encoder);
>   
> 


-- 
With best wishes
Dmitry
