Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C73DA279
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhG2Lsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhG2Lst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:48:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13F9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:48:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f13so6695636plj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxhHsDrYpm2kI+mPYAlWy7FpBAReDvQpjfpTvihE1ZE=;
        b=XQRdVrXr9ifqpbu6q9ewzE9YUmb4YMlVLGs9JHdGfMbmKe4kAYHSv4WY20+0qdxfGm
         5BRybZX5w7SbfyvL9iAXSPOh+xRz8VcvSemDzrTqs4EYxxlH1Eyy7MYcKqSFAWUcrANW
         iCFxE6oY/wFgElEjL5ktNZGFCcUNqiWgxMdKfhmiVshMAGlHBWppJ0DsRjBLnNKMr0qi
         osBMKIoO2gsGMbqJSgLmJHcoHZnWU/xvWKoPelN7JheEAJoSsQG8hGpE3X5LyqjG0cgT
         n8MTJSIDHwUhsK7k+/z9x1Kx2RmeM+/xweoby9TWdXrHItl342LoXyD+wooRp4gOpf+1
         MCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxhHsDrYpm2kI+mPYAlWy7FpBAReDvQpjfpTvihE1ZE=;
        b=VmQLXkDoR9jRYNra2FINXXoUrj1c5skyTLkvfNi2rd1N2iRykNm7JY0ZAo+//f9Vak
         FNomnki5Io/DaBS9EUx84Hhqcg0xFkvcEFkB24CQqCN9o5plYyzpFVUScwEpxwjzogii
         qGnGG5jE0k5Q7cBSnzZ0DUHakTHMUsXsrleo3FeYnffiEXCNCuJsdw9pPEt5PWxIB5YJ
         ZCUCfT/tuSTPDbOYj3HG/fpcO/d0ZMPgQBlQZ7m9oeBvYMttXWXKyfP5TEaSCNbM0/ek
         ZbEKK5qOt3ta3cI/OwczAbhzJ7BS/44d3Wxutd74PSQi0EWWn9Drpy7CKUdrXs1N6oH8
         1KGQ==
X-Gm-Message-State: AOAM5324jh3Ubcy3NMyKm5wiUXBxsHeI6ibuC+1Bvb8nZ0AL++7aaaLp
        5n056TVAB4Xrkvv2k5asQLf3+EDSISAKVDUbVXW5Ig==
X-Google-Smtp-Source: ABdhPJzmjmbRLZHOYGw8ZKDBP8QSe9qxWf7f2rEWUiJPz48ENWI7qEJjpdwkxa7mxaox1V0XGFReV7579lL4tNxFtQs=
X-Received: by 2002:a17:902:da8a:b029:12c:4261:a2d6 with SMTP id
 j10-20020a170902da8ab029012c4261a2d6mr4372829plx.50.1627559326287; Thu, 29
 Jul 2021 04:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210728164557.1882787-1-dianders@chromium.org> <20210728094511.3.I842d483139531aa4651da8338512fdf0171ff23c@changeid>
In-Reply-To: <20210728094511.3.I842d483139531aa4651da8338512fdf0171ff23c@changeid>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 29 Jul 2021 13:48:35 +0200
Message-ID: <CAG3jFyvwTY8azFVcHnSwgSe++ZNEfMvhbgROsLhpY00hwg5ikA@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/bridge: ti-sn65dsi86: Add some 100 us delays
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
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Doug,

Thanks for submitting this.

On Wed, 28 Jul 2021 at 18:46, Douglas Anderson <dianders@chromium.org> wrote:
>
> The manual has always said that we need 100 us delays in a few
> places. Though it hasn't seemed to be a big deal to skip these, let's
> add them in case it makes something happier.
>
> NOTE: this fixes no known issues but it seems good to make it right.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 5e932070a1c3..cd0fccdd8dfd 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -307,6 +307,9 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
>                 return ret;
>         }
>
> +       /* td2: min 100 us after regulators before enabling the GPIO */
> +       usleep_range(100, 110);
> +
>         gpiod_set_value(pdata->enable_gpio, 1);
>
>         /*
> @@ -1096,6 +1099,9 @@ static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
>
>         if (!pdata->refclk)
>                 ti_sn65dsi86_enable_comms(pdata);
> +
> +       /* td7: min 100 us after enable before DSI data */
> +       usleep_range(100, 110);
>  }
>
>  static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
> --
> 2.32.0.432.gabb21c7263-goog
>

Acked-by: Robert Foss <robert.foss@linaro.org>
