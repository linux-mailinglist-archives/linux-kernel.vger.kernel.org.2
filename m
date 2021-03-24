Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2534758F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCXKNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:13:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhCXKNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFFF6AD9F;
        Wed, 24 Mar 2021 10:13:02 +0000 (UTC)
Date:   Wed, 24 Mar 2021 11:12:59 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210324101259.GB16560@linux>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:11:58AM +0100, Michal Hocko wrote:
> [Sorry for a long overdue review. I didn't have time to follow previous
> versions so I am sorry if some of my concerns have been discussed
> already]

No worries, let's go ;-)

> I was playing with movable_node and performance implications back in
> 2017 (unfortunately I do not have specific numbers anymore) and the
> setup was a bit extreme - a single node (0) with normal zones and all
> other nodes with movable memory only. So not only struct pages but any
> other kernel metadata were on a remote node. I remember I could see
> clear performance drop scaling with the distance from node 0 somewhere
> betweem 5-10% on kbuild bound on a movable node.

I see. Yes, it is a rather extreme case, but I think it clearly shows the impact
of having metadata structures on a non-local node.

 
> In fact beginning of the memory block should be sufficient as sections
> cannot be hotremoved without the rest of the memory block.

Sorry, I meant memory block here.

> > struct pages which back the allocated space then just need to be treated
> > carefully.
> > 
> > Implementation wise we will reuse vmem_altmap infrastructure to override
> > the default allocator used by __populate_section_memmap.
> > Part of the implementation also relies on memory_block structure gaining
> > a new field which specifies the number of vmemmap_pages at the beginning.
> 
> Here you are talking about memory block rather than section.

Yes, see above, it should have been memory block in both cases.

> > Hot-remove:
> > 
> >  We need to be careful when removing memory, as adding and
> >  removing memory needs to be done with the same granularity.
> >  To check that this assumption is not violated, we check the
> >  memory range we want to remove and if a) any memory block has
> >  vmemmap pages and b) the range spans more than a single memory
> >  block, we scream out loud and refuse to proceed.
> 
> Is this a real problem? If each memory block has its own vmemmap then we
> should be just fine, no?

Not entirely.

Assume this:

- memory_block_size = 128MB
- add_memory(256MB) : no uses altmap because size != memory_block_size
- add_memory(128MB) : uses altmap

Now, when trying to remove the memory, we should construct the altmap to let
remove_pmd_table->free_hugepage_table() know that it needs to call vmem_altmap_free()
instead of free_pagetable() for those sections that were populated using altmap.

But that becomes trickier to handle if user does remove_memory(384MB) at once.

The only reasonable way I can think of is something like:

/*
 * Try to diferentiate which ranges used altmap when populating vmemmap,
 * and construct the altmap for those
 */
 loop(size / section_size)
  if (range_used altmap)
   arch_remove_memory(nid, start, size, altmap);
  else
   arch_remove_memory(nid, start, size, NULL);
   
But I do not think this is any better than make this scenario completely a NO-NO,
because in the end, this is asking for trouble.
And yes, normal qemu/barematal users does not have the hability to play these
kind of tricks, as baremetal has HW limitations and qemu creates a device for
every range you hot-add (so you are tied to that device when removing memory
as well), but other users e.g: virtio-mem can do that.

> I would appreciate some more description of the patch itself. The above
> outlines a highlevel problems and design. The patch is quite large and
> it acts on several layers - physical hotplug, {on,off}lining and sysfs
> layer.

Ok, will try to come up with something more complete wrt changelog.

> Let me capture my thinking:
> - from the top level 
> - sysfs interfaces - memory block is extended to contain the number of
>   vmemmap pages reserved from the beginning of the block for all
>   memory sections belonging to the block.
yes

> - add_memory_resource is the entry point to reserve the vmemmap space
>   for the block. This is an opt-in feature (MHP_MEMMAP_ON_MEMORY) and
>   there is no current user at this stage.
yes

> - vmem_altmap is instructed to use the reserved vmemmap space as the
>   backing storage for the vmemmap struct pages. Via arch_add_memory->
>   __populate_section_memmap.
yes

> - online_pages for some reason needs to know about the reserved vmemmap
>   space. Why? It already knows the intial pfn to online. Why cannot
>   caller simply alter both start pfn and nr_pages to online everything
>   after the vmemmap space? This is somehow conflating the mem block
>   concept deeper into onlining.
> - the same applies to offlining.

Because some counters need not only the buddy_nr_pages, but the complete
range.

So, let us see what online_pages() do (offline_pages() as well but slightly
different in some areas)

- move_pfn_range_to_zone():
  1) Resize node and zone spanned pages
     * If we were only to pass the nr_pages without the vmemmap pages,
       node/zone's spanned pages would be wrong as vmemmap pages would not
       be accounted in there.

  2) Inits struct pages by memmap_init_range() and sets its migratetype
     * If we were only to pass the nr_pages without the vmemmap pages,
       vmemmap pages would be totally unitialized.
       We also set its migratetype to MIGRATE_UNMOVABLE.
       Previous versions initialize vmemmap pages in another place but
       there was a consensus to do it here.

 So on, this case, we have:

 if (nr_vmemmap_pages)
    move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
                                       MIGRATE_UNMOVABLE);
 move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL
                        MIGRATE_ISOLATE);

- Increment zone->present_pages
  * We need to account buddy_pages + vmemmap_pages here

- zone->zone_pgdat->node_present_pages
  * Same as above

- online_pages_range() (onlines the pages, __and__ the sections)
  * Here do not only need the (buddy_pages, end_pages), but (vmemmap_pages, end_pages)
    as well, because on one hand we do:

    online_pages_range()
    {
       for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
                (*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);

       online_mem_sections(start_pfn, end_pfn);
   }

   For the call to online_mem_sections, we need to whole range (including the vmemmap
   pages), otherwise, if a whole section only contains vmemmap pages, the section
   might be left marked as offline, and that is troublesome.


As I said, the same applies to offline_pages(), but with slightly tweaks here and
there because it handles somewhat different things.

I kind of understand to be reluctant to use vmemmap_pages terminology here, but
unfortunately we need to know about it.
We could rename nr_vmemmap_pages to offset_buddy_pages or something like that.


> - finally hotremove - which is the most tricky part. try_remove_memory
>   learns about vmemmap reserved space and provides it to __remove_pages
>   and eventually all the way down to remove_pagetable via altmap
>   Now a question and something I have stumbled over few years back when
>   looking into this. Let's say you have multi section memblock so the
>   first section of the block backs vmemmaps for all other sections.
>   What happens when you drop the first worth of section before tearing
>   down all other vmemmaps?

I guess you refer to the case were:

- memory_block_size: 1GB (8 sections)
[memory_block] : first 4096 pfns are for vmemmap

Nothing happens, but I see where your comment is comming from.

Back in 2017, in your prototype, there were two different things:

- try_remove_memory (I dunno how it was called back then) still worked
  with pages, not pfns
- arch_memory_memory() either did not have the altmap stuff, or we were
  not setting it properly, but I remember that in your prototype
  you were handling vmemmap pages in free_hugepage_table()->free_pagetable()
  being carefull to not free them.

Back then, when removing the first vmemmap backing further sections, when
then dereferencing those sections in free_pagetable(), we would crash because
the mapping was not there anymore.
This cannot longer happen.

> [...]
> > @@ -185,10 +185,11 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,
> >  
> >  	switch (action) {
> >  	case MEM_ONLINE:
> > -		ret = online_pages(start_pfn, nr_pages, online_type, nid);
> > +		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
> > +				   online_type, nid);
> >  		break;
> 
> I would just offset start_pfn and nr_pages.

As stated above, this is not possible.

 
> > @@ -603,7 +606,7 @@ static int add_memory_block(unsigned long base_section_nr)
> >  	if (section_count == 0)
> >  		return 0;
> >  	return init_memory_block(memory_block_id(base_section_nr),
> > -				 MEM_ONLINE);
> > +				 MEM_ONLINE, 0);
> 
> This would deserve a comment.
> 	/* Early init code to create memory blocks for all the memory.
> 	 * Backed by bootmem struct pages so no vmemmap reserved space.
> 	 */

Ok, will add it.

> >  {
> >  	const unsigned long end_pfn = start_pfn + nr_pages;
> > -	unsigned long pfn;
> > +	unsigned long pfn = buddy_start_pfn;
> > +
> > +	/*
> > +	 * When using memmap_on_memory, the range might be unaligned as the
> > +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> > +	 */
> > +	VM_BUG_ON(!IS_ALIGNED(pfn, pageblock_nr_pages));
> 
> No this is not something VM_BUG_ON should be used for. This is perfectly
> recoverable situation. Besides that this is a wrong layer to care. All
> the fixup should happen up in the call chain.

This should not happen anymore as mhp_support_memmap_on_memory() does not let
to use MHP_MEMMAP_ON_MEMORY if range is not pageblock_nr_pages.

So this can go.

> >  int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> > -		       int online_type, int nid)
> > +		       unsigned long nr_vmemmap_pages, int online_type, int nid)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, buddy_start_pfn, buddy_nr_pages;
> >  	struct zone *zone;
> >  	int need_zonelists_rebuild = 0;
> >  	int ret;
> 
> As already mentioned I believe this would be much easier to follow if
> the given pfn really denotes a first pfn to online rather than learn the
> code about vmemmap space which is not really interesting from the
> onlining POV. Struct pages are already create. All we need is to online
> them for using.
> Just have a look at pfn vs. buddy_start_pfn usage. Why should
> zone_for_pfn_range, node_states_check_changes_online, memory_notify ase
> the former rather than later? As mentioned above online_pages_range is
> just more complex by doing that.
> 
> Sure there are some consistency checks which are more convenient with
> the actual pfn start but I believe those shouldn't be a reason for
> obfuscating the code and mixing layers.

I think I explained this above, but let me repeat just in case.
Take into account that boot vmemmap_pages are also accounted to:
- zone's spanned_pages/present_pages
- node's spanned_pages/present_pages

And those pages are also initialized somehow, so we need to initialize the hotplug
vmemmap pages as well, and account them.

As I said, we can use a different terminology and name it different, but we need to
- properly account them
- properly initialize them

And I __guess__ we could do it somewhere off the {online,offline_pages()) land,
but I see that trickier and not worh it.

> > +	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> > +	       size == memory_block_size_bytes() &&
> > +	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> > +	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
> 
> This is likely more complex than necessary. Is it ever possible that
> remaining_size won't be aligned properly when vmemmap_size is PMD_SIZE
> aligned?

Yes, on arm64 with large pages depending on HUGETLB support this can lead to
one condition be true while the other not.

> > @@ -1563,10 +1639,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
> >  	return 0;
> >  }
> >  
> > -int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> > +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> > +			unsigned long nr_vmemmap_pages)
> 
> same concern as online pages. Nobody should really care about vmemmap
> reserved space. Maybe the accounting (count_system_ram_pages_cb) will
> need some compensation but I have to say I got lost in this accounting
> wrt to memory hotplugged memory. Where do we account hotadded memory to
> system_ram_pages?

Quick summary of account:

- online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
- online_pages()->zone->present_pages += nr_pages;
- zone->zone_pgdat->node_present_pages += nr_pages;
- online_pages()->online_pages_range()->generic_online_page()->totalram_pages_add():
  Accounts for totalram_pages
- online_pages()->adjust_managed_page_count(): Accounts for zone->managed_pages

So, as you can see, we have a mix with of spanned_pages,present_pages and
managed_pages in both {offline,online}_pages().
Vmemmap pages need to be properly accounted to spanned_pages,present_pages,
as we account bootmem vmemmap pages, but they do not be accounted in
managed_pages.

> This made me scratch my head. I do not think this works for size
> spanning multiple memory blocks. Maybe we do not allow something like
> that happening. The logic seems inside out to me. I believe you want to
> either pull arch_remove_memory into the walk_memory_blocks callback and
> handle each memory block this way.

Here, what we fence off is the scenario I mentioned at the beginning, where
someone may call try_remove_memory() with memory_blocks both containing and
not vmemmap_pages.

So, if the user opt-in the feature, he needs to work with the same granularity
in the add and remove operations.

Well, that was a good feedback indeed, and a large one, I hope to have clarified
some of the questions raised.

-- 
Oscar Salvador
SUSE L3
