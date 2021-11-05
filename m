Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF60446AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhKEWqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKEWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:46:46 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00FC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:44:06 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso12506088otg.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+WX8Ony+rRiGfeMOlVgg9laRVvN7WFcLCFVygK2AEnE=;
        b=QbVTFIJZJMrtiAe6KF2JqYWumFuDKH2NxHcB2Jtw1loSJNYi148ey23obYE046cgeC
         gFvhJBHztlnrRf+Kfegn8O/XpvCaNpiWi421RMGqBaBF7bJd41spIxBWc3CYLCoz/wNz
         ftc4g/+eooT3Ym3eazQRrGnZ8TcyeIu3nPGGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+WX8Ony+rRiGfeMOlVgg9laRVvN7WFcLCFVygK2AEnE=;
        b=w93KwbEku2aQFh9Ovx9djxwNY0URsYL2Ly9KcKlWGGEVYFgMgqB5UEzmsR1eFRgjoB
         UjpsEPpXetSntA5CGjQr1APqGi2rypUCD1MoUs9dqrmAYGivSGd9qljFv7AhUInfoZ/R
         SJJ9VfoHyntnJT2xosRlAc22J4fn/63FNHw0+WfFRB3tYpcEkgZhOyEaRbCepzp35976
         RJMQntlLIhUilzpFnw3YCOC1xBbYEZWdLaH/W9XlVlYkqXxNrW4RiHED5ziXEnDP25Zs
         NNFrCjRNMhD8eqXCKAM05gZ3o5Q0AZS8kkT1BU7x9hiZimCkpfoGE9vP7QAAg3PqkprQ
         5rAw==
X-Gm-Message-State: AOAM5328UcQGsKfE28fpWKyhdThLhtYctcfJaavoCiex3uu1JSHLpSRp
        QHfiJMC9QBMsSslBVHtpHfnsT/JbQYjUf2fCLx9eVg==
X-Google-Smtp-Source: ABdhPJy5xtmakYuQMULnA/0aJZJjq029xQeh+lo87oQLv/bbhjKimEDS3qiZ+v4gGJEf0Z6HeNUDVsH99zbYKaa1qws=
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr46901158otr.77.1636152245892;
 Fri, 05 Nov 2021 15:44:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Nov 2021 15:44:05 -0700
MIME-Version: 1.0
In-Reply-To: <1636133291-10551-1-git-send-email-quic_khsieh@quicinc.com>
References: <1636133291-10551-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 5 Nov 2021 15:44:05 -0700
Message-ID: <CAE-0n50=x8Ca3gXKy=TZZxMB1ciDXCCkAxCsgBPjJ-M8vw-yzw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: do not initialize phy until plugin interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-11-05 10:28:11)
> From: Kuogee Hsieh <khsieh@codeaurora.org>
>
> Combo phy supports both USB and DP simultaneously. There may has a
> possible conflict during phy initialization phase between USB and
> DP driver which may cause USB phy timeout when USB tries to power
> up its phy. This patch has the DP driver not initialize its phy
> during DP driver initialization phase. Instead DP driver only enable
> required regulators and clocks so that it is able to receive HPD
> interrupts after completion of initialization phase. DP driver will
> initialize its phy when HPD plug-in interrupt received.
> This patch also provides a positive side effects which balance regulator
> enable count since regulator only enabled at initialize phase and resume
> and disabled at followed suspend.
>

Any Fixes: tag?

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 97 ++++++++++++++++++++++---------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  9 ++--
>  drivers/gpu/drm/msm/dp/dp_display.c | 71 ++++++++++++++++++++-------
>  3 files changed, 119 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 7ec155d..e0e5dc9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1364,7 +1364,41 @@ static int dp_ctrl_enable_stream_clocks(struct dp_ctrl_private *ctrl)
>         return ret;
>  }
>
> -int dp_ctrl_host_init(struct dp_ctrl *dp_ctrl, bool flip, bool reset)
> +void dp_ctrl_irq_enable(struct dp_ctrl *dp_ctrl, bool flip)
> +{
> +       struct dp_ctrl_private *ctrl;
> +
> +       if (!dp_ctrl) {
> +               DRM_ERROR("Invalid input data\n");
> +               return;
> +       }
> +
> +       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +
> +       ctrl->dp_ctrl.orientation = flip;
> +
> +       dp_catalog_ctrl_reset(ctrl->catalog);
> +
> +       dp_catalog_ctrl_enable_irq(ctrl->catalog, true);
> +}
> +
> +void dp_ctrl_irq_disable(struct dp_ctrl *dp_ctrl)
> +{
> +       struct dp_ctrl_private *ctrl;
> +
> +       if (!dp_ctrl) {

Please lets stop adding NULL pointer checks. They should be pushed as
high as possible in the call chain so that we don't need them down deep
in the driver.

> +               DRM_ERROR("Invalid input data\n");
> +               return;
> +       }
> +
> +       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +
> +       dp_catalog_ctrl_reset(ctrl->catalog);
> +
> +       dp_catalog_ctrl_enable_irq(ctrl->catalog, false);
> +}
> +
> +void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>  {
>         struct dp_ctrl_private *ctrl;
>         struct dp_io *dp_io;
> @@ -1372,34 +1406,24 @@ int dp_ctrl_host_init(struct dp_ctrl *dp_ctrl, bool flip, bool reset)
>
>         if (!dp_ctrl) {
>                 DRM_ERROR("Invalid input data\n");
> -               return -EINVAL;
> +               return;
>         }
>
>         ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>         dp_io = &ctrl->parser->io;
>         phy = dp_io->phy;
>
> -       ctrl->dp_ctrl.orientation = flip;
> -
> -       if (reset)
> -               dp_catalog_ctrl_reset(ctrl->catalog);
> +       DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);

