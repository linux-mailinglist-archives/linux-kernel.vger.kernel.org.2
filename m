Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C313EADB9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhHLXjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238480AbhHLXia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7766D6112E;
        Thu, 12 Aug 2021 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811484;
        bh=WwnrEymPtlTXjy10ynCidFxMgHguuIzE/6UZ1pzghrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isKycoi2XNHSvdcerZYs00WsF4IWnL5ab2yY6BhAjcr2inMrF6bR8DVcPtADZxM8F
         AJjsG0M1wX88FKJC28LkQR7tKiD+Bj9DqMWCFa6si6z+T7eHxUA1bdps461M0zUsHJ
         kAymUno45/Ii8RwiJfwJCwKx0DgIudQuZ96ar1H3Gxppy9ToPKiXS6yPCOMACYOBrm
         nCXiUVWWbbqCg7xb7NvWybTlWSLsdiceMPphU4knfALUvXHFT4bEB6gF+mSlOAPiTw
         nOiiBiobX1lQZ8G0/Bf1thsTcjMDL6xfQqiLUylLgcBIj+q9uavsAQq9UWetDcWnmv
         5IRDjaJSovhLw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 16/19] ARC: mm: support 3 levels of page tables
Date:   Thu, 12 Aug 2021 16:37:50 -0700
Message-Id: <20210812233753.104217-17-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCv2 MMU is software walked and Linux implements 2 levels of paging: pgd/pte.
Forthcoming hw will have multiple levels, so this change preps mm code
for same. It is also fun to try multi levels even on soft-walked code to
ensure generic mm code is robust to handle.

overview
________

2 levels {pgd, pte} : pmd is folded but pmd_* macros are valid and operate on pgd
3 levels {pgd, pmd, pte}:
  - pud is folded and pud_* macros point to pgd
  - pmd_* macros operate on actual pmd

code changes
____________

1. #include <asm-generic/pgtable-nopud.h>

2. Define CONFIG_PGTABLE_LEVELS 3

3a. Define PMD_SHIFT, PMD_SIZE, PMD_MASK, pmd_t
3b. Define pmd_val() which actually deals with pmd
    (pmd_offset(), pmd_index() are provided by generic code)
3c. pmd_alloc_one()/pmd_free() also provided by generic code
    (pmd_populate/pmd_free already exist)

4. Define pud_none(), pud_bad() macros based on generic pud_val() which
   internally pertains to pgd now.
4b. define pud_populate() to just setup pgd

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig                      |  4 ++
 arch/arc/include/asm/page.h           | 11 +++++
 arch/arc/include/asm/pgalloc.h        | 11 +++++
 arch/arc/include/asm/pgtable-levels.h | 63 ++++++++++++++++++++++++---
 arch/arc/include/asm/processor.h      |  2 +-
 arch/arc/mm/fault.c                   |  4 ++
 arch/arc/mm/init.c                    |  1 +
 arch/arc/mm/tlb.c                     |  4 +-
 arch/arc/mm/tlbex.S                   |  9 ++++
 9 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 59d5b2a179f6..43cb8aaf57a2 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -314,6 +314,10 @@ config ARC_HUGEPAGE_16M
 
 endchoice
 
+config PGTABLE_LEVELS
+	int "Number of Page table levels"
+	default 2
+
 config ARC_COMPACT_IRQ_LEVELS
 	depends on ISA_ARCOMPACT
 	bool "Setup Timer IRQ as high Priority"
diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 28ed82b1800f..5d7899d87c08 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -41,6 +41,17 @@ typedef struct {
 #define pgd_val(x)	((x).pgd)
 #define __pgd(x)	((pgd_t) { (x) })
 
+#if CONFIG_PGTABLE_LEVELS > 2
+
+typedef struct {
+	unsigned long pmd;
+} pmd_t;
+
+#define pmd_val(x)	((x).pmd)
+#define __pmd(x)	((pmd_t) { (x) })
+
+#endif
+
 typedef struct {
 #ifdef CONFIG_ARC_HAS_PAE40
 	unsigned long long pte;
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 0cde9e5eefd7..781620d2e86f 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -70,6 +70,17 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return ret;
 }
 
+#if CONFIG_PGTABLE_LEVELS > 2
+
+static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
+{
+	set_pud(pudp, __pud((unsigned long)pmdp));
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+
+#endif
+
 #define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
 
 #endif /* _ASM_ARC_PGALLOC_H */
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 8ece75335bb5..1c2f022d4ad0 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -10,6 +10,8 @@
 #ifndef _ASM_ARC_PGTABLE_LEVELS_H
 #define _ASM_ARC_PGTABLE_LEVELS_H
 
+#if CONFIG_PGTABLE_LEVELS == 2
+
 /*
  * 2 level paging setup for software walked MMUv3 (ARC700) and MMUv4 (HS)
  *
@@ -37,16 +39,38 @@
 #define PGDIR_SHIFT		21
 #endif
 
-#define PGDIR_SIZE		BIT(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
-#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
+#else
+
+/*
+ * A default 3 level paging testing setup in software walked MMU
+ *   MMUv4 (8K page): <4> : <7> : <8> : <13>
+ */
+#define PGDIR_SHIFT		28
+#if CONFIG_PGTABLE_LEVELS > 2
+#define PMD_SHIFT		21
+#endif
+
+#endif
 
+#define PGDIR_SIZE		BIT(PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
 #define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
 
-#define PTRS_PER_PTE		BIT(PGDIR_SHIFT - PAGE_SHIFT)
+#if CONFIG_PGTABLE_LEVELS > 2
+#define PMD_SIZE		BIT(PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE - 1))
+#define PTRS_PER_PMD		BIT(PGDIR_SHIFT - PMD_SHIFT)
+#endif
+
+#define PTRS_PER_PTE		BIT(PMD_SHIFT - PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 
+#if CONFIG_PGTABLE_LEVELS > 2
+#include <asm-generic/pgtable-nopud.h>
+#else
 #include <asm-generic/pgtable-nopmd.h>
+#endif
 
 /*
  * 1st level paging: pgd
@@ -57,9 +81,35 @@
 #define pgd_ERROR(e) \
 	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#if CONFIG_PGTABLE_LEVELS > 2
+
+/* In 3 level paging, pud_* macros work on pgd */
+#define pud_none(x)		(!pud_val(x))
+#define pud_bad(x)		((pud_val(x) & ~PAGE_MASK))
+#define pud_present(x)		(pud_val(x))
+#define pud_clear(xp)		do { pud_val(*(xp)) = 0; } while (0)
+#define pud_pgtable(pud)	((pmd_t *)(pud_val(pud) & PAGE_MASK))
+#define pud_page(pud)		virt_to_page(pud_pgtable(pud))
+#define set_pud(pudp, pud)	(*(pudp) = pud)
+
+/*
+ * 2nd level paging: pmd
+ */
+#define pmd_ERROR(e) \
+	pr_crit("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+
+#define pmd_pfn(pmd)		((pmd_val(pmd) & PMD_MASK) >> PAGE_SHIFT)
+#define pfn_pmd(pfn,prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
+
+#endif
+
 /*
- * Due to the strange way generic pgtable level folding works, in a 2 level
- * setup, pmd_val() returns pgd, so these pmd_* macros actually work on pgd
+ * Due to the strange way generic pgtable level folding works, the pmd_* macros
+ *  - are valid even for 2 levels (which supposedly only has pgd - pte)
+ *  - behave differently for 2 vs. 3
+ * In 2  level paging        (pgd -> pte), pmd_* macros work on pgd
+ * In 3+ level paging (pgd -> pmd -> pte), pmd_* macros work on pmd
  */
 #define pmd_none(x)		(!pmd_val(x))
 #define pmd_bad(x)		((pmd_val(x) & ~PAGE_MASK))
@@ -70,6 +120,9 @@
 #define set_pmd(pmdp, pmd)	(*(pmdp) = pmd)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
 
+/*
+ * 3rd level paging: pte
+ */
 #define pte_ERROR(e) \
 	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 
diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index e4031ecd3c8c..f28afcf5c6d1 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -93,7 +93,7 @@ extern unsigned int get_wchan(struct task_struct *p);
 #define VMALLOC_START	(PAGE_OFFSET - (CONFIG_ARC_KVADDR_SIZE << 20))
 
 /* 1 PGDIR_SIZE each for fixmap/pkmap, 2 PGDIR_SIZE gutter (see asm/highmem.h) */
-#define VMALLOC_SIZE	((CONFIG_ARC_KVADDR_SIZE << 20) - PGDIR_SIZE * 4)
+#define VMALLOC_SIZE	((CONFIG_ARC_KVADDR_SIZE << 20) - PMD_SIZE * 4)
 
 #define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
 
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 41f154320964..8da2f0ad8c69 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -39,6 +39,8 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
+	set_pgd(pgd, *pgd_k);
+
 	p4d = p4d_offset(pgd, address);
 	p4d_k = p4d_offset(pgd_k, address);
 	if (!p4d_present(*p4d_k))
@@ -49,6 +51,8 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
+	set_pud(pud, *pud_k);
+
 	pmd = pmd_offset(pud, address);
 	pmd_k = pmd_offset(pud_k, address);
 	if (!pmd_present(*pmd_k))
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 46ad9aee7a73..f7ba2a5d5ec8 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -191,6 +191,7 @@ void __init mem_init(void)
 	highmem_init();
 
 	BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
+	BUILD_BUG_ON((PTRS_PER_PMD * sizeof(pmd_t)) > PAGE_SIZE);
 	BUILD_BUG_ON((PTRS_PER_PTE * sizeof(pte_t)) > PAGE_SIZE);
 }
 
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index b68d5798327b..352abb35a2ad 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -658,8 +658,8 @@ char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len)
 			  IS_USED_CFG(CONFIG_TRANSPARENT_HUGEPAGE));
 
 	n += scnprintf(buf + n, len - n,
-		      "MMU [v%x]\t: %dk PAGE, %sJTLB %d (%dx%d), uDTLB %d, uITLB %d%s%s\n",
-		       p_mmu->ver, p_mmu->pg_sz_k, super_pg,
+		      "MMU [v%x]\t: %dk PAGE, %s, swalk %d lvl, JTLB %d (%dx%d), uDTLB %d, uITLB %d%s%s\n",
+		       p_mmu->ver, p_mmu->pg_sz_k, super_pg,  CONFIG_PGTABLE_LEVELS,
 		       p_mmu->sets * p_mmu->ways, p_mmu->sets, p_mmu->ways,
 		       p_mmu->u_dtlb, p_mmu->u_itlb,
 		       IS_AVAIL2(p_mmu->pae, ", PAE40 ", CONFIG_ARC_HAS_PAE40));
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index c4a5f16444ce..5f57eba1089d 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -173,6 +173,15 @@ ex_saved_reg1:
 	tst	r3, r3
 	bz	do_slow_path_pf         ; if no Page Table, do page fault
 
+#if CONFIG_PGTABLE_LEVELS > 2
+	lsr     r0, r2, PMD_SHIFT	; Bits for indexing into PMD
+	and	r0, r0, (PTRS_PER_PMD - 1)
+	ld.as	r1, [r3, r0]		; PMD entry
+	tst	r1, r1
+	bz	do_slow_path_pf
+	mov	r3, r1
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	and.f	0, r3, _PAGE_HW_SZ	; Is this Huge PMD (thp)
 	add2.nz	r1, r1, r0
-- 
2.25.1

