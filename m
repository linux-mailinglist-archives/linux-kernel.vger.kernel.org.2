Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB593F93FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhH0FVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhH0FVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:21:05 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A21C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:20:16 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so1652930ooh.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Bw4lKm4DRkGFFU7y4OaUt8e27BK/aybFhJJcTi57MKQ=;
        b=gCLbg1CxO2PIQr82hXvq5x3DCZzn0hCanazRdNlFzAq16ek7wRftRsq/Y57VmbYSkw
         0Enk78gHR96jzNxPHVxQVdKGlh0+VsTEs8xzxIQeKX0vAMOe3RHO6OJUlF9AbAzC0qwo
         IkH6kuatJ/i79Usj0jWz1RwrzL2ONPJBVlit0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Bw4lKm4DRkGFFU7y4OaUt8e27BK/aybFhJJcTi57MKQ=;
        b=TG72wciOoFbxjwll7VsZprGSsOIAbzKVpJaDbXN6yUhwzAno5lpVD4N2/1uSCSBiZp
         c9xTmCEOf29O45DNLR7vcPxw9tc4XzTjrc+umFiVAp7UDcPUndWZRCKYwIpG8PDu194X
         XUOTHE2KBFtjton5mOxwvbRwugVeEJfiAhsIaS2jpb1YVD9thcn7beGfaFIWYqeo+R1p
         jry3VpQ9z+e9Exp4rGnrcgVGfI4Gt+PP54Pksz38ylZGAKwXgzF1u8YrX8dfKecsy5lL
         LtuiusOw74FPa5HclCRgFEKQY+vvA3R0JQtdGTqROX0oGLyj2SQlc2v6vr20gGsjOtC9
         5ULg==
X-Gm-Message-State: AOAM533GWDIuBh2uZnUS4u3wQEOR/y+/8gjL15Wd20tz/T2L8iJk8fXU
        0tUrzsK1x91zp7ytpR9/3CblxWdveQZJUhBdMcNCOQ==
X-Google-Smtp-Source: ABdhPJyF/shA5tj4grc4XQr75ReQxmjvKFU7KCfjLGOgJoX6KU6XDNl7YbXOo50MZUzV4QTwzxU2ZFZpGDn7CFu9Li8=
X-Received: by 2002:a4a:96e1:: with SMTP id t30mr6124297ooi.16.1630041615566;
 Thu, 26 Aug 2021 22:20:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 22:20:15 -0700
MIME-Version: 1.0
In-Reply-To: <20210825234233.1721068-4-bjorn.andersson@linaro.org>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org> <20210825234233.1721068-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 22:20:15 -0700
Message-ID: <CAE-0n52YaQXQ4-=bR5ffMHOMp7CyFnCS-u9a2pddvaRUQhLrog@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/msm/dp: Support up to 3 DP controllers
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

Quoting Bjorn Andersson (2021-08-25 16:42:31)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 2c7de43f655a..4a6132c18e57 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -78,6 +78,8 @@ struct dp_display_private {
>         char *name;
>         int irq;
>
> +       int id;
> +
>         /* state variables */
>         bool core_initialized;
>         bool hpd_irq_on;
> @@ -115,8 +117,19 @@ struct dp_display_private {
>         struct dp_audio *audio;
>  };
>
> +
> +struct msm_dp_config {
> +       phys_addr_t io_start[3];

Can this be made into another struct, like msm_dp_desc, that also
indicates what type of DP connector it is, i.e. eDP vs DP? That would
help me understand in modetest and /sys/class/drm what sort of connector
is probing. dp_drm_connector_init() would need to pass the type of
connector appropriately. Right now, eDP connectors still show up as DP
instead of eDP in sysfs.

> +       size_t num_dp;
> +};
> +
> +static const struct msm_dp_config sc7180_dp_cfg = {
> +       .io_start = { 0x0ae90000 },
> +       .num_dp = 1,
> +};
> +
>  static const struct of_device_id dp_dt_match[] = {
> -       {.compatible = "qcom,sc7180-dp"},
> +       { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
>         {}
>  };
>
