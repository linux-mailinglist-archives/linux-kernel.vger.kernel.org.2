Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716DF309965
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhAaAWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhAaAR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E138C0617AA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:27 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t25so9449266pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElI7mxctjrmKx7eCNMFhwo+0oUmE+713UYT2vq30CCA=;
        b=VoErfthXvUHlf0A89aRqLo5YMgSxGBm/eX/s9E5U0RqmefKZ4dYW+dDdr71xhasTKR
         jiubmwQKBeIZ1pbM4uc05+sat9CG67olBqgzi9H/cycz9jHlXlHF/n8T2IcZncamZvfV
         IzCNBeONuYPPn6zIQzrAY3cBXCEYh04+pQYtaqjR6moxO6S8fEBSvmB8GS0SIHyQWxM+
         6olU2xvdJYEwUYHlqvzcxO0biEd/uL1u4x4H/OhYj+i30nQLoN5IbadqinmzsTDhIb4z
         6gkgemMIGS24HEwSq8kTLYnFmNrlXbFVvL2PmGjC8DoaqT3bZ2Q14iwT+pUMXUWh/o9o
         7RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElI7mxctjrmKx7eCNMFhwo+0oUmE+713UYT2vq30CCA=;
        b=ABOGVWTD9VX06OaV2rlOnFQdCb1lDgTPOttZfUAhShhBoV7EkwKoaVesBzbCQW8g3O
         ykj8whi15eqBcSisc/x5i6Vx6xsPn2PcPNyzfoLhHF0cn1gBu9c9SQXLBsTaXLK12dGQ
         q+FfaxIb6qMzuDLWZePx9UKKzrZ7EoeoXsgmICedEJKXU35HCor3d9aOs4KD/XygE8Tf
         z7iV7ej3iEXM9PgVKacTYZ6DU5DIbbUw8S3LB61V0T9GKzQl7of8Q3KzdCSEWtIsx9Qw
         ssdc06g7jMLy+xD9l3GY2JjpixRiVaN5BcBwin4tl91qbBQMt7wYkahMPc+fkYVARd+7
         z1LA==
X-Gm-Message-State: AOAM533pQtg8rK2lZU/5QrcklytWfOfD8yjWGz9qvccLKkH3TiwGu2A+
        JV65DHm1tXI9wOqr9rzVHU4=
X-Google-Smtp-Source: ABdhPJzug1v9DT8EGutRtA5bxGDyj1wQn8vVmXM8N6eCVwRItNY/5oL6QbIAd1LvLu4xsBYwgt5D+A==
X-Received: by 2002:a63:3747:: with SMTP id g7mr10371402pgn.376.1612052186671;
        Sat, 30 Jan 2021 16:16:26 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:25 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: [RFC 16/20] mm/tlb: per-page table generation tracking
Date:   Sat, 30 Jan 2021 16:11:28 -0800
Message-Id: <20210131001132.3368247-17-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Detecting deferred TLB flushes per-VMA has two drawbacks:

1. It requires an atomic cmpxchg to record mm's TLB generation at the
time of the last TLB flush, as two deferred TLB flushes on the same VMA
can race.

2. It might be in coarse granularity for large VMAs.

On 64-bit architectures that have available space on page-struct, we can
resolve these two drawbacks by recording the TLB generation at the time
of the last deferred flush in page-struct of page-table whose TLB
flushes were deferred.

Introduce a new CONFIG_PER_TABLE_DEFERRED_FLUSHES config option. Record
when enabled the deferred TLB flush generation on page-struct, which is
protected by the page-table lock.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pgtable.h | 23 ++++++------
 fs/proc/task_mmu.c             |  6 ++--
 include/asm-generic/tlb.h      | 65 ++++++++++++++++++++++++++--------
 include/linux/mm.h             | 13 +++++++
 include/linux/mm_types.h       | 22 ++++++++++++
 init/Kconfig                   |  7 ++++
 mm/huge_memory.c               |  2 +-
 mm/mapping_dirty_helpers.c     |  4 +--
 mm/mprotect.c                  |  2 +-
 10 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d56b0f5cb00c..dfc6ee9dbe9c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -250,6 +250,7 @@ config X86
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select MAPPING_DIRTY_HELPERS
+	select PER_TABLE_DEFERRED_FLUSHES	if X86_64
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a0e069c15dbc..b380a849be90 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -774,17 +774,18 @@ static inline int pte_devmap(pte_t a)
 }
 #endif
 
