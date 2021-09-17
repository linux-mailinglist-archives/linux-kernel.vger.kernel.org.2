Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346FB410176
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbhIQWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhIQWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:45:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:43:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a10so22246281qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIoW8Eo23iCAjrIU1t3sDARsiqnFEdwPmtswt/NLCf8=;
        b=El06bwReyDXr1NHoxdC01WQI6pe3wgojrolXAjDrvnu/ORtYUsGMjxjaSBHwNkpljb
         FEYRmdvdGYeu0yzMnLrfr49g9ZOOn8vf2oZoLBeL6UTcOp36nZhyOOv5Nq5b0YOx0+dx
         TXM9hR25fEqA7v2fHtW5JGpJY02bmU6tsMBm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIoW8Eo23iCAjrIU1t3sDARsiqnFEdwPmtswt/NLCf8=;
        b=BdglklI3mhc/KILmtrMjTptGWqlKEzAq5xyfQ08SxvfQ/7Ww4cAjrHOLTVVr1kcZ7X
         Fc9NHV6a5XpWZb4KQ/lnWOoD1PeAoQVb1DE5nSv6zTK3qbXRz5oWtbvPcHTFaPr3W3lg
         n7YZly57KdQa7puIhHamqVCcWJvonRJW1EPUOvFXPDQ0Kzs/pVUCv+pe3KQtFCdrE7Vp
         UcGyCeSDdccLbF0UZ7B1Epb40drvbT2SbzNB/h1q8PVbhNiRfyRjV9RiddlSkaWDPzbo
         x3mOH1SOPkO+23skD4FCKKqOh7ImjMaF/8DQAJ2Q87dkt6fP2TIZPJ9sgk7WUU6hMpm0
         j2Iw==
X-Gm-Message-State: AOAM5335/XTf5nGPi3pMEmpzNLjCkXyWgJ27YC/FOrlaU5gx6L7JgBK/
        PKVVTWkqAQ4rDBD5LttgHW5HBvx0I+hZz+jMs0Lsuw==
X-Google-Smtp-Source: ABdhPJz/TKx1KZSwZkp9yjChC8gNexd7paTPcbuLuA7GZ0wA6JoA2nGJYOqtatUMuAtiYO8/f/4SwAhZUD6J/xhssXg=
X-Received: by 2002:a25:6a55:: with SMTP id f82mr16647861ybc.217.1631918622623;
 Fri, 17 Sep 2021 15:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <CAE-0n53izRN8trQ0b4mpO-W_A7sOXqSF=NNjtFsPcaCBGMpr4Q@mail.gmail.com>
In-Reply-To: <CAE-0n53izRN8trQ0b4mpO-W_A7sOXqSF=NNjtFsPcaCBGMpr4Q@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Fri, 17 Sep 2021 15:43:31 -0700
Message-ID: <CA+cxXhmyXmt2VRPTM_d0CBG6P=OZYJLofsTEa__xsZ0SQ+W1eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/bridge: parade-ps8640: Improve logging at probing
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Based on the discussion in [1], this patch is not really needed for now.
So I'll just remove this patch from v4.
Thanks.

[1] https://patchwork.kernel.org/project/dri-devel/patch/20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid/

On Tue, Sep 14, 2021 at 5:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-14 16:28:43)
> > Use dev_err_probe() to add logs for error cases at probing time.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
>
> Can you use a cover-letter for more than one patch series?
>
> > (no changes since v1)
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 685e9c38b2db..e340af381e05 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -332,8 +332,10 @@ static int ps8640_probe(struct i2c_client *client)
> >                 return -ENODEV;
> >
> >         ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> > -       if (IS_ERR(ps_bridge->panel_bridge))
> > -               return PTR_ERR(ps_bridge->panel_bridge);
> > +       if (IS_ERR(ps_bridge->panel_bridge)) {
> > +               return dev_err_probe(dev, PTR_ERR(ps_bridge->panel_bridge),
> > +                                    "Error creating bridge device\n");
>
> From what I can tell it never returns -EPROBE_DEFER? So this isn't
> useful.
>
> > +       }
> >
> >         ps_bridge->supplies[0].supply = "vdd33";
> >         ps_bridge->supplies[1].supply = "vdd12";
> > @@ -344,16 +346,20 @@ static int ps8640_probe(struct i2c_client *client)
> >
> >         ps_bridge->gpio_powerdown = devm_gpiod_get(&client->dev, "powerdown",
> >                                                    GPIOD_OUT_HIGH);
> > -       if (IS_ERR(ps_bridge->gpio_powerdown))
> > -               return PTR_ERR(ps_bridge->gpio_powerdown);
> > +       if (IS_ERR(ps_bridge->gpio_powerdown)) {
> > +               return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_powerdown),
> > +                                    "Error getting gpio_powerdown\n");
>
> This looks ok, except we don't want braces on single statement ifs.
>
> > +       }
> >
> >         /*
> >          * Assert the reset to avoid the bridge being initialized prematurely
> >          */
> >         ps_bridge->gpio_reset = devm_gpiod_get(&client->dev, "reset",
> >                                                GPIOD_OUT_HIGH);
> > -       if (IS_ERR(ps_bridge->gpio_reset))
> > -               return PTR_ERR(ps_bridge->gpio_reset);
> > +       if (IS_ERR(ps_bridge->gpio_reset)) {
> > +               return dev_err_probe(dev, PTR_ERR(ps_bridge->gpio_reset),
> > +                                    "Error getting gpio_reset\n");
>
> Same.
>
> > +       }
> >
> >         ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
> >         ps_bridge->bridge.of_node = dev->of_node;
