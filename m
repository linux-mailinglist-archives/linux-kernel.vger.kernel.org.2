Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C223F1178
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhHSDVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhHSDU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:20:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49736C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o2so4526842pgr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZduSDTtaoEqANwU7wP263QzsgQE1CLRW77GCvOvUTpo=;
        b=TOdOz+CHpoTqRiLtJtGwBZ7v5PzKpBEu4X8/Y2774YSvC5qs1eSwa5psnKHken6xPV
         nGe6LcPLX4IFpdR0TVBET/11w2MpX7vu616u+kPZ26BY58XqGx+GZCe+pibvODCUD62c
         oaCC9fa6lKn4dntpK2JdsgHKlTxgxCR9+jm/p5un2BccglUErqttXHEv5R7WafxnC+kh
         yBOa4wKVhm4UBfi+7psbo2DJhRMz2EPEMHc+OiRxFkd9kcAm1LB1ERlIYj/JHtXHhqyf
         pFce312wD6t8DshsZmm+N8y1e3dKz1YHSm7eBctFd91hN5rh8UBHSoG+FOWTXIvE1mot
         j64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZduSDTtaoEqANwU7wP263QzsgQE1CLRW77GCvOvUTpo=;
        b=rvuEbr30Z4ezE4HXhbZ68462DoFx7kPCEjBMbiVmUJUu47I+qwphDB2Tj7TahZhvCe
         Nue7oLofmJZxSqZbP/zO7s23LN6ZXvQ2kz+YsdlvHaoT2r8kmsPoyZ56tCUFa7JrPPNr
         1IaGxMSA8oIs/yHl9h9ymwvfokLSpNre2YSubC9wmmX8ZWiAyVGvJquoQZ+b0KUTy3bP
         H/eHe2c/C1Oat12oF0a1u9fnOIzVzTnOFpFHOMwZIHFTC3MjrFNpww9olvKyxe5fhp5Y
         1Ag4rQXLzJJ78jZlHzReBwmoee1kG3p1hv6aC3oGZ0DKiXw/MrW9zBkSHkPnraM0kZbN
         RufA==
X-Gm-Message-State: AOAM533lYTJjn6yi/eDZlHDpnEh8DZuOW+VMG7K7sR4wt64QI+As7Puz
        pgvckF0pNE8O39p93mNMIAnSMw==
X-Google-Smtp-Source: ABdhPJz5SUh54nR0fmqbpJJhvEOHArmz3ue46AWktee67T3C1baBIT01Z1CKbagHnfacVGm5yDO+QA==
X-Received: by 2002:a63:4d18:: with SMTP id a24mr11714662pgb.324.1629343221481;
        Wed, 18 Aug 2021 20:20:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k3sm1261276pfc.16.2021.08.18.20.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 20:20:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/9] mm: free user PTE page table pages
Date:   Thu, 19 Aug 2021 11:18:55 +0800
Message-Id: <20210819031858.98043-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some malloc libraries(e.g. jemalloc or tcmalloc) usually
allocate the amount of VAs by mmap() and do not unmap
those VAs. They will use madvise(MADV_DONTNEED) to free
physical memory if they want. But the page tables do not
be freed by madvise(), so it can produce many page tables
when the process touches an enormous virtual address space.

The following figures are a memory usage snapshot of one
process which actually happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

As we can see, the PTE page tables size is 110g, while the
RES is 590g. In theory, the process only need 1.2g PTE page
tables to map those physical memory. The reason why PTE page
tables occupy a lot of memory is that madvise(MADV_DONTNEED)
only empty the PTE and free physical memory but doesn't free
the PTE page table pages. So we can free those empty PTE page
tables to save memory. In the above cases, we can save memory
about 108g(best case). And the larger the difference between
the size of VIRT and RES, the more memory we save.

In this patch series, we add a pte_refcount field to the
struct page of page table to track how many users of PTE page
table. Similar to the mechanism of page refcount, the user of
PTE page table should hold a refcount to it before accessing.
The PTE page table page will be freed when the last refcount
is dropped.

While we access ->pte_refcount of a PTE page table, any of the
following ensures the pmd entry corresponding to the PTE page
table stability:

	- mmap_lock
	- anon_lock
	- i_mmap_lock
	- parallel threads are excluded by other means which
	  can make ->pmd stable(e.g. gup case)

