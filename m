Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9834D83A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhC2T3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:29:04 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:37390 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhC2T2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:28:51 -0400
Received: by mail-io1-f46.google.com with SMTP id b10so13947829iot.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JfcydJJK9Ew4x9wRFFfjvaaCN7zavPvpQW41uS4gYZw=;
        b=I4CAUz7q/SUpXkdJRQypSOAlIlmWcXaMJQuwgGRcHg7dxwYvirTeKn1Mt1j86equDN
         bRcVUXUsDnxAbozxEe2mIM5tvKJLHvKggynodkc3819mLQssUOKYhQo/dS7fxAoUCv+G
         +cl8yaVAq4b5zbzXbX/6OG9wooVOvFAO6xQgOw/3ydOLBR0SaFgjRtKsCc99Ouz58yXB
         HxYVvE7fGaHM6LHpl2tqGeKLlliMQ3F+C8Z2rpHZsFHvM6uvMfl9Ew2buFinqxPSaned
         4TVv3Yv5215VlMkRsBbGYlDkCyxr+KxszUnOaNzo28nWfSGrVq/5SvEZRVTQd1l42SsO
         tAwQ==
X-Gm-Message-State: AOAM533qGTy/AVATBJAjoAXwBVCcTuRjEU3zVomPxsmZRLt1FJuna4Bp
        B3oLhwof1gdpx/Zdd1k2yq6eFOHeMKw=
X-Google-Smtp-Source: ABdhPJz8qS1XzwjPdX+HKCCi80RmU3mS/RnsAcbUmn0ZLOmP68wN6IhinRywSgLpqZ3AO9v+eZPabg==
X-Received: by 2002:a6b:7010:: with SMTP id l16mr20462854ioc.96.1617046130694;
        Mon, 29 Mar 2021 12:28:50 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id h2sm9739557ioj.30.2021.03.29.12.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:28:50 -0700 (PDT)
Date:   Mon, 29 Mar 2021 19:28:49 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 1/4] percpu: implement partial chunk depopulation
Message-ID: <YGIqcSUua1cfBijy@google.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-2-guro@fb.com>
 <YGIMdy2t1oLHDC4b@google.com>
 <YGIcgp/shX4HhXOk@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGIcgp/shX4HhXOk@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:29:22AM -0700, Roman Gushchin wrote:
> On Mon, Mar 29, 2021 at 05:20:55PM +0000, Dennis Zhou wrote:
> > On Wed, Mar 24, 2021 at 12:06:23PM -0700, Roman Gushchin wrote:
> > > This patch implements partial depopulation of percpu chunks.
> > > 
> > > As now, a chunk can be depopulated only as a part of the final
> > > destruction, when there are no more outstanding allocations. However
> > > to minimize a memory waste, it might be useful to depopulate a
> > > partially filed chunk, if a small number of outstanding allocations
> > > prevents the chunk from being reclaimed.
> > > 
> > > This patch implements the following depopulation process: it scans
> > > over the chunk pages, looks for a range of empty and populated pages
> > > and performs the depopulation. To avoid races with new allocations,
> > > the chunk is previously isolated. After the depopulation the chunk is
> > > returned to the original slot (but is appended to the tail of the list
> > > to minimize the chances of population).
> > > 
> > > Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
> > > the chunk can be concurrently moved to a different slot. So we need
> > > to isolate it again on each step. pcpu_alloc_mutex is held, so the
> > > chunk can't be populated/depopulated asynchronously.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  mm/percpu.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > > 
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index 6596a0a4286e..78c55c73fa28 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -2055,6 +2055,96 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> > >  	mutex_unlock(&pcpu_alloc_mutex);
> > >  }
> > >  
> > > +/**
> > > + * pcpu_shrink_populated - scan chunks and release unused pages to the system
> > > + * @type: chunk type
> > > + *
> > > + * Scan over all chunks, find those marked with the depopulate flag and
> > > + * try to release unused pages to the system. On every attempt clear the
> > > + * chunk's depopulate flag to avoid wasting CPU by scanning the same
> > > + * chunk again and again.
> > > + */
> > > +static void pcpu_shrink_populated(enum pcpu_chunk_type type)
> > > +{
> > > +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> > > +	struct pcpu_chunk *chunk;
> > > +	int slot, i, off, start;
> > > +
> > > +	spin_lock_irq(&pcpu_lock);
> > > +	for (slot = pcpu_nr_slots - 1; slot >= 0; slot--) {
> > > +restart:
> > > +		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> > > +			bool isolated = false;
> > > +
> > > +			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
> > > +				break;
> > > +
> > 
> > Deallocation makes me a little worried for the atomic case as now we
> > could in theory pathologically scan deallocated chunks before finding a
> > populated one.
> > 
> > I wonder if we should do something like once a chunk gets depopulated,
> > it gets deprioritized and then only once we exhaust looking through
> > allocated chunks we then find a depopulated chunk and add it back into
> > the rotation. Possibly just add another set of slots? I guess it adds a
> > few dimensions to pcpu_slots after the memcg change.
> 
> Please, take a look at patch 3 in the series ("percpu: on demand chunk depopulation").
> Chunks considered to be a good target for the depopulation are in advance
> marked with a special flag, so we'll actually try to depopulate only
> few chunks at once. While the total number of chunks is fairly low,
> I think it should work.
> 
> Another option is to link all such chunks into a list and scan over it,
> instead of iterating over all slots.
> 
> Adding new dimensions to pcpu_slots is an option too, but I hope we can avoid
> this, as it would complicate the code.
> 

Yeah, depopulation has been on the todo list for a while. It adds the
dimension/opportunity of bin packing by sidelining chunks and I'm
wondering if that is the right thing to do.

Do you have a rough idea of the distribution of # of chunks you're
seeing?

> > 
> > > +			for (i = 0, start = -1; i < chunk->nr_pages; i++) {
> > > +				if (!chunk->nr_empty_pop_pages)
> > > +					break;
> > > +
> > > +				/*
> > > +				 * If the page is empty and populated, start or
> > > +				 * extend the [start, i) range.
> > > +				 */
> > > +				if (test_bit(i, chunk->populated)) {
> > > +					off = find_first_bit(
> > > +						pcpu_index_alloc_map(chunk, i),
> > > +						PCPU_BITMAP_BLOCK_BITS);
> > > +					if (off >= PCPU_BITMAP_BLOCK_BITS) {
> > > +						if (start == -1)
> > > +							start = i;
> > > +						continue;
> > > +					}
> > 
> > Here instead of looking at the alloc_map, you can look at the
> > pcpu_block_md and look for a fully free contig_hint.
> 
> Good idea, will try in v2.
> 
> > 
> > > +				}
> > > +
> > > +				/*
> > > +				 * Otherwise check if there is an active range,
> > > +				 * and if yes, depopulate it.
> > > +				 */
> > > +				if (start == -1)
> > > +					continue;
> > > +
> > > +				/*
> > > +				 * Isolate the chunk, so new allocations
> > > +				 * wouldn't be served using this chunk.
> > > +				 * Async releases can still happen.
> > > +				 */
> > > +				if (!list_empty(&chunk->list)) {
> > > +					list_del_init(&chunk->list);
> > > +					isolated = true;
> > 
> > Maybe when freeing a chunk, we should consider just isolating it period
> > and preventing pcpu_free_area() from being able to add the chunk back
> > to a pcpu_slot.
> 
> You mean to add a check in pcpu_free_area() if the chunks is isolated?
> Yeah, sounds good to me, will do in v2.
> 

Could also be done in pcpu_chunk_relocate() so it's clear an isolated
chunk shouldn't be moved. But I think pcpu_free_area() should be the
only way the chunk can be moved on the list.

> Thank you!
> 
> > 
> > > +				}
> > > +
> > > +				spin_unlock_irq(&pcpu_lock);
> > > +				pcpu_depopulate_chunk(chunk, start, i);
> > > +				cond_resched();
> > > +				spin_lock_irq(&pcpu_lock);
> > > +
> > > +				pcpu_chunk_depopulated(chunk, start, i);
> > > +
> > > +				/*
> > > +				 * Reset the range and continue.
> > > +				 */
> > > +				start = -1;
> > > +			}
> > > +
> > > +			if (isolated) {
> > > +				/*
> > > +				 * The chunk could have been moved while
> > > +				 * pcpu_lock wasn't held. Make sure we put
> > > +				 * the chunk back into the slot and restart
> > > +				 * the scanning.
> > > +				 */
> > > +				if (list_empty(&chunk->list))
> > > +					list_add_tail(&chunk->list,
> > > +						      &pcpu_slot[slot]);
> > > +				goto restart;
> > > +			}
> > > +		}
> > > +	}
> > > +	spin_unlock_irq(&pcpu_lock);
> > > +}
> > > +
> > >  /**
> > >   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
> > >   * @work: unused
> > > -- 
> > > 2.30.2
> > > 
