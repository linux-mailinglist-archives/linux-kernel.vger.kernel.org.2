Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2078B4331A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhJSI5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhJSI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:57:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:55:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2101522pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfQpC7UQZpNqq1v0sLumWlo6NVzWJwEiwTHkqYg5h6A=;
        b=qDxz+misihGXlTA/r4pgSx5eCNWOMbtLHVRQQrxN6vBMhWa5g4a+oG6bivI5nm2mq1
         +nhWGUQM1E1mI3u6T/lsqhQO/MMB9iqvHPLz6UFsXK+gjiCRwA3/8Xz43VDFB1kKvxo4
         wIlF0Mop9np+pX0NkE2GBJGM2f0oPo48wkPgc5la+LtT8qUKlMTFqXsF/TDq2MfVt2f5
         cj81YfZ39cVUbVv+lSJCzuHWQcpkgGfoYfQKG2ln+6/bBHdzQYWID62+rzIiZKS9PyVj
         cTmEVqjy42Iz2FXw3CXdoBONf3EygmpT2FIuq7XV2nqOxQw6Z3VFMI76sUCeUaAB/c/r
         0OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfQpC7UQZpNqq1v0sLumWlo6NVzWJwEiwTHkqYg5h6A=;
        b=oosEMyn0yamwPFAAYrb31oNM0KCgBw+q0g3nQuLv+ox9ll/l6aseJ28JTYkVMiaSIL
         wty7v43fDCW586df2DAg8xYvt+TOcJAnvfgk7rE4Kzy5ask9y5TqgQ8t+3tn1DbCGZWf
         bIH0UHghdlI1h2Q4qQA1h+Td4MC3iin1t16GDWxuRAueRsO/G6YUGQInwD9JDrgvWcay
         YEC8w64oA1MjsRcYXeDEdbKeMWYPHWp89dl5Yhxmyg1CAeNcCS+0WSK3PjPRVRTJ+NuY
         LizFfDtzHF4mKGE0aH1sK+qxQ9eBrqf6nX5UhypA60/d6aAcGCtzYIjhBuT5vYP1h+yi
         vApg==
X-Gm-Message-State: AOAM530NyBYU4pyfc/Qq/Z0L/7e8v2JtfVaADSzOMTjH4TNKm6/RWVFb
        mMRxoEXYS9Ej7waPRdNTiFbp1MvDhW0fwpr/j3meBg==
X-Google-Smtp-Source: ABdhPJxsEa+yroDAhbHQrtQv2/06arqDDWoEpu77sno3nW/g9Vma85iKgTgN8MsdXKAY4s0Z2WIfTrOMJjqvUepGKS0=
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr5042549pjb.232.1634633723777;
 Tue, 19 Oct 2021 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211002233447.1105-1-digetx@gmail.com> <20211002233447.1105-3-digetx@gmail.com>
In-Reply-To: <20211002233447.1105-3-digetx@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Oct 2021 10:55:12 +0200
Message-ID: <CAG3jFyvtSU9ijnL7BwGEg09dgotT1H9Ox3A=Oi1GAAB1+SfoQg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] drm/bridge: tc358768: Support pulse mode
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Support pulse-mode synchronization which is supported and used by simple
> DSI panels like Panasonic VVX10F004B00.
>
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # Asus TF700T
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> #TF700T
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 66 ++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 18ae6605a803..10ebd0621ad3 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -785,24 +785,54 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>         /* START[0] */
>         tc358768_write(priv, TC358768_STARTCNTRL, 1);
>
> -       /* Set event mode */
> -       tc358768_write(priv, TC358768_DSI_EVENT, 1);
> -
> -       /* vsw (+ vbp) */
> -       tc358768_write(priv, TC358768_DSI_VSW,
> -                      mode->vtotal - mode->vsync_start);
> -       /* vbp (not used in event mode) */
> -       tc358768_write(priv, TC358768_DSI_VBPR, 0);
> -       /* vact */
> -       tc358768_write(priv, TC358768_DSI_VACT, mode->vdisplay);
> -
> -       /* (hsw + hbp) * byteclk * ndl / pclk */
> -       val = (u32)div_u64((mode->htotal - mode->hsync_start) *
> -                          ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
> -                          mode->clock * 1000);
> -       tc358768_write(priv, TC358768_DSI_HSW, val);
> -       /* hbp (not used in event mode) */
> -       tc358768_write(priv, TC358768_DSI_HBPR, 0);
> +       if (dsi_dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
> +               /* Set pulse mode */
> +               tc358768_write(priv, TC358768_DSI_EVENT, 0);
> +
> +               /* vact */
> +               tc358768_write(priv, TC358768_DSI_VACT, mode->vdisplay);
> +
> +               /* vsw */
> +               tc358768_write(priv, TC358768_DSI_VSW,
> +                              mode->vsync_end - mode->vsync_start);
> +               /* vbp */
> +               tc358768_write(priv, TC358768_DSI_VBPR,
> +                              mode->vtotal - mode->vsync_end);
> +
> +               /* hsw * byteclk * ndl / pclk */
> +               val = (u32)div_u64((mode->hsync_end - mode->hsync_start) *
> +                                  ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
> +                                  mode->clock * 1000);
> +               tc358768_write(priv, TC358768_DSI_HSW, val);
> +
> +               /* hbp * byteclk * ndl / pclk */
> +               val = (u32)div_u64((mode->htotal - mode->hsync_end) *
> +                                  ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
> +                                  mode->clock * 1000);
> +               tc358768_write(priv, TC358768_DSI_HBPR, val);
> +       } else {
> +               /* Set event mode */
> +               tc358768_write(priv, TC358768_DSI_EVENT, 1);
> +
> +               /* vact */
> +               tc358768_write(priv, TC358768_DSI_VACT, mode->vdisplay);
> +
> +               /* vsw (+ vbp) */
> +               tc358768_write(priv, TC358768_DSI_VSW,
> +                              mode->vtotal - mode->vsync_start);
> +               /* vbp (not used in event mode) */
> +               tc358768_write(priv, TC358768_DSI_VBPR, 0);
> +
> +               /* (hsw + hbp) * byteclk * ndl / pclk */
> +               val = (u32)div_u64((mode->htotal - mode->hsync_start) *
> +                                  ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
> +                                  mode->clock * 1000);
> +               tc358768_write(priv, TC358768_DSI_HSW, val);
> +
> +               /* hbp (not used in event mode) */
> +               tc358768_write(priv, TC358768_DSI_HBPR, 0);
> +       }
> +
>         /* hact (bytes) */
>         tc358768_write(priv, TC358768_DSI_HACT, hact);
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
