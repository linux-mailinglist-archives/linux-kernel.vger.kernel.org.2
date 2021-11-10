Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E212344BF38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKJK6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhKJK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59079C06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u17so2634262plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEkgVbZuVsA0FhlYXGGaJBi830ur6y858NAr5lK/SlI=;
        b=fDInN7lDg/WOd26P7ACBdvTx8SeMC7Ds7sXvURJA9gmFdDBbfrcR0a6J5AlvkegzCB
         A/BxGt0L/fuy21RUR5VlbRRybOHrySj7zuw015WCcRgHXeUQrwB3a1W/MBid9gOnPDkw
         JBp4l90W1LFmgq3oVLyf6TIZIDuVWw+tcEjaCub7DprpdrFSD2qakI8Re2BeCcyEsTXq
         gja6TuaztelGhb3BvANmH72PL+0NJ6G4Yynpd/WrTJ1H3xvcxo/36mnjYbVUzdznQS4U
         6tGstJXrl5BpzllHZ8E8ehMzvene9l1J7jJ8KL5uw6poPa9L8vGdRV+KDBrRDPLiYRkz
         Wxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEkgVbZuVsA0FhlYXGGaJBi830ur6y858NAr5lK/SlI=;
        b=fPOfegsv7kr2X1reYqeMrQyrPLdqai6eKig0XmVRxbnAm2DIFPbc66HSGSoaJBbkdl
         +u7IVg18I1w8CS8Ss+lVOlQQVIaM6ZHJI1kLuCFG6jumPu5YU96WgWxO6YNyTBcqmg8/
         M8fxLI6SY1oSnfl73nqav/gtNM7x9YdoqmnkNGoQEJ2VxkaqGdmT7fmOiXkT+Se0DyeP
         40r3nb29UFry7XJu+H4SU5ORFEgy2/C6DFhP9T03oxspRSOdpW9adgsurd1VZJcytd6+
         k+HCcTV8XNWqVlS12Y1zQVq83YZZwEKOVuDc2hM7CP28fdY2GUY9Unm/esAJj7YnjTrf
         O5nQ==
X-Gm-Message-State: AOAM530E1mcms7OhUGuboJ5d9i+eBOoTvT+vGMJS5jRUVstKK92SURRK
        oJwsfq2VS3kvJAyLvYAf87r0cw==
X-Google-Smtp-Source: ABdhPJzEQ/iU9FptzK8teQahqEayhIxvuxDSVPhhvBP66Hk7CNTA+H93MNXC4UqhOzmnr4h/baHdyA==
X-Received: by 2002:a17:90a:d583:: with SMTP id v3mr15985016pju.216.1636541754871;
        Wed, 10 Nov 2021 02:55:54 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:54 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 13/15] mm/pte_ref: free user PTE page table pages
Date:   Wed, 10 Nov 2021 18:54:26 +0800
Message-Id: <20211110105428.32458-14-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces CONFIG_FREE_USER_PTE option and
implements the actual logic to the dummy helpers about
pte_ref.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h      |  2 ++
 include/linux/pgtable.h |  3 +-
 include/linux/pte_ref.h | 53 ++++++++++++++++++++++++----
 mm/Kconfig              |  4 +++
 mm/debug_vm_pgtable.c   |  2 ++
 mm/memory.c             | 15 ++++++++
 mm/pte_ref.c            | 91 +++++++++++++++++++++++++++++++++++++++++++++----
 7 files changed, 156 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 753a9435e0d0..18fbf9e0996a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -437,6 +437,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PTE_GET: This means the refcount of the pte has been got.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -468,6 +469,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_PTE_GET =		1 << 10,
 };
 
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c8f045705c1e..6ac51d58f11a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -480,7 +480,6 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 }
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
@@ -491,6 +490,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return pmd;
 }
 #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index b6d8335bdc59..8a26eaba83ef 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -8,6 +8,7 @@
 #define _LINUX_PTE_REF_H
 
 #include <linux/pgtable.h>
