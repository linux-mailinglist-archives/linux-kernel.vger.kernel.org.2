Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D303E8765
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhHKAoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236070AbhHKAnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C69C60EB9;
        Wed, 11 Aug 2021 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642603;
        bh=bkSeK1zM8h+JAAwlZRlJp4kcognaCCVRcd5O5x4DWII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTmZmpVbbXqnh9TVRFwLMoAKGFYaxy6EIAZYZ9Or+yC04yXxh8CPyNvv//OB/89On
         cRZeQ7WUVn9vMYQ8qXM7tE947CmZGBGoy/7+q3bWPQY1L0jxe431nY3eKI36TZJclg
         exYHWq9ckoJPpMFiAmzX9BqGlgf9LbJUdGXhwDe+7izebqxgqq5/vR6LDOkvM/LqfX
         QU6Ad0hBV+pNgrbfBk0X46vduXxi3E767Wu0I0kBvp4PjXeOYuT1GCAMaHJT0Ub+pt
         Pibgs8vmBCHolgHTtQ1atZU1syYeRRfiXfF4izfN98TNd8sPHMKi0EhquPKY3EHySD
         LNZtRxggf36lw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 16/18] ARC: mm: support 4 levels of page tables
Date:   Tue, 10 Aug 2021 17:42:56 -0700
Message-Id: <20210811004258.138075-17-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/page.h           | 11 +++++++
 arch/arc/include/asm/pgalloc.h        | 22 +++++++++++++
 arch/arc/include/asm/pgtable-levels.h | 45 ++++++++++++++++++++++++---
 arch/arc/mm/fault.c                   |  2 ++
 arch/arc/mm/tlbex.S                   |  9 ++++++
 5 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index df3cc154ae4a..883856f12afe 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -41,6 +41,17 @@ typedef struct {
 #define pgd_val(x)	((x).pgd)
 #define __pgd(x)	((pgd_t) { (x) })
 
+#if CONFIG_PGTABLE_LEVELS > 3
+
+typedef struct {
+	unsigned long pud;
+} pud_t;
+
+#define pud_val(x)      	((x).pud)
+#define __pud(x)        	((pud_t) { (x) })
+
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 typedef struct {
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 01c2d84418ed..e99c724d9235 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -86,6 +86,28 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 }
 
 
+#if CONFIG_PGTABLE_LEVELS > 3
+
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
+{
+	set_p4d(p4dp, __p4d((unsigned long)pudp));
+}
+
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return (pud_t *)__get_free_page(
+		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
+{
+	free_page((unsigned long)pudp);
+}
+
+#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
+
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 1c2f022d4ad0..2da3c4e52a91 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -44,8 +44,13 @@
 /*
  * A default 3 level paging testing setup in software walked MMU
  *   MMUv4 (8K page): <4> : <7> : <8> : <13>
+ * A default 4 level paging testing setup in software walked MMU
+ *   MMUv4 (8K page): <4> : <3> : <4> : <8> : <13>
  */
 #define PGDIR_SHIFT		28
+#if CONFIG_PGTABLE_LEVELS > 3
+#define PUD_SHIFT		25
+#endif
 #if CONFIG_PGTABLE_LEVELS > 2
 #define PMD_SHIFT		21
 #endif
@@ -56,17 +61,25 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE - 1))
 #define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
 
+#if CONFIG_PGTABLE_LEVELS > 3
+#define PUD_SIZE		BIT(PUD_SHIFT)
+#define PUD_MASK		(~(PUD_SIZE - 1))
+#define PTRS_PER_PUD		BIT(PGDIR_SHIFT - PUD_SHIFT)
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 #define PMD_SIZE		BIT(PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE - 1))
-#define PTRS_PER_PMD		BIT(PGDIR_SHIFT - PMD_SHIFT)
+#define PTRS_PER_PMD		BIT(PUD_SHIFT - PMD_SHIFT)
 #endif
 
 #define PTRS_PER_PTE		BIT(PMD_SHIFT - PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 
-#if CONFIG_PGTABLE_LEVELS > 2
+#if CONFIG_PGTABLE_LEVELS > 3
+#include <asm-generic/pgtable-nop4d.h>
+#elif CONFIG_PGTABLE_LEVELS > 2
 #include <asm-generic/pgtable-nopud.h>
 #else
 #include <asm-generic/pgtable-nopmd.h>
@@ -81,9 +94,31 @@
 #define pgd_ERROR(e) \
 	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#if CONFIG_PGTABLE_LEVELS > 3
+
+/* In 4 level paging, p4d_* macros work on pgd */
+#define p4d_none(x)		(!p4d_val(x))
+#define p4d_bad(x)		((p4d_val(x) & ~PAGE_MASK))
+#define p4d_present(x)		(p4d_val(x))
+#define p4d_clear(xp)		do { p4d_val(*(xp)) = 0; } while (0)
+#define p4d_pgtable(p4d)	((pud_t *)(p4d_val(p4d) & PAGE_MASK))
+#define p4d_page(p4d)		virt_to_page(p4d_pgtable(p4d))
+#define set_p4d(p4dp, p4d)	(*(p4dp) = p4d)
+
+/*
+ * 2nd level paging: pud
+ */
+#define pud_ERROR(e) \
+	pr_crit("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
+
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
-/* In 3 level paging, pud_* macros work on pgd */
+/*
+ * In 3 level paging, pud_* macros work on pgd
+ * In 4 level paging, pud_* macros work on pud
+ */
 #define pud_none(x)		(!pud_val(x))
 #define pud_bad(x)		((pud_val(x) & ~PAGE_MASK))
 #define pud_present(x)		(pud_val(x))
@@ -93,7 +128,7 @@
 #define set_pud(pudp, pud)	(*(pudp) = pud)
 
 /*
- * 2nd level paging: pmd
+ * 3rd level paging: pmd
  */
 #define pmd_ERROR(e) \
 	pr_crit("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
@@ -121,7 +156,7 @@
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
 
 /*
- * 3rd level paging: pte
+ * 4th level paging: pte
  */
 #define pte_ERROR(e) \
 	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 8da2f0ad8c69..f8994164fa36 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -46,6 +46,8 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!p4d_present(*p4d_k))
 		goto bad_area;
 
+	set_p4d(p4d, *p4d_k);
+
 	pud = pud_offset(p4d, address);
 	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 5f6bfdfda1be..e1831b6fafa9 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -173,6 +173,15 @@ ex_saved_reg1:
 	tst	r3, r3
 	bz	do_slow_path_pf         ; if no Page Table, do page fault
 
+#if CONFIG_PGTABLE_LEVELS > 3
+	lsr     r0, r2, PUD_SHIFT	; Bits for indexing into PUD
+	and	r0, r0, (PTRS_PER_PUD - 1)
+	ld.as	r1, [r3, r0]		; PMD entry
+	tst	r1, r1
+	bz	do_slow_path_pf
+	mov	r3, r1
+#endif
+
 #if CONFIG_PGTABLE_LEVELS > 2
 	lsr     r0, r2, PMD_SHIFT	; Bits for indexing into PMD
 	and	r0, r0, (PTRS_PER_PMD - 1)
-- 
2.25.1

