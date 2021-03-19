Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01E341B92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCSLgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:35:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:35:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so6612660pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKHyKM5HpgM64/v1vzFdLp1d/ZtBozUZ21Nb1Kh1LfE=;
        b=oA4VSa+nu/9W7HEreKS2m+YjOanl3TPCruPFBgMTvzGK1JsQbrp7ZQne4hciU+1JpL
         tC2hWULRXHHPm4YwQNXxvUbUHsNu+x7lQ8tKHvDxk7FyQH65oZsd+VfiJrYfgCeNw0x0
         2EN2PSSWRcAdVl/GZMvNDl5QVcWps3mc2u+aTI6dsRha6h0AuWq8HTAlXVRbHO39y8q4
         WZkfB+U/TXLwbSlwImsWvK008U6xWpuA1uj8mdfmuDOUeq0ILBuWvf9PQZDnWX1pHpET
         Cgam/1cfnlVfvmOO9ujm+CmSjw2dgkAUvDDxyLpJFCwN1ntNUPTBIZ28vTqcL+GsxyRT
         dvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKHyKM5HpgM64/v1vzFdLp1d/ZtBozUZ21Nb1Kh1LfE=;
        b=A3Tc1vho5YuZd/9DQb7lIV++8LlbYhGE2DECch6n9D46wpsekJlZZISZBRjbM4o5cW
         Ug3u2Q9BDJIuM2dOYliBnardSofe0rTZ42Ea3vAI69paNvXj53wD4+fvhDp3HtMpsJWW
         Exx9tQKx00hd7HBMufuE38isW99n2U+LECoZamaTvQWtH1xF/7IV1ylugYVmLrG3gzop
         Q9I+NLu4uxmy+ZsMNFK4yNdTChI/BYuHYrqdguXwbYVuAxoDjvi6MWzcA9Sg4vEFHrtF
         lu+BFVJj6V6J28h2bNyg4hlVXF++mzmMUkFZD6W6JPYImrlo3paBCZhDwiu9k6IxIwXr
         OfWQ==
X-Gm-Message-State: AOAM533caZPibnFEWnZwC0iWSqptmlQYPTvQYv4xWl/1xZhuGTdWtGo8
        hZVWIiHhzx2w/0JL5XUBvOEC2AFAnzNc9k48q5JrRA==
X-Google-Smtp-Source: ABdhPJyYOsIuX8edCxIL4tkKbNSgbtWLcodZmdaiaQmxoRZST0LiH2O2E/Mhxco68rpGovr0mKxDhbougBexQ4y0Q9k=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr14084469plf.69.1616153735064; Fri, 19
 Mar 2021 04:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-28-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-28-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 12:35:24 +0100
Message-ID: <CAG3jFyuvnDQXXJKaY7zqi01_BG7pvFj0_9DJ2eAr2C=FvUtL1A@mail.gmail.com>
Subject: Re: [PATCH 27/30] drm/dp_mst: Pass drm_dp_mst_topology_mgr to drm_dp_get_vc_payload_bw()
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch.

On Fri, 19 Feb 2021 at 23:03, Lyude Paul <lyude@redhat.com> wrote:
>
> Since this is one of the few functions in drm_dp_mst_topology.c that
> doesn't have any way of getting access to a drm_device, let's pass the
> drm_dp_mst_topology_mgr down to this function so that it can use
> drm_dbg_kms().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c       | 7 +++++--
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>  include/drm/drm_dp_mst_helper.h             | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index cf4f2f85711e..fb66df39e0bb 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3631,6 +3631,7 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>
>  /**
>   * drm_dp_get_vc_payload_bw - get the VC payload BW for an MST link
> + * @mgr: The &drm_dp_mst_topology_mgr to use
>   * @link_rate: link rate in 10kbits/s units
>   * @link_lane_count: lane count
>   *
> @@ -3639,7 +3640,8 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>   * convert the number of PBNs required for a given stream to the number of
>   * timeslots this stream requires in each MTP.
>   */
> -int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count)
> +int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
> +                            int link_rate, int link_lane_count)
>  {
>         if (link_rate == 0 || link_lane_count == 0)
>                 DRM_DEBUG_KMS("invalid link rate/lane count: (%d / %d)\n",
> @@ -3704,7 +3706,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
>                         goto out_unlock;
>                 }
>
> -               mgr->pbn_div = drm_dp_get_vc_payload_bw(drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
> +               mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
> +                                                       drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
>                                                         mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
>                 if (mgr->pbn_div == 0) {
>                         ret = -EINVAL;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 8e316146b6d1..60ca0fa32d15 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -70,7 +70,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
>                 slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
>                                                       connector->port,
>                                                       crtc_state->pbn,
> -                                                     drm_dp_get_vc_payload_bw(crtc_state->port_clock,
> +                                                     drm_dp_get_vc_payload_bw(&intel_dp->mst_mgr,
> +                                                                              crtc_state->port_clock,
>                                                                                crtc_state->lane_count));

checkpatch --strict is unhappy about this chunk

WARNING: line length of 102 exceeds 100 columns
#61: FILE: drivers/gpu/drm/i915/display/intel_dp_mst.c:73:
+                                           crtc_state->port_clock,

Maybe the results of drm_dp_get_vc_payload_bw() can be but in a
temporary variable.

>                 if (slots == -EDEADLK)
>                         return slots;
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index bd1c39907b92..20dc705642bd 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -783,7 +783,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
>
>  struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
>
> -int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count);
> +int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
> +                            int link_rate, int link_lane_count);
>
>  int drm_dp_calc_pbn_mode(int clock, int bpp, bool dsc);
>
> --
> 2.29.2
>