Use %p instead of casting to a u32.

>
> -       DRM_DEBUG_DP("flip=%d\n", flip);
>         dp_catalog_ctrl_phy_reset(ctrl->catalog);
>         phy_init(phy);
> -       dp_catalog_ctrl_enable_irq(ctrl->catalog, true);
>
> -       return 0;
> +       DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
>  }
>
> -/**
> - * dp_ctrl_host_deinit() - Uninitialize DP controller
> - * @dp_ctrl: Display Port Driver data
> - *
> - * Perform required steps to uninitialize DP controller
> - * and its resources.
> - */
> -void dp_ctrl_host_deinit(struct dp_ctrl *dp_ctrl)
> +void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
>  {
>         struct dp_ctrl_private *ctrl;
>         struct dp_io *dp_io;
> @@ -1414,10 +1438,14 @@ void dp_ctrl_host_deinit(struct dp_ctrl *dp_ctrl)
>         dp_io = &ctrl->parser->io;
>         phy = dp_io->phy;
>
> -       dp_catalog_ctrl_enable_irq(ctrl->catalog, false);
> +       DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> +
> +       dp_catalog_ctrl_phy_reset(ctrl->catalog);
>         phy_exit(phy);
>
> -       DRM_DEBUG_DP("Host deinitialized successfully\n");
> +       DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
>  }
>
>  static bool dp_ctrl_use_fixed_nvid(struct dp_ctrl_private *ctrl)
> @@ -1895,8 +1923,14 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
>                 return ret;
>         }
>
> +       DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> +
>         phy_power_off(phy);
>
> +       DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> +
>         /* aux channel down, reinit phy */
>         phy_exit(phy);
>         phy_init(phy);
> @@ -1905,23 +1939,6 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
>         return ret;
>  }
>
> -void dp_ctrl_off_phy(struct dp_ctrl *dp_ctrl)
> -{
> -       struct dp_ctrl_private *ctrl;
> -       struct dp_io *dp_io;
> -       struct phy *phy;
> -
> -       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> -       dp_io = &ctrl->parser->io;
> -       phy = dp_io->phy;
> -
> -       dp_catalog_ctrl_reset(ctrl->catalog);
> -
> -       phy_exit(phy);
> -
> -       DRM_DEBUG_DP("DP off phy done\n");
> -}
> -
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
>  {
>         struct dp_ctrl_private *ctrl;
> @@ -1949,10 +1966,14 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
>                 DRM_ERROR("Failed to disable link clocks. ret=%d\n", ret);
>         }
>
> +       DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> +
>         phy_power_off(phy);
> -       phy_exit(phy);
>
> -       DRM_DEBUG_DP("DP off done\n");
> +       DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
> +               (u32)(uintptr_t)phy, phy->init_count, phy->power_count);
> +

These debug prints make it really hard to see what's actually changing.
Can you please add them after making the fix in a different patch? So
first patch fixes the problem, and the second patch adds more logging to
track the counts for each phy pointer.

>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2363a2d..c1e4b1b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -19,12 +19,9 @@ struct dp_ctrl {
>         u32 pixel_rate;
>  };
>
> -int dp_ctrl_host_init(struct dp_ctrl *dp_ctrl, bool flip, bool reset);
> -void dp_ctrl_host_deinit(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
> -void dp_ctrl_off_phy(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
> @@ -34,4 +31,10 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
>                         struct dp_power *power, struct dp_catalog *catalog,
>                         struct dp_parser *parser);
>
> +void dp_ctrl_irq_enable(struct dp_ctrl *dp_ctrl, bool flip);

This just looks odd. Why does irq enable care about flip? Is there a
better name for this function?

> +void dp_ctrl_irq_disable(struct dp_ctrl *dp_ctrl);
> +void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl);
> +void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl);
> +void dp_ctrl_irq_phy_exit(struct dp_ctrl *dp_ctrl);
> +
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e41dd40..17d2d5c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -84,6 +84,7 @@ struct dp_display_private {
>
>         /* state variables */
>         bool core_initialized;
> +       bool phy_initialized;
>         bool hpd_irq_on;
>         bool audio_supported;
>
> @@ -387,7 +388,7 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>         return rc;
>  }
>
> -static void dp_display_host_init(struct dp_display_private *dp, int reset)
> +static void dp_display_host_init(struct dp_display_private *dp)
>  {
>         bool flip = false;
>
> @@ -400,12 +401,37 @@ static void dp_display_host_init(struct dp_display_private *dp, int reset)
>         if (dp->usbpd->orientation == ORIENTATION_CC2)
>                 flip = true;
>
> -       dp_power_init(dp->power, flip);
> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
> +       dp_power_init(dp->power, false);
> +       dp_ctrl_irq_enable(dp->ctrl, flip);
> +
> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP)

