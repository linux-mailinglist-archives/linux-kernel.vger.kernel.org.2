Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202944337C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhKBQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhKBQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:46:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF7C0432ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:33:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so34197069wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAvIC90H2Q09upFWDw++dDK4c8sFoQjuntZhnvDGSjc=;
        b=c0mbANBt9R9oj2N98L18a2I8SDKA/gipnKrWs4hd1qLDydb9Sm8p0Tcn6pVUrcNZYS
         0YO3WLlDbYN9LkPXt9oDJl6yHVNsRc/ZsbJO9SKBnFILFlOP3mGcsfylFiqzMlw2UqnT
         YK29EU54tvJhS6nmvqPUWmde/+VU0IeseY5lGZcxiujlOLNV4AjDG5pzVCa0ln+/aCSm
         dC2PM5dknbACWIF0UteQJKH32XlB45eSytkJNuBTEBSSscH8Ui1Aoi/AbUA/acW/jYmG
         dItZ9cExxmcMcfe+F9ZlzG16Fvcdwy5icX9D78B+l+EgvI0PHndwL0Ww0EwxWl26H6Oi
         Ziag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAvIC90H2Q09upFWDw++dDK4c8sFoQjuntZhnvDGSjc=;
        b=BNex0n5/CHIif7KHLGHH+tspd9XaHuhWr+pSPPrFgzq9V9cvanuz8sPOlaW850XgJj
         n9jWY4V31PuRi+JPQx0EGPhsnODIjIQmIuHH6Zsh3aX9NdyuroeZRiRUsH5+0p0vhnLc
         bZIeDZj4f3jPxUyPBzQvsQxWImDD//xWJBQhdQqN5WKlfYFDPMxGCr17dt1XEGWPqQ9H
         d+SXnPP6B9dUsZXk4IHkFZ46BjFMt2kWhab4uNGF9j/6msWGMLMaxN8VPC4k2xHmSGrR
         1hXcTZf+GSu2tT2pKUTI6nv5wmj7rHVWfp9cv1FOoYXBE25WQEk1233JTAO//BNEIW0U
         f7nA==
X-Gm-Message-State: AOAM530/oDCWwV+3yIudoQLvp7zhrduTKiVwww+TZZDuAlMLckurOTA1
        mZj4On53BHRD71TjanzhRv3Ir2D8C/jUJau/TSI+KQ==
X-Google-Smtp-Source: ABdhPJzWC/vow5AFfmXW2psyst7Pv3WXP5/d12dixg/4qM4EsHpPOXqX8KOpobyDj89zmTTPgtf8ds+xSsuvmiW+gcM=
X-Received: by 2002:adf:a143:: with SMTP id r3mr48509272wrr.8.1635870810754;
 Tue, 02 Nov 2021 09:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-7-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-7-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:33:14 +0000
Message-ID: <CAPY8ntBKMr8RRCSq2xY-_uji-d=4Vr4BG53VoXzSd2dKJF-0ww@mail.gmail.com>
Subject: Re: [PATCH v8 06/10] drm/vc4: crtc: Add some logging
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-rpi-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:29, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The encoder retrieval code has been a source of bugs and glitches in the
> past and the crtc <-> encoder association been wrong in a number of
> different ways.
>
> Add some logging to quickly spot issues if they occur.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index fbc1d4638650..6decaa12a078 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -541,6 +541,9 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>         struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
>         struct drm_device *dev = crtc->dev;
>
> +       drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
> +               crtc->name, crtc->base.id, encoder->name, encoder->base.id);
> +
>         require_hvs_enabled(dev);
>
>         /* Disable vblank irq handling before crtc is disabled. */
> @@ -572,6 +575,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>         struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>
> +       drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
> +               crtc->name, crtc->base.id, encoder->name, encoder->base.id);
> +
>         require_hvs_enabled(dev);
>
>         /* Enable vblank irq handling before crtc is started otherwise
> --
> 2.31.1
>
