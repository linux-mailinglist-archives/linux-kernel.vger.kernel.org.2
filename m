Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEE34DC52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC2XMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:12:54 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:35483 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2XMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:12:36 -0400
Received: by mail-il1-f177.google.com with SMTP id 19so12653069ilj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDI2yUT578MbhLhrd5imOPqltraD2SbMpCDp/zTtb7A=;
        b=KEv1oRvNoag5fdnc1efLl+9Yr8k8eMY7zXJt4gCA6SKCH0SOS/FFwqUaWtT3RPy1B3
         lAHlEAQtFGozeezJbp4jQy0BOztbLNw7SJOqmgpteilyjb/tMMV/AII+1D0gBxDuFH/2
         z1DtBJzp1sE7DAwSPJUmmE+7PS6Pp5AJENKd5tf3Qs/fKp1l5xXoQp1//k1g9LoDYrE2
         xO9ZuukXa8U7WkQDnNIzl3bywH6xqtG5F/38h1AmPlz2D3HajXoBVC/CCi1QI2AwxuKA
         y7gI1dLjhhhglQwQJKPwlyZtX4346/fLTMK53zBLSNFXLBlUwk1z+L6UmVKRJvsY9yf8
         3zUw==
X-Gm-Message-State: AOAM530UvgtwdIsQpzjipjHKIzFSLBXB2prjIDoaW8m6cjrQwXqtVytR
        Lig7qjSiUA+J3WK0CNjK8OE=
X-Google-Smtp-Source: ABdhPJwwtHaVNEeCaZXwX85p2/tsQ1SGrAoxcD12EMmUbd6K+wpj4JzeKnfD3Cv4mOP19eOkVFAROw==
X-Received: by 2002:a05:6e02:4b2:: with SMTP id e18mr21047589ils.42.1617059555996;
        Mon, 29 Mar 2021 16:12:35 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id a7sm10200910ilj.64.2021.03.29.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:12:35 -0700 (PDT)
Date:   Mon, 29 Mar 2021 23:12:34 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 3/4] percpu: on demand chunk depopulation
Message-ID: <YGJe4hTfWCoQRFFc@google.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-4-guro@fb.com>
 <YGIotHUFTrPauwrP@google.com>
 <YGI0IsSjGpqomJxh@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGI0IsSjGpqomJxh@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 01:10:10PM -0700, Roman Gushchin wrote:
> On Mon, Mar 29, 2021 at 07:21:24PM +0000, Dennis Zhou wrote:
> > On Wed, Mar 24, 2021 at 12:06:25PM -0700, Roman Gushchin wrote:
> > > To return unused memory to the system schedule an async
> > > depopulation of percpu chunks.
> > > 
> > > To balance between scanning too much and creating an overhead because
> > > of the pcpu_lock contention and scanning not enough, let's track an
> > > amount of chunks to scan and mark chunks which are potentially a good
> > > target for the depopulation with a new boolean flag.  The async
> > > depopulation work will clear the flag after trying to depopulate a
> > > chunk (successfully or not).
> > > 
> > > This commit suggest the following logic: if a chunk
> > >   1) has more than 1/4 of total pages free and populated
> > >   2) isn't a reserved chunk
> > >   3) isn't entirely free
> > >   4) isn't alone in the corresponding slot
> > 
> > I'm not sure I like the check for alone that much. The reason being what
> > about some odd case where each slot has a single chunk, but every slot
> > is populated. It doesn't really make sense to keep them all around.
> 
> Yeah, I agree, I'm not sure either. Maybe we can just look at the total
> number of populated empty pages and make sure it's not too low and not
> too high. Btw, we should probably double PCPU_EMPTY_POP_PAGES_LOW/HIGH
> if memcg accounting is on.
> 

Hmmm. pcpu_nr_populated and pcpu_nr_empty_pop_pages should probably be
per chunk type now that you mention it.

