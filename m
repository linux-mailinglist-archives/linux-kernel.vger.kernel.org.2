Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4737FAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhEMPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:42:59 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37797 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhEMPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:42:58 -0400
Received: by mail-io1-f41.google.com with SMTP id n40so9569583ioz.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Ao5DlschkPFvwmmEHLZKVuxdyHqinSGt19IXhDFGT4=;
        b=MXfZPPAdmwuvXJ/hRH+DqHwQ9ix8L7eMzswfWyhUtSBmdheEgPi50B66iMfp/w1Wry
         wWcKDRobTADe2gfjNTWk7eyF2rOvIRHT7OevvgK4tRU/2FBqkbgM2w3kkm5Cxz7sb4UC
         sPJo3v69mMkUXzvofU/btaVsofx69eB5mAb/vDywITlFF84L/8DVozss9ayjp3v6IZQE
         bUVHEUQ1sPUKiSO+Q3fmQrNhQBoqRLnoIpqRe5FXXw1rU7cD7GDdtgSe7zx8ysKrkaLE
         HuiXqzFdhwbR7X2PSG5Yt6lbFp/zz0BMPSjdlGJ/RPOhgkfavqHbDwUaTm/bgbY33Mlm
         HZsg==
X-Gm-Message-State: AOAM530sC1lgJVYrdNo/fHDTRlUhPL2uS/9N2dAJE+8PnrXajTSrmVnr
        a0Ys1mRSk4OvpnpREz41h9U=
X-Google-Smtp-Source: ABdhPJwrsVRAFdQh0V6Yje3dRTa8wlLtgLbc8+yizdYfC5uZ3jlkxxJQUoCxj2eYZuQHJrH0J42mjA==
X-Received: by 2002:a05:6638:2643:: with SMTP id n3mr38149468jat.104.1620920507991;
        Thu, 13 May 2021 08:41:47 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id 21sm1354028iou.33.2021.05.13.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:41:47 -0700 (PDT)
Date:   Thu, 13 May 2021 15:41:46 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: rework memcg accounting
Message-ID: <YJ1Iuviqo6NE4Kma@google.com>
References: <20210512003504.4023979-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512003504.4023979-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 11, 2021 at 05:35:04PM -0700, Roman Gushchin wrote:
> The current implementation of the memcg accounting of the percpu
> memory is based on the idea of having a separate set of chunks for
> accounted and non-accounted memory. This approach has an advantage
> of not wasting any extra memory for memcg data for non-accounted
> chunks, however it complicates the code and leads to a less effective
> chunk usage due to a lower utilization.
> 
> Instead of having two chunk types it's possible to have only one and
> allocate the space for memcg data (objcg array) dynamically. It makes
> the code simpler in many places (no need to iterate over multiple
> chunk types) and saves memory. The only downside is that in a unlikely
> event when a percpu allocation succeeds and the allocation of the
> objcg array fails, the percpu allocation is passed unaccounted. It's
> not a big deal (a single unaccounted allocation will unlikely cause
> any systematic problems) and it's how the slab accounting works too.
> 
> On my test vm the percpu size just after boot decreased from 7680 kB
> to 7488 kB and the number of chunk decreased by 1. It's not a big win,
> however on production machines with many chunks the win will be likely
> bigger.

Overall I'm fine with this approach. I would like to see some production
numbers to better understand the # of memcg aware chunks vs not as well
as overtime how does that evolve? I suspect that over time non-memcg
aware chunks will be converted and most chunks will be memcg aware after
some period of time.

If the numbers aren't compelling, let's just allocate all chunks to be
memcg aware.

> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu-internal.h |  52 +------------
>  mm/percpu-km.c       |   5 +-
>  mm/percpu-stats.c    |  45 ++++-------
>  mm/percpu-vm.c       |  11 ++-
>  mm/percpu.c          | 180 ++++++++++++++++++-------------------------
>  5 files changed, 98 insertions(+), 195 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 10604dce806f..b6dc22904088 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -5,25 +5,6 @@
>  #include <linux/types.h>
>  #include <linux/percpu.h>
>  
> -/*
> - * There are two chunk types: root and memcg-aware.
> - * Chunks of each type have separate slots list.
> - *
> - * Memcg-aware chunks have an attached vector of obj_cgroup pointers, which is
> - * used to store memcg membership data of a percpu object.  Obj_cgroups are
> - * ref-counted pointers to a memory cgroup with an ability to switch dynamically
> - * to the parent memory cgroup.  This allows to reclaim a deleted memory cgroup
> - * without reclaiming of all outstanding objects, which hold a reference at it.
> - */
> -enum pcpu_chunk_type {
> -	PCPU_CHUNK_ROOT,
> -#ifdef CONFIG_MEMCG_KMEM
> -	PCPU_CHUNK_MEMCG,
> -#endif
> -	PCPU_NR_CHUNK_TYPES,
> -	PCPU_FAIL_ALLOC = PCPU_NR_CHUNK_TYPES
> -};
> -
>  /*
>   * pcpu_block_md is the metadata block struct.
>   * Each chunk's bitmap is split into a number of full blocks.
> @@ -91,7 +72,7 @@ extern struct list_head *pcpu_chunk_lists;
>  extern int pcpu_nr_slots;
>  extern int pcpu_sidelined_slot;
>  extern int pcpu_to_depopulate_slot;
> -extern int pcpu_nr_empty_pop_pages[];
> +extern int pcpu_nr_empty_pop_pages;
>  
>  extern struct pcpu_chunk *pcpu_first_chunk;
>  extern struct pcpu_chunk *pcpu_reserved_chunk;
> @@ -132,37 +113,6 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
>  	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
>  }
>  
> -#ifdef CONFIG_MEMCG_KMEM
> -static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> -{
> -	if (chunk->obj_cgroups)
> -		return PCPU_CHUNK_MEMCG;
> -	return PCPU_CHUNK_ROOT;
> -}
> -
> -static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> -{
> -	return chunk_type == PCPU_CHUNK_MEMCG;
> -}
> -
> -#else
> -static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
> -{
> -	return PCPU_CHUNK_ROOT;
> -}
> -
> -static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
> -{
> -	return false;
> -}
> -#endif
> -
> -static inline struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chunk_type)
> -{
> -	return &pcpu_chunk_lists[pcpu_nr_slots *
> -				 pcpu_is_memcg_chunk(chunk_type)];
> -}
> -
>  #ifdef CONFIG_PERCPU_STATS
>  
>  #include <linux/spinlock.h>
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index c84a9f781a6c..c9d529dc7651 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -44,8 +44,7 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  	/* nada */
>  }
>  
> -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> -					    gfp_t gfp)
> +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  {
>  	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
>  	struct pcpu_chunk *chunk;
> @@ -53,7 +52,7 @@ static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
>  	unsigned long flags;
>  	int i;
>  
> -	chunk = pcpu_alloc_chunk(type, gfp);
> +	chunk = pcpu_alloc_chunk(gfp);
>  	if (!chunk)
>  		return NULL;
>  
> diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> index 2125981acfb9..7103515525e9 100644
> --- a/mm/percpu-stats.c
> +++ b/mm/percpu-stats.c
> @@ -34,15 +34,11 @@ static int find_max_nr_alloc(void)
>  {
>  	struct pcpu_chunk *chunk;
>  	int slot, max_nr_alloc;
> -	enum pcpu_chunk_type type;
>  
>  	max_nr_alloc = 0;
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> -		for (slot = 0; slot < pcpu_nr_slots; slot++)
> -			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> -					    list)
> -				max_nr_alloc = max(max_nr_alloc,
> -						   chunk->nr_alloc);
> +	for (slot = 0; slot < pcpu_nr_slots; slot++)
> +		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list)
> +			max_nr_alloc = max(max_nr_alloc, chunk->nr_alloc);
>  
>  	return max_nr_alloc;
>  }
> @@ -134,7 +130,7 @@ static void chunk_map_stats(struct seq_file *m, struct pcpu_chunk *chunk,
>  	P("cur_med_alloc", cur_med_alloc);
>  	P("cur_max_alloc", cur_max_alloc);
>  #ifdef CONFIG_MEMCG_KMEM
> -	P("memcg_aware", pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)));
> +	P("memcg_aware", !!chunk->obj_cgroups);
>  #endif
>  	seq_putc(m, '\n');
>  }
> @@ -144,8 +140,6 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	struct pcpu_chunk *chunk;
>  	int slot, max_nr_alloc;
>  	int *buffer;
> -	enum pcpu_chunk_type type;
> -	int nr_empty_pop_pages;
>  
>  alloc_buffer:
>  	spin_lock_irq(&pcpu_lock);
> @@ -166,10 +160,6 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  		goto alloc_buffer;
>  	}
>  
> -	nr_empty_pop_pages = 0;
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> -		nr_empty_pop_pages += pcpu_nr_empty_pop_pages[type];
> -
>  #define PL(X)								\
>  	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
>  
> @@ -201,7 +191,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	PU(nr_max_chunks);
>  	PU(min_alloc_size);
>  	PU(max_alloc_size);
> -	P("empty_pop_pages", nr_empty_pop_pages);
> +	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
>  	seq_putc(m, '\n');
>  
>  #undef PU
> @@ -215,20 +205,17 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  		chunk_map_stats(m, pcpu_reserved_chunk, buffer);
>  	}
>  
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> -		for (slot = 0; slot < pcpu_nr_slots; slot++) {
> -			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
> -					    list) {
> -				if (chunk == pcpu_first_chunk)
> -					seq_puts(m, "Chunk: <- First Chunk\n");
> -				else if (slot == pcpu_to_depopulate_slot)
> -					seq_puts(m, "Chunk (to_depopulate)\n");
> -				else if (slot == pcpu_sidelined_slot)
> -					seq_puts(m, "Chunk (sidelined):\n");
> -				else
> -					seq_puts(m, "Chunk:\n");
> -				chunk_map_stats(m, chunk, buffer);
> -			}
> +	for (slot = 0; slot < pcpu_nr_slots; slot++) {
> +		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
> +			if (chunk == pcpu_first_chunk)
> +				seq_puts(m, "Chunk: <- First Chunk\n");
> +			else if (slot == pcpu_to_depopulate_slot)
> +				seq_puts(m, "Chunk (to_depopulate)\n");
> +			else if (slot == pcpu_sidelined_slot)
> +				seq_puts(m, "Chunk (sidelined):\n");
> +			else
> +				seq_puts(m, "Chunk:\n");
> +			chunk_map_stats(m, chunk, buffer);
>  		}
>  	}
>  
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index c75f6f24f2d5..e59566b949d1 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -328,13 +328,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  	pcpu_free_pages(chunk, pages, page_start, page_end);
>  }
>  
> -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> -					    gfp_t gfp)
> +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  {
>  	struct pcpu_chunk *chunk;
>  	struct vm_struct **vms;
>  
> -	chunk = pcpu_alloc_chunk(type, gfp);
> +	chunk = pcpu_alloc_chunk(gfp);
>  	if (!chunk)
>  		return NULL;
>  
> @@ -403,7 +402,7 @@ static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
>  	 * chunk, move it to the to_depopulate list.
>  	 */
>  	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
> -		(pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> -		 PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&
> -		chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
> +		(pcpu_nr_empty_pop_pages > PCPU_EMPTY_POP_PAGES_HIGH +
> +		 chunk->nr_empty_pop_pages &&
> +		 chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
>  }
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 79eebc80860d..09624d920dc5 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -179,10 +179,10 @@ struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
>  static LIST_HEAD(pcpu_map_extend_chunks);
>  
>  /*
> - * The number of empty populated pages by chunk type, protected by pcpu_lock.
> + * The number of empty populated pages, protected by pcpu_lock.
>   * The reserved chunk doesn't contribute to the count.
>   */
> -int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
> +int pcpu_nr_empty_pop_pages;
>  
>  /*
>   * The number of populated pages in use by the allocator, protected by
> @@ -532,13 +532,10 @@ static void __pcpu_chunk_move(struct pcpu_chunk *chunk, int slot,
>  			      bool move_front)
>  {
>  	if (chunk != pcpu_reserved_chunk) {
> -		struct list_head *pcpu_slot;
> -
> -		pcpu_slot = pcpu_chunk_list(pcpu_chunk_type(chunk));
>  		if (move_front)
> -			list_move(&chunk->list, &pcpu_slot[slot]);
> +			list_move(&chunk->list, &pcpu_chunk_lists[slot]);
>  		else
> -			list_move_tail(&chunk->list, &pcpu_slot[slot]);
> +			list_move_tail(&chunk->list, &pcpu_chunk_lists[slot]);
>  	}
>  }
>  
> @@ -574,27 +571,22 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
>  
>  static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
>  {
> -	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
> -	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> -
>  	lockdep_assert_held(&pcpu_lock);
>  
>  	if (!chunk->isolated) {
>  		chunk->isolated = true;
> -		pcpu_nr_empty_pop_pages[type] -= chunk->nr_empty_pop_pages;
> +		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
>  	}
> -	list_move(&chunk->list, &pcpu_slot[pcpu_to_depopulate_slot]);
> +	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
>  }
>  
>  static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
>  {
> -	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
> -
>  	lockdep_assert_held(&pcpu_lock);
>  
>  	if (chunk->isolated) {
>  		chunk->isolated = false;
> -		pcpu_nr_empty_pop_pages[type] += chunk->nr_empty_pop_pages;
> +		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
>  		pcpu_chunk_relocate(chunk, -1);
>  	}
>  }
> @@ -612,7 +604,7 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
>  {
>  	chunk->nr_empty_pop_pages += nr;
>  	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
> -		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] += nr;
> +		pcpu_nr_empty_pop_pages += nr;
>  }
>  
>  /*
> @@ -1447,7 +1439,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
>  	return chunk;
>  }
>  
> -static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
> +static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
>  {
>  	struct pcpu_chunk *chunk;
>  	int region_bits;
> @@ -1475,16 +1467,6 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
>  	if (!chunk->md_blocks)
>  		goto md_blocks_fail;
>  
> -#ifdef CONFIG_MEMCG_KMEM
> -	if (pcpu_is_memcg_chunk(type)) {
> -		chunk->obj_cgroups =
> -			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
> -					sizeof(struct obj_cgroup *), gfp);
> -		if (!chunk->obj_cgroups)
> -			goto objcg_fail;
> -	}
> -#endif
> -
>  	pcpu_init_md_blocks(chunk);
>  
>  	/* init metadata */
> @@ -1492,10 +1474,6 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
>  
>  	return chunk;
>  
> -#ifdef CONFIG_MEMCG_KMEM
> -objcg_fail:
> -	pcpu_mem_free(chunk->md_blocks);
> -#endif
>  md_blocks_fail:
>  	pcpu_mem_free(chunk->bound_map);
>  bound_map_fail:
> @@ -1589,8 +1567,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  			       int page_start, int page_end, gfp_t gfp);
>  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  				  int page_start, int page_end);
> -static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
> -					    gfp_t gfp);
> +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
>  static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
>  static struct page *pcpu_addr_to_page(void *addr);
>  static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai);
> @@ -1633,55 +1610,68 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> -						     struct obj_cgroup **objcgp)
> +static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
> +				      struct obj_cgroup **objcgp)
>  {
>  	struct obj_cgroup *objcg;
>  
>  	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
> -		return PCPU_CHUNK_ROOT;
> +		return true;
>  
>  	objcg = get_obj_cgroup_from_current();
>  	if (!objcg)
> -		return PCPU_CHUNK_ROOT;
> +		return true;
>  
>  	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
>  		obj_cgroup_put(objcg);
> -		return PCPU_FAIL_ALLOC;
> +		return false;
>  	}
>  
>  	*objcgp = objcg;
> -	return PCPU_CHUNK_MEMCG;
> +	return true;
>  }
>  
>  static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
>  				       struct pcpu_chunk *chunk, int off,
> -				       size_t size)
> +				       size_t size, gfp_t gfp)
>  {
>  	if (!objcg)
>  		return;
>  
> -	if (chunk) {
> -		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
> +	if (!chunk)
> +		goto cancel_charge;
>  
> -		rcu_read_lock();
> -		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> -				size * num_possible_cpus());
> -		rcu_read_unlock();
> -	} else {
> -		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> -		obj_cgroup_put(objcg);
> +	if (!chunk->obj_cgroups) {
> +		chunk->obj_cgroups = pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
> +						     sizeof(struct obj_cgroup *), gfp);

Percpu does some weird things with gfp flags. This might need to be
fixed if we don't always pre-allocate this for our definition of atomic.
I haven't thought too much about this just yet as seem my thoughts
above.

> +		if (unlikely(!chunk->obj_cgroups))
> +			goto cancel_charge;
>  	}
> +
> +	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
> +
> +	rcu_read_lock();
> +	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> +			size * num_possible_cpus());
> +	rcu_read_unlock();
> +
> +	return;
> +
> +cancel_charge:
> +	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> +	obj_cgroup_put(objcg);
>  }
>  
>  static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
>  {
>  	struct obj_cgroup *objcg;
>  
> -	if (!pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)))
> +	if (!chunk->obj_cgroups)
>  		return;
>  
>  	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
> +	if (!objcg)
> +		return;
>  	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
>  
>  	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> @@ -1695,15 +1685,15 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
>  }
>  
>  #else /* CONFIG_MEMCG_KMEM */
> -static enum pcpu_chunk_type
> +static bool
>  pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp, struct obj_cgroup **objcgp)
>  {
> -	return PCPU_CHUNK_ROOT;
> +	return true;
>  }
>  
>  static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
>  				       struct pcpu_chunk *chunk, int off,
> -				       size_t size)
> +				       size_t size, gfp_t gfp)
>  {
>  }
>  
> @@ -1733,8 +1723,6 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  	gfp_t pcpu_gfp;
>  	bool is_atomic;
>  	bool do_warn;
> -	enum pcpu_chunk_type type;
> -	struct list_head *pcpu_slot;
>  	struct obj_cgroup *objcg = NULL;
>  	static int warn_limit = 10;
>  	struct pcpu_chunk *chunk, *next;
> @@ -1770,10 +1758,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		return NULL;
>  	}
>  
> -	type = pcpu_memcg_pre_alloc_hook(size, gfp, &objcg);
> -	if (unlikely(type == PCPU_FAIL_ALLOC))
> +	if (unlikely(!pcpu_memcg_pre_alloc_hook(size, gfp, &objcg)))
>  		return NULL;
> -	pcpu_slot = pcpu_chunk_list(type);
>  
>  	if (!is_atomic) {
>  		/*
> @@ -1784,7 +1770,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		if (gfp & __GFP_NOFAIL) {
>  			mutex_lock(&pcpu_alloc_mutex);
>  		} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
> -			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> +			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size, gfp);
>  			return NULL;
>  		}
>  	}
> @@ -1812,7 +1798,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  restart:
>  	/* search through normal chunks */
>  	for (slot = pcpu_size_to_slot(size); slot <= pcpu_free_slot; slot++) {
> -		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
> +		list_for_each_entry_safe(chunk, next, &pcpu_chunk_lists[slot], list) {
>  			off = pcpu_find_block_fit(chunk, bits, bit_align,
>  						  is_atomic);
>  			if (off < 0) {
> @@ -1841,8 +1827,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		goto fail;
>  	}
>  
> -	if (list_empty(&pcpu_slot[pcpu_free_slot])) {
> -		chunk = pcpu_create_chunk(type, pcpu_gfp);
> +	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
> +		chunk = pcpu_create_chunk(pcpu_gfp);
>  		if (!chunk) {
>  			err = "failed to allocate new chunk";
>  			goto fail;
> @@ -1886,7 +1872,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
> +	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
>  
>  	/* clear the areas and return address relative to base address */
> @@ -1899,7 +1885,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
>  			chunk->base_addr, off, ptr);
>  
> -	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
> +	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size, gfp);
>  
>  	return ptr;
>  
> @@ -1923,7 +1909,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> +	pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size, gfp);
>  
>  	return NULL;
>  }
> @@ -1985,18 +1971,16 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
>  
>  /**
>   * pcpu_balance_free - manage the amount of free chunks
> - * @type: chunk type
>   * @empty_only: free chunks only if there are no populated pages
>   *
>   * If empty_only is %false, reclaim all fully free chunks regardless of the
>   * number of populated pages.  Otherwise, only reclaim chunks that have no
>   * populated pages.
>   */
> -static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> +static void pcpu_balance_free(bool empty_only)
>  {
>  	LIST_HEAD(to_free);
> -	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> -	struct list_head *free_head = &pcpu_slot[pcpu_free_slot];
> +	struct list_head *free_head = &pcpu_chunk_lists[pcpu_free_slot];
>  	struct pcpu_chunk *chunk, *next;
>  
>  	/*
> @@ -2035,7 +2019,6 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
>  
>  /**
>   * pcpu_balance_populated - manage the amount of populated pages
> - * @type: chunk type
>   *
>   * Maintain a certain amount of populated pages to satisfy atomic allocations.
>   * It is possible that this is called when physical memory is scarce causing
> @@ -2043,11 +2026,10 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
>   * allocation causes the failure as it is possible that requests can be
>   * serviced from already backed regions.
>   */
> -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +static void pcpu_balance_populated(void)
>  {
>  	/* gfp flags passed to underlying allocators */
>  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> -	struct list_head *pcpu_slot = pcpu_chunk_list(type);
>  	struct pcpu_chunk *chunk;
>  	int slot, nr_to_pop, ret;
>  
> @@ -2068,7 +2050,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  		pcpu_atomic_alloc_failed = false;
>  	} else {
>  		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> -				  pcpu_nr_empty_pop_pages[type],
> +				  pcpu_nr_empty_pop_pages,
>  				  0, PCPU_EMPTY_POP_PAGES_HIGH);
>  	}
>  
> @@ -2079,7 +2061,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  			break;
>  
>  		spin_lock_irq(&pcpu_lock);
> -		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> +		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
>  			nr_unpop = chunk->nr_pages - chunk->nr_populated;
>  			if (nr_unpop)
>  				break;
> @@ -2111,7 +2093,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  
>  	if (nr_to_pop) {
>  		/* ran out of chunks to populate, create a new one and retry */
> -		chunk = pcpu_create_chunk(type, gfp);
> +		chunk = pcpu_create_chunk(gfp);
>  		if (chunk) {
>  			spin_lock_irq(&pcpu_lock);
>  			pcpu_chunk_relocate(chunk, -1);
> @@ -2123,7 +2105,6 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  
>  /**
>   * pcpu_reclaim_populated - scan over to_depopulate chunks and free empty pages
> - * @type: chunk type
>   *
>   * Scan over chunks in the depopulate list and try to release unused populated
>   * pages back to the system.  Depopulated chunks are sidelined to prevent
> @@ -2133,9 +2114,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>   * Each chunk is scanned in the reverse order to keep populated pages close to
>   * the beginning of the chunk.
>   */
> -static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
> +static void pcpu_reclaim_populated(void)
>  {
> -	struct list_head *pcpu_slot = pcpu_chunk_list(type);
>  	struct pcpu_chunk *chunk;
>  	struct pcpu_block_md *block;
>  	int i, end;
> @@ -2149,8 +2129,8 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
>  	 * other accessor is the free path which only returns area back to the
>  	 * allocator not touching the populated bitmap.
>  	 */
> -	while (!list_empty(&pcpu_slot[pcpu_to_depopulate_slot])) {
> -		chunk = list_first_entry(&pcpu_slot[pcpu_to_depopulate_slot],
> +	while (!list_empty(&pcpu_chunk_lists[pcpu_to_depopulate_slot])) {
> +		chunk = list_first_entry(&pcpu_chunk_lists[pcpu_to_depopulate_slot],
>  					 struct pcpu_chunk, list);
>  		WARN_ON(chunk->immutable);
>  
> @@ -2164,8 +2144,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
>  				break;
>  
>  			/* reintegrate chunk to prevent atomic alloc failures */
> -			if (pcpu_nr_empty_pop_pages[type] <
> -			    PCPU_EMPTY_POP_PAGES_HIGH) {
> +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
>  				pcpu_reintegrate_chunk(chunk);
>  				goto restart;
>  			}
> @@ -2205,7 +2184,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
>  			pcpu_reintegrate_chunk(chunk);
>  		else
>  			list_move(&chunk->list,
> -				  &pcpu_slot[pcpu_sidelined_slot]);
> +				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
>  	}
>  
>  	spin_unlock_irq(&pcpu_lock);
> @@ -2221,8 +2200,6 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
>   */
>  static void pcpu_balance_workfn(struct work_struct *work)
>  {
> -	enum pcpu_chunk_type type;
> -
>  	/*
>  	 * pcpu_balance_free() is called twice because the first time we may
>  	 * trim pages in the active pcpu_nr_empty_pop_pages which may cause us
> @@ -2230,14 +2207,12 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	 * to move fully free chunks to the active list to be freed if
>  	 * appropriate.
>  	 */
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> -		mutex_lock(&pcpu_alloc_mutex);
> -		pcpu_balance_free(type, false);
> -		pcpu_reclaim_populated(type);
> -		pcpu_balance_populated(type);
> -		pcpu_balance_free(type, true);
> -		mutex_unlock(&pcpu_alloc_mutex);
> -	}
> +	mutex_lock(&pcpu_alloc_mutex);
> +	pcpu_balance_free(false);
> +	pcpu_reclaim_populated();
> +	pcpu_balance_populated();
> +	pcpu_balance_free(true);
> +	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
>  /**
> @@ -2256,7 +2231,6 @@ void free_percpu(void __percpu *ptr)
>  	unsigned long flags;
>  	int size, off;
>  	bool need_balance = false;
> -	struct list_head *pcpu_slot;
>  
>  	if (!ptr)
>  		return;
> @@ -2272,8 +2246,6 @@ void free_percpu(void __percpu *ptr)
>  
>  	size = pcpu_free_area(chunk, off);
>  
> -	pcpu_slot = pcpu_chunk_list(pcpu_chunk_type(chunk));
> -
>  	pcpu_memcg_free_hook(chunk, off, size);
>  
>  	/*
> @@ -2284,7 +2256,7 @@ void free_percpu(void __percpu *ptr)
>  	if (!chunk->isolated && chunk->free_bytes == pcpu_unit_size) {
>  		struct pcpu_chunk *pos;
>  
> -		list_for_each_entry(pos, &pcpu_slot[pcpu_free_slot], list)
> +		list_for_each_entry(pos, &pcpu_chunk_lists[pcpu_free_slot], list)
>  			if (pos != chunk) {
>  				need_balance = true;
>  				break;
> @@ -2592,7 +2564,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	int map_size;
>  	unsigned long tmp_addr;
>  	size_t alloc_size;
> -	enum pcpu_chunk_type type;
>  
>  #define PCPU_SETUP_BUG_ON(cond)	do {					\
>  	if (unlikely(cond)) {						\
> @@ -2716,17 +2687,14 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	pcpu_to_depopulate_slot = pcpu_free_slot + 1;
>  	pcpu_nr_slots = pcpu_to_depopulate_slot + 1;
>  	pcpu_chunk_lists = memblock_alloc(pcpu_nr_slots *
> -					  sizeof(pcpu_chunk_lists[0]) *
> -					  PCPU_NR_CHUNK_TYPES,
> +					  sizeof(pcpu_chunk_lists[0]),
>  					  SMP_CACHE_BYTES);
>  	if (!pcpu_chunk_lists)
>  		panic("%s: Failed to allocate %zu bytes\n", __func__,
> -		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]) *
> -		      PCPU_NR_CHUNK_TYPES);
> +		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]));
>  
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> -		for (i = 0; i < pcpu_nr_slots; i++)
> -			INIT_LIST_HEAD(&pcpu_chunk_list(type)[i]);
> +	for (i = 0; i < pcpu_nr_slots; i++)
> +		INIT_LIST_HEAD(&pcpu_chunk_lists[i]);
>  
>  	/*
>  	 * The end of the static region needs to be aligned with the
> @@ -2763,7 +2731,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  
>  	/* link the first chunk in */
>  	pcpu_first_chunk = chunk;
> -	pcpu_nr_empty_pop_pages[PCPU_CHUNK_ROOT] = pcpu_first_chunk->nr_empty_pop_pages;
> +	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
>  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
>  
>  	/* include all regions of the first chunk */
> -- 
> 2.30.2
> 

Thanks,
Dennis