This patch does not support THP temporarily, it will be
supported in the next patch.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/task_mmu.c      |  18 ++++-
 fs/userfaultfd.c        |   2 +
 include/linux/mm.h      |   2 +
 include/linux/pte_ref.h |   1 -
 include/linux/rmap.h    |   4 +-
 kernel/events/uprobes.c |   3 +
 mm/filemap.c            |  43 ++++++-----
 mm/gup.c                |   7 ++
 mm/hmm.c                |   4 +
 mm/internal.h           |   1 +
 mm/ksm.c                |   4 +
 mm/madvise.c            |  17 ++++-
 mm/memcontrol.c         |   8 +-
 mm/memory.c             | 194 +++++++++++++++++++++++++++++++++++++++---------
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |  15 +++-
 mm/mincore.c            |   5 +-
 mm/mlock.c              |   1 +
 mm/mprotect.c           |  10 ++-
 mm/mremap.c             |  12 ++-
 mm/page_vma_mapped.c    |   4 +
 mm/pagewalk.c           |  16 +++-
 mm/pte_ref.c            |   5 --
 mm/rmap.c               |  13 ++++
 mm/swapfile.c           |   4 +-
 mm/userfaultfd.c        |  14 +++-
 26 files changed, 326 insertions(+), 85 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..85ee730ff6ae 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -574,6 +574,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -582,7 +583,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
@@ -593,6 +594,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 out:
 	cond_resched();
 	return 0;
@@ -1121,6 +1123,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -1143,7 +1146,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
@@ -1168,6 +1171,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ClearPageReferenced(page);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 	return 0;
 }
@@ -1407,6 +1411,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
@@ -1475,6 +1480,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+	if (!pte_try_get(walk->mm, pmdp))
+		return 0;
+
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
 	 * goes beyond vma->vm_end.
@@ -1489,6 +1497,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			break;
 	}
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmdp, start);
 
 	cond_resched();
 
@@ -1795,6 +1804,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte;
 	pte_t *pte;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -1812,6 +1822,9 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (!pte_try_get(walk->mm, pmd))
+		return 0;
+
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
@@ -1821,6 +1834,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 	return 0;
 }
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 003f0d31743e..baa1d98a6f87 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,6 +28,7 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
+#include <linux/pte_ref.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -509,6 +510,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
 						       vmf->address,
 						       vmf->flags, reason);
+	pte_put_vmf(vmf);
 	mmap_read_unlock(mm);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 369d4283de49..5659a483072b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -437,6 +437,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PTE_GET: This means the pte ->pte_refcount has been got.
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
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index 47aaeac7507e..c2389d03bb59 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -13,7 +13,6 @@
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 221c3c6438a7..3a7ec085d939 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -11,7 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/memcontrol.h>
 #include <linux/highmem.h>
-
+#include <linux/pte_ref.h>
 #include <linux/refcount.h>
 
 /*
@@ -222,6 +222,8 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	if (pvmw->pte && !PageHuge(pvmw->page))
+		pte_put(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..5762f3abfd55 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -206,6 +206,9 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
 
+	if (!new_page)
+		pte_put(mm, pte_to_pmd(pvmw.pte), addr);
+
 	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
 		munlock_vma_page(old_page);
 	put_page(old_page);
diff --git a/mm/filemap.c b/mm/filemap.c
index eeac0e119cf5..7f2eb64e5c76 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1701,6 +1701,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			return false;
 
+		pte_put_vmf(vmf);
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
@@ -1713,6 +1714,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
+			pte_put_vmf(vmf);
 			mmap_read_unlock(mm);
 			return false;
 		}
@@ -3197,32 +3199,30 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	struct mm_struct *mm = vmf->vma->vm_mm;
 
 	/* Huge page is mapped? No need to proceed. */
