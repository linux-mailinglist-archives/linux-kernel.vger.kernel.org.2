Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247D35519C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhDFLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:11:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234223AbhDFLLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:11:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1D8BB156;
        Tue,  6 Apr 2021 11:11:27 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 4/8] mm,memory_hotplug: Allocate memmap from the added memory range
Date:   Tue,  6 Apr 2021 13:11:11 +0200
Message-Id: <20210406111115.8953-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210406111115.8953-1-osalvador@suse.de>
References: <20210406111115.8953-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Physical memory hotadd has to allocate a memmap (struct page array) for
the newly added memory section. Currently, alloc_pages_node() is used
for those allocations.

This has some disadvantages:
 a) an existing memory is consumed for that purpose
    (eg: ~2MB per 128MB memory section on x86_64)
 b) if the whole node is movable then we have off-node struct pages
    which has performance drawbacks.
 c) It might be there are no PMD_ALIGNED chunks so memmap array gets
    populated with base pages.

This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.

Vmemap page tables can map arbitrary memory.
That means that we can simply use the beginning of each memory section and
map struct pages there.
struct pages which back the allocated space then just need to be treated
carefully.

Implementation wise we will reuse vmem_altmap infrastructure to override
the default allocator used by __populate_section_memmap.
Part of the implementation also relies on memory_block structure gaining
a new field which specifies the number of vmemmap_pages at the beginning.
This patch also introduces the following functions:

 - vmemmap_init_space: Initializes vmemmap pages by calling move_pfn_range_to_zone(),
		       calls kasan_add_zero_shadow() or the vmemmap range and marks
		       online as many sections as vmemmap pages fully span.
 - vmemmap_adjust_pages: Accounts/substract vmemmap_pages to node and zone
			 present_pages
 - vmemmap_deinit_space: Undoes what vmemmap_init_space does.

The new function memory_block_online() calls vmemmap_init_space() before
doing the actual online_pages(). Should online_pages() fail, we clean up
by calling vmemmap_adjust_pages() and vmemmap_deinit_space().

On offline, memory_block_offline() calls vmemmap_adjust_pages() prior to calling
offline_pages(), because offline_pages() performs the tearing-down of kthreads
and the rebuilding of the zonelists if the node/zone become empty.
If offline_pages() fails, we account back vmemmap pages by vmemmap_adjust_pages().
If it succeeds, we call vmemmap_deinit_space().

Hot-remove:

 We need to be careful when removing memory, as adding and
 removing memory needs to be done with the same granularity.
 To check that this assumption is not violated, we check the
 memory range we want to remove and if a) any memory block has
 vmemmap pages and b) the range spans more than a single memory
 block, we scream out loud and refuse to proceed.

 If all is good and the range was using memmap on memory (aka vmemmap pages),
 we construct an altmap structure so free_hugepage_table does the right
 thing and calls vmem_altmap_free instead of free_pagetable.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c          |  64 +++++++++++++++--
 include/linux/memory.h         |   8 ++-
 include/linux/memory_hotplug.h |  13 ++++
 include/linux/memremap.h       |   2 +-
 include/linux/mmzone.h         |   5 ++
 mm/Kconfig                     |   5 ++
 mm/memory_hotplug.c            | 153 +++++++++++++++++++++++++++++++++++++++--
 7 files changed, 238 insertions(+), 12 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f209925a5d4e..a5e536a3e9a4 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -173,16 +173,65 @@ static int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
+	int ret;
+
+	/*
+	 * Although vmemmap pages have a different lifecycle than the pages
+	 * they describe (they remain until the memory is unplugged), doing
+	 * its initialization and accounting at hot-{online,offline} stage
+	 * simplifies things a lot
+	 */
+	if (nr_vmemmap_pages) {
+		ret = vmemmap_init_space(start_pfn, nr_vmemmap_pages, mem->nid,
+					 mem->online_type);
+		if (ret)
+			return ret;
+	}
 
