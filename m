Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB00D40BF56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhIOFd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhIOFd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:33:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4DDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:32:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so1334041pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vfymLMfvSiPfGiyOQFicalit4S0Mmi/fVl/kbNU+ldI=;
        b=U5N1VEsyiXqqd4VdT4lRzl4RupY18P+MdilwSfcvvLQWqrN1AdAQZ5/q5CPQKBKu1J
         xqcYK++xnx43MmDNHZ+fVAsGunaHDKqRw6ei4bd3LLUPZgQlZFWsv2MhF5MYZggpRDO2
         2tbxSUgFZX3TSGntrNPmax3ycDzyX8aMn4S8Lk58DZnSfbWFyMZ991QaM9Yztox6WJNP
         AIBFd1SKNx14L5c8Ddol2OZ7nGgQ9Jrfa2m7Fcg4Kh2/X3yswDvLCuXYsNq2meNsC7sT
         VHTIuVqTG0HGN2PwnshqqUl+ZnpvSVPiQIQ/N5zooN3YYIR0guqN51RTHIGOoISKO2dC
         X6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vfymLMfvSiPfGiyOQFicalit4S0Mmi/fVl/kbNU+ldI=;
        b=l18MmAu7nHCP9OVePebLeC7NeaodkZYRUTMKm7ocAFmYb7+84tMHt06dYl4FupGO18
         6G3eDU4vflfNzK1Xa+m7mxj0oz1fK004d2zX0/VWiL62hY3fM+0mri0CQWGIn9WkUuhs
         CWtt8Bd8qNEOUwO35/HgaSCigUHmam9VAnEDWbpF8Qj+PPg2Jh6TMyXoQyqXcu3wcqhr
         IFLiwusqHlp9q737mNBFYvX/jJeT1kVtMYdGeeV7pi7/FfgtZY6TzC2tCWc6g3WsgzsV
         YZz/2SJjCSjFjuzagYabPjZzxMUtY9q71vEiDEF28pj/QrWRfKB4pWC2ntTYbFmfPwhb
         Li2A==
X-Gm-Message-State: AOAM530E4v17KC6BStKfLd7J6QcJfrsd8Io26P4+Mgp/3HAOi67ggyVD
        jCaDeZWEeuOkE0HqwJlfEWFDIw==
X-Google-Smtp-Source: ABdhPJw8h1iOxAM1Sf+3wquhVKRaqHzrlMlD0jd8FyowhheEUiKswW7F7PgS2CvydiyMCX6Oq6zo1A==
X-Received: by 2002:a17:902:860b:b0:13a:3809:5d92 with SMTP id f11-20020a170902860b00b0013a38095d92mr18032471plo.88.1631683959346;
        Tue, 14 Sep 2021 22:32:39 -0700 (PDT)
Received: from [2620:15c:17:3:22e5:69e1:debc:7973] ([2620:15c:17:3:22e5:69e1:debc:7973])
        by smtp.gmail.com with ESMTPSA id b27sm13029951pge.52.2021.09.14.22.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 22:32:38 -0700 (PDT)
Date:   Tue, 14 Sep 2021 22:32:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [RFC PATCH] mm, slub: change percpu partial accounting from
 objects to pages
In-Reply-To: <20210913170148.10992-1-vbabka@suse.cz>
Message-ID: <c167ab10-f970-15c-b0e-fd4484ddc637@google.com>
References: <20210913170148.10992-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021, Vlastimil Babka wrote:

