Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECD3BF64E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGHHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhGHHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:35:55 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 00:33:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s24so6780102oiw.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PdJCICv/Zysk0e+rf0benlWHKSPGV6HDfju3kxJCLWI=;
        b=HzAqGgTBHOoSvW4yL5OJTF0SLSJqdiJIFxBh2b1ujPsK3SPtVYR2jz2hx9tNL/IYbb
         QYp9xsuCHTijSgsLuC2xO8SRCv74dF+mvAZa6qN37mX9tQPp5IZutfz+zb5qFh9epYBH
         3hlMxyfGYJpyVqQdXHjgs5BqOQee0bT9zqwos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PdJCICv/Zysk0e+rf0benlWHKSPGV6HDfju3kxJCLWI=;
        b=AFLoQC9e6A4S3f9yM/XLZgvU6ky/hjdJ9yRfwNc/6Fih3pO1wr21Wk6CtxxuSXNliu
         kEep5mPLB0o79OvglJnzIJzXOJRFzL+pdMmhEgfDi5C9+6FJkm/7sJGqAp3QFCNsLkj6
         h1dFhn1izMRdc3rcI3rOFEPG3lkIQZqpp04GMz34TwPU665LM+w7zgk3JNTKu5x5/mBA
         jKCJIFOfLLGbfC+8Vlt5D++WdkfQVnIf5RIl3qjXZTsz/+Q/JZvTVFme+PqRqbBneJi+
         PenwfhF30vAbO9ijjH8lK03FJZMGGN7pMVDiwQfXLeu88J/4GLkDylwwWIDjztvdx2Qh
         EVCg==
X-Gm-Message-State: AOAM531SxT345tyY3SkT4Bcp3O8H3+uB0yJ9PXLlvFZbDMB6iodLUQor
        W/0QENj2a3Dfwq2+WuFw9fUaRJoEw5k/EpQm+IwDpA==
X-Google-Smtp-Source: ABdhPJy08szo/mEaH0I349rMh8ZGhur3wEQvn9fc2VfBGOAR488PWDiPqSciyCfh8UPJrapJeNA2IvmCULZYBZWIqN8=
X-Received: by 2002:aca:3012:: with SMTP id w18mr2575205oiw.125.1625729593722;
 Thu, 08 Jul 2021 00:33:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 07:33:13 +0000