-#define pte_accessible pte_accessible
-static inline bool pte_accessible(struct vm_area_struct *vma, pte_t *a)
-{
-	if (pte_flags(*a) & _PAGE_PRESENT)
-		return true;
-
-	if ((pte_flags(*a) & _PAGE_PROTNONE) && pte_tlb_flush_pending(vma, a))
-		return true;
-
-	return false;
-}
+#define pte_accessible(vma, a)						\
+	({								\
+		pte_t *_a = (a);					\
+		bool r = false;						\
+									\
+		if (pte_flags(*_a) & _PAGE_PRESENT)			\
+			r = true;					\
+		else							\
+			r = ((pte_flags(*_a) & _PAGE_PROTNONE) &&	\
+			     pte_tlb_flush_pending((vma), _a));		\
+		r;							\
+	})
 
 static inline int pmd_present(pmd_t pmd)
 {
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d0cce961fa5c..00e116feb62c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1157,7 +1157,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
 		test_and_clear_page_young(page);
-		tlb_flush_pmd_range(&cp->tlb, addr, HPAGE_PMD_SIZE);
+		tlb_flush_pmd_range(&cp->tlb, pmd, addr, HPAGE_PMD_SIZE);
 		ClearPageReferenced(page);
 out:
 		spin_unlock(ptl);
@@ -1174,7 +1174,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
 			clear_soft_dirty(vma, addr, pte);
-			tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
+			tlb_flush_pte_range(&cp->tlb, pte, addr, PAGE_SIZE);
 			continue;
 		}
 
@@ -1188,7 +1188,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
 		test_and_clear_page_young(page);
-		tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
+		tlb_flush_pte_range(&cp->tlb, pte, addr, PAGE_SIZE);
 		ClearPageReferenced(page);
 	}
 	tlb_end_ptes(&cp->tlb);
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f25d2d955076..74dbb56d816d 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -310,10 +310,12 @@ struct mmu_gather {
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
-
 #ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
 	u64			defer_gen;
 #endif
+#ifdef CONFIG_PER_TABLE_DEFERRED_FLUSHES
+	pte_t			*last_pte;
+#endif
 #endif
 };
 
@@ -572,21 +574,45 @@ static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
 	}
 }
 
+#ifndef CONFIG_PER_TABLE_DEFERRED_FLUSHES
+
 /*
- * Store the deferred TLB generation in the VMA
+ * Store the deferred TLB generation in the VMA or page-table for PTEs or PMDs
  */
-static inline void store_deferred_tlb_gen(struct mmu_gather *tlb)
+static inline void store_deferred_tlb_gen(struct mmu_gather *tlb,
+					  struct page *page)
 {
 	tlb_update_generation(&tlb->vma->defer_tlb_gen, tlb->defer_gen);
 }
 
+static inline void tlb_set_last_pte(struct mmu_gather *tlb, pte_t *pte) { }
+
+#else /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
+
+/*
+ * Store the deferred TLB generation in the VMA
+ */
+static inline void store_deferred_tlb_gen(struct mmu_gather *tlb,
+					  struct page *page)
+{
+	page->deferred_tlb_gen = tlb->defer_gen;
+}
+
+static inline void tlb_set_last_pte(struct mmu_gather *tlb, pte_t *pte)
+{
+	tlb->last_pte = pte;
+}
+
+#endif /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
+
 /*
  * Track deferred TLB flushes for PTEs and PMDs to allow fine granularity checks
  * whether a PTE is accessible. The TLB generation after the PTE is flushed is
  * saved in the mmu_gather struct. Once a flush is performed, the geneartion is
  * advanced.
  */
