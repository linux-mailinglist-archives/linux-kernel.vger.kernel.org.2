Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA630995F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhAaAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhAaAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70801C061788
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g15so8808366pjd.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hJDN7XNNHxUFXr1gFcDueyT3gu6sc9b9CRfP4LC3cA=;
        b=ow69JJyNSdpulLwcbA6pnNqB05DyszuF2ILeMYJoZ6kDSZtOizqFoSJ1Z52b6kdZb7
         iuNX06K/eXkJbnx5csSDBXdK9HkxDbJo8Ava29VfhIFughtSLCG5U/4jfKVwNMZK4Qnz
         QAgmJmIAdovQ9wmmPTmDG+K+PQAeRRwMj3TlxsD4cJs+rV10LUS/hs4eX5ru/olAgwoj
         H8jFXUdh23m1f+P1x9Mwu/qNgyqPDFk2kv+RUcdA3dMY4O95QhK2gqyywq/2DEg/4yUd
         jr5wEfSe8v9lPkDxrH+ARJsEpIoxXfbIiA24RUPH8etmRUDcE7PjB6fKzrXS+o9OOPLw
         eKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hJDN7XNNHxUFXr1gFcDueyT3gu6sc9b9CRfP4LC3cA=;
        b=ToAabZiWErdKrQKlAbzKaqpc/rvHXiKvB5/5gFi/s31MSrN8a2B1pwLD0sMPCHi41G
         +fDL9RCkHaXNYcNNvKsD6RzScqzEr5aQjGLbNDf/fWk3nGLy9pu12wpmoJrZiu+fS5pR
         4bUnaCpgE3IyC4tTl8TviEh1p5xQA4h1LFNrzbRpmDu3wGjwG1KLNFm/A2wJZMWnsPhM
         +Kwxa+PoXrRKTEUqeEcnh2vsOoTW2E3hZcMg1tYs8u/InvNW5WB4aAaaozsRnwZIkob6
         2jUUIDN6N+SOpcvTMatKiNvPwOD3HEtuLkmta/xt041sulMreL1PxxyAlekpWXU/qLx5
         7p3A==
X-Gm-Message-State: AOAM533kjOXFY8KbRYAedoF+pK9z/8lprFogTzw1XlYG8dSS9DCefanT
        tCBjTZ/E9TMmAfjX7MVGdYs=
X-Google-Smtp-Source: ABdhPJy72eR2ZRDjCZKm4iC26xiBMDQwui2uZKhjvbwqocRCErn3L6mMegNacR+p6TAjZbEgqfwanw==
X-Received: by 2002:a17:902:9306:b029:df:fb48:8c43 with SMTP id bc6-20020a1709029306b02900dffb488c43mr11826131plb.77.1612052171913;
        Sat, 30 Jan 2021 16:16:11 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:11 -0800 (PST)
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
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 07/20] mm: move x86 tlb_gen to generic code
Date:   Sat, 30 Jan 2021 16:11:19 -0800
Message-Id: <20210131001132.3368247-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

x86 currently has a TLB-generation tracking logic that can be used by
additional architectures (as long as they implement some additional
logic).

Extract the relevant pieces of code from x86 to general TLB code. This
would be useful to allow to write the next "fine granularity deferred
TLB flushes detection" patches without making them x86-specific.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/mmu.h         | 10 --------
 arch/x86/include/asm/mmu_context.h |  1 -
 arch/x86/include/asm/tlbflush.h    | 18 --------------
 arch/x86/mm/tlb.c                  |  8 +++---
 drivers/firmware/efi/efi.c         |  1 +
 include/linux/mm_types.h           | 39 ++++++++++++++++++++++++++++++
 init/Kconfig                       |  6 +++++
 kernel/fork.c                      |  2 ++
 mm/init-mm.c                       |  1 +
 mm/rmap.c                          |  9 ++++++-
 11 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 591efb2476bc..6bd4d626a6b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -86,6 +86,7 @@ config X86
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_TLB_GENERATIONS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..134454956c96 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -23,16 +23,6 @@ typedef struct {
 	 */
 	u64 ctx_id;
 
-	/*
-	 * Any code that needs to do any sort of TLB flushing for this
-	 * mm will first make its changes to the page tables, then
-	 * increment tlb_gen, then flush.  This lets the low-level
-	 * flushing code keep track of what needs flushing.
-	 *
-	 * This is not used on Xen PV.
-	 */
-	atomic64_t tlb_gen;
-
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..e7597c642270 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -105,7 +105,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	mutex_init(&mm->context.lock);
 
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
-	atomic64_set(&mm->context.tlb_gen, 0);
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a617dc0a9b06..2110b98026a7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -235,24 +235,6 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
-{
-	/*
-	 * Bump the generation count.  This also serves as a full barrier
-	 * that synchronizes with switch_mm(): callers are required to order
-	 * their read of mm_cpumask after their writes to the paging
-	 * structures.
-	 */
-	return atomic64_inc_return(&mm->context.tlb_gen);
-}
-
-static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
-					struct mm_struct *mm)
-{
-	inc_mm_tlb_gen(mm);
-	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
-}
-
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d57f55..7ab21430be41 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -511,7 +511,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * the TLB shootdown code.
 		 */
 		smp_mb();
