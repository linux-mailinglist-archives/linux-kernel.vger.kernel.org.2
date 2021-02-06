Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E52311AA5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBFEEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:04:15 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:39211 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhBFDB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:01:29 -0500
Received: by mail-qv1-f51.google.com with SMTP id j4so4479391qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 19:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWIdyaZk9/oYRcHEJ4+7tjtfndiQTrSxe6MqleW8vSk=;
        b=EttcJxPs2QbwLr/udhGmx6gXl4kpmMWkVGbtcEvg43vXWQPiNLyQeiDiBGiMtnvAT9
         Zq/sq5HGtVacAexJ7RC602IqV174kwZmKS3BwT4ft39XJC4wPKmsatk3+Xif7mRzUF/v
         i9kvEXDY427SBZwRQmv249mYbyPJTGv4RcqGYSmDHFHyS+XjGx2w0jLA9VYhGA0hP/VA
         /BxDdxD0tNMaALxlez7x7UlC602S8EFBsheIt6lapR260ziRl1BD6vhFy4Vie8LCc7yJ
         NmB/hesDYLvY2rUXJQhKiRsFRX88ztct5i5Yl/A79nYk/6zdv576ZhMMFA9eWsuhw1/m
         DQ+A==
X-Gm-Message-State: AOAM532FjmctrnBYWh6NuvVvP1dEZBLstodXoWSGiN1zcYTWs4+bFI54
        C1dWbnnxRY3LaUs3I50BxGY99s1kywtCOut9G4nXgMsmlrE=
X-Google-Smtp-Source: ABdhPJxJIgKIk10RyyaoxQblF4duLLNKgdCrZTM3t0nEtDR0HKVJ+HMhYv8hicaLUuB9Bc+5v/j665IqMkjHYeTsV0A=
X-Received: by 2002:a1f:ae81:: with SMTP id x123mr5136104vke.1.1612570045044;
 Fri, 05 Feb 2021 16:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20210205234515.1216538-1-lyude@redhat.com> <20210205234515.1216538-6-lyude@redhat.com>
In-Reply-To: <20210205234515.1216538-6-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 5 Feb 2021 19:07:13 -0500
Message-ID: <CAKb7Uvhj+hMwhaNNng7yOOTSBf5gPNRT86aeXebvmPKHY1yTcw@mail.gmail.com>
Subject: Re: [Nouveau] [RFC v3 05/10] drm/i915/dpcd_bl: Cleanup
 intel_dp_aux_vesa_enable_backlight() a bit
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:45 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Get rid of the extraneous switch case in here, and just open code
> edp_backlight_mode as we only ever use it once.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  .../gpu/drm/i915/display/intel_dp_aux_backlight.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index c37ccc8538cb..95e3e344cf40 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -382,7 +382,7 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>         struct intel_dp *intel_dp = intel_attached_dp(connector);
>         struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>         struct intel_panel *panel = &connector->panel;
> -       u8 dpcd_buf, new_dpcd_buf, edp_backlight_mode;
> +       u8 dpcd_buf, new_dpcd_buf;
>         u8 pwmgen_bit_count = panel->backlight.edp.vesa.pwmgen_bit_count;
>
>         if (drm_dp_dpcd_readb(&intel_dp->aux,
> @@ -393,12 +393,8 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>         }
>
>         new_dpcd_buf = dpcd_buf;
> -       edp_backlight_mode = dpcd_buf & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
>
> -       switch (edp_backlight_mode) {
> -       case DP_EDP_BACKLIGHT_CONTROL_MODE_PWM:
> -       case DP_EDP_BACKLIGHT_CONTROL_MODE_PRESET:
> -       case DP_EDP_BACKLIGHT_CONTROL_MODE_PRODUCT:
> +       if ((dpcd_buf & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) != DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) {

You probably meant != MODE_DPCD?

>                 new_dpcd_buf &= ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
>                 new_dpcd_buf |= DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
>
> @@ -406,13 +402,6 @@ intel_dp_aux_vesa_enable_backlight(const struct intel_crtc_state *crtc_state,
>                                        pwmgen_bit_count) != 1)
>                         drm_dbg_kms(&i915->drm,
>                                     "Failed to write aux pwmgen bit count\n");
> -
> -               break;
> -
> -       /* Do nothing when it is already DPCD mode */
> -       case DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD:
> -       default:
> -               break;
>         }
>
>         if (panel->backlight.edp.vesa.pwm_freq_pre_divider) {
> --
> 2.29.2
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
