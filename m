Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41293ACF65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhFRPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFRPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:49:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:46:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q190so9367584qkd.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcQ7KK9hBr7yvfbTrQi3Dt8X1Vt9/IIv1M0D2G1Phvg=;
        b=d6zx0EVQIUvYQKiq5vg04ODnRSh3aGr1a4W5bd212/iIGjXiQkaD5wFJ5cwXwMXenx
         +TTT2W2Pz/bfQsaV5Z9Mr7zuyJkWKU444YC5R2BUqLgkZB7cwtux8b8tqsiiyM6TpgVU
         ESQLBs4GzhK69GPIM7/pM1iniJvkHekT4cq9PArNOhWGdRKuX8JehmeabeQ5KMe/R+6/
         biaWwvgWsVvIdhoGqgbx/bYxYtE251FrlNdqhcSSKnINGgSd0aMCFHZEi2vjEKw1Pm5M
         psIxwZJrtgFiAnHuxVThFK6U4xqjcbIFobjYzIlszVp17uFuwGe6rhmgsaV4YMJOGhfG
         arWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcQ7KK9hBr7yvfbTrQi3Dt8X1Vt9/IIv1M0D2G1Phvg=;
        b=cEybU2Qwlu6twO3ly7l5FLEGJiMbMpIq4YSLziuHy9zisfsEJwfZqqH0ARYm3/9Nzn
         HgCHY7Qw03KXWgc2j6f6YJYzN5PE9W2Ibr8nWF2qTyBc3YSapDaToYhdHngu+FT8w7pB
         zD+2xHkDVzJ8PpfNe28yqBwHWEaavHLWbbLuBIPWnH7f3pK6stlXVi7nVYnUKiVDwofk
         kiwpms8jhnTFlsKqSyNoyTkpCn2lxXYdRT9FMwF3RVACb4Gm6X+akNqe5Pxt6K4bED7h
         Pn22MMOCPRGGEqgq7SrNzUH5dFLcLXvJUs02eGFMZf82ZCJ6I4jaaHHxX8/JUcxlYYdi
         pxpQ==
X-Gm-Message-State: AOAM532Fv2dUe4OGk7Vr6Ia/VNdxM74CWNKiLhNBAjfIX4ZKQv1etJx9
        KtHaGC8v+nppnEky2wQzseHb1Ata5EM2N0Zwsgg=
X-Google-Smtp-Source: ABdhPJxeeNCGxHdVH+QTwJHu5xaAsLnCKxDux48dD7O23fN1VXkfNzhfdtFjRSJIuoNIO5YzqhK0a5tN7P14CwSm2v4=
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr9806718qkm.481.1624031210454;
 Fri, 18 Jun 2021 08:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <YMdPcWZi4x7vnCxI@google.com> <YMuGGqs4cDotxuKO@phenom.ffwll.local>
In-Reply-To: <YMuGGqs4cDotxuKO@phenom.ffwll.local>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Fri, 18 Jun 2021 16:46:24 +0100
Message-ID: <CAM0jSHMYk3GeZTP7FQ8z2H02GfCcJsUeNwbzH3GLdRVxvMzqDg@mail.gmail.com>
Subject: Re: drm/i915: __GFP_RETRY_MAYFAIL allocations in stable kernels
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 18:27, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jun 14, 2021 at 09:45:37PM +0900, Sergey Senozhatsky wrote:
> > Hi,
> >
> > We are observing some user-space crashes (sigabort, segfaults etc.)
> > under moderate memory pressure (pretty far from severe pressure) which
> > have one thing in common - restrictive GFP mask in setup_scratch_page().
> >
> > For instance, (stable 4.19) drivers/gpu/drm/i915/i915_gem_gtt.c
> >
> > (trimmed down version)
> >
> > static int gen8_init_scratch(struct i915_address_space *vm)
> > {
> >         setup_scratch_page(vm, __GFP_HIGHMEM);
> >
> >         vm->scratch_pt = alloc_pt(vm);
> >         vm->scratch_pd = alloc_pd(vm);
> >         if (use_4lvl(vm)) {
> >                 vm->scratch_pdp = alloc_pdp(vm);
> >         }
> > }
> >
> > gen8_init_scratch() function puts a rather inconsistent restrictions on mm.
> >
> > Looking at it line by line:
> >
> > setup_scratch_page() uses very restrictive gfp mask:
> >       __GFP_HIGHMEM | __GFP_ZERO | __GFP_RETRY_MAYFAIL
> >
> > it doesn't try to reclaim anything and fails almost immediately.
> >
> > alloc_pt() - uses more permissive gfp mask:
> >       GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN
> >
> > alloc_pd() - likewise:
> >       GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN
> >
> > alloc_pdp() - very permissive gfp mask:
> >       GFP_KERNEL
> >
> >
> > So can all allocations in gen8_init_scratch() use
> >       GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN
>
> Yeah that looks all fairly broken tbh. The only thing I didn't know was
> that GFP_DMA32 wasn't a full gfp mask with reclaim bits set as needed. I
> guess it would be clearer if we use GFP_KERNEL | __GFP_DMA32 for these.
>
> The commit that introduced a lot of this, including I915_GFP_ALLOW_FAIL
> seems to be
>
> commit 1abb70f5955d1a9021f96359a2c6502ca569b68d
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Tue May 22 09:36:43 2018 +0100
>
>     drm/i915/gtt: Allow pagedirectory allocations to fail
>
> which used a selftest as justification, not real world workloads, so looks
> rather dubious.
>
> Adding Matt Auld to this thread, maybe he has ideas.

