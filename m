Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760B3827C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhEQJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhEQJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:06:48 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:05:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z1so5504407ils.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o60wPNLr21xWpD+QwBWtK7YH8IFJi6smJPucpJVnzMY=;
        b=oG167cCo5raGDssXdEmdUQlIdmaHQVF5t31VR1SsNkqG5d/rhAg6Tv/rjbL2BdrXlF
         T4S//obYm6TeUseFLMj8i86rcCBTfsekBZuA1NqR1Hvt6llzpfqeYmEZ4/ORyJmShOqy
         d1wb/6dO2bAoFSZjKki/OS2d8gh7OnVy1ZiioADr5eAm4FdxBh7AasoXJYPjmfdNVGvG
         PHT7pl4vDF+FWRF7Q02XVzcuIxa1YWK0wveJSD38M1z1FVkDd9eNZ8ZXtU/tR0xe1TDi
         xovUSpuOGnV9VME7mHt5Lc+Q71gQ45OpJOskyEa5VzP8e2EwLO6It7QOH4j9G7zz8Tkg
         91zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o60wPNLr21xWpD+QwBWtK7YH8IFJi6smJPucpJVnzMY=;
        b=l4wcTjASGSiBjaBscq2ofQNgeF1ZmEYNHknCuyzd8HN/MmZ0Y6tbImgjJqcGHahH2R
         OGQO53U5I8m4e1mw/JqIU2i8mKDpb2/7TtYeeJwYrgYr5br4LsPWshCbOeGBvz6w/WxU
         vJ71pmaGuj7W/uoOyL9BbeDcstLQq0iQlhdnhktiqSQjvNk6mRS/D+voMfg2xJVu4537
         0IdhfvmNdmpTP9hldn5ACs2f5/7Orj05DvhAEzO1pcJxVlip8IbcEfS0W/7OrACUU3U9
         6mMw/LTd6SPks5SvtKpptw1y9zGmRbrgFWfUnnrRZXdFQhPPcq5W5u75i8qdIUMn/ytB
         URAQ==
X-Gm-Message-State: AOAM533gvGBT8aaPgYEOZhCWf0j1gP6sFoi3UgP379EhSk9al8X9GETJ
        zeSWGLDnmTre1IY9C2O7zGTVAzpSHaObnR4D9KD4mg==
X-Google-Smtp-Source: ABdhPJxZbp3diLrvyq3dgrYuMRWfC3H9RpmazP77wsFU4Fo/hGGzNwxhNiPkwUYI7ddMGxLaJexigKtM+k4YmlmUSmM=
X-Received: by 2002:a05:6e02:1b05:: with SMTP id i5mr38832882ilv.204.1621242329564;
 Mon, 17 May 2021 02:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210517063553.554955-1-pihsun@chromium.org>
In-Reply-To: <20210517063553.554955-1-pihsun@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 May 2021 17:05:18 +0800
Message-ID: <CA+Px+wXePF0Pi1binoZyhZY=9QSX53N-ThWN4mn+fGBoHk1s3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: anx7625: refactor power control to use
 runtime PM framework
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 2:36 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

With some minor comments,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

> @@ -1228,22 +1173,25 @@ static void anx7625_work_func(struct work_struct *work)
>                                                 struct anx7625_data, work);
>
>         mutex_lock(&ctx->lock);
> +
> +       if (pm_runtime_suspended(&ctx->client->dev))
> +               goto unlock;
> +
>         event = anx7625_hpd_change_detect(ctx);
> -       mutex_unlock(&ctx->lock);
>         if (event < 0)
> -               return;
> +               goto unlock;
>
>         if (ctx->bridge_attached)
>                 drm_helper_hpd_irq_event(ctx->bridge.dev);
> +
> +unlock:
> +       mutex_unlock(&ctx->lock);
>  }

Reminder: the lock now also protects the invoke of drm_helper_hpd_irq_event().

> +static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +
> +       mutex_lock(&ctx->lock);
> +
> +       anx7625_stop_dp_work(ctx);
> +       anx7625_power_standby(ctx);
> +
> +       mutex_unlock(&ctx->lock);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +
> +       mutex_lock(&ctx->lock);
> +
> +       anx7625_power_on_init(ctx);
> +       anx7625_hpd_polling(ctx);
> +
> +       mutex_unlock(&ctx->lock);
> +
> +       return 0;
> +}

Maybe in another patch: the ctx->lock looks to protect too much code.
