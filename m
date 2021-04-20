Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137523656EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhDTK4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:56:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDTK4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618916164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaBj6JM1q84ZgKwNPCxbgcsLt80d6OrryYvcPRF3ptY=;
        b=oCR+ievQ5QchRFIEnDSmzIG53jj9+vdpQiWMdqgsDILK3/Sk0AVzBOzrHpYYmi/Vx/kPJb
        WrTJtyzscckUH610cm1SLM88hf5IPRjeRXhD3G3IL63LF+FWDKnv+BhrPa1Ie24DdIftr1
        gY+ozer/QsiWG6vSu+Iy6DGz1m6cYw4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3572FAF0F;
        Tue, 20 Apr 2021 10:56:04 +0000 (UTC)
Date:   Tue, 20 Apr 2021 12:56:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416112411.9826-5-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:24:07, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)

I would extend this slightly. This can even lead to extreme cases where
system goes OOM because the physically hotplugged memory depletes the
available memory before it is onlined.

>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.
>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section and
> map struct pages there.

Again this can be confusing because this is not what is really happening
in practice because we are going to have a multisection memory block
where all sections will be backed by a common reserved space rather than
per section sparse space. I would go with

"
Vmemap page tables can map arbitrary memory. That means that we can
reserve a part of the physically hotadded memory to back vmemmap page
tables. This implementation uses the beggining of the hotplugged memory
for that purpose.
"

> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.
> This patch also introduces the following functions:

There is quite a large leap from __populate_section_memmap to the
memory_block that deserves explaining to not lose all the subtle things
discussed in the past. I think it should be made clear why all the fuzz.
I would structure it as follows:
"
There are some non-obiously things to consider though.  Vmemmap
pages are allocated/freed during the memory hotplug events
(add_memory_resource, try_remove_memory) when the memory is
added/removed. This means that the reserved physical range is not online
yet it is used. The most obvious side effect is that pfn_to_online_page
returns NULL for those pfns. The current design expects that this
should be OK as the hotplugged memory is considered a garbage until it
is onlined. For example hibernation wouldn't save the content of those
vmmemmaps into the image so it wouldn't be restored on resume but this
should be OK as there no real content to recover anyway while metadata
is reachable from other data structures (e.g. vmemmap page tables).

The reserved space is therefore (de)initialized during the {on,off}line
events (mhp_{de}init_memmap_on_memory). That is done by extracting page
allocator independent initialization from the regular onlining path.
The primary reason to handle the reserved space outside of {on,off}line_pages
is to make each initialization specific to the purpose rather than
special case them in a single function.

> Adjusting of present_pages is done at the end once we know that online_pages()
> succedeed.
> 
> On offline, memory_block_offline() needs to unaccount vmemmap pages from
> present_pages() before calling offline_pages().
> This is necessary because offline_pages() tears down some structures based
> on the fact whether the node or the zone become empty.
> If offline_pages() fails, we account back vmemmap pages.
> If it succeeds, we call mhp_deinit_memmap_on_memory().
> 
> Hot-remove:
> 
>  We need to be careful when removing memory, as adding and
>  removing memory needs to be done with the same granularity.
>  To check that this assumption is not violated, we check the
>  memory range we want to remove and if a) any memory block has
>  vmemmap pages and b) the range spans more than a single memory
>  block, we scream out loud and refuse to proceed.
> 
>  If all is good and the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does the right
>  thing and calls vmem_altmap_free instead of free_pagetable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          |  71 ++++++++++++++++--
>  include/linux/memory.h         |   8 ++-
>  include/linux/memory_hotplug.h |  15 +++-
>  include/linux/memremap.h       |   2 +-
>  include/linux/mmzone.h         |   7 +-
>  mm/Kconfig                     |   5 ++
>  mm/memory_hotplug.c            | 159 ++++++++++++++++++++++++++++++++++++++---
>  mm/sparse.c                    |   2 -
>  8 files changed, 247 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f209925a5d4e..2e2b2f654f0a 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -173,16 +173,72 @@ static int memory_block_online(struct memory_block *mem)
>  {
>  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>  	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> +	struct zone *zone;
> +	int ret;
> +
> +	zone = zone_for_pfn_range(mem->online_type, mem->nid, start_pfn, nr_pages);
> +
> +	/*
> +	 * Although vmemmap pages have a different lifecycle than the pages
> +	 * they describe (they remain until the memory is unplugged), doing
> +	 * their initialization and accounting at memory onlining/offlining
> +	 * stage simplifies things a lot.

"simplify things a lot" is not really helpful to people reading the
code. It would be much better to state reasons here. I would go with
	 * stage helps to keep accounting easier to follow - e.g.
	 * vmemmaps belong to the same zone as the onlined memory.
> +	 */
> +	if (nr_vmemmap_pages) {
> +		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = online_pages(start_pfn + nr_vmemmap_pages,
> +			   nr_pages - nr_vmemmap_pages, zone);
> +	if (ret) {
> +		if (nr_vmemmap_pages)
> +			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Account once onlining succeeded. If the zone was unpopulated, it is
> +	 * now already properly populated.
> +	 */
> +	if (nr_vmemmap_pages)
> +		adjust_present_page_count(zone, nr_vmemmap_pages);
>  
> -	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
> +	return ret;
>  }
[...]
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d05056b3c173..5ef626926449 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,6 +42,8 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> +static bool memmap_on_memory;
> +
>  /*
>   * online_page_callback contains pointer to current page onlining function.
>   * Initially it is generic_online_page(). If it is required it could be
> @@ -641,7 +643,12 @@ EXPORT_SYMBOL_GPL(generic_online_page);
>  static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn;
> +	unsigned long pfn = start_pfn;
> +
> +	while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
> +		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> +		pfn += pageblock_nr_pages;
> +	}

I believe we do not need to check for nr_pages as the actual operation
will never run out of range in practice but the code is more subtle than
necessary. Using two different iteration styles is also hurting the code
readability. I would go with the following
	for (pfn = start_pfn; pfn < end_pfn; ) {
		unsigned long order = min(MAX_ORDER - 1UL, __ffs(pfn));

		while (start + (1UL << order) > end_pfn)
                        order--;
		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
		pfn += 1 << order;
	}

which is what __free_pages_memory does already.

>  
>  	/*
>  	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> @@ -649,7 +656,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  	 * later). We account all pages as being online and belonging to this
>  	 * zone ("present").
>  	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> +	for (; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
>  		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
>  
>  	/* mark all involved sections as online */
[...]
> @@ -1848,6 +1964,31 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> +	 * the same granularity it was added - a single memory block.
> +	 */
> +	if (memmap_on_memory) {
> +		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
> +						      get_nr_vmemmap_pages_cb);
> +		if (nr_vmemmap_pages) {
> +			if (size != memory_block_size_bytes()) {
> +				pr_warn("Refuse to remove %#llx - %#llx,"
> +					"wrong granularity\n",
> +					start, start + size);
> +				return -EINVAL;
> +			}
> +
> +			/*
> +			 * Let remove_pmd_table->free_hugepage_table do the
> +			 * right thing if we used vmem_altmap when hot-adding
> +			 * the range.
> +			 */
> +			mhp_altmap.alloc = nr_vmemmap_pages;
> +			altmap = &mhp_altmap;
> +		}
> +	}
> +
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");

I have to say I still dislike this and I would just wrap it inside out
and do the operation from within walk_memory_blocks but I will not
insist.
-- 
Michal Hocko
SUSE Labs