The latest code is quite different, but for both scratch and the
various paging structures it's now sharing the same GFP
flags(I915_GFP_ALLOW_FAIL). And for the actual backing page, which is
now a GEM object, we use i915_gem_object_get_pages_internal().

Not sure why scratch wants to be different, and I don't recall
anything funny. At first I thought it might have been related to
needing only one scratch page/directory etc which was then shared
between different VMs, but I don't think we had read-only support in
the driver at that point, so can't be that. But I guess once we did
add that seeing failures in init_scratch() was very unlikely, at least
until gen11+ arrived which then broke read-only support in the HW.

>
> Thanks, Daniel
>
> > ?
> >
> > E.g.
> >
> > ---
> > diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
> > index a12430187108..e862680b9c93 100644
> > --- a/drivers/gpu/drm/i915/i915_gem_gtt.c
> > +++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
> > @@ -792,7 +792,7 @@ alloc_pdp(struct i915_address_space *vm)
> >
> >         GEM_BUG_ON(!use_4lvl(vm));
> >
> > -       pdp = kzalloc(sizeof(*pdp), GFP_KERNEL);
> > +       pdp = kzalloc(sizeof(*pdp), I915_GFP_ALLOW_FAIL);
> >         if (!pdp)
> >                 return ERR_PTR(-ENOMEM);
> >
> > @@ -1262,7 +1262,7 @@ static int gen8_init_scratch(struct i915_address_space *vm)
> >  {
> >         int ret;
> >
> > -       ret = setup_scratch_page(vm, __GFP_HIGHMEM);
> > +       ret = setup_scratch_page(vm, GFP_KERNEL | __GFP_HIGHMEM);
> >         if (ret)
> >                 return ret;
> >
> > @@ -1972,7 +1972,7 @@ static int gen6_ppgtt_init_scratch(struct gen6_hw_ppgtt *ppgtt)
> >         u32 pde;
> >         int ret;
> >
> > -       ret = setup_scratch_page(vm, __GFP_HIGHMEM);
> > +       ret = setup_scratch_page(vm, GFP_KERNEL | __GFP_HIGHMEM);
> >         if (ret)
> >                 return ret;
> >
> > @@ -3078,7 +3078,7 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
> >                 return -ENOMEM;
> >         }
> >
> > -       ret = setup_scratch_page(&ggtt->vm, GFP_DMA32);
> > +       ret = setup_scratch_page(&ggtt->vm, GFP_KERNEL | GFP_DMA32);
> >         if (ret) {
> >                 DRM_ERROR("Scratch setup failed\n");
> >                 /* iounmap will also get called at remove, but meh */
> > ---
> >
> >
> >
> > It's quite similar on stable 5.4 - setup_scratch_page() uses restrictive
> > gfp mask again.
> >
> > ---
> > diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
> > index f614646ed3f9..99d78b1052df 100644
> > --- a/drivers/gpu/drm/i915/i915_gem_gtt.c
> > +++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
> > @@ -1378,7 +1378,7 @@ static int gen8_init_scratch(struct i915_address_space *vm)
> >                 return 0;
> >         }
> >
> > -       ret = setup_scratch_page(vm, __GFP_HIGHMEM);
> > +       ret = setup_scratch_page(vm, GFP_KERNEL | __GFP_HIGHMEM);
> >         if (ret)
> >                 return ret;
> >
> > @@ -1753,7 +1753,7 @@ static int gen6_ppgtt_init_scratch(struct gen6_ppgtt *ppgtt)
> >         struct i915_page_directory * const pd = ppgtt->base.pd;
> >         int ret;
> >
> > -       ret = setup_scratch_page(vm, __GFP_HIGHMEM);
> > +       ret = setup_scratch_page(vm, GFP_KERNEL | __GFP_HIGHMEM);
> >         if (ret)
> >                 return ret;
> >
> > @@ -2860,7 +2860,7 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
> >                 return -ENOMEM;
> >         }
> >
> > -       ret = setup_scratch_page(&ggtt->vm, GFP_DMA32);
> > +       ret = setup_scratch_page(&ggtt->vm, GFP_KERNEL | GFP_DMA32);
> >         if (ret) {
> >                 DRM_ERROR("Scratch setup failed\n");
> >                 /* iounmap will also get called at remove, but meh */
> > ---
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
