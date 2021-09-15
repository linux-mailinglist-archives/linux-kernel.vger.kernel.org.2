Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D402440BE62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhIODor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:44:47 -0400
Received: from foss.arm.com ([217.140.110.172]:51630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhIODoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:44:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24CB231B;
        Tue, 14 Sep 2021 20:43:28 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.70.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7047D3F5A1;
        Tue, 14 Sep 2021 20:43:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Add pud_sect_supported()
Date:   Wed, 15 Sep 2021 09:14:19 +0530
Message-Id: <1631677459-28383-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section mapping at PUD level is supported only on 4K pages and currently it
gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
new helper pud_sect_supported() for this purpose, which particularly cleans
up the HugeTLB code path. It updates relevant switch statements with checks
for __PAGETABLE_PUD_FOLDED in order to avoid build failures caused with two
identical switch case values in those code blocks.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.15-rc1

 arch/arm64/include/asm/pgtable.h |  5 +++++
 arch/arm64/include/asm/vmalloc.h |  4 ++--
 arch/arm64/mm/hugetlbpage.c      | 26 +++++++++++++++-----------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index dfa76afa0ccf..84fbb52b4224 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1022,6 +1022,11 @@ static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 	return PAGE_READONLY_EXEC;
 }
 
+static inline bool pud_sect_supported(void)
+{
+	return PAGE_SIZE == SZ_4K;
+}
+
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 7a22aeea9bb5..b9185503feae 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -2,6 +2,7 @@
 #define _ASM_ARM64_VMALLOC_H
 
 #include <asm/page.h>
+#include <asm/pgtable.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
@@ -9,10 +10,9 @@
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/*
-	 * Only 4k granule supports level 1 block mappings.
 	 * SW table walks can't handle removal of intermediate entries.
 	 */
-	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
+	return pud_sect_supported() &&
 	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 23505fc35324..641854f0e8ee 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -40,11 +40,10 @@ void __init arm64_hugetlb_cma_reserve(void)
 {
 	int order;
 
-#ifdef CONFIG_ARM64_4K_PAGES
-	order = PUD_SHIFT - PAGE_SHIFT;
-#else
-	order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
-#endif
+	if (pud_sect_supported())
+		order = PUD_SHIFT - PAGE_SHIFT;
+	else
+		order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
 	/*
 	 * HugeTLB CMA reservation is required for gigantic
 	 * huge pages which could not be allocated via the
@@ -62,8 +61,9 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
 	size_t pagesize = huge_page_size(h);
 
 	switch (pagesize) {
-#ifdef CONFIG_ARM64_4K_PAGES
+#ifndef __PAGETABLE_PUD_FOLDED
 	case PUD_SIZE:
+		return pud_sect_supported();
 #endif
 	case PMD_SIZE:
 	case CONT_PMD_SIZE:
@@ -126,8 +126,11 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	*pgsize = size;
 
 	switch (size) {
-#ifdef CONFIG_ARM64_4K_PAGES
+#ifndef __PAGETABLE_PUD_FOLDED
 	case PUD_SIZE:
+		if (pud_sect_supported())
+			contig_ptes = 1;
+		break;
 #endif
 	case PMD_SIZE:
 		contig_ptes = 1;
@@ -489,9 +492,9 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 
 static int __init hugetlbpage_init(void)
 {
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
-#endif
+	if (pud_sect_supported())
+		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+
 	hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
 	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
 	hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
@@ -503,8 +506,9 @@ arch_initcall(hugetlbpage_init);
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	switch (size) {
-#ifdef CONFIG_ARM64_4K_PAGES
+#ifndef __PAGETABLE_PUD_FOLDED
 	case PUD_SIZE:
+		return pud_sect_supported();
 #endif
 	case CONT_PMD_SIZE:
 	case PMD_SIZE:
-- 
2.20.1