-	if (pmd_trans_huge(*vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
-	}
+	if (pmd_trans_huge(*vmf->pmd))
+		goto out;
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
-	if (pmd_none(*vmf->pmd))
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+	if (IS_ENABLED(CONFIG_FREE_USER_PTE) || pmd_none(*vmf->pmd))
+		pmd_install_get(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	/* See comment in handle_pte_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd)) {
-		unlock_page(page);
-		put_page(page);
-		return true;
-	}
+	if (pmd_devmap_trans_unstable(vmf->pmd))
+		goto out;
 
 	return false;
+out:
+	unlock_page(page);
+	put_page(page);
+	return true;
 }
 
 static struct page *next_uptodate_page(struct page *page,
@@ -3292,10 +3292,12 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long addr;
+	unsigned long start;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	unsigned int nr_get = 0;
 
 	rcu_read_lock();
 	head = first_map_page(mapping, &xas, end_pgoff);
@@ -3307,7 +3309,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	start = addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
 		page = find_subpage(head, xas.xa_index);
@@ -3329,6 +3331,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			ret = VM_FAULT_NOPAGE;
 
 		do_set_pte(vmf, page, addr);
+		nr_get++;
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, addr, vmf->pte);
 		unlock_page(head);
@@ -3338,6 +3341,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		put_page(head);
 	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_get_many(vmf->pmd, nr_get);
+	pte_put(vma->vm_mm, vmf->pmd, start);
 out:
 	rcu_read_unlock();
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
diff --git a/mm/gup.c b/mm/gup.c
index 2630ed1bb4f4..30757f3b176c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
+	if (!pte_try_get(mm, pmd))
+		return no_page_table(vma, flags);
+
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
 	if (!pte_present(pte)) {
@@ -517,6 +520,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		if (!is_migration_entry(entry))
 			goto no_page;
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		migration_entry_wait(mm, pmd, address);
 		goto retry;
 	}
@@ -524,6 +528,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto no_page;
 	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		return NULL;
 	}
 
@@ -612,9 +617,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 out:
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmd, address);
 	return page;
 no_page:
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmd, address);
 	if (!pte_none(pte))
 		return NULL;
 	return no_page_table(vma, flags);
diff --git a/mm/hmm.c b/mm/hmm.c
index fad6be2bf072..29bb379510cc 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -380,6 +380,9 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
+	if (!pte_try_get(walk->mm, pmdp))
+		goto again;
+
 	ptep = pte_offset_map(pmdp, addr);
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
 		int r;
@@ -391,6 +394,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		}
 	}
 	pte_unmap(ptep - 1);
+	pte_put(walk->mm, pmdp, start);
 	return 0;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index c1e23fa563a7..5cebb4ee1792 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -466,6 +466,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	if (fault_flag_allow_retry_first(flags) &&
 	    !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
 		fpin = get_file(vmf->vma->vm_file);
+		pte_put_vmf(vmf);
 		mmap_read_unlock(vmf->vma->vm_mm);
 	}
 	return fpin;
diff --git a/mm/ksm.c b/mm/ksm.c
index 08092e6f0b73..d0d72dd1eaf0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1138,6 +1138,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
+	if (!pte_try_get(mm, pmd))
+		goto out;
+
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1187,6 +1190,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	err = 0;
 out_mn:
 	mmu_notifier_invalidate_range_end(&range);
+	pte_put(mm, pmd, addr);
 out:
 	return err;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..1494da73281c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -191,7 +191,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 
-	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+	if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
+	    !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -215,6 +216,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		if (page)
 			put_page(page);
 	}
+	pte_put(vma->vm_mm, pmd, start);
 
 	return 0;
 }
@@ -318,6 +320,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct page *page = NULL;
 	LIST_HEAD(page_list);
+	unsigned long start = addr;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -392,6 +395,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (!pte_try_get(vma->vm_mm, pmd))
+		return 0;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -471,6 +477,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -580,14 +587,17 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	int nr_swap = 0;
 	unsigned long next;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd) || !pte_try_get(mm, pmd))
 		return 0;
+	nr_put++;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -612,6 +622,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			nr_swap--;
 			free_swap_and_cache(entry);
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			continue;
 		}
 
@@ -696,6 +707,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7c205a1852..f7d203ce14af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5795,6 +5795,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -5809,13 +5810,14 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd) || !pte_try_get(vma->vm_mm, pmd))
 		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	return 0;
@@ -5995,6 +5997,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -6030,6 +6033,8 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 retry:
+	if (!pte_try_get(vma->vm_mm, pmd))
+		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
@@ -6080,6 +6085,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	if (addr != end) {
diff --git a/mm/memory.c b/mm/memory.c
index d1efb868e682..8fcef8b67971 100644
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
@@ -822,6 +834,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_swp_clear_uffd_wp(pte);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -890,6 +903,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		/* Uffd-wp needs to be delivered to dest pte as well */
 		pte = pte_wrprotect(pte_mkuffd_wp(pte));
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -942,6 +956,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_clear_uffd_wp(pte);
 
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
+	pte_get(pte_to_pmd(dst_pte));
 	return 0;
 }
 
@@ -983,7 +998,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	progress = 0;
 	init_rss_vec(rss);
 
-	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
+	dst_pte = pte_alloc_get_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
 		ret = -ENOMEM;
 		goto out;
@@ -1071,8 +1086,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		goto out;
 	} else if (ret ==  -EAGAIN) {
 		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
-		if (!prealloc)
-			return -ENOMEM;
+		if (!prealloc) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	} else if (ret) {
 		VM_WARN_ON_ONCE(1);
 	}
