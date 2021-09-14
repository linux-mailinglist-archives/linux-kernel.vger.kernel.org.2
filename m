Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2640BC32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhINXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:32:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:31:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c206so1665500ybb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpDB93KqvDEqQtSqDaHrb/DKtjXderwhU/tuU7IyXMU=;
        b=Iia1fqQf7kx/cXwep5yrFCmvdXJpdRGSScxXXn8HeUXlksCgc4RocQKjjC7rlNhhy+
         qheQ+j26SkXBEhyRfQ52xGK6Haaw6cFxogi1jktOWIZx3LVS3dg76EM1LcBRNHGOrm2p
         bsRUZ31h+/w12HzERiHhXsBTyKgBGyEaTf1tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpDB93KqvDEqQtSqDaHrb/DKtjXderwhU/tuU7IyXMU=;
        b=UOZuXrkJPqAr0wevDiUdwH9ruh5iBueiVEO85U2x5wrdSE6Ob7SMBFC5accDY4pZvp
         y4oTeUNnR29WZu36EONmoacLT+YemCooDuKHorckMrP5iOX1EKi6+EL/HiBpsjn1akIC
         S3stWA7wQTg+UmRYMGAjfUcscCf8kinZojUIRXzCmW7vQPKB1lmyi45in2x4ncgxVBM5
         /dSVezin5EYOMRbzHiZZJG+1Dl/VbZEULQP/6GqIgNUpk0PUw8zwDaNUyj7uBQlqJ8CK
         Al/o9rbNVEifbAOamIYFHthtQhUSb3ujgEwXXv8mrvYLwNzX6qb4dAlyXTngTqq/NBsU
         qKzQ==
X-Gm-Message-State: AOAM532ysfY5exj5BBGCmiuoznNrUe8PJnEIpwwrMIOkFQsiyiDkLJBA
        U4P+OoJVmEaDDl86t/fXGUz5HvD2sEqi7h1oLXu0Sw==
X-Google-Smtp-Source: ABdhPJykzvphEHWYs668CaEvAbPwEgaFlzvYG712Rj1vvJ9Kk4Pcg6LhA1KZ1bfJkFoUv+Wd/ltyeBVeuCDoKWCG+SY=
X-Received: by 2002:a25:478b:: with SMTP id u133mr2174458yba.532.1631662295531;
 Tue, 14 Sep 2021 16:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210913143255.RFC.v2.1.I8ad7a535bb18a1f41f3858f83379beedb397a9db@changeid>
 <CAD=FV=XDn3XWt5USOmkhikYMUqY1gt7MQfOQhu7v+soy=u3_0g@mail.gmail.com>
In-Reply-To: <CAD=FV=XDn3XWt5USOmkhikYMUqY1gt7MQfOQhu7v+soy=u3_0g@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 14 Sep 2021 16:31:24 -0700
Message-ID: <CA+cxXh=MHDBS-1+PGGpKOJF-mWeXQBy8YA+c+uKRZTm3tbu9bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

Hi, Doug

Thanks for the review.
I fixed the nits you pointed out in v3.
PTAL.

On Mon, Sep 13, 2021 at 5:32 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Sep 13, 2021 at 2:33 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 685e9c38b2db..1b2414601538 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of_graph.h>
> > +#include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >
> >  #include <drm/drm_bridge.h>
> > @@ -31,6 +32,11 @@
> >
> >  #define NUM_MIPI_LANES         4
> >
> > +#define COMMON_PS8640_REGMAP_CONFIG \
> > +       .reg_bits = 8, \
> > +       .val_bits = 8, \
> > +       .cache_type = REGCACHE_NONE
>
> At some point we should see if we get any speed gains by actually
> caching, but that could be done later and isn't terribly high
> priority.
>
>
> > +
> >  /*
> >   * PS8640 uses multiple addresses:
> >   * page[0]: for DP control
> > @@ -64,12 +70,48 @@ struct ps8640 {
> >         struct drm_bridge *panel_bridge;
> >         struct mipi_dsi_device *dsi;
> >         struct i2c_client *page[MAX_DEVS];
> > +       struct regmap   *regmap[MAX_DEVS];
> >         struct regulator_bulk_data supplies[2];
> >         struct gpio_desc *gpio_reset;
> >         struct gpio_desc *gpio_powerdown;
> >         bool powered;
> >  };
> >
> > +static const struct regmap_config ps8640_regmap_config[] = {
> > +       [PAGE0_DP_CNTL] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xbf
> > +       },
> > +       [PAGE1_VDO_BDG] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       },
> > +       [PAGE2_TOP_CNTL] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       },
> > +       [PAGE3_DSI_CNTL1] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       },
> > +       [PAGE4_MIPI_PHY] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       },
> > +       [PAGE5_VPLL] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0x7f
> > +       },
> > +       [PAGE6_DSI_CNTL2] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       },
> > +       [PAGE7_SPI_CNTL] = {
> > +               COMMON_PS8640_REGMAP_CONFIG,
> > +               .max_register = 0xff
> > +       }
>
> nit: stylistically it's nice to add a "," after the last brace too.
> It's not technically needed but it makes diffs cleaner if another
> config is later added.
>
>
> > @@ -362,6 +390,10 @@ static int ps8640_probe(struct i2c_client *client)
> >
> >         ps_bridge->page[PAGE0_DP_CNTL] = client;
> >
> > +       ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> > +       if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]))
> > +               return PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]);
>
> I'm a huge fan of dev_err_probe(). I wonder if it makes sense to use
> it here? Untested:
>
> if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]))
>   return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
>                        "Error initting page 0 regmap\n");
>
>
> All of that is just nits, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
