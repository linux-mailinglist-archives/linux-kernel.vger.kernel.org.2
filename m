Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168883F117B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhHSDV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhHSDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:21:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3FC06179A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o2so4527014pgr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34jEtgDIeeAqwHdouWeDn0M5i3xpVbjPPaVPxhKZPRE=;
        b=OdP2K1fqSGeLmuoGc3A9/GqVuJKPr41KRCzmakQQVzlVznH91tiVD0wdi28Eo9bUiX
         OcUCEBwDWpbKxF+uY9Bx7NLL3r4ajdFP/A6yS3s/QJ6z2hgPwOoB4caJb7C0O2fkr4hn
         Srh0p5BCDsOAZpxMOsxdGNRcxe0HJ9FQSYCnF9fpiH2GsWEVxJmMXdedpWrXpwCKOXRr
         IbcMzRKSeooqwNSH8bSe/4FSOJcFxfRMpI62j4D7K4d/tOy46DSCnGzqjZNHBdHIlibB
         AB7KPJVeZLfEwX68uJYcQSHOAG6GaJwBkaMlNflsPf0MVEniqjYjxxM7rGpAkibFAMfa
         VIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34jEtgDIeeAqwHdouWeDn0M5i3xpVbjPPaVPxhKZPRE=;
        b=q6SQSWV8Kr2Ey6j+MNgX/hqB3oS2AYIw8iS0PzT54Sq5N+Ta/tnUlyzuDcTAqCPf8d
         ocZ+Y7eFQjaW7iJ0M049kJ0ZEF46svs8bm8aaMiE4mSMJ8HKAYXXrnkyXBbi17HgXAA0
         cDEg47bjVoRpbR/iNfgKghO291VXeqpJw9UmcEfXk/GBXacjluiCqmh3qcI6VuBkTFFb
         VrCRD9JO26CaWgVWbJwbzyWJbXuLjfsXwRu9VTyIP4z2TO7bQfH9BLrwYTySbE3U1rBv
         QPBGfVG220bEVsBMElKLbe/TiroWBoOxXQWKSaAklGiMx/DEPM4SX62Q11z6tM5ZQdpV
         coBQ==
X-Gm-Message-State: AOAM530llLjVg5hMat9QdDsz+NPHOJAWG/rA4X8k4CAKQSH6uQVwOLKj
        MOgeooYGYpAhUBUJR1uTy/l4RA==
X-Google-Smtp-Source: ABdhPJxFhreOnM2cO4INt+6XuH9uM6cjiWdC7/fs34RZrCaATmNYyiCmVpHw6mVerLbAYhmUHCOMIQ==
X-Received: by 2002:a63:170d:: with SMTP id x13mr11620321pgl.216.1629343226086;
        Wed, 18 Aug 2021 20:20:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:25 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 7/9] mm: add THP support for pte_ref
Date:   Thu, 19 Aug 2021 11:18:56 +0800
Message-Id: <20210819031858.98043-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The situation will become more complex with THP enabled. In
the handle_pte_fault(), the pmd entry can be populated with
PTE page table as well as THP page. So we can no longer
always get ->pte_refcount successfully, we add the following
function to solve this case:

	pte_alloc_try_get()
	pmd_install_try_get()

When split THP into PTE page table, we initialize
->pte_refcount to HPAGE_PMD_NR, so that we can free this PTE
normally through pte_put().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/task_mmu.c      | 14 +++-------
 include/linux/pte_ref.h | 46 +++++++++++++++++++++++++++++--
 mm/Kconfig              |  2 +-
 mm/filemap.c            | 11 ++++----
 mm/khugepaged.c         |  9 ++++++
 mm/madvise.c            |  9 ++----
 mm/memcontrol.c         |  7 ++---
 mm/memory.c             | 43 +++++++++++++++--------------
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  7 +----
 mm/mincore.c            |  2 +-
 mm/pgtable-generic.c    |  2 ++
 mm/pte_ref.c            | 73 +++++++++++++++++++++++++++++++++++++------------
 mm/sparse-vmemmap.c     |  2 +-
 mm/swapfile.c           |  3 +-
 mm/userfaultfd.c        | 10 ++++---
 16 files changed, 159 insertions(+), 83 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 85ee730ff6ae..b31915696210 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -583,7 +583,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
@@ -1146,7 +1146,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -1475,12 +1475,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		spin_unlock(ptl);
 		return err;
 	}
