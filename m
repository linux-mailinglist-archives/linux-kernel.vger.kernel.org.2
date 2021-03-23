Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39E345BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCWKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:12:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhCWKMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:12:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616494319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gXuENufR+JBl3IE8CK3A7Osln66HFMUbYGbR/d7vjA=;
        b=WI8KDWI2PJFmLz+Ma55PSZVJoIg8eeer6kCjC1xjpwsdo7mrupt2LF4Z90As1/T4+S/e6I
        MSiqilqSRuCXN6h1XBcb/gFfnDWYfB9CmHyT/fTF6bMZl6+id7I8auJ+ljWF+KwXyJ02Ku
        6AJjBUmyfm5BUX9sqmAn7D4t6/HOb6Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D861FAF13;
        Tue, 23 Mar 2021 10:11:58 +0000 (UTC)
Date:   Tue, 23 Mar 2021 11:11:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319092635.6214-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a long overdue review. I didn't have time to follow previous
versions so I am sorry if some of my concerns have been discussed
already]

On Fri 19-03-21 10:26:31, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.

I was playing with movable_node and performance implications back in
2017 (unfortunately I do not have specific numbers anymore) and the
setup was a bit extreme - a single node (0) with normal zones and all
other nodes with movable memory only. So not only struct pages but any
other kernel metadata were on a remote node. I remember I could see
clear performance drop scaling with the distance from node 0 somewhere
betweem 5-10% on kbuild bound on a movable node.

>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section and
> map struct pages there.

In fact beginning of the memory block should be sufficient as sections
cannot be hotremoved without the rest of the memory block.

> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.

Here you are talking about memory block rather than section.

> This comes in handy as in {online,offline}_pages, all the isolation and
> migration is being done on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn = start_pfn + nr_vmemmap_pages.
> 
> In this way, we have:
> 
> [start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> [buddy_start_pfn, end_pfn - 1]       = Initialized and sent to buddy
> 
> Hot-remove:
> 
>  We need to be careful when removing memory, as adding and
>  removing memory needs to be done with the same granularity.
>  To check that this assumption is not violated, we check the
>  memory range we want to remove and if a) any memory block has
>  vmemmap pages and b) the range spans more than a single memory
>  block, we scream out loud and refuse to proceed.

Is this a real problem? If each memory block has its own vmemmap then we
should be just fine, no?
 
>  If all is good and the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does the right
>  thing and calls vmem_altmap_free instead of free_pagetable.

I would appreciate some more description of the patch itself. The above
outlines a highlevel problems and design. The patch is quite large and
it acts on several layers - physical hotplug, {on,off}lining and sysfs
layer.

Let me capture my thinking:
- from the top level 
- sysfs interfaces - memory block is extended to contain the number of
  vmemmap pages reserved from the beginning of the block for all
  memory sections belonging to the block.
- add_memory_resource is the entry point to reserve the vmemmap space
  for the block. This is an opt-in feature (MHP_MEMMAP_ON_MEMORY) and
  there is no current user at this stage.
- vmem_altmap is instructed to use the reserved vmemmap space as the
  backing storage for the vmemmap struct pages. Via arch_add_memory->
  __populate_section_memmap.
- online_pages for some reason needs to know about the reserved vmemmap
  space. Why? It already knows the intial pfn to online. Why cannot
  caller simply alter both start pfn and nr_pages to online everything
  after the vmemmap space? This is somehow conflating the mem block
  concept deeper into onlining.
- the same applies to offlining.
- finally hotremove - which is the most tricky part. try_remove_memory
  learns about vmemmap reserved space and provides it to __remove_pages
  and eventually all the way down to remove_pagetable via altmap
  Now a question and something I have stumbled over few years back when
  looking into this. Let's say you have multi section memblock so the
  first section of the block backs vmemmaps for all other sections.
  What happens when you drop the first worth of section before tearing
  down all other vmemmaps?

Now to the specific implementation.

[...]
> @@ -185,10 +185,11 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,
>  
>  	switch (action) {
>  	case MEM_ONLINE:
> -		ret = online_pages(start_pfn, nr_pages, online_type, nid);
> +		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
> +				   online_type, nid);
>  		break;

I would just offset start_pfn and nr_pages.

[...]

> @@ -603,7 +606,7 @@ static int add_memory_block(unsigned long base_section_nr)
>  	if (section_count == 0)
>  		return 0;
>  	return init_memory_block(memory_block_id(base_section_nr),
> -				 MEM_ONLINE);
> +				 MEM_ONLINE, 0);