+#include <linux/page-flags.h>
 
 enum pte_tryget_type {
 	TRYGET_SUCCESSED,
@@ -16,12 +17,49 @@ enum pte_tryget_type {
 	TRYGET_FAILED_HUGE_PMD,
 };
 
-bool pte_get_unless_zero(pmd_t *pmd);
-enum pte_tryget_type pte_try_get(pmd_t *pmd);
 void pte_put_vmf(struct vm_fault *vmf);
+enum pte_tryget_type pte_try_get(pmd_t *pmd);
+bool pte_get_unless_zero(pmd_t *pmd);
+
+#ifdef CONFIG_FREE_USER_PTE
+void free_user_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
 
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
 {
+	pte->pmd = pmd;
+	atomic_set(&pte->pte_refcount, count);
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return virt_to_page(pte)->pmd;
+}
+
+static inline void pte_update_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+	pmd_pgtable(old_pmd)->pmd = new_pmd;
+}
+
+static inline void pte_get_many(pmd_t *pmd, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmd);
+
+	VM_BUG_ON(!PageTable(pte));
+	atomic_add(nr, &pte->pte_refcount);
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmd);
+
+	VM_BUG_ON(!PageTable(pte));
+	if (atomic_sub_and_test(nr, &pte->pte_refcount))
+		free_user_pte_table(mm, pmd, addr & PMD_MASK);
+}
+#else
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
 }
 
 static inline pmd_t *pte_to_pmd(pte_t *pte)
@@ -37,6 +75,12 @@ static inline void pte_get_many(pmd_t *pmd, unsigned int nr)
 {
 }
 
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned int nr)
+{
+}
+#endif /* CONFIG_FREE_USER_PTE */
+
 /*
  * pte_get - Increment refcount for the PTE page table.
  * @pmd: a pointer to the pmd entry corresponding to the PTE page table.
@@ -66,11 +110,6 @@ static inline pte_t *pte_tryget_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte_offset_map_lock(mm, pmd, address, ptlp);
 }
 
-static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr, unsigned int nr)
-{
-}
-
 /*
  * pte_put - Decrement refcount for the PTE page table.
  * @mm: the mm_struct of the target address space.
diff --git a/mm/Kconfig b/mm/Kconfig
index 5c5508fafcec..44549d287869 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -898,6 +898,10 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config FREE_USER_PTE
+	def_bool y
+	depends on X86_64
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 52f006654664..757dd84ee254 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1049,8 +1049,10 @@ static void __init destroy_args(struct pgtable_debug_args *args)
 	/* Free page table entries */
 	if (args->start_ptep) {
 		pte_put(args->mm, args->start_pmdp, args->vaddr);
+#ifndef CONFIG_FREE_USER_PTE
 		pte_free(args->mm, args->start_ptep);
 		mm_dec_nr_ptes(args->mm);
+#endif
 	}
 
 	if (args->start_pmdp) {
diff --git a/mm/memory.c b/mm/memory.c
index e360ecd37a71..4d1ede78d1b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -219,6 +219,17 @@ static void check_sync_rss_stat(struct task_struct *task)
 
 #endif /* SPLIT_RSS_COUNTING */
 
+#ifdef CONFIG_FREE_USER_PTE
+static inline void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				  unsigned long addr)
+{
+	/*
+	 * We should never reach here since the PTE page tables are
+	 * dynamically freed.
+	 */
+	BUG();
+}
+#else
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
@@ -231,6 +242,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 	pte_free_tlb(tlb, token, addr);
 	mm_dec_nr_ptes(tlb->mm);
 }
+#endif /* CONFIG_FREE_USER_PTE */
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
@@ -4631,6 +4643,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			goto retry;
 		vmf->orig_pte = *vmf->pte;
 
