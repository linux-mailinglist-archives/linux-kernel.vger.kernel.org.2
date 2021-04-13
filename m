Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360B935E790
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbhDMUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhDMUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:21:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97294C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:21:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso4279213pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vd4hM8TIUo1RzgqEpGrao+8fNPd8c1Sl3okjl2RgvE=;
        b=UgQsWVZdRVQjOVJF5/lChHhgFrkLrfGkEpmZe1BnJBVnMSYFbM1Sjmbu4KBbIr6Ure
         AqtAfm90wlS5eO7S1LVe5jR2mkXdAiITLN3SkID6bE/KaQiOFl8foEC5PJAmWtJY/WeR
         afuoY61aoDYYXFaesMICWF2dTx3JYwO4TIFsXt+TbbukHA3S87shTHxYuOA1Iz+zsu+P
         3P1nS+5HjYUUInaHaeSH3L7KOhcRrfFlNnMuxsEdppKd1zj/jzskDie/RrKIqf7RNd2t
         HwRBvMHe1PnDKCtTknuP7IzEA+5AZIeCVjDxpKX39H2FXRqJKI/Hk6CBPvj6R9aQtdXj
         cvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vd4hM8TIUo1RzgqEpGrao+8fNPd8c1Sl3okjl2RgvE=;
        b=JFi0wAOmKvddobULNf7vcSWhLhoEtjM9FnNEL5ljTdhPwE2D8rI+OHWgXdyyor7Tmj
         /S/NoD55YuM9W4we/oid4K/X/1sO0li7T1ZYLd2cN2bjZNpiNii0TfM9UEpJppITIWZq
         lBI8piC4RNSaLzzO/zwB+U2mQKAO3HxohywNhJszfJu0j1RTHwlVftmDAcN16IcgGLXT
         +L7rJ4XcyFaw94tddP/JCcpiSJBwaDbLyXYwj5Tn5kllNmIk4stMYR6hWq/ZtIJt+PyT
         g9xaR+ZJcrc0kWiT+WYpeuOG1rs4CXidAhX3n4U8eoYXM76LY2Zp2FfBY4b0r7KJ+lUO
         h/Kg==
X-Gm-Message-State: AOAM533dKJHGE7ffH8sIkBaN06jjqNibuXWCu7WL0eoCu9M8wyyz8d8l
        MwnJSOzD5mpL7wRmMDBOsGFE9vfDk/eptG3xg0HhEA==
X-Google-Smtp-Source: ABdhPJx2Q6trbmEyBPGMNkyaEggQB8G9ymoTlSsx6e9e4BsAJxS4fWCVAK1KopE210nmGmxkN456S/yZaq4pzyRbTkA=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr1900457pjh.19.1618345283988;
 Tue, 13 Apr 2021 13:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210412154648.3719153-1-narmstrong@baylibre.com> <20210412154648.3719153-3-narmstrong@baylibre.com>
In-Reply-To: <20210412154648.3719153-3-narmstrong@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 13 Apr 2021 22:21:13 +0200
Message-ID: <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        paul@crapouillou.net, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Neil & Phong,

Thanks for submitting this series!

> +
> +static const struct drm_bridge_funcs it66121_bridge_funcs = {
> +       .attach = it66121_bridge_attach,
> +       .enable = it66121_bridge_enable,
> +       .disable = it66121_bridge_disable,
> +       .mode_set = it66121_bridge_mode_set,
> +       .mode_valid = it66121_bridge_mode_valid,
> +       .detect = it66121_bridge_detect,
> +       .get_edid = it66121_bridge_get_edid,
> +       .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
> +       .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
> +};

I would like to see an implementation of HPD, since it is supported by
the hardware[1] (and required by the documentation). IRQ status bit 0
seems to be the responsible for notifying us about hot plug detection
events.

[1] https://rockchip.fr/radxa/IT66121_Programming_Guide.v1.05.pdf


Rob.
