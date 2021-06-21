Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B695A3AF5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFUS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFUS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:57:35 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:55:20 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so4742138ood.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ws0oUR3ELNIs8zDdYQlkxeo47oD4qWhq/p9GYsE3cWc=;
        b=UAj25foB8paV/qzw6De9bWBQ/zVoonOSC+mqDDzsWiB7zTejfKKEtdvdFtcEGTJ9d4
         LiZOfgfzhcGf/yG8msPChespnZL7E5JA3E1VLZqYVF4ppCo/5f1oK1iQa5aVb5avu56d
         dPErho+jgb2momidg8IeTmOcCRCES6u8xezcvZyiN1/EFH1od8URuHtQquzC0CJpidCV
         tTOzmR9pySr/8G8IcM/AMppDsyw4cgNdHHaxQVCTAq52yfxDfQzeIlZwmC3s7pleVZkE
         Ku8m7irJZ+xh95Vq0dkuzopdEzsgGwYzOz3RhSA88hcl/WgKq6XdSbl9gfNzt6Fg1xih
         qycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ws0oUR3ELNIs8zDdYQlkxeo47oD4qWhq/p9GYsE3cWc=;
        b=Oa/3qugBbSB0NgFQUJGjE4Q0QAunBwnkls2FA+dU6yCSU19xex04svadXiofZzAGYt
         183GP1UzmoyQXz88bu1dm2GtWhgm+5Xe8/nHD5jymRwcmIPAvXoO8ew24IeIh/yE/E0a
         ODNsj9ZvP1+zIE04KSAzWdFscrxSjTySizw/rNt8dTYVQobNF93yzto1WXflpOq6udjH
         Zmp5VSNfnVk6wsOnoV4mEP7V3R0AkVW3y7gu33YhnYQHf/zj5TohyBfOEYb69PoUDmbV
         HlFZG9EBZkd+QfasO9V0Rff6Pp2Up2Pl/kHGVIOAchTUKuwYcVXeKrk2lpPlc/T2ucS8
         qnKg==
X-Gm-Message-State: AOAM531vlS2NryDtjybTxjBCa/YK6uJsq2n/VW86mB5rUwaObehuMbLL
        sji3DPJ+KR3Tx9R358HKVu5fgO6EXG8r3hVmkQU=
X-Google-Smtp-Source: ABdhPJwZOfxSpjPiiNCLU7Pfkv6Ol9WQKID5eHbvsk9ZYD8jHhKBt6Tf6/5taM6m/Jblb7JD4y3WgD8QHo+lW5rJpps=
X-Received: by 2002:a4a:3904:: with SMTP id m4mr38610ooa.61.1624301719420;
 Mon, 21 Jun 2021 11:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210621130508.29511-1-bernard@vivo.com> <626348b5-a3c5-4a86-ca9f-ec41cc82044d@gmail.com>
