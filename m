Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98113666DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhDUIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:16:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234010AbhDUIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3908B137;
        Wed, 21 Apr 2021 08:15:49 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:15:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210421081546.GD22456@linux>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de>
 <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:56:03PM +0200, Michal Hocko wrote:
> On Fri 16-04-21 13:24:07, Oscar Salvador wrote:
> > Physical memory hotadd has to allocate a memmap (struct page array) for
> > the newly added memory section. Currently, alloc_pages_node() is used
> > for those allocations.
> > 
> > This has some disadvantages:
> >  a) an existing memory is consumed for that purpose
> >     (eg: ~2MB per 128MB memory section on x86_64)
> 
> I would extend this slightly. This can even lead to extreme cases where
> system goes OOM because the physically hotplugged memory depletes the
> available memory before it is onlined.

Ok.

> > Vmemap page tables can map arbitrary memory.
> > That means that we can simply use the beginning of each memory section and
> > map struct pages there.
> 
> Again this can be confusing because this is not what is really happening
> in practice because we are going to have a multisection memory block
> where all sections will be backed by a common reserved space rather than
> per section sparse space. I would go with
> 
> "
> Vmemap page tables can map arbitrary memory. That means that we can
> reserve a part of the physically hotadded memory to back vmemmap page
> tables. This implementation uses the beggining of the hotplugged memory
> for that purpose.
> "

Yeah, I thought I fixed that, it should have been "That means that we can simply
use the beginning of each memory block...", but I am ok with your rewording.

> There is quite a large leap from __populate_section_memmap to the
> memory_block that deserves explaining to not lose all the subtle things
> discussed in the past. I think it should be made clear why all the fuzz.
> I would structure it as follows:
> "
> There are some non-obiously things to consider though.  Vmemmap
> pages are allocated/freed during the memory hotplug events
> (add_memory_resource, try_remove_memory) when the memory is
> added/removed. This means that the reserved physical range is not online
> yet it is used. The most obvious side effect is that pfn_to_online_page
> returns NULL for those pfns. The current design expects that this
> should be OK as the hotplugged memory is considered a garbage until it
> is onlined. For example hibernation wouldn't save the content of those
> vmmemmaps into the image so it wouldn't be restored on resume but this
> should be OK as there no real content to recover anyway while metadata
> is reachable from other data structures (e.g. vmemmap page tables).
> 
> The reserved space is therefore (de)initialized during the {on,off}line
> events (mhp_{de}init_memmap_on_memory). That is done by extracting page
> allocator independent initialization from the regular onlining path.
> The primary reason to handle the reserved space outside of {on,off}line_pages
> is to make each initialization specific to the purpose rather than
> special case them in a single function.

Ok, that definitely adds a valuable information.

> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index f209925a5d4e..2e2b2f654f0a 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -173,16 +173,72 @@ static int memory_block_online(struct memory_block *mem)
> >  {
> >  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> >  	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> > +	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> > +	struct zone *zone;
> > +	int ret;
> > +
> > +	zone = zone_for_pfn_range(mem->online_type, mem->nid, start_pfn, nr_pages);
> > +
> > +	/*
> > +	 * Although vmemmap pages have a different lifecycle than the pages
> > +	 * they describe (they remain until the memory is unplugged), doing
> > +	 * their initialization and accounting at memory onlining/offlining
> > +	 * stage simplifies things a lot.
> 
> "simplify things a lot" is not really helpful to people reading the
> code. It would be much better to state reasons here. I would go with
> 	 * stage helps to keep accounting easier to follow - e.g.
> 	 * vmemmaps belong to the same zone as the onlined memory.

Ok

> >  static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> >  {
> >  	const unsigned long end_pfn = start_pfn + nr_pages;
> > -	unsigned long pfn;
> > +	unsigned long pfn = start_pfn;
> > +
> > +	while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
> > +		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> > +		pfn += pageblock_nr_pages;
> > +	}
> 
> I believe we do not need to check for nr_pages as the actual operation
> will never run out of range in practice but the code is more subtle than

If you mean that IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES) can go, that is not
right.
Of course, with your changes below it would not be necesary.

> necessary. Using two different iteration styles is also hurting the code
> readability. I would go with the following
> 	for (pfn = start_pfn; pfn < end_pfn; ) {
> 		unsigned long order = min(MAX_ORDER - 1UL, __ffs(pfn));
> 
> 		while (start + (1UL << order) > end_pfn)
>                         order--;
> 		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> 		pfn += 1 << order;
> 	}
> 
> which is what __free_pages_memory does already.

this is kinda what I used to have in the early versions, but it was agreed
with David to split it in two loops to make it explicit.
I can go back to that if it is preferred.

> > +	if (memmap_on_memory) {
> > +		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
> > +						      get_nr_vmemmap_pages_cb);
> > +		if (nr_vmemmap_pages) {
> > +			if (size != memory_block_size_bytes()) {
> > +				pr_warn("Refuse to remove %#llx - %#llx,"
> > +					"wrong granularity\n",
> > +					start, start + size);
> > +				return -EINVAL;
> > +			}
> > +
> > +			/*
> > +			 * Let remove_pmd_table->free_hugepage_table do the
> > +			 * right thing if we used vmem_altmap when hot-adding
> > +			 * the range.
> > +			 */
> > +			mhp_altmap.alloc = nr_vmemmap_pages;
> > +			altmap = &mhp_altmap;
> > +		}
> > +	}
> > +
> >  	/* remove memmap entry */
> >  	firmware_map_remove(start, start + size, "System RAM");
> 
> I have to say I still dislike this and I would just wrap it inside out
> and do the operation from within walk_memory_blocks but I will not
> insist.

I have to confess I forgot about the details of that dicussion, as we were
quite focused on decoupling vmemmap pages from {online,offline} interface.
Would you mind elaborating a bit more?


-- 
Oscar Salvador
SUSE L3