-
-	if (pmd_trans_unstable(pmdp))
-		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	if (!pte_try_get(walk->mm, pmdp))
+	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmdp))
 		return 0;
 
 	/*
@@ -1818,11 +1815,8 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		spin_unlock(ptl);
 		return 0;
 	}
-
-	if (pmd_trans_unstable(pmd))
-		return 0;
 #endif
-	if (!pte_try_get(walk->mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd))
 		return 0;
 
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index c2389d03bb59..04cca9427270 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -14,8 +14,9 @@
 #include <asm/pgalloc.h>
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
-void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+bool pmd_install_try_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd);
+int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd);
 
 #define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
 
@@ -95,7 +96,8 @@ static inline bool pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmdp);
-	if (!pmd_present(*pmdp) || !pte_get_unless_zero(pmdp))
+	if (pmd_leaf(*pmdp) || !pmd_present(*pmdp) ||
+	    !pte_get_unless_zero(pmdp))
 		retval = false;
 	spin_unlock(ptl);
 
@@ -174,6 +176,30 @@ static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
 #define pte_alloc_get_map_lock(mm, pmd, address, ptlp)		\
 	(pte_alloc_get(mm, pmd) ?				\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
+
+/*
+ * pte_alloc_try_get - allocate a PTE page table if the pmd entry is none, and
+ *		       try to hold a ->pte_refcount
+ * @mm: the mm_struct of the target address space.
+ * @pmdp: a pointer to the pmd entry corresponding to the PTE page table.
+ *
+ * Return 1 if the ->pte_refcount is successfully held, return 0 if the pmd
+ * entry is populated with a THP page by another thread, Otherwise return
+ * -ENOMEM.
+ */
+static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (!pte_try_get(mm, pmdp))
+		return __pte_alloc_try_get(mm, pmdp);
+	return 1;
+}
+
+static inline bool pmd_trans_unstable_or_pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (!pte_try_get(mm, pmdp))
+		return true;
+	return false;
+}
 #else
 static inline void pte_ref_init(pgtable_t pte, pmd_t *pmd, int count)
 {
@@ -229,6 +255,22 @@ static inline int pte_alloc_get(struct mm_struct *mm, pmd_t *pmdp)
 
 #define pte_alloc_get_map_lock(mm, pmd, address, ptlp)		\
 	pte_alloc_map_lock(mm, pmd, address, ptlp)
+
+static inline int pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (unlikely(pmd_none(*pmdp)))
+		return __pte_alloc_try_get(mm, pmdp);
+	if (unlikely(pmd_devmap_trans_unstable(pmdp)))
+		return 0;
+	return 1;
+}
+
+static inline bool pmd_trans_unstable_or_pte_try_get(struct mm_struct *mm, pmd_t *pmdp)
+{
+	if (pmd_trans_unstable(pmdp))
+		return true;
+	return false;
+}
 #endif /* CONFIG_FREE_USER_PTE */
 
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index fb16ecebcb80..18aea3d0ce49 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -896,7 +896,7 @@ config SECRETMEM
 
 config FREE_USER_PTE
 	def_bool y
-	depends on X86_64 && !TRANSPARENT_HUGEPAGE
+	depends on X86_64
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7f2eb64e5c76..8bcab6fc5d17 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3211,12 +3211,13 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_FREE_USER_PTE) || pmd_none(*vmf->pmd))
-		pmd_install_get(mm, vmf->pmd, &vmf->prealloc_pte);
-
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
+	if (IS_ENABLED(CONFIG_FREE_USER_PTE) || pmd_none(*vmf->pmd)) {
+		if (!pmd_install_try_get(mm, vmf->pmd, &vmf->prealloc_pte))
+			goto out;
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		/* See comment in handle_pte_fault() */
 		goto out;
+	}
 
 	return false;
 out:
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9c98ddcd09..95d90c896580 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1240,6 +1240,10 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
+	if (!pte_try_get(mm, pmd)) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
@@ -1361,6 +1365,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pmd, address);
 	if (ret) {
 		node = khugepaged_find_target_node();
 		/* collapse_huge_page will return with the mmap_lock released */
@@ -1463,6 +1468,8 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		goto drop_hpage;
 
+	if (!pte_try_get(mm, pmd))
+		goto drop_hpage;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 
 	/* step 1: check all mapped PTEs are to the right huge page */
@@ -1501,6 +1508,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
@@ -1522,6 +1530,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 	goto drop_hpage;
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 1494da73281c..1befb4e64f2b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -191,8 +191,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 
-	if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
-	    !pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -392,10 +391,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 regular_page:
-	if (pmd_trans_unstable(pmd))
-		return 0;
 #endif
-	if (!pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
@@ -595,7 +592,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(mm, pmd))
 		return 0;
 	nr_put++;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f7d203ce14af..56c580d37e94 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5810,7 +5810,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
@@ -6029,11 +6029,8 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		spin_unlock(ptl);
 		return 0;
 	}
-
-	if (pmd_trans_unstable(pmd))
-		return 0;
 retry:
-	if (!pte_try_get(vma->vm_mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
diff --git a/mm/memory.c b/mm/memory.c
index 8fcef8b67971..99dde124755b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -453,7 +453,7 @@ int __pte_alloc_kernel(pmd_t *pmd)
 
 	spin_lock(&init_mm.page_table_lock);
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
-		smp_wmb(); /* See comment in pmd_install_get() */
+		smp_wmb(); /* See comment in __pmd_install() */
 		pmd_populate_kernel(&init_mm, pmd, new);
 		new = NULL;
 	}
@@ -1478,8 +1478,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 * because MADV_DONTNEED holds the mmap_lock in read
 		 * mode.
 		 */
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
-		    !pte_try_get(tlb->mm, pmd))
+		if (pmd_trans_unstable_or_pte_try_get(tlb->mm, pmd))
 			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
 		pte_put(tlb->mm, pmd, addr);
@@ -3760,7 +3759,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/*
-	 * Use pte_alloc_get() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_try_get() instead of pte_alloc_get_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
@@ -3769,12 +3768,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc_get(vma->vm_mm, vmf->pmd))
-		return VM_FAULT_OOM;
-
-	/* See comment in handle_pte_fault() */
-	if (unlikely(pmd_trans_unstable(vmf->pmd)))
-		return 0;
+	ret = pte_alloc_try_get(vma->vm_mm, vmf->pmd);
+	if (ret <= 0)
+		return ret < 0 ? VM_FAULT_OOM : 0;
+	ret = 0;
 
 	/* Use the zero-page for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
@@ -4068,18 +4065,22 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pmd_install_get(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc_get(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		if (vmf->prealloc_pte) {
+			if (!pmd_install_try_get(vma->vm_mm, vmf->pmd,
+			    &vmf->prealloc_pte))
+				return 0;
+		} else {
+			ret = pte_alloc_try_get(vma->vm_mm, vmf->pmd);
+			if (ret <= 0)
+				return ret < 0 ? VM_FAULT_OOM : 0;
+		}
+	} else if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		/* See comment in handle_pte_fault() */
+		return 0;
 	} else if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
 		goto retry;
 	}
 
-	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
-		return 0;
-
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
 	ret = 0;
@@ -4890,7 +4891,7 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 	if (pgd_present(*pgd))		/* Another has populated it */
 		p4d_free(mm, new);
 	else {
-		smp_wmb(); /* See comment in pmd_install_get() */
+		smp_wmb(); /* See comment in __pmd_install() */
 		pgd_populate(mm, pgd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -4912,7 +4913,7 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address)
 	spin_lock(&mm->page_table_lock);
 	if (!p4d_present(*p4d)) {
 		mm_inc_nr_puds(mm);
-		smp_wmb(); /* See comment in pmd_install_get() */
+		smp_wmb(); /* See comment in __pmd_install() */
 		p4d_populate(mm, p4d, new);
 	} else	/* Another has populated it */
 		pud_free(mm, new);
@@ -4936,7 +4937,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	ptl = pud_lock(mm, pud);
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
-		smp_wmb(); /* See comment in pmd_install_get() */
+		smp_wmb(); /* See comment in __pmd_install() */
 		pud_populate(mm, pud, new);
 	} else	/* Another has populated it */
 		pmd_free(mm, new);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index acef7df762a9..9d0493f80a75 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -518,7 +518,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	/* THP was split, fall through to pte walk */
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(walk->mm, pmd))
+	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd))
 		return 0;
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index a3bcef1430c9..af5b8900551b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2829,7 +2829,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 
 	/*
-	 * Use pte_alloc_get() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_try_get() instead of pte_alloc_get_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
@@ -2841,12 +2841,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (pte_alloc_get(mm, pmdp))
 		goto abort;
 
-	/* See the comment in pte_alloc_one_map() */
-	if (unlikely(pmd_trans_unstable(pmdp)))
-		goto abort;
-
 	if (unlikely(anon_vma_prepare(vma)))