-static inline void track_defer_tlb_flush(struct mmu_gather *tlb)
+static inline void track_defer_tlb_flush(struct mmu_gather *tlb,
+					 struct page *page)
 {
 	if (tlb->fullmm)
 		return;
@@ -594,7 +620,7 @@ static inline void track_defer_tlb_flush(struct mmu_gather *tlb)
 	BUG_ON(!tlb->vma);
 
 	read_defer_tlb_flush_gen(tlb);
-	store_deferred_tlb_gen(tlb);
+	store_deferred_tlb_gen(tlb, page);
 }
 
 #define init_vma_tlb_generation(vma)				\
@@ -610,6 +636,7 @@ static inline void init_vma_tlb_generation(struct vm_area_struct *vma) { }
 		flush_tlb_batched_pending(_tlb->mm);			\
 		if (IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))	\
 			_tlb->cleared_ptes_in_table = 0;		\
+		tlb_set_last_pte(_tlb, NULL);				\
 	} while (0)
 
 static inline void tlb_end_ptes(struct mmu_gather *tlb)
@@ -617,24 +644,31 @@ static inline void tlb_end_ptes(struct mmu_gather *tlb)
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))
 		return;
 
+#ifdef CONFIG_PER_TABLE_DEFERRED_FLUSHES
+	if (tlb->last_pte)
+		track_defer_tlb_flush(tlb, pte_to_page(tlb->last_pte));
+#elif CONFIG_ARCH_HAS_TLB_GENERATIONS /* && !CONFIG_PER_TABLE_DEFERRED_FLUSHES */
 	if (tlb->cleared_ptes_in_table)
-		track_defer_tlb_flush(tlb);
-
+		track_defer_tlb_flush(tlb, NULL);
 	tlb->cleared_ptes_in_table = 0;
+#endif /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
 }
 
 /*
  * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
  * and set corresponding cleared_*.
  */
-static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
+static inline void tlb_flush_pte_range(struct mmu_gather *tlb, pte_t *pte,
 				     unsigned long address, unsigned long size)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_ptes = 1;
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))
+	if (IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS) &&
+	    !IS_ENABLED(CONFIG_PER_TABLE_DEFERRED_FLUSHES))
 		tlb->cleared_ptes_in_table = 1;
+
+	tlb_set_last_pte(tlb, pte);
 }
 
 static inline void __tlb_flush_pmd_range(struct mmu_gather *tlb,
@@ -644,11 +678,11 @@ static inline void __tlb_flush_pmd_range(struct mmu_gather *tlb,
 	tlb->cleared_pmds = 1;
 }
 
-static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb, pmd_t *pmd,
 				     unsigned long address, unsigned long size)
 {
 	__tlb_flush_pmd_range(tlb, address, size);
-	track_defer_tlb_flush(tlb);
+	track_defer_tlb_flush(tlb, pmd_to_page(pmd));
 }
 
 static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
@@ -678,7 +712,8 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
  */
 #define tlb_remove_tlb_entry(tlb, ptep, address)		\
 	do {							\
-		tlb_flush_pte_range(tlb, address, PAGE_SIZE);	\
+		tlb_flush_pte_range(tlb, ptep, address,		\
+				    PAGE_SIZE);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
@@ -686,7 +721,8 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 	do {							\
 		unsigned long _sz = huge_page_size(h);		\
 		if (_sz == PMD_SIZE)				\
-			tlb_flush_pmd_range(tlb, address, _sz);	\
+			tlb_flush_pmd_range(tlb, (pmd_t *)ptep,	\
+					    address, _sz);	\
 		else if (_sz == PUD_SIZE)			\
 			tlb_flush_pud_range(tlb, address, _sz);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
@@ -702,7 +738,8 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 
 #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)			\
 	do {								\
-		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE);	\
+		tlb_flush_pmd_range(tlb, pmdp, address,			\
+				    HPAGE_PMD_SIZE);			\
 		__tlb_remove_pmd_tlb_entry(tlb, pmdp, address);		\
 	} while (0)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d78a79fbb012..a8a5bf82bd03 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2208,11 +2208,21 @@ static inline void pgtable_init(void)
 	pgtable_cache_init();
 }
 
