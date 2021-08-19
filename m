Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF423F117E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhHSDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhHSDVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:21:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF0DC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c17so3126198plz.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjxUS8O0SJ7ps3SzxoHYG/pW1shSChW8FQfdtPM3PZM=;
        b=Wt4eNvhsZql5ao/bqo27jODT8cRx3CrgAMjduQRW2uLN8kxO2x/DkYHXPqNNbIxyJz
         Eue96XByNueG0HhfOm2iPYGwffLz5LnPvuK6i4dFn8u6e3GIVWrPBbkZfpFHBBMsSMUg
         Fa5WrWsV0xU6pEJq3xemB/SBOqwQFvVWAbkBV1GcyE8V796Jf5fIlTdGqWqix2ifa2Wu
         68SiRN66tOUgI4pavyIuSGCrpzYl79Oif92eoIbmFSnTdSGunTjmGnW+rcPS9Yu9qDNQ
         qpvvkIf/nsA/e9cbSwUkEu4mG6rRPuSEylOGMBtZu7tW8+3T030N5hJuSV7I24S6sMih
         cY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjxUS8O0SJ7ps3SzxoHYG/pW1shSChW8FQfdtPM3PZM=;
        b=WpCmVdQx+ns0zPXiEPEkMXP/srPF2mcB/BPtvbuZcNe+PGKZpIJ2mHduwxs9vEGZST
         ovlonFgr6NLu9dfRoTggWBQ0tP0oCi4oNf1lufIKujTEMyTNL2x7EeIGOr5IAYGe9bdn
         nfHtFBWAXHea/v7eQfroOaAgsWfTF7oxWpwIyX+CQgoe9Mn7INTlsSP5r6MyFJRmEHVW
         GSw8Z49u5eS8v9cqwHNUXcDjyjYsI/5MKiDK/0/Hx20X3HMaa/7zJvuueY5ZRGFHpDAH
         dbdqBGdjlY/GUSJOUIclTAW0OhINZ9KhEb6yYRLfUe8803k8cAkPNHHycbcQ+oXKJg4w
         8AiQ==
X-Gm-Message-State: AOAM532kmSBbIttT3AhTEHSXaMbpa8YiOsAVAB5Zbsr5nnvpVZzmE0d3
        CaQrzYrylD5XbTzEkNN1EqAgHg==
X-Google-Smtp-Source: ABdhPJyq8s/yc850Q4TklxHUL/DeYRu467Wv3JSf4VqRt7oZsTov56iltxlDsI7aw28TiXLi565fkw==
X-Received: by 2002:a17:902:d0ce:b0:12d:c570:370c with SMTP id n14-20020a170902d0ce00b0012dc570370cmr9948844pln.40.1629343230651;
        Wed, 18 Aug 2021 20:20:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:30 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 8/9] mm: free PTE page table by using rcu mechanism
Date:   Thu, 19 Aug 2021 11:18:57 +0800
Message-Id: <20210819031858.98043-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
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
 include/linux/pte_ref.h | 34 ++++++++++++++++++----------------
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
 17 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b31915696210..f44caef03f22 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -583,7 +583,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
@@ -1146,7 +1146,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -1477,7 +1477,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmdp))
+	if (pmd_trans_unstable_or_pte_try_get(pmdp))
 		return 0;
 
 	/*
@@ -1816,7 +1816,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 #endif
-	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index 04cca9427270..259e5aec048d 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -90,16 +90,17 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
  * Before Operating the PTE page table, we need to hold a ->pte_refcount
  * to protect against the concurrent release of the PTE page table.
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
@@ -159,14 +160,15 @@ static inline void pte_put_vmf(struct vm_fault *vmf)
  */
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
 
@@ -189,14 +191,14 @@ static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
  */
 static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
 {
-	if (!pte_try_get(mm, pmdp))
+	if (!pte_try_get(pmdp))
 		return __pte_alloc_try_get(mm, pmdp);
 	return 1;
 }
 
-static inline bool pmd_trans_unstable_or_pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+static inline bool pmd_trans_unstable_or_pte_try_get(pmd_t *pmdp)
 {
-	if (!pte_try_get(mm, pmdp))
+	if (!pte_try_get(pmdp))
 		return true;
 	return false;
 }
