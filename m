Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0F37019E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhD3TzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:16 -0400
Received: from server.lespinasse.org ([63.205.204.226]:54421 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhD3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:37 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=in6C9xm2aQi+RZ2gD0g9zMXOcx4SOVEAt3QJRKwzXzw=;
 b=y1VcywCk3wkhDGxVwvBnn9Gel88/ciqw6Jv2ouuGUtJZiG0dNktLTHO6MYFT0EDEIfh0f
 jqVrg+kyNtI8l5FDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=in6C9xm2aQi+RZ2gD0g9zMXOcx4SOVEAt3QJRKwzXzw=;
 b=gPEA2N1bdoR3t7KK+ez4hQ2VWS85UMrFRpj5G+wbozJK/cWXoO6q7L+GhlHKlQOZqwbq3
 wk120gGfQIwQ4QEjVOFcQE9vs9Ak7bjPzpGqiBFNZf3oUns3CO/+gPJv0ew25LmtN07OLeZ
 0URGLJlIjfHTn5aR4dCCxWDfxpBYvBH1F+FPV8oTwplwSvI49SV/j6UUfbS8hkVFg5sDA7E
 wmSt/TumK+CMwLWyX7IyT/cNi1K5lKre7ngOJ4nhbSYSufKVTLayvoTQCRcarGMe3tnXJwK
 /leE2vHFgpGBbIHtnpuu8OTb5Nr7fpRV+nIoUpd7Mi/nzbdbwraRJDpLjLOg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id BF80E160366;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id AFBBA19F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 27/29] mm: anon spf statistics
Date:   Fri, 30 Apr 2021 12:52:28 -0700
Message-Id: <20210430195232.30491-28-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CONFIG_SPECULATIVE_PAGE_FAULT_STATS config option,
and dump extra statistics about executed spf cases and abort reasons
when the option is set.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c           | 18 ++++++++---
 include/linux/mmap_lock.h     | 19 +++++++++--
 include/linux/vm_event_item.h | 23 ++++++++++++++
 include/linux/vmstat.h        |  6 ++++
 mm/Kconfig.debug              |  7 ++++
 mm/memory.c                   | 60 ++++++++++++++++++++++++++++-------
 mm/vmstat.c                   | 23 ++++++++++++++
 7 files changed, 139 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b5c21585e35f..7d8c99023a82 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1331,21 +1331,31 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	count_vm_event(SPF_ATTEMPT);
 	seq = mmap_seq_read_start(mm);
-	if (seq & 1)
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
 		goto spf_abort;
+	}
 	rcu_read_lock();
 	vma = find_vma(mm, address);
-	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
+	if (!vma || vma->vm_start > address) {
 		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_UNMAPPED);
+		goto spf_abort;
+	}
+	if (!vma_is_anonymous(vma)) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_NO_SPECULATE);
 		goto spf_abort;
 	}
 	pvma = *vma;
 	rcu_read_unlock();
-	if (!mmap_seq_read_check(mm, seq))
+	if (!mmap_seq_read_check(mm, seq, SPF_ABORT_VMA_COPY))
 		goto spf_abort;
 	vma = &pvma;
-	if (unlikely(access_error(error_code, vma)))
+	if (unlikely(access_error(error_code, vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
 		goto spf_abort;
+	}
 	fault = do_handle_mm_fault(vma, address,
 				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8f4eca2d0f43..98f24a9910a9 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,6 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
+#include <linux/vmstat.h>
 
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 #define MMAP_LOCK_SEQ_INITIALIZER(name) \
@@ -104,12 +105,26 @@ static inline unsigned long mmap_seq_read_start(struct mm_struct *mm)
 	return seq;
 }
 
-static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq)
+static inline bool __mmap_seq_read_check(struct mm_struct *mm,
+					 unsigned long seq)
 {
 	smp_rmb();
 	return seq == READ_ONCE(mm->mmap_seq);
 }
-#endif
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq,
+	enum vm_event_item fail_event)
+{
+	if (__mmap_seq_read_check(mm, seq))
+		return true;
+	count_vm_event(fail_event);
+	return false;
+}
+#else
+#define mmap_seq_read_check(mm, seq, fail) __mmap_seq_read_check(mm, seq)
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT_STATS */
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index cc4f8d14e43f..42e57db1623b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -124,6 +124,29 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 		SPF_ATTEMPT,
 		SPF_ABORT,
