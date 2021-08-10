Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADA3D6A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhGZXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhGZXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:14:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F0C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:54:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y18so13064159oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/VLYF7ULvK8ZBgtGaBzY2DEw131HN7Z0pCBHVUvwO54=;
        b=hxr7765n6XazZWlQrt1w5TK6xrOZnmJ0Egyb88XGLVXTWx7fLXIPJFISvBfpxLF/Rm
         xnFRkf4oY5oEMEAaOXSUwOucRnQQ/PcaM5rWWyXmoo60bUMF3vBQ5KPWF/wETQ4jt24+
         CktUVvmDz3kzCaFCDYjeWSqxbuBZmPkr2EoF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/VLYF7ULvK8ZBgtGaBzY2DEw131HN7Z0pCBHVUvwO54=;
        b=EMdClBFFsJ+e2jsDfL0xtMWomMftnS7lgN2XRHc7z+1zXEM1QbhMBZKf30pAyGQ8P+
         2/J6/EjHd5ZAFq0uMk7XKNhAsKyIHLhvNXLUzivbKHOnMxPaVEDPnCItwzsLvd0aDGno
         RiZg2g7SnL0V3TirHOvyAng6dwuvx5aZwxmCEE5xsBV/QsJjBWpjJBcmgE4rHajTkiLN
         6Rdc5S5odvgrKCba+PpfOBpUPth2ke6stz86ayvlWDzI5BwNyXP05GHu7tJ+Jfl8UooC
         /dyAlB/mJ9fZ3y8rKISDf2n0q+w9FQNCaslJet9zuzBbhgJQ4Mol2p/A5NglNzcxCJCe
         FsyA==
X-Gm-Message-State: AOAM530+d3wu+BjCNrd/jJkZ01Nw8HjlUpAJ/rXQqUsg7XJbbZWqMr8F
        cjktq9/hbQxZNnp/8nqyuXqNhWka0gtpqTVEce/p7g==
X-Google-Smtp-Source: ABdhPJzd/1nyMLgswv7B9b/xTSfgYdGHuVA0ExUmZ4ifjYmYX/hivyNvHxCzZQ7qLJmY/6pV3kbD/8Sp1ceKx2RVsA0=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr13166680oiu.19.1627343665469;
 Mon, 26 Jul 2021 16:54:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 19:54:25 -0400
MIME-Version: 1.0
In-Reply-To: <20210725042436.3967173-7-bjorn.andersson@linaro.org>
References: <20210725042436.3967173-1-bjorn.andersson@linaro.org> <20210725042436.3967173-7-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 19:54:25 -0400
Message-ID: <CAE-0n52iQ5XOu=X3sVOyvYddoYRY7bHPc-5GiOwTcnOwLL2_gQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/msm/dp: Add sc8180x DP controllers
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-24 21:24:36)
> The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
> DP driver.
>
> Link: https://lore.kernel.org/linux-arm-msm/20210511042043.592802-5-bjorn.andersson@linaro.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 92b7646a1bb7..c26805cfcdd1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -129,8 +129,20 @@ static const struct msm_dp_config sc7180_dp_cfg = {
>         .num_dp = 1,
>  };
>
> +static const struct msm_dp_config sc8180x_dp_cfg = {
> +       .io_start = { 0xae90000, 0xae98000, 0 },
> +       .num_dp = 3,
> +};
> +
> +static const struct msm_dp_config sc8180x_edp_cfg = {
> +       .io_start = { 0, 0, 0xae9a000 },
> +       .num_dp = 3,
> +};

Can the two structs not be combined into one struct and set as .data for
either compatible?

> +
>  static const struct of_device_id dp_dt_match[] = {
>         { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
> +       { .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
> +       { .compatible = "qcom,sc8180x-edp", .data = &sc8180x_edp_cfg },
>         {}
