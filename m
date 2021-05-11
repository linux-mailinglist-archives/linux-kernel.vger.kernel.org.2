Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84237AFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhEKUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:14:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:13:01 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso18558038otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2M7i3OM3TdmABjLPSIXD1SsZiaIt0flPM1PcqwkFM0E=;
        b=G+o2VLn5iC77L6jgX4A3gjrnUa/7lSk6dn3BJVzLYlnp66WKm+DQVEKYdI2vIZpSQD
         w45MOJtLvVStmHQ6SBGetYuXiR/6bnAcRFr5UVNSqajnf9W5E1IC4eOBODzDos+kaTDw
         4kuG0P6cB56+mzkG0a1Xt5ERhW7FW8sM/TM2dF8x4EahEjGw5S1fQKJc4Wm2bCLR2P+6
         dP+mWrkOvxuirk/I71UUwNSPZk09NLNg7FOnD6/1rab8rPc6Zjn7t94X+Nqe6V6lMsOQ
         WHbShZl8FEH2MrOWZHCivMU9ZQNCZ41UsqPYOnnLiT4zF+9cb5W9Xo4xbvDrfW4LuwUX
         iTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2M7i3OM3TdmABjLPSIXD1SsZiaIt0flPM1PcqwkFM0E=;
        b=EBPZ0l0Kp0FcKyyH1fKgyiY0Ct2XYwb2mFfYGQlzo3QWhYnPUd07cUZjwl8+p6y+/1
         Zxt9PitHBrhwiDo9ZUzxthixiqjVDRCAukA7ut58XsnQ9UpzSy/wAv0iEJvOYnEbnQXY
         TB5kMvZpD8Xnxaysb07kuKM2nAePbL3W63Ui0sRr4v1Dno5Yv3Mn803SM7H98KIDYiXn
         AN3ElO2obmyLLA958+Cbw/JWOhq9/4QiQemcQTxk3NEl0uxQq0sZsEryg7aZ04nVLAug
         76tKxg236Mj1DRJ/8Efo9gNJP3psO1atckeLphz9Vs2fybdfF3SDia2CFpGJe4UQ45Vx
         lCcw==
X-Gm-Message-State: AOAM531jtxplcEGk2KWb1BJHzTfdiqNkgAv6rUzgeW2lQMW797ClohMG
        m5g0iICbDaGJVh4vagYT1fOAFk+XZNZnsMvY2is=
X-Google-Smtp-Source: ABdhPJwXPwvyfRjsMHTY09QJKdISxNGiHPrjAi1z0b0hOgpy/pkpSRj0Ad3aZhG6x0gkMazxZywXYzfkdlPcQTrKsr8=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr11846574otl.132.1620763980927;
 Tue, 11 May 2021 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210430045656.577395-1-kai.heng.feng@canonical.com> <CAAd53p4fLYXB0z7OQOmAS_BkACARTrrfRf+QwWd3MYQhk5oFTw@mail.gmail.com>
In-Reply-To: <CAAd53p4fLYXB0z7OQOmAS_BkACARTrrfRf+QwWd3MYQhk5oFTw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 May 2021 16:12:49 -0400
Message-ID: <CADnq5_OVQv2K_30uWN7qwUsGVWD7bc7qAs-s_TL-m8NLCDSkOw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/dpm: Disable sclk switching on Oland when
 two 4K 60Hz monitors are connected
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:33 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Fri, Apr 30, 2021 at 12:57 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Screen flickers rapidly when two 4K 60Hz monitors are in use. This issue
> > doesn't happen when one monitor is 4K 60Hz (pixelclock 594MHz) and
> > another one is 4K 30Hz (pixelclock 297MHz).
> >
> > The issue is gone after setting "power_dpm_force_performance_level" to
> > "high". Following the indication, we found that the issue occurs when
> > sclk is too low.
> >
> > So resolve the issue by disabling sclk switching when there are two
> > monitors requires high pixelclock (> 297MHz).
> >
> > v2:
> >  - Only apply the fix to Oland.
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A gentle ping...

Applied.  Thanks for the reminder.

Alex


>
> > ---
> >  drivers/gpu/drm/radeon/radeon.h    | 1 +
> >  drivers/gpu/drm/radeon/radeon_pm.c | 8 ++++++++
> >  drivers/gpu/drm/radeon/si_dpm.c    | 3 +++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> > index 42281fce552e6..56ed5634cebef 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -1549,6 +1549,7 @@ struct radeon_dpm {
> >         void                    *priv;
> >         u32                     new_active_crtcs;
> >         int                     new_active_crtc_count;
> > +       int                     high_pixelclock_count;
> >         u32                     current_active_crtcs;
> >         int                     current_active_crtc_count;
> >         bool single_display;
> > diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> > index 0c1950f4e146f..3861c0b98fcf3 100644
> > --- a/drivers/gpu/drm/radeon/radeon_pm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> > @@ -1767,6 +1767,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
> >         struct drm_device *ddev = rdev->ddev;
> >         struct drm_crtc *crtc;
> >         struct radeon_crtc *radeon_crtc;
> > +       struct radeon_connector *radeon_connector;
> >
> >         if (!rdev->pm.dpm_enabled)
> >                 return;
> > @@ -1776,6 +1777,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
> >         /* update active crtc counts */
> >         rdev->pm.dpm.new_active_crtcs = 0;
> >         rdev->pm.dpm.new_active_crtc_count = 0;
> > +       rdev->pm.dpm.high_pixelclock_count = 0;
> >         if (rdev->num_crtc && rdev->mode_info.mode_config_initialized) {
> >                 list_for_each_entry(crtc,
> >                                     &ddev->mode_config.crtc_list, head) {
> > @@ -1783,6 +1785,12 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
> >                         if (crtc->enabled) {
> >                                 rdev->pm.dpm.new_active_crtcs |= (1 << radeon_crtc->crtc_id);
> >                                 rdev->pm.dpm.new_active_crtc_count++;
> > +                               if (!radeon_crtc->connector)
> > +                                       continue;
> > +
> > +                               radeon_connector = to_radeon_connector(radeon_crtc->connector);
> > +                               if (radeon_connector->pixelclock_for_modeset > 297000)
> > +                                       rdev->pm.dpm.high_pixelclock_count++;
> >                         }
> >                 }
> >         }
> > diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> > index 9186095518047..3cc2b96a7f368 100644
> > --- a/drivers/gpu/drm/radeon/si_dpm.c
> > +++ b/drivers/gpu/drm/radeon/si_dpm.c
> > @@ -2979,6 +2979,9 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
> >                     (rdev->pdev->device == 0x6605)) {
> >                         max_sclk = 75000;
> >                 }
> > +
> > +               if (rdev->pm.dpm.high_pixelclock_count > 1)
> > +                       disable_sclk_switching = true;
> >         }
> >
> >         if (rps->vce_active) {
> > --
> > 2.30.2
> >