+		if (IS_ENABLED(CONFIG_FREE_USER_PTE))
+			vmf->flags |= FAULT_FLAG_PTE_GET;
+
 		/*
 		 * some architectures can have larger ptes than wordsize,
 		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index de109905bc8f..728e61cea25e 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -7,7 +7,10 @@
 
 #include <linux/pte_ref.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <asm/tlbflush.h>
 
+#ifdef CONFIG_FREE_USER_PTE
 /*
  * pte_get_unless_zero - Increment refcount for the PTE page table
  *			 unless it is zero.
@@ -15,7 +18,10 @@
  */
 bool pte_get_unless_zero(pmd_t *pmd)
 {
-	return true;
+	pgtable_t pte = pmd_pgtable(*pmd);
+
+	VM_BUG_ON(!PageTable(pte));
+	return atomic_inc_not_zero(&pte->pte_refcount);
 }
 
 /*
@@ -32,12 +38,20 @@ bool pte_get_unless_zero(pmd_t *pmd)
  */
 enum pte_tryget_type pte_try_get(pmd_t *pmd)
 {
-	if (unlikely(pmd_none(*pmd)))
-		return TRYGET_FAILED_NONE;
-	if (unlikely(is_huge_pmd(*pmd)))
-		return TRYGET_FAILED_HUGE_PMD;
+	int retval = TRYGET_SUCCESSED;
+	pmd_t pmdval;
 
-	return TRYGET_SUCCESSED;
+	rcu_read_lock();
+	pmdval = READ_ONCE(*pmd);
+	if (unlikely(pmd_none(pmdval)))
+		retval = TRYGET_FAILED_NONE;
+	else if (unlikely(is_huge_pmd(pmdval)))
+		retval = TRYGET_FAILED_HUGE_PMD;
+	else if (!pte_get_unless_zero(&pmdval))
+		retval = TRYGET_FAILED_ZERO;
+	rcu_read_unlock();
+
+	return retval;
 }
 
 /*
@@ -52,4 +66,69 @@ enum pte_tryget_type pte_try_get(pmd_t *pmd)
  */
 void pte_put_vmf(struct vm_fault *vmf)
 {
+	if (!(vmf->flags & FAULT_FLAG_PTE_GET))
+		return;
+	vmf->flags &= ~FAULT_FLAG_PTE_GET;
+
+	pte_put(vmf->vma->vm_mm, vmf->pmd, vmf->address);
+}
+#else
+bool pte_get_unless_zero(pmd_t *pmd)
+{
+	return true;
+}
+
+enum pte_tryget_type pte_try_get(pmd_t *pmd)
+{
+	if (unlikely(pmd_none(*pmd)))
+		return TRYGET_FAILED_NONE;
+
+	if (unlikely(is_huge_pmd(*pmd)))
+		return TRYGET_FAILED_HUGE_PMD;
+
+	return TRYGET_SUCCESSED;
+}
+
+void pte_put_vmf(struct vm_fault *vmf)
+{
+}
+#endif /* CONFIG_FREE_USER_PTE */
+
+#ifdef CONFIG_DEBUG_VM
+static void pte_free_debug(pmd_t pmd)
+{
+	pte_t *ptep = (pte_t *)pmd_page_vaddr(pmd);
+	int i = 0;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		BUG_ON(!pte_none(*ptep++));
+}
+#else
+static inline void pte_free_debug(pmd_t pmd)
+{
+}
+#endif
+
+static void pte_free_rcu(struct rcu_head *rcu)
+{
+	struct page *page = container_of(rcu, struct page, rcu_head);
+
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
+void free_user_pte_table(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	spinlock_t *ptl;
+	pmd_t pmdval;
+
+	ptl = pmd_lock(mm, pmd);
+	pmdval = pmdp_huge_get_and_clear(mm, addr, pmd);
+	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	spin_unlock(ptl);
+
+	pte_free_debug(pmdval);
+	mm_dec_nr_ptes(mm);
+	call_rcu(&pmd_pgtable(pmdval)->rcu_head, pte_free_rcu);
 }
-- 
2.11.0

