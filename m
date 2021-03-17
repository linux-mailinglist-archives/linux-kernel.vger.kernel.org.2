Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0607633EBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCQItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCQIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:48:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u6so33701272oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2lDZOKUu2tocdd1TqzDB8RH8osZOQXjtwD5b7bHNt4=;
        b=UpCpQm6qKSJkJiHvOx7FD4SHIKiovDPynsKTnF3tkv/mMNpkmk7QyL/dMwIl8BiySr
         L+8jPkp/ViSktLLwx3+q4f6AiHpityLpU8THJqQTmBp0eQBjE4JHZf7H5xSKcEKzaD3E
         lhqVEARaTRNvP5VOODqZQnr2LK24iC8MFnTVAtfTyWAF7rBnYJd1ZJ4fWDcCLjRFtfDj
         lGKy+IwSfyfZlbeq/HthsYdnqhwHE+2HPI5Zv3kGv8PLUsuQ676IAkcEiQWfBQi4aQtO
         IgZjfoIDsg97pd9BOcp/ur1uuKWm76UEPKZPSpejWqyJ/HQ807+WxgI4jWRl3Gwizj+R
         SiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2lDZOKUu2tocdd1TqzDB8RH8osZOQXjtwD5b7bHNt4=;
        b=VFqdOv6hDjMRZtuVSu4qdZWfkNswyWep78wrmdIik0AvRHbRowJvxcJxjDjleJhdwD
         eC+4PEPWV/LycKG4sgmiY3b777Q5d0UWZVGPrdPj+2QmdL9t5Fgi7nCBANvHd31ydjXi
         QG/wSlaVBAkBVhuUL7I2rebcuFHdj6wBL0QGyjLPx9octR3cL/3K2IycpldNHjbCWlwg
         4vX5Uk9L/Ht2ZROoUER8j5Uua/TWKpH2aBTHi58TGS1fxThUFByOqnJbQbt9ESKK77ex
         WAYZgEZtOj+oD32zwWshaLlApk3U6eowzh2kdiSYkOyuajvu/FSzR5/vwVUSRir1JhGa
         vt7w==
X-Gm-Message-State: AOAM533/u8iVKIGffAPh1qtqWGnHh9GMvHs9cvA7Ytot3MX87K6DLpgR
        Ax4j18LxQrCM/V3Av9XoDMokb+zxMZXSlGWBmCbwqg==
X-Google-Smtp-Source: ABdhPJxHbGXhVE3T9q0cm84qel9MN7Cu/iBsdF2YPv4yxcSaG/6axfSHVO4ngTggeWGqkRfTQQFWfvpsMv2U/pG+E4A=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr1990854oif.121.1615970916125;
 Wed, 17 Mar 2021 01:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <YFDf6iKH1p/jGnM0@suse.de> <YFDrGL45JxFHyajD@elver.google.com>
 <20210316181938.GA28565@arm.com> <YFD9JEdQNI1TqSuL@elver.google.com> <YFHApOWeDRWncdrQ@suse.de>
