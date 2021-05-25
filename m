Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5677D390641
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEYQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:55106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhEYQMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:12:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621959069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgZ/dpZNnufBx0dYLh6eb7HpVbEBDITjsBozJlpKOnE=;
        b=NT2CIqWF2jLSnl7DoeWU+7U9u0p2S6rsfmduIJmqg3aHR+8uGWPKOnr1EsL9rvgFWWqrp1
        J6JNz95YyvbjouR2XwfughkBuXh9/opTiB6IFCPrfkeHxSdF/6Yq3rVTziNbrgxWk9iw7b
        WZHCTpv5EnaYF9VhG0WDSOZcs19AjpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621959069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgZ/dpZNnufBx0dYLh6eb7HpVbEBDITjsBozJlpKOnE=;
        b=GVm5IBuDN4z9dPQ94/9up0itDHVOi7BGyOtS+YjlweLBagM8v2D4iySsfqiPwD4wdPKDwi
        wPcUPhc8bhu/2JCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E717FAEA8;
        Tue, 25 May 2021 16:11:08 +0000 (UTC)
Subject: Re: [RFC 26/26] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-27-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d6adf5e1-e80f-e198-67ef-f0917bda0a8f@suse.cz>
Date:   Tue, 25 May 2021 18:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524233946.20352-27-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 1:39 AM, Vlastimil Babka wrote:
> Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions of
> local_lock instead of plain local_irq_save/restore. On !PREEMPT_RT that's
> equivalent, with better lockdep visibility. On PREEMPT_RT that means better
> preemption.
> 
> Also update the comment about locking scheme in SLUB to reflect changes done
> by this series.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Hm just realized that this won't work on RT because unlike true irq disable, the
local_lock on RT won't protect from irq handler doing alloc/free changing the
critical fields in kmem_cache_cpu in the lockless fastpath, which doesn't take
the local_lock.

Good that I've put the local_lock patch last, I guess. The reduced irq disabled
sections should still help.

