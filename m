Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761E4341832
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCSJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhCSJ0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:26:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DDE3AC2E;
        Fri, 19 Mar 2021 09:26:42 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 0/5] Allocate memmap from hotadded memory (per device)
Date:   Fri, 19 Mar 2021 10:26:30 +0100
Message-Id: <20210319092635.6214-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4 -> v5:
 - Addressed feedback from David (patch#1)
 - Tested on x86_64 with different struct page sizes and on large/small memory
   blocks
 - Tested on arm64 with 4K, 64K (with and without THP) and with different struct
   page sizes

 NOTE: We might need to make this feature and hugetlb-vmemmap feature [1] mutually
       exclusive. I raised an issue I see in [2].
       Hugetlb-vmemmap feature has been withdrawn for the time being due to the need
       in further changes  wrt. locking/freeing context.
       I will keep an eye, and when the time comes again I will see how the two
       features play together and how one another can be disabled when needed.

Changes from v3 -> v4:
 - Addressed feedback from David
 - Wrap memmap_on_memory module thingy with #ifdef
   on MHP_MEMMAP_ON_MEMORY
 - Move "depend on MEMORY_HOTPLUG" to MHP_MEMMAP_ON_MEMORY
   in generic mm/Kconfig
 - Collect David's Reviewed-bys

Changes from v2 -> v3:
 - Addressed feedback from David
 - Squash former patch#4 and and patch#5 into patch#1
 - Fix config dependency CONFIR_SPARSE_VMEMMAP vs CONFIG_SPARSE_VMEMMAP_ENABLE
 - Simplify module parameter functions

Changes from v1 -> v2
 - Addressed feedback from David
 - Fence off the feature in case struct page size is not
   multiple of PMD size or pageblock alignment cannot be guaranted
 - Tested on x86_64 small and large memory_blocks
 - Tested on arm64 4KB and 64KB page sizes (for some reason I cannot boot
   my VM with 16KB page size).

 Arm64 with 4KB page size behaves like x86_64 after [1], which made section
 size smaller.
 With 64KB, the feature gets fenced off due to pageblock alignment.

Changes from RFCv3 -> v1:
 - Addressed feedback from David
 - Re-order patches

Changes from v2 -> v3 (RFC):
 - Re-order patches (Michal)
 - Fold "mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY" in patch#1
 - Add kernel boot option to enable this feature (Michal)

Changes from v1 -> v2 (RFC):
 - Addressed feedback provided by David
 - Add a arch_support_memmap_on_memory to be called
   from mhp_supports_memmap_on_memory, as atm,
   only ARM, powerpc and x86_64 have altmat support.

[1] https://lore.kernel.org/lkml/cover.1611206601.git.sudaraja@codeaurora.org/

Original cover letter:

----

 The primary goal of this patchset is to reduce memory overhead of the
 hot-added memory (at least for SPARSEMEM_VMEMMAP memory model).
 The current way we use to populate memmap (struct page array) has two main drawbacks:
 
 a) it consumes an additional memory until the hotadded memory itself is
    onlined and
 b) memmap might end up on a different numa node which is especially true
    for movable_node configuration.
 c) due to fragmentation we might end up populating memmap with base
    pages
 
 One way to mitigate all these issues is to simply allocate memmap array
 (which is the largest memory footprint of the physical memory hotplug)
 from the hot-added memory itself. SPARSEMEM_VMEMMAP memory model allows
 us to map any pfn range so the memory doesn't need to be online to be
 usable for the array. See patch 3 for more details.
 This feature is only usable when CONFIG_SPARSEMEM_VMEMMAP is set.
 
 [Overall design]:
 
 Implementation wise we reuse vmem_altmap infrastructure to override
 the default allocator used by vmemap_populate.
 memory_block structure gained a new field called nr_vmemmap_pages.
 This plays well for two reasons:
 
  1) {offline/online}_pages know the difference between start_pfn and
     buddy_start_pfn, which is start_pfn + nr_vmemmap_pages.
     In this way all isolation/migration operations are
     done to within the right range of memory without vmemmap pages.
     This allows us for a much cleaner handling.
 
  2) In try_remove_memory, we construct a new vmemap_altmap struct with the
     right information based on memory_block->nr_vmemap_pages, so we end up
     calling vmem_altmap_free instead of free_pagetable when removing the memory.


Oscar Salvador (5):
  mm,memory_hotplug: Allocate memmap from the added memory range
  acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
  mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
  x86/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  arm64/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE

 Documentation/admin-guide/kernel-parameters.txt |  16 +++
 arch/arm64/Kconfig                              |   3 +
 arch/x86/Kconfig                                |   3 +
 drivers/acpi/acpi_memhotplug.c                  |   5 +-
 drivers/base/memory.c                           |  20 +--
 include/linux/memory.h                          |   8 +-
 include/linux/memory_hotplug.h                  |  21 ++-
 include/linux/memremap.h                        |   2 +-
 include/linux/mmzone.h                          |   5 +
 mm/Kconfig                                      |   5 +
 mm/Makefile                                     |   5 +-
 mm/memory_hotplug.c                             | 166 +++++++++++++++++++++---
 mm/page_alloc.c                                 |   4 +-
 13 files changed, 225 insertions(+), 38 deletions(-)

-- 
2.16.3