@@ -1080,11 +1097,14 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	/* We've captured and resolved the error. Reset, try again. */
 	ret = 0;
 
-	if (addr != end)
+	if (addr != end) {
+		pte_put(dst_mm, dst_pmd, addr);
 		goto again;
+	}
 out:
 	if (unlikely(prealloc))
 		put_page(prealloc);
+	pte_put(dst_mm, dst_pmd, addr);
 	return ret;
 }
 
@@ -1103,9 +1123,13 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		return -ENOMEM;
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
+		pmd_t pmdval;
+
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+retry:
+		pmdval = READ_ONCE(*src_pmd);
+		if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval)
+			|| pmd_devmap(pmdval)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1118,9 +1142,14 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
+		if (!pte_try_get(src_mm, src_pmd))
+			goto retry;
 		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-				   addr, next))
+				   addr, next)) {
+			pte_put(src_mm, src_pmd, addr);
 			return -ENOMEM;
+		}
+		pte_put(src_mm, src_pmd, addr);
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1278,6 +1307,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	unsigned int nr_put = 0;
+	unsigned long start = addr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1310,6 +1341,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			nr_put++;
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
@@ -1352,6 +1384,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			nr_put++;
 			rss[mm_counter(page)]--;
 
 			if (is_device_private_entry(entry))
@@ -1376,6 +1409,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		nr_put++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1402,6 +1436,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (nr_put)
+		pte_put_many(mm, pmd, start, nr_put);
+
 	return addr;
 }
 
@@ -1441,9 +1478,11 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 * because MADV_DONTNEED holds the mmap_lock in read
 		 * mode.
 		 */
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+		if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
+		    !pte_try_get(tlb->mm, pmd))
 			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
+		pte_put(tlb->mm, pmd, addr);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -1698,7 +1737,7 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 	if (!pmd)
 		return NULL;
-	return pte_alloc_map_lock(mm, pmd, addr, ptl);
+	return pte_alloc_get_map_lock(mm, pmd, addr, ptl);
 }
 
 static int validate_page_before_insert(struct page *page)
@@ -1719,6 +1758,7 @@ static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
 	inc_mm_counter_fast(mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	pte_get(pte_to_pmd(pte));
 	return 0;
 }
 
@@ -1746,6 +1786,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 		goto out;
 	retval = insert_page_into_pte_locked(mm, pte, addr, page, prot);
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 out:
 	return retval;
 }
@@ -1789,7 +1830,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	/* Allocate the PTE if necessary; takes PMD lock once only. */
 	ret = -ENOMEM;
-	if (pte_alloc(mm, pmd))
+	if (pte_alloc_get(mm, pmd))
 		goto out;
 
 	while (pages_to_write_in_pmd) {
@@ -1816,6 +1857,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	if (remaining_pages_total)
 		goto more;
 	ret = 0;
+	pte_put(mm, pmd, addr);
 out:
 	*num = remaining_pages_total;
 	return ret;
@@ -2039,10 +2081,12 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	set_pte_at(mm, addr, pte, entry);
+	pte_get(pte_to_pmd(pte));
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
 out_unlock:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pte_to_pmd(pte), addr);
 	return VM_FAULT_NOPAGE;
 }
 
@@ -2246,8 +2290,10 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
+	unsigned int nr_get = 0;
+	unsigned long start_addr = addr;
 
