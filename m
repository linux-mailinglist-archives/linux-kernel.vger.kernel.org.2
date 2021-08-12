Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF273E9BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhHLAmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhHLAmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:42:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:41:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so5648396otu.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=jM+xutYWNtnqEV0s0IGhXP8JVGB/Bhk66wnci23eKj4=;
        b=PxiNRLaJozLwNLBqEV7BuM1/mDxA/OdTcrZh9IFAsWsusIM2qnDMAOZ20Iwm4gR954
         MiP3KowO8X8kwQDEhsIA38BIrMuj8ittf3BWeIOaq2hiMAZv5NlE9DyjC/8iHoTVizK7
         aLPwMczvJ44xTE3/dNdMHahXWi3LeoRjOnTXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=jM+xutYWNtnqEV0s0IGhXP8JVGB/Bhk66wnci23eKj4=;
        b=CnFFWT+s6Lerrn1FuAqIczW1RZ/rHewsFSx2aAp1NZzQTwtd5V0FF+d/qMGBba5eFI
         lmrtTV8J8o9pCGpCYz13LfeiKpuKmmFFwtp0QWKHmRczAknLhKvrcXFPTsCvTf9YPFBW
         BW4xs6ZCrLb3p6QDrSr+pUJ9SvYl/6HVuJAH0AC3YfRs9X+WgHNrUo3/EgLZHRiEhzsk
         yI/soSKmbeB30+RIBtv68kUZ94Lv0ePuZD13tkorCiTYreGERPcw8DWoIJLeuVOxGP35
         qZIC3ONuBfaB3Gn49DmJVZH7zq+RisahvvE5oZZvpnlhCi4UhVmYi4/6Lmt5DzkP4I5z
         ROyA==
X-Gm-Message-State: AOAM532+8xUqD9M8Z/3tO5H29+yUslgwVqvQb7y9PDz8xW9BiWzWDIgk
        MGbKZKTAHv9BH04XF0TLWGAipGdCZlRAdm4jdgFxPw==
X-Google-Smtp-Source: ABdhPJxAp1sBRQqhIhDhSWNPOBvBoD42tMJDnWSfW9Cdjwo+DFTF4wUF/0n1zEPIpBgLayxqaTTwbi8GAYeqEd067Ww=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr1308313otq.233.1628728900794;
 Wed, 11 Aug 2021 17:41:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 17:41:40 -0700
