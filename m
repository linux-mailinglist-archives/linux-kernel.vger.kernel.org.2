Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8D6361E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbhDPLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233959AbhDPLYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FB93B01C;
        Fri, 16 Apr 2021 11:24:20 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v9 0/8] Allocate memmap from hotadded memory (per device)
Date:   Fri, 16 Apr 2021 13:24:03 +0200
Message-Id: <20210416112411.9826-1-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please, consider pulling out the patch that sits currently in linux-mm and
put this one instead.
I would still like to hear Michal's opinion but it should be safe
enough to let it sit in the mmotm/linux-next for a while.

Thanks

Changes from v8 -> v9:
 - Change order of kasan calls and offline_mem_sections
 - Collect Reviewed-by

Changes from v7 -> v8:
 - Addressed feedback from David for patch#4

Changes from v6 -> v7:
 - Fix check from "mm,memory_hotplug: Relax fully spanned sections check"
 - Add fixup from "mm,memory_hotplug: Allocate memmap from the added memory range"
 - Add Reviewed-by from David for patch#2
 - Fix changelog in "mm,memory_hotplug: Factor out adjusting present pages into
    adjust_present_page_count()"

Changes from v5 -> v6:
 - Create memory_block_{online,offline} functions
 - Create vmemmap_* functions to deal with vmemmap stuff, so
   {online,offline}_pages remain untouched
 - Add adjust_present_page_count's patch from David
 - Relax check in {offline,online}_pages
 - Rework changelogs

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

[1] https://lore.kernel.org/lkml/cover.1611206601.git.sudaraj...

Original cover letter:

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
 usable for the array. See patch 4 for more details.
 This feature is only usable when CONFIG_SPARSEMEM_VMEMMAP is set.

 [Overall design]:

 Implementation wise we reuse vmem_altmap infrastructure to override
 the default allocator used by vmemap_populate.
 memory_block structure gains a new field called nr_vmemmap_pages,
 which accounts for the number of vmemmap pages used by that memory_block.
 E.g: On x86_64, that is 512 vmemmap pages on small memory bloks and 4096
      on large memory blocks (1GB)

 We also introduce new two functions: memory_block_{online,offline}.
 These functions take care of initializing/unitializing vmemmap pages
 prior to calling {online,offline}_pages, so the latter functions can
 remain totally untouched.

 More details can be found in the respective changelogs.


David Hildenbrand (1):
  mm,memory_hotplug: Factor out adjusting present pages into
    adjust_present_page_count()

Oscar Salvador (7):
  drivers/base/memory: Introduce memory_block_{online,offline}
  mm,memory_hotplug: Relax fully spanned sections check
  mm,memory_hotplug: Allocate memmap from the added memory range
  acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
  mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
  x86/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  arm64/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE

 Documentation/admin-guide/kernel-parameters.txt |  17 ++
 arch/arm64/Kconfig                              |   3 +
 arch/x86/Kconfig                                |   3 +
 drivers/acpi/acpi_memhotplug.c                  |   5 +-
 drivers/base/memory.c                           | 100 ++++++++++--
 include/linux/memory.h                          |   8 +-
 include/linux/memory_hotplug.h                  |  15 +-
 include/linux/memremap.h                        |   2 +-
 include/linux/mmzone.h                          |   7 +-
 mm/Kconfig                                      |   5 +
 mm/Makefile                                     |   5 +-
 mm/memory_hotplug.c                             | 205 +++++++++++++++++++++---
 mm/sparse.c                                     |   2 -
 13 files changed, 330 insertions(+), 47 deletions(-)

-- 
2.16.3

