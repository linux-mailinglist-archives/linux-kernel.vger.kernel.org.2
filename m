Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52560361BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhDPIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbhDPIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:41:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:41:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 20so9642965pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He3oTSlwnFPi0gSb22caSHrtR7K6cmAux7Z+2T9Xo1o=;
        b=hacERswIX9cIS1UJydG+GKquH1hgrwS2+nCAq/Bgnj2hhImJuvM1HgFl4cg3S6pZev
         JCM/D2hsoeC9Cts3k/lDE+Tk9+6VMkX2XSjBRWjIaS+bPe6By0MTX5I0WkSokhwkTZ2s
         IbESokhSKgVQrq92WrdxoWpJ2zDl3xWxv0TymTHlFtLoHnW/4sc2o/IGhHEL6OREV5PB
         6L4ls7hRTeG8WWZxbf/vK4servXkCqbwQ9exsc6rCarR8bBKnafSkErOolvEAnnBOVyk
         YimIDDJRfC/4fGCP6QUmjQnHe0SUetMfhL8E10Ju8nu1Lfygrl+Nh+deXzi9RCwd4o03
         s9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He3oTSlwnFPi0gSb22caSHrtR7K6cmAux7Z+2T9Xo1o=;
        b=neOD+Ng8v0Jle+TIiInTeEtxxt3HLPSzrQ9eZ4Wr/R9yXxAd/IBenA8odTLP8hLD7u
         jtGXyHvZdzyCkQgkoCqWYROCkzIdq9qZT+Bxu+7nXA9E8XPeR2pi6sRZicP+k4Ps5/LV
         5XNVfDlYIq9awGj+tpA0LUvMZIeC1ydUCrIwSjIYqrSWthf5rp2Qi/ecuK6grwOPqI5j
         VaPTmG79frT9ReI4kzAG55DI1xS40ryb1/KQp7WEaLXS3s3a66pu5SlOqwuD8ODjRYQV
         ojNspVgFVkHIEZHa4GKrPEPa4ZiuuP8lYT01UNpGTNx/fRFs6tFub4TFddpV53eGj1VR
         uy0w==
X-Gm-Message-State: AOAM533aKW1FkXVrL5owMScaWXonAM6XcDjjWLbxGJM5+J640O4IQ9FP
        KJ37l4qzmBj2dqxaTGMZ/kL6yhXzQmEWwQpK4V+jIA==
X-Google-Smtp-Source: ABdhPJwF2oXeuk5v0ZBd9FHld186Dr4jfV9Bgsh1mreQZM+bGYmRq9h7B9YLZnGn9NgnTr0mVBmGQE0fwbP36eT7Of4=
X-Received: by 2002:a17:90b:392:: with SMTP id ga18mr8091538pjb.222.1618562488639;
 Fri, 16 Apr 2021 01:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210415183619.1431-1-rdunlap@infradead.org>
In-Reply-To: <20210415183619.1431-1-rdunlap@infradead.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 16 Apr 2021 10:41:17 +0200
Message-ID: <CAG3jFyvi-NyOdd8DdKu_QYz593YYvJzXm65DoCLubzHE+-5zNg@mail.gmail.com>
Subject: Re: [PATCH -next] drm: bridge: fix ANX7625 use of mipi_dsi_() functions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy!

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Thu, 15 Apr 2021 at 20:36, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The Analogix DRM ANX7625 bridge driver uses mips_dsi_() function
> interfaces so it should select DRM_MIPI_DSI to prevent build errors.
>
>
> ERROR: modpost: "mipi_dsi_attach" [drivers/gpu/drm/bridge/analogix/anx7625.ko] undefined!
> ERROR: modpost: "mipi_dsi_device_register_full" [drivers/gpu/drm/bridge/analogix/anx7625.ko] undefined!
> ERROR: modpost: "of_find_mipi_dsi_host_by_node" [drivers/gpu/drm/bridge/analogix/anx7625.ko] undefined!
> ERROR: modpost: "mipi_dsi_device_unregister" [drivers/gpu/drm/bridge/analogix/anx7625.ko] undefined!
> ERROR: modpost: "mipi_dsi_detach" [drivers/gpu/drm/bridge/analogix/anx7625.ko] undefined!
>
>
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Xin Ji <xji@analogixsemi.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20210414.orig/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ linux-next-20210414/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -30,6 +30,7 @@ config DRM_ANALOGIX_ANX7625
>         tristate "Analogix Anx7625 MIPI to DP interface support"
>         depends on DRM
>         depends on OF
> +       select DRM_MIPI_DSI
>         help
>           ANX7625 is an ultra-low power 4K mobile HD transmitter
>           designed for portable devices. It converts MIPI/DPI to
