Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6963CC792
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhGREe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhGREeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:34:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C3C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4-20020a17090ace84b029017554809f35so11773022pju.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkDonhS/0zW6qX5fgqqNQXuBc0PI4yA6BT4exnNjD10=;
        b=K4TnxxmsICEKEHNKIOXpXvwPLmqSlyh9/RWeyaFHtulG7k4Inn+SQZADEgHR7PtUsb
         gSdQT3u8snsbOf9ULGpytuWfOGS29nh8o0pOgiXHxd7mV0FkImNAhng+Ks3zPAlwGHiC
         kgt0pcX976KmaT33CWY2qPTKGfGxINiYa17400jvTenZAPSNhdgunC3CG5Uh0sSe1WAo
         GinUeqDjRXc/ogJSC7SuSAumCfxIMdL2SsTn54VcNiQB6sRXVbzGaj+DRw5Da0nSznAQ
         lbCcbgi7Tw/u0BVfGvC49ZcyJZ303KEEf8RzhHAmrKdgzfV6+mbAMv/W1WGGEpJkjYiD
         8vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkDonhS/0zW6qX5fgqqNQXuBc0PI4yA6BT4exnNjD10=;
        b=IV1ELhrbHms8aqNiPcY7MtXgxV/lK9yVYPs8DKvy6179608vKaMZek9DfkMO3Ne2Tw
         Jk6PA1kXTMoqekpRnwU+3FiLhTe22+e3WyKo3RJJPp9pgDF6lEMtHe0TffGiu2CRxsFI
         Mq3yX6V75r9JD+iLk6RvIrgcxXG7C3waPYXZpsQ/LjhQAelHKua3lwNs2eD3+hrUOMwa
         skgVDMuAKarbUQ+B16hkeqaMQMOIXNRyjv3OpFSyYZJQZB7OeA6SGc1cNu7rjHVEabYO
         oXcIPbEfc56xE6yxOSr54992BhFJUyzgKNUM7E+BrhZOQZqFPAV4oy9IFW4N8wxML9Iw
         HOBg==
X-Gm-Message-State: AOAM530+rz7CKhrc3o7uYefIEgnY69NwvoR1upiphPyEpkr1A7VC1H3V
        zF9BOoGx1fxnoCFVrLhzPCbIyw==
X-Google-Smtp-Source: ABdhPJzMskEG9thJ2HkhJOWCgOLmwEa7eCNC+o+x9ePXxlMLV3xdpdIRH4bTUUExHUU97sZoR6YRpQ==
X-Received: by 2002:a17:90b:1484:: with SMTP id js4mr17883369pjb.155.1626582679993;
        Sat, 17 Jul 2021 21:31:19 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.31.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:31:19 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 7/7] mm: use mmu_gather to free PTE page table
Date:   Sun, 18 Jul 2021 12:30:33 +0800
Message-Id: <20210718043034.76431-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In unmap_region() and other paths, we can reuse @tlb to
free PTE page table, which can reduce the number of tlb
flush.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig        |  2 +-
 include/linux/pte_ref.h | 32 +++++++++++++++++++++++++++-----
 mm/madvise.c            |  4 ++--
 mm/memory.c             |  4 ++--
 mm/mmu_gather.c         | 40 +++++++++++++++++-----------------------
 mm/pte_ref.c            | 12 +++++++++---
 6 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 761ad0830dd6..1f873c2d5f51 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,7 +233,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT || FREE_USER_PTE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index f4d20faab684..bf6cd09b67d7 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -18,7 +18,8 @@ int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd);
 
 #ifdef CONFIG_FREE_USER_PTE
-void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
+void free_pte_table(struct mmu_gather *tlb, struct mm_struct *mm, pmd_t *pmdp,
+		    unsigned long addr);
 
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
 {
@@ -62,7 +63,6 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
 {
 	pgtable_t pte = pmd_pgtable(*pmdp);
 
-	VM_BUG_ON(!PageTable(pte));
 	return atomic_inc_not_zero(&pte->pte_refcount);
 }
 
@@ -97,8 +97,8 @@ static inline bool pte_try_get(pmd_t *pmdp)
  * i_mmap_lock or when parallel threads are excluded by other means
  * which can make @pmdp entry stable.
  */
-static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
-				unsigned long addr, unsigned int nr)
+static inline void pte_put_many_tlb(struct mmu_gather *tlb, struct mm_struct *mm,
+				    pmd_t *pmdp, unsigned long addr, unsigned int nr)
 {
 	pgtable_t pte = pmd_pgtable(*pmdp);
 
@@ -106,7 +106,19 @@ static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
 	VM_BUG_ON(pmd_devmap_trans_unstable(pmdp));
 	VM_BUG_ON(pte->pmd != pmdp);
 	if (atomic_sub_and_test(nr, &pte->pte_refcount))
-		free_pte_table(mm, pmdp, addr & PMD_MASK);
+		free_pte_table(tlb, mm, pmdp, addr & PMD_MASK);
+}
+
+static inline void pte_put_tlb(struct mmu_gather *tlb, struct mm_struct *mm,
+			       pmd_t *pmdp, unsigned long addr)
+{
+	pte_put_many_tlb(tlb, mm, pmdp, addr, 1);
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
+				unsigned long addr, unsigned int nr)
+{
+	pte_put_many_tlb(NULL, mm, pmdp, addr, nr);
 }
 
 static inline void pte_put(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
@@ -180,6 +192,16 @@ static inline bool pte_try_get(pmd_t *pmdp)
 	return true;
 }
 