+#endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+		SPF_ABORT_ODD,
+		SPF_ABORT_UNMAPPED,
+		SPF_ABORT_NO_SPECULATE,
+		SPF_ABORT_VMA_COPY,
+		SPF_ABORT_ACCESS_ERROR,
+		SPF_ABORT_PUD,
+		SPF_ABORT_PMD,
+		SPF_ABORT_ANON_VMA,
+		SPF_ABORT_PTE_MAP_LOCK_SEQ1,
+		SPF_ABORT_PTE_MAP_LOCK_PMD,
+		SPF_ABORT_PTE_MAP_LOCK_PTL,
+		SPF_ABORT_PTE_MAP_LOCK_SEQ2,
+		SPF_ABORT_USERFAULTFD,
+		SPF_ABORT_FAULT,
+		SPF_ABORT_NON_SWAP_ENTRY,
+		SPF_ABORT_SWAP_NOPAGE,
+		SPF_ATTEMPT_ANON,
+		SPF_ATTEMPT_SWAP,
+		SPF_ATTEMPT_NUMA,
+		SPF_ATTEMPT_PTE,
+		SPF_ATTEMPT_WP,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 506d625163a1..34e05604a93f 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -109,6 +109,12 @@ static inline void vm_events_fold_cpu(int cpu)
 
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+#define count_vm_spf_event(x) count_vm_event(x)
+#else
+#define count_vm_spf_event(x) do {} while (0)
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 #define count_vm_numa_event(x)     count_vm_event(x)
 #define count_vm_numa_events(x, y) count_vm_events(x, y)
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 1e73717802f8..6be8ca7950ee 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -150,3 +150,10 @@ config PTDUMP_DEBUGFS
 	  kernel.
 
 	  If in doubt, say N.
+
+config SPECULATIVE_PAGE_FAULT_STATS
+	bool "Additional statistics for speculative page faults"
+	depends on SPECULATIVE_PAGE_FAULT
+	help
+	  Additional statistics for speculative page faults.
+	  If in doubt, say N.
diff --git a/mm/memory.c b/mm/memory.c
index cf1a1c0196f0..838482b7ffc5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2603,7 +2603,8 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	}
 
 	speculative_page_walk_begin();
-	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq,
+				 SPF_ABORT_PTE_MAP_LOCK_SEQ1))
 		goto fail;
 	/*
 	 * The mmap sequence count check guarantees that the page
@@ -2616,8 +2617,10 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	 * is not a huge collapse operation in progress in our back.
 	 */
 	pmdval = READ_ONCE(*vmf->pmd);
-	if (!pmd_same(pmdval, vmf->orig_pmd))
+	if (!pmd_same(pmdval, vmf->orig_pmd)) {
+		count_vm_spf_event(SPF_ABORT_PTE_MAP_LOCK_PMD);
 		goto fail;
+	}
 #endif
 	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	if (!pte)
@@ -2634,9 +2637,12 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	 * We also don't want to retry until spin_trylock() succeeds,
 	 * because of the starvation potential against a stream of lockers.
 	 */
-	if (unlikely(!spin_trylock(ptl)))
+	if (unlikely(!spin_trylock(ptl))) {
+		count_vm_spf_event(SPF_ABORT_PTE_MAP_LOCK_PTL);
 		goto fail;
-	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+	}
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq,
+				 SPF_ABORT_PTE_MAP_LOCK_SEQ2))
 		goto unlock_fail;
 	speculative_page_walk_end();
 	vmf->pte = pte;
@@ -2908,6 +2914,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	if (unlikely(!vma->anon_vma)) {
 		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_ANON_VMA);
 			ret = VM_FAULT_RETRY;
 			goto out;
 		}
@@ -3170,10 +3177,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_WP);
+
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_USERFAULTFD);
 			return VM_FAULT_RETRY;