-	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
+	ret = online_pages(start_pfn + nr_vmemmap_pages,
+			   nr_pages - nr_vmemmap_pages, mem->online_type,
+			   mem->nid);
+
+	/*
+	 * Undo the work if online_pages() fails.
+	 */
+	if (ret && nr_vmemmap_pages) {
+		vmemmap_adjust_pages(start_pfn, -nr_vmemmap_pages);
+		vmemmap_deinit_space(start_pfn, nr_vmemmap_pages);
+	}
+
+	return ret;
 }
 
 static int memory_block_offline(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
+	int ret;
+
+	/*
+	 * offline_pages() relies on present_pages in order to perform the
+	 * tearing-down of kthreads and the rebuilding of the zonelists.
+	 */
+	if (nr_vmemmap_pages)
+		vmemmap_adjust_pages(start_pfn, -nr_vmemmap_pages);
+
+	ret = offline_pages(start_pfn + nr_vmemmap_pages,
+			    nr_pages - nr_vmemmap_pages);
 
-	return offline_pages(start_pfn, nr_pages);
+	/*
+	 * Re-adjust present pages if offline_pages() fails.
+	 */
+	if (nr_vmemmap_pages) {
+		if (ret)
+			vmemmap_adjust_pages(start_pfn, nr_vmemmap_pages);
+		else
+			vmemmap_deinit_space(start_pfn, nr_pages);
+	}
+
+	return ret;
 }
 
 /*
@@ -576,7 +625,8 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
-static int init_memory_block(unsigned long block_id, unsigned long state)
+static int init_memory_block(unsigned long block_id, unsigned long state,
+			     unsigned long nr_vmemmap_pages)
 {
 	struct memory_block *mem;
 	int ret = 0;
@@ -593,6 +643,7 @@ static int init_memory_block(unsigned long block_id, unsigned long state)
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
+	mem->nr_vmemmap_pages = nr_vmemmap_pages;
 
 	ret = register_memory(mem);
 
@@ -612,7 +663,7 @@ static int add_memory_block(unsigned long base_section_nr)
 	if (section_count == 0)
 		return 0;
 	return init_memory_block(memory_block_id(base_section_nr),
-				 MEM_ONLINE);
+				 MEM_ONLINE, 0);
 }
 
 static void unregister_memory(struct memory_block *memory)
@@ -634,7 +685,8 @@ static void unregister_memory(struct memory_block *memory)
  *
  * Called under device_hotplug_lock.
  */