> With CONFIG_SLUB_CPU_PARTIAL enabled, SLUB keeps a percpu list of partial
> slabs that can be promoted to cpu slab when the previous one is depleted,
> without accessing the shared partial list. A slab can be added to this list
> by 1) refill of an empty list from get_partial_node() - once we really have to
> access the shared partial list, we acquire multiple slabs to amortize the cost
> of locking, and 2) first free to a previously full slab - instead of putting
> the slab on a shared partial list, we can more cheaply freeze it and put it on
> the per-cpu list.
> 
> To control how large a percpu partial list can grow for a kmem cache,
> set_cpu_partial() calculates a target number of free objects on each cpu's
> percpu partial list, and this can be also set by the sysfs file cpu_partial.
> 
> However, the tracking of actual number of objects is imprecise, in order to
> limit overhead from cpu X freeing an objects to a slab on percpu partial
> list of cpu Y. Basically, the percpu partial slabs form a single linked list,
> and when we add a new slab to the list with current head "oldpage", we set in
> the struct page of the slab we're adding:
> 
> page->pages = oldpage->pages + 1; // this is precise
> page->pobjects = oldpage->pobjects + (page->objects - page->inuse);
> page->next = oldpage;
> 
> Thus the real number of free objects in the slab (objects - inuse) is only
> determined at the moment of adding the slab to the percpu partial list, and
> further freeing doesn't update the pobjects counter nor propagate it to the
> current list head. As Jann reports [1], this can easily lead to large
> inaccuracies, where the target number of objects (up to 30 by default) can
> translate to the same number of (empty) slab pages on the list. In case 2)
> above, we put a slab with 1 free object on the list, thus only increase
> page->pobjects by 1, even if there are subsequent frees on the same slab. Jann
> has noticed this in practice and so did we [2] when investigating significant
> increase of kmemcg usage after switching from SLAB to SLUB.
> 
> While this is no longer a problem in kmemcg context thanks to the accounting
> rewrite in 5.9, the memory waste is still not ideal and it's questionable
> whether it makes sense to perform free object count based control when object
> counts can easily become so much inaccurate. So this patch converts the
> accounting to be based on number of pages only (which is precise) and removes
> the page->pobjects field completely. This is also ultimately simpler.
> 

Thanks for the very detailed explanation, this is very timely for us.

I'm wondering if we should be concerned about the memory waste even being 
possible, though, now that we have the kmemcg accounting change?

IIUC, because we're accounting objects and not pages, then it *seems* like 
we could have a high number of pages but very few objects charged per 
page so this memory waste could go unconstrained from any kmemcg 
limitation.

> To retain the existing set_cpu_partial() heuristic, first calculate the target
> number of objects as previously, but then convert it to target number of pages
> by assuming the pages will be half-filled on average. This assumption might
> obviously also be inaccurate in practice, but cannot degrade to actual number of
> pages being equal to the target number of objects.
> 

I think that's a fair heuristic.

> We could also skip the intermediate step with target number of objects and
> rewrite the heuristic in terms of pages. However we still have the sysfs file
> cpu_partial which uses number of objects and could break existing users if it
> suddenly becomes number of pages, so this patch doesn't do that.
> 
> In practice, after this patch the heuristics limit the size of percpu partial
> list up to 2 pages. In case of a reported regression (which would mean some
> workload has benefited from the previous imprecise object based counting), we
> can tune the heuristics to get a better compromise within the new scheme, while
> still avoid the unexpectedly long percpu partial lists.
> 

Curious if you've tried netperf TCP_RR with this change?  This benchmark 
was the most significantly improved benchmark that I recall with the 
introduction of per-cpu partial slabs for SLUB.  If there are any 
regressions to be introduced by such an approach, I'm willing to bet that 
it would be surfaced with that benchmark.

Let me know if we can help in benchmarking.