@@ -227,7 +229,7 @@ static inline bool pte_get_unless_zero(pmd_t *pmdp)
 	return true;
 }
 
-static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+static inline bool pte_try_get(pmd_t *pmdp)
 {
 	return true;
 }
@@ -265,7 +267,7 @@ static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
 	return 1;
 }
 
-static inline bool pmd_trans_unstable_or_pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+static inline bool pmd_trans_unstable_or_pte_try_get(pmd_t *pmdp)
 {
 	if (pmd_trans_unstable(pmdp))
 		return true;
diff --git a/mm/gup.c b/mm/gup.c
index 30757f3b176c..c987ac45d939 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -500,7 +500,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
index 95d90c896580..f33db38eaafc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1240,7 +1240,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
-	if (!pte_try_get(mm, pmd)) {
+	if (!pte_try_get(pmd)) {
 		result = SCAN_PMD_NULL;
 		goto out;
 	}
@@ -1468,7 +1468,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		goto drop_hpage;
 
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		goto drop_hpage;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index d0d72dd1eaf0..4a15418f1252 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1138,7 +1138,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
-	if (!pte_try_get(mm, pmd))
+	if (!pte_try_get(pmd))
 		goto out;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
diff --git a/mm/madvise.c b/mm/madvise.c
index 1befb4e64f2b..254811f41850 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -191,7 +191,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -392,7 +392,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 regular_page:
 #endif
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
@@ -592,7 +592,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable_or_pte_try_get(mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 	nr_put++;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56c580d37e94..956920f96191 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5810,7 +5810,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
@@ -6030,7 +6030,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 retry:
-	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
diff --git a/mm/memory.c b/mm/memory.c
index 99dde124755b..6a7fe29d593b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1142,7 +1142,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		if (!pte_try_get(src_mm, src_pmd))
+		if (!pte_try_get(src_pmd))
 			goto retry;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
 				   addr, next)) {
@@ -1478,7 +1478,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 * because MADV_DONTNEED holds the mmap_lock in read
 		 * mode.
 		 */
-		if (pmd_trans_unstable_or_pte_try_get(tlb->mm, pmd))
+		if (pmd_trans_unstable_or_pte_try_get(pmd))
 			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
 		pte_put(tlb->mm, pmd, addr);
@@ -2604,7 +2604,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 				continue;
 			pmd_clear_bad(pmd);
 		}
-		if (!create && !pte_try_get(mm, pmd))
+		if (!create && !pte_try_get(pmd))
 			goto retry;
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
@@ -4077,7 +4077,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
 		/* See comment in handle_pte_fault() */
 		return 0;
-	} else if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+	} else if (!pte_try_get(vmf->pmd)) {
 		goto retry;
 	}
 
@@ -4320,7 +4320,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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
index 9d0493f80a75..9a6d1c845a93 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -518,7 +518,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	/* THP was split, fall through to pte walk */
 
-	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(pmd))
 		return 0;
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index af5b8900551b..eb0da7fb7033 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2298,7 +2298,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-	if (!pte_try_get(mm, pmdp))
+	if (!pte_try_get(pmdp))
 		goto again;
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	arch_enter_lazy_mmu_mode();
diff --git a/mm/mincore.c b/mm/mincore.c
index a72ec90dd54f..e47fe60c6e04 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -114,7 +114,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd)) {
+	if (pmd_trans_unstable_or_pte_try_get(pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 53b412423ee8..4673604c709e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -279,7 +279,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
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
index da1324021429..97cd4e726a2b 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -153,7 +153,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
 		} else {
 			if (!walk->no_vma) {
-				if (!pte_try_get(walk->mm, pmd))
+				if (!pte_try_get(pmd))
 					goto retry;
 				err = walk_pte_range(pmd, addr, next, walk);
 				pte_put(walk->mm, pmd, addr);
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index dff32909c7c4..ea40b1777056 100644
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
 
 static inline void __pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6db8381e1e19..47e95aceedd5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2021,7 +2021,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
-		if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
+		if (pmd_trans_unstable_or_pte_try_get(pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
-- 
2.11.0

