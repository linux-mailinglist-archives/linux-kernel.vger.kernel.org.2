Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73F44BF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKJK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhKJK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED07BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:56:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h24so1247373pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25VRZHR2Pd1VOPr3qZJqaRujj9XwfT4H1vR/Swabhf0=;
        b=lz02LYdU8qxmCn1b6rHkpZA/GZ/O+w2Elu0uYFnq1f5iHi/0SBko9OtG0wFLIoD4yz
         b0hWoKv/hzZ0NYjWQ/OJu9oGxhKVIOhCv+moAsqKJJKJwZ89zZvegnmx1NxOLqtQl2c5
         hMV71i7n2eMyMCO1JHtvVw48yoi8urgDLIHg1ob7sGE3BCov3KrnzAysFU94hqOwMdXN
         dH9vL3Z6czJou33gMPj72kQ3xO7D2Ms7T1uFWlImi+lXqu83eo+AGGO0D9StuTSabqVe
         O0nZBwDnMViWz7EmAxIiALvpWL+dCP80ex4FwnJA1Dni3ChoPgKRtoJRcrqYQtShwBxO
         iMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25VRZHR2Pd1VOPr3qZJqaRujj9XwfT4H1vR/Swabhf0=;
        b=YKd6YBvSdjK16/K3C2v1/qL+EhPt5rk2Igdis2WSu58AtR3IZ2DDo2ZqRPCnwxkfbH
         OOl4r8ZPnqy6YCRbaALoZS582e+f2dVnE63fsyOAncm+4BKM0y9slf9t8DZi6ujVlnSx
         WRmpaWsI7LkzIg2eCOYBhOwUSjWP8hFR6Z+B6cZM14JYsuTrlIslBjUbLLoTxch263cJ
         a6SoomcT/b3mBeo9rWbq9HlEo8beBheYjJNvfKco3X+UCnTh1TZJdI330lBYj3hM1MIe
         qwUZ/6N9O/Vu0dE2osCTT1kVWVPxZ4DTJKlQGuBOLcWTYTcBYidAIC8GZRZ0VHUUrPfY
         juGQ==
X-Gm-Message-State: AOAM530jPPpncgzrHbPI3Oc/Ckex3qdyGJhJrRNilJj33Wfh/wykCO+3
        mxj+yFy6HQXOx2t7W84NTBdU8w==
X-Google-Smtp-Source: ABdhPJwGhGqveQ+o8jACuOsGuYbmyPmdBPe4k0o2lNyqcYut9KcMuAGLX1QXE/zSG37UacD6C/vYpA==
X-Received: by 2002:a17:902:e789:b0:140:801:1262 with SMTP id cp9-20020a170902e78900b0014008011262mr15005904plb.42.1636541764450;
        Wed, 10 Nov 2021 02:56:04 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.56.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:56:04 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 15/15] mm/pte_ref: use mmu_gather to free PTE page table pages
Date:   Wed, 10 Nov 2021 18:54:28 +0800
Message-Id: <20211110105428.32458-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
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
 Documentation/vm/pte_ref.rst | 58 +++++++++++++++++++++++---------------------
 arch/x86/Kconfig             |  2 +-
 include/linux/pte_ref.h      | 34 ++++++++++++++++++++------
 mm/madvise.c                 |  4 +--
 mm/memory.c                  |  4 +--
 mm/mmu_gather.c              | 40 +++++++++++++-----------------
 mm/pte_ref.c                 | 13 +++++++---
 7 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
index c5323a263464..d304c0bfaae1 100644
--- a/Documentation/vm/pte_ref.rst
+++ b/Documentation/vm/pte_ref.rst
@@ -183,30 +183,34 @@ GUP as an example::
 4. Helpers
 ==========
 