> [1] https://lore.kernel.org/linux-mm/CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com/
> [2] https://lore.kernel.org/all/2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz/
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mm_types.h |  2 -
>  include/linux/slub_def.h | 13 +-----
>  mm/slub.c                | 89 ++++++++++++++++++++++++++--------------
>  3 files changed, 61 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7f8ee09c711f..68ffa064b7a8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -124,10 +124,8 @@ struct page {
>  					struct page *next;
>  #ifdef CONFIG_64BIT
>  					int pages;	/* Nr of pages left */
> -					int pobjects;	/* Approximate count */
>  #else
>  					short int pages;
> -					short int pobjects;
>  #endif
>  				};
>  			};
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 85499f0586b0..0fa751b946fa 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -99,6 +99,8 @@ struct kmem_cache {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
>  	unsigned int cpu_partial;
> +	/* Number of per cpu partial pages to keep around */
> +	unsigned int cpu_partial_pages;
>  #endif
>  	struct kmem_cache_order_objects oo;
>  
> @@ -141,17 +143,6 @@ struct kmem_cache {
>  	struct kmem_cache_node *node[MAX_NUMNODES];
>  };
>  
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -#define slub_cpu_partial(s)		((s)->cpu_partial)
> -#define slub_set_cpu_partial(s, n)		\
> -({						\
> -	slub_cpu_partial(s) = (n);		\
> -})
> -#else
> -#define slub_cpu_partial(s)		(0)
> -#define slub_set_cpu_partial(s, n)
> -#endif /* CONFIG_SLUB_CPU_PARTIAL */
> -
>  #ifdef CONFIG_SYSFS
>  #define SLAB_SUPPORTS_SYSFS
>  void sysfs_slab_unlink(struct kmem_cache *);
> diff --git a/mm/slub.c b/mm/slub.c
> index 3d2025f7163b..3757f31c5d97 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -414,6 +414,29 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
>  	return x.x & OO_MASK;
>  }
>  
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
> +{
> +	unsigned int nr_pages;
> +
> +	s->cpu_partial = nr_objects;
> +
> +	/*
> +	 * We take the number of objects but actually limit the number of
> +	 * pages on the per cpu partial list, in order to limit excessive
> +	 * growth of the list. For simplicity we assume that the pages will
> +	 * be half-full.
> +	 */
> +	nr_pages = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
> +	s->cpu_partial_pages = nr_pages;
> +}
> +#else
> +static inline void
> +slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
> +{
> +}
> +#endif /* CONFIG_SLUB_CPU_PARTIAL */
> +
>  /*
>   * Per slab locking using the pagelock
>   */
> @@ -2045,7 +2068,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
>   */
>  static inline void *acquire_slab(struct kmem_cache *s,
>  		struct kmem_cache_node *n, struct page *page,
> -		int mode, int *objects)
> +		int mode)
>  {
>  	void *freelist;
>  	unsigned long counters;
> @@ -2061,7 +2084,6 @@ static inline void *acquire_slab(struct kmem_cache *s,
>  	freelist = page->freelist;
>  	counters = page->counters;
>  	new.counters = counters;
> -	*objects = new.objects - new.inuse;
>  	if (mode) {
>  		new.inuse = page->objects;
>  		new.freelist = NULL;
> @@ -2099,9 +2121,8 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  {
>  	struct page *page, *page2;
>  	void *object = NULL;
> -	unsigned int available = 0;
>  	unsigned long flags;
> -	int objects;
> +	unsigned int partial_pages = 0;
>  
>  	/*
>  	 * Racy check. If we mistakenly see no partial slabs then we
> @@ -2119,11 +2140,10 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  		if (!pfmemalloc_match(page, gfpflags))
>  			continue;
>  
> -		t = acquire_slab(s, n, page, object == NULL, &objects);
> +		t = acquire_slab(s, n, page, object == NULL);
>  		if (!t)
>  			break;
>  
> -		available += objects;
>  		if (!object) {
>  			*ret_page = page;
>  			stat(s, ALLOC_FROM_PARTIAL);
> @@ -2131,10 +2151,15 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  		} else {
>  			put_cpu_partial(s, page, 0);
>  			stat(s, CPU_PARTIAL_NODE);
> +			partial_pages++;
>  		}
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
>  		if (!kmem_cache_has_cpu_partial(s)
> -			|| available > slub_cpu_partial(s) / 2)
> +			|| partial_pages > s->cpu_partial_pages / 2)
>  			break;
> +#else
> +		break;
> +#endif
>  
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -2539,14 +2564,13 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  	struct page *page_to_unfreeze = NULL;
>  	unsigned long flags;
>  	int pages = 0;
> -	int pobjects = 0;
>  
>  	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  
>  	oldpage = this_cpu_read(s->cpu_slab->partial);
>  
>  	if (oldpage) {
> -		if (drain && oldpage->pobjects > slub_cpu_partial(s)) {
> +		if (drain && oldpage->pages >= s->cpu_partial_pages) {
>  			/*
>  			 * Partial array is full. Move the existing set to the
>  			 * per node partial list. Postpone the actual unfreezing
> @@ -2555,16 +2579,13 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  			page_to_unfreeze = oldpage;
>  			oldpage = NULL;
>  		} else {
> -			pobjects = oldpage->pobjects;
>  			pages = oldpage->pages;
>  		}
>  	}
>  
>  	pages++;
> -	pobjects += page->objects - page->inuse;
>  
>  	page->pages = pages;
> -	page->pobjects = pobjects;
>  	page->next = oldpage;
>  
>  	this_cpu_write(s->cpu_slab->partial, page);
> @@ -3980,6 +4001,8 @@ static void set_min_partial(struct kmem_cache *s, unsigned long min)
>  static void set_cpu_partial(struct kmem_cache *s)
>  {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> +	unsigned int nr_objects;
> +
>  	/*
>  	 * cpu_partial determined the maximum number of objects kept in the
>  	 * per cpu partial lists of a processor.
> @@ -3989,24 +4012,22 @@ static void set_cpu_partial(struct kmem_cache *s)
>  	 * filled up again with minimal effort. The slab will never hit the
>  	 * per node partial lists and therefore no locking will be required.
>  	 *
> -	 * This setting also determines
> -	 *
> -	 * A) The number of objects from per cpu partial slabs dumped to the
> -	 *    per node list when we reach the limit.
> -	 * B) The number of objects in cpu partial slabs to extract from the
> -	 *    per node list when we run out of per cpu objects. We only fetch
> -	 *    50% to keep some capacity around for frees.
> +	 * For backwards compatibility reasons, this is determined as number
> +	 * of objects, even though we now limit maximum number of pages, see
> +	 * slub_set_cpu_partial()
>  	 */
>  	if (!kmem_cache_has_cpu_partial(s))
> -		slub_set_cpu_partial(s, 0);
> +		nr_objects = 0;
>  	else if (s->size >= PAGE_SIZE)
> -		slub_set_cpu_partial(s, 2);
> +		nr_objects = 2;
>  	else if (s->size >= 1024)
> -		slub_set_cpu_partial(s, 6);
> +		nr_objects = 6;
>  	else if (s->size >= 256)
> -		slub_set_cpu_partial(s, 13);
> +		nr_objects = 13;
>  	else
> -		slub_set_cpu_partial(s, 30);
> +		nr_objects = 30;
> +
> +	slub_set_cpu_partial(s, nr_objects);
>  #endif
>  }
>  
> @@ -5379,7 +5400,12 @@ SLAB_ATTR(min_partial);
>  
>  static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
>  {
> -	return sysfs_emit(buf, "%u\n", slub_cpu_partial(s));
> +	unsigned int nr_partial = 0;
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +	nr_partial = s->cpu_partial;
> +#endif
> +
> +	return sysfs_emit(buf, "%u\n", nr_partial);
>  }
>  
>  static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
> @@ -5450,12 +5476,12 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  
>  		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  
> -		if (page) {
> +		if (page)
>  			pages += page->pages;
> -			objects += page->pobjects;
> -		}
>  	}
>  
> +	/* Approximate half-full pages , see slub_set_cpu_partial() */
> +	objects = (pages * oo_objects(s->oo)) / 2;
>  	len += sysfs_emit_at(buf, len, "%d(%d)", objects, pages);
>  
>  #ifdef CONFIG_SMP
> @@ -5463,9 +5489,12 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  		struct page *page;
>  
>  		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
> -		if (page)
> +		if (page) {
> +			pages = READ_ONCE(page->pages);
> +			objects = (pages * oo_objects(s->oo)) / 2;
>  			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
> -					     cpu, page->pobjects, page->pages);
> +					     cpu, objects, pages);
> +		}
>  	}
>  #endif
>  	len += sysfs_emit_at(buf, len, "\n");
> -- 
> 2.33.0
> 
> 