-int create_memory_block_devices(unsigned long start, unsigned long size)
+int create_memory_block_devices(unsigned long start, unsigned long size,
+				unsigned long vmemmap_pages)
 {
 	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
 	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
@@ -647,7 +699,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(block_id, MEM_OFFLINE);
+		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
 		if (ret)
 			break;
 	}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 4da95e684e20..97e92e8b556a 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -29,6 +29,11 @@ struct memory_block {
 	int online_type;		/* for passing data to online routine */
 	int nid;			/* NID for this memory block */
 	struct device dev;
+	/*
+	 * Number of vmemmap pages. These pages
+	 * lay at the beginning of the memory block.
+	 */
+	unsigned long nr_vmemmap_pages;
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
@@ -80,7 +85,8 @@ static inline int memory_notify(unsigned long val, void *v)
 #else
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
-int create_memory_block_devices(unsigned long start, unsigned long size);
+int create_memory_block_devices(unsigned long start, unsigned long size,
+				unsigned long vmemmap_pages);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7288aa5ef73b..cc3dbc0abf02 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -55,6 +55,14 @@ typedef int __bitwise mhp_t;
  */
 #define MHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+/*
+ * We want memmap (struct page array) to be self contained.
+ * To do so, we will use the beginning of the hot-added range to build
+ * the page tables for the memmap array that describes the entire range.
+ * Only selected architectures support it with SPARSE_VMEMMAP.
+ */
+#define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
@@ -100,6 +108,9 @@ extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
+extern void vmemmap_adjust_pages(unsigned long pfn, long nr_pages);
+extern int vmemmap_init_space(unsigned long pfn, unsigned long nr_pages,
+			      int nid, int online_type);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			int online_type, int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
@@ -306,6 +317,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
+extern void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
@@ -359,6 +371,7 @@ extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
+extern bool mhp_supports_memmap_on_memory(unsigned long size);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f5b464daeeca..45a79da89c5f 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -17,7 +17,7 @@ struct device;
  * @alloc: track pages consumed, private to vmemmap_populate()
  */
 struct vmem_altmap {
-	const unsigned long base_pfn;
+	unsigned long base_pfn;
 	const unsigned long end_pfn;
 	const unsigned long reserve;
 	unsigned long free;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..747e1c21d8e2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -427,6 +427,11 @@ enum zone_type {
 	 *    techniques might use alloc_contig_range() to hide previously
 	 *    exposed pages from the buddy again (e.g., to implement some sort
 	 *    of memory unplug in virtio-mem).
+	 * 6. Memory-hotplug: when using memmap_on_memory and onlining the memory
+	 *    to the MOVABLE zone, the vmemmap pages are also placed in such
+	 *    zone. Such pages cannot be really moved around as they are
+	 *    self-stored in the range, but they are treated as movable when
+	 *    the range they describe is about to be offlined.
 	 *
 	 * In general, no unmovable allocations that degrade memory offlining
 	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..febf805000f8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -183,6 +183,11 @@ config MEMORY_HOTREMOVE
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
 
+config MHP_MEMMAP_ON_MEMORY
+	def_bool y
+	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
+	depends on ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7411f6b5287d..43f0daf922e6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,6 +42,8 @@
 #include "internal.h"
 #include "shuffle.h"
 
+static bool memmap_on_memory;
+
 /*
  * online_page_callback contains pointer to current page onlining function.
  * Initially it is generic_online_page(). If it is required it could be
@@ -641,7 +643,12 @@ EXPORT_SYMBOL_GPL(generic_online_page);
 static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn;
+	unsigned long pfn = start_pfn;
+
+	while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
+		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
+		pfn += pageblock_nr_pages;
+	}
 
 	/*
 	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
@@ -649,7 +656,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 */
-	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
+	for (; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
 		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
 
 	/* mark all involved sections as online */
@@ -839,6 +846,45 @@ static void adjust_present_page_count(struct zone *zone, long nr_pages)
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
+void vmemmap_adjust_pages(unsigned long pfn, long nr_pages)
+{
+	struct zone *zone = page_zone(pfn_to_page(pfn));
+
+	adjust_present_page_count(zone, nr_pages);
+}
+
+int vmemmap_init_space(unsigned long pfn, unsigned long nr_pages, int nid,
+		       int online_type)
+{
+	unsigned long end_pfn = pfn + nr_pages;
+	struct zone *zone;
+	int ret;
+
+	/*
+	 * Initialize vmemmap pages with the corresponding node, zone links set.
+	 */
+	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
+
+	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
+	if (ret) {
+		remove_pfn_range_from_zone(zone, pfn, nr_pages);
+		return ret;
+	}
+
+	vmemmap_adjust_pages(pfn, nr_pages);
+
+	/*
+	 * It might be that the vmemmap_pages fully span sections. If that is
+	 * the case, mark those sections online here as otherwise they will be
+	 * left offline.
+	 */
+	if (nr_pages >= PAGES_PER_SECTION)
+	        online_mem_sections(pfn, ALIGN_DOWN(end_pfn, PAGES_PER_SECTION));
+
+	return ret;
+}
+
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       int online_type, int nid)
 {
@@ -1074,6 +1120,45 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
+bool mhp_supports_memmap_on_memory(unsigned long size)
+{
+	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
+	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
+	unsigned long remaining_size = size - vmemmap_size;
+
+	/*
+	 * Besides having arch support and the feature enabled at runtime, we
+	 * need a few more assumptions to hold true:
+	 *
+	 * a) We span a single memory block: memory onlining/offlinin;g happens
+	 *    in memory block granularity. We don't want the vmemmap of online
+	 *    memory blocks to reside on offline memory blocks. In the future,
+	 *    we might want to support variable-sized memory blocks to make the
+	 *    feature more versatile.
+	 *
+	 * b) The vmemmap pages span complete PMDs: We don't want vmemmap code
+	 *    to populate memory from the altmap for unrelated parts (i.e.,
+	 *    other memory blocks)
+	 *
+	 * c) The vmemmap pages (and thereby the pages that will be exposed to
+	 *    the buddy) have to cover full pageblocks: memory onlining/offlining
+	 *    code requires applicable ranges to be page-aligned, for example, to
+	 *    set the migratetypes properly.
+	 *
+	 * TODO: Although we have a check here to make sure that vmemmap pages
+	 *       fully populate a PMD, it is not the right place to check for
+	 *       this. A much better solution involves improving vmemmap code
+	 *       to fallback to base pages when trying to populate vmemmap using
+	 *       altmap as an alternative source of memory, and we do not exactly
+	 *       populate a single PMD.
+	 */
+	return memmap_on_memory &&
+	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
+	       size == memory_block_size_bytes() &&
+	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
+	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1083,6 +1168,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	struct vmem_altmap mhp_altmap = {};
 	u64 start, size;
 	bool new_node = false;
 	int ret;
@@ -1109,13 +1195,26 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 	new_node = ret;
 
+	/*
+	 * Self hosted memmap array
+	 */
+	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
+		if (!mhp_supports_memmap_on_memory(size)) {
+			ret = -EINVAL;
+			goto error;
+		}
+		mhp_altmap.free = PHYS_PFN(size);
+		mhp_altmap.base_pfn = PHYS_PFN(start);
+		params.altmap = &mhp_altmap;
+	}
+
 	/* call arch's memory hotadd */
 	ret = arch_add_memory(nid, start, size, &params);
 	if (ret < 0)
 		goto error;
 
 	/* create memory block devices after memory was added */
-	ret = create_memory_block_devices(start, size);
+	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
 	if (ret) {
 		arch_remove_memory(nid, start, size, NULL);
 		goto error;
@@ -1573,6 +1672,16 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
+void vmemmap_deinit_space(unsigned long pfn, unsigned long nr_pages)
+{
+	/*
+	 * The pages associated with this vmemmap have been offlined, so
+	 * we can reset its state here in case we have page_init_poison.
+	 */
+	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn, nr_pages);
+	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
+}
+
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
@@ -1760,6 +1869,14 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 	return 0;
 }
 
+static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
+{
+	/*
+	 * If not set, continue with the next block.
+	 */
+	return mem->nr_vmemmap_pages;
+}
+
 static int check_cpu_on_node(pg_data_t *pgdat)
 {
 	int cpu;
@@ -1834,6 +1951,9 @@ EXPORT_SYMBOL(try_offline_node);
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
+	struct vmem_altmap mhp_altmap = {};
+	struct vmem_altmap *altmap = NULL;
+	unsigned long nr_vmemmap_pages;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1846,6 +1966,31 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 	if (rc)
 		return rc;
 
+	/*
+	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
+	 * the same granularity it was added - a single memory block.
+	 */
+	if (memmap_on_memory) {
+		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
+						      get_nr_vmemmap_pages_cb);
+		if (nr_vmemmap_pages) {
+			if (size != memory_block_size_bytes()) {
+				pr_warn("Refuse to remove %#llx - %#llx,"
+					"wrong granularity\n",
+					start, start + size);
+				return -EINVAL;
+			}
+
+			/*
+			 * Let remove_pmd_table->free_hugepage_table do the
+			 * right thing if we used vmem_altmap when hot-adding
+			 * the range.
+			 */
+			mhp_altmap.alloc = nr_vmemmap_pages;
+			altmap = &mhp_altmap;
+		}
+	}
+
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
 
@@ -1857,7 +2002,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	mem_hotplug_begin();
 
-	arch_remove_memory(nid, start, size, NULL);
+	arch_remove_memory(nid, start, size, altmap);
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		memblock_free(start, size);
-- 
2.16.3