In-Reply-To: <YFHApOWeDRWncdrQ@suse.de>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Mar 2021 09:48:24 +0100
Message-ID: <CANpmjNMxg-unHe2C5BaW1yaSpLOvms6rn2beFz04EwB_UepDfg@mail.gmail.com>
Subject: Re: Issue with kfence and kmemleak
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 09:39, Luis Henriques <lhenriques@suse.de> wrote:
> On Tue, Mar 16, 2021 at 07:47:00PM +0100, Marco Elver wrote:
> > On Tue, Mar 16, 2021 at 06:19PM +0000, Catalin Marinas wrote:
> > > On Tue, Mar 16, 2021 at 06:30:00PM +0100, Marco Elver wrote:
> > > > On Tue, Mar 16, 2021 at 04:42PM +0000, Luis Henriques wrote:
> > > > > This is probably a known issue, but just in case: looks like it's not
> > > > > possible to use kmemleak when kfence is enabled:
> > > > >
> > > > > [    0.272136] kmemleak: Cannot insert 0xffff888236e02f00 into the object search tree (overlaps existing)
> > > > > [    0.272136] CPU: 0 PID: 8 Comm: kthreadd Not tainted 5.12.0-rc3+ #92
> > > > > [    0.272136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> > > > > [    0.272136] Call Trace:
> > > > > [    0.272136]  dump_stack+0x6d/0x89
> > > > > [    0.272136]  create_object.isra.0.cold+0x40/0x62
> > > > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > > > [    0.272136]  kmem_cache_alloc_trace+0x110/0x2f0
> > > > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > > > [    0.272136]  kthread+0x3f/0x150
> > > > > [    0.272136]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> > > > > [    0.272136]  ? __kthread_bind_mask+0x60/0x60
> > > > > [    0.272136]  ret_from_fork+0x22/0x30
> > > > > [    0.272136] kmemleak: Kernel memory leak detector disabled
> > > > > [    0.272136] kmemleak: Object 0xffff888236e00000 (size 2097152):
> > > > > [    0.272136] kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> > > > > [    0.272136] kmemleak:   min_count = 0
> > > > > [    0.272136] kmemleak:   count = 0
> > > > > [    0.272136] kmemleak:   flags = 0x1
> > > > > [    0.272136] kmemleak:   checksum = 0
> > > > > [    0.272136] kmemleak:   backtrace:
> > > > > [    0.272136]      memblock_alloc_internal+0x6d/0xb0
> > > > > [    0.272136]      memblock_alloc_try_nid+0x6c/0x8a
> > > > > [    0.272136]      kfence_alloc_pool+0x26/0x3f
> > > > > [    0.272136]      start_kernel+0x242/0x548
> > > > > [    0.272136]      secondary_startup_64_no_verify+0xb0/0xbb
> > > > >
> > > > > I've tried the hack below but it didn't really helped.  Obviously I don't
> > > > > really understand what's going on ;-)  But I think the reason for this
> > > > > patch not working as (I) expected is because kfence is initialised
> > > > > *before* kmemleak.
> > > > >
> > > > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > > > index 3b8ec938470a..b4ffd7695268 100644
> > > > > --- a/mm/kfence/core.c
> > > > > +++ b/mm/kfence/core.c
> > > > > @@ -631,6 +631,9 @@ void __init kfence_alloc_pool(void)
> > > > >
> > > > >         if (!__kfence_pool)
> > > > >                 pr_err("failed to allocate pool\n");
> > > > > +       kmemleak_no_scan(__kfence_pool);
> > > > >  }
> > > >
> > > > Can you try the below patch?
> > > >
> > > > Thanks,
> > > > -- Marco
> > > >
> > > > ------ >8 ------
> > > >
> > > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > > index f7106f28443d..5891019721f6 100644
> > > > --- a/mm/kfence/core.c
> > > > +++ b/mm/kfence/core.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/debugfs.h>
> > > >  #include <linux/kcsan-checks.h>
> > > >  #include <linux/kfence.h>
> > > > +#include <linux/kmemleak.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/lockdep.h>
> > > >  #include <linux/memblock.h>
> > > > @@ -481,6 +482,13 @@ static bool __init kfence_init_pool(void)
> > > >           addr += 2 * PAGE_SIZE;
> > > >   }
> > > >
> > > > + /*
> > > > +  * The pool is live and will never be deallocated from this point on;
> > > > +  * tell kmemleak this is now free memory, so that later allocations can
> > > > +  * correctly be tracked.
> > > > +  */
> > > > + kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> > >
> > > I presume this pool does not refer any objects that are only tracked
> > > through pool pointers.
> >
> > No, at this point this memory should not have been touched by anything.
> >
> > > kmemleak_free() (or *_free_part) should work, no need for the _phys
> > > variant (which converts it back with __va).
> >
> > Will fix.
> >
> > > Since we normally use kmemleak_ignore() (or no_scan) for objects we
> > > don't care about, I'd expand the comment that this object needs to be
> > > removed from the kmemleak object tree as it will overlap with subsequent
> > > allocations handled by kfence which return pointers within this range.
> >
> > One thing I've just run into: "BUG: KFENCE: out-of-bounds read in
> > scan_block+0x6b/0x170 mm/kmemleak.c:1244"
>
> FWIW, I just saw this as well.  It doesn't happen every time, but yeah I
> missed it in my initial testing.

I've just sent the patch, please re-test if you can:
https://lkml.kernel.org/r/20210317084740.3099921-1-elver@google.com

Thanks!
