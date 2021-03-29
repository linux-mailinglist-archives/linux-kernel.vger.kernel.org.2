Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB78A34D807
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC2TWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:22:03 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:33443 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhC2TV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:21:27 -0400
Received: by mail-io1-f41.google.com with SMTP id n198so13983652iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3fvMIhSqu7sJNv/kNTkn2WkYYe1axf5Dbnbe6NPasU=;
        b=uVaYhb+dEquDDaHPQJKfaeAxfT/qMNZCqP1gzKzZO7+rdpFvNtpCmhpif29XemwDGq
         V5CJ7FnZgy0GTeQYFRygWh/tWA17kf0egWIicItYxvF2/rmId2qxDx519UgiOoQgwq60
         lR2c2PcRHWvNaooAF85XdF2clhMKMBoiF4fJUP7sMOQGZTU/HxVue3wSDAt+ygYN8QmR
         XjhKiNuOL6yYbwP/lIom/IF24LOskLv+Zp/ZIs0aM2uW6nNqPeoF3HfiaCkGwcftfWQl
         j682UE75Misuo9cBwkwxKZB5MqaEqKVp+8BMTr5bNBeeyth+H6EB7urr/bHHM+8jU9HP
         5Kfw==
X-Gm-Message-State: AOAM5337h3yuhjfLObFPR22FwEW7oJhea4Lbihcd5ohrON7fS7iHgc5j
        qLWy3yCbYfnOC6uhXy3bDWhYm/2qscM=
X-Google-Smtp-Source: ABdhPJymGF0byyC/d0PaFeZ6t9skx6/7Pl+nSG1ZyO2s9ibS8cKWKd42feI6wrKi088vo6GioOkWVg==
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr10672730jar.52.1617045686470;
        Mon, 29 Mar 2021 12:21:26 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y13sm10105672ilq.20.2021.03.29.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:21:26 -0700 (PDT)
Date:   Mon, 29 Mar 2021 19:21:24 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 3/4] percpu: on demand chunk depopulation
Message-ID: <YGIotHUFTrPauwrP@google.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324190626.564297-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:06:25PM -0700, Roman Gushchin wrote:
> To return unused memory to the system schedule an async
> depopulation of percpu chunks.
> 
> To balance between scanning too much and creating an overhead because
> of the pcpu_lock contention and scanning not enough, let's track an
> amount of chunks to scan and mark chunks which are potentially a good
> target for the depopulation with a new boolean flag.  The async
> depopulation work will clear the flag after trying to depopulate a
> chunk (successfully or not).
> 
> This commit suggest the following logic: if a chunk
>   1) has more than 1/4 of total pages free and populated
>   2) isn't a reserved chunk
>   3) isn't entirely free
>   4) isn't alone in the corresponding slot

I'm not sure I like the check for alone that much. The reason being what
about some odd case where each slot has a single chunk, but every slot
is populated. It doesn't really make sense to keep them all around.

I think there is some decision making we can do here to handle packing
post depopulation allocations into a handful of chunks. Depopulated
chunks could be sidelined with say a flag ->depopulated to prevent the
first attempt of allocations from using them. And then we could bring
back a chunk 1 by 1 somehow to attempt to suffice the allocation.
I'm not too sure if this is a good idea, just a thought.

> it's a good target for depopulation.
> 
> If there are 2 or more of such chunks, an async depopulation
> is scheduled.
> 
> Because chunk population and depopulation are opposite processes
> which make a little sense together, split out the shrinking part of
> pcpu_balance_populated() into pcpu_grow_populated() and make
> pcpu_balance_populated() calling into pcpu_grow_populated() or
> pcpu_shrink_populated() conditionally.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu-internal.h |   1 +
>  mm/percpu.c          | 111 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 85 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 18b768ac7dca..1c5b92af02eb 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -67,6 +67,7 @@ struct pcpu_chunk {
>  
>  	void			*data;		/* chunk data */
>  	bool			immutable;	/* no [de]population allowed */
> +	bool			depopulate;	/* depopulation hint */
>  	int			start_offset;	/* the overlap with the previous
>  						   region to have a page aligned
>  						   base_addr */
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 015d076893f5..148137f0fc0b 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -178,6 +178,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
>   */
>  int pcpu_nr_empty_pop_pages;
>  
> +/*
> + * Track the number of chunks with a lot of free memory.
> + * It's used to release unused pages to the system.
> + */
> +static int pcpu_nr_chunks_to_depopulate;
> +
>  /*
>   * The number of populated pages in use by the allocator, protected by
>   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> @@ -1955,6 +1961,11 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
>  		if (chunk == list_first_entry(free_head, struct pcpu_chunk, list))
>  			continue;
>  
> +		if (chunk->depopulate) {
> +			chunk->depopulate = false;
> +			pcpu_nr_chunks_to_depopulate--;
> +		}
> +
>  		list_move(&chunk->list, &to_free);
>  	}
>  
> @@ -1976,7 +1987,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
>  }
>  
>  /**
> - * pcpu_balance_populated - manage the amount of populated pages
> + * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
>   * @type: chunk type
>   *
>   * Maintain a certain amount of populated pages to satisfy atomic allocations.
> @@ -1985,35 +1996,15 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
>   * allocation causes the failure as it is possible that requests can be
>   * serviced from already backed regions.
>   */
> -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
>  {
>  	/* gfp flags passed to underlying allocators */
>  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
>  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
>  	struct pcpu_chunk *chunk;
> -	int slot, nr_to_pop, ret;
> +	int slot, ret;
>  
> -	/*
> -	 * Ensure there are certain number of free populated pages for
> -	 * atomic allocs.  Fill up from the most packed so that atomic
> -	 * allocs don't increase fragmentation.  If atomic allocation
> -	 * failed previously, always populate the maximum amount.  This
> -	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> -	 * failing indefinitely; however, large atomic allocs are not
> -	 * something we support properly and can be highly unreliable and
> -	 * inefficient.
> -	 */
>  retry_pop:
> -	if (pcpu_atomic_alloc_failed) {
> -		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> -		/* best effort anyway, don't worry about synchronization */
> -		pcpu_atomic_alloc_failed = false;
> -	} else {
> -		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> -				  pcpu_nr_empty_pop_pages,
> -				  0, PCPU_EMPTY_POP_PAGES_HIGH);
> -	}
> -
>  	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
>  		unsigned int nr_unpop = 0, rs, re;
>  
> @@ -2084,9 +2075,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)