+#ifdef CONFIG_PER_TABLE_DEFERRED_FLUSHES
+static inline void page_table_tlb_gen_init(struct page *page)
+{
+	page->deferred_tlb_gen = 0;
+}
+#else /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
+static inline void page_table_tlb_gen_init(struct page *page) { }
+#endif /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
+
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+	page_table_tlb_gen_init(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -2221,6 +2231,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
 	__ClearPageTable(page);
+	page_table_tlb_gen_init(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
@@ -2308,6 +2319,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+	page_table_tlb_gen_init(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -2316,6 +2328,7 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
 	__ClearPageTable(page);
+	page_table_tlb_gen_init(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bbe5d4a422f7..cae9e8bbf8e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -148,6 +148,9 @@ struct page {
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
+#ifdef CONFIG_PER_TABLE_DEFERRED_FLUSHES
+				u64 deferred_tlb_gen; /* x86 non-pgd protected by page->ptl */
+#endif
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
 			};
@@ -632,6 +635,7 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+#ifndef CONFIG_PER_TABLE_DEFERRED_FLUSHES
 static inline bool pte_tlb_flush_pending(struct vm_area_struct *vma, pte_t *pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -645,6 +649,24 @@ static inline bool pmd_tlb_flush_pending(struct vm_area_struct *vma, pmd_t *pmd)
 
 	return atomic64_read(&vma->defer_tlb_gen) < atomic64_read(&mm->tlb_gen_completed);
 }
+#else /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
+#define pte_tlb_flush_pending(vma, pte)					\
+	({								\
+		struct mm_struct *mm = (vma)->vm_mm;			\
+									\
+		(pte_to_page(pte))->deferred_tlb_gen <			\
+			atomic64_read(&mm->tlb_gen_completed);		\
+	 })
+
+#define pmd_tlb_flush_pending(vma, pmd)					\
+	({								\
+		struct mm_struct *mm = (vma)->vm_mm;			\
+									\
+		(pmd_to_page(pmd))->deferred_tlb_gen <			\
+			atomic64_read(&mm->tlb_gen_completed);		\
+	 })
+
+#endif /* CONFIG_PER_TABLE_DEFERRED_FLUSHES */
 #else /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
 static inline bool pte_tlb_flush_pending(struct vm_area_struct *vma, pte_t *pte)
 {
diff --git a/init/Kconfig b/init/Kconfig
index 14a599a48738..e0d8a9ea7dd0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -857,6 +857,13 @@ config ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING
 	bool
 	depends on !CONFIG_MMU_GATHER_NO_GATHER
 
+#
+# For architectures that prefer to save deferred TLB generations in the
+# page-table instead of the VMA.
+config PER_TABLE_DEFERRED_FLUSHES
+	bool
+	depends on ARCH_HAS_TLB_GENERATIONS && 64BIT
+
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c4b7c00cc69c..8f6c0e1a7ff7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1886,7 +1886,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		entry = pmd_clear_uffd_wp(entry);
 	}
 	ret = HPAGE_PMD_NR;
-	tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
+	tlb_flush_pmd_range(tlb, pmd, addr, HPAGE_PMD_SIZE);
 	set_pmd_at(mm, addr, pmd, entry);
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 063419ade304..923b8c0ec837 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -48,7 +48,7 @@ static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
 		wpwalk->total++;
 
 		if (pte_may_need_flush(old_pte, ptent))
-			tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
+			tlb_flush_pte_range(&wpwalk->tlb, pte, addr, PAGE_SIZE);
 		tlb_end_ptes(&wpwalk->tlb);
 	}
 
@@ -110,7 +110,7 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
 
 		wpwalk->total++;
-		tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
+		tlb_flush_pte_range(&wpwalk->tlb, pte, addr, PAGE_SIZE);
 		tlb_end_ptes(&wpwalk->tlb);
 
 		__set_bit(pgoff, cwalk->bitmap);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1258bbe42ee1..c3aa3030f4d9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -140,7 +140,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_may_need_flush(oldpte, ptent))
-				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
+				tlb_flush_pte_range(tlb, pte, addr, PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
-- 
2.25.1