-	mapped_pte = pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_alloc_get_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 	arch_enter_lazy_mmu_mode();
@@ -2258,10 +2304,13 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			break;
 		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
+		nr_get++;
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_get_many(pmd, nr_get);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(mm, pmd, start_addr);
 	return err;
 }
 
@@ -2474,13 +2523,17 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte, *mapped_pte;
 	int err = 0;
 	spinlock_t *ptl;
+	unsigned int nr_put = 0;
+	unsigned int nr_get = 0;
+	unsigned long start = addr;
 
 	if (create) {
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_alloc_kernel_track(pmd, addr, mask) :
-			pte_alloc_map_lock(mm, pmd, addr, &ptl);
+			pte_alloc_get_map_lock(mm, pmd, addr, &ptl);
 		if (!pte)
 			return -ENOMEM;
+		nr_put++;
 	} else {
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_offset_kernel(pmd, addr) :
@@ -2495,17 +2548,30 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		do {
 			if (create || !pte_none(*pte)) {
 				err = fn(pte++, addr, data);
-				if (err)
-					break;
+				if (IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+					mm != &init_mm && !pte_none(*(pte-1)))
+					nr_get++;
+			} else if (!pte_none(*pte)) {
+				err = fn(pte++, addr, data);
+				if (IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+					mm != &init_mm && pte_none(*(pte-1)))
+					nr_put++;
 			}
+			if (err)
+				break;
 		} while (addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
 	arch_leave_lazy_mmu_mode();
 
-	if (mm != &init_mm)
+	if (mm != &init_mm) {
 		pte_unmap_unlock(mapped_pte, ptl);
+		pte_get_many(pmd, nr_get);
+		if (nr_put)
+			pte_put_many(mm, pmd, start, nr_put);
+	}
+
 	return err;
 }
 
@@ -2529,6 +2595,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	}
 	do {
 		next = pmd_addr_end(addr, end);
+retry:
 		if (pmd_none(*pmd) && !create)
 			continue;
 		if (WARN_ON_ONCE(pmd_leaf(*pmd)))
@@ -2538,8 +2605,12 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 				continue;
 			pmd_clear_bad(pmd);
 		}
+		if (!create && !pte_try_get(mm, pmd))
+			goto retry;
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
+		if (!create)
+			pte_put(mm, pmd, addr);
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
@@ -3689,7 +3760,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_get() instead of pte_alloc_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
@@ -3698,7 +3769,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
+	if (pte_alloc_get(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
 	/* See comment in handle_pte_fault() */
@@ -3722,7 +3793,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		/* Deliver the page fault to userland, check inside PT lock */
 		if (userfaultfd_missing(vma)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
+			ret = handle_userfault(vmf, VM_UFFD_MISSING);
+			goto put;
 		}
 		goto setpte;
 	}
@@ -3765,7 +3837,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		put_page(page);
-		return handle_userfault(vmf, VM_UFFD_MISSING);
+		ret = handle_userfault(vmf, VM_UFFD_MISSING);
+		goto put;
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3773,19 +3846,23 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	pte_get(vmf->pmd);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return ret;
+	goto put;
 release:
 	put_page(page);
 	goto unlock;
 oom_free_page:
 	put_page(page);
 oom:
-	return VM_FAULT_OOM;
+	ret = VM_FAULT_OOM;
+put:
+	pte_put(vma->vm_mm, vmf->pmd, vmf->address);
+	return ret;
 }
 
 /*
@@ -3813,7 +3890,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				unlock_page(B)
 	 *				# flush A, B to clear the writeback
 	 */
-	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
+	if (!vmf->prealloc_pte) {
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
@@ -3983,6 +4060,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+retry:
 	if (pmd_none(*vmf->pmd)) {
 		if (PageTransCompound(page)) {
 			ret = do_set_pmd(vmf, page);
@@ -3991,9 +4069,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			pmd_install_get(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc_get(vma->vm_mm, vmf->pmd)))
 			return VM_FAULT_OOM;
+	} else if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+		goto retry;
 	}
 
 	/* See comment in handle_pte_fault() */
