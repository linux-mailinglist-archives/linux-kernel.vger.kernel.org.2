Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF2347994
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhCXN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:28:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234381AbhCXN14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:27:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 711FBAD71;
        Wed, 24 Mar 2021 13:27:55 +0000 (UTC)
Date:   Wed, 24 Mar 2021 14:27:53 +0100
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
Message-ID: <20210324132745.GA20676@linux>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:03:29PM +0100, Michal Hocko wrote:
> > Assume this:
> > 
> > - memory_block_size = 128MB
> > - add_memory(256MB) : no uses altmap because size != memory_block_size
> > - add_memory(128MB) : uses altmap
> 
> 256 are two memory blocks so why couldn't we split the operation and add
> two altmaps each for its own memory block?

We could, but then the code just gets trickier. I find easier to define more
simple semantics that must hold in order to opt-in the feature.

Moreover, what we get in return wrt. splitting sizes in memory_blocks is not
really worth comparing to the simple check we have to fence off these kind
of situations.

So, IOW, we could do it conceptually, but I would like to keep it simple.

> > But I do not think this is any better than make this scenario completely a NO-NO,
> > because in the end, this is asking for trouble.
> > And yes, normal qemu/barematal users does not have the hability to play these
> > kind of tricks, as baremetal has HW limitations and qemu creates a device for
> > every range you hot-add (so you are tied to that device when removing memory
> > as well), but other users e.g: virtio-mem can do that.
> 
> I am not against reducing functionality for the initial version where it
> makes sense. E.g. partial memory blocks. But if the overall hotplug
> operation can be devided into multiple blocks then there shouldn't be
> any real reason for restrictions IMHO.

As I said, I think it can be done, but it would overcomplicate the picture
at this moment, an I am not sure it is really worth it.
Something to inspect fot the future? Sure, and it kinda sounds interesting,
but putting that in place atm would be too much IMHO.

> [...]
> > > - online_pages for some reason needs to know about the reserved vmemmap
> > >   space. Why? It already knows the intial pfn to online. Why cannot
> > >   caller simply alter both start pfn and nr_pages to online everything
> > >   after the vmemmap space? This is somehow conflating the mem block
> > >   concept deeper into onlining.
> > > - the same applies to offlining.
> > 
> > Because some counters need not only the buddy_nr_pages, but the complete
> > range.
> > 
> > So, let us see what online_pages() do (offline_pages() as well but slightly
> > different in some areas)
> > 
> > - move_pfn_range_to_zone():
> >   1) Resize node and zone spanned pages
> >      * If we were only to pass the nr_pages without the vmemmap pages,
> >        node/zone's spanned pages would be wrong as vmemmap pages would not
> >        be accounted in there.
> 
> Why is that a problem? That memory is not usable anyway.

We account bootmem vemmamp memory as node/zone's spanned pages, why hotplug
vmemmap should be any diferent? And we are talking about spanned pages here,
which do not relate to usable memory.


> >   2) Inits struct pages by memmap_init_range() and sets its migratetype
> >      * If we were only to pass the nr_pages without the vmemmap pages,
> >        vmemmap pages would be totally unitialized.
> >        We also set its migratetype to MIGRATE_UNMOVABLE.
> >        Previous versions initialize vmemmap pages in another place but
> >        there was a consensus to do it here.
> 
> Migrate type for pages backing vmemmap?

Since we initialize them, it made sense to mark them as UNMOVABLE, as that
memory is self-hosted.
More on that below.

> > - Increment zone->present_pages
> >   * We need to account buddy_pages + vmemmap_pages here
> 
> You can compensate for that by accounting present_pages where you
> allocate them - when the memory is hot removed.

Why compensate? We have the data handy, and as above, bootmem vmemmap pages
get directly accounted to node/zone's present_pages. I do not see why
hotplug vmemmap pages would be different in this regard.

> > - zone->zone_pgdat->node_present_pages
> >   * Same as above
> > 
> > - online_pages_range() (onlines the pages, __and__ the sections)
> >   * Here do not only need the (buddy_pages, end_pages), but (vmemmap_pages, end_pages)
> >     as well, because on one hand we do:
> > 
> >     online_pages_range()
> >     {
> >        for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> >                 (*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
> > 
> >        online_mem_sections(start_pfn, end_pfn);
> >    }
> > 
> >    For the call to online_mem_sections, we need to whole range (including the vmemmap
> >    pages), otherwise, if a whole section only contains vmemmap pages, the section
> >    might be left marked as offline, and that is troublesome.
> 
> I would like to hear much more about those troubles.

In a previous discussion with David:

   " Well, if the section holding vmemmap pages is offline, would it be bad
    that pfn_to_online_page() returns NULL?
    AFAICS, callers would know that there is nothing to do with such page,
    and that is true since they only back other pages, and if
    these other pages are offline, that is it."

  "It's for example an issue with zone shrinking. But I recall it's also an
   issue when hibernating/suspending, dumping memory and so on ."

Moreover, sections containing bootmem vmemmap pages get also onlined, so it would
special case something that it does not need to.

> > As I said, the same applies to offline_pages(), but with slightly tweaks here and
> > there because it handles somewhat different things.
> > 
> > I kind of understand to be reluctant to use vmemmap_pages terminology here, but
> > unfortunately we need to know about it.
> > We could rename nr_vmemmap_pages to offset_buddy_pages or something like that.
> 
> I am not convinced. It seems you are justr trying to graft the new
> functionality in. But I still believe that {on,off}lining shouldn't care
> about where their vmemmaps come from at all. It should be a
> responsibility of the code which reserves that space to compansate for
> accounting. Otherwise we will end up with a hard to maintain code
> because expectations would be spread at way too many places. Not to
> mention different pfns that the code should care about.
...
> > Back then, when removing the first vmemmap backing further sections, when
> > then dereferencing those sections in free_pagetable(), we would crash because
> > the mapping was not there anymore.
> > This cannot longer happen.
> 
> OK, it would be great to outline that in the changelog because this is
> an important detail.

Will add it.

> > This should not happen anymore as mhp_support_memmap_on_memory() does not let
> > to use MHP_MEMMAP_ON_MEMORY if range is not pageblock_nr_pages.
> 
> My point was that even if this was still needed VM_BUG_ON is not the
> right way to take care of it. If you have a way to gracefully handle an
> unexpected input then this should always be done.

Ok, I understand.

> > Yes, on arm64 with large pages depending on HUGETLB support this can lead to
> > one condition be true while the other not.
> 
> A comment would be helpful.

Sure

> > Quick summary of account:
> > 
> > - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
> > - online_pages()->zone->present_pages += nr_pages;
> > - zone->zone_pgdat->node_present_pages += nr_pages;
> > - online_pages()->online_pages_range()->generic_online_page()->totalram_pages_add():
> >   Accounts for totalram_pages
> 
> these should account vmemmap pages as well. Although I do not why it
> would be a big problem to leave those out. Anyway, it should be quite
> straightforward to account them at the time when the vmemmap space is
> reserved as already mentioned above.
> 
> > - online_pages()->adjust_managed_page_count(): Accounts for zone->managed_pages
> 
> these are only managed by the allocator so vmemmap pages are off the
> table.

Yes, vmemmap pages are not accounted to managed_pages.

Ok, it all boils down to:

- online_pages/offline_pages __besides__ handing pages over to buddy or migrate them,
  take care of onlining/offlining sections, the accounting of:
  present_pages (node/zone)
  spanned_pages (node/zone)
  managed_pages  (zone)
  (remember that bootmem vmemmap pages get directly accounted in those counters,
   special casing vmemmap pages seems wrong tbh)

  __and__ the initialization of pages.

  vmemmap pages, as any other page, neeed to be properly initalized.
  Since the initialization and accounting is carved in online_pages(), it makes
  sense to pass the vmemmap pages in there.
  
I guess we could have some helpers to do that and try to call those helpers
out of {online,offline}_pages(), but I think the end result would look more
weird.

As I said, vmemmap pages need to be initialized and accounted, and all that
work is done in {offline,online}_pages.

As I said, terminilogy could change (not sure it is any better), but we need to
do some of the work those two function provides, and it seems quite straightforward
do it there.


-- 
Oscar Salvador
SUSE L3
