Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3134D5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC2RV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:21:26 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:33621 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhC2RU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:20:58 -0400
Received: by mail-io1-f51.google.com with SMTP id n198so13606235iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMWTErVQxa6Br5eKuQTUrDw3Akw8/5fDwCd4vZ5RQb8=;
        b=QmSZbTizoDWf5qxAeNVKUHi+braOTzDs8GIo5sgeCZ4p/1f/MYeLr/n8QTIUIR2VTQ
         OX552heaixJzwu2KiTutndQyWJr57UFWeA1dm+JJxYXpiA0JCByLD1jHuq+8wsl1+Erq
         iCMYga/ItSsQ5qipQxpC0L3Bbl0XtMsVvwbjE/CyjpC4rackZJ/OgmvqtN2BTv08e46q
         sG+7q17cgaw6Q5wrBRMFdcfR81Tq3oR7rHvlzAE6+A1ENz/sKxcdPLhNOMl5W84VHDgN
         vl0YhMthGmNh0pS5HOqfrsTRgq3IPP3knmescniVKKWDhbaVSra1fA0j/QOMipIAUavK
         zpYQ==
X-Gm-Message-State: AOAM531TprjLeowMLIJw6hcFGIFeku5LpQpnQWzL3C5PtN7n3UBi+GWW
        m/jMu6fdiuUExcS+6O7dAgwvXsl5vL0=
X-Google-Smtp-Source: ABdhPJxpxNa7tBKLkU+8bOLFCusW0dMTKwreFmJoWNbcB3LeiDx4h9RarXnIyWZYTp1hAbjohLSu4w==
X-Received: by 2002:a6b:7501:: with SMTP id l1mr20733718ioh.92.1617038457633;
        Mon, 29 Mar 2021 10:20:57 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id x4sm4424915ilo.43.2021.03.29.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 10:20:57 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:20:55 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 1/4] percpu: implement partial chunk depopulation
Message-ID: <YGIMdy2t1oLHDC4b@google.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324190626.564297-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:06:23PM -0700, Roman Gushchin wrote:
> This patch implements partial depopulation of percpu chunks.
> 
> As now, a chunk can be depopulated only as a part of the final
> destruction, when there are no more outstanding allocations. However
> to minimize a memory waste, it might be useful to depopulate a
> partially filed chunk, if a small number of outstanding allocations
> prevents the chunk from being reclaimed.
> 
> This patch implements the following depopulation process: it scans
> over the chunk pages, looks for a range of empty and populated pages
> and performs the depopulation. To avoid races with new allocations,
> the chunk is previously isolated. After the depopulation the chunk is
> returned to the original slot (but is appended to the tail of the list
> to minimize the chances of population).
> 
> Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
> the chunk can be concurrently moved to a different slot. So we need
> to isolate it again on each step. pcpu_alloc_mutex is held, so the
> chunk can't be populated/depopulated asynchronously.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 6596a0a4286e..78c55c73fa28 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2055,6 +2055,96 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
>  	mutex_unlock(&pcpu_alloc_mutex);
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
> +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> +{
> +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> +	struct pcpu_chunk *chunk;
> +	int slot, i, off, start;
> +
> +	spin_lock_irq(&pcpu_lock);
> +	for (slot = pcpu_nr_slots - 1; slot >= 0; slot--) {
> +restart:
> +		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> +			bool isolated = false;
> +
> +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> +				break;
> +

Deallocation makes me a little worried for the atomic case as now we
could in theory pathologically scan deallocated chunks before finding a
populated one.

I wonder if we should do something like once a chunk gets depopulated,
it gets deprioritized and then only once we exhaust looking through
allocated chunks we then find a depopulated chunk and add it back into
the rotation. Possibly just add another set of slots? I guess it adds a
few dimensions to pcpu_slots after the memcg change.

> +			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> +				if (!chunk->nr_empty_pop_pages)
> +					break;
> +
> +				/*
> +				 * If the page is empty and populated, start or
> +				 * extend the [start, i) range.
> +				 */
> +				if (test_bit(i, chunk->populated)) {
> +					off = find_first_bit(
> +						pcpu_index_alloc_map(chunk, i),
> +						PCPU_BITMAP_BLOCK_BITS);
> +					if (off >= PCPU_BITMAP_BLOCK_BITS) {
> +						if (start == -1)
> +							start = i;
> +						continue;
> +					}

Here instead of looking at the alloc_map, you can look at the
pcpu_block_md and look for a fully free contig_hint.

> +				}
> +
> +				/*
> +				 * Otherwise check if there is an active range,
> +				 * and if yes, depopulate it.
> +				 */
> +				if (start == -1)
> +					continue;
> +
> +				/*
> +				 * Isolate the chunk, so new allocations
> +				 * wouldn't be served using this chunk.
> +				 * Async releases can still happen.
> +				 */
> +				if (!list_empty(&chunk->list)) {
> +					list_del_init(&chunk->list);
> +					isolated = true;

Maybe when freeing a chunk, we should consider just isolating it period
and preventing pcpu_free_area() from being able to add the chunk back
to a pcpu_slot.

> +				}
> +
> +				spin_unlock_irq(&pcpu_lock);
> +				pcpu_depopulate_chunk(chunk, start, i);
> +				cond_resched();
> +				spin_lock_irq(&pcpu_lock);
> +
> +				pcpu_chunk_depopulated(chunk, start, i);
> +
> +				/*
> +				 * Reset the range and continue.
> +				 */
> +				start = -1;
> +			}
> +
> +			if (isolated) {
> +				/*
> +				 * The chunk could have been moved while
> +				 * pcpu_lock wasn't held. Make sure we put
> +				 * the chunk back into the slot and restart
> +				 * the scanning.
> +				 */
> +				if (list_empty(&chunk->list))
> +					list_add_tail(&chunk->list,
> +						      &pcpu_slot[slot]);
> +				goto restart;
> +			}
> +		}
> +	}
> +	spin_unlock_irq(&pcpu_lock);
> +}
> +
>  /**
>   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
>   * @work: unused
> -- 
> 2.30.2
> 
