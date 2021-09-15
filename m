Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65440BC99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhIOA2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhIOA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:28:35 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:27:15 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so1132710otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SN0wr5T1oWZLC7OMWguWNpqj/fohCLowDltatcxEkTU=;
        b=WU2MQDEx3s01BJ/oFkDjBDj3qHQaODxp2KcwWPiuvwombsGYhFWuve+QFXzcGFds/f
         sw73fsScUZMGy0tTG7dpICNgv4/4wW4doJif8CKWZmum/kUKqgD0tDIVtvKZcehHc0si
         +q5/fIPImhHMcjbsb20iwZQ0ADyrlbI+trFYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SN0wr5T1oWZLC7OMWguWNpqj/fohCLowDltatcxEkTU=;
        b=GmL5DHcsRA+KyAhXGII9rfTZSpkSGiWLNk2d3wUaNd7NGSTg7HKrXUACn1tWJXErnf
         tAYOVBBqyqVoaiun3VeWKwyz+716pBgHEYyKC2UZNB6A3FoPsdJpjuF/CegwwL3YPrAH
         ry2Y5hM97mRuMvYaph8ogMuxHSr2wVmpwX3lGKsgTPg7DJxzHvoeDKWJt9eb9ZtcYBQq
         SPeYx+atLQccPseY80ngzUSaG0crrysn54c/BToTgTb6AK6Qg5F3PRqwxDzS9GkUkmyH
         9hiwUiKERqPjGLgm73BDvqG4MxjRs/5JPxJRP4vUgubpenTyqDhCJncJ2sqe4cu2dndU
         cvpQ==
X-Gm-Message-State: AOAM533q58kSHwIwY9tQvivjs+KEf0rttNc2117ddmXUOvQic5jruV/4
        hTS0skB/ma9me54aEq2h4wWL6OmeV7f+BujdjsNFsRTAOYk=
X-Google-Smtp-Source: ABdhPJwtktFIoB9nUZS0Hg0Bb5h5EonNfMac+l6E13vcItJOtaUG+LTRZnmA0YaSfB86wdXxhSuslbX9Gr4eLmSQoVc=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr16496618otp.159.1631665634859;
 Tue, 14 Sep 2021 17:27:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 17:27:14 -0700
MIME-Version: 1.0
In-Reply-To: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 17:27:14 -0700
Message-ID: <CAE-0n53izRN8trQ0b4mpO-W_A7sOXqSF=NNjtFsPcaCBGMpr4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/bridge: parade-ps8640: Improve logging at probing
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-14 16:28:43)
> Use dev_err_probe() to add logs for error cases at probing time.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>

Can you use a cover-letter for more than one patch series?

> (no changes since v1)
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 685e9c38b2db..e340af381e05 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -332,8 +332,10 @@ static int ps8640_probe(struct i2c_client *client)
>                 return -ENODEV;
>
>         ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> -       if (IS_ERR(ps_bridge->panel_bridge))
> -               return PTR_ERR(ps_bridge->panel_bridge);
> +       if (IS_ERR(ps_bridge->panel_bridge)) {
> +               return dev_err_probe(dev, PTR_ERR(ps_bridge->panel_bridge),
> +                                    "Error creating bridge device\n");

From what I can tell it never returns -EPROBE_DEFER? So this isn't
useful.

> +       }
>
>         ps_bridge->supplies[0].supply = "vdd33";
>         ps_bridge->supplies[1].supply = "vdd12";
> @@ -344,16 +346,20 @@ static int ps8640_probe(struct i2c_client *client)
>
>         ps_bridge->gpio_powerdown = devm_gpiod_get(&client->dev, "powerdown",
>                                                    GPIOD_OUT_HIGH);
> -       if (IS_ERR(ps_bridge->gpio_powerdown))
> -               return PTR_ERR(ps_bridge->gpio_powerdown);
> +       if (IS_ERR(ps_bridge->gpio_powerdown)) {
> +               return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_powerdown),
> +                                    "Error getting gpio_powerdown\n");

This looks ok, except we don't want braces on single statement ifs.

> +       }
>
>         /*
>          * Assert the reset to avoid the bridge being initialized prematurely
>          */
>         ps_bridge->gpio_reset = devm_gpiod_get(&client->dev, "reset",
>                                                GPIOD_OUT_HIGH);
> -       if (IS_ERR(ps_bridge->gpio_reset))
> -               return PTR_ERR(ps_bridge->gpio_reset);
> +       if (IS_ERR(ps_bridge->gpio_reset)) {
> +               return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_reset),
> +                                    "Error getting gpio_reset\n");

Same.

> +       }
>
>         ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
>         ps_bridge->bridge.of_node = dev->of_node;