Can we get a comment here why it's safe to initialize the phy for eDP
but not for DP? And maybe a pointer to where the phy is initialized for
DP?

> +               dp_ctrl_phy_init(dp->ctrl);
> +
>         dp_aux_init(dp->aux);
>         dp->core_initialized = true;
>  }
>
> +static void dp_display_host_phy_init(struct dp_display_private *dp)
> +{
> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
> +                       dp->core_initialized, dp->phy_initialized);
> +       if (dp->phy_initialized == false) {

The preferred style is

	if (!dp->phy_initialized)

> +               dp_ctrl_phy_init(dp->ctrl);
> +               dp->phy_initialized = true;
> +       }
> +}
> +
> +static void dp_display_host_phy_exit(struct dp_display_private *dp)
> +{
> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
> +                       dp->core_initialized, dp->phy_initialized);
> +
> +       if (dp->phy_initialized == true) {
> +               dp_ctrl_phy_exit(dp->ctrl);
> +               dp->phy_initialized = false;
> +       }
> +}
> +
>  static void dp_display_host_deinit(struct dp_display_private *dp)
>  {
>         if (!dp->core_initialized) {
> @@ -413,7 +439,7 @@ static void dp_display_host_deinit(struct dp_display_private *dp)
>                 return;
>         }
>
> -       dp_ctrl_host_deinit(dp->ctrl);
> +       dp_ctrl_irq_disable(dp->ctrl);
>         dp_aux_deinit(dp->aux);
>         dp_power_deinit(dp->power);
>
> @@ -424,7 +450,7 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
>  {
>         struct dp_display_private *dp = dev_get_dp_display_private(dev);
>
> -       dp_display_host_init(dp, true);
> +       dp_display_host_phy_init(dp);
>
>         return dp_display_process_hpd_high(dp);
>  }
> @@ -551,7 +577,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>                 dp->hpd_state = ST_DISCONNECTED;
>
>                 if (ret == -ECONNRESET) { /* cable unplugged */
> -                       dp->core_initialized = false;
> +                       dp->phy_initialized = false;
>                 }
>
>         } else {
> @@ -623,9 +649,8 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>         if (state == ST_DISCONNECTED) {
>                 /* triggered by irq_hdp with sink_count = 0 */
>                 if (dp->link->sink_count == 0) {
> -                       dp_ctrl_off_phy(dp->ctrl);
> +                       dp_display_host_phy_exit(dp);
>                         hpd->hpd_high = 0;
> -                       dp->core_initialized = false;
>                 }
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
> @@ -716,7 +741,7 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
>
>         ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
>         if (ret == -ECONNRESET) { /* cable unplugged */
> -               dp->core_initialized = false;
> +               dp->phy_initialized = false;
>         }
>         DRM_DEBUG_DP("hpd_state=%d\n", state);
>
> @@ -918,12 +943,19 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
>
>         dp_display->audio_enabled = false;
>
> -       /* triggered by irq_hpd with sink_count = 0 */
>         if (dp->link->sink_count == 0) {
> +               /*
> +                * irq_hpd with sink_count = 0
> +                * hdmi unplugged out of dongle
> +                */
>                 dp_ctrl_off_link_stream(dp->ctrl);
>         } else {
> +               /*
> +                * unplugged interrupt
> +                * dongle unplugged out of DUT
> +                */
>                 dp_ctrl_off(dp->ctrl);
> -               dp->core_initialized = false;
> +               dp_display_host_phy_exit(dp);
>         }
>
>         dp_power_panel_on(dp->power, false);
> @@ -1059,7 +1091,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  static void dp_display_config_hpd(struct dp_display_private *dp)
>  {
>
> -       dp_display_host_init(dp, true);
> +       dp_display_host_init(dp);
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
>         /* Enable interrupt first time
> @@ -1338,7 +1370,7 @@ static int dp_pm_resume(struct device *dev)
>         dp->hpd_state = ST_DISCONNECTED;
>
>         /* turn on dp ctrl/phy */
> -       dp_display_host_init(dp, true);
> +       dp_display_host_init(dp);
>
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
> @@ -1346,12 +1378,15 @@ static int dp_pm_resume(struct device *dev)
>          * set sink to normal operation mode -- D0
>          * before dpcd read

Does this comment still apply?

>          */
> -       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> -
>         if (dp_catalog_link_is_connected(dp->catalog)) {
> +               dp_display_host_phy_init(dp);
> +
> +               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>                 sink_count = drm_dp_read_sink_count(dp->aux);
>                 if (sink_count < 0)
>                         sink_count = 0;
> +
> +               dp_display_host_phy_exit(dp);
>         }
>
>         dp->link->sink_count = sink_count;
