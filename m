Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD93F1175
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhHSDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhHSDUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:20:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so3883813pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOJy7d3mMHwvnCJysEKs+l/IQmr3k7czrKmvR87Rq+Y=;
        b=ZQtPcDfT/IvJ0lwmDwNMUvKubfxsfdrSWJTX/Gyl20U7Bj8zWdMmAiyW4sP1seBT41
         gZIooZB7ch001lCJCH2ckerONpSyV5p8Je2yJ6eo4vjFpaJxp0DWG8c/eiA5g7s/dGaZ
         JtRu4quV5wLxRc9tM4UGEuBc43812xdRVPM7L81ugs34foHzwTt9qgu6eb7hZn7XBUKX
         Fuz04duulFSLI7saoBwqk3QS47Y0BTIniWSs0WUJPK21KoQItsDaaHIr8M1YFqwrWWFF
         kziYc+T7nV+iHv+IOcONPKLBMRERYmbnAJdS4FTuR2jTo3XU9Cx+G7dtXBSTlkfVgJkq
         vH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOJy7d3mMHwvnCJysEKs+l/IQmr3k7czrKmvR87Rq+Y=;
        b=szPRho7V4LxhSOcxkgELhSXlDBvtdVXERhOvfBaogVXoCDyUGj05lY8Mwg2ieS8/pr
         rUDXhF7UZ+d/UwFQBK+jSrClj9Z1Vw++LhutaX0HWMrK9g+pWYe9A2KawROQKLThwl0t
         GctpQ42NGoXsJgCAgh8CvBuWEDjvt5pIb6MnjW64gIASYVl4QZ8LOkMFEBVLoU8a666N
         fT88eCDtmhiXIAtUopXmqEMD2QoP9v/C3Zvxx+C1cX3uX1D3laP2QX5twLZgntji7FkK
         TjjF/XZa3ZIt1I7ucaM6nuJSKiu+qcXrt6hVdpcvenuQwqcbXaVGdsO+j+aXbxmWcF1g
         FotA==
X-Gm-Message-State: AOAM530jtliGRL6d/tuBwPs6vVd9LaAGZiv9C/jy+oWIzn7QyzDbtK66
        9Xhsf8D56dzK/75YlZFnqJigeA==
X-Google-Smtp-Source: ABdhPJwEZ4RGOFInOKpqGaEMoIBV8Dz6mSB99TTKJzOR8VkbejafmMz0iT7mYo7EUQgIqYstfbLNlw==
X-Received: by 2002:a17:90a:5d12:: with SMTP id s18mr10115629pji.35.1629343216801;
        Wed, 18 Aug 2021 20:20:16 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:16 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 5/9] mm: pte_refcount infrastructure
Date:   Thu, 19 Aug 2021 11:18:54 +0800
Message-Id: <20210819031858.98043-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, we add two fields to the struct page of PTE page
table, the pte_refcount is used to track how many users of PTE
page table, the pmd is used to record the pmd entry which is
populated by the PTE. And we introduce some APIs that will be
used in subsequent patches:

The following are some APIs related to ->pte_refcount:

	pte_get{,_many}()
	pte_put{,_many,_vmf}()
	pte_try_get()

And we add pte_alloc_get{,_map,_map_lock}(), the semantics of
these function is to hold a pte_refcount count when it returns 0,
and its caller is responsible for decrease the pte_refcount by
calling pte_put(), like the following pattern:

	--> pte_alloc_get()

	    do something about pte

	    pte_put()

This patch contains no functional changes, just creates some
infrastructure, and we will use these in the next patch.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_types.h |   8 +-
 include/linux/pgtable.h  |   3 +-
 include/linux/pte_ref.h  | 208 ++++++++++++++++++++++++++++++++++++++++++++++-
 mm/Kconfig               |   4 +
 mm/memory.c              |   8 +-
 mm/pte_ref.c             |  59 ++++++++++++--
 mm/sparse-vmemmap.c      |   2 +-
 7 files changed, 279 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b9aa9aa99924..85c5cc4b95b3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -161,11 +161,17 @@ struct page {
 		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			union {
+				pgtable_t pmd_huge_pte; /* protected by page->ptl */
+				pmd_t *pmd;             /* PTE page only */
+			};
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+#ifdef CONFIG_FREE_USER_PTE
+				atomic_t pte_refcount;  /* PTE page only */
+#endif
 			};
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..c799475bc5c9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -331,7 +331,6 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 }
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
@@ -342,6 +341,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return pmd;
 }
 #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address,
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index 60b752dd7846..47aaeac7507e 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -15,6 +15,8 @@
 
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
+void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd);
 
 #define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
 