-		goto put;
 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
 		goto put;
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 0401b526adee..a72ec90dd54f 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -114,7 +114,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd) || !pte_try_get(walk->mm, pmd)) {
+	if (pmd_trans_unstable_or_pte_try_get(walk->mm, pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4e640baf9794..88464c54619f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/pte_ref.h>
 #include <asm/tlb.h>
 
 /*
@@ -186,6 +187,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 							  struct page, lru);
 	if (pmd_huge_pte(mm, pmdp))
 		list_del(&pgtable->lru);
+	pte_ref_init(pgtable, pmdp, HPAGE_PMD_NR);
 	return pgtable;
 }
 #endif
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index dfbf817b7367..dff32909c7c4 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -42,6 +42,28 @@ void free_pte_table(struct mm_struct *mm, pmd_t *pmdp, unsigned long addr)
 	pte_free(mm, pmd_pgtable(pmd));
 }
 
+static inline void __pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	mm_inc_nr_ptes(mm);
+	/*
+	 * Ensure all pte setup (eg. pte page lock and page clearing) are
+	 * visible before the pte is made visible to other CPUs by being
+	 * put into page tables.
+	 *
+	 * The other side of the story is the pointer chasing in the page
+	 * table walking code (when walking the page table without locking;
+	 * ie. most of the time). Fortunately, these data accesses consist
+	 * of a chain of data-dependent loads, meaning most CPUs (alpha
+	 * being the notable exception) will already guarantee loads are
+	 * seen in-order. See the alpha page table accessors for the
+	 * smp_rmb() barriers in page table walking code.
+	 */
+	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
+	pmd_populate(mm, pmd, *pte);
+	pte_ref_init(*pte, pmd, 1);
+	*pte = NULL;
+}
+
 void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 {
 	spinlock_t *ptl;
@@ -49,24 +71,7 @@ void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 retry:
 	ptl = pmd_lock(mm, pmd);
 	if (likely(pmd_none(*pmd))) {
-		mm_inc_nr_ptes(mm);
-		/*
-		 * Ensure all pte setup (eg. pte page lock and page clearing) are
-		 * visible before the pte is made visible to other CPUs by being
-		 * put into page tables.
-		 *
-		 * The other side of the story is the pointer chasing in the page
-		 * table walking code (when walking the page table without locking;
-		 * ie. most of the time). Fortunately, these data accesses consist
-		 * of a chain of data-dependent loads, meaning most CPUs (alpha
-		 * being the notable exception) will already guarantee loads are
-		 * seen in-order. See the alpha page table accessors for the
-		 * smp_rmb() barriers in page table walking code.
-		 */
-		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, *pte);
-		pte_ref_init(*pte, pmd, 1);
-		*pte = NULL;
+		__pmd_install(mm, pmd, pte);
 	} else if (!pte_get_unless_zero(pmd)) {
 		spin_unlock(ptl);
 		goto retry;
@@ -74,6 +79,25 @@ void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 	spin_unlock(ptl);
 }
 
+bool pmd_install_try_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+{
+	spinlock_t *ptl;
+	bool retval = true;
+
+retry:
+	ptl = pmd_lock(mm, pmd);
+	if (likely(pmd_none(*pmd))) {
+		__pmd_install(mm, pmd, pte);
+	} else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
+		retval = false;
+	} else if (!pte_get_unless_zero(pmd)) {
+		spin_unlock(ptl);
+		goto retry;
+	}
+	spin_unlock(ptl);
+	return retval;
+}
+
 int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t new = pte_alloc_one(mm);
@@ -86,6 +110,19 @@ int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd)
 	return 0;
 }
 
+int __pte_alloc_try_get(struct mm_struct *mm, pmd_t *pmd)
+{
+	int retval;
+	pgtable_t new = pte_alloc_one(mm);
+	if (!new)
+		return -ENOMEM;
+
+	retval = pmd_install_try_get(mm, pmd, &new);
+	if (new)
+		pte_free(mm, new);
+	return retval;
+}
+
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 {
 	return __pte_alloc_get(mm, pmd);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 818c82ee3c6e..0ce288b979f1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -76,7 +76,7 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in pmd_install_get(). */
+	/* Make pte visible before pmd. See comment in __pmd_install(). */
 	smp_wmb();
 	pmd_populate_kernel(&init_mm, pmd, pgtable);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 10ebfc94208a..6db8381e1e19 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2021,8 +2021,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
-		    !pte_try_get(vma->vm_mm, pmd))
+		if (pmd_trans_unstable_or_pte_try_get(vma->vm_mm, pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7661929b27bf..cb76c6167541 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -572,6 +572,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
+		int ret = 1;
 
 		BUG_ON(dst_addr >= dst_start + len);
 
@@ -590,12 +591,13 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			err = -EEXIST;
 			break;
 		}
-		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc_get(dst_mm, dst_pmd))) {
+		if ((IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+		     unlikely((ret = pte_alloc_try_get(dst_mm, dst_pmd)) < 0)) ||
+		    (unlikely(pmd_none(dst_pmdval)) &&
+		     unlikely((ret = __pte_alloc_try_get(dst_mm, dst_pmd)) < 0))) {
 			err = -ENOMEM;
 			break;
-		} else if (unlikely(pmd_trans_huge(*dst_pmd)) ||
-			   !pte_try_get(dst_mm, dst_pmd)) {
+		} else if (!ret || unlikely(pmd_trans_huge(*dst_pmd))) {
 			/*
 			 * If an huge pmd materialized from under us fail or the
 			 * pte populated in the dst_pmd was freed.
-- 
2.11.0

