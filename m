Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9744E33DCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhCPSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbhCPSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:47:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:47:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t9so7970251wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/z2fIfiSMbNLDzKmZ65SrMYqzt+vbhT5AuPhg7JmU1A=;
        b=rM3fdiR93sBuVsIUeAPdbUaLcSxhzpqK+Q3E4pVvgl1ggkrA4Fg5Ww3gaeX/Rtz3FR
         Zn8PL9Ieo8iIS9dWTjZ2KO8dFem4AgtBv+shAVHwk3zkRr4hI+bnRCHe30OO/KD1j/v9
         zcV+oZaB2vEttpmraquxvw7W2uFx3vvWNuAVlSEMaz6HRefxpFtv+Z3Y+fxKA0dgsq1j
         UhATV7ovUa/r7Ka873Y0A70v2TtCtRHaB0bT42iHD9fZzVv5/zqkSCpuUWGQtReV3w8k
         OfiVLNQPw8M9SFLHxgqbpWCFdNGt6+155RuIug6fCxegjYlTsUfD3riqQ79j1kZwkdmx
         ooqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/z2fIfiSMbNLDzKmZ65SrMYqzt+vbhT5AuPhg7JmU1A=;
        b=WY0peN96aRGmTPYfvwR6togQKZIUtG0iioTjZ9qcerVVWVFnwRump861TRGx3RUorz
         Pb0Yv67CIIJl8J4xBpsWsxZx85sH3cKfBRXEIBvMalslxH1d38to/Ee4pwOmo8bqAYtK
         TlFBjW1RlOFlqsOurkNFaE/WamicX8dADEzg6zLlRd+rnOg53tUc4OHyVJ/TeDSpOt5Y
         jg//vcOASsRCEKceqirO9aUxcbPFdHvWmVRy86NgM10eonhmGmwLrsx1AabURvUmxz2+
         AxGeJ0NRQIQNCbSrHXArgw9ZELcm1RN6rZ11fv/FdQlUZSAWIdUATgOjnqX3y08edWz3
         64nQ==
X-Gm-Message-State: AOAM532wcEwQrbvLjREZrCabVsDeOKXUvc3KxBIXzEckP706eZn2o7qz
        oF3tZ5u/aQRzXD0N5oTsydCRVw==
X-Google-Smtp-Source: ABdhPJyh+0bySp8rsXwvlCfrJY4z8ySax7xDgPD2zWP5JPV+1fSVVvyCXJOniHvdTY4W32t5qJ4HnA==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr438331wre.386.1615920430858;
        Tue, 16 Mar 2021 11:47:10 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:1d09:9676:5eaa:550])
        by smtp.gmail.com with ESMTPSA id 12sm191075wmw.43.2021.03.16.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:47:10 -0700 (PDT)
Date:   Tue, 16 Mar 2021 19:47:00 +0100
From:   Marco Elver <elver@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issue with kfence and kmemleak
Message-ID: <YFD9JEdQNI1TqSuL@elver.google.com>
References: <YFDf6iKH1p/jGnM0@suse.de>
 <YFDrGL45JxFHyajD@elver.google.com>
 <20210316181938.GA28565@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316181938.GA28565@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:19PM +0000, Catalin Marinas wrote:
> On Tue, Mar 16, 2021 at 06:30:00PM +0100, Marco Elver wrote:
> > On Tue, Mar 16, 2021 at 04:42PM +0000, Luis Henriques wrote:
> > > This is probably a known issue, but just in case: looks like it's not
> > > possible to use kmemleak when kfence is enabled:
> > > 
> > > [    0.272136] kmemleak: Cannot insert 0xffff888236e02f00 into the object search tree (overlaps existing)
> > > [    0.272136] CPU: 0 PID: 8 Comm: kthreadd Not tainted 5.12.0-rc3+ #92
> > > [    0.272136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> > > [    0.272136] Call Trace:
> > > [    0.272136]  dump_stack+0x6d/0x89
> > > [    0.272136]  create_object.isra.0.cold+0x40/0x62
> > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > [    0.272136]  kmem_cache_alloc_trace+0x110/0x2f0
> > > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > > [    0.272136]  kthread+0x3f/0x150
> > > [    0.272136]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> > > [    0.272136]  ? __kthread_bind_mask+0x60/0x60
> > > [    0.272136]  ret_from_fork+0x22/0x30
> > > [    0.272136] kmemleak: Kernel memory leak detector disabled
> > > [    0.272136] kmemleak: Object 0xffff888236e00000 (size 2097152):
> > > [    0.272136] kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> > > [    0.272136] kmemleak:   min_count = 0
> > > [    0.272136] kmemleak:   count = 0
> > > [    0.272136] kmemleak:   flags = 0x1
> > > [    0.272136] kmemleak:   checksum = 0
> > > [    0.272136] kmemleak:   backtrace:
> > > [    0.272136]      memblock_alloc_internal+0x6d/0xb0
> > > [    0.272136]      memblock_alloc_try_nid+0x6c/0x8a
> > > [    0.272136]      kfence_alloc_pool+0x26/0x3f
> > > [    0.272136]      start_kernel+0x242/0x548
> > > [    0.272136]      secondary_startup_64_no_verify+0xb0/0xbb
> > > 
> > > I've tried the hack below but it didn't really helped.  Obviously I don't
> > > really understand what's going on ;-)  But I think the reason for this
> > > patch not working as (I) expected is because kfence is initialised
> > > *before* kmemleak.
> > > 
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > index 3b8ec938470a..b4ffd7695268 100644
> > > --- a/mm/kfence/core.c
> > > +++ b/mm/kfence/core.c
> > > @@ -631,6 +631,9 @@ void __init kfence_alloc_pool(void)
> > >  
> > >  	if (!__kfence_pool)
> > >  		pr_err("failed to allocate pool\n");
> > > +	kmemleak_no_scan(__kfence_pool);
> > >  }
> > 
> > Can you try the below patch?
> > 
> > Thanks,
> > -- Marco
> > 
> > ------ >8 ------
> > 
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index f7106f28443d..5891019721f6 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/kcsan-checks.h>
> >  #include <linux/kfence.h>
> > +#include <linux/kmemleak.h>
> >  #include <linux/list.h>
> >  #include <linux/lockdep.h>
> >  #include <linux/memblock.h>
> > @@ -481,6 +482,13 @@ static bool __init kfence_init_pool(void)
> >  		addr += 2 * PAGE_SIZE;
> >  	}
> >  
> > +	/*
> > +	 * The pool is live and will never be deallocated from this point on;
> > +	 * tell kmemleak this is now free memory, so that later allocations can
> > +	 * correctly be tracked.
> > +	 */
> > +	kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> 
> I presume this pool does not refer any objects that are only tracked
> through pool pointers.

No, at this point this memory should not have been touched by anything.

> kmemleak_free() (or *_free_part) should work, no need for the _phys
> variant (which converts it back with __va).

Will fix.

> Since we normally use kmemleak_ignore() (or no_scan) for objects we
> don't care about, I'd expand the comment that this object needs to be
> removed from the kmemleak object tree as it will overlap with subsequent
> allocations handled by kfence which return pointers within this range.

One thing I've just run into: "BUG: KFENCE: out-of-bounds read in
scan_block+0x6b/0x170 mm/kmemleak.c:1244"

Probably because kmemleak is passed the rounded size for the size-class,
and not the real allocation size. Can this be fixed with
kmemleak_ignore() only called on the KFENCE guard pages?

I'd like kmemleak to scan the valid portion of an object allocated
through KFENCE, but no further than that.

Or do we need to fix the size if it's a kfence object:

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c0014d3b91c1..fe6e3ae8e8c6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -589,7 +590,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
-	object->size = size;
+	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
 	object->min_count = min_count;
 	object->count = 0;			/* white color initially */


The alternative is to call kfence_ksize() in slab_post_alloc_hook() when
calling kmemleak_alloc.

Do you have a preference?

Thanks,
-- Marco