MIME-Version: 1.0
In-Reply-To: <1628726882-27841-2-git-send-email-sbillaka@codeaurora.org>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org> <1628726882-27841-2-git-send-email-sbillaka@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 17:41:40 -0700
Message-ID: <CAE-0n52=mR0Zt8UZ3vOM-nt0UJszcFhi-eYfzDtD0bt3zhNA_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: Add support for SC7280 eDP
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-08-11 17:08:01)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index b131fd37..1096c44 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -856,9 +856,9 @@ static const struct dpu_intf_cfg sm8150_intf[] = {
>  };
>
>  static const struct dpu_intf_cfg sc7280_intf[] = {
> -       INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> +       INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>         INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> -       INTF_BLK("intf_5", INTF_5, 0x39000, INTF_EDP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> +       INTF_BLK("intf_5", INTF_5, 0x39000, INTF_DP, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>  };
>
>  /*************************************************************
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index d2569da..06d5a2d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1244,7 +1244,9 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
>                 struct dp_cr_status *cr, int *training_step)
>  {
>         int ret = 0;
> +       u8 *dpcd = ctrl->panel->dpcd;
>         u8 encoding = DP_SET_ANSI_8B10B;
> +       u8 ssc = 0, assr = 0;

Please don't initialize to zero and then overwrite it before using it.
It hides usage before actual initialization bugs.

>         struct dp_link_info link_info = {0};
>
>         dp_ctrl_config_ctrl(ctrl);
> @@ -1254,9 +1256,21 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
>         link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
>
>         dp_aux_link_configure(ctrl->aux, &link_info);
> +
> +       if (dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5) {
> +               ssc = DP_SPREAD_AMP_0_5;
> +               drm_dp_dpcd_write(ctrl->aux, DP_DOWNSPREAD_CTRL, &ssc, 1);
> +       }
> +
>         drm_dp_dpcd_write(ctrl->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
>                                 &encoding, 1);
>
> +       if (dpcd[DP_EDP_CONFIGURATION_CAP] & DP_ALTERNATE_SCRAMBLER_RESET_CAP) {
> +               assr = DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
> +               drm_dp_dpcd_write(ctrl->aux, DP_EDP_CONFIGURATION_SET,
> +                               &assr, 1);
> +       }
> +
>         ret = dp_ctrl_link_train_1(ctrl, cr, training_step);
>         if (ret) {
>                 DRM_ERROR("link training #1 failed. ret=%d\n", ret);
> @@ -1328,9 +1342,11 @@ static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl)
>         struct dp_io *dp_io = &ctrl->parser->io;
>         struct phy *phy = dp_io->phy;
>         struct phy_configure_opts_dp *opts_dp = &dp_io->phy_opts.dp;
> +       u8 *dpcd = ctrl->panel->dpcd;

const?

>
>         opts_dp->lanes = ctrl->link->link_params.num_lanes;
>         opts_dp->link_rate = ctrl->link->link_params.rate / 100;
> +       opts_dp->ssc = dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5;
>         dp_ctrl_set_clock_rate(ctrl, DP_CTRL_PM, "ctrl_link",
>                                         ctrl->link->link_params.rate * 1000);
>
> @@ -1760,6 +1776,9 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>         ctrl->link->link_params.num_lanes = ctrl->panel->link_info.num_lanes;
>         ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>
> +       if (ctrl->dp_ctrl.pixel_rate == 0)
> +               return -EINVAL;
> +

Why are we enabling the stream with a zero pixel clk?

>         DRM_DEBUG_DP("rate=%d, num_lanes=%d, pixel_rate=%d\n",
>                 ctrl->link->link_params.rate,
>                 ctrl->link->link_params.num_lanes, ctrl->dp_ctrl.pixel_rate);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index ee5bf64..a772290 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -117,8 +117,36 @@ struct dp_display_private {
>         struct dp_audio *audio;
>  };
>
> +struct msm_dp_config {
> +       phys_addr_t io_start[3];
> +       size_t num_dp;
> +};
> +
> +static const struct msm_dp_config sc7180_dp_cfg = {
> +       .io_start = { 0x0ae90000 },
> +       .num_dp = 1,
> +};
> +
> +static const struct msm_dp_config sc8180x_dp_cfg = {
> +       .io_start = { 0xae90000, 0xae98000, 0 },
> +       .num_dp = 3,
> +};
> +
> +static const struct msm_dp_config sc8180x_edp_cfg = {
> +       .io_start = { 0, 0, 0xae9a000 },
> +       .num_dp = 3,
> +};
> +
> +static const struct msm_dp_config sc7280_edp_cfg = {
> +       .io_start = { 0xaea0000, 0 },
> +       .num_dp = 2,
> +};

Are all of these supposed to be here?

> +
>  static const struct of_device_id dp_dt_match[] = {
> -       {.compatible = "qcom,sc7180-dp"},
> +       { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
> +       { .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
> +       { .compatible = "qcom,sc8180x-edp", .data = &sc8180x_edp_cfg },
> +       { .compatible = "qcom,sc7280-edp", .data = &sc7280_edp_cfg },

Please sort alphabetically on compatible string, it helps avoid
conflicts in the future.

>         {}
>  };
>
> @@ -1408,7 +1436,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>
>         dp_hpd_event_setup(dp);
>
> -       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
> +       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 1);
>  }
>
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index 0519dd3..c05fc0a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -248,6 +248,33 @@ static int dp_parser_clock(struct dp_parser *parser)
>         return 0;
>  }
>
> +static int dp_parser_gpio(struct dp_parser *parser)
> +{
> +       struct device *dev = &parser->pdev->dev;
> +       int ret;
> +
> +       parser->panel_bklt_gpio = devm_gpiod_get(dev, "panel-bklt",
> +                       GPIOD_OUT_HIGH);
> +       if (IS_ERR(parser->panel_bklt_gpio)) {
> +               ret = PTR_ERR(parser->panel_bklt_gpio);
> +               parser->panel_bklt_gpio = NULL;
> +               DRM_ERROR("%s: cannot get panel-bklt gpio, %d\n", __func__, ret);
> +               goto fail;
> +       }
> +
> +       parser->panel_pwm_gpio = devm_gpiod_get(dev, "panel-pwm", GPIOD_OUT_HIGH);
> +       if (IS_ERR(parser->panel_pwm_gpio)) {
> +               ret = PTR_ERR(parser->panel_pwm_gpio);
> +               parser->panel_pwm_gpio = NULL;
> +               DRM_ERROR("%s: cannot get panel-pwm gpio, %d\n", __func__, ret);
> +               goto fail;
> +       }
> +
> +       DRM_INFO("gpio on");
> +fail:
> +       return 0;
> +}

Don't we have pwm backlight drivers like
drivers/video/backlight/pwm_bl.c to support this? This sort of thing
doesn't belong in the dp driver.

> +
>  static int dp_parser_parse(struct dp_parser *parser)
>  {
>         int rc = 0;
> @@ -269,6 +296,10 @@ static int dp_parser_parse(struct dp_parser *parser)
>         if (rc)
>                 return rc;
>
> +       rc = dp_parser_gpio(parser);
> +       if (rc)
> +               return rc;
> +
>         /* Map the corresponding regulator information according to
>          * version. Currently, since we only have one supported platform,
>          * mapping the regulator directly.
