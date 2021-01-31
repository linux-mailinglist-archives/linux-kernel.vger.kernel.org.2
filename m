Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327C309967
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhAaAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhAaARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:01 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC2C0617A9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q20so9069800pfu.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0sNt0ybEAJJITGt3SZGOCmrQucNsG5Zn6uxnJSWEHU=;
        b=mGqXv/v3S2PT1kY3WmXQuXGhWNvnf3TFomZSCuxt1lRwxzy077QI4egWiVOxjrT4Ps
         WdBCHWZ9bM30L+PnMBFQYR5QoPUCONXwjHTb2CDztTXX0+Y/RsYWFOCAgJny0OVKA0dX
         urxWPZ18rfSnLOWT7SNjyGpNrbjABnWpvnaCkip4YW9JEZq9xoazTN5jOWU/yhyXXh0O
         ttiWKtPXS0Xf7UzsCDAJtZ7STa/yKkDu5EslnM+ftx0oR1V/jKH82cGUXaqyfGQmYWDD
         Z0N6Tkq2NOap6GymQUn4b7abeYc4N8WuMremtfN9pDd4PvmWnva8N+AbeWAlPjpEj52G
         M+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0sNt0ybEAJJITGt3SZGOCmrQucNsG5Zn6uxnJSWEHU=;
        b=GuMG/AWIsc/O1s+cQGdujGtDqavnXUs387LIq2RN+gTh3xS2O6XIL5KWrmO2qDPNZ3
         DLnWWQsT8CRTiR7RTCnE7ARLtVWmRmi3zAx17uLVdA/nNX3QdAVjbM5Ua8DRXmQvT35G
         Ci69i1HByI9OIhJdv1o7fnZYJ/dnAElKM3g14bnDWhGzToMbk69I2hlm/Z6UTRK4gJ1s
         xQ1almV61e4p2/Cu/yWTgcgYnlDvs+6nTYgSgFY5jwUvUGLYBo7CfVzS3VQtxeUx6hiM
         5cPomptBUHHBIhG14SFFiKTQ2xdzq2F5sZduM4VG9m0W6Am695ysXz8Fi9UE+VvHayEo
         ZbRg==
X-Gm-Message-State: AOAM5326pNnyfHjKN96zCvPRHZoHcK1iuUZ8DZeteFBUYuy45VBSH+hH
        c6J+bCmsVVm8J1suCgAadTg=
X-Google-Smtp-Source: ABdhPJwNe3mKTlXo7k7U2SgPj7FsSjQAw80hIuT+kdV7YK4IsAvj/+Q83sl9GE2LG7Qvy2myneRi7g==
X-Received: by 2002:a62:1690:0:b029:1c6:fdac:3438 with SMTP id 138-20020a6216900000b02901c6fdac3438mr10186735pfw.43.1612052184960;
        Sat, 30 Jan 2021 16:16:24 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:24 -0800 (PST)
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
Subject: [RFC 15/20] mm: detect deferred TLB flushes in vma granularity
Date:   Sat, 30 Jan 2021 16:11:27 -0800
Message-Id: <20210131001132.3368247-16-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, deferred TLB flushes are detected in the mm granularity: if
there is any deferred TLB flush in the entire address space due to NUMA
migration, pte_accessible() in x86 would return true, and
ptep_clear_flush() would require a TLB flush. This would happen even if
the PTE resides in a completely different vma.

Recent code changes and possible future enhancements might require to
detect TLB flushes in finer granularity. Detection in finer granularity
can also enable more aggressive TLB deferring in the future.

Record for each vma the last mm's TLB generation after the last deferred
PTE/PMD change while the page-table lock is still held. Increase the mm
generation before recording to indicate that a pending TLB flush is
pending. Record in the mmu_gather struct the mm's TLB generation at the
time in which the last TLB flushing was deferred.

Once the TLB flushing of deferred request takes place, use the deferred
TLB generation that is recorded in mmu_gather. Detection of deferred TLB
flushes is performed by checking whether the mm's completed TLB
generation is the lower/equal than the mm's TLB generation.
Architectures that use the TLB generation logic are required to perform
a full TLB flush if they detect that a new TLB flush request "skips" a
generation (as already done by x86 code).

To indicate that a deferred TLB flush takes place, increase the mm's TLB
generation after updating the PTEs. However, try to avoid increasing the
mm's generation after subsequent PTE updates, as increasing it again
would lead to a full TLB flush once the deferred TLB flushes are
performed (due to the "skipped" TLB generation). Therefore, if the mm
generation did not change after subsequent PTE update, use the previous
generation.

As multiple updates of the vma generation can be performed concurrently,
use atomic operations to ensure that the TLB generation as recorded in
the vma is the last (most recent) one.