@@ -4004,13 +4084,16 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_none(*vmf->pte))) {
 		do_set_pte(vmf, page, vmf->address);
-	else
+		pte_get(vmf->pmd);
+	} else {
 		ret = VM_FAULT_NOPAGE;
+	}
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	pte_put(vma->vm_mm, vmf->pmd, vmf->address);
 	return ret;
 }
 
@@ -4232,9 +4315,15 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		 * If we find a migration pmd entry or a none pmd entry, which
 		 * should never happen, return SIGBUS
 		 */
-		if (unlikely(!pmd_present(*vmf->pmd)))
+		if (unlikely(!pmd_present(*vmf->pmd))) {
 			ret = VM_FAULT_SIGBUS;
-		else {
+			goto out;
+		} else {
+			if (!pte_try_get(vma->vm_mm, vmf->pmd)) {
+				ret = VM_FAULT_SIGBUS;
+				goto out;
+			}
+
 			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
 						       vmf->pmd,
 						       vmf->address,
@@ -4252,6 +4341,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 				ret = VM_FAULT_NOPAGE;
 
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			pte_put(vma->vm_mm, vmf->pmd, vmf->address);
 		}
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
@@ -4265,6 +4355,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		pte_free(vm_mm, vmf->prealloc_pte);
 		vmf->prealloc_pte = NULL;
 	}
+out:
 	return ret;
 }
 
@@ -4460,10 +4551,12 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
+	vm_fault_t ret;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
+retry:
+	if (unlikely(pmd_none(READ_ONCE(*vmf->pmd)))) {
 		/*
-		 * Leave __pte_alloc() until later: because vm_ops->fault may
+		 * Leave __pte_alloc_get() until later: because vm_ops->fault may
 		 * want to allocate huge page, and if we expose page table
 		 * for an instant, it will be difficult to retract from
 		 * concurrent faults and from rmap lookups.
@@ -4484,6 +4577,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
+
+		if (!pte_try_get(vmf->vma->vm_mm, vmf->pmd))
+			goto retry;
+
+		if (IS_ENABLED(CONFIG_FREE_USER_PTE))
+			vmf->flags |= FAULT_FLAG_PTE_GET;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd from under us anymore at this point because we hold the
@@ -4505,6 +4605,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		if (pte_none(vmf->orig_pte)) {
 			pte_unmap(vmf->pte);
 			vmf->pte = NULL;
+			pte_put_vmf(vmf);
 		}
 	}
 
@@ -4515,11 +4616,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+	if (!pte_present(vmf->orig_pte)) {
+		ret = do_swap_page(vmf);
+		goto put;
+	}
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
-		return do_numa_page(vmf);
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		ret = do_numa_page(vmf);
+		goto put;
+	}
 
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
@@ -4529,8 +4634,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		goto unlock;
 	}
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		if (!pte_write(entry))
-			return do_wp_page(vmf);
+		if (!pte_write(entry)) {
+			ret = do_wp_page(vmf);
+			goto put;
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -4552,7 +4659,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return 0;
+	ret = 0;
+put:
+	pte_put_vmf(vmf);
+	return ret;
 }
 
 /*
@@ -4889,13 +4999,22 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 					(address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
+	if (!pte_try_get(mm, pmd))
+		goto out;
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
 	if (!pte_present(*ptep))
 		goto unlock;
+	/*
+	 * when we reach here, it means that the ->pte_refcount is at least
+	 * one and the contents of the PTE page table are stable until @ptlp is
+	 * released, so we can put pte safely.
+	 */
+	pte_put(mm, pmd, address);
 	*ptepp = ptep;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
+	pte_put(mm, pmd, address);
 	if (range)
 		mmu_notifier_invalidate_range_end(range);
 out:
@@ -5022,6 +5141,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 		return -EINVAL;
 	pte = *ptep;
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(vma->vm_mm, pte_to_pmd(ptep), addr);
 
 	prot = pgprot_val(pte_pgprot(pte));
 	phys_addr = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9d3afa015fac..acef7df762a9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -508,6 +508,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -517,7 +518,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	/* THP was split, fall through to pte walk */
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(pmd) || !pte_try_get(walk->mm, pmd))
 		return 0;
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
@@ -553,6 +554,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 
 	if (has_unmovable)
diff --git a/mm/migrate.c b/mm/migrate.c
index 7a03a61bbcd8..a3bcef1430c9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2298,6 +2298,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
+	if (!pte_try_get(mm, pmdp))
+		goto again;
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	arch_enter_lazy_mmu_mode();
 