-		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+		next_tlb_gen = atomic64_read(&next->tlb_gen);
 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
 				next_tlb_gen)
 			return;
@@ -546,7 +546,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
-		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+		next_tlb_gen = atomic64_read(&next->tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
@@ -618,7 +618,7 @@ void initialize_tlbstate_and_flush(void)
 {
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	u64 tlb_gen = atomic64_read(&init_mm.tlb_gen);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -667,7 +667,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 */
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
+	u64 mm_tlb_gen = atomic64_read(&loaded_mm->tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
 
 	/* This code cannot presently handle being reentered. */
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index df3f9bcab581..02a6a1c81576 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -62,6 +62,7 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+	INIT_TLB_GENERATIONS
 };
 
 struct workqueue_struct *efi_rts_wq;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0974ad501a47..2035ac319c2b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -560,6 +560,17 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
+#endif
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+		/*
+		 * Any code that needs to do any sort of TLB flushing for this
+		 * mm will first make its changes to the page tables, then
+		 * increment tlb_gen, then flush.  This lets the low-level
+		 * flushing code keep track of what needs flushing.
+		 *
+		 * This is not used on Xen PV.
+		 */
+		atomic64_t tlb_gen;
 #endif
 	} __randomize_layout;
 
@@ -676,6 +687,34 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+static inline void init_mm_tlb_gen(struct mm_struct *mm)
+{
+	atomic64_set(&mm->tlb_gen, 0);
+}
+
+static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
+{
+	/*
+	 * Bump the generation count.  This also serves as a full barrier
+	 * that synchronizes with switch_mm(): callers are required to order
+	 * their read of mm_cpumask after their writes to the paging
+	 * structures.
+	 */
+	return atomic64_inc_return(&mm->tlb_gen);
+}
+
+#define INIT_TLB_GENERATIONS					\
+	.tlb_gen	= ATOMIC64_INIT(0),
+
+#else
+
+static inline void init_mm_tlb_gen(struct mm_struct *mm) { }
+
+#define INIT_TLB_GENERATION
+
+#endif
+
 struct vm_fault;
 
 /**
diff --git a/init/Kconfig b/init/Kconfig
index b77c60f8b963..3d11a0f7c8cc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -842,6 +842,12 @@ config ARCH_SUPPORTS_NUMA_BALANCING
 # and the refill costs are offset by the savings of sending fewer IPIs.
 config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	bool
+	depends on ARCH_HAS_TLB_GENERATIONS
+
+#
+# For architectures that track for each address space the TLB generation.
+config ARCH_HAS_TLB_GENERATIONS
+	bool
 
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..3e735a86ab2c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1027,6 +1027,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
+	init_mm_tlb_gen(mm);
+
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
 #endif
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 153162669f80..ef3a471f4de4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -38,5 +38,6 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
+	INIT_TLB_GENERATIONS
 	INIT_MM_CONTEXT(init_mm)
 };
diff --git a/mm/rmap.c b/mm/rmap.c
index 08c56aaf72eb..9655e1fc328a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -613,11 +613,18 @@ void try_to_unmap_flush_dirty(void)
 		try_to_unmap_flush();
 }
 
+static inline void tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
+				   struct mm_struct *mm)
+{
+	inc_mm_tlb_gen(mm);
+	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+}
+
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 
-	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
+	tlbbatch_add_mm(&tlb_ubc->arch, mm);
 	tlb_ubc->flush_required = true;
 
 	/*
-- 
2.25.1