-+---------------------+-------------------------------------------------+
-| pte_ref_init        | Initialize the pte_refcount and pmd             |
-+---------------------+-------------------------------------------------+
-| pte_to_pmd          | Get the corresponding pmd                       |
-+---------------------+-------------------------------------------------+
-| pte_update_pmd      | Update the corresponding pmd                    |
-+---------------------+-------------------------------------------------+
-| pte_get             | Increment a pte_refcount                        |
-+---------------------+-------------------------------------------------+
-| pte_get_many        | Add a value to a pte_refcount                   |
-+---------------------+-------------------------------------------------+
-| pte_get_unless_zero | Increment a pte_refcount unless it is 0         |
-+---------------------+-------------------------------------------------+
-| pte_try_get         | Try to increment a pte_refcount                 |
-+---------------------+-------------------------------------------------+
-| pte_tryget_map      | Try to increment a pte_refcount before          |
-|                     | pte_offset_map()                                |
-+---------------------+-------------------------------------------------+
-| pte_tryget_map_lock | Try to increment a pte_refcount before          |
-|                     | pte_offset_map_lock()                           |
-+---------------------+-------------------------------------------------+
-| pte_put             | Decrement a pte_refcount                        |
-+---------------------+-------------------------------------------------+
-| pte_put_many        | Sub a value to a pte_refcount                   |
-+---------------------+-------------------------------------------------+
-| pte_put_vmf         | Decrement a pte_refcount in the page fault path |
-+---------------------+-------------------------------------------------+
++---------------------+------------------------------------------------------+
+| pte_ref_init        | Initialize the pte_refcount and pmd                  |
++---------------------+------------------------------------------------------+
+| pte_to_pmd          | Get the corresponding pmd                            |
++---------------------+------------------------------------------------------+
+| pte_update_pmd      | Update the corresponding pmd                         |
++---------------------+------------------------------------------------------+
+| pte_get             | Increment a pte_refcount                             |
++---------------------+------------------------------------------------------+
+| pte_get_many        | Add a value to a pte_refcount                        |
++---------------------+------------------------------------------------------+
+| pte_get_unless_zero | Increment a pte_refcount unless it is 0              |
++---------------------+------------------------------------------------------+
+| pte_try_get         | Try to increment a pte_refcount                      |
++---------------------+------------------------------------------------------+
+| pte_tryget_map      | Try to increment a pte_refcount before               |
+|                     | pte_offset_map()                                     |
++---------------------+------------------------------------------------------+
+| pte_tryget_map_lock | Try to increment a pte_refcount before               |
+|                     | pte_offset_map_lock()                                |
++---------------------+------------------------------------------------------+
+| __pte_put           | Decrement a pte_refcount                             |
++---------------------+------------------------------------------------------+
+| __pte_put_many      | Sub a value to a pte_refcount                        |
++---------------------+------------------------------------------------------+
+| pte_put             | Decrement a pte_refcount(without tlb parameter)      |
++---------------------+------------------------------------------------------+
+| pte_put_many        | Sub a value to a pte_refcount(without tlb parameter) |
++---------------------+------------------------------------------------------+
+| pte_put_vmf         | Decrement a pte_refcount in the page fault path      |
++---------------------+------------------------------------------------------+
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ca5bfe83ec61..69ea13437947 100644
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
index 8a26eaba83ef..dc3923bb38f6 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -22,7 +22,8 @@ enum pte_tryget_type pte_try_get(pmd_t *pmd);
 bool pte_get_unless_zero(pmd_t *pmd);
 
 #ifdef CONFIG_FREE_USER_PTE
-void free_user_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
+void free_user_pte_table(struct mmu_gather *tlb, struct mm_struct *mm,
+			 pmd_t *pmd, unsigned long addr);
 
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
 {
@@ -48,14 +49,21 @@ static inline void pte_get_many(pmd_t *pmd, unsigned int nr)
 	atomic_add(nr, &pte->pte_refcount);
 }
 
