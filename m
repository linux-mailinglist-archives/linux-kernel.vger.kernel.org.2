Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE1309961
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhAaAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhAaARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991CFC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 8so2586909plc.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTdsuJQth2J6WGuWWZ2jdlnmzFKq4d9KvvhYC+YtYPM=;
        b=kQA8w6RBjWwklh54JZyl96kDKOlZPvVrUhbxGdhR4VwqYSyrGHXNPzm/7T3cNlhk+9
         Jt/AvSljO4Qqx7b7YU7hxsVKNvzENWz4PlbqvlqI+E9TprAVSCOcZyHWlqBIA/+uqfSQ
         H/S8DpVZPw3N8xREtnXd5OXhbe3kkWh8ll+f58bkGpfUo1Zbv5s274x2Gi4ID+RKAp4R
         dsjseZNxDFRCwZJpWykiRQBVCNOwCJE7jXQtt0juVEt2J0aHZazhW3DRmn9E+N7OgeSe
         eB/l7QMfwLa04lCx1txffJBhV+2JqFsbkWOClh9AaUL623Seyvv9XMyzl2+mj2y0DFjj
         saXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTdsuJQth2J6WGuWWZ2jdlnmzFKq4d9KvvhYC+YtYPM=;
        b=ufFxmSA6BFiWnLeWR/itok68P4lCcFNb7RsE3S6mxLpn9ahrbnP2l/Um348gfdkp8x
         X/Ev+Pbx1xrOS1vL+f9i8s6y+0EmZS4TEIm5hWGZ6mmITG6k/9ICyHUxz0FidAQx+X5i
         xIKy1ib2q/xadK56NbE29FPtyCD5qGuKkhKYl/XsCcrks9fjpZwjuuh4GKD2SOcjpKZ5
         2kzKxB0jwsdiOav/AqLn7r8deA2WY4vXbk09vHu3TP/syvRvMXr3pA0dhqCAWvcdEGyb
         WJ8bj8aKAKiryi/pjk3+u+XrdL9qbkavXMGw9zDSwwpTNIFqd72o6ltsrkhk67lEDKWB
         KQZQ==
X-Gm-Message-State: AOAM530THGN5zAV2krk428yHQjwc78oB3wGPuRT3AxBs5ZnApw0iakl7
        VWhBL7z5d65PUvYaXlbOvqM=
X-Google-Smtp-Source: ABdhPJxc1EgCFTX8mBi+r3yG2hwnghqgny3SVhg+g/XVGDEfxMAToxY0ux9sP9kqY7dHWCPL7E5z2w==
X-Received: by 2002:a17:90a:8c87:: with SMTP id b7mr11168725pjo.158.1612052193016;
        Sat, 30 Jan 2021 16:16:33 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:32 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: [RFC 20/20] mm/rmap: avoid potential races
Date:   Sat, 30 Jan 2021 16:11:32 -0800
Message-Id: <20210131001132.3368247-21-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

flush_tlb_batched_pending() appears to have a theoretical race:
tlb_flush_batched is being cleared after the TLB flush, and if in
between another core calls set_tlb_ubc_flush_pending() and sets the
pending TLB flush indication, this indication might be lost. Holding the
page-table lock when SPLIT_LOCK is set cannot eliminate this race.

The current batched TLB invalidation scheme therefore does not seem
viable or easily repairable.

Introduce a new scheme, in which a cpumask is maintained for pending
batched TLB flushes. When a full TLB flush is performed clear the
corresponding bit on the CPU the performs the TLB flush.

This scheme is only suitable for architectures that use IPIs for TLB
shootdowns. As x86 is the only architecture that currently uses batched
TLB flushes, this is not an issue.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
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
 arch/x86/include/asm/tlbbatch.h | 15 ------------
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 18 ++++++++++-----
 include/linux/mm.h              |  7 ++++++
 include/linux/mm_types_task.h   | 13 -----------
 mm/rmap.c                       | 41 ++++++++++++++++-----------------
 6 files changed, 40 insertions(+), 56 deletions(-)
 delete mode 100644 arch/x86/include/asm/tlbbatch.h

