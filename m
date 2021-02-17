Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995431D8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhBQLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhBQLtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:48:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jt13so21627499ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PeUb27+4l8wv9xRbhMuUZ92iUcBzzFC3Il0N543igIU=;
        b=UH4HxQq0/yLhBjYJXi2x50+Ru5QuPQ3Khj5FuJ2ti3lbWCyYscOQkO7WCyNhQx2Gun
         WvjbbGdihZbzjvPk3/8jVrCDiceUsK2EWml9/WESBB7gKRvh/2lJubvnYRaHfHzKCEiG
         KQjJB6SblWzOzBE0A8+YgPypwIhp5PL20Kso8Qj+mqA2bT5uKXn4T6udyaMfllJ8WelS
         pKuR1AO9vlt4hIFJGIjNgV7/M6a8DMqpwHW7diZXO8y6uY3USDXkA8uLNbM9JYs2OzDg
         b1zFq5lrcw4sAQDi+XBzC8GunjBPAAqnR3VDsXuLjyer2GfZOlkQG/6mvKWggjXSHfcc
         d3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=PeUb27+4l8wv9xRbhMuUZ92iUcBzzFC3Il0N543igIU=;
        b=ksR9E5mkTH01auqVkW1aENkrAt3SBFtgspQvCVUDP5OHA92RkGq3rqYdgNO+RPPXQ6
         ePobu3jCDMIeKLoGZ/aw+h5NgS8h5MWwM7Xhb7ipaCIW1iK11WO3vNBNpndfcyFKjlMS
         gcX7ocrmsFSf2SyBbEHzj489O3cyGCjYnVoEOoopeZqGK/PTqmkJRU815YHBoX3YCLTO
         GslQVATibnHafYneH/UtFdSkO0LvFzliOtfIhY1sLAmqPT0ED5MCwikezKtSTz4idd5r
         eS613R8nxZJYRMQqkpwVtU1jjBGqdnVogiWjPAXVkcx0Le0QoJzJz5FJenmG7r/SkKDe
         ReYQ==
X-Gm-Message-State: AOAM532zwxaF6KN8k5LSA38HWTfd1gQmtTOPxhhw3eAkHKT8yZ+eaFpQ
        ycBDbtYADCb09jqWJg48Y3s=
X-Google-Smtp-Source: ABdhPJwWMQqsZoWi9x5Jd1003qSauLBSJrsak7h1pv/C4SYBu8JNUrkyf8qpqHMlcVbv+DtLwj1eaA==
X-Received: by 2002:a17:906:a4c:: with SMTP id x12mr22338916ejf.159.1613562515781;
        Wed, 17 Feb 2021 03:48:35 -0800 (PST)
Received: from gmail.com (20014C4E1C8ABB004E764B08203955B1.dsl.pool.telekom.hu. [2001:4c4e:1c8a:bb00:4e76:4b08:2039:55b1])
        by smtp.gmail.com with ESMTPSA id z22sm949748edb.88.2021.02.17.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:48:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Feb 2021 12:48:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/mm: Fix (soft-)dirty bit management & clean up the
 TLB gather API
Message-ID: <20210217114833.GA145460@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2021-02-17

   # HEAD: 8cf55f24ce6cf90eb8828421e15e9efcd508bd2c x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables

These changes fix MM (soft-)dirty bit management in the procfs code & clean up the API.

 Thanks,

	Ingo