@@ -2419,6 +2421,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(mm, pmdp, start);
 
 	/* Only flush the TLB if we actually modified any entries */
 	if (unmapped)
@@ -2826,7 +2829,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 
 	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
+	 * Use pte_alloc_get() instead of pte_alloc_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
@@ -2835,7 +2838,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	 *
 	 * Here we only have mmap_read_lock(mm).
 	 */
-	if (pte_alloc(mm, pmdp))
+	if (pte_alloc_get(mm, pmdp))
 		goto abort;
 
 	/* See the comment in pte_alloc_one_map() */
@@ -2843,9 +2846,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 
 	if (unlikely(anon_vma_prepare(vma)))
-		goto abort;
+		goto put;
 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
-		goto abort;
+		goto put;
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
@@ -2914,15 +2917,19 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	} else {
 		/* No need to invalidate - it was non-present before */
 		set_pte_at(mm, addr, ptep, entry);
+		pte_get(pmdp);
 		update_mmu_cache(vma, addr, ptep);
 	}
 
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmdp, addr);
 	*src = MIGRATE_PFN_MIGRATE;
 	return;
 
 unlock_abort:
 	pte_unmap_unlock(ptep, ptl);
+put:
+	pte_put(mm, pmdp, addr);
 abort:
 	*src &= ~MIGRATE_PFN_MIGRATE;
 }
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..0401b526adee 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -18,6 +18,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/pte_ref.h>
 
 #include <linux/uaccess.h>
 
@@ -104,6 +105,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *ptep;
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -112,7 +114,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd)) {
+	if (pmd_trans_unstable(pmd) || !pte_try_get(walk->mm, pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
@@ -148,6 +150,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		vec++;
 	}
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(walk->mm, pmd, start);
 out:
 	walk->private += nr;
 	cond_resched();
diff --git a/mm/mlock.c b/mm/mlock.c
index e263d62ae2d0..a4ef20ba9627 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -398,6 +398,7 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 			break;
 	}
 	pte_unmap_unlock(pte, ptl);
+	pte_put(vma->vm_mm, pte_to_pmd(pte), start);
 	return start;
 }
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..53b412423ee8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -234,9 +234,12 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	pmd = pmd_offset(pud, addr);
 	do {
 		unsigned long this_pages;
+		pmd_t pmdval;
 
 		next = pmd_addr_end(addr, end);
 
+retry:
+		pmdval = READ_ONCE(*pmd);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -245,7 +248,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * Hence, it's necessary to atomically read the PMD value
 		 * for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		if (!is_swap_pmd(pmdval) && !pmd_devmap(pmdval) &&
 		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
 			goto next;
 
@@ -257,7 +260,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(pmdval) || pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
@@ -276,8 +279,11 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
+		if (!pte_try_get(vma->vm_mm, pmd))
+			goto retry;
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
 					      cp_flags);
+		pte_put(vma->vm_mm, pmd, addr);
 		pages += this_pages;
 next:
 		cond_resched();
diff --git a/mm/mremap.c b/mm/mremap.c
index c0b6c41b7b78..461dcb2de18a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -141,6 +141,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	unsigned long old_start = old_addr;
+	unsigned int nr_put = 0;
+	unsigned int nr_get = 0;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -181,6 +184,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 			continue;
 
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
+		nr_put++;
 		/*
 		 * If we are remapping a valid PTE, make sure
 		 * to flush TLB before we drop the PTL for the
@@ -197,7 +201,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
+		nr_get++;
 	}
+	pte_get_many(new_pmd, nr_get);
 
 	arch_leave_lazy_mmu_mode();
 	if (force_flush)
@@ -206,6 +212,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
+	if (nr_put)
+		pte_put_many(mm, old_pmd, old_start, nr_put);
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
 }
@@ -271,6 +279,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
+	pte_migrate_pmd(pmd, new_pmd);
 	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -548,10 +557,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				continue;
 		}
 
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc_get(new_vma->vm_mm, new_pmd))
 			break;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
+		pte_put(new_vma->vm_mm, new_pmd, new_addr);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..eb84fa5825c0 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -211,6 +211,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		}
 
 		pvmw->pmd = pmd_offset(pud, pvmw->address);
+retry:
 		/*
 		 * Make sure the pmd value isn't cached in a register by the
 		 * compiler and used as a stale value after we've observed a
@@ -258,6 +259,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+		if (!pte_try_get(pvmw->vma->vm_mm, pvmw->pmd))
+			goto retry;
 		if (!map_pte(pvmw))
 			goto next_pte;
 this_pte:
@@ -275,6 +278,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					pvmw->ptl = NULL;
 				}
 				pte_unmap(pvmw->pte);
+				pte_put(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
 				pvmw->pte = NULL;
 				goto restart;
 			}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..da1324021429 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/pte_ref.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -110,6 +111,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 again:
 		next = pmd_addr_end(addr, end);
+retry:
 		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -147,10 +149,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				goto again;
 		}
 
-		if (is_hugepd(__hugepd(pmd_val(*pmd))))
+		if (is_hugepd(__hugepd(pmd_val(*pmd)))) {
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
-		else
-			err = walk_pte_range(pmd, addr, next, walk);
+		} else {
+			if (!walk->no_vma) {
+				if (!pte_try_get(walk->mm, pmd))
+					goto retry;
+				err = walk_pte_range(pmd, addr, next, walk);
+				pte_put(walk->mm, pmd, addr);
+			} else {
+				err = walk_pte_range(pmd, addr, next, walk);
+			}
+		}
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 630704ae26db..dfbf817b7367 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -74,11 +74,6 @@ void pmd_install_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 	spin_unlock(ptl);
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
-{
-	pmd_install_get(mm, pmd, pte);
-}
-
 int __pte_alloc_get(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t new = pte_alloc_one(mm);
diff --git a/mm/rmap.c b/mm/rmap.c
index 09c41e1f44d8..eac31f3bca05 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1402,6 +1402,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned int nr_put = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1549,6 +1550,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
+			nr_put++;
 		} else if (PageAnon(page)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
@@ -1562,6 +1564,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				/* We have to invalidate as we cleared the pte */
 				mmu_notifier_invalidate_range(mm, address,
 							address + PAGE_SIZE);
+				nr_put++;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
@@ -1573,6 +1576,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
 					dec_mm_counter(mm, MM_ANONPAGES);
+					nr_put++;
 					goto discard;
 				}
 
