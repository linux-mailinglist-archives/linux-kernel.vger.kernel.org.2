Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A6421B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhJEA75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJEA7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:59:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D472C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:58:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so23826974ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=05i/Uy6gH7QU48SgJKDCirwR+ez4PcUFTnCClwqtXkI=;
        b=B61+Xp8onNbuyRL6JL9Kxx4gC7m4sx0TwG+gx96gdFijZbZa2c6EJNfNtnOeQJOwXX
         eLTEkAB++Egb3OWnOCeMRLxZ200uG29IPQPtRxmdxhoPMiZ0Kzq4wjKcMiUzLVW7BtHg
         VGNt67VDZhoMZ3GAicFMm7CEiyGU80AfYNBWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=05i/Uy6gH7QU48SgJKDCirwR+ez4PcUFTnCClwqtXkI=;
        b=zjGCiyL17UDpYAdo/+SWmbnR4vxklIyYECaSN+crVz/sLWn15Naqh7zYoqPjZ5yB7E
         zpBy9NeBJkpMBRYX97aBP7muklUPtmWC2PhOpcugjUAZXrYQLM9YxsLhuKhaThdvUhg5
         1kIKzKl3J8Ikt+WDYYhaRoXz3XPrbnZuUmlDnIJbeB7sSg54/spigIZliec7sgF8EUiU
         HzL4VnURY40aDNiOtZCxAfsb2wriKB/ToqSwLjp+bywin3FpjJ81nslQXJ3BK3SQT1aq
         0VM+ubhHRpS6OPjbt956XvaOwuyYl4YJPIfB+wsBuWWtGNaYuchzr108HY9nGYefuonZ
         omCA==
X-Gm-Message-State: AOAM530EcUUggwRnkEx7UdmU0YA6bXcldt+5hY82X5qMJ3yvS2Rwd19X
        DgJMflvLjHuwjCZPlBpUt5WZb8gXcerxp07gWZN7GA==
X-Google-Smtp-Source: ABdhPJx07aCTnqNwiD/0aa6rjlgcFB5P771OgnalRpLSTtV86//Yf7K4nDE2SG3vY/Lrmi1lOKT5dn1JO1kfvg1iC44=
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr11371665ote.159.1633395483677;
 Mon, 04 Oct 2021 17:58:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 20:58:03 -0400
MIME-Version: 1.0
In-Reply-To: <20211001180058.1021913-4-bjorn.andersson@linaro.org>
References: <20211001180058.1021913-1-bjorn.andersson@linaro.org> <20211001180058.1021913-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 20:58:03 -0400
Message-ID: <CAE-0n50=EWg1GKuTnRi=zA0ufO1Xg4mucYaqNUZ+wgYNDRcWLA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/msm/dp: Support up to 3 DP controllers
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

Quoting Bjorn Andersson (2021-10-01 11:00:56)
> Based on the removal of the g_dp_display and the movement of the
> priv->dp lookup into the DP code it's now possible to have multiple
> DP instances.
>
> In line with the other controllers in the MSM driver, introduce a
> per-compatible list of base addresses which is used to resolve the
> "instance id" for the given DP controller. This instance id is used as
> index in the priv->dp[] array.
>
> Then extend the initialization code to initialize struct drm_encoder for
> each of the registered priv->dp[] and update the logic for associating
> each struct msm_dp with the struct dpu_encoder_virt.
>
> Lastly, bump the number of struct msm_dp instances carries by priv->dp
> to 3, the currently known maximum number of controllers found in a
> Qualcomm SoC.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Some nits below.

>
> Changes since v2:
> - Added MSM_DRM_DP_COUNT to link the two 3s
> - Moved NULL check for msm_dp_debugfs_init() to the call site
> - Made struct dp_display_private->id unsigned
>
> I also implemented added connector_type to each of the DP instances and
> propagated this to dp_drm_connector_init() but later dropped this again per
> Doug's suggestion that we'll base this on the presence/absence of a associated
> drm bridge or panel.

Sad but OK. We can take up that topic in another patch.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index f655adbc2421..875b07e7183d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -203,8 +204,10 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
>         dpu_debugfs_vbif_init(dpu_kms, entry);
>         dpu_debugfs_core_irq_init(dpu_kms, entry);
>
> -       if (priv->dp)
> -               msm_dp_debugfs_init(priv->dp, minor);
> +       for (i = 0; i < ARRAY_SIZE(priv->dp); i++) {
> +               if (priv->dp[i])
> +                       msm_dp_debugfs_init(priv->dp[i], minor);

This seems to cause a bunch of debugfs warnings when there are multiple
nodes created with the same name.

> +       }
>
>         return dpu_core_perf_debugfs_init(dpu_kms, entry);
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5d3ee5ef07c2..ff3477474c5d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1180,10 +1192,31 @@ int dp_display_request_irq(struct msm_dp *dp_display)
>         return 0;
>  }
>
> +static int dp_display_find_id(struct platform_device *pdev)
> +{
> +       const struct msm_dp_config *cfg = of_device_get_match_data(&pdev->dev);
> +       struct resource *res;
> +       int i;
> +
> +

Nitpick: Remove a newline here.

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       for (i = 0; i < cfg->num_descs; i++) {
> +               if (cfg->io_start[i] == res->start)
> +                       return i;
> +       }

Nitpick: Drop braces on single line if inside for loop.

> +
> +       dev_err(&pdev->dev, "unknown displayport instance\n");
> +       return -EINVAL;
> +}
> +
