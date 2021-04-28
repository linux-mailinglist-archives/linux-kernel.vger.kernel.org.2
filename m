Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7C36DD28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhD1Qgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbhD1Qgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:36:35 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:35:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id d1so19489399qvy.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//UO2IjJqBIxaWSoAlfPA77HhIEosOhf6+vv78gfMgc=;
        b=Sb32zysRjoegxCScU/eqzs7T0aXi9ZWfG28GsmoYSJM387iS073EN9yXEQDCWId+uZ
         jsqHpX/Whj8LYUthaggplNBubdKnAh9Fxy+1nxIl/Dxe3W1PMsXoZjO4KnmBTLWuRfsq
         n5ht2NKrpOqDV2SXNDLOXW2w8oUlIroGk2FWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//UO2IjJqBIxaWSoAlfPA77HhIEosOhf6+vv78gfMgc=;
        b=nvUVrW8wDFdrYbF4xxr988oFLd2BW7l5OrOilevDchKXoRJ/HKDvxrhi41dEnyMF68
         /HZum0G22qKhuTjWkDkTQNOcnHLHLAza/h+aMLyM9lVJz6j1vRDnSDygJ3duJpM9mHt0
         RgauXTvQq16tRJXtPH0e8CM7BAD11K6kMmtTNxM4f8qREZtnMLwiWYXNpca3jP8KLUMG
         P4uNq3ROhhJgQynKBOJCjofDBB6A87UO9+mXXqZenMWYAC1119EKjMV2Y58RQv11zs1q
         P5w/QYidMXGXciiJG/cLOTZWLL0ns8Q3jtjP/fn5AaIbnJW3A0fZYusywD2PO4fjvW+0
         sEVw==
X-Gm-Message-State: AOAM530lgLPiFZdtWdH1XO1k37S9XJNHbAP1zVvWCu/laaSmMIBKAsen
        5E5t4FC7A4GpSRZi2O1Tl+Nr6x1bseiaMw==
X-Google-Smtp-Source: ABdhPJztOgR8gB/WEK3PFD1PtknP0lZKVVEYpL1ogVe665MNTSUDgaAPdzyesK7rFLJiNeFkIXahhA==
X-Received: by 2002:a0c:f78e:: with SMTP id s14mr29811865qvn.46.1619627748892;
        Wed, 28 Apr 2021 09:35:48 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id o12sm180994qkg.36.2021.04.28.09.35.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:35:48 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id y2so72602206ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:35:47 -0700 (PDT)
X-Received: by 2002:a25:382:: with SMTP id 124mr19716461ybd.25.1619627746944;
 Wed, 28 Apr 2021 09:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org> <20210423095743.v5.10.I40eeedc23459d1e3fc96fa6cdad775d88c6e706c@changeid>
In-Reply-To: <20210423095743.v5.10.I40eeedc23459d1e3fc96fa6cdad775d88c6e706c@changeid>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Wed, 28 Apr 2021 12:35:09 -0400
X-Gmail-Original-Message-ID: <CAOw6vbJj327Y0vtzwm=aOqwyHScE5XYG2LDw6TxCh_N+rCJ9kQ@mail.gmail.com>
Message-ID: <CAOw6vbJj327Y0vtzwm=aOqwyHScE5XYG2LDw6TxCh_N+rCJ9kQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] drm/panel: panel-simple: Get rid of hacky HPD
 chicken-and-egg code
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        robdclark@chromium.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 1:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When I added support for the hpd-gpio to simple-panel in commit
> 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for delaying
> prepare()"), I added a special case to handle a circular dependency I
> was running into on the ti-sn65dsi86 bridge chip. On my board the
> hpd-gpio is actually provided by the bridge chip. That was causing
> some circular dependency problems that I had to work around by getting
> the hpd-gpio late.
>
> I've now reorganized the ti-sn65dsi86 bridge chip driver to be a
> collection of sub-drivers. Now the GPIO part can probe separately and
> that breaks the chain. Let's get rid of the old code to clean things
> up.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/panel/panel-simple.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9746eda6f675..bd208abcbf07 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -366,8 +366,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
>         return 0;
>  }
>
> -static int panel_simple_get_hpd_gpio(struct device *dev,
> -                                    struct panel_simple *p, bool from_probe)
> +static int panel_simple_get_hpd_gpio(struct device *dev, struct panel_simple *p)
>  {
>         int err;
>
> @@ -375,17 +374,10 @@ static int panel_simple_get_hpd_gpio(struct device *dev,
>         if (IS_ERR(p->hpd_gpio)) {
>                 err = PTR_ERR(p->hpd_gpio);
>
> -               /*
> -                * If we're called from probe we won't consider '-EPROBE_DEFER'
> -                * to be an error--we'll leave the error code in "hpd_gpio".
> -                * When we try to use it we'll try again.  This allows for
> -                * circular dependencies where the component providing the
> -                * hpd gpio needs the panel to init before probing.
> -                */
> -               if (err != -EPROBE_DEFER || !from_probe) {
> +               if (err != -EPROBE_DEFER)
>                         dev_err(dev, "failed to get 'hpd' GPIO: %d\n", err);
> -                       return err;
> -               }
> +
> +               return err;
>         }
>
>         return 0;
> @@ -416,12 +408,6 @@ static int panel_simple_prepare_once(struct panel_simple *p)
>                 msleep(delay);
>
>         if (p->hpd_gpio) {
> -               if (IS_ERR(p->hpd_gpio)) {
> -                       err = panel_simple_get_hpd_gpio(dev, p, false);
> -                       if (err)
> -                               goto error;
> -               }
> -
>                 if (p->desc->delay.hpd_absent_delay)
>                         hpd_wait_us = p->desc->delay.hpd_absent_delay * 1000UL;
>                 else
> @@ -682,7 +668,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>
>         panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
>         if (!panel->no_hpd) {
> -               err = panel_simple_get_hpd_gpio(dev, panel, true);
> +               err = panel_simple_get_hpd_gpio(dev, panel);
>                 if (err)
>                         return err;
>         }
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