-static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr, unsigned int nr)
+static inline void __pte_put_many(struct mmu_gather *tlb, struct mm_struct *mm,
+				  pmd_t *pmd, unsigned long addr,
+				  unsigned int nr)
 {
 	pgtable_t pte = pmd_pgtable(*pmd);
 
 	VM_BUG_ON(!PageTable(pte));
 	if (atomic_sub_and_test(nr, &pte->pte_refcount))
-		free_user_pte_table(mm, pmd, addr & PMD_MASK);
+		free_user_pte_table(tlb, mm, pmd, addr & PMD_MASK);
+}
+
+static inline void __pte_put(struct mmu_gather *tlb, struct mm_struct *mm,
+			     pmd_t *pmd, unsigned long addr)
+{
+	__pte_put_many(tlb, mm, pmd, addr, 1);
 }
 #else
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
@@ -75,8 +83,14 @@ static inline void pte_get_many(pmd_t *pmd, unsigned int nr)
 {
 }
 
-static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr, unsigned int nr)
+static inline void __pte_put_many(struct mmu_gather *tlb, struct mm_struct *mm,
+				  pmd_t *pmd, unsigned long addr,
+				  unsigned int nr)
+{
+}
+
+static inline void __pte_put(struct mmu_gather *tlb, struct mm_struct *mm,
+			     pmd_t *pmd, unsigned long addr)
 {
 }
 #endif /* CONFIG_FREE_USER_PTE */
@@ -110,6 +124,12 @@ static inline pte_t *pte_tryget_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte_offset_map_lock(mm, pmd, address, ptlp);
 }
 
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned int nr)
+{
+	__pte_put_many(NULL, mm, pmd, addr, nr);
+}
+
 /*
  * pte_put - Decrement refcount for the PTE page table.
  * @mm: the mm_struct of the target address space.
@@ -120,7 +140,7 @@ static inline pte_t *pte_tryget_map_lock(struct mm_struct *mm, pmd_t *pmd,
  */
 static inline void pte_put(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 {
-	pte_put_many(mm, pmd, addr, 1);
+	__pte_put(NULL, mm, pmd, addr);
 }
 
 #endif
diff --git a/mm/madvise.c b/mm/madvise.c
index 5cf2832abb98..b51254305bb2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -477,7 +477,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
-	pte_put(vma->vm_mm, pmd, start);
+	__pte_put(tlb, vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -710,7 +710,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		__pte_put_many(tlb, mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 4d1ede78d1b0..1bdae3b0f877 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1469,7 +1469,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	}
 
 	if (nr_put)
-		pte_put_many(mm, pmd, start, nr_put);
+		__pte_put_many(tlb, mm, pmd, start, nr_put);
 
 	return addr;
 }
@@ -1515,7 +1515,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		if (pte_try_get(pmd))
 			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
-		pte_put(tlb->mm, pmd, addr);
+		__pte_put(tlb, tlb->mm, pmd, addr);
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
index 728e61cea25e..f9650ad23c7c 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -8,6 +8,8 @@
 #include <linux/pte_ref.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
 #ifdef CONFIG_FREE_USER_PTE
@@ -117,7 +119,8 @@ static void pte_free_rcu(struct rcu_head *rcu)
 	__free_page(page);
 }
 
-void free_user_pte_table(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+void free_user_pte_table(struct mmu_gather *tlb, struct mm_struct *mm,
+			 pmd_t *pmd, unsigned long addr)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
 	spinlock_t *ptl;
@@ -125,10 +128,14 @@ void free_user_pte_table(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 
 	ptl = pmd_lock(mm, pmd);
 	pmdval = pmdp_huge_get_and_clear(mm, addr, pmd);
-	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	if (!tlb)
+		flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	else
+		pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
 	spin_unlock(ptl);
 
 	pte_free_debug(pmdval);
 	mm_dec_nr_ptes(mm);
-	call_rcu(&pmd_pgtable(pmdval)->rcu_head, pte_free_rcu);
+	if (!tlb)
+		call_rcu(&pmd_pgtable(pmdval)->rcu_head, pte_free_rcu);
 }
-- 
2.11.0