@@ -25,5 +27,209 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 	(pte_alloc(mm, pmd) ?				\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
 
-#endif
+#ifdef CONFIG_FREE_USER_PTE
+
+void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr);
+
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
+	pte->pmd = pmd;
+	atomic_set(&pte->pte_refcount, count);
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return virt_to_page(pte)->pmd;
+}
+
+static inline void pte_migrate_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+	pmd_pgtable(old_pmd)->pmd = new_pmd;
+}
+
+static inline void pte_get_many(pmd_t *pmdp, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
+
+	VM_BUG_ON(!PageTable(pte));
+	atomic_add(nr, &pte->pte_refcount);
+}
+
+/*
+ * pte_get - Increment ->pte_refcount for the PTE page table.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ *
+ * Similar to the mechanism of page refcount, the user of PTE page table
+ * should hold a refcount to it before accessing.
+ */
+static inline void pte_get(pmd_t *pmdp)
+{
+	pte_get_many(pmdp, 1);
+}
+
+/*
+ * pte_get_unless_zero - Increment ->pte_refcount for the PTE page table
+ *			 unless it is zero.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ */
+static inline bool pte_get_unless_zero(pmd_t *pmdp)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
 
+	VM_BUG_ON(!PageTable(pte));
+	return atomic_inc_not_zero(&pte->pte_refcount);
+}
+
+/*
+ * pte_try_get - Try to increment ->pte_refcount for the PTE page table.
+ * @mm: the mm_struct of the target address space.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ *
+ * Return true if the increment succeeded. Otherwise return false.
+ *
+ * Before Operating the PTE page table, we need to hold a ->pte_refcount
+ * to protect against the concurrent release of the PTE page table.
+ */
+static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	bool retval = true;
+	spinlock_t *ptl;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (!pmd_present(*pmdp) || !pte_get_unless_zero(pmdp))
+		retval = false;
+	spin_unlock(ptl);
+
+	return retval;
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
+				unsigned long addr, unsigned int nr)
+{
+	pgtable_t pte = pmd_pgtable(*pmdp);
+
+	VM_BUG_ON(!PageTable(pte));
+	if (atomic_sub_and_test(nr, &pte->pte_refcount))
+		free_pte_table(mm, pmdp, addr & PMD_MASK);
+}
+
+/*
+ * pte_put - Decrement ->pte_refcount for the PTE page table.
+ * @mm: the mm_struct of the target address space.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ * @addr: the start address of the tlb range to be flushed.
+ *
+ * The PTE page table page will be freed when the last refcount is dropped.
+ */
+static inline void pte_put(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+	pte_put_many(mm, pmdp, addr, 1);
+}
+
+/*
+ * pte_put_vmf - Decrement ->pte_refcount for the PTE page table.
+ * @vmf: fault information
+ *
+ * While we access ->pte_refcount of a PTE page table, any of the following
+ * ensures the pmd entry corresponding to the PTE page table stability:
+ * 	- mmap_lock
+ * 	- anon_lock
+ * 	- i_mmap_lock
+ * 	- parallel threads are excluded by other means which
+ * 	  can make ->pmd stable(e.g. gup case)
+ * But the mmap_lock maybe unlocked in advance in some cases in
+ * handle_pte_fault(), so we should ensure the pte_put() is performed
+ * in the critical section of the mmap_lock.
+ */
+static inline void pte_put_vmf(struct vm_fault *vmf)
+{
+	if (!(vmf->flags & FAULT_FLAG_PTE_GET))
+		return;
+	vmf->flags &= ~FAULT_FLAG_PTE_GET;
+
+	pte_put(vmf->vma->vm_mm, vmf->pmd, vmf->address);
+}
+
+/*
+ * pte_alloc_get - allocate a PTE page table if the pmd entry is none, and
+ *		   hold a ->pte_refcount when returning
+ * @mm: the mm_struct of the target address space.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ */
+static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	spinlock_t *ptl;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (pmd_none(*pmdp) || !pte_get_unless_zero(pmdp)) {
+		spin_unlock(ptl);
+		return __pte_alloc_get(mm, pmdp);
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+
+#define pte_alloc_get_map(mm, pmd, address)			\
+	(pte_alloc_get(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+
+#define pte_alloc_get_map_lock(mm, pmd, address, ptlp)		\
+	(pte_alloc_get(mm, pmd) ?				\
+		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
+#else
+static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
+{
+}
+
+static inline pmd_t *pte_to_pmd(pte_t *pte)
+{
+	return NULL;
+}
+
+static inline void pte_migrate_pmd(pmd_t old_pmd, pmd_t *new_pmd)
+{
+}
+
+static inline void pte_get_many(pmd_t *pmdp, unsigned int nr)
+{
+}
+
+static inline void pte_get(pmd_t *pmdp)
+{
+}
+
+static inline bool pte_get_unless_zero(pmd_t *pmdp)
+{
+	return true;
+}
+
+static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	return true;
+}
+
+static inline void pte_put_many(struct mm_struct *mm, pmd_t *pmdp,
+				unsigned long addr, unsigned int value)
+{
+}
+
+static inline void pte_put(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+}
+
+static inline void pte_put_vmf(struct vm_fault *vmf)
+{
+}
+
+static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	return pte_alloc(mm, pmdp);
+}
+
+#define pte_alloc_get_map(mm, pmd, address)			\
+	pte_alloc_map(mm, pmd, address)
+
+#define pte_alloc_get_map_lock(mm, pmd, address, ptlp)		\
+	pte_alloc_map_lock(mm, pmd, address, ptlp)
+#endif /* CONFIG_FREE_USER_PTE */
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 50ca602edeb6..fb16ecebcb80 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -894,6 +894,10 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config FREE_USER_PTE
+	def_bool y
+	depends on X86_64 && !TRANSPARENT_HUGEPAGE
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/memory.c b/mm/memory.c
index 265b841cc7f9..d1efb868e682 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -441,7 +441,7 @@ int __pte_alloc_kernel(pmd_t *pmd)
 
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		smp_wmb(); /* See comment in pmd_install() */
+		smp_wmb(); /* See comment in pmd_install_get() */
 		pmd_populate_kernel(&init_mm, pmd, new);
 		new = NULL;
 	}
@@ -4780,7 +4780,7 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	if (pgd_present(*pgd))		/* Another has populated it */
 		p4d_free(mm, new);
 	else {
-		smp_wmb(); /* See comment in pmd_install() */
+		smp_wmb(); /* See comment in pmd_install_get() */
 		pgd_populate(mm, pgd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -4802,7 +4802,7 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 	spin_lock(&mm->page_table_lock);
 	if (!p4d_present(*p4d)) {
 		mm_inc_nr_puds(mm);
-		smp_wmb(); /* See comment in pmd_install() */
+		smp_wmb(); /* See comment in pmd_install_get() */
 		p4d_populate(mm, p4d, new);
 	} else	/* Another has populated it */
 		pud_free(mm, new);
@@ -4826,7 +4826,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	ptl = pud_lock(mm, pud);
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
-		smp_wmb(); /* See comment in pmd_install() */
+		smp_wmb(); /* See comment in pmd_install_get() */
 		pud_populate(mm, pud, new);
 	} else	/* Another has populated it */
 		pmd_free(mm, new);
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 07a73b5521cc..630704ae26db 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -8,12 +8,47 @@
  */
 
 #include <linux/pte_ref.h>
+#include <linux/hugetlb.h>
+#include <asm/tlbflush.h>
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
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
+void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	ptl = pmd_lock(mm, pmdp);
+	pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
+	spin_unlock(ptl);
+
+	pte_free_debug(pmd);
+	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(pmd));
+}
+
+void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 {
-	spinlock_t *ptl = pmd_lock(mm, pmd);
+	spinlock_t *ptl;
 
-	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+retry:
+	ptl = pmd_lock(mm, pmd);
+	if (likely(pmd_none(*pmd))) {
 		mm_inc_nr_ptes(mm);
 		/*
 		 * Ensure all pte setup (eg. pte page lock and page clearing) are
@@ -30,19 +65,33 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 */
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 		pmd_populate(mm, pmd, *pte);
+		pte_ref_init(*pte, pmd, 1);
 		*pte = NULL;
+	} else if (!pte_get_unless_zero(pmd)) {
+		spin_unlock(ptl);
+		goto retry;
 	}
 	spin_unlock(ptl);
 }
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	pmd_install_get(mm, pmd, pte);
+}
+
+int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, &new);
+	pmd_install_get(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
 	return 0;
 }
+
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+{
+	return __pte_alloc_get(mm, pmd);
+}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index db6df27c852a..818c82ee3c6e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -76,7 +76,7 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in pmd_install(). */
+	/* Make pte visible before pmd. See comment in pmd_install_get(). */
 	smp_wmb();
 	pmd_populate_kernel(&init_mm, pmd, pgtable);
 
-- 
2.11.0

