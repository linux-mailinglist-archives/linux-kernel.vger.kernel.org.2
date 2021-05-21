Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CCE38CC66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhEURlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbhEURlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:41:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B65C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:39:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7841337wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PGMSdzY46rRUuH9CGjzhpvBKwl08kAKQs9u+i9AHgw=;
        b=Nn/JXXpzFSUUF64vgcRuuSVXe/enfhqmlOCjKV5fks10W3PXjnVsUKNxAZt2HMHBNP
         wp1MYjFhmTKcFLOLG8SjGSwkRr/JmWL2ygPv97tNoCrECDCzHaxms1bNUwOc2dBrG3yA
         dwrN2LsP9pod4hYOFhawoiW8PNKgurFDMx3m+vJCAciOjFkSzs4QR1/8Ao6FKSuR9VnQ
         hT/AQU6r8/9UNqBRPIJW4Wp+Oomm9NrER4XqbAOs4p2GLScxEUkSP1OvV8S1qMHAW1nX
         AuOzbK/cC9MOhbsgp6XnaF1p//DBJAUkCQvlZY6Wca1KMeo0SOwrWrmiKl8kT0lp9JG9
         J35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PGMSdzY46rRUuH9CGjzhpvBKwl08kAKQs9u+i9AHgw=;
        b=N3A/ynMXRYxHCf6R0qQO5Tl//A6PLHMqK0oLwrQW/GNjJW0+of6OpYJ84DYga2s/R9
         MulDAH+2fY0NVU7eL03Ks6UZXFtz08WoWrLddl9HJf3tUHyuBUNoNCPOUCwl8kaq/ld4
         2Qbu8q0Q1Xe5IjBr02EBjQKnQBhefo8QFay9dCUbmcbw78jyM2DMaarZM1xjdPc7jzEl
         6JOa1cajukHInW2VmnrYvf3NtUgHivb9bBhTGxDtpbJioHBEWqHbLmZY6TOr362Ax0q1
         nXbkOnAXGVaZTKPUOXs0AMAujO7kNvs7eIUKK0QIBLjrid0k3xVOekxVgbNWvZTMhMMq
         LavA==
X-Gm-Message-State: AOAM531O+q6B0QqQY7Rm+97hZr8rrne3+aEkk6fBjuTj36oeXCpO5OzB
        1dn8mWhF1FPaq5hJvoTVW28NoZEDomkqu530y1Pv8g==
X-Google-Smtp-Source: ABdhPJwke9Zo9x6GRI6kIxAFqdYIOumj7qPq/rLlobM00C2kSpIwb3CzB9F4uxA+c0nJd0BrRD2oN1At/JeLDi7s6FA=
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr10189003wmi.116.1621618780301;
 Fri, 21 May 2021 10:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210507150515.257424-1-maxime@cerno.tech> <20210507150515.257424-11-maxime@cerno.tech>
In-Reply-To: <20210507150515.257424-11-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 21 May 2021 18:39:24 +0100
Message-ID: <CAPY8ntC=k5eDp8vy_WwymD8OD8o_83Z3C8kCt38qOsOEqsVCsA@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] drm/vc4: hdmi: Enable the scrambler
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