+		}
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
@@ -3357,6 +3369,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_SWAP);
+
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		/*
@@ -3383,6 +3398,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_NON_SWAP_ENTRY);
 			ret = VM_FAULT_RETRY;
 		} else if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
@@ -3409,6 +3425,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
 			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+			count_vm_spf_event(SPF_ABORT_SWAP_NOPAGE);
 			return VM_FAULT_RETRY;
 		}
 
@@ -3615,6 +3632,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	pte_t entry;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_ANON);
+
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
 		return VM_FAULT_SIGBUS;
@@ -3644,8 +3664,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	} else {
 		/* Allocate our own private page. */
 		if (unlikely(!vma->anon_vma)) {
-			if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+				count_vm_spf_event(SPF_ABORT_ANON_VMA);
 				return VM_FAULT_RETRY;
+			}
 			if (__anon_vma_prepare(vma))
 				goto oom;
 		}
@@ -3687,8 +3709,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		if (page)
 			put_page(page);
-		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_USERFAULTFD);
 			return VM_FAULT_RETRY;
+		}
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
@@ -4221,6 +4245,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	bool was_writable = pte_savedwrite(vmf->orig_pte);
 	int flags = 0;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_NUMA);
+
 	/*
 	 * The "pte" at this point cannot be used safely without
 	 * validation through pte_unmap_same(). It's of NUMA type but
@@ -4393,6 +4420,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_PTE);
+
 	if (!pte_spinlock(vmf))
 		return VM_FAULT_RETRY;
 	entry = vmf->orig_pte;
@@ -4460,20 +4490,26 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		speculative_page_walk_begin();
 		pgd = pgd_offset(mm, address);
 		pgdval = READ_ONCE(*pgd);
-		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval)))
+		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		p4d = p4d_offset(pgd, address);
 		p4dval = READ_ONCE(*p4d);
-		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval)))
+		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		vmf.pud = pud_offset(p4d, address);
 		pudval = READ_ONCE(*vmf.pud);
 		if (pud_none(pudval) || unlikely(pud_bad(pudval)) ||
 		    unlikely(pud_trans_huge(pudval)) ||
-		    unlikely(pud_devmap(pudval)))
+		    unlikely(pud_devmap(pudval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		vmf.pmd = pmd_offset(vmf.pud, address);
 		vmf.orig_pmd = READ_ONCE(*vmf.pmd);
@@ -4491,8 +4527,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (unlikely(pmd_none(vmf.orig_pmd) ||
 			     is_swap_pmd(vmf.orig_pmd) ||
 			     pmd_trans_huge(vmf.orig_pmd) ||
-			     pmd_devmap(vmf.orig_pmd)))
+			     pmd_devmap(vmf.orig_pmd))) {
+			count_vm_spf_event(SPF_ABORT_PMD);
 			goto spf_fail;
+		}
 
 		/*
 		 * The above does not allocate/instantiate page-tables because
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 9ae1c27a549e..dbaefae62da3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1369,6 +1369,29 @@ const char * const vmstat_text[] = {
 	"spf_attempt",
 	"spf_abort",
 #endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+	"SPF_ABORT_ODD",
+	"SPF_ABORT_UNMAPPED",
+	"SPF_ABORT_NO_SPECULATE",
+	"SPF_ABORT_VMA_COPY",
+	"SPF_ABORT_ACCESS_ERROR",
+	"SPF_ABORT_PUD",
+	"SPF_ABORT_PMD",
+	"SPF_ABORT_ANON_VMA",
+	"SPF_ABORT_PTE_MAP_LOCK_SEQ1",
+	"SPF_ABORT_PTE_MAP_LOCK_PMD",
+	"SPF_ABORT_PTE_MAP_LOCK_PTL",
+	"SPF_ABORT_PTE_MAP_LOCK_SEQ2",
+	"SPF_ABORT_USERFAULTFD",
+	"SPF_ABORT_FAULT",
+	"SPF_ABORT_NON_SWAP_ENTRY",
+	"SPF_ABORT_SWAP_NOPAGE",
+	"SPF_ATTEMPT_ANON",
+	"SPF_ATTEMPT_SWAP",
+	"SPF_ATTEMPT_NUMA",
+	"SPF_ATTEMPT_PTE",
+	"SPF_ATTEMPT_WP",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.20.1

