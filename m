Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF23273DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhB1Sva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 13:51:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:41406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhB1Sv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 13:51:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F4060AEE6;
        Sun, 28 Feb 2021 18:50:46 +0000 (UTC)
Date:   Sun, 28 Feb 2021 19:50:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 1/7] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210228185044.GA3929@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-2-osalvador@suse.de>
 <60afb5ca-230e-265f-9579-dac66a152c33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60afb5ca-230e-265f-9579-dac66a152c33@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:58:01PM +0100, David Hildenbrand wrote:
> > In this way, we have:
> > 
> > (start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> > (buddy_start_pfn, end_pfn]       = Initialized and sent to buddy
> 
> nit: shouldn't it be
> 
> [start_pfn, buddy_start_pfn - 1]
> [buddy_start_pfn, end_pfn - 1]
> 
> or
> 
> [start_pfn, buddy_start_pfn)
> [buddy_start_pfn, end_pfn)
> 
> (I remember that "[" means inclusive and "(" means exclusive, I might be wrong :) )
> 
> I actually prefer the first variant.

Let us go witht the first variant, I guess it is more clear.

> > -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> > +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> > +			       unsigned long buddy_start_pfn)
> >   {
> >   	const unsigned long end_pfn = start_pfn + nr_pages;
> > -	unsigned long pfn;
> > +	unsigned long pfn = buddy_start_pfn;
> > +
> > +	/*
> > +	 * When using memmap_on_memory, the range might be unaligned as the
> > +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> > +	 */
> > +	if (pfn & ((1 << (MAX_ORDER - 1)) - 1)) {
> 
> if (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES))

Will change

> 
> > +		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> > +		pfn += 1 << pageblock_order;
> 
> pfn += pageblock_nr_pages;
> 
> Can you add a comment why we can be sure that we are off by  a single pageblock? What about s390x where a MAX_ORDER_NR_PAGES == 4 * pageblock_nr_pages?
> 
> Would it make thing simpler to just do a
> 
> while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
> 	(*online_page_callback)(pfn_to_page(pfn), 0);
> 	pfn++;
> }

Honestly, I did not spend much time thinking on other platforms other
than arm64/x86_64.
But I think that that would be the universal solution as we do not make
any assumptions.

I will replace it.

> > +bool mhp_supports_memmap_on_memory(unsigned long size)
> > +{
> > +	return memmap_on_memory_enabled &&
> > +	       size == memory_block_size_bytes();
> 
> Regarding my other comments as reply to the other patches, I'd move all magic you have when trying to enable right here.

Ok, will do.

> > @@ -1613,7 +1658,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> >   	zone_pcp_disable(zone);
> >   	/* set above range as isolated */
> > -	ret = start_isolate_page_range(start_pfn, end_pfn,
> > +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
> >   				       MIGRATE_MOVABLE,
> >   				       MEMORY_OFFLINE | REPORT_FAILURE);
> 
> Did you take care to properly adjust undo_isolate_page_range() as well? I can't spot it.

No, I did not. Good that you noticed :-)

Will fix it up in the next version.

> > +static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> > +{
> > +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> > +
> > +	*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> > +	return mem->nr_vmemmap_pages;
> > +}
> > +
> 
> I think you can do this easier, all you want to know is if there
> is any block that has nr_vmemmap_pages set - and return the value.
> 
> static int first_set_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> {
> 	/* If not set, continue with the next block. */
> 	return mem->nr_vmemmap_pages;
> }

Yeah, less code.
Will fix it.

> 
> ...
> > +		walk_memory_blocks(start, size, &nr_vmemmap_pages,
> > +					 get_nr_vmemmap_pages_cb);
> 
> ...
> 
> mem->nr_vmemmap_pages = walk_memory_blocks(start ...)
> 
> 
> 
> Looks quite promising, only a couple of things to fine-tune :) Thanks!

Thanks for having a look, that is highly appreciated!

Let us see if we can polish the minor things that are missing and target
this for the next release.


-- 
Oscar Salvador
SUSE L3
