Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78B31507C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBINkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:60424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhBINjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:39:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6666DAD6A;
        Tue,  9 Feb 2021 13:38:59 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/7] Allocate memmap from hotadded memory (per device)
Date:   Tue,  9 Feb 2021 14:38:47 +0100
Message-Id: <20210209133854.17399-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is v2.

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

Oscar Salvador (7):
  mm,memory_hotplug: Allocate memmap from the added memory range
  acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
  mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
  mm,memory_hotplug: Enforce struct page size to be multiple of PMD
  mm,memory_hotplug: Enforce pageblock alignment when memmap_on_memory
  x86/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  arm64/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE

 Documentation/admin-guide/kernel-parameters.txt |  14 +++
 arch/arm64/Kconfig                              |   4 +
 arch/x86/Kconfig                                |   4 +
 drivers/acpi/acpi_memhotplug.c                  |   5 +-
 drivers/base/memory.c                           |  20 ++--
 include/linux/memory.h                          |   8 +-
 include/linux/memory_hotplug.h                  |  21 +++-
 include/linux/memremap.h                        |   2 +-
 include/linux/mmzone.h                          |   5 +
 mm/Kconfig                                      |   3 +
 mm/Makefile                                     |   5 +-
 mm/memory_hotplug.c                             | 150 ++++++++++++++++++++----
 mm/page_alloc.c                                 |   4 +-
 13 files changed, 208 insertions(+), 37 deletions(-)

-- 
2.16.3

