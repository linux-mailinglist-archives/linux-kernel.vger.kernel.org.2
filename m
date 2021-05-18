Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253103879F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349597AbhERNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbhERNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:30:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C87C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:29:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s4so3523274plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9uUXCGM1WRSLZSKiMJRcVlxa7yFZ11QeqDeoqK0ih0=;
        b=VkJlo6aDzmgedwuPJlD6/sR6xRtHX9hlA6a/sT70kxM2CZtzJyB8E/1f/uuQQL72jM
         RgSd6CTnJ2B8mkWBWA7T0biB/qWptdVWJ9CR01MoM8wSemX4pQcuioxOoGD8iMwxSqVl
         XQ+vV6CHG6cLAKBc+U65HZA+xTQ50ElmVQg9XEpUUFRoAx/RBNP8hb8+iQcsNgRNVq+O
         1C3RmUqfsqY3k3SB4L/KTblMT6dkmnA3dGlpLD0OyZ9iqFadqbftsKmdSguz3nBHpHTP
         1xWuNf7DlOd8Pt6G6kasTA8SpWbuGGeOJpGdag8TzGjNPizBOaQxbraSgTAundfiJsDM
         4Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9uUXCGM1WRSLZSKiMJRcVlxa7yFZ11QeqDeoqK0ih0=;
        b=ru5WPdJh/v9oXSiZN6YN8GMi+QT9FMYww64CF0JSiWGktTxf3v4P39z4THjvZd5DHb
         CEAYruIbN3R/Ylm0u3u6PclURhv/ENLhssPlZvFemOv4SjNPZu2qkVKGNIPLldHwSJ5h
         Xg3s40IVWeTSsenRSxf+x0czSuqOEjm5ChTP6whpGCLlb3bUjo+J1aaTBfdpUaeTvt2Q
         KLzWn+HXr+2X6BjQ4Bn3AqXWyqhIBml/e4F7Z00NryMwL0HSD9h4mwKG9lH4Ry4KP6++
         wU9fejzIVFPCTsCahTCJYhpB5VBnC5YZTgdZGSuRqoZV4QhKP7TpmXugHwHDUfC0dcR0
         bLGg==
X-Gm-Message-State: AOAM532tg1QmVQGmzMBh9/dyeXzZwB+6qjOZ+aUbag846m8Ozjk0grxb
        FBX1RHMwH/VOAeu4BuSqKcJQhrGSdeIyBbuT9sVWNA==
X-Google-Smtp-Source: ABdhPJyiRloyNEJhG1wQmfsOk1IFKsu7S1Qi/FL145KCqHGpn79hzewNqDX8wpkVthQLJYRuP/xASf05ED/bn9leiOU=
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id
 4-20020a1709020004b02900ee8f40ecbfmr4596509pla.28.1621344556939; Tue, 18 May
 2021 06:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <YKOGogHasIyvF8nj@mwanda> <CAG3jFytpOb8KeNCjCJ7gq20LQK3UGA9PgGne+cR2kZdADS-Oxg@mail.gmail.com>
In-Reply-To: <CAG3jFytpOb8KeNCjCJ7gq20LQK3UGA9PgGne+cR2kZdADS-Oxg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 18 May 2021 15:29:06 +0200
Message-ID: <CAG3jFytF9KToiQcNZpiVz7T-uAx6gHDcxSnc6MH7d3bqpWWz8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: fix a ternary type promotion bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it fixes drm-misc-next, applied it there instead.

On Tue, 18 May 2021 at 15:20, Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Dan,
>
> Thanks for submitting this.
>
> On Tue, 18 May 2021 at 11:20, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The ti_sn_aux_transfer() function returns ssize_t (signed long).  It's
> > supposed to return negative error codes or the number of bytes
> > transferred.  The "ret" variable is int and the "len" variable is
> > unsigned int.
> >
> > The problem is that with a ternary like this, the negative int is first
> > type promoted to unsigned int to match "len" at this point it is a high
> > positive value.  Then when it is type promoted to ssize_t (s64) it
> > remains a high positive value instead of sign extending and becoming a
> > negative again.
> >
> > Fix this by removing the ternary.
> >
> > Fixes: b137406d9679 ("drm/bridge: ti-sn65dsi86: If refclk, DP AUX can happen w/out pre-enable")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index bb0a0e1c6341..45a2969afb2b 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -1042,7 +1042,9 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
> >         pm_runtime_mark_last_busy(pdata->dev);
> >         pm_runtime_put_autosuspend(pdata->dev);
> >
> > -       return ret ? ret : len;
> > +       if (ret)
> > +               return ret;
> > +       return len;
> >  }
> >
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
>
> Applying to drm-misc-fixes.
