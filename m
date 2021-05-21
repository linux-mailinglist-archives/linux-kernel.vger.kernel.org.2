Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01238CC16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhEUR2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEUR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:28:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7CBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:26:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j14so20063271wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HWXVP0e3Hcyxgm8TtR0BXxQYkcU6pjwHxvcyzC9gIM=;
        b=VS5DSLSPprKtNFD0DVsGL14+/349xDGMLh+mX2jYz2j67JB8oy37/IphMpC9gaq3Av
         thAtnj9g919W1QBh26aPfrvVfPg8zh6SkHyUYHpFXVURyB8kevNkNsTleB2N3mkctI2I
         iJM7f7/8iDBWE13iMiU7EIO7FvlI80+ob/z+dptosRK8jq/Y3pjZmZ9Szr0n1sPEr1JP
         u0vBLFJmo7/SQ/peGi+R77cDGZCYF2gNApRnq8Wp/cBr5L0U3UeGjPwmY6UQXxm4VyBe
         q1HLaZsa6cD9KKt80im6oPfYVPo7Uz1bXcZhMKfiOeeUXwvktcEcQ/Y73cZ/TsX6lKr1
         YLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HWXVP0e3Hcyxgm8TtR0BXxQYkcU6pjwHxvcyzC9gIM=;
        b=OquqsouoV+fhytDYhSUNx/RZodHT2W3yagG/qrR+j0NNqrx2Y2JDCIdr8xASzPiP8y
         E1HAcegSr4tyLvlIpRK8z+O3PYrTDtKR6MZOCFJY6DThCJVJHYqOy9WTPaC0urfsOj0x
         OyQleffwGVw4yvF/6i04PhZwmo5ALIcmu/eYbkEe3TQoLrzIgzf/h7rbtit1zhOlTK+0
         Lh4p8bxHTcboH6ITrwtWOVXsTVBTId2WyXjKhr9mYB7Dk4dRINl3tt0c1TgHyCxHxqs5
         f7ICrNe3a65+AEDejhpSPW335gzeMhd0be42dvhlqy1atXrB0hfpAOay3E5OTwljSmmL
         H8aQ==
X-Gm-Message-State: AOAM530TqoWhIOnP+hIsx6azV+z/W8it6lipZXdYOE+93c94z/ZWviEj
        ZXMgLPf16XSDrT/fTGRFMzCYzc0qpoE8mCmbR0aUfA==
X-Google-Smtp-Source: ABdhPJy08vzADSRZP901UvB9CawI7ieMduPTcjcFSBxbQPA1ZbKP/sY1janxRj9OfUR+ZdJ6zLxeTboD1W8fG+E3R/8=
X-Received: by 2002:a5d:6248:: with SMTP id m8mr10798651wrv.42.1621618011198;
 Fri, 21 May 2021 10:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210507150515.257424-1-maxime@cerno.tech> <20210507150515.257424-4-maxime@cerno.tech>
In-Reply-To: <20210507150515.257424-4-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 21 May 2021 18:26:35 +0100
Message-ID: <CAPY8ntDh_HKny+VoeGKn_facrTDNg_=JTzN1AZBaXCDT0Fp6Eg@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] drm/vc4: crtc: Pass the drm_atomic_state to config_pv
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

Thanks for the patch

On Fri, 7 May 2021 at 16:05, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The vc4_crtc_config_pv will need to access the drm_atomic_state
> structure and its only parent function, vc4_crtc_atomic_enable already
> has access to it. Let's pass it as a parameter.
>
> Fixes: 792c3132bc1b ("drm/vc4: encoder: Add finer-grained encoder callbacks")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index f1f2e8cbce79..8a19d6c76605 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -288,7 +288,7 @@ static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_FIFO_CLR);
>  }
>
> -static void vc4_crtc_config_pv(struct drm_crtc *crtc)
> +static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_atomic_state *state)
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -296,8 +296,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>         const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
> -       struct drm_crtc_state *state = crtc->state;
> -       struct drm_display_mode *mode = &state->adjusted_mode;
> +       struct drm_crtc_state *crtc_state = crtc->state;
> +       struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>         bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
>         u32 pixel_rep = (mode->flags & DRM_MODE_FLAG_DBLCLK) ? 2 : 1;
>         bool is_dsi = (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
> @@ -522,7 +522,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>         if (vc4_encoder->pre_crtc_configure)
>                 vc4_encoder->pre_crtc_configure(encoder, state);
>
> -       vc4_crtc_config_pv(crtc);
> +       vc4_crtc_config_pv(crtc, state);
>
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
>
> --
> 2.31.1
>
