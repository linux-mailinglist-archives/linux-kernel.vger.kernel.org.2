Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C744BF26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKJK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKJK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:57:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F7DC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1327795pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4diZW2wEVqXk2ndEsmrS3nCtcwwWuUKIRQnKQFgeem0=;
        b=COtsjIpr3BRI4gEAV+7KnRqUIb8utOtebdwXLB3m7llDg/5zahVoa8o/IYTsFOsyrt
         bUIWdwV5r/0pjidaepCIseNRFM+E0E5QARRz0HazoKmTrN6MPiiVAekvkdfnDHDHvTqZ
         LCqlKldesqC6ZTXQU3bHRP4HVHG224561nCXqbQs9nTBBfVqK6EIVuquYe6w9CUl1qdv
         XgAm3YwtQNpcvkHQHijJ1QcM6vzagO/Fr75N1VdhD1BLNpWknv5caWxHMLx8C2f/AfOT
         h5TD3ZnpTj+3o/S1h0K0+l144PNQ5Hd2WjyLns7T2rwte7KapCc6Zssao8NBJEKvgpC/
         2o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4diZW2wEVqXk2ndEsmrS3nCtcwwWuUKIRQnKQFgeem0=;
        b=Dp2w3H2f+gfdAKhVKpjhKU89PC3y/0Ge/22N5Q4C25D5uYIvO3cY0lqy6OS4YJjCJG
         TT3NnK+2TpoUahOO5b5XG5Ev50tOXmEW6apu1XKjHAtTuY2k6dzLWz9aQJ6mG/tLcETT
         ip7xHodjOY30Zp9lmVlK2NSyR6UiMlWEssbMZnATJmYPC0tZ5WO+gABZkbkH8938fcKq
         9pyD4+yZY1/DKWXiCo47dUF1CdMlKzwH/lL9uggJSjFdU5rme/YJoMwbv2d3LmsTssG/
         QfWOrOQqQWHeQ7y+Gmyag7SyoF9a6KGLKRzENN/cVatR2LEB8yzaUHVBNlplE4ECii7c
         5mjw==
X-Gm-Message-State: AOAM533BDrVU4aoySvrRJN5iDiVDNRDW5cdVLYv7R+1s4Ac0T4BJDvP4
        4zOcXQzJ8wIkqPLZi+ALEPYy1A==
X-Google-Smtp-Source: ABdhPJzQ+sHBFCJV0gr4TeSz2WlmbmXylJJw1YLnLOpTAEHwwUclKmLfFDkpfmt1JaAJ+7PoXM5DTw==
X-Received: by 2002:a17:902:b682:b0:143:7eb8:222 with SMTP id c2-20020a170902b68200b001437eb80222mr5397811pls.31.1636541707612;
        Wed, 10 Nov 2021 02:55:07 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:07 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 05/15] mm: add pmd_installed_type return for __pte_alloc() and other friends
Date:   Wed, 10 Nov 2021 18:54:18 +0800
Message-Id: <20211110105428.32458-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we call __pte_alloc() or other friends, a huge pmd might
be created from a different thread. This is why
pmd_trans_unstable() will now be called after __pte_alloc()
or other friends return.

This patch add pmd_installed_type return for __pte_alloc() and other
friends, then we can check the huge pmd through the return value
instead of calling pmd_trans_unstable() again.

This patch has no functional change, just some preparations
for the future patches.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h    | 20 +++++++++++++++++---
 mm/debug_vm_pgtable.c |  2 +-
 mm/filemap.c          | 11 +++++++----
 mm/gup.c              |  2 +-
 mm/internal.h         |  3 ++-
 mm/memory.c           | 39 ++++++++++++++++++++++++++-------------
 mm/migrate.c          | 17 ++---------------
 mm/mremap.c           |  2 +-
 mm/userfaultfd.c      | 24 +++++++++++++++---------
 9 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 706da081b9f8..52f36fde2f11 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2306,13 +2306,27 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
+enum pmd_installed_type {
+	INSTALLED_PTE,
+	INSTALLED_HUGE_PMD,
+};
+
+static inline int pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+{
+	if (unlikely(pmd_none(*(pmd))))
+		return __pte_alloc(mm, pmd);
+	if (unlikely(is_huge_pmd(*pmd)))
+		return INSTALLED_HUGE_PMD;
+
+	return INSTALLED_PTE;
+}
+#define pte_alloc pte_alloc
 
 #define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+	(pte_alloc(mm, pmd) < 0 ? NULL : pte_offset_map(pmd, address))
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	(pte_alloc(mm, pmd) ?			\
+	(pte_alloc(mm, pmd) < 0 ?			\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
 
 #define pte_alloc_kernel(pmd, address)			\
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 228e3954b90c..b8322c55e65d 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1170,7 +1170,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	args->start_pmdp = pmd_offset(args->pudp, 0UL);
 	WARN_ON(!args->start_pmdp);
 
-	if (pte_alloc(args->mm, args->pmdp)) {
+	if (pte_alloc(args->mm, args->pmdp) < 0) {
 		pr_err("Failed to allocate pte entries\n");
 		ret = -ENOMEM;
 		goto error;
diff --git a/mm/filemap.c b/mm/filemap.c
index ff8d19b7ce1d..23363f8ddbbe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3217,12 +3217,15 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		}
 	}
 
-	if (pmd_none(*vmf->pmd))
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+	if (pmd_none(*vmf->pmd)) {
+		int ret = pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
+		if (unlikely(ret == INSTALLED_HUGE_PMD))
+			goto out;
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		/* See comment in handle_pte_fault() */
 		goto out;
+	}
 
 	return false;
 
diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..2def775232a3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -699,7 +699,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		} else {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmd, address);
-			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
+			ret = pte_alloc(mm, pmd) < 0 ? -ENOMEM : 0;
 		}
 
 		return ret ? ERR_PTR(ret) :
diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..474d6e3443f8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -67,7 +67,8 @@ bool __folio_end_writeback(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+enum pmd_installed_type pmd_install(struct mm_struct *mm, pmd_t *pmd,
+				    pgtable_t *pte);
 
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
diff --git a/mm/memory.c b/mm/memory.c
index bec6a5d5ee7c..8a39c0e58324 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -437,8 +437,10 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+enum pmd_installed_type pmd_install(struct mm_struct *mm, pmd_t *pmd,
+				    pgtable_t *pte)
 {
+	int ret = INSTALLED_PTE;
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
@@ -459,20 +461,26 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 		pmd_populate(mm, pmd, *pte);
 		*pte = NULL;
+	} else if (is_huge_pmd(*pmd)) {
+		/* See comment in handle_pte_fault() */
+		ret = INSTALLED_HUGE_PMD;
 	}
 	spin_unlock(ptl);
+
+	return ret;
 }
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 {
+	enum pmd_installed_type ret;
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, &new);
+	ret = pmd_install(mm, pmd, &new);
 	if (new)
 		pte_free(mm, new);
-	return 0;
+	return ret;
 }
 
 int __pte_alloc_kernel(pmd_t *pmd)
@@ -1813,7 +1821,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	/* Allocate the PTE if necessary; takes PMD lock once only. */
 	ret = -ENOMEM;
-	if (pte_alloc(mm, pmd))
+	if (pte_alloc(mm, pmd) < 0)
 		goto out;
 
 	while (pages_to_write_in_pmd) {
@@ -3713,6 +3721,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	struct page *page;
 	vm_fault_t ret = 0;
 	pte_t entry;
+	int alloc_ret;
 
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -3728,11 +3737,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
+	alloc_ret = pte_alloc(vma->vm_mm, vmf->pmd);
+	if (alloc_ret < 0)
 		return VM_FAULT_OOM;
-
 	/* See comment in handle_pte_fault() */
-	if (unlikely(pmd_trans_unstable(vmf->pmd)))
+	if (unlikely(alloc_ret == INSTALLED_HUGE_PMD))
 		return 0;
 
 	/* Use the zero-page for reads */
@@ -4023,6 +4032,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	}
 
 	if (pmd_none(*vmf->pmd)) {
+		int alloc_ret;
+
 		if (PageTransCompound(page)) {
 			ret = do_set_pmd(vmf, page);
 			if (ret != VM_FAULT_FALLBACK)
@@ -4030,14 +4041,16 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
-	}
+			alloc_ret = pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+		else
+			alloc_ret = pte_alloc(vma->vm_mm, vmf->pmd);
 
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
+		if (unlikely(alloc_ret != INSTALLED_PTE))
+			return alloc_ret < 0 ? VM_FAULT_OOM : 0;
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		/* See comment in handle_pte_fault() */
 		return 0;
+	}
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..bdfdfd3b50be 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2731,21 +2731,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
 		goto abort;
 
-	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
-	 * pte_offset_map() on pmds where a huge pmd might be created
-	 * from a different thread.
-	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
-	 * parallel threads are excluded by other means.
-	 *
-	 * Here we only have mmap_read_lock(mm).
-	 */
-	if (pte_alloc(mm, pmdp))
-		goto abort;
-
-	/* See the comment in pte_alloc_one_map() */
-	if (unlikely(pmd_trans_unstable(pmdp)))
+	/* See the comment in do_anonymous_page() */
+	if (unlikely(pte_alloc(mm, pmdp) != INSTALLED_PTE))
 		goto abort;
 
 	if (unlikely(anon_vma_prepare(vma)))
diff --git a/mm/mremap.c b/mm/mremap.c
index c6e9da09dd0a..fc5c56858883 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -551,7 +551,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				continue;
 		}
 
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(new_vma->vm_mm, new_pmd) < 0)
 			break;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0780c2a57ff1..2cea08e7f076 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -592,15 +592,21 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			err = -EEXIST;
 			break;
 		}
-		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
-			err = -ENOMEM;
-			break;
-		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
-			err = -EFAULT;
-			break;
+
+		if (unlikely(pmd_none(dst_pmdval))) {
+			int ret = __pte_alloc(dst_mm, dst_pmd);
+
+			/*
+			 * If there is not enough memory or an huge pmd
+			 * materialized from under us
+			 */
+			if (unlikely(ret < 0)) {
+				err = -ENOMEM;
+				break;
+			} else if (unlikely(ret == INSTALLED_HUGE_PMD)) {
+				err = -EFAULT;
+				break;
+			}
 		}
 
 		BUG_ON(pmd_none(*dst_pmd));
-- 
2.11.0

