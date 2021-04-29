Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736D736F0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhD2UHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhD2UHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:07:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B675C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:06:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso29514016otp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpBPDRcCRB4YxTEvwemy+iKlTGhooWps70WY0dARJHk=;
        b=uv5WKOSb0n9+PSbwiZF9C7R5OItIFXVmQzEgvQPbML11er6OCcLvYx9Iy7kvH6+2DR
         IFGHm+BC0SdAJW26T0arODEv3n/DoMpnCOPFTBVJ3ZjWRy+oexH6W6szK3dZpctkquFM
         CoZtrpCrO3UFDlAPdFGd9iidNr2sTmWmoJuzh3Q/cOeVk4FKabrpO6Qty7eIKlfR6gUD
         kg1jefsCRnqoG6vRE5x2DOfd0A4NFRMuN+enDyl1Bz/1BTxGGMbIrD2v+dw5I6GHZpfb
         tvsNTbH0lqmTXHf1+urJ4PDMiS0ZZSviLOIbEYkHWFO/e2AJFn44atiX1P/bbccQB7tc
         CuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpBPDRcCRB4YxTEvwemy+iKlTGhooWps70WY0dARJHk=;
        b=juKzY0shJWngnek8RrK4L9/fLOwIXKRKARZiEraKU7UQ63dXR8UmZR6FfHn90WhY42
         MW+3MK5iU8Ur+9hKmLGPNLhYPWyvTHgdIpGfcyqq9uPlo7U5Rfs1tHUi4x5HghuYFeAK
         5tQEMT+D1R0d5L0m6kb6nMuXkdNQUJDDD4ykH0WBziSRhhNuLLnL0uBsBpkBy2PSXp/S
         k0IEqg0ieKSIaZT9qz5u+B4YupeROKnBWrYgJeAOS+3+NPyhQPhfE1HQqSNvk4FQooRn
         8qTAsZuID/GwUqpftdAxE6ZGYnyE8g2n2XdvLfnYjbsLzE7KXJtiRC1CEQXqxZrioW8M
         lXuw==
X-Gm-Message-State: AOAM532OmeH12Z62DffnQNIykEIbrNGdOlDw9CCWhmhgR6qC8zJet9r4
        NHx8hT4vZAsq3UOSE+PwUtYWL4vwTM5Wl948MVs=
X-Google-Smtp-Source: ABdhPJwfjLb/OyZmfEzUeN61AK09kq3wPPmkA4+QKlDFRCyea1X6NeJdVv16cVWd6Rr6GcOWNVG2u4zC+8amG+95JXs=
X-Received: by 2002:a9d:63d1:: with SMTP id e17mr635034otl.311.1619726806738;
 Thu, 29 Apr 2021 13:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210429133941.531730-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210429133941.531730-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Apr 2021 16:06:35 -0400
Message-ID: <CADnq5_MGhFTUOafo_Prjxgek7ufP-9uo59a+_R0=DKZBQayX0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/dpm: Disable sclk switching when two 4K 60Hz
 monitors are connected
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 9:40 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen flickers rapidly when two 4K 60Hz monitors are connected to an
> Oland card. This issue doesn't happen when one monitor is 4K 60Hz
> (pixelclock 594MHz) and another one is 4K 30Hz (pixelclock 297MHz).
>
> The issue is gone after setting "power_dpm_force_performance_level" to
> "high". Following the lead, we found that the issue only occurs when
> sclk is too low.
>
> So resolve the issue by disabling sclk switching when there are two
> monitors that requires high pixelclock (> 297MHz).
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
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
> index 9186095518047..be6fa3257d1bc 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -2995,6 +2995,9 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
>             ni_dpm_vblank_too_short(rdev))
>                 disable_mclk_switching = true;
>
> +       if (rdev->pm.dpm.high_pixelclock_count > 1)
> +               disable_sclk_switching = true;
> +

I would suggest limiting this to just Oland.

Alex


>         if (rps->vclk || rps->dclk) {
>                 disable_mclk_switching = true;
>                 disable_sclk_switching = true;
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