On Fri, 7 May 2021 at 16:06, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The HDMI controller on the BCM2711 includes a scrambler in order to
> reach the HDMI 2.0 modes that require it. Let's add the support for it.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c      | 64 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi_regs.h |  3 ++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 01d24ce8a795..bda12fea0dce 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -35,6 +35,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_scdc_helper.h>
>  #include <linux/clk.h>
>  #include <linux/component.h>
>  #include <linux/i2c.h>
> @@ -76,6 +77,8 @@
>  #define VC5_HDMI_VERTB_VSPO_SHIFT              16
>  #define VC5_HDMI_VERTB_VSPO_MASK               VC4_MASK(29, 16)
>
> +#define VC5_HDMI_SCRAMBLER_CTL_ENABLE          BIT(0)
> +
>  #define VC5_HDMI_DEEP_COLOR_CONFIG_1_INIT_PACK_PHASE_SHIFT     8
>  #define VC5_HDMI_DEEP_COLOR_CONFIG_1_INIT_PACK_PHASE_MASK      VC4_MASK(10, 8)
>
> @@ -462,6 +465,64 @@ static void vc4_hdmi_set_infoframes(struct drm_encoder *encoder)
>                 vc4_hdmi_set_audio_infoframe(encoder);
>  }
>
> +static bool vc4_hdmi_supports_scrambling(struct drm_encoder *encoder,
> +                                        struct drm_display_mode *mode)
> +{
> +       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       struct drm_display_info *display = &vc4_hdmi->connector.display_info;
> +
> +       if (!vc4_encoder->hdmi_monitor)
> +               return false;
> +
> +       if (!display->hdmi.scdc.supported ||
> +           !display->hdmi.scdc.scrambling.supported)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
> +{
> +       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +
> +       if (!vc4_hdmi_supports_scrambling(encoder, mode))
> +               return;
> +
> +       if (!vc4_hdmi_mode_needs_scrambling(mode))
> +               return;
> +
> +       drm_scdc_set_high_tmds_clock_ratio(vc4_hdmi->ddc, true);
> +       drm_scdc_set_scrambling(vc4_hdmi->ddc, true);
> +
> +       HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
> +                  VC5_HDMI_SCRAMBLER_CTL_ENABLE);
> +}
> +
> +static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
> +{
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       struct drm_crtc *crtc = encoder->crtc;
> +
> +       /*
> +        * At boot, encoder->crtc will be NULL. Since we don't know the
> +        * state of the scrambler and in order to avoid any
> +        * inconsistency, let's disable it all the time.
> +        */
> +       if (crtc && !vc4_hdmi_supports_scrambling(encoder, &crtc->mode))
> +               return;
> +
> +       if (crtc && !vc4_hdmi_mode_needs_scrambling(&crtc->mode))
> +               return;
> +
> +       HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) &
> +                  ~VC5_HDMI_SCRAMBLER_CTL_ENABLE);
> +
> +       drm_scdc_set_scrambling(vc4_hdmi->ddc, false);
> +       drm_scdc_set_high_tmds_clock_ratio(vc4_hdmi->ddc, false);
> +}
> +
>  static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
>                                                struct drm_atomic_state *state)
>  {
> @@ -474,6 +535,8 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
>
>         HDMI_WRITE(HDMI_VID_CTL,
>                    HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_BLANKPIX);
> +
> +       vc4_hdmi_disable_scrambling(encoder);
>  }
>
>  static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
> @@ -924,6 +987,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
>         }
>
>         vc4_hdmi_recenter_fifo(vc4_hdmi);
> +       vc4_hdmi_enable_scrambling(encoder);
>  }
>
>  static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
> index e1b58eac766f..19d2fdc446bc 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
> @@ -100,6 +100,7 @@ enum vc4_hdmi_field {
>         HDMI_RM_FORMAT,
>         HDMI_RM_OFFSET,
>         HDMI_SCHEDULER_CONTROL,
> +       HDMI_SCRAMBLER_CTL,
>         HDMI_SW_RESET_CONTROL,
>         HDMI_TX_PHY_CHANNEL_SWAP,
>         HDMI_TX_PHY_CLK_DIV,
> @@ -238,6 +239,7 @@ static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi0_fields[] = {
>         VC4_HDMI_REG(HDMI_GCP_CONFIG, 0x178),
>         VC4_HDMI_REG(HDMI_GCP_WORD_1, 0x17c),
>         VC4_HDMI_REG(HDMI_HOTPLUG, 0x1a8),
> +       VC4_HDMI_REG(HDMI_SCRAMBLER_CTL, 0x1c4),
>
>         VC5_DVP_REG(HDMI_CLOCK_STOP, 0x0bc),
>         VC5_DVP_REG(HDMI_VEC_INTERFACE_XBAR, 0x0f0),
> @@ -317,6 +319,7 @@ static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi1_fields[] = {
>         VC4_HDMI_REG(HDMI_GCP_CONFIG, 0x178),
>         VC4_HDMI_REG(HDMI_GCP_WORD_1, 0x17c),
>         VC4_HDMI_REG(HDMI_HOTPLUG, 0x1a8),
> +       VC4_HDMI_REG(HDMI_SCRAMBLER_CTL, 0x1c4),
>
>         VC5_DVP_REG(HDMI_CLOCK_STOP, 0x0bc),
>         VC5_DVP_REG(HDMI_VEC_INTERFACE_XBAR, 0x0f0),
> --
> 2.31.1
>
