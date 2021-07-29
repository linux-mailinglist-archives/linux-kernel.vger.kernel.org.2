Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650483DA271
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhG2Lry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhG2Lrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:47:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B2C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:47:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so8822847pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9GiTJuVI5x4RuGCQ02DAiAFTRDb2BIvA8GMDRJSB6k=;
        b=yv0lO2IkvEcpcHECnb+T9gwzGSAowFwz+9NwBQpZ11PaFdVU/wsxqo5fT/yrr9tE6M
         Ldm2VOpbXRZAp/Ug5rk1DcmYG25epedmzpza6KBBkPIWWIU7cnkhwi5RdfEKtfrk65s1
         GcDIOKGueKx7ADdXFb+B0UfN7q529DbF4mAMud1t5ig4ZT4wFlvvW93uLKfhpMPpuYDE
         +3qoQXZFOEq7/2BkBOo2VE/K4GgooZfWR7x7Q7wbCbqOdGeZ8UTclpJv5e7k8I+pY3do
         pFVHevMO+EsgGnt9SJ+iP6vbjj8fi2gt0ZptRsIVCs1MsTj5s26K9jP2McPJUIYn8Wko
         OsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9GiTJuVI5x4RuGCQ02DAiAFTRDb2BIvA8GMDRJSB6k=;
        b=tjTeMkDG4UF3s3QSrJ9zSobaB3lOsr9B5bwXpvo8lUWXKw/pPNMnLcPLAenvDT2scJ
         L5A2KjICVmwmRBX6ci/7hzkA2aHz0K/Ry/wYLiCCDXOGKHxjsAhRY8gmktYbihsMr/4O
         cRT5Fbd4qVRz1g+BL+716pZ657iaIc0iY8+AY2lPDjl7abYFCJITjGkXJaNvXBoFGnBM
         XhPY2qNbRuco2R9WRB0eW92k4AcRGDmAsSnkkuHIT6gw+GdHbh55Vy0DSmD3d8BW2dTS
         +DPB55Ft0kKG+nrjjwDE3KwXYMYxGX8TU0wpbpI+8zcFhf5gXBnQOKI9S9JbENypyLjQ
         chIQ==
X-Gm-Message-State: AOAM531qx70Q45Cur4C5nVcEHD8W+GnE3lIitOP7JIrAENiXfg9WUmv7
        nn31ZgJIX8rXbaEt4a4VZzP+LYLZh3OlOb4J45Sz4A==
X-Google-Smtp-Source: ABdhPJy0UIG7qmOKUr5AtuyIOSotO04zDKZuTO2snDleiMOIl76CIKdVjCd+V8P1Zk5FWrClXpEgXRn8P4tKqvKvU8w=
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id
 k8-20020aa790c80000b029032c935fde5fmr4738606pfk.79.1627559269461; Thu, 29 Jul
 2021 04:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210728164557.1882787-1-dianders@chromium.org> <20210728094511.2.If8a8ec3bf1855cf0dbb62c005a71d6698c99c125@changeid>
In-Reply-To: <20210728094511.2.If8a8ec3bf1855cf0dbb62c005a71d6698c99c125@changeid>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 29 Jul 2021 13:47:38 +0200
Message-ID: <CAG3jFytxZAJZdpMyL1Dye2Q+AaVLBDofV8risAFd=++pLYPvXQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/bridge: ti-sn65dsi86: Fix power off sequence
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        rajeevny@codeaurora.org, Lyude Paul <lyude@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Steev Klimaszewski <steev@kali.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Doug,

Thank you for submitting this.

On Wed, 28 Jul 2021 at 18:46, Douglas Anderson <dianders@chromium.org> wrote:
>
> When testing with a panel that's apparently a little more persnickety
> about the correct power sequence (specifically Samsung ATNA33XC20), we
> found that the ti-sn65dsi86 was doing things just slightly wrong.
>
> Looking closely at the ti-sn65dsi86's datasheet, the power off
> sequence is supposed to be:
> 1. Clear VSTREAM_ENABLE bit
> 2. Stop DSI stream from GPU. DSI lanes must be placed in LP11 state.
> 3. Program the ML_TX_MODE to 0x0 (OFF)
> 4. Program the DP_NUM_LANES register to 0x0
> 5. Clear the DP_PLL_EN bit.
> 6. Deassert the EN pin.
> 7. Remove power from supply pins
>
> Since we were doing the whole sequence in the "disable", I believe
> that step #2 (stopping the DSI stream from the GPU) wasn't
> happening. We also weren't setting DP_NUM_LANES to 0.
>
> Let's fix this.
>
> NOTE: things are a little asymmetric now. For instance, we turn the
> PLL on in "enable" but now we're not turning it off until
> "post_disable". It would seem to make sense to move the PLL turning on
> to "pre_enable" to match. Unfortunately, I don't believe that's
> allowed. It looks as if (in the non-refclk mode which probably nobody
> is using) we have to wait until the MIPI clock is there before we can
> enable the PLL. In any case, the way it is here won't really
> hurt--it'll just leave the PLL on a little longer.
>
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 9bf889302bcc..5e932070a1c3 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -766,10 +766,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
>
>         /* disable video stream */
>         regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
> -       /* semi auto link training mode OFF */
> -       regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
> -       /* disable DP PLL */
> -       regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
>  }
>
>  static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
> @@ -1106,6 +1102,13 @@ static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
>  {
>         struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>
> +       /* semi auto link training mode OFF */
> +       regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
> +       /* Num lanes to 0 as per power sequencing in data sheet */
> +       regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK, 0);
> +       /* disable DP PLL */
> +       regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
> +
>         if (!pdata->refclk)
>                 ti_sn65dsi86_disable_comms(pdata);
>
> --
> 2.32.0.432.gabb21c7263-goog
>

Acked-by: Robert Foss <robert.foss@linaro.org>
