Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BE33DB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhCPRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:41:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233930AbhCPRlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:41:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D90A1AC1F;
        Tue, 16 Mar 2021 17:41:05 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id f6ee1319;
        Tue, 16 Mar 2021 17:42:20 +0000 (UTC)
Date:   Tue, 16 Mar 2021 17:42:20 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issue with kfence and kmemleak
Message-ID: <YFDt/PunpQydUAq/@suse.de>
References: <YFDf6iKH1p/jGnM0@suse.de>
 <YFDrGL45JxFHyajD@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFDrGL45JxFHyajD@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:30:00PM +0100, Marco Elver wrote:
> On Tue, Mar 16, 2021 at 04:42PM +0000, Luis Henriques wrote:
> > Hi!
> > 
> > This is probably a known issue, but just in case: looks like it's not
> > possible to use kmemleak when kfence is enabled:
> 
> Thanks for spotting this.
> 
> > [    0.272136] kmemleak: Cannot insert 0xffff888236e02f00 into the object search tree (overlaps existing)
> > [    0.272136] CPU: 0 PID: 8 Comm: kthreadd Not tainted 5.12.0-rc3+ #92
> > [    0.272136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> > [    0.272136] Call Trace:
> > [    0.272136]  dump_stack+0x6d/0x89
> > [    0.272136]  create_object.isra.0.cold+0x40/0x62
> > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > [    0.272136]  kmem_cache_alloc_trace+0x110/0x2f0
> > [    0.272136]  ? process_one_work+0x5a0/0x5a0
> > [    0.272136]  kthread+0x3f/0x150
> > [    0.272136]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> > [    0.272136]  ? __kthread_bind_mask+0x60/0x60
> > [    0.272136]  ret_from_fork+0x22/0x30
> > [    0.272136] kmemleak: Kernel memory leak detector disabled
> > [    0.272136] kmemleak: Object 0xffff888236e00000 (size 2097152):
> > [    0.272136] kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> > [    0.272136] kmemleak:   min_count = 0
> > [    0.272136] kmemleak:   count = 0
> > [    0.272136] kmemleak:   flags = 0x1
> > [    0.272136] kmemleak:   checksum = 0
> > [    0.272136] kmemleak:   backtrace:
> > [    0.272136]      memblock_alloc_internal+0x6d/0xb0
> > [    0.272136]      memblock_alloc_try_nid+0x6c/0x8a
> > [    0.272136]      kfence_alloc_pool+0x26/0x3f
> > [    0.272136]      start_kernel+0x242/0x548
> > [    0.272136]      secondary_startup_64_no_verify+0xb0/0xbb
> > 
> > I've tried the hack below but it didn't really helped.  Obviously I don't
> > really understand what's going on ;-)  But I think the reason for this
> > patch not working as (I) expected is because kfence is initialised
> > *before* kmemleak.
> > 
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 3b8ec938470a..b4ffd7695268 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -631,6 +631,9 @@ void __init kfence_alloc_pool(void)
> >  
> >  	if (!__kfence_pool)
> >  		pr_err("failed to allocate pool\n");
> > +	kmemleak_no_scan(__kfence_pool);
> >  }
> 
> Can you try the below patch?

Yep, that seems to fix the issue.  Feel free to add my Tested-by.  Thanks!

Cheers,
--
Luís

> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index f7106f28443d..5891019721f6 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -12,6 +12,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/kcsan-checks.h>
>  #include <linux/kfence.h>
> +#include <linux/kmemleak.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
>  #include <linux/memblock.h>
> @@ -481,6 +482,13 @@ static bool __init kfence_init_pool(void)
>  		addr += 2 * PAGE_SIZE;
>  	}
>  
> +	/*
> +	 * The pool is live and will never be deallocated from this point on;
> +	 * tell kmemleak this is now free memory, so that later allocations can
> +	 * correctly be tracked.
> +	 */
> +	kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> +
>  	return true;
>  
>  err:
