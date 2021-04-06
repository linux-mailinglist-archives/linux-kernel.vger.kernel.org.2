Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA7355CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbhDFU24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:28:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhDFU2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:28:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B986FAF9A;
        Tue,  6 Apr 2021 20:28:45 +0000 (UTC)
Date:   Tue, 6 Apr 2021 22:28:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YGzEe1XH0kGgwsxp@localhost.localdomain>
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406111115.8953-5-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:11:11PM +0200, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
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
> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.
> This patch also introduces the following functions:
> 
>  - vmemmap_init_space: Initializes vmemmap pages by calling move_pfn_range_to_zone(),
> 		       calls kasan_add_zero_shadow() or the vmemmap range and marks
> 		       online as many sections as vmemmap pages fully span.
>  - vmemmap_adjust_pages: Accounts/substract vmemmap_pages to node and zone
> 			 present_pages
>  - vmemmap_deinit_space: Undoes what vmemmap_init_space does.
> 
> The new function memory_block_online() calls vmemmap_init_space() before
> doing the actual online_pages(). Should online_pages() fail, we clean up
> by calling vmemmap_adjust_pages() and vmemmap_deinit_space().
> 
> On offline, memory_block_offline() calls vmemmap_adjust_pages() prior to calling
> offline_pages(), because offline_pages() performs the tearing-down of kthreads
> and the rebuilding of the zonelists if the node/zone become empty.
> If offline_pages() fails, we account back vmemmap pages by vmemmap_adjust_pages().
> If it succeeds, we call vmemmap_deinit_space().
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

Heh, it seems I spaced out today.

We need a few things on top:

- In case !CONFIG_MEMORY_HOTREMOVE, we still need vmemmap_deinit_space
  as we call it from memory_block_online() too in case online_pages()
  fails. So we need to move it out of #CONFIG_MEMORY_HOTREMOVE, with
  the others.
- If vmemmap pages fully spans sections, we need to mark those sections
  as online, since online_pages() will not do it for us.
  In vmemmap_deinit_space, we need to mark them back offline.
  Since vmemmap_deinit_space might get called from
  memory_block_online(), we need to move the offline_mem_sections()
  out of #CONFIG_MEMORY_HOTREMOVE code.

So, we would need the following on top:

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index cc3dbc0abf02..c7669d2accfd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -111,6 +111,7 @@ extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 extern void vmemmap_adjust_pages(unsigned long pfn, long nr_pages);
 extern int vmemmap_init_space(unsigned long pfn, unsigned long nr_pages,
 			      int nid, int online_type);
+extern void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			int online_type, int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
@@ -317,7 +318,6 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}

 #ifdef CONFIG_MEMORY_HOTREMOVE

-extern void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 747e1c21d8e2..76f4ca5ed230 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1383,10 +1383,8 @@ static inline int online_section_nr(unsigned long nr)

 #ifdef CONFIG_MEMORY_HOTPLUG
 void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
 #endif
-#endif

 static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 43f0daf922e6..68f11751cd82 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -885,6 +885,25 @@ int vmemmap_init_space(unsigned long pfn, unsigned long nr_pages, int nid,
 	return ret;
 }

+void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages)
+{
+	unsigned long end_pfn = pfn + nr_pages;
+        /*
+	 * The pages associated with this vmemmap have been offlined, so
+	 * we can reset its state here in case we have page_init_poison.
+	 */
+	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn, nr_pages);
+	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
+
+	/*
+	 * It might be that the vmemmap_pages fully span sections. If that is
+	 * the case, mark those sections offline here as otherwise they will be
+	 * left online.
+	 */
+	if (nr_pages >= PAGES_PER_SECTION)
+		offline_mem_sections(pfn, ALIGN_DOWN(end_pfn, PAGES_PER_SECTION));
+}
+
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       int online_type, int nid)
 {
@@ -1672,16 +1691,6 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }

-void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages)
-{
-	/*
-	 * The pages associated with this vmemmap have been offlined, so
-	 * we can reset its state here in case we have page_init_poison.
-	 */
-	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn, nr_pages);
-	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
-}
-
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
diff --git a/mm/sparse.c b/mm/sparse.c
index 7bd23f9d6cef..8e96cf00536b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -623,7 +623,6 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }

-#ifdef CONFIG_MEMORY_HOTREMOVE
 /* Mark all memory sections within the pfn range as offline */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
@@ -644,7 +643,6 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
 }
-#endif

 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 static struct page * __meminit populate_section_memmap(unsigned long pfn,


-- 
Oscar Salvador
SUSE L3
