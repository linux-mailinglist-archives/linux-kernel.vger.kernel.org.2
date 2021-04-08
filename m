Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27EC357A68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 04:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhDHCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 22:34:22 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:47101 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:34:20 -0400
Received: by mail-io1-f45.google.com with SMTP id j26so585750iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 19:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0i0J//0G8Aaxd3DIsF46N2+ARX5bagEX+gcAs1OlF0=;
        b=p8fiogk4skR9bwKMPlkZLcOIeFxXOxzIp0DQla3b1w4VDMUE/uUFs+FAavspXMDTPw
         FqDCsNyjrj6+rqDVGohrD9QxEubDU2rkyc+5czm4Hek/6UvttVqG9rcpWyVtO2V7j9FW
         5SMP2LixYCydI+l8giDhfpqBNPGfjOcC71n5lpaONtwAa811dvxMCpRJQqtuu4kIdC3h
         4eq1A/5Z1bmuHtlFlv2oy73GX2+KM1Azz7xJ9p3BbTIec+BYHyBKv4czu4cWetgI7w2V
         Ld5GojdnhLw/BJTJNli/SprNHvEDahAHj+ypKewtY6iKUmOyUps50ilUADysV8zKny9N
         gLQA==
X-Gm-Message-State: AOAM530RgSYWjdKdk5WJjzmjCu312bSI8cnp47ApnOBsAuJvvqS6epqR
        vsDGhk4vKgrt5+eXNz1o4e4=
X-Google-Smtp-Source: ABdhPJwCMRLoceAAPTxPi1Au1jSo8saJxg0wpxHfIUPvTXh2An/dd3yxI36+i1R3Qc+lAdH2UnQhzA==
X-Received: by 2002:a02:cd33:: with SMTP id h19mr6456988jaq.88.1617849249720;
        Wed, 07 Apr 2021 19:34:09 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id k6sm3518903ilo.44.2021.04.07.19.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 19:34:09 -0700 (PDT)