MIME-Version: 1.0
In-Reply-To: <1625592020-22658-3-git-send-email-khsieh@codeaurora.org>
References: <1625592020-22658-1-git-send-email-khsieh@codeaurora.org> <1625592020-22658-3-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 07:33:13 +0000
Message-ID: <CAE-0n52WyMKdQ96ji=5YLBxpndgB_CLsxscXaFexMPdLducrkQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/msm/dp: reduce link rate if failed at link
 training 1
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-06 10:20:15)
> Reduce link rate and re start link training if link training 1
> failed due to loss of clock recovery done to fix Link Layer
> CTS case 4.3.1.7.  Also only update voltage and pre-emphasis
> swing level after link training started to fix Link Layer CTS
> case 4.3.1.6.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 86 ++++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 27fb0f0..6f8443d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -83,13 +83,6 @@ struct dp_ctrl_private {
>         struct completion video_comp;
>  };
>
> -struct dp_cr_status {
> -       u8 lane_0_1;
> -       u8 lane_2_3;
> -};
> -
> -#define DP_LANE0_1_CR_DONE     0x11
> -
>  static int dp_aux_link_configure(struct drm_dp_aux *aux,
>                                         struct dp_link_info *link)
>  {
> @@ -1080,7 +1073,7 @@ static int dp_ctrl_read_link_status(struct dp_ctrl_private *ctrl,
>  }
>
>  static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
> -               struct dp_cr_status *cr, int *training_step)
> +               u8 *cr, int *training_step)
>  {
>         int tries, old_v_level, ret = 0;
>         u8 link_status[DP_LINK_STATUS_SIZE];
> @@ -1109,8 +1102,8 @@ static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
>                 if (ret)
>                         return ret;
>
> -               cr->lane_0_1 = link_status[0];
> -               cr->lane_2_3 = link_status[1];
> +               cr[0] = link_status[0];
> +               cr[1] = link_status[1];
>
>                 if (drm_dp_clock_recovery_ok(link_status,
>                         ctrl->link->link_params.num_lanes)) {
> @@ -1188,7 +1181,7 @@ static void dp_ctrl_clear_training_pattern(struct dp_ctrl_private *ctrl)
>  }
>
>  static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
> -               struct dp_cr_status *cr, int *training_step)
> +               u8 *cr, int *training_step)
>  {
>         int tries = 0, ret = 0;
>         char pattern;
> @@ -1204,10 +1197,6 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>         else
>                 pattern = DP_TRAINING_PATTERN_2;
>
> -       ret = dp_ctrl_update_vx_px(ctrl);
> -       if (ret)
> -               return ret;
> -
>         ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, pattern);
>         if (ret)
>                 return ret;
> @@ -1220,8 +1209,8 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>                 ret = dp_ctrl_read_link_status(ctrl, link_status);
>                 if (ret)
>                         return ret;
> -               cr->lane_0_1 = link_status[0];
> -               cr->lane_2_3 = link_status[1];
> +               cr[0] = link_status[0];
> +               cr[1] = link_status[1];
>
>                 if (drm_dp_channel_eq_ok(link_status,
>                         ctrl->link->link_params.num_lanes)) {
> @@ -1241,7 +1230,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>  static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl);
>
>  static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
> -               struct dp_cr_status *cr, int *training_step)
> +               u8 *cr, int *training_step)
>  {
>         int ret = 0;
>         u8 encoding = DP_SET_ANSI_8B10B;
> @@ -1282,7 +1271,7 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
>  }
>
>  static int dp_ctrl_setup_main_link(struct dp_ctrl_private *ctrl,
> -               struct dp_cr_status *cr, int *training_step)
> +               u8 *cr, int *training_step)
>  {
>         int ret = 0;
>
> @@ -1496,14 +1485,14 @@ static int dp_ctrl_deinitialize_mainlink(struct dp_ctrl_private *ctrl)
>  static int dp_ctrl_link_maintenance(struct dp_ctrl_private *ctrl)
>  {
>         int ret = 0;
> -       struct dp_cr_status cr;
> +       u8 cr_status[2];
>         int training_step = DP_TRAINING_NONE;
>
>         dp_ctrl_push_idle(&ctrl->dp_ctrl);
>
>         ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>
> -       ret = dp_ctrl_setup_main_link(ctrl, &cr, &training_step);
> +       ret = dp_ctrl_setup_main_link(ctrl, cr_status, &training_step);
>         if (ret)
>                 goto end;

Do we need to extract the link status information from deep in these
functions? Why not read it again when we need to?

>
> @@ -1634,6 +1623,41 @@ void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
>         }
>  }
>
> +static bool dp_ctrl_any_lane_cr_done(struct dp_ctrl_private *ctrl,
> +                                       u8 *cr_status)
> +
> +{
> +       int i;
> +       u8 status;
> +       int lane = ctrl->link->link_params.num_lanes;
> +
> +       for (i = 0; i < lane; i++) {
> +               status = cr_status[i / 2];
> +               status >>= ((i % 2) * 4);
> +               if (status & DP_LANE_CR_DONE)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool dp_ctrl_any_lane_cr_lose(struct dp_ctrl_private *ctrl,
> +                                       u8 *cr_status)
> +{
> +       int i;
> +       u8 status;
> +       int lane = ctrl->link->link_params.num_lanes;
> +
> +       for (i = 0; i < lane; i++) {
> +               status = cr_status[i / 2];
> +               status >>= ((i % 2) * 4);
> +               if (!(status & DP_LANE_CR_DONE))
> +                       return true;
> +       }
> +
> +       return false;
> +}

Why not use !drm_dp_clock_recovery_ok() for dp_ctrl_any_lane_cr_lose()?
And then move dp_ctrl_any_lane_cr_done() next to
drm_dp_clock_recovery_ok() and call it drm_dp_clock_recovery_any_ok()?

> +
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>  {
>         int rc = 0;
> @@ -1641,7 +1665,7 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>         u32 rate = 0;
>         int link_train_max_retries = 5;
>         u32 const phy_cts_pixel_clk_khz = 148500;
> -       struct dp_cr_status cr;
> +       u8 cr_status[2];
>         unsigned int training_step;
>
>         if (!dp_ctrl)
> @@ -1681,19 +1705,18 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>                 }
>
>                 training_step = DP_TRAINING_NONE;
> -               rc = dp_ctrl_setup_main_link(ctrl, &cr, &training_step);
> +               rc = dp_ctrl_setup_main_link(ctrl, cr_status, &training_step);
>                 if (rc == 0) {
>                         /* training completed successfully */
>                         break;
>                 } else if (training_step == DP_TRAINING_1) {
>                         /* link train_1 failed */
> -                       if (!dp_catalog_link_is_connected(ctrl->catalog)) {
> +                       if (!dp_catalog_link_is_connected(ctrl->catalog))
>                                 break;
> -                       }
>
>                         rc = dp_ctrl_link_rate_down_shift(ctrl);
>                         if (rc < 0) { /* already in RBR = 1.6G */
> -                               if (cr.lane_0_1 & DP_LANE0_1_CR_DONE) {
> +                               if (dp_ctrl_any_lane_cr_done(ctrl, cr_status)) {
>                                         /*
>                                          * some lanes are ready,
>                                          * reduce lane number
> @@ -1709,12 +1732,15 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>                                 }
>                         }
>                 } else if (training_step == DP_TRAINING_2) {
> -                       /* link train_2 failed, lower lane rate */
> -                       if (!dp_catalog_link_is_connected(ctrl->catalog)) {
> +                       /* link train_2 failed */
> +                       if (!dp_catalog_link_is_connected(ctrl->catalog))
>                                 break;
> -                       }
>
> -                       rc = dp_ctrl_link_lane_down_shift(ctrl);
> +                       if (dp_ctrl_any_lane_cr_lose(ctrl, cr_status))
> +                               rc = dp_ctrl_link_rate_down_shift(ctrl);
> +                       else
> +                               rc = dp_ctrl_link_lane_down_shift(ctrl);
> +
>                         if (rc < 0) {
>                                 /* end with failure */
>                                 break; /* lane == 1 already */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
