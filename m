Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF83115D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhBEWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:43:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:12586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhBEOwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:12 -0500
IronPort-SDR: SlTT75xB9TQh8S+WOSZVIa/4sSRpq3bE4bSJAlc3z1/hGB6uw3/fmWs/T2AjfUSI2Nq7yDvID4
 3z2FJZqXC54g==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168561535"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168561535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:49 -0800
IronPort-SDR: jxsvMVOLx5wq57Ew8CjFFdQJqSMhMQeC21PrI2thQhQn1mrhPySf87/o9vmV7xoobkxSmiJZJk
 mqWT3OG4EOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="357732305"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2021 07:16:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D81F62BD; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 4/9] x86/mm: Introduce TIF_LAM_U57 and TIF_LAM_U48
Date:   Fri,  5 Feb 2021 18:16:25 +0300
Message-Id: <20210205151631.43511-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new thread flags indicate that the thread has Linear Address Masking
enabled.

switch_mm_irqs_off() now respects these flags and set CR3 accordingly.

The active LAM mode gets recorded in the tlb_state.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/thread_info.h |  9 ++-
 arch/x86/include/asm/tlbflush.h    |  5 ++
 arch/x86/mm/tlb.c                  | 96 +++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 44733a4bfc42..e2ae8fcb3492 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
+#define TIF_X32			19	/* 32-bit native x86-64 binary */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -101,7 +102,9 @@ struct thread_info {
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
+#define TIF_LAM_U57		30	/* LAM for userspace pointers, 6 bits */
+#define TIF_LAM_U48		31	/* LAM for userspace pointers, 15 bits */
+
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -122,6 +125,7 @@ struct thread_info {
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
+#define _TIF_X32		(1 << TIF_X32)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
@@ -129,7 +133,8 @@ struct thread_info {
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
+#define _TIF_LAM_U57		(1 << TIF_LAM_U57)
+#define _TIF_LAM_U48		(1 << TIF_LAM_U48)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..7e124fd71a67 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -17,6 +17,10 @@ void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
 
+#define LAM_NONE	0
+#define LAM_U57		1
+#define LAM_U48		2
+
 void cr4_update_irqsoff(unsigned long set, unsigned long clear);
 unsigned long cr4_read_shadow(void);
 
@@ -88,6 +92,7 @@ struct tlb_state {
 
 	u16 loaded_mm_asid;
 	u16 next_asid;
+	u8 lam;
 
 	/*
 	 * We can be in one of several states:
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d57f55..138d4748aa97 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -145,17 +145,73 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+#ifdef CONFIG_X86_64
+static inline unsigned long lam_to_cr3(u8 lam)
+{
+	switch (lam) {
+	case LAM_NONE:
+		return 0;
+	case LAM_U57:
+		return X86_CR3_LAM_U57;
+	case LAM_U48:
+		return X86_CR3_LAM_U48;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static inline u8 cr3_to_lam(unsigned long cr3)
+{
+	if (cr3 & X86_CR3_LAM_U57)
+		return LAM_U57;
+	if (cr3 & X86_CR3_LAM_U48)
+		return LAM_U48;
+	return 0;
+}
+
+static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+	if (!tsk)
+		return LAM_NONE;
+
+	if (test_ti_thread_flag(ti, TIF_LAM_U57))
+		return LAM_U57;
+	if (test_ti_thread_flag(ti, TIF_LAM_U48))
+		return LAM_U48;
+	return LAM_NONE;
+}
+
+#else
+
+static inline unsigned long lam_to_cr3(u8 lam)
+{
+	return 0;
+}
+
+static inline u8 cr3_to_lam(unsigned long cr3)
+{
+	return LAM_NONE;
+}
+
+static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
+{
+	return LAM_NONE;
+}
+#endif
+
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, u8 lam)
 {
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
+		return __sme_pa(pgd) | kern_pcid(asid) | lam_to_cr3(lam);
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
+		return __sme_pa(pgd) | lam_to_cr3(lam);
 	}
 }
 
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid, u8 lam)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 	/*
@@ -164,7 +220,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 	 * boot because all CPU's the have same capabilities:
 	 */
 	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH | lam_to_cr3(lam);
 }
 
 /*
@@ -265,15 +321,15 @@ static inline void invalidate_user_asid(u16 asid)
 		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
 }
 
-static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
+static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, u8 lam, bool need_flush)
 {
 	unsigned long new_mm_cr3;
 
 	if (need_flush) {
 		invalidate_user_asid(new_asid);
-		new_mm_cr3 = build_cr3(pgdir, new_asid);
+		new_mm_cr3 = build_cr3(pgdir, new_asid, lam);
 	} else {
-		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid);
+		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid, lam);
 	}
 
 	/*
@@ -424,6 +480,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u8 prev_lam = this_cpu_read(cpu_tlbstate.lam);
+	u8 new_lam = gen_lam(tsk, next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
@@ -437,6 +495,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * cpu_tlbstate.loaded_mm) matches next.
 	 *
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
+	 *
+	 * NB: Initial LAM enabling calls us with prev == next. We must update
+	 * CR3 if prev_lam doesn't match the new one.
 	 */
 
 	/* We don't want flush_tlb_func_* to run concurrently with us. */
@@ -453,7 +514,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
+	if (WARN_ON_ONCE(__read_cr3() !=
+			 build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -483,7 +545,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * provides that full memory barrier and core serializing
 	 * instruction.
 	 */
-	if (real_prev == next) {
+	if (real_prev == next && prev_lam == new_lam) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
@@ -555,15 +617,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	this_cpu_write(cpu_tlbstate.lam, new_lam);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-		load_new_mm_cr3(next->pgd, new_asid, true);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
-		load_new_mm_cr3(next->pgd, new_asid, false);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
@@ -620,6 +683,7 @@ void initialize_tlbstate_and_flush(void)
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
 	unsigned long cr3 = __read_cr3();
+	u8 lam = cr3_to_lam(cr3);
 
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
@@ -633,7 +697,7 @@ void initialize_tlbstate_and_flush(void)
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
 	/* Force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0));
+	write_cr3(build_cr3(mm->pgd, 0, lam));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
@@ -970,8 +1034,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  */
 unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	unsigned long cr3 =
+		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+		this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+		this_cpu_read(cpu_tlbstate.lam));
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
-- 
2.26.2