> ---
>  include/linux/slub_def.h |  2 +
>  mm/slub.c                | 90 ++++++++++++++++++++++++++++------------
>  2 files changed, 66 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index dcde82a4434c..b5bcac29b979 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -10,6 +10,7 @@
>  #include <linux/kfence.h>
>  #include <linux/kobject.h>
>  #include <linux/reciprocal_div.h>
> +#include <linux/local_lock.h>
>  
>  enum stat_item {
>  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> @@ -41,6 +42,7 @@ enum stat_item {
>  	NR_SLUB_STAT_ITEMS };
>  
>  struct kmem_cache_cpu {
> +	local_lock_t lock;	/* Protects the fields below except stat */
>  	void **freelist;	/* Pointer to next available object */
>  	unsigned long tid;	/* Globally unique transaction id */
>  	struct page *page;	/* The slab from which we are allocating */
> diff --git a/mm/slub.c b/mm/slub.c
> index 8818c210cb97..5455c6bda997 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -43,13 +43,22 @@
>  /*
>   * Lock order:
>   *   1. slab_mutex (Global Mutex)
> - *   2. node->list_lock
> + *   2. node->list_lock (Spinlock)
> + *	OR
> + *	kmem_cache->cpu_slab->lock (Local lock)
>   *   3. slab_lock(page) (Only on some arches and for debugging)
> + *   4. object_map_lock (Only for debugging)
>   *
>   *   slab_mutex
>   *
>   *   The role of the slab_mutex is to protect the list of all the slabs
>   *   and to synchronize major metadata changes to slab cache structures.
> + *   Also synchronizes memory hotplug callbacks.
> + *
> + *   slab_lock
> + *
> + *   The slab_lock is a wrapper around the page lock, thus it is a bit
> + *   spinlock.
>   *
>   *   The slab_lock is only used for debugging and on arches that do not
>   *   have the ability to do a cmpxchg_double. It only protects:
> @@ -65,6 +74,8 @@
>   *   froze the slab is the only one that can retrieve the objects from the
>   *   page's freelist.
>   *
> + *   list_lock
> + *
>   *   The list_lock protects the partial and full list on each node and
>   *   the partial slab counter. If taken then no new slabs may be added or
>   *   removed from the lists nor make the number of partial slabs be modified.
> @@ -76,10 +87,33 @@
>   *   slabs, operations can continue without any centralized lock. F.e.
>   *   allocating a long series of objects that fill up slabs does not require
>   *   the list lock.
> - *   Interrupts are disabled during allocation and deallocation in order to
> - *   make the slab allocator safe to use in the context of an irq. In addition
> - *   interrupts are disabled to ensure that the processor does not change
> - *   while handling per_cpu slabs, due to kernel preemption.
> + *
> + *   cpu_slab->lock local lock
> + *
> + *   This locks protect slowpath manipulation of all kmem_cache_cpu fields
> + *   except the stat counters. This is a percpu structure manipulated only by
> + *   the local cpu, so the lock protects against being preempted or interrupted
> + *   by an irq. Fast path operations rely on lockless operations instead.
> + *
> + *   lockless fastpaths
> + *
> + *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_free())
> + *   are fully lockless when satisfied from the percpu slab (and when
> + *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
> + *   They also don't disable preemption or migration or irqs. They rely on
> + *   the transaction id (tid) field to detect being preempted or moved to
> + *   another cpu.
> + *
> + *   irq, preemption, migration considerations
> + *
> + *   Interrupts are disabled as part of list_lock or local_lock operations, or
> + *   around the slab_lock operation, in order to make the slab allocator safe
> + *   to use in the context of an irq.
> + *
> + *   In addition, migration is disabled in the allocation slowpath, bulk
> + *   allocation, and put_cpu_partial(), so that the local cpu doesn't change in
> + *   the process and e.g. the kmem_cache_cpu pointer doesn't have to be
> + *   revalidated in each section protected by the local lock.
>   *
>   * SLUB assigns one slab for allocation to each processor.
>   * Allocations only occur from these slabs called cpu slabs.
> @@ -427,7 +461,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
>  			page->freelist = freelist_new;
>  			page->counters = counters_new;
>  			slab_unlock(page);
> -			local_irq_restore(flags);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  			return true;
>  		}
>  		slab_unlock(page);
> @@ -2157,9 +2191,13 @@ static inline void note_cmpxchg_failure(const char *n,
>  static void init_kmem_cache_cpus(struct kmem_cache *s)
>  {
>  	int cpu;
> +	struct kmem_cache_cpu *c;
>  
> -	for_each_possible_cpu(cpu)
> -		per_cpu_ptr(s->cpu_slab, cpu)->tid = init_tid(cpu);
> +	for_each_possible_cpu(cpu) {
> +		c = per_cpu_ptr(s->cpu_slab, cpu);
> +		local_lock_init(&c->lock);
> +		c->tid = init_tid(cpu);
> +	}
>  }
>  
>  /*
> @@ -2708,9 +2746,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto deactivate_slab;
>  
>  	/* must check again c->page in case of IRQ */
> -	local_irq_save(flags);
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  	if (unlikely(page != c->page)) {
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		goto reread_page;
>  	}
>  	freelist = c->freelist;
> @@ -2721,7 +2759,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  	if (!freelist) {
>  		c->page = NULL;
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		stat(s, DEACTIVATE_BYPASS);
>  		goto new_slab;
>  	}
> @@ -2737,37 +2775,37 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	VM_BUG_ON(!c->page->frozen);
>  	c->freelist = get_freepointer(s, freelist);
>  	c->tid = next_tid(c->tid);
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  	return freelist;
>  
>  deactivate_slab:
> -	local_irq_save(flags);
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  	if (page != c->page) {
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		goto reread_page;
>  	}
>  	freelist = c->freelist;
>  	c->page = NULL;
>  	c->freelist = NULL;
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  	deactivate_slab(s, page, freelist);
>  
>  new_slab:
>  
>  	if (slub_percpu_partial(c)) {
> -		local_irq_save(flags);
> +		local_lock_irqsave(&s->cpu_slab->lock, flags);
>  		if (unlikely(c->page)) {
> -			local_irq_restore(flags);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  			goto reread_page;
>  		}
>  		if (unlikely(!slub_percpu_partial(c))) { /* stolen by IRQ? */
> -			local_irq_restore(flags);
> +			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  			goto new_objects;
>  		}
>  
>  		page = c->page = slub_percpu_partial(c);
>  		slub_set_percpu_partial(c, page);
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		stat(s, CPU_PARTIAL_ALLOC);
>  		goto redo;
>  	}
> @@ -2820,7 +2858,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto return_single;
>  
>  retry_load_page:
> -	local_irq_save(flags);
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  	if (unlikely(c->page)) {
>  		void *flush_freelist = c->freelist;
>  		struct page *flush_page = c->page;
> @@ -2829,7 +2867,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		c->freelist = NULL;
>  		c->tid = next_tid(c->tid);
>  
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  
>  		deactivate_slab(s, flush_page, flush_freelist);
>  
> @@ -3389,7 +3427,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 */
>  	migrate_disable();
>  	c = this_cpu_ptr(s->cpu_slab);
> -	local_irq_disable();
> +	local_lock_irq(&s->cpu_slab->lock);
>  
>  	for (i = 0; i < size; i++) {
>  		void *object = kfence_alloc(s, s->object_size, flags);
> @@ -3410,7 +3448,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  			 */
>  			c->tid = next_tid(c->tid);
>  
> -			local_irq_enable();
> +			local_unlock_irq(&s->cpu_slab->lock);
>  
>  			/*
>  			 * Invoking slow path likely have side-effect
> @@ -3424,7 +3462,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  			c = this_cpu_ptr(s->cpu_slab);
>  			maybe_wipe_obj_freeptr(s, p[i]);
>  
> -			local_irq_disable();
> +			local_lock_irq(&s->cpu_slab->lock);
>  
>  			continue; /* goto for-loop */
>  		}
> @@ -3433,7 +3471,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  		maybe_wipe_obj_freeptr(s, p[i]);
>  	}
>  	c->tid = next_tid(c->tid);
> -	local_irq_enable();
> +	local_unlock_irq(&s->cpu_slab->lock);
>  	migrate_enable();
>  
>  	/*
> @@ -3444,7 +3482,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  				slab_want_init_on_alloc(flags, s));
>  	return i;
>  error:
> -	local_irq_enable();
> +	local_unlock_irq(&s->cpu_slab->lock);
>  	slab_post_alloc_hook(s, objcg, flags, i, p, false);
>  	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
> 

