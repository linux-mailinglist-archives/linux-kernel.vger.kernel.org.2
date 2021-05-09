Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C71377938
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEIXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:21:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4921C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 16:20:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v123so13056952ioe.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkkodwnCdAU48UvO9y0/V9XoTu/uQKyzxNYDNO8KRq4=;
        b=PzcwNtsDyTvjamCuXnR5F3wfitQnkD5U7s4W7TRuEiOO4acVOCA6LDH8wcCiWKG0S7
         7dy22gNoHksr9WXn/oXRIKH8ZyoZGnTaOPqJlbtHMaXSqFuGc0JXrphdrFdEiWOFI6QJ
         xwqLAyRaXePVoCCt0suUH1RaYfldDgXmzfgTR6fJxcRlyrPE/gF6yemKbbriqTE9np71
         lYzO3iYariBJXq4lKnzDTA8qoVdr5GNyEYMIz2jGxt0kSiW8M1j3bvBS2+umFbgSjBP7
         G+kaEYwqWlUc9YDHI/sq7V+3MJn5SNzAFkLVbsGx0ltll74dfkNSTu7x7ck+KIH7rN7d
         Ix9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkkodwnCdAU48UvO9y0/V9XoTu/uQKyzxNYDNO8KRq4=;
        b=ec9Mu+PVkvxRBBvSkCb1haseoIugYI0PetDbyYl0+uS87zc7wJjHaecmVR/fGhLjS2
         umBDorCkfziVqBVrPc4l2dF2nc86n87XKPGqJL6mgeYllpLcQDwu+plfd0xd0JQ2p4HU
         aO6IsMkbGEDIcXboU8nbdzK3NxVKeRgtAwITvQiKl7U8lllMdGHMXoh+sWM/CBtPRQbm
         4Zh7L4cBMn3KRqh4kqE45A1AGqxldjx+ViyI03CVCZtaUVbIo/RMHjJQQEqz3O9jhqjP
         gcas24W/DcqOfW6y9my/j6AFW3J5c9zddq0bI+LxuTH2zUBH9vT9bF+1SD6tnstTv4oA
         u8cw==
X-Gm-Message-State: AOAM530GKxH2fjEOtHfO7hfx4lHGMZVoViyDe8/15wQ9mxKDygm2CLZe
        2E8HChS9LNiser5wjOR0V06yDAuvSilleL3hF1o=
X-Google-Smtp-Source: ABdhPJxVqyFHKasq9v2Y1K0qL+X2UZlzzIqXpos3LGOjDoyQkt4aDioHgmhu9BOAjGruQjOILiWnREyHE6MhQFvjCxg=
X-Received: by 2002:a05:6602:55:: with SMTP id z21mr4947092ioz.54.1620602418318;
 Sun, 09 May 2021 16:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210509044330.4655-1-pauldzim@gmail.com>
In-Reply-To: <20210509044330.4655-1-pauldzim@gmail.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Sun, 9 May 2021 16:19:52 -0700
Message-ID: <CADBGO78C0T8dx9pgvim6oYd1K2DCvh8pctUwdWpgCP_VqRKbBQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Revert "drm/i915: Try to use fast+narrow link on eDP
 again and fall back to the old max strategy on failure"
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 9:44 PM Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> This reverts commit 2bbd6dba84d44219387df051a1c799b7bac46099.
>
> Since 5.12-rc2, my Dell XPS-15 laptop has had a blank screen on boot.
> The system seems to run fine other than having no display, I am able
> to ssh into the machine. I don't see anything interesting in the dmesg
> log. I bisected the problem down to this commit, and reverting it fixes
> the problem.
>
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>

Replying to myself, to say that I just tested kernel 5.13-rc1, and the
problem still exists there, and the same revert fixes the problem.

- Paul

> ---
> I am attaching the dmesg log from 5.12.0 when the problem occurs. Any
> other debugging info you want me to provide?
>
>  .../drm/i915/display/intel_display_types.h    |  1 -
>  drivers/gpu/drm/i915/display/intel_dp.c       | 75 +++----------------
>  2 files changed, 9 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 184ecbbcec99..196900100689 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1424,7 +1424,6 @@ struct intel_dp {
>         bool has_hdmi_sink;
>         bool has_audio;
>         bool reset_link_params;
> -       bool use_max_params;
>         u8 dpcd[DP_RECEIVER_CAP_SIZE];
>         u8 psr_dpcd[EDP_PSR_RECEIVER_CAP_SIZE];
>         u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 775d89b6c3fc..238ae1099132 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -480,13 +480,6 @@ int intel_dp_get_link_train_fallback_values(struct intel_dp *intel_dp,
>                 return -1;
>         }
>
> -       if (intel_dp_is_edp(intel_dp) && !intel_dp->use_max_params) {
> -               drm_dbg_kms(&i915->drm,
> -                           "Retrying Link training for eDP with max parameters\n");
> -               intel_dp->use_max_params = true;
> -               return 0;
> -       }
> -
>         index = intel_dp_rate_index(intel_dp->common_rates,
>                                     intel_dp->num_common_rates,
>                                     link_rate);
> @@ -1174,44 +1167,6 @@ intel_dp_compute_link_config_wide(struct intel_dp *intel_dp,
>         return -EINVAL;
>  }
>
> -/* Optimize link config in order: max bpp, min lanes, min clock */
> -static int
> -intel_dp_compute_link_config_fast(struct intel_dp *intel_dp,
> -                                 struct intel_crtc_state *pipe_config,
> -                                 const struct link_config_limits *limits)
> -{
> -       const struct drm_display_mode *adjusted_mode = &pipe_config->hw.adjusted_mode;
> -       int bpp, clock, lane_count;
> -       int mode_rate, link_clock, link_avail;
> -
> -       for (bpp = limits->max_bpp; bpp >= limits->min_bpp; bpp -= 2 * 3) {
> -               int output_bpp = intel_dp_output_bpp(pipe_config->output_format, bpp);
> -
> -               mode_rate = intel_dp_link_required(adjusted_mode->crtc_clock,
> -                                                  output_bpp);
> -
> -               for (lane_count = limits->min_lane_count;
> -                    lane_count <= limits->max_lane_count;
> -                    lane_count <<= 1) {
> -                       for (clock = limits->min_clock; clock <= limits->max_clock; clock++) {
> -                               link_clock = intel_dp->common_rates[clock];
> -                               link_avail = intel_dp_max_data_rate(link_clock,
> -                                                                   lane_count);
> -
> -                               if (mode_rate <= link_avail) {
> -                                       pipe_config->lane_count = lane_count;
> -                                       pipe_config->pipe_bpp = bpp;
> -                                       pipe_config->port_clock = link_clock;
> -
> -                                       return 0;
> -                               }
> -                       }
> -               }
> -       }
> -
> -       return -EINVAL;
> -}
> -
>  static int intel_dp_dsc_compute_bpp(struct intel_dp *intel_dp, u8 dsc_max_bpc)
>  {
>         int i, num_bpc;
> @@ -1435,14 +1390,13 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
>         limits.min_bpp = intel_dp_min_bpp(pipe_config->output_format);
>         limits.max_bpp = intel_dp_max_bpp(intel_dp, pipe_config);
>
> -       if (intel_dp->use_max_params) {
> +       if (intel_dp_is_edp(intel_dp)) {
>                 /*
>                  * Use the maximum clock and number of lanes the eDP panel
> -                * advertizes being capable of in case the initial fast
> -                * optimal params failed us. The panels are generally
> +                * advertizes being capable of. The panels are generally
>                  * designed to support only a single clock and lane
> -                * configuration, and typically on older panels these
> -                * values correspond to the native resolution of the panel.
> +                * configuration, and typically these values correspond to the
> +                * native resolution of the panel.
>                  */
>                 limits.min_lane_count = limits.max_lane_count;
>                 limits.min_clock = limits.max_clock;
> @@ -1461,22 +1415,11 @@ intel_dp_compute_link_config(struct intel_encoder *encoder,
>             intel_dp_can_bigjoiner(intel_dp))
>                 pipe_config->bigjoiner = true;
>
> -       if (intel_dp_is_edp(intel_dp))
> -               /*
> -                * Optimize for fast and narrow. eDP 1.3 section 3.3 and eDP 1.4
> -                * section A.1: "It is recommended that the minimum number of
> -                * lanes be used, using the minimum link rate allowed for that
> -                * lane configuration."
> -                *
> -                * Note that we fall back to the max clock and lane count for eDP
> -                * panels that fail with the fast optimal settings (see
> -                * intel_dp->use_max_params), in which case the fast vs. wide
> -                * choice doesn't matter.
> -                */
> -               ret = intel_dp_compute_link_config_fast(intel_dp, pipe_config, &limits);
> -       else
> -               /* Optimize for slow and wide. */
> -               ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config, &limits);
> +       /*
> +        * Optimize for slow and wide. This is the place to add alternative
> +        * optimization policy.
> +        */
> +       ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config, &limits);
>
>         /* enable compression if the mode doesn't fit available BW */
>         drm_dbg_kms(&i915->drm, "Force DSC en = %d\n", intel_dp->force_dsc_en);
> --
> 2.25.1