In-Reply-To: <626348b5-a3c5-4a86-ca9f-ec41cc82044d@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Jun 2021 14:55:08 -0400
Message-ID: <CADnq5_OZ9_s6RMYcpstF2fN3kFjEkjC2Kx8kwZakHTpeFYf9Og@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: delete useless function return values &
 remove meaningless if(r) check code
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jun 21, 2021 at 9:15 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 21.06.21 um 15:05 schrieb Bernard Zhao:
> > Function radeon_fence_driver_init always returns success,
> > the function type maybe coule be changed to void.
> > This patch first delete the check of the return
> > value of the function call radeon_fence_driver_init, then,
> > optimise the function declaration and function to void type.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/cik.c          | 4 +---
> >   drivers/gpu/drm/radeon/evergreen.c    | 4 +---
> >   drivers/gpu/drm/radeon/ni.c           | 4 +---
> >   drivers/gpu/drm/radeon/r100.c         | 4 +---
> >   drivers/gpu/drm/radeon/r300.c         | 4 +---
> >   drivers/gpu/drm/radeon/r420.c         | 5 +----
> >   drivers/gpu/drm/radeon/r520.c         | 4 +---
> >   drivers/gpu/drm/radeon/r600.c         | 4 +---
> >   drivers/gpu/drm/radeon/radeon.h       | 2 +-
> >   drivers/gpu/drm/radeon/radeon_fence.c | 5 +----
> >   drivers/gpu/drm/radeon/rs400.c        | 4 +---
> >   drivers/gpu/drm/radeon/rs600.c        | 4 +---
> >   drivers/gpu/drm/radeon/rs690.c        | 4 +---
> >   drivers/gpu/drm/radeon/rv515.c        | 4 +---
> >   drivers/gpu/drm/radeon/rv770.c        | 4 +---
> >   drivers/gpu/drm/radeon/si.c           | 4 +---
> >   16 files changed, 16 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.=
c
> > index 42a8afa839cb..f6cf0b8fdd83 100644
> > --- a/drivers/gpu/drm/radeon/cik.c
> > +++ b/drivers/gpu/drm/radeon/cik.c
> > @@ -8584,9 +8584,7 @@ int cik_init(struct radeon_device *rdev)
> >       radeon_get_clock_info(rdev->ddev);
> >
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >
> >       /* initialize memory controller */
> >       r =3D cik_mc_init(rdev);
> > diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeo=
n/evergreen.c
> > index 8e9e88bf1f43..36a888e1b179 100644
> > --- a/drivers/gpu/drm/radeon/evergreen.c
> > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > @@ -5208,9 +5208,7 @@ int evergreen_init(struct radeon_device *rdev)
> >       /* Initialize clocks */
> >       radeon_get_clock_info(rdev->ddev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* initialize AGP */
> >       if (rdev->flags & RADEON_IS_AGP) {
> >               r =3D radeon_agp_init(rdev);
> > diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> > index ab7bd3080217..4a364ca7a1be 100644
> > --- a/drivers/gpu/drm/radeon/ni.c
> > +++ b/drivers/gpu/drm/radeon/ni.c
> > @@ -2375,9 +2375,7 @@ int cayman_init(struct radeon_device *rdev)
> >       /* Initialize clocks */
> >       radeon_get_clock_info(rdev->ddev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* initialize memory controller */
> >       r =3D evergreen_mc_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r10=
0.c
> > index fcfcaec25a9e..aa6800b0e198 100644
> > --- a/drivers/gpu/drm/radeon/r100.c
> > +++ b/drivers/gpu/drm/radeon/r100.c
> > @@ -4056,9 +4056,7 @@ int r100_init(struct radeon_device *rdev)
> >       /* initialize VRAM */
> >       r100_mc_init(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r30=
0.c
> > index 92643dfdd8a8..621ff174dff3 100644
> > --- a/drivers/gpu/drm/radeon/r300.c
> > +++ b/drivers/gpu/drm/radeon/r300.c
> > @@ -1549,9 +1549,7 @@ int r300_init(struct radeon_device *rdev)
> >       /* initialize memory controller */
> >       r300_mc_init(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r42=
0.c
> > index 1ed4407b91aa..7e6320e8c6a0 100644
> > --- a/drivers/gpu/drm/radeon/r420.c
> > +++ b/drivers/gpu/drm/radeon/r420.c
> > @@ -425,10 +425,7 @@ int r420_init(struct radeon_device *rdev)
> >       r300_mc_init(rdev);
> >       r420_debugfs(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r) {
> > -             return r;
> > -     }
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r) {
> > diff --git a/drivers/gpu/drm/radeon/r520.c b/drivers/gpu/drm/radeon/r52=
0.c
> > index fc78e64ae727..6cbcaa845192 100644
> > --- a/drivers/gpu/drm/radeon/r520.c
> > +++ b/drivers/gpu/drm/radeon/r520.c
> > @@ -299,9 +299,7 @@ int r520_init(struct radeon_device *rdev)
> >       r520_mc_init(rdev);
> >       rv515_debugfs(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r60=
0.c
> > index 7444dc0e0c0e..ca3fcae2adb5 100644
> > --- a/drivers/gpu/drm/radeon/r600.c
> > +++ b/drivers/gpu/drm/radeon/r600.c
> > @@ -3282,9 +3282,7 @@ int r600_init(struct radeon_device *rdev)
> >       /* Initialize clocks */
> >       radeon_get_clock_info(rdev->ddev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       if (rdev->flags & RADEON_IS_AGP) {
> >               r =3D radeon_agp_init(rdev);
> >               if (r)
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 56ed5634cebe..8a15f490a390 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -384,7 +384,7 @@ struct radeon_fence {
> >   };
> >
> >   int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ri=
ng);
> > -int radeon_fence_driver_init(struct radeon_device *rdev);
> > +void radeon_fence_driver_init(struct radeon_device *rdev);
> >   void radeon_fence_driver_fini(struct radeon_device *rdev);
> >   void radeon_fence_driver_force_completion(struct radeon_device *rdev,=
 int ring);
> >   int radeon_fence_emit(struct radeon_device *rdev, struct radeon_fence=
 **fence, int ring);
> > diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/ra=
deon/radeon_fence.c
> > index 0d8ef2368adf..b2ce642ca4fa 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fence.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> > @@ -905,9 +905,8 @@ static void radeon_fence_driver_init_ring(struct ra=
deon_device *rdev, int ring)
> >    * Not all asics have all rings, so each asic will only
> >    * start the fence driver on the rings it has using
> >    * radeon_fence_driver_start_ring().
> > - * Returns 0 for success.
> >    */
> > -int radeon_fence_driver_init(struct radeon_device *rdev)
> > +void radeon_fence_driver_init(struct radeon_device *rdev)
> >   {
> >       int ring;
> >
> > @@ -917,8 +916,6 @@ int radeon_fence_driver_init(struct radeon_device *=
rdev)
> >       }
> >
> >       radeon_debugfs_fence_init(rdev);
> > -
> > -     return 0;
> >   }
> >
> >   /**
> > diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs=
400.c
> > index 8423bcc3302b..6383f7a34bd8 100644
> > --- a/drivers/gpu/drm/radeon/rs400.c
> > +++ b/drivers/gpu/drm/radeon/rs400.c
> > @@ -555,9 +555,7 @@ int rs400_init(struct radeon_device *rdev)
> >       /* initialize memory controller */
> >       rs400_mc_init(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs=
600.c
> > index 5bf26058eec0..b2d22e25eee1 100644
> > --- a/drivers/gpu/drm/radeon/rs600.c
> > +++ b/drivers/gpu/drm/radeon/rs600.c
> > @@ -1132,9 +1132,7 @@ int rs600_init(struct radeon_device *rdev)
> >       rs600_mc_init(rdev);
> >       r100_debugfs_rbbm_init(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs=
690.c
> > index 7bc302a89232..14fb0819b8c1 100644
> > --- a/drivers/gpu/drm/radeon/rs690.c
> > +++ b/drivers/gpu/drm/radeon/rs690.c
> > @@ -850,9 +850,7 @@ int rs690_init(struct radeon_device *rdev)
> >       rs690_mc_init(rdev);
> >       rv515_debugfs(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv=
515.c
> > index 46a53dd38079..63fb06e8e2d7 100644
> > --- a/drivers/gpu/drm/radeon/rv515.c
> > +++ b/drivers/gpu/drm/radeon/rv515.c
> > @@ -648,9 +648,7 @@ int rv515_init(struct radeon_device *rdev)
> >       rv515_mc_init(rdev);
> >       rv515_debugfs(rdev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* Memory manager */
> >       r =3D radeon_bo_init(rdev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv=
770.c
> > index 88e29ebaad46..74499307285b 100644
> > --- a/drivers/gpu/drm/radeon/rv770.c
> > +++ b/drivers/gpu/drm/radeon/rv770.c
> > @@ -1941,9 +1941,7 @@ int rv770_init(struct radeon_device *rdev)
> >       /* Initialize clocks */
> >       radeon_get_clock_info(rdev->ddev);
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >       /* initialize AGP */
> >       if (rdev->flags & RADEON_IS_AGP) {
> >               r =3D radeon_agp_init(rdev);
> > diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> > index d0e94b10e4c0..013e44ed0f39 100644
> > --- a/drivers/gpu/drm/radeon/si.c
> > +++ b/drivers/gpu/drm/radeon/si.c
> > @@ -6857,9 +6857,7 @@ int si_init(struct radeon_device *rdev)
> >       radeon_get_clock_info(rdev->ddev);
> >
> >       /* Fence driver */
> > -     r =3D radeon_fence_driver_init(rdev);
> > -     if (r)
> > -             return r;
> > +     radeon_fence_driver_init(rdev);
> >
> >       /* initialize memory controller */
> >       r =3D si_mc_init(rdev);
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
