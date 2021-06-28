Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D13B5CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhF1LNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhF1LND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:13:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D853EC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:10:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c11so25095315ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWqtZ2im8bhpe7wgbjV8zsEbbfLVDc0iR3ke9Y3lfWw=;
        b=GWKNCASd9MPmyxEUsoGR9JzIVqWCjK0OSZF1l1oCdifzvEDMqh0KUYe3MV8Dgbr+PA
         la9gyUtlwDg0n3+3jlE9gokVLM6wdEqMHpYm1GUNKILSnuRdU+RgBU7sRxOUjljpyx1u
         zKT2T7iMjOJzomPtHeovnBESXt8hdlSg1o9l9GDzfxR/6G/S3tgN1K7+yyCGozJ1EgyI
         9PvkiqVsL1bXqLvS7gQ+U/3JwHmPIo1Hy4i7AHzDiPuPyOEXwm7HJstY+KYKcy+at9Yg
         H1VQ4aM1iq7p8brNaOJS61SqZPEocFRr1bHCErosV2zAZJTQ2DzKJf/Yr1Gt16mOzVxo
         1abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWqtZ2im8bhpe7wgbjV8zsEbbfLVDc0iR3ke9Y3lfWw=;
        b=okop+lf8i570SV/O6ymkYTpWBdM0GFWUI62k3UCmOrbeCUTqULLcAbYAxLghGM62mp
         kKudIJABhqLdOmiadfh73bCz3IL9sbanhksMZTtOcE+EkLrG90q/R/a7an7BR3fwMe44
         PXkxHFVGvrFg8rOsWJleFvOXOmlHK6Cgxiu8+v0qAoc049JQ4lABGH836YlWKs8o40ju
         CeAex0r1VYUYp5nhmB80SLzmL4Hgr6TgSc0+HBY6HL8e6Ql48lyJgCd0V2GsNynMpq2n
         ncNDzAjYoscTuWhAPypNt2uFZ6I5MyGyLStul6ypr0OArz9/bdjjcjHfzKlfw2kCZEuQ
         dMSw==
X-Gm-Message-State: AOAM533jq0OSO1hZDBNId8ftXiJpqQ6thnHgNiMCJWp+Wgdt21qYHY2G
        IMHSFNz99nJ7M65/aBcDj4c/oOm/aVKuWkBK0DC4lw==
X-Google-Smtp-Source: ABdhPJzyEQpk+qVTQTN61ga94Up2dG17/tdSZ8ryGBxDStAhbzvUPZemkx4xWP9DPdoHPznWcXaHK8zDx3IUoLZtJDU=
X-Received: by 2002:a2e:9483:: with SMTP id c3mr19694556ljh.273.1624878635125;
 Mon, 28 Jun 2021 04:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210211113309.1.I629b2366a6591410359c7fcf6d385b474b705ca2@changeid>
 <CACRpkdbQa3BZwgtp3=061cu+y+4qkMqtXQhXH_VuHB3KcLyDCA@mail.gmail.com> <CANMq1KAsvXZAjmYCMQsAUwpkzuA9-PRnNWkpsLuNbOkP6DixGA@mail.gmail.com>
In-Reply-To: <CANMq1KAsvXZAjmYCMQsAUwpkzuA9-PRnNWkpsLuNbOkP6DixGA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jun 2021 13:10:23 +0200
Message-ID: <CACRpkdYK3nw890YFNxgtrwDvxcoeNVu7MxqUw94NN_6PiYxkJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dsi: Add _NO_ to MIPI_DSI_* flags disabling features
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Ji <xji@analogixsemi.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 11:31 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> On Mon, Mar 1, 2021 at 4:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > >                 dsi->mode_flags =
> > >                         MIPI_DSI_CLOCK_NON_CONTINUOUS |
> > > -                       MIPI_DSI_MODE_EOT_PACKET;
> > > +                       MIPI_DSI_MODE_NO_EOT_PACKET;
> >
> > Same, just delete the flag.
> >
> > These are all just semantic bugs due to the ambiguity of the flags, it is
> > possible to provide a Fixes: flag for each file using this flag the wrong way
> > but I dunno if it's worth it.
>
> Wow nice catch.
>
> I think we should fix all of those _before_ my patch is applied, with
> proper Fixes tags so that this can be backported to stable branches,
> even if it's a no-op. I can look into it but that may take a bit of
> time.

This is fixed now, please will you proceed with this patch, because I
really like it!

Yours,
Linus Walleij
