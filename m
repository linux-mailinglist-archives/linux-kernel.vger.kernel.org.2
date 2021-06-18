Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3FF3AC26D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFREso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:48:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhFREsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:48:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3DD113A1;
        Thu, 17 Jun 2021 21:46:27 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.86.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A386E3F694;
        Thu, 17 Jun 2021 21:46:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Rename ARM64_SWAPPER_USES_SECTION_MAPS
Date:   Fri, 18 Jun 2021 10:17:02 +0530
Message-Id: <1623991622-24294-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64_SWAPPER_USES_SECTION_MAPS implies that a PMD level huge page mappings
are used for swapper, idmap and vmemmap. Lets make it PMD explicit removing
any possible confusion with generic memory sections and also bit generic as
it's applicable for idmap and vmemmap mappings as well. Hence rename it as
ARM64_KERNEL_USES_PMD_MAPS instead.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on latest linux-next (20210617).

 arch/arm64/include/asm/kernel-pgtable.h | 10 +++++-----
 arch/arm64/mm/mmu.c                     |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 1260187adb31..3512184cfec1 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -18,9 +18,9 @@
  * 64K (section size = 512M).
  */
 #ifdef CONFIG_ARM64_4K_PAGES
-#define ARM64_SWAPPER_USES_SECTION_MAPS 1
+#define ARM64_KERNEL_USES_PMD_MAPS 1
 #else
-#define ARM64_SWAPPER_USES_SECTION_MAPS 0
+#define ARM64_KERNEL_USES_PMD_MAPS 0
 #endif
 
 /*
@@ -33,7 +33,7 @@
  * VA range, so pages required to map highest possible PA are reserved in all
  * cases.
  */
-#if ARM64_SWAPPER_USES_SECTION_MAPS
+#if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
 #define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT) - 1)
 #else
@@ -90,7 +90,7 @@
 #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
 /* Initial memory map size */
-#if ARM64_SWAPPER_USES_SECTION_MAPS
+#if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
 #define SWAPPER_BLOCK_SIZE	PMD_SIZE
 #define SWAPPER_TABLE_SHIFT	PUD_SHIFT
@@ -106,7 +106,7 @@
 #define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
-#if ARM64_SWAPPER_USES_SECTION_MAPS
+#if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
 #else
 #define SWAPPER_MM_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 37a9b8875769..d74586508448 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1114,14 +1114,14 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 }
 #endif
 
-#if !ARM64_SWAPPER_USES_SECTION_MAPS
+#if !ARM64_KERNEL_USES_PMD_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 	return vmemmap_populate_basepages(start, end, node, altmap);
 }
-#else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
+#else	/* !ARM64_KERNEL_USES_PMD_MAPS */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
@@ -1166,7 +1166,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	return 0;
 }
-#endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
+#endif	/* !ARM64_KERNEL_USES_PMD_MAPS */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
-- 
2.20.1