Once a deferred TLB flush is eventually performed it might be redundant,
if due to another TLB flush the deferred flush was performed (by doing a
full TLB flush once detecting the "skipped" generation).  This case can
be detected if the deferred TLB generation, as recorded in mmu_gather
was already completed. However, we do not record deferred PUD/P4D
flushes, and freeing tables also requires a flush on cores in lazy
TLB mode. In such cases a TLB flush is needed even if the mm's completed
TLB generation indicates the flush was already "performed".

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
 arch/x86/include/asm/tlb.h      |  18 ++++--
 arch/x86/include/asm/tlbflush.h |   5 ++
 arch/x86/mm/tlb.c               |  14 ++++-
 include/asm-generic/tlb.h       | 104 ++++++++++++++++++++++++++++++--
 include/linux/mm_types.h        |  19 ++++++
 mm/mmap.c                       |   1 +
 mm/mmu_gather.c                 |   3 +
 7 files changed, 150 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257..ecf538e6c6d5 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -9,15 +9,23 @@ static inline void tlb_flush(struct mmu_gather *tlb);
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
 	unsigned int stride_shift = tlb_get_unmap_shift(tlb);
 
-	if (!tlb->fullmm && !tlb->need_flush_all) {
-		start = tlb->start;
-		end = tlb->end;
+	/* Perform full flush when needed */
+	if (tlb->fullmm || tlb->need_flush_all) {
+		flush_tlb_mm_range(tlb->mm, 0, TLB_FLUSH_ALL, stride_shift,
+				   tlb->freed_tables);
+		return;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	/* Check if flush was already performed */
+	if (!tlb->freed_tables && !tlb->cleared_puds &&
+	    !tlb->cleared_p4ds &&
+	    atomic64_read(&tlb->mm->tlb_gen_completed) > tlb->defer_gen)
+		return;
+
+	flush_tlb_mm_range_gen(tlb->mm, tlb->start, tlb->end, stride_shift,
+			       tlb->freed_tables, tlb->defer_gen);
 }
 
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 2110b98026a7..296a00545056 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -225,6 +225,11 @@ void flush_tlb_others(const struct cpumask *cpumask,
 				: PAGE_SHIFT, false)
 
 extern void flush_tlb_all(void);
+
+extern void flush_tlb_mm_range_gen(struct mm_struct *mm, unsigned long start,
+				unsigned long end, unsigned int stride_shift,
+				bool freed_tables, u64 gen);
+
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d17b5575531e..48f4b56fc4a7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -883,12 +883,11 @@ static inline void put_flush_tlb_info(void)
 #endif
 }
 
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
+void flush_tlb_mm_range_gen(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables)
+				bool freed_tables, u64 new_tlb_gen)
 {
 	struct flush_tlb_info *info;
-	u64 new_tlb_gen;
 	int cpu;
 
 	cpu = get_cpu();
@@ -923,6 +922,15 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	put_cpu();
 }
 
+void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
+				unsigned long end, unsigned int stride_shift,
+				bool freed_tables)
+{
+	u64 new_tlb_gen = inc_mm_tlb_gen(mm);
+
+	flush_tlb_mm_range_gen(mm, start, end, stride_shift, freed_tables,
+			       new_tlb_gen);
+}
 
 static void do_flush_tlb_all(void *info)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 10690763090a..f25d2d955076 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -295,6 +295,11 @@ struct mmu_gather {
 	unsigned int		cleared_puds : 1;
 	unsigned int		cleared_p4ds : 1;
 
+	/*
+	 * Whether a TLB flush was needed for PTEs in the current table
+	 */
+	unsigned int		cleared_ptes_in_table : 1;
+
 	unsigned int		batch_count;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -305,6 +310,10 @@ struct mmu_gather {
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
+
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+	u64			defer_gen;
+#endif
 #endif
 };
 
@@ -381,7 +390,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 #endif
 
 #if __is_defined(tlb_flush) ||						\
-	IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING)
+	IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING) ||	\
+	IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS)
 
 static inline void
 tlb_update_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
@@ -472,7 +482,8 @@ static inline unsigned long tlb_get_unmap_size(struct mmu_gather *tlb)
  */
 static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (tlb->fullmm)
+	if (IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING) &&
+		       tlb->fullmm)
 		return;
 
 	tlb_update_vma(tlb, vma);
@@ -530,16 +541,87 @@ static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
 	tlb_update_generation(&mm->tlb_gen_completed, gen);
 }
 