@@ -1628,6 +1632,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 * See Documentation/vm/mmu_notifier.rst
 			 */
 			dec_mm_counter(mm, mm_counter_file(page));
+			nr_put++;
 		}
 discard:
 		/*
@@ -1641,6 +1646,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		put_page(page);
 	}
 
+	if (nr_put)
+		pte_put_many(mm, pvmw.pmd, address, nr_put);
+
 	mmu_notifier_invalidate_range_end(&range);
 
 	return ret;
@@ -1702,6 +1710,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned int nr_put = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1865,6 +1874,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
+			nr_put++;
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
@@ -1911,6 +1921,9 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		put_page(page);
 	}
 
+	if (nr_put)
+		pte_put_many(mm, pvmw.pmd, address, nr_put);
+
 	mmu_notifier_invalidate_range_end(&range);
 
 	return ret;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f..10ebfc94208a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2021,10 +2021,12 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+		if (pmd_none_or_trans_huge_or_clear_bad(pmd) ||
+		    !pte_try_get(vma->vm_mm, pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
+		pte_put(vma->vm_mm, pmd, addr);
 		if (ret)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 36e5f6ab976f..7661929b27bf 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -111,6 +111,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
@@ -205,6 +206,7 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	pte_get(dst_pmd);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
@@ -589,12 +591,15 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			break;
 		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+		    unlikely(__pte_alloc_get(dst_mm, dst_pmd))) {
 			err = -ENOMEM;
 			break;
-		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		} else if (unlikely(pmd_trans_huge(*dst_pmd)) ||
+			   !pte_try_get(dst_mm, dst_pmd)) {
+			/*
+			 * If an huge pmd materialized from under us fail or the
+			 * pte populated in the dst_pmd was freed.
+			 */
 			err = -EFAULT;
 			break;
 		}
@@ -604,6 +609,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
+		pte_put(dst_mm, dst_pmd, dst_addr);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.11.0

