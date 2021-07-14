Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEFE3C7BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhGNCYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:24:20 -0400
Received: from foss.arm.com ([217.140.110.172]:55792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237474AbhGNCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:24:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F17D6E;
        Tue, 13 Jul 2021 19:21:28 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A30C33F7D8;
        Tue, 13 Jul 2021 19:21:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 06/10] arm64/mm: Add FEAT_LPA2 specific encoding
Date:   Wed, 14 Jul 2021 07:51:27 +0530
Message-Id: <1626229291-6569-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_LPA2 requires different PTE representation formats for both 4K and 16K
page size config. This adds FEAT_LPA2 specific new PTE encodings as per ARM
ARM (0487G.A) which updates [pte|phys]_to_[phys|pte](). The updated helpers
would be used when FEAT_LPA2 gets enabled via CONFIG_ARM64_PA_BITS_52 on 4K
and 16K page size. Although TTBR encoding and phys_to_ttbr() helper remains
the same as FEAT_LPA for FEAT_LPA2 as well. It updates 'phys_to_pte' helper
to accept a temporary variable and changes impacted call sites.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++----
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++++
 arch/arm64/include/asm/pgtable.h       |  4 ++++
 arch/arm64/kernel/head.S               | 25 +++++++++++++------------
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fedc202..0492543 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -606,7 +606,7 @@ alternative_endif
 #endif
 	.endm
 
-	.macro	phys_to_pte, pte, phys
+	.macro	phys_to_pte, pte, phys, tmp
 #ifdef CONFIG_ARM64_PA_BITS_52_LPA
 	/*
 	 * We assume \phys is 64K aligned and this is guaranteed by only
@@ -614,6 +614,17 @@ alternative_endif
 	 */
 	orr	\pte, \phys, \phys, lsr #36
 	and	\pte, \pte, #PTE_ADDR_MASK
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	orr	\pte, \phys, \phys, lsr #42
+
+	/*
+	 * The 'tmp' is being used here to just prepare
+	 * and hold PTE_ADDR_MASK which cannot be passed
+	 * to the subsequent 'and' instruction.
+	 */
+	mov	\tmp, #PTE_ADDR_LOW
+	orr	\tmp, \tmp, #PTE_ADDR_HIGH
+	and	\pte, \pte, \tmp
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	mov	\pte, \phys
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
@@ -621,9 +632,13 @@ alternative_endif
 
 	.macro	pte_to_phys, phys, pte
 #ifdef CONFIG_ARM64_PA_BITS_52_LPA
-	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
-	bfxil	\phys, \pte, #16, #32
-	lsl	\phys, \phys, #16
+	ubfiz	\phys, \pte, #(48 - PAGE_SHIFT - 12), #16
+	bfxil	\phys, \pte, #PAGE_SHIFT, #(48 - PAGE_SHIFT)
+	lsl	\phys, \phys, #PAGE_SHIFT
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	ubfiz	\phys, \pte, #(52 - PAGE_SHIFT - 10), #10
+	bfxil	\phys, \pte, #PAGE_SHIFT, #(50 - PAGE_SHIFT)
+	lsl	\phys, \phys, #PAGE_SHIFT
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	and	\phys, \pte, #PTE_ADDR_MASK
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index f375bcf..c815a85 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -159,6 +159,10 @@
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (50 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+#define PTE_ADDR_HIGH		(_AT(pteval_t, 0x3) << 8)
+#define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #define PTE_ADDR_MASK		PTE_ADDR_LOW
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3c57fb2..5e7e402 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -70,6 +70,10 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define __pte_to_phys(pte)	\
 	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
 #define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+#define __pte_to_phys(pte)	\
+	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 42))
+#define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 42)) & PTE_ADDR_MASK)
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
 #define __phys_to_pte_val(phys)	(phys)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c5c994a..6444147 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -134,9 +134,9 @@ SYM_CODE_END(preserve_boot_args)
  * Corrupts:	ptrs, tmp1, tmp2
  * Returns:	tbl -> next level table page address
  */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
+	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2, tmp3
 	add	\tmp1, \tbl, #PAGE_SIZE
-	phys_to_pte \tmp2, \tmp1
+	phys_to_pte \tmp2, \tmp1, \tmp3
 	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	lsr	\tmp1, \virt, #\shift
 	sub	\ptrs, \ptrs, #1
@@ -161,8 +161,8 @@ SYM_CODE_END(preserve_boot_args)
  * Corrupts:	index, tmp1
  * Returns:	rtbl
  */
-	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1
-.Lpe\@:	phys_to_pte \tmp1, \rtbl
+	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1, tmp2
+.Lpe\@:	phys_to_pte \tmp1, \rtbl, \tmp2
 	orr	\tmp1, \tmp1, \flags	// tmp1 = table entry
 	str	\tmp1, [\tbl, \index, lsl #3]
 	add	\rtbl, \rtbl, \inc	// rtbl = pa next level
@@ -224,31 +224,32 @@ SYM_CODE_END(preserve_boot_args)
  * Preserves:	vstart, vend, flags
  * Corrupts:	tbl, rtbl, istart, iend, tmp, count, sv
  */
-	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, pgds, istart, iend, tmp, count, sv
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, pgds, istart, iend, \
+								tmp, tmp1, count, sv
 	add \rtbl, \tbl, #PAGE_SIZE
 	mov \sv, \rtbl
 	mov \count, #0
 	compute_indices \vstart, \vend, #PGDIR_SHIFT, \pgds, \istart, \iend, \count
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp, \tmp1
 	mov \tbl, \sv
 	mov \sv, \rtbl
 
 #if SWAPPER_PGTABLE_LEVELS > 3
 	compute_indices \vstart, \vend, #PUD_SHIFT, #PTRS_PER_PUD, \istart, \iend, \count
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp, \tmp1
 	mov \tbl, \sv
 	mov \sv, \rtbl
 #endif
 
 #if SWAPPER_PGTABLE_LEVELS > 2
 	compute_indices \vstart, \vend, #SWAPPER_TABLE_SHIFT, #PTRS_PER_PMD, \istart, \iend, \count
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp, \tmp1
 	mov \tbl, \sv
 #endif
 
 	compute_indices \vstart, \vend, #SWAPPER_BLOCK_SHIFT, #PTRS_PER_PTE, \istart, \iend, \count
 	bic \count, \phys, #SWAPPER_BLOCK_SIZE - 1
-	populate_entries \tbl, \count, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
+	populate_entries \tbl, \count, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp, \tmp1
 	.endm
 
 /*
@@ -343,7 +344,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #endif
 
 	mov	x4, EXTRA_PTRS
-	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6, x20
 #else
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
@@ -356,7 +357,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	ldr_l	x4, idmap_ptrs_per_pgd
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
-	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
+	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x20, x13, x14
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -370,7 +371,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
 
-	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
+	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x20, x13, x14
 
 	/*
 	 * Since the page tables have been populated with non-cacheable
-- 
2.7.4

