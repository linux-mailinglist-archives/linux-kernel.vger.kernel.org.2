Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A844BD21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhKJIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhKJIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:44:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA50C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:41:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so1675923pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MsbkM47+d/dKbMtk5lgpAD1nJiQP3KKT2CTa5NSKic=;
        b=GuFa/5BcXtMLjpHuNLAp2Mnf/7GkFL52x24pA3lEgtCnzLHWO5lTrLy51FIHsdt83B
         4imAZ63u/gZvnnmGR/psKmQLnCcmy0pR+MSpEqCiwKmZoAAgqdagxW17FZJpE6hhc7gO
         vVPel1rnEia8H5kQnGCtX/aNkXSC5QBlkHBoVhopYid3AafHIc5Y1R/9hWqNLAfg2VBK
         iJep1gtL33gnVF3YHiQ+iKrN6q182/+lVLZtdGNZ3gJYAztjDVfH7sAym3JKK9CE/9WA
         DTkAC42KcZ4N8vetclu+iZF+7aH3SqB4sOaPmrg8gAvaojycy/TExfSmkqNlHZp5HKS2
         /9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MsbkM47+d/dKbMtk5lgpAD1nJiQP3KKT2CTa5NSKic=;
        b=QP+bqxqJouZ/aiu8p+yVfdh2LZx5MToDwB+XJNvOCCpaWTs27OvRslyjNkh4iLxj8H
         qAOZjUS6Eaq+idsLgNJsusl9JU904jsvsh5J2PmORrdEU+TMjVPjyZyzKwop4D6KP+CE
         RABj//OIxcEwr+ZQpTuR/hzZqokYt2pacKt1MB0rKnrwMeUNd8j0bWPeH8UvYG7Dpjov
         7SsokftpP6E10EjUFxQADMquYZ6Ajhjx9UJdN9nqTz9/9UKOGp2cZdvlrwVcP2wrzvsi
         gHbqgwStnvUJnJfXm5WIzWktZrEdffMpAEmQ9nToTvOOO3KdTAaYrDd4ZvqRvWQBtQxe
         0JVQ==
X-Gm-Message-State: AOAM533QK8vDqK3yJ2LurVqYEhqzktcQQ0aEicmnNS+awNyT9aq1x2th
        2zRIT4w8gEgfYl8vSSA/kLGOQQ==
X-Google-Smtp-Source: ABdhPJyPCEn8p6Ohih2He2iy9+cyYyAw6gzc+KNszWRgtMh1Y+BFZ0nU8LGE69AIg/v7UjCdnutsNA==
X-Received: by 2002:a63:30a:: with SMTP id 10mr10531729pgd.229.1636533706058;
        Wed, 10 Nov 2021 00:41:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5485368pgl.38.2021.11.10.00.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:41:45 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 03/15] mm: move pte_offset_map_lock() to pgtable.h
Date:   Wed, 10 Nov 2021 16:40:45 +0800
Message-Id: <20211110084057.27676-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_offset_map() is in include/linux/pgtable.h, so move its
friend pte_offset_map_lock() to pgtable.h together.

pte_lockptr() is required for pte_offset_map_lock(), so
also move {pte,pmd,pud}_lockptr() to pgtable.h.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h      | 149 ------------------------------------------------
 include/linux/pgtable.h | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..706da081b9f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2284,70 +2284,6 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 }
 #endif /* CONFIG_MMU */
 