+static inline void pte_put_many_tlb(struct mmu_gather *tlb, struct mm_struct *mm,
+				    pmd_t *pmdp, unsigned long addr, unsigned int nr)
+{
+}
+
+static inline void pte_put_tlb(struct mmu_gather *tlb, struct mm_struct *mm,
+			       pmd_t *pmdp, unsigned long addr)
+{
+}
+
 static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
 				unsigned long addr, unsigned int value)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 0e849bbf268b..117bc5aad0f8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -477,7 +477,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
-	pte_put(vma->vm_mm, pmd, start);
+	pte_put_tlb(tlb, vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -709,7 +709,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		pte_put_many_tlb(tlb, mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index c8ee0074c730..4f49e8135000 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1438,7 +1438,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	}
 
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		pte_put_many_tlb(tlb, mm, pmd, start, nr_put);
 
 	return addr;
 }
@@ -1485,7 +1485,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
-		pte_put(tlb->mm, pmd, addr);
+		pte_put_tlb(tlb, tlb->mm, pmd, addr);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9..1bd9fa889421 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -134,42 +134,42 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
  *
  */
 
-static void tlb_remove_table_smp_sync(void *arg)
+static void tlb_remove_table_rcu(struct rcu_head *head)
 {
-	/* Simply deliver the interrupt */
+	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
 }
 
-static void tlb_remove_table_sync_one(void)
+static void tlb_remove_table_free(struct mmu_table_batch *batch)
 {
-	/*
-	 * This isn't an RCU grace period and hence the page-tables cannot be
-	 * assumed to be actually RCU-freed.
-	 *
-	 * It is however sufficient for software page-table walkers that rely on
-	 * IRQ disabling.
-	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	call_rcu(&batch->rcu, tlb_remove_table_rcu);
 }
 
-static void tlb_remove_table_rcu(struct rcu_head *head)
+static void tlb_remove_table_one_rcu(struct rcu_head *head)
 {
-	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
+	struct page *page = container_of(head, struct page, rcu_head);
+
+	__tlb_remove_table(page);
 }
 
-static void tlb_remove_table_free(struct mmu_table_batch *batch)
+static void tlb_remove_table_one(void *table)
 {
-	call_rcu(&batch->rcu, tlb_remove_table_rcu);
+	pgtable_t page = (pgtable_t)table;
+
+	call_rcu(&page->rcu_head, tlb_remove_table_one_rcu);
 }
 
 #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
-static void tlb_remove_table_sync_one(void) { }
-
 static void tlb_remove_table_free(struct mmu_table_batch *batch)
 {
 	__tlb_remove_table_free(batch);
 }
 
+static void tlb_remove_table_one(void *table)
+{
+	__tlb_remove_table(table);
+}
+
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 /*
@@ -187,12 +187,6 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-static void tlb_remove_table_one(void *table)
-{
-	tlb_remove_table_sync_one();
-	__tlb_remove_table(table);
-}
-
 static void tlb_table_flush(struct mmu_gather *tlb)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 7fd3d687a9cd..92fb73c35d81 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -10,6 +10,7 @@
 #include <linux/pte_ref.h>
 #include <linux/hugetlb.h>
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #ifdef CONFIG_DEBUG_VM
 static void pte_free_debug(pmd_t pmd)
@@ -34,7 +35,8 @@ static void pte_free_rcu(struct rcu_head *rcu)
 	__free_page(page);
 }
 
-void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+void free_pte_table(struct mmu_gather *tlb, struct mm_struct *mm,
+		    pmd_t *pmdp, unsigned long addr)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
 	spinlock_t *ptl;
@@ -45,9 +47,13 @@ void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
 	spin_unlock(ptl);
 
 	pte_free_debug(pmd);
-	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	if (!tlb) {
+		flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+		call_rcu(&pmd_pgtable(pmd)->rcu_head, pte_free_rcu);
+	} else {
+		pte_free_tlb(tlb, pmd_pgtable(pmd), addr);
+	}
 	mm_dec_nr_ptes(mm);
-	call_rcu(&pmd_pgtable(pmd)->rcu_head, pte_free_rcu);
 }
 
 static inline void __pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
-- 
2.11.0

