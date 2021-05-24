Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E838E304
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhEXJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:13:52 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:38439 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhEXJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:13:51 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id A0FC4CAD42
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:12:22 +0100 (IST)
Received: (qmail 26294 invoked from network); 24 May 2021 09:12:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 09:12:22 -0000
Date:   Mon, 24 May 2021 10:12:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm/page_alloc: Scale the number of pages that are
 batch freed
Message-ID: <20210524091220.GC30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-5-mgorman@techsingularity.net>
 <8646d3ad-345f-7ec7-fe4a-ada2680487a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8646d3ad-345f-7ec7-fe4a-ada2680487a3@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:36:05PM -0700, Dave Hansen wrote:
> ...
> > +static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch)
> > +{
> > +	int min_nr_free, max_nr_free;
> > +
> > +	/* Check for PCP disabled or boot pageset */
> > +	if (unlikely(high < batch))
> > +		return 1;
> > +
> > +	min_nr_free = batch;
> > +	max_nr_free = high - batch;
> 
> I puzzled over this for a minute.  I *think* it means to say: "Leave at
> least one batch worth of pages in the pcp at all times so that the next
> allocation can still be satisfied from this pcp."
> 

Yes, I added a comment.

> > +	batch <<= pcp->free_factor;
> > +	if (batch < max_nr_free)
> > +		pcp->free_factor++;
> > +	batch = clamp(batch, min_nr_free, max_nr_free);
> > +
> > +	return batch;
> > +}
> > +
> >  static void free_unref_page_commit(struct page *page, unsigned long pfn,
> >  				   int migratetype)
> >  {
> >  	struct zone *zone = page_zone(page);
> >  	struct per_cpu_pages *pcp;
> > +	int high;
> >  
> >  	__count_vm_event(PGFREE);
> >  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
> >  	list_add(&page->lru, &pcp->lists[migratetype]);
> >  	pcp->count++;
> > -	if (pcp->count >= READ_ONCE(pcp->high))
> > -		free_pcppages_bulk(zone, READ_ONCE(pcp->batch), pcp);
> > +	high = READ_ONCE(pcp->high);
> > +	if (pcp->count >= high) {
> > +		int batch = READ_ONCE(pcp->batch);
> > +
> > +		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
> > +	}
> >  }
> >  
> >  /*
> > @@ -3531,6 +3555,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
> >  
> >  	local_lock_irqsave(&pagesets.lock, flags);
> >  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
> > +	pcp->free_factor >>= 1;
> >  	list = &pcp->lists[migratetype];
> >  	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
> >  	local_unlock_irqrestore(&pagesets.lock, flags);
> 
> A high-level description of the algorithm in the changelog would also be
> nice.  I *think* it's basically:
> 
> After hitting the high pcp mark, free one pcp->batch at a time.  But, as
> subsequent pcp free operations occur, keep doubling the size of the
> freed batches.  Cap them so that they always leave at least one
> pcp->batch worth of pages.  Scale the size back down by half whenever an
> allocation that consumes a page from the pcp occurs.
> 
> While I'd appreciate another comment or two, I do think this is worth
> doing, and the approach seems sound:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks, I added a few additional comments.

-- 
Mel Gorman
SUSE Labs
