Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972B73DBE92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhG3S5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhG3S5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:57:30 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D3C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:57:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o185so14432879oih.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=R52SkjmgEOTUBqEHYa4AfMHcfuuZbXxc9uqTeblsMI4=;
        b=cHDqg/JVMq/KqDermTQjYQh3zJXJCgTPV0eNVwov0YhCZHuLgysibPpi3PiXwC8AL/
         r7BYwYGHH616M3q6D5LlbG06SRra2HKOgobDs6tHNk6qKcizFKqbOz2O8tuMAjVa0e98
         AFfaruS7lNYtXfYX7BcUXNpVasZSMNkgguCmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=R52SkjmgEOTUBqEHYa4AfMHcfuuZbXxc9uqTeblsMI4=;
        b=AZZjIkvCz9BiC0Y5nUms040vfSVaQlA4hkVrlT4fU4B53g4b1NdRrUpaBv/r93mLoC
         1ElOeDix3TOQceH8cW93LF57iBlRKV3A3jW6Sib+QsWQduF6f0AfFxCam4i8V0+RwarH
         XRfIttvO06rSIEKqSIbceH/RPU0BCk3kUZ9MeuBiywcemXiN5DLBeqCwxygD65/ujVSK
         8cpc1i2xlkp0IOaSBiYC3729DurMMjdzB666hfMeafCCIxqcKv9FIcL3t20+svaO25/M
         E4hkg15I29EYZUCOHrcM2yHpbBoakr0n7esr2KFQhv7YLdiC/Z52CETL3O2o1cGZDjMH
         YOvQ==
X-Gm-Message-State: AOAM531ltDWwFoCtJzUUkr+0DLCAKNR3MabR/C9ZeaqXI/wwn0aIbzrA
        /5A82WAa2imXH8W5k8WBJUy5symBEQO97IxV60NvOQ==
X-Google-Smtp-Source: ABdhPJxNDgMIs+i6xUVmTNkHBOhTrdiS70/qH/dNqao4vmx6KI2snPhoSDEX5E4jN4uKjzYEP/Dq7jJoDsUvXCG78qo=
X-Received: by 2002:a05:6808:619:: with SMTP id y25mr3062792oih.166.1627671445211;
 Fri, 30 Jul 2021 11:57:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Jul 2021 11:57:24 -0700
MIME-Version: 1.0
In-Reply-To: <1627507854-16733-1-git-send-email-khsieh@codeaurora.org>
References: <1627507854-16733-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 30 Jul 2021 11:57:24 -0700
Message-ID: <CAE-0n51cNywB2ThQxqS4iX-d7wR+rYXt8P33o9cUq9J6tT915A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: update is_connected status base on sink count
 at dp_pm_resume()
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-28 14:30:54)
> Currently at dp_pm_resume() is_connected state is decided base on hpd connection
> status only. This will put is_connected in wrongly "true" state at the scenario
> that dongle attached to DUT but without hmdi cable connecting to it. Fix this
> problem by adding read sink count from dongle and decided is_connected state base
> on both sink count and hpd connection status.
>

Please add a Fixes tag.

> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 2b660e9..9bcb261 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1308,6 +1308,17 @@ static int dp_display_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int dp_get_sink_count(struct dp_display_private *dp)
> +{
> +       u8 sink_count;
> +
> +       sink_count = drm_dp_read_sink_count(dp->aux);

drm_dp_read_sink_count() returns an int, not a u8. Comparing a u8 to
less than zero doesn't make any sense as it isn't signed.

> +       if (sink_count < 0)
> +               return 0;
> +
> +       return sink_count;
> +}

We can drop this function and just have an int count in dp_pm_resume()
that is compared to < 0 and then ignored.

> +
>  static int dp_pm_resume(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
> @@ -1327,14 +1338,22 @@ static int dp_pm_resume(struct device *dev)
>
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
> -       status = dp_catalog_link_is_connected(dp->catalog);
> +       /*
> +        * set sink to normal operation mode -- D0
> +        * before dpcd read
> +        */
> +       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>
> +       if ((status = dp_catalog_link_is_connected(dp->catalog)))
> +               dp->link->sink_count = dp_get_sink_count(dp);

Do we need to call drm_dp_read_sink_count_cap() as well?

> +       else
> +               dp->link->sink_count = 0;
>         /*
>          * can not declared display is connected unless
>          * HDMI cable is plugged in and sink_count of
>          * dongle become 1
>          */
> -       if (status && dp->link->sink_count)

Is 'status' used anymore? If not, please remove it.

> +       if (dp->link->sink_count)
>                 dp->dp_display.is_connected = true;
>         else
>                 dp->dp_display.is_connected = false;
