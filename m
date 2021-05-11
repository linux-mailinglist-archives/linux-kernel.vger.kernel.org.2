Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58A4379DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhEKDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:34:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEKDeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:34:13 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lgJ8p-0006CQ-Ma
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 03:33:05 +0000
Received: by mail-lj1-f198.google.com with SMTP id a14-20020a2e7f0e0000b02900b9011db00cso10208161ljd.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpZ1o8BZbVj97ScJ5uIe5Iz8N7aLUvfNU9S9Nz3IzwM=;
        b=rNzTqLPO5VyhfVSDmg9BuR8B1OFGk9d9I4XkuSd+aO0NuVo6c36hxq1mvBgz+FT5Yd
         lEblpdGP9cI6mQyEogLvtdkA2zKGTCvQlVdn0Z/UlBc/v3qGaANrJ3E58wLS6LqugdQn
         FX3K79cMMIWIx8abdKyfStVnckYW+ixEXaKZCPQHWmDNt/nrWbrz4eDhxGWXSbHMmtt+
         ZNPYKwNLuSymiQt66VLsTyX7mPt1KDGbFU+SPYhirGzT0ljkYdBqJpT/sC8NdYsuvE6k
         q+ENlmJgbO37fpHrNF94V9Ax62VgpRTnMpoJHyF693c21jl5Kt0r0+7c1KIU4HfcnYDD
         um2w==
X-Gm-Message-State: AOAM530YuHOXcogDreL3Y2e1ciSaZRy5w+640xROl7s6TYSUlpwjd7Ya
        +hZiirijDsNHAYj0sZvlmaAuc0OageAUWip+IzBLRSwWbs/9d3E/6gcm6YeSgZNJyoqd7RxdCLy
        28nHDvFZxhtOKR8lV13HS4KwamHnSyZiqAr0sXsj83BvzDXEKMys/IHxvsg==
X-Received: by 2002:a05:6512:3b93:: with SMTP id g19mr19441658lfv.548.1620703983109;
        Mon, 10 May 2021 20:33:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ3I3h7WqnNP7SEfWG7sKaQkaYZUkTMSdI76PL8q58FqDBzKUFS9tR8ZJAqHuO5+E46Kf0NlHlj83wxal64HY=
X-Received: by 2002:a05:6512:3b93:: with SMTP id g19mr19441646lfv.548.1620703982869;
 Mon, 10 May 2021 20:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210430045656.577395-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210430045656.577395-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 11 May 2021 11:32:50 +0800
Message-ID: <CAAd53p4fLYXB0z7OQOmAS_BkACARTrrfRf+QwWd3MYQhk5oFTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/dpm: Disable sclk switching on Oland when
 two 4K 60Hz monitors are connected
To:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:57 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen flickers rapidly when two 4K 60Hz monitors are in use. This issue
> doesn't happen when one monitor is 4K 60Hz (pixelclock 594MHz) and
> another one is 4K 30Hz (pixelclock 297MHz).
>
> The issue is gone after setting "power_dpm_force_performance_level" to
> "high". Following the indication, we found that the issue occurs when
> sclk is too low.
>
> So resolve the issue by disabling sclk switching when there are two
> monitors requires high pixelclock (> 297MHz).
>
> v2:
>  - Only apply the fix to Oland.
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/gpu/drm/radeon/radeon.h    | 1 +
>  drivers/gpu/drm/radeon/radeon_pm.c | 8 ++++++++
>  drivers/gpu/drm/radeon/si_dpm.c    | 3 +++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index 42281fce552e6..56ed5634cebef 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -1549,6 +1549,7 @@ struct radeon_dpm {
>         void                    *priv;
>         u32                     new_active_crtcs;
>         int                     new_active_crtc_count;
> +       int                     high_pixelclock_count;
>         u32                     current_active_crtcs;
>         int                     current_active_crtc_count;
>         bool single_display;
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index 0c1950f4e146f..3861c0b98fcf3 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -1767,6 +1767,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>         struct drm_device *ddev = rdev->ddev;
>         struct drm_crtc *crtc;
>         struct radeon_crtc *radeon_crtc;
> +       struct radeon_connector *radeon_connector;
>
>         if (!rdev->pm.dpm_enabled)
>                 return;
> @@ -1776,6 +1777,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>         /* update active crtc counts */
>         rdev->pm.dpm.new_active_crtcs = 0;
>         rdev->pm.dpm.new_active_crtc_count = 0;
> +       rdev->pm.dpm.high_pixelclock_count = 0;
>         if (rdev->num_crtc && rdev->mode_info.mode_config_initialized) {
>                 list_for_each_entry(crtc,
>                                     &ddev->mode_config.crtc_list, head) {
> @@ -1783,6 +1785,12 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
>                         if (crtc->enabled) {
>                                 rdev->pm.dpm.new_active_crtcs |= (1 << radeon_crtc->crtc_id);
>                                 rdev->pm.dpm.new_active_crtc_count++;
> +                               if (!radeon_crtc->connector)
> +                                       continue;
> +
> +                               radeon_connector = to_radeon_connector(radeon_crtc->connector);
> +                               if (radeon_connector->pixelclock_for_modeset > 297000)
> +                                       rdev->pm.dpm.high_pixelclock_count++;
>                         }
>                 }
>         }
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 9186095518047..3cc2b96a7f368 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -2979,6 +2979,9 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
>                     (rdev->pdev->device == 0x6605)) {
>                         max_sclk = 75000;
>                 }
> +
> +               if (rdev->pm.dpm.high_pixelclock_count > 1)
> +                       disable_sclk_switching = true;
>         }
>
>         if (rps->vce_active) {
> --
> 2.30.2
>