> > 
> > I think there is some decision making we can do here to handle packing
> > post depopulation allocations into a handful of chunks. Depopulated
> > chunks could be sidelined with say a flag ->depopulated to prevent the
> > first attempt of allocations from using them. And then we could bring
> > back a chunk 1 by 1 somehow to attempt to suffice the allocation.
> > I'm not too sure if this is a good idea, just a thought.
> 
> I thought about it in this way: depopulated chunks are not different to
> new chunks, which are not yet fully populated. And they are naturally
> de-prioritized by being located in higher slots (and at the tail of the list).
> So I'm not sure we should handle them any special.
> 

I'm thinking of the following. Imagine 3 chunks, A and B in slot X, and
C in slot X+1. If B gets depopulated followed by A getting exhausted,
which chunk B or C should be used? If C is fully populated, we might
want to use that one.

I see that the priority is chunks at the very end, but I don't want to
take something that doesn't reasonable generalize to any slot PAGE_SIZE
and up. Or it should explicitly try to tackle only say the last N slots
(but preferably the former).

> > 
> > > it's a good target for depopulation.
> > > 
> > > If there are 2 or more of such chunks, an async depopulation
> > > is scheduled.
> > > 
> > > Because chunk population and depopulation are opposite processes
> > > which make a little sense together, split out the shrinking part of
> > > pcpu_balance_populated() into pcpu_grow_populated() and make
> > > pcpu_balance_populated() calling into pcpu_grow_populated() or
> > > pcpu_shrink_populated() conditionally.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  mm/percpu-internal.h |   1 +
> > >  mm/percpu.c          | 111 ++++++++++++++++++++++++++++++++-----------
> > >  2 files changed, 85 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > > index 18b768ac7dca..1c5b92af02eb 100644
> > > --- a/mm/percpu-internal.h
> > > +++ b/mm/percpu-internal.h
> > > @@ -67,6 +67,7 @@ struct pcpu_chunk {
> > >  
> > >  	void			*data;		/* chunk data */
> > >  	bool			immutable;	/* no [de]population allowed */
> > > +	bool			depopulate;	/* depopulation hint */
> > >  	int			start_offset;	/* the overlap with the previous
> > >  						   region to have a page aligned
> > >  						   base_addr */
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index 015d076893f5..148137f0fc0b 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -178,6 +178,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
> > >   */
> > >  int pcpu_nr_empty_pop_pages;
> > >  
> > > +/*
> > > + * Track the number of chunks with a lot of free memory.
> > > + * It's used to release unused pages to the system.
> > > + */
> > > +static int pcpu_nr_chunks_to_depopulate;
> > > +
> > >  /*
> > >   * The number of populated pages in use by the allocator, protected by
> > >   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> > > @@ -1955,6 +1961,11 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > >  		if (chunk == list_first_entry(free_head, struct pcpu_chunk, list))
> > >  			continue;
> > >  
> > > +		if (chunk->depopulate) {
> > > +			chunk->depopulate = false;
> > > +			pcpu_nr_chunks_to_depopulate--;
> > > +		}
> > > +
> > >  		list_move(&chunk->list, &to_free);
> > >  	}
> > >  
> > > @@ -1976,7 +1987,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > >  }
> > >  
> > >  /**
> > > - * pcpu_balance_populated - manage the amount of populated pages
> > > + * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
> > >   * @type: chunk type
> > >   *
> > >   * Maintain a certain amount of populated pages to satisfy atomic allocations.
> > > @@ -1985,35 +1996,15 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
> > >   * allocation causes the failure as it is possible that requests can be
> > >   * serviced from already backed regions.
> > >   */
> > > -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > > +static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
> > >  {
> > >  	/* gfp flags passed to underlying allocators */
> > >  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> > >  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > >  	struct pcpu_chunk *chunk;
> > > -	int slot, nr_to_pop, ret;
> > > +	int slot, ret;
> > >  
> > > -	/*
> > > -	 * Ensure there are certain number of free populated pages for
> > > -	 * atomic allocs.  Fill up from the most packed so that atomic
> > > -	 * allocs don't increase fragmentation.  If atomic allocation
> > > -	 * failed previously, always populate the maximum amount.  This
> > > -	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > > -	 * failing indefinitely; however, large atomic allocs are not
> > > -	 * something we support properly and can be highly unreliable and
> > > -	 * inefficient.
> > > -	 */
> > >  retry_pop:
> > > -	if (pcpu_atomic_alloc_failed) {
> > > -		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > > -		/* best effort anyway, don't worry about synchronization */
> > > -		pcpu_atomic_alloc_failed = false;
> > > -	} else {
> > > -		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> > > -				  pcpu_nr_empty_pop_pages,
> > > -				  0, PCPU_EMPTY_POP_PAGES_HIGH);
> > > -	}
> > > -
> > >  	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
> > >  		unsigned int nr_unpop = 0, rs, re;
> > >  
> > > @@ -2084,9 +2075,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > 
> > I missed this in the review of patch 1, but pcpu_shrink only needs to
> > iterate over:
> > for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
> 
> You mean skip first few slots?
> Yeah, it's probably safe. I was afraid that a marked chunk can be moved to
> one of such slots, so we'll never find it and will repeat scanning, but it seems
> like it's not a possible scenario. Will adjust, thanks.
> 
> > 
> > >  		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > >  			bool isolated = false;
> > >  
> > > -			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH ||
> > > +			    pcpu_nr_chunks_to_depopulate < 1)
> > >  				break;
> > >  
> > > +			/*
> > > +			 * Don't try to depopulate a chunk again and again.
> > > +			 */
> > > +			if (!chunk->depopulate)
> > > +				continue;
> > > +			chunk->depopulate = false;
> > > +			pcpu_nr_chunks_to_depopulate--;
> > > +
> > >  			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> > >  				if (!chunk->nr_empty_pop_pages)
> > >  					break;
> > > @@ -2153,6 +2153,41 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > >  	spin_unlock_irq(&pcpu_lock);
> > >  }
> > >  
> > > +/**
> > > + * pcpu_balance_populated - manage the amount of populated pages
> > > + * @type: chunk type
> > > + *
> > > + * Populate or depopulate chunks to maintain a certain amount
> > > + * of free pages to satisfy atomic allocations, but not waste
> > > + * large amounts of memory.
> > > + */
> > > +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > > +{
> > > +	int nr_to_pop;
> > > +
> > > +	/*
> > > +	 * Ensure there are certain number of free populated pages for
> > > +	 * atomic allocs.  Fill up from the most packed so that atomic
> > > +	 * allocs don't increase fragmentation.  If atomic allocation
> > > +	 * failed previously, always populate the maximum amount.  This
> > > +	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> > > +	 * failing indefinitely; however, large atomic allocs are not
> > > +	 * something we support properly and can be highly unreliable and
> > > +	 * inefficient.
> > > +	 */
> > > +	if (pcpu_atomic_alloc_failed) {
> > > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> > > +		/* best effort anyway, don't worry about synchronization */
> > > +		pcpu_atomic_alloc_failed = false;
> > > +		pcpu_grow_populated(type, nr_to_pop);
> > > +	} else if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> > > +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages;
> > > +		pcpu_grow_populated(type, nr_to_pop);
> > > +	} else if (pcpu_nr_chunks_to_depopulate > 0) {
> > > +		pcpu_shrink_populated(type);
> > > +	}
> > > +}
> > > +
> > >  /**
> > >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > >   * @work: unused
> > > @@ -2188,6 +2223,7 @@ void free_percpu(void __percpu *ptr)
> > >  	int size, off;
> > >  	bool need_balance = false;
> > >  	struct list_head *pcpu_slot;
> > > +	struct pcpu_chunk *pos;
> > >  
> > >  	if (!ptr)
> > >  		return;
> > > @@ -2207,15 +2243,36 @@ void free_percpu(void __percpu *ptr)
> > >  
> > >  	pcpu_memcg_free_hook(chunk, off, size);
> > >  
> > > -	/* if there are more than one fully free chunks, wake up grim reaper */
> > >  	if (chunk->free_bytes == pcpu_unit_size) {
> > > -		struct pcpu_chunk *pos;
> > > -
> > > +		/*
> > > +		 * If there are more than one fully free chunks,
> > > +		 * wake up grim reaper.
> > > +		 */
> > >  		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
> > >  			if (pos != chunk) {
> > >  				need_balance = true;
> > >  				break;
> > >  			}
> > > +
> > > +	} else if (chunk->nr_empty_pop_pages > chunk->nr_pages / 4) {
> > 
> > We should have this ignore the first and reserved chunks. While it
> > shouldn't be possible in theory, it would be nice to just make it
> > explicit here.
> 
> Ok, will do, makes sense to me!
> 
> > 
> > > +		/*
> > > +		 * If there is more than one chunk in the slot and
> > > +		 * at least 1/4 of its pages are empty, mark the chunk
> > > +		 * as a target for the depopulation. If there is more
> > > +		 * than one chunk like this, schedule an async balancing.
> > > +		 */
> > > +		int nslot = pcpu_chunk_slot(chunk);
> > > +
> > > +		list_for_each_entry(pos, &pcpu_slot[nslot], list)
> > > +			if (pos != chunk && !chunk->depopulate &&
> > > +			    !chunk->immutable) {
> > > +				chunk->depopulate = true;
> > > +				pcpu_nr_chunks_to_depopulate++;
> > > +				break;
> > > +			}
> > > +
> > > +		if (pcpu_nr_chunks_to_depopulate > 1)
> > > +			need_balance = true;
> > >  	}
> > >  
> > >  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> > > -- 
> > > 2.30.2
> > > 
> > 
> > Some questions I have:
> > 1. How do we prevent unnecessary scanning for atomic allocations?
> 
> Depopulated chunks tend to be at tail of the chunks lists in high(er) slots,
> so they seem to be the last target for an atomic allocation, if there is
> enough space in other chunks.
> 