I missed this in the review of patch 1, but pcpu_shrink only needs to
iterate over:
for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {

>  		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
>  			bool isolated = false;
>  
> -			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH ||
> +			    pcpu_nr_chunks_to_depopulate < 1)
>  				break;
>  
> +			/*
> +			 * Don't try to depopulate a chunk again and again.
> +			 */
> +			if (!chunk->depopulate)
> +				continue;
> +			chunk->depopulate = false;
> +			pcpu_nr_chunks_to_depopulate--;
> +
>  			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
>  				if (!chunk->nr_empty_pop_pages)
>  					break;
> @@ -2153,6 +2153,41 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
>  	spin_unlock_irq(&pcpu_lock);
>  }
>  
> +/**
> + * pcpu_balance_populated - manage the amount of populated pages
> + * @type: chunk type
> + *
> + * Populate or depopulate chunks to maintain a certain amount
> + * of free pages to satisfy atomic allocations, but not waste
> + * large amounts of memory.
> + */
> +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +{
> +	int nr_to_pop;
> +
> +	/*
> +	 * Ensure there are certain number of free populated pages for
> +	 * atomic allocs.  Fill up from the most packed so that atomic
> +	 * allocs don't increase fragmentation.  If atomic allocation
> +	 * failed previously, always populate the maximum amount.  This
> +	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> +	 * failing indefinitely; however, large atomic allocs are not
> +	 * something we support properly and can be highly unreliable and
> +	 * inefficient.
> +	 */
> +	if (pcpu_atomic_alloc_failed) {
> +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> +		/* best effort anyway, don't worry about synchronization */
> +		pcpu_atomic_alloc_failed = false;
> +		pcpu_grow_populated(type, nr_to_pop);
> +	} else if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages;
> +		pcpu_grow_populated(type, nr_to_pop);
> +	} else if (pcpu_nr_chunks_to_depopulate > 0) {
> +		pcpu_shrink_populated(type);
> +	}
> +}
> +
>  /**
>   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
>   * @work: unused
> @@ -2188,6 +2223,7 @@ void free_percpu(void __percpu *ptr)
>  	int size, off;
>  	bool need_balance = false;
>  	struct list_head *pcpu_slot;
> +	struct pcpu_chunk *pos;
>  
>  	if (!ptr)
>  		return;
> @@ -2207,15 +2243,36 @@ void free_percpu(void __percpu *ptr)
>  
>  	pcpu_memcg_free_hook(chunk, off, size);
>  
> -	/* if there are more than one fully free chunks, wake up grim reaper */
>  	if (chunk->free_bytes == pcpu_unit_size) {
> -		struct pcpu_chunk *pos;
> -
> +		/*
> +		 * If there are more than one fully free chunks,
> +		 * wake up grim reaper.
> +		 */
>  		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
>  			if (pos != chunk) {
>  				need_balance = true;
>  				break;
>  			}
> +
> +	} else if (chunk->nr_empty_pop_pages > chunk->nr_pages / 4) {

We should have this ignore the first and reserved chunks. While it
shouldn't be possible in theory, it would be nice to just make it
explicit here.

> +		/*
> +		 * If there is more than one chunk in the slot and
> +		 * at least 1/4 of its pages are empty, mark the chunk
> +		 * as a target for the depopulation. If there is more
> +		 * than one chunk like this, schedule an async balancing.
> +		 */
> +		int nslot = pcpu_chunk_slot(chunk);
> +
> +		list_for_each_entry(pos, &pcpu_slot[nslot], list)
> +			if (pos != chunk && !chunk->depopulate &&
> +			    !chunk->immutable) {
> +				chunk->depopulate = true;
> +				pcpu_nr_chunks_to_depopulate++;
> +				break;
> +			}
> +
> +		if (pcpu_nr_chunks_to_depopulate > 1)
> +			need_balance = true;
>  	}
>  
>  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> -- 
> 2.30.2
> 

Some questions I have:
1. How do we prevent unnecessary scanning for atomic allocations?
2. Even in the normal case, should we try to pack future allocations
into a smaller # of chunks in after depopulation?
3. What is the right frequency to do depopulation scanning? I think of
the pcpu work item as a way to defer the 2 the freeing of chunks and in
a way more immediately replenish free pages. Depopulation isn't
necessarily as high a priority.

Thanks,
Dennis