-#endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
+static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
+{
+	struct mm_struct *mm = tlb->mm;
+	u64 mm_gen;
+
+	/*
+	 * Any change of PTE before calling __track_deferred_tlb_flush() must be
+	 * performed using RMW atomic operation that provides a memory barriers,
+	 * such as ptep_modify_prot_start().  The barrier ensure the PTEs are
+	 * written before the current generation is read, synchronizing
+	 * (implicitly) with flush_tlb_mm_range().
+	 */
+	smp_mb__after_atomic();
+
+	mm_gen = atomic64_read(&mm->tlb_gen);
+
+	/*
+	 * This condition checks for both first deferred TLB flush and for other
+	 * TLB pending or executed TLB flushes after the last table that we
+	 * updated. In the latter case, we are going to skip a generation, which
+	 * would lead to a full TLB flush. This should therefore not cause
+	 * correctness issues, and should not induce overheads, since anyhow in
+	 * TLB storms it is better to perform full TLB flush.
+	 */
+	if (mm_gen != tlb->defer_gen) {
+		VM_BUG_ON(mm_gen < tlb->defer_gen);
+
+		tlb->defer_gen = inc_mm_tlb_gen(mm);
+	}
+}
+
+/*
+ * Store the deferred TLB generation in the VMA
+ */
+static inline void store_deferred_tlb_gen(struct mmu_gather *tlb)
+{
+	tlb_update_generation(&tlb->vma->defer_tlb_gen, tlb->defer_gen);
+}
+
+/*
+ * Track deferred TLB flushes for PTEs and PMDs to allow fine granularity checks
+ * whether a PTE is accessible. The TLB generation after the PTE is flushed is
+ * saved in the mmu_gather struct. Once a flush is performed, the geneartion is
+ * advanced.
+ */
+static inline void track_defer_tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm)
+		return;
+
+	BUG_ON(!tlb->vma);
+
+	read_defer_tlb_flush_gen(tlb);
+	store_deferred_tlb_gen(tlb);
+}
+
+#define init_vma_tlb_generation(vma)				\
+	atomic64_set(&(vma)->defer_tlb_gen, 0)
+#else
+static inline void init_vma_tlb_generation(struct vm_area_struct *vma) { }
+#endif
 
 #define tlb_start_ptes(tlb)						\
 	do {								\
 		struct mmu_gather *_tlb = (tlb);			\
 									\
 		flush_tlb_batched_pending(_tlb->mm);			\
+		if (IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))	\
+			_tlb->cleared_ptes_in_table = 0;		\
 	} while (0)
 
-static inline void tlb_end_ptes(struct mmu_gather *tlb) { }
+static inline void tlb_end_ptes(struct mmu_gather *tlb)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))
+		return;
+
+	if (tlb->cleared_ptes_in_table)
+		track_defer_tlb_flush(tlb);
+
+	tlb->cleared_ptes_in_table = 0;
+}
 
 /*
  * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
@@ -550,15 +632,25 @@ static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_ptes = 1;
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_TLB_GENERATIONS))
+		tlb->cleared_ptes_in_table = 1;
 }
 
-static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+static inline void __tlb_flush_pmd_range(struct mmu_gather *tlb,
 				     unsigned long address, unsigned long size)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_pmds = 1;
 }
 
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_flush_pmd_range(tlb, address, size);
+	track_defer_tlb_flush(tlb);
+}
+
 static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
 				     unsigned long address, unsigned long size)
 {
@@ -649,7 +741,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 #ifndef pte_free_tlb
 #define pte_free_tlb(tlb, ptep, address)			\
 	do {							\
-		tlb_flush_pmd_range(tlb, address, PAGE_SIZE);	\
+		__tlb_flush_pmd_range(tlb, address, PAGE_SIZE);	\
 		tlb->freed_tables = 1;				\
 		__pte_free_tlb(tlb, ptep, address);		\
 	} while (0)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 676795dfd5d4..bbe5d4a422f7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -367,6 +367,9 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+	atomic64_t defer_tlb_gen;	/* Deferred TLB flushes generation */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
@@ -628,6 +631,21 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending);
 }
 
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+static inline bool pte_tlb_flush_pending(struct vm_area_struct *vma, pte_t *pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	return atomic64_read(&vma->defer_tlb_gen) < atomic64_read(&mm->tlb_gen_completed);
+}
+
+static inline bool pmd_tlb_flush_pending(struct vm_area_struct *vma, pmd_t *pmd)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	return atomic64_read(&vma->defer_tlb_gen) < atomic64_read(&mm->tlb_gen_completed);
+}
+#else /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
 static inline bool pte_tlb_flush_pending(struct vm_area_struct *vma, pte_t *pte)
 {
 	return mm_tlb_flush_pending(vma->vm_mm);
@@ -637,6 +655,7 @@ static inline bool pmd_tlb_flush_pending(struct vm_area_struct *vma, pmd_t *pmd)
 {
 	return mm_tlb_flush_pending(vma->vm_mm);
 }
+#endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
 
 static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 90673febce6a..a81ef902e296 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3337,6 +3337,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
+		init_vma_tlb_generation(new_vma);
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks = false;
 	}
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 13338c096cc6..0d554f2f92ac 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -329,6 +329,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 #endif
 
 	tlb_table_init(tlb);
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+	tlb->defer_gen = 0;
+#endif
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
-- 
2.25.1