I'm just not seeing a reason slot(PAGE_SIZE) can't have 2 chunks in it
and get the second chunk gets depopulated.

> > 2. Even in the normal case, should we try to pack future allocations
> > into a smaller # of chunks in after depopulation?
> 
> Well, there is one specific problem I'm trying to solve: if the percpu memory
> is heavily inflated by something (e.g. by creating a ton of cgroups or bpf maps),
> sometimes it's impossible to get the memory back at all, even if the absolute
> majority of percpu objects was released. In this case there are many chunks
> which are almost entirely empty, and the actual size of the needed percpu memory
> is way less that the number of populated pages.
> 
> We can look at the percpu memory fragmentation as a more fundamental problem,
> and probably the right thing to do long-term is to introduce some sort of a
> slab allocator. At least, we can put small allocations (aka percpu reference
> counters) into separate chunks. But this is obviously a way bigger change,
> which unlikely can do into any stable branches, so I'd treat it separately.
> Also, I'm not convinced that we really need it so much at the moment.
> If the percpu usage is more or less stable, I don't see any pathological
> fragmentation problem.
> 

That makes sense. If we narrow the scope to reclaiming inflated usage,
we could get rid of the 2 chunk in slot heuristic and scan up from
slot(PAGE_SIZE), leaving a reasonable # of free pages,
PCPU_EMPTY_POP_PAGES_LOW/HIGH, possibly just leaving those chunks
untouched and then free anything else before the final slot which will
be freed by the freeing path.

Thinking a little more about what you said earlier, they're basically
new chunks, anything PAGE_SIZE and up shouldn't expect to find a home
quickly.

> > 3. What is the right frequency to do depopulation scanning? I think of
> > the pcpu work item as a way to defer the 2 the freeing of chunks and in
> > a way more immediately replenish free pages. Depopulation isn't
> > necessarily as high a priority.
> 
> I think that the number of chunks which are potentially good for the
> depopulation is a good metric. I've chosen 2 as a threshold, but I'm
> fine with other ideas as well.
> 

We might need to untangle a few stats from global to per chunk_type.
Thoughts? Having 1 chunk in each type isn't necessarily a bad thing, but
having several 2+ is the problem?

> Thank you!
