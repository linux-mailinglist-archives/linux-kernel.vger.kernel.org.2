Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0535A390163
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhEYM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:56:51 -0400
Received: from foss.arm.com ([217.140.110.172]:55760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhEYM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:56:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234D56D;
        Tue, 25 May 2021 05:55:21 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B47CD3F719;
        Tue, 25 May 2021 05:55:17 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] arm64/mm: Drop HAVE_ARCH_PFN_VALID
Date:   Tue, 25 May 2021 18:25:49 +0530
Message-Id: <1621947349-25421-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SPARSEMEM_VMEMMAP is now the only available memory model on arm64
platforms and free_unused_memmap() would just return without creating any
holes in the memmap mapping. There is no need for any special handling in
pfn_valid() and HAVE_ARCH_PFN_VALID can just be dropped. This also moves
the pfn upper bits sanity check into generic pfn_valid().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on linux-next (next-20210525) which contain the prerequisite
series (https://patchwork.kernel.org/project/linux-mm/list/?series=480177).

 arch/arm64/Kconfig            |  1 -
 arch/arm64/include/asm/page.h |  1 -
 arch/arm64/mm/init.c          | 37 -----------------------------------
 include/linux/mmzone.h        |  9 +++++++++
 4 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d7dc8698cf8e..7904728befcc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,7 +154,6 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 75ddfe671393..fcbef3eec4b2 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -37,7 +37,6 @@ void copy_highpage(struct page *to, struct page *from);
 
 typedef struct page *pgtable_t;
 
-int pfn_valid(unsigned long pfn);
 int pfn_is_map_memory(unsigned long pfn);
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 725aa84f2faa..49019ea0c8a8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -219,43 +219,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
-int pfn_valid(unsigned long pfn)
-{
-	phys_addr_t addr = PFN_PHYS(pfn);
-	struct mem_section *ms;
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
-
-	return memblock_is_memory(addr);
-}
-EXPORT_SYMBOL(pfn_valid);
-
 int pfn_is_map_memory(unsigned long pfn)
 {
 	phys_addr_t addr = PFN_PHYS(pfn);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a9b263d4cf9d..d0c4fc506fa3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1443,6 +1443,15 @@ static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
 
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
+		return 0;
+
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __nr_to_section(pfn_to_section_nr(pfn));
-- 
2.20.1