This would deserve a comment.
	/* Early init code to create memory blocks for all the memory.
	 * Backed by bootmem struct pages so no vmemmap reserved space.
	 */

[...]
> -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> +			       unsigned long buddy_start_pfn)

More on that later
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn;
> +	unsigned long pfn = buddy_start_pfn;
> +
> +	/*
> +	 * When using memmap_on_memory, the range might be unaligned as the
> +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> +	 */
> +	VM_BUG_ON(!IS_ALIGNED(pfn, pageblock_nr_pages));

No this is not something VM_BUG_ON should be used for. This is perfectly
recoverable situation. Besides that this is a wrong layer to care. All
the fixup should happen up in the call chain.

>  int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> -		       int online_type, int nid)
> +		       unsigned long nr_vmemmap_pages, int online_type, int nid)
>  {
> -	unsigned long flags;
> +	unsigned long flags, buddy_start_pfn, buddy_nr_pages;
>  	struct zone *zone;
>  	int need_zonelists_rebuild = 0;
>  	int ret;

As already mentioned I believe this would be much easier to follow if
the given pfn really denotes a first pfn to online rather than learn the
code about vmemmap space which is not really interesting from the
onlining POV. Struct pages are already create. All we need is to online
them for using.
Just have a look at pfn vs. buddy_start_pfn usage. Why should
zone_for_pfn_range, node_states_check_changes_online, memory_notify ase
the former rather than later? As mentioned above online_pages_range is
just more complex by doing that.

Sure there are some consistency checks which are more convenient with
the actual pfn start but I believe those shouldn't be a reason for
obfuscating the code and mixing layers.

[...]
> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
> +	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> +	unsigned long remaining_size = size - vmemmap_size;
> +
> +	/*
> +	 * Besides having arch support and the feature enabled at runtime, we
> +	 * need a few more assumptions to hold true:
> +	 *
> +	 * a) We span a single memory block: memory onlining/offlinin;g happens
> +	 *    in memory block granularity. We don't want the vmemmap of online
> +	 *    memory blocks to reside on offline memory blocks. In the future,
> +	 *    we might want to support variable-sized memory blocks to make the
> +	 *    feature more versatile.
> +	 *
> +	 * b) The vmemmap pages span complete PMDs: We don't want vmemmap code
> +	 *    to populate memory from the altmap for unrelated parts (i.e.,
> +	 *    other memory blocks)
> +	 *
> +	 * c) The vmemmap pages (and thereby the pages that will be exposed to
> +	 *    the buddy) have to cover full pageblocks: memory onlining/offlining
> +	 *    code requires applicable ranges to be page-aligned, for example, to
> +	 *    set the migratetypes properly.
> +	 *
> +	 * TODO: Although we have a check here to make sure that vmemmap pages
> +	 *	 fully populate a PMD, it is not the right place to check for
> +	 *	 this. A much better solution involves improving vmemmap code
> +	 *	 to fallback to base pages when trying to populate vmemmap using
> +	 *	 altmap as an alternative source of memory, and we do not exactly
> +	 *	 populate a single PMD.
> +	 */
> +	return memmap_on_memory &&

What is memmap_on_memory? I do not see anybody setting it anywhere.
Probably a later patch...

> +	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> +	       size == memory_block_size_bytes() &&
> +	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> +	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));

This is likely more complex than necessary. Is it ever possible that
remaining_size won't be aligned properly when vmemmap_size is PMD_SIZE
aligned?

> @@ -1563,10 +1639,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  	return 0;
>  }
>  
> -int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			unsigned long nr_vmemmap_pages)

same concern as online pages. Nobody should really care about vmemmap
reserved space. Maybe the accounting (count_system_ram_pages_cb) will
need some compensation but I have to say I got lost in this accounting
wrt to memory hotplugged memory. Where do we account hotadded memory to
system_ram_pages?

[...]
> @@ -1836,6 +1927,31 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
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
> +					 start, start + size);
> +				return -EINVAL;
> +			}
> +
> +			/*
> +			 * Let remove_pmd_table->free_hugepage_table
> +			 * do the right thing if we used vmem_altmap
> +			 * when hot-adding the range.
> +			 */
> +			mhp_altmap.alloc = nr_vmemmap_pages;
> +			altmap = &mhp_altmap;
> +		}
> +	}
> +

This made me scratch my head. I do not think this works for size
spanning multiple memory blocks. Maybe we do not allow something like
that happening. The logic seems inside out to me. I believe you want to
either pull arch_remove_memory into the walk_memory_blocks callback and
handle each memory block this way.
-- 
Michal Hocko
SUSE Labs
