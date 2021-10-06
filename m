Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0CA4234D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhJFAR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:17:24 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C5C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 17:15:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso964047otj.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9tzMxEXeRZ9vZ6WKGHD8GdqG31K/v2rLyNRBux+Swf4=;
        b=OQygNhVVehGtg+wS+bXFa/5K4w+jHJ8XiWZZc9xqBeysMV0N1n9NlIwDng1+Cojt5u
         TRNVm2MYGpXYZIg/Z4wzA5EMFkwgvIy1kC8LA8oorAxOy3dN7WqdJT8YHWrb0mhSPmlt
         pOVWRrrO4p9IeMsttWIJAuM9EAtEVukvZfZP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9tzMxEXeRZ9vZ6WKGHD8GdqG31K/v2rLyNRBux+Swf4=;
        b=IpcT9s83xTonpwkUG5wXUnKlCz3ohZxthj/7i3XNPDAw1JGPJSLOKAEMw66Q94RIB0
         bV0efPiSK82cHKU9S5rGyDgYv+qQpf3Zi3l9HvN8sZ8pecDaVY3Q+8g5IiQs2j0SDX+H
         UNK299pr9dQAfwt9T4JsV89dtKndJoY5T2dqQ1YZN3O7wYDnY3T205upemc5ZtxCGEe8
         qp90kZy8liBtayBeQRnsW9FsdXQ9hQXkFpTdd/KzNrHknXuD/EOO/rnmncntB50Ntn7/
         dYTfpiz3bXNTUfkTcFR6QpadgiVvJXtzEdsMhCR7wvVcu7Uiq56SdVAusXKDj2rv6WRX
         yCMQ==
X-Gm-Message-State: AOAM532V0ZNpY16bSw3eUzvWNPl7qih1EjKW53PauxvgPK/iyy4awa9h
        KGUivn0hEmvca8WyW6M4yFdOtmQMpSTmD18M9KBIMw==
X-Google-Smtp-Source: ABdhPJzSi7rJ/j68GKHBK0r+knYE/P5yBIQ/VbjAnJL7ff/zbZl98PnkJ9ta6ivRwIe2lxeGGKRz/NNCimqJP8IUsLk=
X-Received: by 2002:a9d:1f4:: with SMTP id e107mr16675560ote.77.1633479332704;
 Tue, 05 Oct 2021 17:15:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 17:15:32 -0700
MIME-Version: 1.0
In-Reply-To: <20211005231323.2663520-4-bjorn.andersson@linaro.org>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org> <20211005231323.2663520-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 17:15:32 -0700
Message-ID: <CAE-0n53cQwmz2j1TDkfmt7+JLFD3QBkY8_Tb1HPALqsWJFWmUA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] drm/msm/dp: Allow specifying connector_type per controller
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

Quoting Bjorn Andersson (2021-10-05 16:13:19)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5d3ee5ef07c2..eaf08f9e7d87 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -115,8 +115,25 @@ struct dp_display_private {
>         struct dp_audio *audio;
>  };
>
> +struct msm_dp_desc {
> +       phys_addr_t io_start;
> +       int connector_type;
> +};
> +
> +struct msm_dp_config {
> +       struct msm_dp_desc *descs;

const?

> +       size_t num_descs;
> +};
> +
> +static const struct msm_dp_config sc7180_dp_cfg = {
> +       .descs = (struct msm_dp_desc[]) {

const?

> +               { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +       },
> +       .num_descs = 1,
> +};
> +
>  static const struct of_device_id dp_dt_match[] = {
> -       {.compatible = "qcom,sc7180-dp"},
> +       { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
>         {}
>  };
>
> @@ -1180,10 +1197,29 @@ int dp_display_request_irq(struct msm_dp *dp_display)
>         return 0;
>  }
>
> +static struct msm_dp_desc *dp_display_get_desc(struct platform_device *pdev)

const msm_dp_desc?

> +{
> +       const struct msm_dp_config *cfg = of_device_get_match_data(&pdev->dev);
> +       struct resource *res;
> +       int i;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return NULL;
> +
> +       for (i = 0; i < cfg->num_descs; i++)
> +               if (cfg->descs[i].io_start == res->start)
> +                       return &cfg->descs[i];
> +
> +       dev_err(&pdev->dev, "unknown displayport instance\n");
> +       return NULL;
> +}
> +
>  static int dp_display_probe(struct platform_device *pdev)
>  {
>         int rc = 0;
>         struct dp_display_private *dp;
> +       struct msm_dp_desc *desc;

const?

>
>         if (!pdev || !pdev->dev.of_node) {
>                 DRM_ERROR("pdev not found\n");
> @@ -1194,8 +1230,13 @@ static int dp_display_probe(struct platform_device *pdev)
>         if (!dp)
>                 return -ENOMEM;
>
> +       desc = dp_display_get_desc(pdev);
> +       if (!desc)
> +               return -EINVAL;
> +
>         dp->pdev = pdev;
>         dp->name = "drm_dp";
> +       dp->dp_display.connector_type = desc->connector_type;
>
>         rc = dp_init_sub_modules(dp);
>         if (rc) {
