Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459E33EC31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCQJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCQJHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:07:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37607AC1E;
        Wed, 17 Mar 2021 09:07:12 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 5b239ed0;
        Wed, 17 Mar 2021 09:08:27 +0000 (UTC)
Date:   Wed, 17 Mar 2021 09:08:26 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        andreyknvl@google.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH mm] kfence: make compatible with kmemleak
Message-ID: <YFHHCi247iLcykDF@suse.de>
References: <20210317084740.3099921-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317084740.3099921-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:47:40AM +0100, Marco Elver wrote:
> Because memblock allocations are registered with kmemleak, the KFENCE
> pool was seen by kmemleak as one large object. Later allocations through
> kfence_alloc() that were registered with kmemleak via
> slab_post_alloc_hook() would then overlap and trigger a warning.
> Therefore, once the pool is initialized, we can remove (free) it from
> kmemleak again, since it should be treated as allocator-internal and be
> seen as "free memory".
> 
> The second problem is that kmemleak is passed the rounded size, and not
> the originally requested size, which is also the size of KFENCE objects.
> To avoid kmemleak scanning past the end of an object and trigger a
> KFENCE out-of-bounds error, fix the size if it is a KFENCE object.
> 
> For simplicity, to avoid a call to kfence_ksize() in
> slab_post_alloc_hook() (and avoid new IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)
> guard), just call kfence_ksize() in mm/kmemleak.c:create_object().
> 
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marco Elver <elver@google.com>

Tested-by: Luis Henriques <lhenriques@suse.de>

> ---
>  mm/kfence/core.c | 9 +++++++++
>  mm/kmemleak.c    | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index f7106f28443d..768dbd58170d 100644
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
> @@ -481,6 +482,14 @@ static bool __init kfence_init_pool(void)
>  		addr += 2 * PAGE_SIZE;
>  	}
>  
> +	/*
> +	 * The pool is live and will never be deallocated from this point on.
> +	 * Remove the pool object from the kmemleak object tree, as it would
> +	 * otherwise overlap with allocations returned by kfence_alloc(), which
> +	 * are registered with kmemleak through the slab post-alloc hook.
> +	 */
> +	kmemleak_free(__kfence_pool);
> +
>  	return true;
>  
>  err:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index c0014d3b91c1..fe6e3ae8e8c6 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -97,6 +97,7 @@
>  #include <linux/atomic.h>
>  
>  #include <linux/kasan.h>
> +#include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
>  
> @@ -589,7 +590,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	atomic_set(&object->use_count, 1);
>  	object->flags = OBJECT_ALLOCATED;
>  	object->pointer = ptr;
> -	object->size = size;
> +	object->size = kfence_ksize((void *)ptr) ?: size;
>  	object->excess_ref = 0;
>  	object->min_count = min_count;
>  	object->count = 0;			/* white color initially */
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
