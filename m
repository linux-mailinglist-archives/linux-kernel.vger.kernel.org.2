Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071F392664
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhE0EbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE0EbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:31:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A16FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:29:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so3219630oty.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=b6/faYhfGu8qBtbR9bUitKj7oId3L35j1rSLlZcppAc=;
        b=hqtLG7QpB0PQlZwg8WYtUpXzm2d/c3skqj2CuiBHVhNRi5kJrIGjiCGThIW9cWk625
         F+gG060MyizR0reJ0HKBczMaxAQiJCu56bAJbJ4Z3gyBrrh+XtlXRJwR4KnqTw/XKBfs
         XzwIZPTaXXUDQFHD08XZiVdQAoLGZXeLhvLZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=b6/faYhfGu8qBtbR9bUitKj7oId3L35j1rSLlZcppAc=;
        b=nnlWMFgwogHsHhLbJIMqr07Ru8VPsJnQ3ERQcHCM6zOkOrc42T3Vmiz6gPscOdMyT0
         A04bEseesSXpeCHzLr2tsXSvnsunhav157PbLx7OLE02M7Mg8vCfliTgXmo4FLpYOECI
         39vD3tuc/VuviLITMt2NAkSYeD/Ml+uvdTDOSkTuNYZE5QztRjbT/v0bBaB8Aw3GQsaB
         57c/6RU7Xzm8B7VyuzyXh9f3FLosSI/D1wMPvFnZzsEHRaE4atP8TP/6QLTCORezo5pv
         HEdUkHveWSVM5TujOmQ6ad97bSBp0X+DrFl/1+vzu9ZE86xj5yO59PWp8ckunKP3MjGd
         uGvg==
X-Gm-Message-State: AOAM5339bdVjDpv5kmQS+6hTf0T5fYg3guFoZhbv6h5bMJKIC6HF7uxQ
        lve6SfIj9ZIHcdRIg+PWBUtbHTIBYtYEVv8/Dk328A==
X-Google-Smtp-Source: ABdhPJws6Lj2vooodJL5wMKOsFkykOzSDFlWUi5rcClITq/ysQEsXTKKyLiW6XmKahA5l1NgfJeVvV5+sShDboAl3j0=
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr1338955oth.25.1622089771409;
 Wed, 26 May 2021 21:29:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 May 2021 00:29:30 -0400
MIME-Version: 1.0
In-Reply-To: <1622072989-793-1-git-send-email-khsieh@codeaurora.org>
References: <1622072989-793-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 27 May 2021 00:29:30 -0400
Message-ID: <CAE-0n51tgnPnwTvtNe-w5MjEAOmgtko0aw6Hu744EwOE00tzPg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: keep aux channel up when power of dp phy
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

General note, please Cc dri-devel on freedreno driver patches.

Quoting Kuogee Hsieh (2021-05-26 16:49:49)
> Aux channel is used to perform management function and should be
> running in parallel with main link. Therefore should only power
> down main link and keep aux channel running when power down phy.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Does this supersede the previous patch[1] or is it in addition to?

[1] https://lore.kernel.org/r/1622052503-21158-1-git-send-email-khsieh@codeaurora.org

>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  4 ----
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 11 +++++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)

Given that it touches two subsystems the merge path is questionable.

>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 5115c05..5f93c64 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1844,10 +1844,6 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
>
>         phy_power_off(phy);
>
> -       /* aux channel down, reinit phy */
> -       phy_exit(phy);
> -       phy_init(phy);
> -
>         DRM_DEBUG_DP("DP off link/stream done\n");
>         return ret;
>  }
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b122e63..567e32e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3214,12 +3214,19 @@ static int qcom_qmp_phy_power_off(struct phy *phy)
>  {
>         struct qmp_phy *qphy = phy_get_drvdata(phy);
>         const struct qmp_phy_cfg *cfg = qphy->cfg;
> +       u32 val;
>
>         clk_disable_unprepare(qphy->pipe_clk);
>
>         if (cfg->type == PHY_TYPE_DP) {
> -               /* Assert DP PHY power down */
> -               writel(DP_PHY_PD_CTL_PSR_PWRDN, qphy->pcs + QSERDES_V3_DP_PHY_PD_CTL);
> +               /*
> +                * Assert DP PHY LANE_0_1, LANE_2_3, PSR power down
> +                * keep aux channel up

Maybe say "keep aux channel up until phy_exit() is called" so we know
how long it is supposed to stay on. And just to confirm, it is on in
phy_init(), right?

> +                */
> +               val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> +                       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN |
> +                       DP_PHY_PD_CTL_PSR_PWRDN;
> +               writel(val, qphy->pcs + QSERDES_V3_DP_PHY_PD_CTL);
>         } else {
>                 /* PHY reset */
>                 if (!cfg->no_pcs_sw_reset)
