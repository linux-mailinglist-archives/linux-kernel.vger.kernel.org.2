Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA73CC791
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhGREeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhGREeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:34:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9B5C061766
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so9852516pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecbJ8mi6zoEc51yjzESaLgqsnEwjBh4X3ABuueto7F8=;
        b=ZuDwtlhwFRtm1aW6kY2PK/Yh/k7762C1G2XUDh/ojUpsya9FRxD2CjVdimS7/AEIXD
         BCX84otqYKD2wbPDJUc5qbhwhfroP6SrEUu/bjxxDBpS76KpvpgbdABKXhous56eqLNo
         Vy8cSmpnZZ6WYk/DkNNO/u4gKGGfhK4xzMaoMXZua9Lj27o4NGxyxMKglvgSksRhewXM
         navCp5qFv+EqcJax7uvaew9rcMgR2oEfi1QCxVDUuvc1HI6udNhhUzEvYypoahKAKSbQ
         3xAYYuf+t9PufL1T8f/BOXpaxyuo+19TySDNxcM/ZQ0ndLyytUs9DSueBCRMaiYEbJmC
         nOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecbJ8mi6zoEc51yjzESaLgqsnEwjBh4X3ABuueto7F8=;
        b=BL2e1jUSdIS5CZB2+oZNaFcI8uiWA9V0ho9qtzhAFxAEXFzYRKAEQHRlbMh2lT++k8
         vetoqOWsDyCJx+Yb32xnesyAOx4vqRNw9cwhsv/+Sl3y3nz4BPaTdTwyUes8QSG3lb9E
         GePBvHX56poD8wXk7GEOe00kR+J9qmRXhVmTmDPDYT+RoLXAuFRZ00ueopL7PI1qlHKZ
         uA2ThpxIGySjPYQpmouTjxoLjCj/eQDFSDmzmm1MeJVwB9viTv0fQOmlnkhFQkPUjg5s
         dvUIiEErKuUgAZLPoPcMpTPUeNxAekATXy6VfAlCoF8FpTkXX0yxpSF/0HFIekjfXvoZ
         jI/g==
X-Gm-Message-State: AOAM532b4XFknGJJO8aRac3tk7xnHWK0KeB4ay2iQFZLwH2CWyldaFwq
        no4wx5TaScIUkAbaLzQ26d4Z5Q==
X-Google-Smtp-Source: ABdhPJzJPQ1DUXa1r2tFDvkSeq/ehIWPeoE/10RXBNHIMrf/nzmYZknFiDLlMba+X3KOOehdmkAA5g==
X-Received: by 2002:a17:90a:bd06:: with SMTP id y6mr18072358pjr.6.1626582676021;
        Sat, 17 Jul 2021 21:31:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:31:15 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 6/7] mm: defer freeing PTE page table for a grace period
Date:   Sun, 18 Jul 2021 12:30:32 +0800
Message-Id: <20210718043034.76431-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With rcu_read_lock(), the release of the PTE page table
can be postponed. So we don't need to hold the pmd lock
anymore when we do pte_try_get()/pte_alloc_get(), which
can improve performance and simplify code logic.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/task_mmu.c      |  8 ++++----
 include/linux/pte_ref.h | 28 +++++++++++++++-------------
 mm/gup.c                |  2 +-
 mm/hmm.c                |  2 +-
 mm/khugepaged.c         |  4 ++--
 mm/ksm.c                |  2 +-
 mm/madvise.c            |  6 +++---
 mm/memcontrol.c         |  4 ++--
 mm/memory.c             | 14 +++++++-------
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 mm/mincore.c            |  2 +-
 mm/mprotect.c           |  2 +-
 mm/page_vma_mapped.c    |  2 +-
 mm/pagewalk.c           |  2 +-
 mm/pte_ref.c            | 10 +++++++++-
 mm/swapfile.c           |  2 +-
 17 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b3cf4b8a91d6..f3c9c984bc29 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -584,7 +584,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	}
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
-	    !pte_try_get(vma->vm_mm, pmd))
+	    !pte_try_get(pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
@@ -1148,7 +1148,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
-	    !pte_try_get(vma->vm_mm, pmd))
+	    !pte_try_get(pmd))
 		return 0;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -1482,7 +1482,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	if (!pte_try_get(walk->mm, pmdp))
