Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A957D43D0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbhJ0Sgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbhJ0Sgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:36:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:34:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u5so6220596ljo.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMasC2rgckEWdCe4DVz6in+O9oEmCriK7Q/BDKT8+60=;
        b=BU9c4Kt2klb9pGlGYSH6N2/niQ4oNqfLZ0U1NjtsaTgg7k2zPmvXxZMNe4LsT/a25Y
         FIhGhLYGlcZIbZ5j7j/wImxQN0EpLG2rhMuMjkY2ZOZtzRN9RqqqM2Z5uaL0wHre6mWM
         X7XRH+g6SO72fi7HbBdQdNVRGP6vVPJBwpQNB051MQ98oMp8EsGzZR8rkERWdlg/ct9o
         ddJXJKuqCo1GoTk5cB29k6H24t/jtwCG/qx/JiEgo0fh9G2BeRlLJWBsA8+ncOvhsWK7
         4aJySPcTUrOnoJ4Ah5b9ngmkz6HfI8+bB1S/leVgn/9yzaNvwSOGDWeh+h8NSiDjQk22
         DXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMasC2rgckEWdCe4DVz6in+O9oEmCriK7Q/BDKT8+60=;
        b=e0wvH41rq5maFdsTDvXCKCTTrXL3YvUNNaDH2S8EkDONmiGLHUnau6HrlTr15tqm4x
         bDgWAkCtOLaZWruXTdBHxZuQMkp5iEytZ3avsaruOdcHC/9hBOopcrfOUaZ7OPq+lM3F
         tbE4wmp+M8lT9MYxShwM1xu5WtOt3nTGcY5oohy4QQaanTPX0iUGRgSk+JFbYEHOFIuY
         rck7Rv/GLCFu5dB8zsDg3zezO2eBjnlgtuGz4iMNCVoTCQUmEU2A4LUSaudueTKJKdKA
         03tqK7hQNiU1DLPSS73j0zeJuuWPKRKqTqnDZ2fv4+dzVUXS4z/OwnLqTSG3JgJk2WIr
         /kDQ==
X-Gm-Message-State: AOAM5311FSMzyO/FUTEWg+EX/vtf+rADx6tHM9hQjmi4NPDKZvUsocLP
        hQsbhopYgY/Q5GyKCY69xjUIc2vyc1JuP1Up+c+upA==
X-Google-Smtp-Source: ABdhPJydr0p5R5kOrBi0cKjyUtJDjfb0NxbOwZhHcj6m+H19kxZT9BRZop/bB7yZsgjxXgCMaOYdHA2FjRV6asLzles=
X-Received: by 2002:a05:651c:389:: with SMTP id e9mr14617679ljp.61.1635359656666;
 Wed, 27 Oct 2021 11:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211025151536.1048186-1-maxime@cerno.tech> <20211025151536.1048186-21-maxime@cerno.tech>
In-Reply-To: <20211025151536.1048186-21-maxime@cerno.tech>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 27 Oct 2021 11:34:05 -0700
Message-ID: <CALAqxLXG5R2ZN9gfFsGTLfdY8mhNhh=o8f1w5Axo8NSw8QanAQ@mail.gmail.com>
Subject: Re: [PATCH v6 20/21] drm/kirin: dsi: Adjust probe order
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Xinliang Liu <xinliang.liu@linaro.org>,
        linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 8:16 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Without proper care and an agreement between how DSI hosts and devices
> drivers register their MIPI-DSI entities and potential components, we can
> end up in a situation where the drivers can never probe.
>
> Most drivers were taking evasive maneuvers to try to workaround this,
> but not all of them were following the same conventions, resulting in
> various incompatibilities between DSI hosts and devices.
>
> Now that we have a sequence agreed upon and documented, let's convert
> kirin to it.
>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

For this patch, and any others in this series folks see fit:
   Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
