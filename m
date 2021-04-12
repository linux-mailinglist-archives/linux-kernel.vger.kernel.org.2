Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA235CEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbhDLQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbhDLQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:44:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56177C061344
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:36:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso7270953wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gunh+hu1ZDPddGOLmBt9qVFmAz2B0a627uCXn4xtBkY=;
        b=DcS2K04aKH40+WM215ezgNDsZ3NKXOk9HyqM8lTLgVfjV4ojsDVORcfq1ylr/LWcIK
         gFqmUGPdQo4jhbOGeOfzY6E6wTRi1knUyB14IvQcGNRMjpxmCQQo5i7zcb6ggZdB5uv9
         l1YWrofE4GOOz4F0gLdFyCo/4FPJr1Y+HcYdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gunh+hu1ZDPddGOLmBt9qVFmAz2B0a627uCXn4xtBkY=;
        b=s1cV2u7L1GgmXIjxGNMiCgtv4pNMUAtP6T+T+TNx6cN2pfVwUvqW/JRJcRDmg7WKoK
         DvVjIXrYCTOApemO+QbSmOMWtTQZ2Vsc5kSoppiSyflTToG4617esp2WVqEHTTMShcTp
         +LUWfU0fCr1myBZpIXZBWW2ObFtvN9WD8koLPF6AZSXfpuSoEqMAkuiv+9/Dl4TR3S29
         4xt/SFCWCymPIjIECtyNHx1agxp4JZPECZ6W9dCcrk96zCnptC8tzBjC74jMtcLSo3Dp
         fmOva44E9aiyPOfgTQ9oH4AFjaW/Jg8Rs+NQl9vltTSyQOGbDK1ULFTsnw/TcV1qKucv
         kiZQ==
X-Gm-Message-State: AOAM530Z7131naoe7pe2p4bcuVMBIYzBQwbUwTnNQ5ycK6vyfszRYrM8
        R5IcD4JfO7/DTeyO71STGkT16g==
X-Google-Smtp-Source: ABdhPJzn5o7o9pIbs8RDCfOQtJTd/DwzbN2+p9xuMhj7/AcD7iZeT+BjD0xlMeG1v2HLHEHHSzxhVA==
X-Received: by 2002:a1c:1f92:: with SMTP id f140mr15058wmf.108.1618245366994;
        Mon, 12 Apr 2021 09:36:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v3sm15633986wmj.25.2021.04.12.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:36:06 -0700 (PDT)
Date:   Mon, 12 Apr 2021 18:36:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] drm/msm: Swappable GEM objects
Message-ID: <YHR29HEs31jx2GGn@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>
References: <20210405174532.1441497-1-robdclark@gmail.com>
 <YG7l0LwVQ2s4Y0Sa@phenom.ffwll.local>
 <CAF6AEGsH2gbKv-Q04gRbjz=ue1TF7S_6DXa06bvYPcmYvG684w@mail.gmail.com>
 <YHRZA+WBbWrUdpAV@phenom.ffwll.local>
 <CAF6AEGv+ewxwtP4PN1G_gjdE0DW_LiukYbZoL-isFsGTRbcbOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGv+ewxwtP4PN1G_gjdE0DW_LiukYbZoL-isFsGTRbcbOQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 08:23:33AM -0700, Rob Clark wrote:
> On Mon, Apr 12, 2021 at 7:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Apr 08, 2021 at 08:23:42AM -0700, Rob Clark wrote:
> > > On Thu, Apr 8, 2021 at 4:15 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Mon, Apr 05, 2021 at 10:45:23AM -0700, Rob Clark wrote:
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > One would normally hope not to be under enough memory pressure to need
> > > > > to swap GEM objects to disk backed swap.  But memory backed zram swap
> > > > > (as enabled on chromebooks, for example) can actually be quite fast
> > > > > and useful on devices with less RAM.  On a 4GB device, opening up ~4
> > > > > memory intensive web pages (in separate windows rather than tabs, to try
> > > > > and prevent tab discard), I see ~500MB worth of GEM objects, of which
> > > > > maybe only 10% are active at any time, and with unpin/evict enabled,
> > > > > only about half resident (which is a number that gets much lower if you
> > > > > simulate extreme memory pressure).  Assuming a 2:1 compression ratio (I
> > > > > see a bit higher in practice, but cannot isolate swapped out GEM pages
> > > > > vs other), that is like having an extra 100+MB of RAM, or more under
> > > > > higher memory pressure.
> > > > >
> > > > > Rob Clark (8):
> > > > >   drm/msm: ratelimit GEM related WARN_ON()s
> > > > >   drm/msm: Reorganize msm_gem_shrinker_scan()
> > > > >   drm/msm: Clear msm_obj->sgt in put_pages()
> > > > >   drm/msm: Split iova purge and close
> > > > >   drm/msm: Add $debugfs/gem stats on resident objects
> > > > >   drm/msm: Track potentially evictable objects
> > > > >   drm/msm: Small msm_gem_purge() fix
> > > > >   drm/msm: Support evicting GEM objects to swap
> > > >
> > > > Given how much entertainement shrinkers are, should we aim for more common
> > > > code here?
> > > >
> > > > Christian has tons of fun with adding something like this for ttm (well
> > > > different shades of grey). i915 is going to adopt ttm, at least for
> > > > discrete.
> > > >
> > > > The locking is also an utter pain, and msm seems to still live a lot in
> > > > its own land here. I think as much as possible a standard approach here
> > > > would be really good, ideally maybe as building blocks shared between ttm
> > > > and gem-shmem drivers ...
> > >
> > > I don't disagree.. but also replacing the engines on an airplane
> > > mid-flight isn't a great option either.. ;-)
> > >
> > > The hard part (esp. wrt to locking) is tracking the state of a given
> > > bo.. ie. is it active, active+purgable, inactive+purgable,
> > > inactive+unpinnable, etc.  Currently the shmem helpers don't really
> > > provide anything here.  If they did, I suppose they could provide some
> > > shrinker helpers as well.  Unfortunately these days I barely have
> > > enough time for drm/msm, let alone bolting this onto the shmem
> > > helpers.  I would recommend that if someone wanted to do this, that
> > > they look at recent drm/msm shrinker patches that I've sent (ie. make
> > > shrinker->count() lockless, and drop the locks in shrinker->scan()
> > > body.. when the system is under heavy memory pressure, you start
> > > getting shrinker called from all the threads so contention for mm_lock
> > > can be a really bad problem)
> > >
> > > (Well, the other potential problem is that drm/msm has a lot of
> > > different possible iommu pairings across the generations, so there is
> > > some potential here to uncover exciting new bugs.. the locking at
> > > least is the same for all the generations and pretty easy to test with
> > > and without lockdep with some tests that push essentially all memory
> > > into swap)
> >
> > So what we aimed for with i915 and discrete gpu is to first align on
> > locking with dma_resv_lock for all buffer state, plus a bunch of
> > lru/allocator locks for lists and stuff.
> >
> > And then with more aligned locking, figure out how to maybe share more
> > code.
> >
> > The trouble is that right now neither shmem helpers, nor drivers using
> > them, are really using dma_resv_lock to protect their per-buffer state.
> 
> We are actually already using dma_resv_lock() since a few release
> cycles back.. msm_gem_lock() and friends are a wrapper around that
> from the migration away from using our own lock).. the mm_lock is
> symply protecting the lists, not the objects

Oh I thought there were still some warts here scanning through your
series. I guess I got confused, yay :-)

> > So yeah it's a bit an awkward situation, and I don't know myself really
> > how to get out of it. Lack of people with tons of free time doesn't help
> > much.
> >
> > So best case I think is that every time we touch helpers or drivers
> > locking in a big way, we check whether it's at least slightly going
> > towards dma_resv_lock or not. And at least make sure we're not going
> > backwards, and maybe not spin wheels at standstill.
> >
> > I guess my question is, what would be good to have to make sure we at
> > least all agree on the overall direction?
> 
> I guess if gem_shmem users aren't already using resv lock, moving in
> that directly would be a good idea.  Maybe it would make sense to
> build more object state tracking into gem_shmem helpers (ie. so you
> can know which buffers are active/purgable/unpinnable/etc without
> traversing a list of *all* gem objects).. that seems like pushing it
> more in the direction of being ttm-style frameworky compared to the
> simple helper API that it is now.  But maybe that is a good thing?

Moving shmem helpers is on the todo already.

https://dri.freedesktop.org/docs/drm/gpu/todo.html#move-buffer-object-locking-to-dma-resv-lock

And yes I think letting everyone reinvent their buffer locking scheme
wasn't the best idea. But otoh ttm was a monolith, and before Maarten
spent a lot of time pulling out dma_fence/resv and ww_mutex it really
wasn't reasonable to align with the design without pulling in the entire
monolith. The code improved a lot in this regard.

Also yeah I think pushing more object state into shmem helpers would
probably be good, but ideally not on the current locking ...
-Daniel

> 
> BR,
> -R
> 
> > -Daniel
> >
> > >
> > > BR,
> > > -R
> > >
> > > > -Daniel
> > > >
> > > > >
> > > > >  drivers/gpu/drm/msm/msm_drv.c          |   2 +-
> > > > >  drivers/gpu/drm/msm/msm_drv.h          |  13 ++-
> > > > >  drivers/gpu/drm/msm/msm_gem.c          | 155 +++++++++++++++++--------
> > > > >  drivers/gpu/drm/msm/msm_gem.h          |  68 +++++++++--
> > > > >  drivers/gpu/drm/msm/msm_gem_shrinker.c | 129 ++++++++++++--------
> > > > >  drivers/gpu/drm/msm/msm_gpu_trace.h    |  13 +++
> > > > >  6 files changed, 272 insertions(+), 108 deletions(-)
> > > > >
> > > > > --
> > > > > 2.30.2
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