diff --git a/arch/x86/include/asm/tlbbatch.h b/arch/x86/include/asm/tlbbatch.h
deleted file mode 100644
index 1ad56eb3e8a8..000000000000
--- a/arch/x86/include/asm/tlbbatch.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ARCH_X86_TLBBATCH_H
-#define _ARCH_X86_TLBBATCH_H
-
-#include <linux/cpumask.h>
-
-struct arch_tlbflush_unmap_batch {
-	/*
-	 * Each bit set is a CPU that potentially has a TLB entry for one of
-	 * the PFNs being flushed..
-	 */
-	struct cpumask cpumask;
-};
-
-#endif /* _ARCH_X86_TLBBATCH_H */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a4e7c90d11a8..0e681a565b78 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,7 +240,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_flush(void);
 
 static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ba85d6bb4988..f7304d45e6b9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -760,8 +760,15 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_invalidate);
 		trace_tlb_flush(reason, nr_invalidate);
 	} else {
+		int cpu = smp_processor_id();
+
 		/* Full flush. */
 		flush_tlb_local();
+
+		/* If there are batched TLB flushes, mark they are done */
+		if (cpumask_test_cpu(cpu, &tlb_flush_batched_cpumask))
+			cpumask_clear_cpu(cpu, &tlb_flush_batched_cpumask);
+
 		if (local)
 			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 		trace_tlb_flush(reason, TLB_FLUSH_ALL);
@@ -1143,21 +1150,20 @@ static const struct flush_tlb_info full_flush_tlb_info = {
 	.end = TLB_FLUSH_ALL,
 };
 
-void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+void arch_tlbbatch_flush(void)
 {
 	int cpu = get_cpu();
 
-	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
+	if (cpumask_test_cpu(cpu, &tlb_flush_batched_cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
 		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
-
-	cpumask_clear(&batch->cpumask);
+	if (cpumask_any_but(&tlb_flush_batched_cpumask, cpu) < nr_cpu_ids)
+		flush_tlb_others(&tlb_flush_batched_cpumask,
+				 &full_flush_tlb_info);
 
 	/*
 	 * We cannot call mark_mm_tlb_gen_done() since we do not know which
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a8a5bf82bd03..e4eeee985cf6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3197,5 +3197,12 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+extern volatile cpumask_t tlb_flush_batched_cpumask;
+void tlb_batch_init(void);
+#else
+static inline void tlb_batch_init(void) { }
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..742c542aaf3f 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -15,10 +15,6 @@
 
 #include <asm/page.h>
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-#include <asm/tlbbatch.h>
-#endif
-
 #define USE_SPLIT_PTE_PTLOCKS	(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
 #define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
 		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
@@ -75,15 +71,6 @@ struct page_frag {
 /* Track pages that require TLB flushes */
 struct tlbflush_unmap_batch {
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-	/*
-	 * The arch code makes the following promise: generic code can modify a
-	 * PTE, then call arch_tlbbatch_add_mm() (which internally provides all
-	 * needed barriers), then call arch_tlbbatch_flush(), and the entries
-	 * will be flushed on all CPUs by the time that arch_tlbbatch_flush()
-	 * returns.
-	 */
-	struct arch_tlbflush_unmap_batch arch;
-
 	/* True if a flush is needed. */
 	bool flush_required;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 9655e1fc328a..0d2ac5a72d19 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -586,6 +586,18 @@ void page_unlock_anon_vma_read(struct anon_vma *anon_vma)
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+/*
+ * TLB batching requires arch code to make the following promise: upon a full
+ * TLB flushes, the CPU that performs tlb_flush_batched_cpumask will clear
+ * tlb_flush_batched_cpumask atomically (i.e., during an IRQ or while interrupts
+ * are disabled). arch_tlbbatch_flush() is required to flush all the CPUs that
+ * are set in tlb_flush_batched_cpumask.
+ *
+ * This scheme is therefore only suitable for IPI-based TLB shootdowns.
+ */
+volatile cpumask_t tlb_flush_batched_cpumask = { 0 };
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -599,7 +611,7 @@ void try_to_unmap_flush(void)
 	if (!tlb_ubc->flush_required)
 		return;
 
-	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_flush();
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
@@ -613,27 +625,20 @@ void try_to_unmap_flush_dirty(void)
 		try_to_unmap_flush();
 }
 
-static inline void tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
-				   struct mm_struct *mm)
+static inline void tlbbatch_add_mm(struct mm_struct *mm)
 {
+	cpumask_atomic_or(&tlb_flush_batched_cpumask, mm_cpumask(mm));
+
 	inc_mm_tlb_gen(mm);
-	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
 }
 
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 
-	tlbbatch_add_mm(&tlb_ubc->arch, mm);
+	tlbbatch_add_mm(mm);
 	tlb_ubc->flush_required = true;
 
-	/*
-	 * Ensure compiler does not re-order the setting of tlb_flush_batched
-	 * before the PTE is cleared.
-	 */
-	barrier();
-	mm->tlb_flush_batched = true;
-
 	/*
 	 * If the PTE was dirty then it's best to assume it's writable. The
 	 * caller must use try_to_unmap_flush_dirty() or try_to_unmap_flush()
@@ -679,16 +684,10 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  */
 void flush_tlb_batched_pending(struct mm_struct *mm)
 {
-	if (data_race(mm->tlb_flush_batched)) {
-		flush_tlb_mm(mm);
+	if (!cpumask_intersects(mm_cpumask(mm), &tlb_flush_batched_cpumask))
+		return;
 
-		/*
-		 * Do not allow the compiler to re-order the clearing of
-		 * tlb_flush_batched before the tlb is flushed.
-		 */
-		barrier();
-		mm->tlb_flush_batched = false;
-	}
+	flush_tlb_mm(mm);
 }
 #else
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
-- 
2.25.1

