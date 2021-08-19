Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122353F117F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHSDVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhHSDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:21:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCCC0613A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so10420756pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WXbcHWNowQAVftzV5Tv2pLkmBnGpqWKBHXjn2bp8kE=;
        b=o1leQwFsVxR/zVtkR51mW76kcy/9PDUerFFV6wfGKhd3L8MqT9rlNGjLbKzVpbGZT5
         4yWfecK0uVNjnpnyYXBsYh1X8gy+260xfrgtORlIIaf5UirQo3VeRCm9UybFwU0Er4Jj
         ZAcVxx0Esho8/oD/iPX+/iz08fBtMClr27wGzT518ouy5slZDhfm3HNhwbqom3rzoUBE
         ruswg74ZEHpxEGJZog/6Xm/YFTMSqmj09fe25GIzI7rX7wGwG+K5e4ONwnuj9IOfKmRr
         oE3PhkGHsE9E7NwdGysFfN/IHdk+qT0cU6hq1n4e5h0jyild/+PwJmvkY7xKfSsf2M1q
         ZwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WXbcHWNowQAVftzV5Tv2pLkmBnGpqWKBHXjn2bp8kE=;
        b=LV86R+zYtOePVih8L+sQMThhIoHbSvT4+4qOHh0zPrdySuadti0HnwL6p76Ol7fNik
         cnp+wInulv3reJgu01Xq1NCfvBtrrWD84b49vy0PS+bldsqhEOr5VM0Hzi+qXdfUPSCw
         LU4KwNj5nmUClI0APP7HjbAkRhPmP9WerDGRiFq+do0R5/BAIPWJgCIboHaifXcpeyUp
         K+YTyrc1GrB35t8qhZvhXUHDhd1LNZUpZetBBB6x962nmpF6FNLnN6PxW8kGw77iXXAn
         uSJf9aH0InKFm4NfwWAkCNWGxoHIckXHQRLajzvvNlwIpIVOVtG8ASaNxgzE4/tyU4HO
         cusw==
X-Gm-Message-State: AOAM532Pqa+ACUb0eK8R0llZTXoP4s7kZc2J+G+NO2N98dWdpX5dyffu
        77pfeZ7ebl/11aTetrnWeCNZvw==
X-Google-Smtp-Source: ABdhPJwnx+NtF/ns4F180dZ3R3QOaGtghaOiuVcTab32/0QMuYQEzTd2Kp5RXtBOqx3fudBw9tGBjw==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr12716983pjh.40.1629343235286;
        Wed, 18 Aug 2021 20:20:35 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:34 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 9/9] mm: use mmu_gather to free PTE page table
Date:   Thu, 19 Aug 2021 11:18:58 +0800
Message-Id: <20210819031858.98043-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
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
index 45962aaf2b2c..fc7453826160 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -232,7 +232,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT || FREE_USER_PTE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index 259e5aec048d..4b7ea1fe447f 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -29,7 +29,8 @@ int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd);
 
 #ifdef CONFIG_FREE_USER_PTE
 
-void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
+void free_pte_table(struct mmu_gather *tlb, struct mm_struct *mm, pmd_t *pmdp,
+		    unsigned long addr);
 
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
 {
@@ -76,7 +77,6 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
 {
 	pgtable_t pte = pmd_pgtable(*pmdp);
 
-	VM_BUG_ON(!PageTable(pte));
 	return atomic_inc_not_zero(&pte->pte_refcount);
 }
 
@@ -105,14 +105,26 @@ static inline bool pte_try_get(pmd_t *pmdp)
 	return retval;
 }
 
-static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
-				unsigned long addr, unsigned int nr)
+static inline void pte_put_many_tlb(struct mmu_gather *tlb, struct mm_struct *mm,
+				    pmd_t *pmdp, unsigned long addr, unsigned int nr)
 {
 	pgtable_t pte = pmd_pgtable(*pmdp);
 
 	VM_BUG_ON(!PageTable(pte));
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
 
 /*
@@ -234,6 +246,16 @@ static inline bool pte_try_get(pmd_t *pmdp)
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
index 254811f41850..6616c0567dcb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -474,7 +474,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
-	pte_put(vma->vm_mm, pmd, start);
+	pte_put_tlb(tlb, vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -705,7 +705,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		pte_put_many_tlb(tlb, mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 6a7fe29d593b..28639a75ce02 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1437,7 +1437,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	}
 
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		pte_put_many_tlb(tlb, mm, pmd, start, nr_put);
 
 	return addr;
 }
@@ -1481,7 +1481,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		if (pmd_trans_unstable_or_pte_try_get(pmd))
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
index ea40b1777056..676923f3c7c8 100644
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
 
 static inline void __pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
-- 
2.11.0