------------------>
Will Deacon (6):
      mm: proc: Invalidate TLB after clearing soft-dirty page state
      tlb: mmu_gather: Remove unused start/end arguments from tlb_finish_mmu()
      tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
      tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
      tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
      x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables


 arch/ia64/include/asm/tlb.h     |  4 ++--
 arch/sparc/include/asm/tlb_64.h |  1 -
 arch/x86/include/asm/tlb.h      |  1 -
 arch/x86/kernel/ldt.c           | 10 ++++++++--
 fs/exec.c                       |  4 ++--
 fs/proc/task_mmu.c              |  9 +++++----
 include/asm-generic/tlb.h       |  6 ++++--
 include/linux/mm_types.h        |  7 +++----
 mm/hugetlb.c                    | 18 ++----------------
 mm/madvise.c                    | 12 ++++++------
 mm/memory.c                     |  8 ++++----
 mm/mmap.c                       |  8 ++++----
 mm/mmu_gather.c                 | 31 +++++++++++++++++--------------
 mm/oom_kill.c                   |  6 +++---
 14 files changed, 60 insertions(+), 65 deletions(-)

diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 8d9da6f08a62..a15fe0809aae 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -23,7 +23,7 @@
  * unmapping a portion of the virtual address space, these hooks are called according to
  * the following template:
  *
- *	tlb <- tlb_gather_mmu(mm, start, end);		// start unmap for address space MM
+ *	tlb <- tlb_gather_mmu(mm);			// start unmap for address space MM
  *	{
  *	  for each vma that needs a shootdown do {
  *	    tlb_start_vma(tlb, vma);
@@ -36,7 +36,7 @@
  *	    tlb_end_vma(tlb, vma);
  *	  }
  *	}
- *	tlb_finish_mmu(tlb, start, end);	// finish unmap for address space MM
+ *	tlb_finish_mmu(tlb);				// finish unmap for address space MM
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index e841cae544c2..779a5a0f0608 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -24,7 +24,6 @@ void flush_tlb_pending(void);
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
 /*
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 820082bd6880..1bfe979bb9bc 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -4,7 +4,6 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index b8aee71840ae..aa15132228da 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,9 +398,15 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm, start, end);
+	/*
+	 * Although free_pgd_range() is intended for freeing user
+	 * page-tables, it also works out for kernel mappings on x86.
+	 * We use tlb_gather_mmu_fullmm() to avoid confusing the
+	 * range-tracking logic in __tlb_adjust_range().
+	 */
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 #endif
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 5d4d52039105..5a853f03c233 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -708,7 +708,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		return -ENOMEM;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, old_start, old_end);
+	tlb_gather_mmu(&tlb, mm);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
@@ -725,7 +725,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		free_pgd_range(&tlb, old_start, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
 	}
-	tlb_finish_mmu(&tlb, old_start, old_end);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Shrink the vma to just the new range.  Always succeeds.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 602e3a52884d..3cec6fbef725 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1210,7 +1210,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
-	struct mmu_gather tlb;
 	int itype;
 	int rv;
 
@@ -1249,7 +1248,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			goto out_unlock;
 		}
 
-		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1258,15 +1256,18 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				vma_set_page_prot(vma);
 			}
 
+			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
 		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
 				&cp);
-		if (type == CLEAR_REFS_SOFT_DIRTY)
+		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-		tlb_finish_mmu(&tlb, 0, -1);
+			flush_tlb_mm(mm);
+			dec_tlb_flush_pending(mm);
+		}
 out_unlock:
 		mmap_write_unlock(mm);
 out_mm:
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 6661ee1cff47..2c68a545ffa7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -46,7 +46,9 @@
  *
  * The mmu_gather API consists of:
  *
- *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
+ *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_finish_mmu()
+ *
+ *    start and finish a mmu_gather
  *
  *    Finish in particular will issue a (final) TLB invalidate and free
  *    all (remaining) queued pages.
@@ -91,7 +93,7 @@
  *
  *  - mmu_gather::fullmm
  *
- *    A flag set by tlb_gather_mmu() to indicate we're going to free
+ *    A flag set by tlb_gather_mmu_fullmm() to indicate we're going to free
  *    the entire mm; this allows a number of optimizations.
  *
  *    - We can ignore tlb_{start,end}_vma(); because we don't
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07d9acb5b19c..0974ad501a47 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -588,10 +588,9 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 }
 
 struct mmu_gather;
-extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-				unsigned long start, unsigned long end);
-extern void tlb_finish_mmu(struct mmu_gather *tlb,
-				unsigned long start, unsigned long end);
+extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
+extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
+extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee317900..89635f407232 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3967,25 +3967,11 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 			  unsigned long end, struct page *ref_page)
 {
-	struct mm_struct *mm;
 	struct mmu_gather tlb;
-	unsigned long tlb_start = start;
-	unsigned long tlb_end = end;
 
-	/*
-	 * If shared PMDs were possibly used within this vma range, adjust
-	 * start/end for worst case tlb flushing.
-	 * Note that we can not be sure if PMDs are shared until we try to
-	 * unmap pages.  However, we want to make sure TLB flushing covers
-	 * the largest possible range.
-	 */
-	adjust_range_if_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
-
-	mm = vma->vm_mm;
-
-	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
-	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..0938fd3ad228 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -506,9 +506,9 @@ static long madvise_cold(struct vm_area_struct *vma,
 		return -EINVAL;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -558,9 +558,9 @@ static long madvise_pageout(struct vm_area_struct *vma,
 		return 0;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -723,7 +723,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 				range.start, range.end);
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, range.start, range.end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
@@ -732,7 +732,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 			&madvise_free_walk_ops, &tlb);
 	tlb_end_vma(&tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, range.start, range.end);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..9e8576a83147 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1534,13 +1534,13 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, start, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, start, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
@@ -1561,12 +1561,12 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, address + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, address, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, address, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
diff --git a/mm/mmap.c b/mm/mmap.c
index dc7206032387..90673febce6a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2671,12 +2671,12 @@ static void unmap_region(struct mm_struct *mm,
 	struct mmu_gather tlb;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
@@ -3214,12 +3214,12 @@ void exit_mmap(struct mm_struct *mm)
 
 	lru_add_drain();
 	flush_cache_mm(mm);
-	tlb_gather_mmu(&tlb, mm, 0, -1);
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, 0, -1);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 03c33c93a582..0dc7149b0c61 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -253,21 +253,17 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
  * @mm: the mm_struct of the target address space
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
+ * @fullmm: @mm is without users and we're going to destroy the full address
+ *	    space (exit/execve)
  *
  * Called to initialize an (on-stack) mmu_gather structure for page-table
- * tear-down from @mm. The @start and @end are set to 0 and -1
- * respectively when @mm is without users and we're going to destroy
- * the full address space (exit/execve).
+ * tear-down from @mm.
  */
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			unsigned long start, unsigned long end)
+static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+			     bool fullmm)
 {
 	tlb->mm = mm;
-
-	/* Is it from 0 to ~0? */
-	tlb->fullmm     = !(start | (end+1));
+	tlb->fullmm = fullmm;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
@@ -287,17 +283,24 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	inc_tlb_flush_pending(tlb->mm);
 }
 
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
+{
+	__tlb_gather_mmu(tlb, mm, false);
+}
+
+void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
+{
+	__tlb_gather_mmu(tlb, mm, true);
+}
+
 /**
  * tlb_finish_mmu - finish an mmu_gather structure
  * @tlb: the mmu_gather structure to finish
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
  *
  * Called at the end of the shootdown operation to free up any resources that
  * were required.
  */
-void tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end)
+void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 	/*
 	 * If there are parallel threads are doing PTE changes on same range
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 04b19b7b5435..c9a33ffe38b7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -546,15 +546,15 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
 						vma, mm, vma->vm_start,
 						vma->vm_end);
-			tlb_gather_mmu(&tlb, mm, range.start, range.end);
+			tlb_gather_mmu(&tlb, mm);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
-				tlb_finish_mmu(&tlb, range.start, range.end);
+				tlb_finish_mmu(&tlb);
 				ret = false;
 				continue;
 			}
 			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
 			mmu_notifier_invalidate_range_end(&range);
-			tlb_finish_mmu(&tlb, range.start, range.end);
+			tlb_finish_mmu(&tlb);
 		}
 	}
 
