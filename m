Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7D38CCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhEUR4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhEUR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:56:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:54:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x8so21862117wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rHHcqz/pSg+dF4fMTZIEIgL/w6hIgzmKYZhWvb9og4=;
        b=hwvO0oS5iHlghvvUEitNVzEcBlqhR9fDodL1/KXliEqTsFBs/3cS4bgxqPGnihBG/t
         RnD6hDIwXc4DgEeDOpLniRWuBJxG353sRMGI5PthKcbrB+uvYpAx64DhvoQc/CwsO0tW
         ZZwvevQG5H8LCGBPqFKKPhXRc3QmbDjkWKwJosrejTbT+CAJdewVJD1HjfnlZuk4ReXq
         lbL6BOUehocvJF8lG7pI9tAlIPmcthPrPzaLc+uQ0LLmcQrAWS1VcT841vV1I+sWGq56
         cy0Km2a8Twno1adwjOVTEDFDLCBfKxKpmv0KvPpa6IMd3DIjYD1KqyZwqRp3vHSDH2ye
         kbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rHHcqz/pSg+dF4fMTZIEIgL/w6hIgzmKYZhWvb9og4=;
        b=r8GMoMnWKAv6I6O7LqrHYw/6D3tKlA891EPDaCYAa6VtkmtcZ6eIQkzZnAshyUu2d0
         xGAFkixmOiGBIDHkr2N0+I9v7jsrh4VzpVB8XJI0hJ/CuAdBj5PSyLpZlY5zgxxHkNyU
         XxyuQYhIsn33SdxLdqlTv+erq5Y283CL4XWADlE9dXB6jhoKZPbtnPSeYUdegHLHPpQI
         8dSUkRJroAc/InZjI+QBrst95X0w0iOkgmYT6uo1U0UVPpoJ+7aAIQg2R1k9wLsdpBSW
         qaZESh9OBk6K5tZOjIfOcEbg9m8lShZOuTPpJyAbLcLNTfhgB0MrijnrtUusfmZIjHAQ
         JwgQ==
X-Gm-Message-State: AOAM531arZTstiALUNoy74Ve94idxekZ1VkPtreu8lc5vbkDcOjHzmf8
        2ipHQ6+3wu0hXlo++sncQgBeq5uCHWZpd6yGGAB7lg==
X-Google-Smtp-Source: ABdhPJz6Whci0uUbleXzP3RlbdqRHSYAEycNljrlvUB6tTvssvEuldYxUtRTtrpcyO8m+7RP1E/fHZX4AlWjSLaYD7Y=
X-Received: by 2002:adf:f751:: with SMTP id z17mr10786261wrp.150.1621619676980;
 Fri, 21 May 2021 10:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210507150515.257424-1-maxime@cerno.tech> <20210507150515.257424-5-maxime@cerno.tech>
In-Reply-To: <20210507150515.257424-5-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 21 May 2021 18:54:20 +0100
Message-ID: <CAPY8ntDZeqHGLX1-ypC83v+-tEwOC1Z6N4eNg3d_WwzJ39NbXw@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] drm/vc4: crtc: Fix vc4_get_crtc_encoder logic
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Fri, 7 May 2021 at 16:05, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The vc4_get_crtc_encoder function currently only works when the
> connector->state->crtc pointer is set, which is only true when the
> connector is currently enabled.
>
> However, we use it as part of the disable path as well, and our lookup
> will fail in that case, resulting in it returning a null pointer we
> can't act on.
>
> We can access the connector that used to be connected to that crtc
> though using the old connector state in the disable path.
>
> Since we want to support both the enable and disable path, we can
> support it by passing the state accessor variant as a function pointer,
> together with the atomic state.
>
> Fixes: 792c3132bc1b ("drm/vc4: encoder: Add finer-grained encoder callbacks")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 8a19d6c76605..36ea684a349b 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -262,14 +262,22 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
>   * allows drivers to push pixels to more than one encoder from the
>   * same CRTC.
>   */
> -static struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc)
> +static struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
> +                                               struct drm_atomic_state *state,
> +                                               struct drm_connector_state *(*get_state)(struct drm_atomic_state *state,
> +                                                                                        struct drm_connector *connector))
>  {
>         struct drm_connector *connector;
>         struct drm_connector_list_iter conn_iter;
>
>         drm_connector_list_iter_begin(crtc->dev, &conn_iter);
>         drm_for_each_connector_iter(connector, &conn_iter) {
> -               if (connector->state->crtc == crtc) {
> +               struct drm_connector_state *conn_state = get_state(state, connector);
> +
> +               if (!conn_state)
> +                       continue;
> +
> +               if (conn_state->crtc == crtc) {
>                         drm_connector_list_iter_end(&conn_iter);
>                         return connector->encoder;
>                 }
> @@ -292,7 +300,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_atomic_state *s
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
> -       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
> +       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
> +                                                          drm_atomic_get_new_connector_state);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>         const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
> @@ -407,7 +416,8 @@ static int vc4_crtc_disable(struct drm_crtc *crtc,
>                             struct drm_atomic_state *state,
>                             unsigned int channel)
>  {
> -       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
> +       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
> +                                                          drm_atomic_get_old_connector_state);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>         struct drm_device *dev = crtc->dev;
> @@ -507,7 +517,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> -       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
> +       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, state,
> +                                                          drm_atomic_get_new_connector_state);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>
>         require_hvs_enabled(dev);
> --
> 2.31.1
>