+	if (!pte_try_get(pmdp))
 		return 0;
 
 	/*
@@ -1824,7 +1824,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 #endif
-	if (!pte_try_get(walk->mm, pmd))
+	if (!pte_try_get(pmd))
 		return 0;
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index 695fbe8b991b..f4d20faab684 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -74,16 +74,17 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
  * i_mmap_lock or when parallel threads are excluded by other means
  * which can make @pmdp entry stable.
  */
-static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+static inline bool pte_try_get(pmd_t *pmdp)
 {
 	bool retval = true;
-	spinlock_t *ptl;
+	pmd_t pmdval;
 
-	ptl = pmd_lock(mm, pmdp);
-	if (pmd_leaf(*pmdp) || !pmd_present(*pmdp) ||
-	    !pte_get_unless_zero(pmdp))
+	rcu_read_lock();
+	pmdval = READ_ONCE(*pmdp);
+	if (pmd_leaf(pmdval) || !pmd_present(pmdval) ||
+	    !pte_get_unless_zero(&pmdval))
 		retval = false;
-	spin_unlock(ptl);
+	rcu_read_unlock();
 
 	return retval;
 }
@@ -129,21 +130,22 @@ static inline void pte_put_vmf(struct vm_fault *vmf)
 
 static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
 {
-	if (!pte_try_get(mm, pmdp))
+	if (!pte_try_get(pmdp))
 		return __pte_alloc_try_get(mm, pmdp);
 	return 1;
 }
 
 static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
 {
-	spinlock_t *ptl;
+	pmd_t pmdval;
 
-	ptl = pmd_lock(mm, pmdp);
-	if (pmd_none(*pmdp) || !pte_get_unless_zero(pmdp)) {
-		spin_unlock(ptl);
+	rcu_read_lock();
+	pmdval = READ_ONCE(*pmdp);
+	if (pmd_none(pmdval) || !pte_get_unless_zero(&pmdval)) {
+		rcu_read_unlock();
 		return __pte_alloc_get(mm, pmdp);
 	}
-	spin_unlock(ptl);
+	rcu_read_unlock();
 	return 0;
 }
 #else
@@ -173,7 +175,7 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
 	return true;
 }
 
-static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+static inline bool pte_try_get(pmd_t *pmdp)
 {
 	return true;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 3e2a153cb18e..a5be18e349cd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -503,7 +503,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		return no_page_table(vma, flags);
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
diff --git a/mm/hmm.c b/mm/hmm.c
index 29bb379510cc..d0e767c5fbb6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -380,7 +380,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (!pte_try_get(walk->mm, pmdp))
+	if (!pte_try_get(pmdp))
 		goto again;
 
 	ptep = pte_offset_map(pmdp, addr);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e6c4d1b7a12a..c653edd75345 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1240,7 +1240,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (!pte_try_get(mm, pmd)) {
+	if (!pte_try_get(pmd)) {
 		result = SCAN_PMD_NULL;
 		goto out;
 	}
@@ -1469,7 +1469,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		goto drop_hpage;
 
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		goto drop_hpage;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 2e106f58dad0..5671683890c0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1133,7 +1133,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		goto out;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4c4b35292212..0e849bbf268b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -193,7 +193,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
 	    pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
-	    !pte_try_get(vma->vm_mm, pmd))
+	    !pte_try_get(pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -396,7 +396,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 #endif
-	if (!pte_try_get(vma->vm_mm, pmd))
+	if (!pte_try_get(pmd))
 		return 0;
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -596,7 +596,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			goto next;
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
-	     pmd_trans_unstable(pmd)) || !pte_try_get(mm, pmd))
+	     pmd_trans_unstable(pmd)) || !pte_try_get(pmd))
 		return 0;
 	nr_put++;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4f19e5f2cd18..f8c1cabdd259 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5835,7 +5835,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	}
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
-	    !pte_try_get(vma->vm_mm, pmd))
+	    !pte_try_get(pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
@@ -6058,7 +6058,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	if (!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd))
 		return 0;
 retry:
-	if (!pte_try_get(vma->vm_mm, pmd))
+	if (!pte_try_get(pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
diff --git a/mm/memory.c b/mm/memory.c
index 242ed135bde4..c8ee0074c730 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1143,7 +1143,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
 
-		if (!pte_try_get(src_mm, src_pmd))
+		if (!pte_try_get(src_pmd))
 			goto retry;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
 				   addr, next)) {
@@ -1481,7 +1481,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 */
 		if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
 		     pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
-		     !pte_try_get(tlb->mm, pmd))
+		     !pte_try_get(pmd))
 			goto next;
 
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
@@ -2608,7 +2608,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 				continue;
 			pmd_clear_bad(pmd);
 		}
-		if (!create && !pte_try_get(mm, pmd))
+		if (!create && !pte_try_get(pmd))
 			goto retry;
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
@@ -4078,7 +4078,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 	} else if (pmd_devmap_trans_unstable(vmf->pmd)) { /* See comment in handle_pte_fault() */
 		return 0;
-	} else if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+	} else if (!pte_try_get(vmf->pmd)) {
 		goto retry;
 	}
 
@@ -4319,7 +4319,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_SIGBUS;
 			goto out;
 		} else {
-			if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+			if (!pte_try_get(vmf->pmd)) {
 				ret = VM_FAULT_SIGBUS;
 				goto out;
 			}
@@ -4579,7 +4579,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
 
-		if (!pte_try_get(vmf->vma->vm_mm, vmf->pmd))
+		if (!pte_try_get(vmf->pmd))
 			goto retry;
 
 		if (IS_ENABLED(CONFIG_FREE_USER_PTE))
@@ -5000,7 +5000,7 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 					(address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		goto out;
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
 	if (!pte_present(*ptep))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cbb3640717ff..b19243d8fe56 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -520,7 +520,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	/* THP was split, fall through to pte walk */
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
-	    !pte_try_get(walk->mm, pmd))
+	    !pte_try_get(pmd))
 		return 0;
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a94e8558b2c..e1a2169ab9e9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2265,7 +2265,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-	if (!pte_try_get(mm, pmdp))
+	if (!pte_try_get(pmdp))
 		goto again;
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	arch_enter_lazy_mmu_mode();
diff --git a/mm/mincore.c b/mm/mincore.c
index e21e271a7657..76eb31aaeef9 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -115,7 +115,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	}
 
 	if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) && pmd_trans_unstable(pmd)) ||
-	    !pte_try_get(walk->mm, pmd)) {
+	    !pte_try_get(pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 9cbd0848c5c5..8b387f8386c4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -319,7 +319,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		if (!pte_try_get(vma->vm_mm, pmd))
+		if (!pte_try_get(pmd))
 			goto retry;
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
 					      cp_flags);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index eb84fa5825c0..c49bbff7aa60 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -259,7 +259,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!pte_try_get(pvmw->vma->vm_mm, pvmw->pmd))
+		if (!pte_try_get(pvmw->pmd))
 			goto retry;
 		if (!map_pte(pvmw))
 			goto next_pte;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 4080a88d7852..c7439a2e85f7 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -152,7 +152,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
 		} else {
 			if (!walk->no_vma) {
-				if (!pte_try_get(walk->mm, pmd))
+				if (!pte_try_get(pmd))
 					goto again;
 				err = walk_pte_range(pmd, addr, next, walk);
 				pte_put(walk->mm, pmd, addr);
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 1b8d9828d513..7fd3d687a9cd 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -26,6 +26,14 @@ static inline void pte_free_debug(pmd_t pmd)
 }
 #endif
 
+static void pte_free_rcu(struct rcu_head *rcu)
+{
+	struct page *page = container_of(rcu, struct page, rcu_head);
+
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
 void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
@@ -39,7 +47,7 @@ void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
 	pte_free_debug(pmd);
 	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
 	mm_dec_nr_ptes(mm);
-	pte_free(mm, pmd_pgtable(pmd));
+	call_rcu(&pmd_pgtable(pmd)->rcu_head, pte_free_rcu);
 }
 
 static inline void __pte_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6153283be500..fe6f7c6d2849 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2024,7 +2024,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if ((!IS_ENABLED(CONFIG_FREE_USER_PTE) &&
 		    pmd_none_or_trans_huge_or_clear_bad(pmd)) ||
-		    !pte_try_get(vma->vm_mm, pmd))
+		    !pte_try_get(pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
-- 
2.11.0

