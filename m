Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED88B354913
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhDEXC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:58 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:42588 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhDEXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:57 -0400
Received: by mail-io1-f47.google.com with SMTP id r193so10598948ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7FAxrpr5NVcCsUfbE21LFT03ax27o1Pts1X3zv3PHI=;
        b=Z4z0lz3+GkW4gV4ANHBNdPiHiA9RmPbbIorg9dZ3jtpjPJVT/xIV7bbo9KUznXCREZ
         EpTqlsTUSYGJn061w1EfJ/Ld8lvZD96vruuiTo0z+rKDHt5WsG+vEH1KpBQDcI8kt1Tu
         P5lGw+IbAQ7x6ZcTmiX5JWsRzsBO8S4HW1H+Bw/DtGICtKNay6p3ABRu2OTLajCGVNnm
         /I3XFHsNVHa5m/VVKIpUXoGtbE/ftCUn4FembW3MQ1e1OqrbRMW7uu1gyJgzdN8bqN34
         p47XqwVi40e3OsO/sAmZq9t4zQvQigijflnM93ju1Bc6Nr45B1swNFhDmLWs9iirR8dp
         8QZg==
X-Gm-Message-State: AOAM533WEFU08WhPWlN2f7jKjL7CbnmadDbJsEjGhp1zr7fsQeI2ya0M
        Ye6DtTWQJVzj573nnXQ5Thw=
X-Google-Smtp-Source: ABdhPJyoW1Hmg2MUGhFbDAFEmuSzWZ+H6IOY5NLkfVnQQpGZX4LCUM4RTkrRuD++NqTWVXlR38d7sA==
X-Received: by 2002:a05:6602:228f:: with SMTP id d15mr20384037iod.141.1617663769961;
        Mon, 05 Apr 2021 16:02:49 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id x8sm12457180iov.7.2021.04.05.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:02:49 -0700 (PDT)
Date:   Mon, 5 Apr 2021 23:02:48 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] percpu: implement partial chunk depopulation
Message-ID: <YGuXGEuuv8GVJszF@google.com>
References: <20210401214301.1689099-1-guro@fb.com>
 <20210401214301.1689099-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401214301.1689099-6-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:43:01PM -0700, Roman Gushchin wrote:
> This patch implements partial depopulation of percpu chunks.
> 
> As now, a chunk can be depopulated only as a part of the final
> destruction, if there are no more outstanding allocations. However
> to minimize a memory waste it might be useful to depopulate a
> partially filed chunk, if a small number of outstanding allocations
> prevents the chunk from being fully reclaimed.
> 
> This patch implements the following depopulation process: it scans
> over the chunk pages, looks for a range of empty and populated pages
> and performs the depopulation. To avoid races with new allocations,
> the chunk is previously isolated. After the depopulation the chunk is
> returned to the original slot (but is appended to the tail of the list
> to minimize the chances of population).
> 
> Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
> the chunk can be concurrently moved to a different slot. To prevent
> this, bool chunk->isolated flag is introduced. If set, the chunk can't
> be moved to a different slot.
> 
> The depopulation is scheduled on the free path. Is the chunk:
>   1) has more than 1/8 of total pages free and populated
>   2) the system has enough free percpu pages aside of this chunk
>   3) isn't the reserved chunk
>   4) isn't the first chunk
>   5) isn't entirely free
> it's a good target for depopulation.
> 
> If so, the chunk is moved to a special pcpu_depopulate_list,
> chunk->isolate flag is set and the async balancing is scheduled.
> 
> The async balancing moves pcpu_depopulate_list to a local list
> (because pcpu_depopulate_list can be changed when pcpu_lock is
> releases), and then tries to depopulate each chunk. Successfully
> or not, at the end all chunks are returned to appropriate slots
> and their isolated flags are cleared.
> 
> Many thanks to Dennis Zhou for his great ideas and a very constructive
> discussion which led to many improvements in this patchset!
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu-internal.h |   1 +
>  mm/percpu.c          | 101 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 095d7eaa0db4..ff318752915d 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -67,6 +67,7 @@ struct pcpu_chunk {
>  
>  	void			*data;		/* chunk data */
>  	bool			immutable;	/* no [de]population allowed */
> +	bool			isolated;	/* isolated from chunk slot lists */
>  	int			start_offset;	/* the overlap with the previous
>  						   region to have a page aligned
>  						   base_addr */
> diff --git a/mm/percpu.c b/mm/percpu.c
> index e20119668c42..dae0b870e10a 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -181,6 +181,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
>   */
>  int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
>  
> +/*
> + * List of chunks with a lot of free pages. Used to depopulate them
> + * asynchronously.
> + */
> +static LIST_HEAD(pcpu_depopulate_list);
> +

Now that pcpu_nr_empty_pop_pages is per chunk_type I think the
depopulate_list should be per chunk_type.

>  /*
>   * The number of populated pages in use by the allocator, protected by
>   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> @@ -542,7 +548,7 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
>  {
>  	int nslot = pcpu_chunk_slot(chunk);
>  
> -	if (oslot != nslot)
> +	if (!chunk->isolated && oslot != nslot)
>  		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
>  }
>  
> @@ -2048,6 +2054,82 @@ static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
>  	}
>  }
>  
> +/**
> + * pcpu_shrink_populated - scan chunks and release unused pages to the system
> + * @type: chunk type
> + *
> + * Scan over all chunks, find those marked with the depopulate flag and
> + * try to release unused pages to the system. On every attempt clear the
> + * chunk's depopulate flag to avoid wasting CPU by scanning the same
> + * chunk again and again.
> + */

There no longer is a depopulate flag.

> +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> +{
> +	struct pcpu_block_md *block;
> +	struct pcpu_chunk *chunk, *tmp;
> +	LIST_HEAD(to_depopulate);
> +	int i, start;
> +
> +	spin_lock_irq(&pcpu_lock);
> +
> +	list_splice_init(&pcpu_depopulate_list, &to_depopulate);
> +
> +	list_for_each_entry_safe(chunk, tmp, &to_depopulate, list) {
> +		WARN_ON(chunk->immutable);
> +
> +		for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> +			/*
> +			 * If the chunk has no empty pages or
> +			 * we're short on empty pages in general,
> +			 * just put the chunk back into the original slot.
> +			 */
> +			if (!chunk->nr_empty_pop_pages ||
> +			    pcpu_nr_empty_pop_pages[type] <
> +			    PCPU_EMPTY_POP_PAGES_HIGH)
> +				break;

This isn't ideal because if we do drop below PCPU_EMPTY_POP_PAGES_HIGH
because of the next deallocation range, then we're leaving the region
that's going to get allocated next unpopulated and the populated pages
stranded later on. See below for more discussion.

> +
> +			/*
> +			 * If the page is empty and populated, start or
> +			 * extend the [start, i) range.
> +			 */
> +			block = chunk->md_blocks + i;
> +			if (block->contig_hint == PCPU_BITMAP_BLOCK_BITS &&
> +			    test_bit(i, chunk->populated)) {
> +				if (start == -1)
> +					start = i;
> +				continue;
> +			}
> +
> +			/*
> +			 * Otherwise check if there is an active range,
> +			 * and if yes, depopulate it.
> +			 */
> +			if (start == -1)
> +				continue;
> +
> +			spin_unlock_irq(&pcpu_lock);
> +			pcpu_depopulate_chunk(chunk, start, i);
> +			cond_resched();
> +			spin_lock_irq(&pcpu_lock);
> +
> +			pcpu_chunk_depopulated(chunk, start, i);
> +
> +			/*
> +			 * Reset the range and continue.
> +			 */
> +			start = -1;
> +		}
> +
> +		/*
> +		 * Return the chunk to the corresponding slot.
> +		 */
> +		chunk->isolated = false;
> +		pcpu_chunk_relocate(chunk, -1);
> +	}
> +
> +	spin_unlock_irq(&pcpu_lock);
> +}
> +
>  /**
>   * pcpu_balance_populated - manage the amount of populated pages
>   * @type: chunk type
> @@ -2078,6 +2160,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
>  		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type];
>  		pcpu_grow_populated(type, nr_to_pop);
> +	} else if (!list_empty(&pcpu_depopulate_list)) {
> +		pcpu_shrink_populated(type);
>  	}
>  }
>  
> @@ -2135,7 +2219,12 @@ void free_percpu(void __percpu *ptr)
>  
>  	pcpu_memcg_free_hook(chunk, off, size);
>  
> -	/* if there are more than one fully free chunks, wake up grim reaper */
> +	/*
> +	 * If there are more than one fully free chunks, wake up grim reaper.
> +	 * Otherwise if at least 1/8 of its pages are empty and there is no
> +	 * system-wide shortage of empty pages aside from this chunk, isolate
> +	 * the chunk and schedule an async depopulation.
> +	 */
>  	if (chunk->free_bytes == pcpu_unit_size) {
>  		struct pcpu_chunk *pos;
>  
> @@ -2144,6 +2233,14 @@ void free_percpu(void __percpu *ptr)
>  				need_balance = true;
>  				break;
>  			}
> +	} else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
> +		   !chunk->isolated &&
> +		   chunk->nr_empty_pop_pages >= chunk->nr_pages / 8 &&
> +		   pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> +		   PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages) {
> +		list_move(&chunk->list, &pcpu_depopulate_list);

I'm missing something here quite possibly. Right now, when we free,
we're not doing anything to place the floating empty pages in a
particular chunk (such as the first chunk in slot[PAGE_SIZE]). If the
ordering is bad, we can end up leaving the float pages in some random
chunk and because we scan forwards, they'll be populated pages at the
end of a chunk. Not exactly the most useful.

I wonder if we should free everything in the depopulate list and then
scan up and repopulate a # of pages scanning up from slot(PAGE_SIZE)?
This would add additional churn though. If not we need to switch the
direction of freeing.

So questions:
1. How do we keep the float pages in a way that they're most likely to
be found next by the allocator?
2. Do we need to change the direction of freeing or change the
accounting above?

> +		chunk->isolated = true;
> +		need_balance = true;
>  	}
>  
>  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> -- 
> 2.30.2
> 
