Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65F540BDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhIOCSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhIOCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:18:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36EC0613A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:17:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l10so1269175ilh.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9q2xLJ1hwg8ZonS652P1/WWF9+E7349Lf8vX2F81hA=;
        b=aBiLRw4HynCYfAhxL7il0axQugRkZZwmT0cOn2zJAoW7y7IH/zmLn+JuAiHqfDJJSw
         V/UvG9H6mE3qFO4FG5pZXojyrrfwppyilJ9dS61IU/MuI2nWyp4hIvcRIQrH4+4Vb4AM
         X6O0mnVwjUMSzxLU9jGH53TgmHpBGrf2iv97g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9q2xLJ1hwg8ZonS652P1/WWF9+E7349Lf8vX2F81hA=;
        b=EtnhzQhgBlozn4qt86nU5vDNuU6Vys7m6BhTzjhwoMdrMEkSAHQdqd3Oww7iSYsbH7
         Vy2JfFiACDj+UOtW4f05BIyQD/ktfu68X/E3HF4lkx7rLu1yKHi/7V/og9X8J01GqXoq
         yISMW4/nq8WbOb2U9CMSfS5NDKDCBL0IlPOUD7Vu5C8Xl8JhGUG96+di3c4P7dZlbmAv
         cuDDLmzo9x4Et64b9Drgwr4oUZ0r0cmemjkfz/pWisX9Oc87Be93qVBkrsT+dOAtExnj
         csgVGXO2S7B/ckJ5yxH2ymwdErMpmcs3ShH+lmzVy5Tz7UK5hVcSiw9OpMdRhI+JhK1N
         YPNw==
X-Gm-Message-State: AOAM530DJ4lS6Lr0NGSXgftytGu7RJGv9MiDPUkWWABbY4/8w1jYNwxl
        tXqa77szf/IGoE41tWyYrH4krrEUYo+BJg==
X-Google-Smtp-Source: ABdhPJxi4C/V5Q7L3RAK9u8EyrW4+F+AnIOsWP5XzWwY2MPkM2/zJcC9k/NO2WNa0YtpPXqbEYgWNg==
X-Received: by 2002:a92:cb87:: with SMTP id z7mr15235440ilo.315.1631672235977;
        Tue, 14 Sep 2021 19:17:15 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id g13sm8027587ile.68.2021.09.14.19.17.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:17:15 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id h9so1278728ile.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:17:15 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr2164174ilv.180.1631672234933;
 Tue, 14 Sep 2021 19:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid> <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
In-Reply-To: <CAE-0n53BXh3_6jEW5oTbPA-V=MSaN=RvqaU8uoY9GNOm-0Pv_g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Sep 2021 19:17:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKQg-fU1jaSOh3RTa5HpSAiTzt2-Sycwt59uv1WemYxg@mail.gmail.com>
Message-ID: <CAD=FV=WKQg-fU1jaSOh3RTa5HpSAiTzt2-Sycwt59uv1WemYxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: parade-ps8640: Use regmap APIs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
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

Hi,

On Tue, Sep 14, 2021 at 5:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-14 16:28:44)
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index e340af381e05..8d3e7a147170 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -368,6 +396,12 @@ static int ps8640_probe(struct i2c_client *client)
> >
> >         ps_bridge->page[PAGE0_DP_CNTL] = client;
> >
> > +       ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> > +       if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL])) {
> > +               return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
> > +                                    "Error initting page 0 regmap\n");
>
> This one also doesn't return -EPROBE_DEFER? The dev_err_probe() should
> really only be used on "get" style APIs that can defer.

Any reason why you say that dev_err_probe() should only be used on
"get" style APIs that can defer? Even if an API can't return
-EPROBE_DEFER, using dev_err_probe() still (IMO) makes the code
cleaner and should be used for any error cases like this during probe.
Why?

* It shows the error code in a standard way for you.
* It returns the error code you passed it so you can make your error
return "one line" instead of 2.

Is there some bad thing about dev_err_probe() that makes it
problematic to use? If not then the above advantages should be a net
win, right?

-Doug
