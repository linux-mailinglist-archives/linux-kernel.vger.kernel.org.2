Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9C33066A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhCHD1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:27:39 -0500
Received: from foss.arm.com ([217.140.110.172]:58362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233987AbhCHD1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:27:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D64D6E;
        Sun,  7 Mar 2021 19:27:33 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 233273F73C;
        Sun,  7 Mar 2021 19:27:29 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC] mm: Enable generic pfn_valid() to handle early sections with memmap holes
Date:   Mon,  8 Mar 2021 08:57:53 +0530
Message-Id: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms like arm and arm64 have redefined pfn_valid() because their early
memory sections might have contained memmap holes caused by memblock areas
tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
for struct page backing. This scenario could be captured with a new option
CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
improved to accommodate such platforms. This reduces overall code footprint
and also improves maintainability.

Commit 4f5b0c178996 ("arm, arm64: move free_unused_memmap() to generic mm")
had used CONFIG_HAVE_ARCH_PFN_VALID to gate free_unused_memmap(), which in
turn had expanded its scope to new platforms like arc and m68k. Rather lets
restrict back the scope for free_unused_memmap() to arm and arm64 platforms
using this new config option i.e CONFIG_HAVE_EARLY_SECTION_MEMMAP.

While here, it exports the symbol memblock_is_map_memory() to build drivers
that depend on pfn_valid() but does not have the required visibility. After
this new config is in place, just drop CONFIG_HAVE_ARCH_PFN_VALID from both
arm and arm64 platforms.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.12-rc2 along with arm64 pfn_valid() fix patches [1] and
has been lightly tested on the arm64 platform. The idea to represent this
unique situation on the arm and arm64 platforms with a config option was
proposed by David H during an earlier discussion [2]. This still does not
build on arm platform due to pfn_valid() resolution errors. Nonetheless
wanted to get some early feedback whether the overall approach here, is
acceptable or not.

[1] https://patchwork.kernel.org/project/linux-mm/list/?series=442433 
[2] https://lore.kernel.org/linux-arm-kernel/4b282848-d2d7-6156-4726-ce974b2dff41@redhat.com/

 arch/arm/Kconfig              |  2 +-
 arch/arm/include/asm/page.h   |  4 ----
 arch/arm/mm/init.c            | 13 -----------
 arch/arm64/Kconfig            |  2 +-
 arch/arm64/include/asm/page.h |  2 --
 arch/arm64/mm/init.c          | 41 -----------------------------------
 include/linux/mmzone.h        | 24 +++++++++++++++++++-
 mm/Kconfig                    | 10 +++++++++
 mm/memblock.c                 |  3 ++-
 9 files changed, 37 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 853aab5ab327..8b1d3089baa6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -71,7 +71,6 @@ config ARM
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
-	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
@@ -84,6 +83,7 @@ config ARM
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_EARLY_SECTION_MEMMAP_HOLES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP if ARM_LPAE
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 11b058a72a5b..7e3189083bd7 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -153,10 +153,6 @@ extern void copy_page(void *to, const void *from);
 
 typedef struct page *pgtable_t;
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
-extern int pfn_valid(unsigned long);
-#endif
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..9131ef4e599e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -121,19 +121,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	free_area_init(max_zone_pfn);
 }
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
-int pfn_valid(unsigned long pfn)
-{
-	phys_addr_t addr = __pfn_to_phys(pfn);
-
-	if (__phys_to_pfn(addr) != pfn)
-		return 0;
-
-	return memblock_is_map_memory(addr);
-}
-EXPORT_SYMBOL(pfn_valid);
-#endif
-
 static bool arm_memblock_steal_permitted = true;
 
 phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..2ee48bdf9dc1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,7 +144,6 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
@@ -167,6 +166,7 @@ config ARM64
 		if $(cc-option,-fpatchable-function-entry=2)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_EARLY_SECTION_MEMMAP_HOLES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..635a030a3826 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -37,8 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
 
 typedef struct page *pgtable_t;
 
-extern int pfn_valid(unsigned long);
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3685e12aba9b..2cba4347aef2 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -217,47 +217,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
-int pfn_valid(unsigned long pfn)
-{
-	phys_addr_t addr = PFN_PHYS(pfn);
-
-	/*
-	 * Ensure the upper PAGE_SHIFT bits are clear in the
-	 * pfn. Else it might lead to false positives when
-	 * some of the upper bits are set, but the lower bits
-	 * match a valid pfn.
-	 */
-	if (PHYS_PFN(addr) != pfn)
-		return 0;
-
-#ifdef CONFIG_SPARSEMEM
-{
-	struct mem_section *ms;
-
-	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
-		return 0;
-
-	ms = __pfn_to_section(pfn);
-	if (!valid_section(ms))
-		return 0;
-
-	/*
-	 * ZONE_DEVICE memory does not have the memblock entries.
-	 * memblock_is_map_memory() check for ZONE_DEVICE based
-	 * addresses will always fail. Even the normal hotplugged
-	 * memory will never have MEMBLOCK_NOMAP flag set in their
-	 * memblock entries. Skip memblock search for all non early
-	 * memory sections covering all of hotplug memory including
-	 * both normal and ZONE_DEVICE based.
-	 */
-	if (!early_section(ms))
-		return pfn_section_valid(ms, pfn);
-}
-#endif
-	return memblock_is_map_memory(addr);
-}
-EXPORT_SYMBOL(pfn_valid);
-
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..93532994113f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1409,8 +1409,23 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 }
 #endif
 
+bool memblock_is_map_memory(phys_addr_t addr);
+
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
 static inline int pfn_valid(unsigned long pfn)
+{
+	phys_addr_t addr = PFN_PHYS(pfn);
+
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (PHYS_PFN(addr) != pfn)
+		return 0;
+
+#ifdef CONFIG_SPARSEMEM
 {
 	struct mem_section *ms;
 
@@ -1423,7 +1438,14 @@ static inline int pfn_valid(unsigned long pfn)
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	if (early_section(ms))
+		return IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ?
+			memblock_is_map_memory(pfn << PAGE_SHIFT) : 1;
+
+	return pfn_section_valid(ms, pfn);
+}
+#endif
+	return 1;
 }
 #endif
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..0ec20f661b3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -135,6 +135,16 @@ config HAVE_FAST_GUP
 config ARCH_KEEP_MEMBLOCK
 	bool
 
+config HAVE_EARLY_SECTION_MEMMAP_HOLES
+	depends on ARCH_KEEP_MEMBLOCK && SPARSEMEM_VMEMMAP
+	def_bool n
+	help
+	  Early sections on certain platforms might have portions which are
+	  not backed with struct page mapping as their memblock entries are
+	  marked with MEMBLOCK_NOMAP. When subscribed, this option enables
+	  specific handling for those memory sections in certain situations
+	  such as pfn_valid().
+
 # Keep arch NUMA mapping infrastructure post-init.
 config NUMA_KEEP_MEMINFO
 	bool
diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..d9fa2e62ab7a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1744,6 +1744,7 @@ bool __init_memblock memblock_is_map_memory(phys_addr_t addr)
 		return false;
 	return !memblock_is_nomap(&memblock.memory.regions[i]);
 }
+EXPORT_SYMBOL(memblock_is_map_memory);
 
 int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 			 unsigned long *start_pfn, unsigned long *end_pfn)
@@ -1926,7 +1927,7 @@ static void __init free_unused_memmap(void)
 	unsigned long start, end, prev_end = 0;
 	int i;
 
-	if (!IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) ||
+	if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ||
 	    IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
 		return;
 
-- 
2.20.1