-#if USE_SPLIT_PTE_PTLOCKS
-#if ALLOC_SPLIT_PTLOCKS
-void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
-extern void ptlock_free(struct page *page);
-
-static inline spinlock_t *ptlock_ptr(struct page *page)
-{
-	return page->ptl;
-}
-#else /* ALLOC_SPLIT_PTLOCKS */
-static inline void ptlock_cache_init(void)
-{
-}
-
-static inline bool ptlock_alloc(struct page *page)
-{
-	return true;
-}
-
-static inline void ptlock_free(struct page *page)
-{
-}
-
-static inline spinlock_t *ptlock_ptr(struct page *page)
-{
-	return &page->ptl;
-}
-#endif /* ALLOC_SPLIT_PTLOCKS */
-
-static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
-{
-	return ptlock_ptr(pmd_page(*pmd));
-}
-
-static inline bool ptlock_init(struct page *page)
-{
-	/*
-	 * prep_new_page() initialize page->private (and therefore page->ptl)
-	 * with 0. Make sure nobody took it in use in between.
-	 *
-	 * It can happen if arch try to use slab for page table allocation:
-	 * slab code uses page->slab_cache, which share storage with page->ptl.
-	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
-		return false;
-	spin_lock_init(ptlock_ptr(page));
-	return true;
-}
-
-#else	/* !USE_SPLIT_PTE_PTLOCKS */
-/*
- * We use mm->page_table_lock to guard all pagetable pages of the mm.
- */
-static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
-{
-	return &mm->page_table_lock;
-}
-static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
-static inline void ptlock_free(struct page *page) {}
-#endif /* USE_SPLIT_PTE_PTLOCKS */
-
 static inline void pgtable_init(void)
 {
 	ptlock_cache_init();
@@ -2370,20 +2306,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
-#define pte_offset_map_lock(mm, pmd, address, ptlp)	\
-({							\
-	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
-	pte_t *__pte = pte_offset_map(pmd, address);	\
-	*(ptlp) = __ptl;				\
-	spin_lock(__ptl);				\
-	__pte;						\
-})
-
-#define pte_unmap_unlock(pte, ptl)	do {		\
-	spin_unlock(ptl);				\
-	pte_unmap(pte);					\
-} while (0)
-
 #define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
 
 #define pte_alloc_map(mm, pmd, address)			\
@@ -2397,58 +2319,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
 
-#if USE_SPLIT_PMD_PTLOCKS
-
-static struct page *pmd_to_page(pmd_t *pmd)
-{
-	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	return virt_to_page((void *)((unsigned long) pmd & mask));
-}
-
-static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
-{
-	return ptlock_ptr(pmd_to_page(pmd));
-}
-
-static inline bool pmd_ptlock_init(struct page *page)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
-#endif
-	return ptlock_init(page);
-}
-
-static inline void pmd_ptlock_free(struct page *page)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
-#endif
-	ptlock_free(page);
-}
-
-#define pmd_huge_pte(mm, pmd) (pmd_to_page(pmd)->pmd_huge_pte)
-
-#else
-
-static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
-{
-	return &mm->page_table_lock;
-}
-
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
-
-#define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
-
-#endif
-
-static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
-{
-	spinlock_t *ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
-	return ptl;
-}
-
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
@@ -2465,25 +2335,6 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
-/*
- * No scalability reason to split PUD locks yet, but follow the same pattern
- * as the PMD locks to make it easier if we decide to.  The VM should not be
- * considered ready to switch to split PUD locks yet; there may be places
- * which need to be converted from page_table_lock.
- */
-static inline spinlock_t *pud_lockptr(struct mm_struct *mm, pud_t *pud)
-{
-	return &mm->page_table_lock;
-}
-
-static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
-{
-	spinlock_t *ptl = pud_lockptr(mm, pud);
-
-	spin_lock(ptl);
-	return ptl;
-}
-
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..c8f045705c1e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -84,6 +84,141 @@ static inline unsigned long pud_index(unsigned long address)
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #endif
 