Date:   Thu, 8 Apr 2021 02:34:08 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] percpu: implement partial chunk depopulation
Message-ID: <YG5roL/l7qt+9WAM@google.com>
References: <20210407182618.2728388-1-guro@fb.com>
 <20210407182618.2728388-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407182618.2728388-6-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 11:26:18AM -0700, Roman Gushchin wrote:
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
> sidelined to a special list or freed. New allocations can't be served
> using a sidelined chunk. The chunk can be moved back to a corresponding
> slot if there are not enough chunks with empty populated pages.
> 
> The depopulation is scheduled on the free path. Is the chunk:
>   1) has more than 1/4 of total pages free and populated
>   2) the system has enough free percpu pages aside of this chunk
>   3) isn't the reserved chunk
>   4) isn't the first chunk
>   5) isn't entirely free
> it's a good target for depopulation. If it's already depopulated
> but got free populated pages, it's a good target too.
> The chunk is moved to a special pcpu_depopulate_list, chunk->isolate
> flag is set and the async balancing is scheduled.
> 
> The async balancing moves pcpu_depopulate_list to a local list
> (because pcpu_depopulate_list can be changed when pcpu_lock is
> releases), and then tries to depopulate each chunk.  The depopulation
> is performed in the reverse direction to keep populated pages close to
> the beginning, if the global number of empty pages is reached.
> Depopulated chunks are sidelined to prevent further allocations.
> Skipped and fully empty chunks are returned to the corresponding slot.
> 
> On the allocation path, if there are no suitable chunks found,
> the list of sidelined chunks in scanned prior to creating a new chunk.
> If there is a good sidelined chunk, it's placed back to the slot
> and the scanning is restarted.
> 
> Many thanks to Dennis Zhou for his great ideas and a very constructive
> discussion which led to many improvements in this patchset!
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu-internal.h |   2 +
>  mm/percpu.c          | 164 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 095d7eaa0db4..8e432663c41e 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -67,6 +67,8 @@ struct pcpu_chunk {
>  
>  	void			*data;		/* chunk data */
>  	bool			immutable;	/* no [de]population allowed */
> +	bool			isolated;	/* isolated from chunk slot lists */
> +	bool			depopulated;    /* sidelined after depopulation */
>  	int			start_offset;	/* the overlap with the previous
>  						   region to have a page aligned
>  						   base_addr */
> diff --git a/mm/percpu.c b/mm/percpu.c
> index e20119668c42..0a5a5e84e0a4 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -181,6 +181,19 @@ static LIST_HEAD(pcpu_map_extend_chunks);
>   */
>  int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
>  
> +/*
> + * List of chunks with a lot of free pages.  Used to depopulate them
> + * asynchronously.
> + */
> +static struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
> +
> +/*
> + * List of previously depopulated chunks.  They are not usually used for new
> + * allocations, but can be returned back to service if a need arises.
> + */
> +static struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
> +
> +
>  /*
>   * The number of populated pages in use by the allocator, protected by
>   * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> @@ -542,6 +555,12 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
>  {
>  	int nslot = pcpu_chunk_slot(chunk);
>  
> +	/*
> +	 * Keep isolated and depopulated chunks on a sideline.
> +	 */
> +	if (chunk->isolated || chunk->depopulated)
> +		return;
> +
>  	if (oslot != nslot)
>  		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
>  }
> @@ -1778,6 +1797,25 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		}
>  	}
>  
> +	/* search through sidelined depopulated chunks */
> +	list_for_each_entry(chunk, &pcpu_sideline_list[type], list) {
> +		struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> +		int bit_off;
> +
> +		/*
> +		 * If the allocation can fit in the chunk's contig hint,
> +		 * place the chunk back into corresponding slot and restart
> +		 * the scanning.
> +		 */
> +		bit_off = ALIGN(chunk_md->contig_hint_start, align) -
> +			chunk_md->contig_hint_start;
> +		if (bit_off + bits > chunk_md->contig_hint) {
> +			chunk->depopulated = false;
> +			pcpu_chunk_relocate(chunk, -1);
> +			goto restart;
> +		}

This check should be bit_off + bits < chunk_md->contig_hint.
Can you please factor that out to a function:

pcpu_check_chunk_hint(chunk_md, bits)
{
  int bit_off = (ALIGN(chunk_md->contig_hint_start, align) -
                 chunk_md->contig_hint_start);

  return (bit_off + bits < chunk_md->contig_hint);
}

Then your use case can just call pcpu_check_chunk_hint() and the other
user pcpu_find_block_fit() can use !pcpu_check_chunk_hint().

> +	}
> +
>  	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
>  	/*
> @@ -2048,6 +2086,106 @@ static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
>  	}
>  }
>  
> +/**
> + * pcpu_shrink_populated - scan chunks and release unused pages to the system
> + * @type: chunk type
> + *
> + * Scan over chunks in the depopulate list, try to release unused populated
> + * pages to the system.  Depopulated chunks are sidelined to prevent further
> + * allocations without a need.  Skipped and fully free chunks are returned
> + * to corresponding slots.  Stop depopulating if the number of empty populated
> + * pages reaches the threshold.  Each chunk is scanned in the reverse order to
> + * keep populated pages close to the beginning of the chunk.
> + */
> +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> +{
> +	struct pcpu_block_md *block;
> +	struct pcpu_chunk *chunk, *tmp;
> +	LIST_HEAD(to_depopulate);
> +	bool depopulated;
> +	int i, end;
> +
> +	spin_lock_irq(&pcpu_lock);
> +
> +	list_splice_init(&pcpu_depopulate_list[type], &to_depopulate);
> +
> +	list_for_each_entry_safe(chunk, tmp, &to_depopulate, list) {
> +		WARN_ON(chunk->immutable);
> +		depopulated = false;
> +
> +		/*
> +		 * Scan chunk's pages in the reverse order to keep populated
> +		 * pages close to the beginning of the chunk.
> +		 */
> +		for (i = chunk->nr_pages - 1, end = -1; i >= 0; i--) {
> +			/*
> +			 * If the chunk has no empty pages or
> +			 * we're short on empty pages in general,
> +			 * just put the chunk back into the original slot.
> +			 */
> +			if (!chunk->nr_empty_pop_pages ||
> +			    pcpu_nr_empty_pop_pages[type] <=
> +			    PCPU_EMPTY_POP_PAGES_HIGH)
> +				break;
> +
> +			/*
> +			 * If the page is empty and populated, start or
> +			 * extend the (i, end) range.  If i == 0, decrease
> +			 * i and perform the depopulation to cover the last
> +			 * (first) page in the chunk.
> +			 */
> +			block = chunk->md_blocks + i;
> +			if (block->contig_hint == PCPU_BITMAP_BLOCK_BITS &&
> +			    test_bit(i, chunk->populated)) {
> +				if (end == -1)
> +					end = i;
> +				if (i > 0)
> +					continue;
> +				i--;
> +			}
> +
> +			/*
> +			 * Otherwise check if there is an active range,
> +			 * and if yes, depopulate it.
> +			 */
> +			if (end == -1)
> +				continue;
> +
> +			depopulated = true;
> +
> +			spin_unlock_irq(&pcpu_lock);
> +			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
> +			cond_resched();
> +			spin_lock_irq(&pcpu_lock);
> +
> +			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
> +
> +			/*
> +			 * Reset the range and continue.
> +			 */
> +			end = -1;
> +		}
> +
> +		chunk->isolated = false;
> +		if (chunk->free_bytes == pcpu_unit_size || !depopulated) {
> +			/*
> +			 * If the chunk is empty or hasn't been depopulated,
> +			 * return it to the original slot.
> +			 */
> +			pcpu_chunk_relocate(chunk, -1);
> +		} else {
> +			/*
> +			 * Otherwise put the chunk to the list of depopulated
> +			 * chunks.
> +			 */
> +			chunk->depopulated = true;
> +			list_move(&chunk->list, &pcpu_sideline_list[type]);
> +		}
> +	}
> +
> +	spin_unlock_irq(&pcpu_lock);
> +}
> +
>  /**
>   * pcpu_balance_populated - manage the amount of populated pages
>   * @type: chunk type
> @@ -2078,6 +2216,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
>  		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type];
>  		pcpu_grow_populated(type, nr_to_pop);
> +	} else if (!list_empty(&pcpu_depopulate_list[type])) {
> +		pcpu_shrink_populated(type);
>  	}
>  }
>  
> @@ -2135,7 +2275,13 @@ void free_percpu(void __percpu *ptr)
>  
>  	pcpu_memcg_free_hook(chunk, off, size);
>  
> -	/* if there are more than one fully free chunks, wake up grim reaper */
> +	/*
> +	 * If there are more than one fully free chunks, wake up grim reaper.
> +	 * Otherwise if at least 1/4 of its pages are empty and there is no
> +	 * system-wide shortage of empty pages aside from this chunk, isolate
> +	 * the chunk and schedule an async depopulation.  If the chunk was
> +	 * depopulated previously and got free pages, depopulate it too.
> +	 */
>  	if (chunk->free_bytes == pcpu_unit_size) {
>  		struct pcpu_chunk *pos;
>  
> @@ -2144,6 +2290,16 @@ void free_percpu(void __percpu *ptr)
>  				need_balance = true;
>  				break;
>  			}
> +	} else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
> +		   !chunk->isolated &&
> +		   pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> +		   PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&

nit: can you add parethesis around this condition?

> +		   ((chunk->depopulated && chunk->nr_empty_pop_pages) ||
> +		    (chunk->nr_empty_pop_pages >= chunk->nr_pages / 4))) {
> +		list_move(&chunk->list, &pcpu_depopulate_list[pcpu_chunk_type(chunk)]);
> +		chunk->isolated = true;
> +		chunk->depopulated = false;
> +		need_balance = true;
>  	}
>  
>  	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
> @@ -2571,10 +2727,14 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]) *
>  		      PCPU_NR_CHUNK_TYPES);
>  
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
>  		for (i = 0; i < pcpu_nr_slots; i++)
>  			INIT_LIST_HEAD(&pcpu_chunk_list(type)[i]);
>  
> +		INIT_LIST_HEAD(&pcpu_depopulate_list[type]);
> +		INIT_LIST_HEAD(&pcpu_sideline_list[type]);
> +	}
> +
>  	/*
>  	 * The end of the static region needs to be aligned with the
>  	 * minimum allocation size as this offsets the reserved and
> -- 
> 2.30.2
> 

Thanks,
Dennis
