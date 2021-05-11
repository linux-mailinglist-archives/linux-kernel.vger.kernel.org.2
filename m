Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9E379E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEKEfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKEfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:35:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:34:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j20so16037874ilo.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4tpZentr0TR2+FXTu3cAIgvwuk8SCd5AACOcGsFclc=;
        b=bG2CP+eF8OkjQT3EabsJgsO+73FTRrGWVbWePSQEyPiCfhCMqDrNIsf8IlatXcwIxQ
         zKGRkGZffuLgiROFw15VfNpKCNxsszcOMz+wxPgK3NaJOyQsfkzdFHkifcFrshkW4psZ
         zsTmYDUhLk7v4sGXObhL+8wTZ6GnlKXSWFbzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4tpZentr0TR2+FXTu3cAIgvwuk8SCd5AACOcGsFclc=;
        b=CZt4KPUtqq8Q08jsT0i42MdrX/y1ZX7jufaNUc+AptOqGT0d4AsXDXTHEQgUjj+hwv
         cg/+lWhKmul4rhLBA2DryHozPQd0IN2T8dOLamR5fIPI3a7yeMIq9ljZUI8ixrjOr+9X
         qA+9Zd8k+fQMDZzS8++AIkPcQDuVaZ70VeD7G7IEpAw5s2FpAylklMO7HhPY0CshhkaF
         Aatx36tosq8Ya0aqHkdubsVm958+JQHKz1XHf2CL7cFzbUzO4J4YwOy1SLuDtUs+N/uZ
         FiNO21edHmztW9L/j61PA8SynuwzWWi3Yii2qUw/jNbxSO4VWOZ+KEsCum9cfZowBldl
         iLaw==
X-Gm-Message-State: AOAM532zBtGNsVmHbLp31PrbbczY9ueAxgwjFpuQmM1er31yUEiptFan
        uZJaBj5ndBtaLIa2fVb0wFrIpi7SWiGeGw3h5kiUCPL7aOQldQ==
X-Google-Smtp-Source: ABdhPJzFflNdpVJDf+0TIvFgpzzopa1uxa/OtJjcqRcc+rKSCn9UlaFhW0oFRTdjhXoBDVY9BBfp5kygW6IDQzpOHmI=
X-Received: by 2002:a92:cd52:: with SMTP id v18mr24668263ilq.308.1620707675024;
 Mon, 10 May 2021 21:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210510053125.1595659-1-pihsun@chromium.org> <20210510053125.1595659-2-pihsun@chromium.org>
In-Reply-To: <20210510053125.1595659-2-pihsun@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 11 May 2021 12:34:09 +0800
Message-ID: <CAJMQK-jYb_0+AA_bBrvkJ4JaT1mQTr6uGZQbbpnyA1CJ_NLKuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: anx7625: add suspend / resume hooks
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 1:31 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Add suspend / resume hooks for anx7625 driver, that power off the device
> on suspend and power on the device on resume if it was previously
> powered.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested on a mt8183 juniper device.

> ---
>
> Changes from v2:
> * No change.
>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index e1bf31eafe22..b165ef71e00f 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1705,7 +1705,34 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
>         return 0;
>  }
>
> +static int __maybe_unused anx7625_resume(struct device *dev)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +
> +       if (!ctx->pdata.intp_irq)
> +               return 0;
> +
> +       if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev))
> +               anx7625_runtime_pm_resume(dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused anx7625_suspend(struct device *dev)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +
> +       if (!ctx->pdata.intp_irq)
> +               return 0;
> +
> +       if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev))
> +               anx7625_runtime_pm_suspend(dev);
> +
> +       return 0;
> +}
> +
>  static const struct dev_pm_ops anx7625_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
>         SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
>                            anx7625_runtime_pm_resume, NULL)
>  };
> --
> 2.31.1.607.g51e8a6a459-goog
>