+#if USE_SPLIT_PTE_PTLOCKS
+#if ALLOC_SPLIT_PTLOCKS
+void __init ptlock_cache_init(void);
+extern bool ptlock_alloc(struct page *page);
+extern void ptlock_free(struct page *page);
+
+static inline spinlock_t *ptlock_ptr(struct page *page)
+{
+	return page->ptl;
+}
+#else /* ALLOC_SPLIT_PTLOCKS */
+static inline void ptlock_cache_init(void)
+{
+}
+
+static inline bool ptlock_alloc(struct page *page)
+{
+	return true;
+}
+
+static inline void ptlock_free(struct page *page)
+{
+}
+
+static inline spinlock_t *ptlock_ptr(struct page *page)
+{
+	return &page->ptl;
+}
+#endif /* ALLOC_SPLIT_PTLOCKS */
+
+static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
+{
+	return ptlock_ptr(pmd_page(*pmd));
+}
+
+static inline bool ptlock_init(struct page *page)
+{
+	/*
+	 * prep_new_page() initialize page->private (and therefore page->ptl)
+	 * with 0. Make sure nobody took it in use in between.
+	 *
+	 * It can happen if arch try to use slab for page table allocation:
+	 * slab code uses page->slab_cache, which share storage with page->ptl.
+	 */
+	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
+	if (!ptlock_alloc(page))
+		return false;
+	spin_lock_init(ptlock_ptr(page));
+	return true;
+}
+
+#else	/* !USE_SPLIT_PTE_PTLOCKS */
+/*
+ * We use mm->page_table_lock to guard all pagetable pages of the mm.
+ */
+static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
+{
+	return &mm->page_table_lock;
+}
+static inline void ptlock_cache_init(void) {}
+static inline bool ptlock_init(struct page *page) { return true; }
+static inline void ptlock_free(struct page *page) {}
+#endif /* USE_SPLIT_PTE_PTLOCKS */
+
+#if USE_SPLIT_PMD_PTLOCKS
+
+static struct page *pmd_to_page(pmd_t *pmd)
+{
+	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
+	return virt_to_page((void *)((unsigned long) pmd & mask));
+}
+
+static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
+{
+	return ptlock_ptr(pmd_to_page(pmd));
+}
+
+static inline bool pmd_ptlock_init(struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	page->pmd_huge_pte = NULL;
+#endif
+	return ptlock_init(page);
+}
+
+static inline void pmd_ptlock_free(struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+#endif
+	ptlock_free(page);
+}
+
+#define pmd_huge_pte(mm, pmd) (pmd_to_page(pmd)->pmd_huge_pte)
+
+#else
+
+static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
+{
+	return &mm->page_table_lock;
+}
+
+static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline void pmd_ptlock_free(struct page *page) {}
+
+#define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
+
+#endif
+
+static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
+{
+	spinlock_t *ptl = pmd_lockptr(mm, pmd);
+	spin_lock(ptl);
+	return ptl;
+}
+
+/*
+ * No scalability reason to split PUD locks yet, but follow the same pattern
+ * as the PMD locks to make it easier if we decide to.  The VM should not be
+ * considered ready to switch to split PUD locks yet; there may be places
+ * which need to be converted from page_table_lock.
+ */
+static inline spinlock_t *pud_lockptr(struct mm_struct *mm, pud_t *pud)
+{
+	return &mm->page_table_lock;
+}
+
+static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
+{
+	spinlock_t *ptl = pud_lockptr(mm, pud);
+
+	spin_lock(ptl);
+	return ptl;
+}
+
 #ifndef pte_offset_kernel
 static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 {
@@ -102,6 +237,20 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #define pte_unmap(pte) ((void)(pte))	/* NOP */
 #endif
 
+#define pte_offset_map_lock(mm, pmd, address, ptlp)	\
+({							\
+	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
+	pte_t *__pte = pte_offset_map(pmd, address);	\
+	*(ptlp) = __ptl;				\
+	spin_lock(__ptl);				\
+	__pte;						\
+})
+
+#define pte_unmap_unlock(pte, ptl)	do {		\
+	spin_unlock(ptl);				\
+	pte_unmap(pte);					\
+} while (0)
+
 /* Find an entry in the second-level page table.. */
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
-- 
2.11.0

