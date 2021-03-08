Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6525330C87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCHLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCHLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:37:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12993C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:37:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id w7so5840690wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=87FdZea+iM/dFONNBtDahO6WoHLjdEMssDM4fhYdjyg=;
        b=jlVBStZqs8WQUraCWHSwKyJt6Qve0w4rI9lCnnim7Qm6Zz9AyojesiTCvj9xOTpCa3
         zVtt7D2hb4XbqwjHCQ+Ka4aYXQSZOXo1dKJ0umpbH/ed/PgNWUbi+VfeZhCbz789/b89
         12XUqVbSmElzPSp3wkaniTtAe7eyT7bSuI1Kcb1NDxArgKuFyPNuverTuqkjKW4/6G5d
         YgVq6WclS8de7RzQnfvzg/o7BDodxBjUnAWYxPaurh1JaYSLEYXdCHpEFYV5pRKLbeyj
         E1ziPjYCWelATZ/n136yNY5/rLHwfm9Qz8uMYK60cvRAO/polXcD2qRPpau+caurITHV
         xwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87FdZea+iM/dFONNBtDahO6WoHLjdEMssDM4fhYdjyg=;
        b=ZkaU4ni59ktwUZr13LIEfSBELZkci56LCCBJTUgAR8j2KkYrmkYefrPHVbmaFWecfz
         OGvR+YH/Pr35E4qf/gpjILpXUg4+xFqHE/IjmrJ55cDbU6kDILmbccjyP5NSt49z4Wwc
         jb13PbARbFkfdGcjVTpXL63oD2dL+zIAAvAIoG/HOnc8ZKwO64rMXTTUhqGk6xGqJDoy
         J/Gp6lqt2Qg14XwkVfpkZyMc+q0R812Dse05dAhOp7Gyr6CFv3SHBcq6WOPjVSAmJPfp
         s4uy80BkBLqokpAU0gdqxvQKUcduOp5LCOs1Yi5D03Hm2JPB59yx641MYZFC9XTc5s6o
         qapg==
X-Gm-Message-State: AOAM532IGzQ40rEM9ml2dh5jGzcE20UIuEN75Ard327r6r+1dwjuEJyW
        Xhomf1BT5f9YeR31eTz8vB943Q==
X-Google-Smtp-Source: ABdhPJxeOjaQHVun5YbiM2V9rDOzEj+A75H/TI2A+ePs46qmxN3wauRLCAyHBGq9k5JV3IidA6cS5g==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr21264635wmi.127.1615203425609;
        Mon, 08 Mar 2021 03:37:05 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:9d1d:b6a0:d116:531b])
        by smtp.gmail.com with ESMTPSA id p14sm18252588wmc.30.2021.03.08.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:37:04 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:36:59 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kasan, mm: integrate slab init_on_alloc with HW_TAGS
Message-ID: <YEYMWynJ3SdDhV8u@elver.google.com>
References: <cover.1614989433.git.andreyknvl@google.com>
 <b8cc85d5cc9818b72e543d8034ce38acce0c0300.1614989433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cc85d5cc9818b72e543d8034ce38acce0c0300.1614989433.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:15AM +0100, Andrey Konovalov wrote:
> This change uses the previously added memory initialization feature
> of HW_TAGS KASAN routines for slab memory when init_on_alloc is enabled.
> 
> With this change, memory initialization memset() is no longer called
> when both HW_TAGS KASAN and init_on_alloc are enabled. Instead, memory
> is initialized in KASAN runtime.
> 
> The memory initialization memset() is moved into slab_post_alloc_hook()
> that currently directly follows the initialization loop. A new argument
> is added to slab_post_alloc_hook() that indicates whether to initialize
> the memory or not.
> 
> To avoid discrepancies with which memory gets initialized that can be
> caused by future changes, both KASAN hook and initialization memset()
> are put together and a warning comment is added.
> 
> Combining setting allocation tags with memory initialization improves
> HW_TAGS KASAN performance when init_on_alloc is enabled.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h |  8 ++++----
>  mm/kasan/common.c     |  4 ++--
>  mm/slab.c             | 28 +++++++++++++---------------
>  mm/slab.h             | 17 +++++++++++++----
>  mm/slub.c             | 27 +++++++++++----------------
>  5 files changed, 43 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 4c0f414a893b..bb756f6c73b5 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -216,12 +216,12 @@ static __always_inline void kasan_slab_free_mempool(void *ptr)
>  }
>  
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> -				       void *object, gfp_t flags);
> +				       void *object, gfp_t flags, bool init);
>  static __always_inline void * __must_check kasan_slab_alloc(
> -				struct kmem_cache *s, void *object, gfp_t flags)
> +		struct kmem_cache *s, void *object, gfp_t flags, bool init)
>  {
>  	if (kasan_enabled())
> -		return __kasan_slab_alloc(s, object, flags);
> +		return __kasan_slab_alloc(s, object, flags, init);
>  	return object;
>  }
>  
> @@ -306,7 +306,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
>  static inline void kasan_kfree_large(void *ptr) {}
>  static inline void kasan_slab_free_mempool(void *ptr) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> -				   gfp_t flags)
> +				   gfp_t flags, bool init)
>  {
>  	return object;
>  }
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6107c795611f..7ea747b18c26 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -428,7 +428,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object,
>  }
>  
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
> -					void *object, gfp_t flags)
> +					void *object, gfp_t flags, bool init)
>  {
>  	u8 tag;
>  	void *tagged_object;
> @@ -453,7 +453,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>  	 * Unpoison the whole object.
>  	 * For kmalloc() allocations, kasan_kmalloc() will do precise poisoning.
>  	 */
> -	kasan_unpoison(tagged_object, cache->object_size, false);
> +	kasan_unpoison(tagged_object, cache->object_size, init);
>  
>  	/* Save alloc info (if possible) for non-kmalloc() allocations. */
>  	if (kasan_stack_collection_enabled())
> diff --git a/mm/slab.c b/mm/slab.c
> index 51fd424e0d6d..936dd686dec9 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3216,6 +3216,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>  	void *ptr;
>  	int slab_node = numa_mem_id();
>  	struct obj_cgroup *objcg = NULL;
> +	bool init = false;
>  
>  	flags &= gfp_allowed_mask;
>  	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
> @@ -3254,12 +3255,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>    out:
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
> -
> -	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
> -		memset(ptr, 0, cachep->object_size);
> +	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out_hooks:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
>  	return ptr;
>  }
>  
> @@ -3301,6 +3300,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
>  	unsigned long save_flags;
>  	void *objp;
>  	struct obj_cgroup *objcg = NULL;
> +	bool init = false;
>  
>  	flags &= gfp_allowed_mask;
>  	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
> @@ -3317,12 +3317,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
>  	local_irq_restore(save_flags);
>  	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
>  	prefetchw(objp);
> -
> -	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
> -		memset(objp, 0, cachep->object_size);
> +	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
>  	return objp;
>  }
>  
> @@ -3542,18 +3540,18 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  
>  	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
>  
> -	/* Clear memory outside IRQ disabled section */
> -	if (unlikely(slab_want_init_on_alloc(flags, s)))
> -		for (i = 0; i < size; i++)
> -			memset(p[i], 0, s->object_size);
> -
> -	slab_post_alloc_hook(s, objcg, flags, size, p);
> +	/*
> +	 * memcg and kmem_cache debug support and memory initialization.
> +	 * Done outside of the IRQ disabled section.
> +	 */
> +	slab_post_alloc_hook(s, objcg, flags, size, p,
> +				slab_want_init_on_alloc(flags, s));
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
>  	local_irq_enable();
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false);
>  	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f58f68..0116a314cd21 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -506,15 +506,24 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  }
>  
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
> -					struct obj_cgroup *objcg,
> -					gfp_t flags, size_t size, void **p)
> +					struct obj_cgroup *objcg, gfp_t flags,
> +					size_t size, void **p, bool init)
>  {
>  	size_t i;
>  
>  	flags &= gfp_allowed_mask;
> +
> +	/*
> +	 * As memory initialization is integrated with hardware tag-based
> +	 * KASAN, kasan_slab_alloc and initialization memset must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 *
> +	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
> +	 */
>  	for (i = 0; i < size; i++) {
> -		p[i] = kasan_slab_alloc(s, p[i], flags);
> -		/* As p[i] might get tagged, call kmemleak hook after KASAN. */
> +		p[i] = kasan_slab_alloc(s, p[i], flags, init);
> +		if (p[i] && init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))

Same as the other patch, it seems awkward to have
!IS_ENABLED(CONFIG_KASAN_HW_TAGS) rather than a kasan_*() helper that
returns this information.

> +			memset(p[i], 0, s->object_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
>  	}
> diff --git a/mm/slub.c b/mm/slub.c
> index e26c274b4657..f53df23760e3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2822,6 +2822,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  	struct page *page;
>  	unsigned long tid;
>  	struct obj_cgroup *objcg = NULL;
> +	bool init = false;
>  
>  	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
>  	if (!s)
> @@ -2899,12 +2900,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  	}
>  
>  	maybe_wipe_obj_freeptr(s, object);
> -
> -	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
> -		memset(kasan_reset_tag(object), 0, s->object_size);
> +	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
>  
>  	return object;
>  }
> @@ -3356,20 +3355,16 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	c->tid = next_tid(c->tid);
>  	local_irq_enable();
>  
> -	/* Clear memory outside IRQ disabled fastpath loop */
> -	if (unlikely(slab_want_init_on_alloc(flags, s))) {
> -		int j;
> -
> -		for (j = 0; j < i; j++)
> -			memset(kasan_reset_tag(p[j]), 0, s->object_size);
> -	}
> -
> -	/* memcg and kmem_cache debug support */
> -	slab_post_alloc_hook(s, objcg, flags, size, p);
> +	/*
> +	 * memcg and kmem_cache debug support and memory initialization.
> +	 * Done outside of the IRQ disabled fastpath loop.
> +	 */
> +	slab_post_alloc_hook(s, objcg, flags, size, p,
> +				slab_want_init_on_alloc(flags, s));
>  	return i;
>  error:
>  	local_irq_enable();
> -	slab_post_alloc_hook(s, objcg, flags, i, p);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false);
>  	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> @@ -3579,7 +3574,7 @@ static void early_kmem_cache_node_alloc(int node)
>  	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
>  	init_tracking(kmem_cache_node, n);
>  #endif
> -	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
> +	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
>  	page->freelist = get_freepointer(kmem_cache_node, n);
>  	page->inuse = 1;
>  	page->frozen = 0;
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 
