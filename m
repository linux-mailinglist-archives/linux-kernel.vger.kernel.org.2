Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07FC44BF34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKJK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhKJK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB5FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so1249710pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKDF6fzfiXc8Vyvfw72GJavPYu3r53WCuZUQ+TXvJhw=;
        b=c+RZgiWHPvKXp4uYhSTWNM+SWj8/NqMRWY5bY15HxWfIP3r/q4PpltIqf7LhSKqjO6
         sRVY+qivnZOw51j+Yg7diwaQu2lJL3gzjRlVAaPcHAdlgMp4ADwt/l2auGMuGLRi5BLl
         btoxwPQsD7ApE6Qq2MW7oP2QnHAXg0v4qF+YxkuQr/zhuGG5z8OyE5wxE2LqhQ9psRVJ
         2beiqJH8f3ouRkssyUP5vPwjJRmM3yhnSPiK9aQipnmTzB5XdhQ91POvnqxOx/2Z65Lf
         /ATDhSNxSA0VXCCzqjOTXqxF4b1jjBKQurPug833TYMy5o8hHkQu6/EF5jHnmfWPc5WE
         rxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKDF6fzfiXc8Vyvfw72GJavPYu3r53WCuZUQ+TXvJhw=;
        b=o/y3NDBbEhYDhpGShiDBt5nGd7/YQDDk51ImPIsSQ0weM5NI/emWDFE5ieWW91M7xC
         sXooTrig97xCEwJpQkv8ZgzcVVd9qYzC/O7dV/Ux82vpw+8BB+ASkrkiEBcBQg2SojdW
         KoW6OvP5t3MCNRJHCnHlBtV92QPwSnLRqji8Nzd4o0f4UibNaiCi0hU2vRwPx3EJNHc/
         IGXAfO23YU8e86RXIKiu06nOQA90KlnYz7Xtk2ii5WidU1ppasXwsV4aAHCkuwGDUFQK
         FEcN9mAblNm6BpuGB1vZcRHK7XHth2DtrnkUVmDimOyI782Ag/W60L3zBhIuR3t8Op9y
         GQ7A==
X-Gm-Message-State: AOAM5335kU1b9l+IZI8JyyiYu+sxJ3YeD3lHUF4rWVIrxpg3RYwaQxp7
        +P6bOEA3WXVvouUXcr2XVJULAQ==
X-Google-Smtp-Source: ABdhPJyzvJYgDdoOYpu8g1Ea3k9a8ndWoD6+0hXlBI+/XwAS7njN4MV4iRjXp/aDCaJ631NaCmD8DA==
X-Received: by 2002:a17:90a:bb84:: with SMTP id v4mr15962150pjr.4.1636541743354;
        Wed, 10 Nov 2021 02:55:43 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:42 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 11/15] mm/pte_ref: take a refcount before accessing the PTE page table page
Date:   Wed, 10 Nov 2021 18:54:24 +0800
Message-Id: <20211110105428.32458-12-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the user page table will only be released by calling
free_pgtables() when the process exits or unmap_region() is called
(e.g. munmap() path). So other threads only need to ensure mutual
exclusion with these paths to ensure that the page table is not
released. For example::

	thread A			thread B
	page table walker		munmap
	=================		======

	mmap_read_lock()
	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
		pte_offset_map_lock()
		*walk page table*
		pte_unmap_unlock()
	}
	mmap_read_unlock()

					mmap_write_lock_killable()
					detach_vmas_to_be_unmapped()
					unmap_region()
					--> free_pgtables()

But after we introduce the reference count for the user PTE page table
page, these existing balances will be broken. The page can be released
at any time when its pte_refcount is reduced to 0. Therefore, the
following case may happen::

	thread A		thread B
	page table walker	madvise(MADV_DONTNEED)
	=================	======================

	mmap_read_lock()
	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {

				mmap_read_lock()
				unmap_page_range()
				--> zap_pte_range()
				    *the pte_refcount is reduced to 0*
				    --> *free PTE page table page*

		/* broken!! */
		pte_offset_map_lock()

As we can see, all of the thread A and B hold the read lock of
mmap_lock, so they can execute concurrently. When thread B releases the
PTE page table page, the value in the corresponding pmd entry will
become unstable, which may be none or huge pmd, or map a new PTE page
table page again. This will cause system chaos and even panic.

So we need to try to take a reference to the PTE page table page before
walking page table, then the system will become orderly again::

	thread A		thread B
	page table walker	madvise(MADV_DONTNEED)
	=================	======================

	mmap_read_lock()
	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
		pte_try_get()
		--> pte_get_unless_zero
		*if successfully, then:*

				mmap_read_lock()
				unmap_page_range()
				--> zap_pte_range()
				    *the pte_refcount is reduced to 1*

		pte_offset_map_lock()
		*walk page table*
		pte_unmap_unlock()
		pte_put()
		--> *the pte_refcount is reduced to 0*
		    --> *free PTE page table page*

There is also a lock-less scenario(such as fast GUP). Fortunately, we
don't need to do any additional operations to ensure that the system is
in order. Take fast GUP as an example::

	thread A		thread B
	fast GUP		madvise(MADV_DONTNEED)
	========		======================

	get_user_pages_fast_only()
	--> local_irq_save();
				*free PTE page table page*
				--> unhook page
				    /* The CPU where thread A is
				     * located closed the local
				     * interrupt and cannot respond to
				     * IPI, so it will block here
				     */
				    TLB invalidate page
	    gup_pgd_range();
	    local_irq_restore();
	    			    *free page*

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/task_mmu.c   | 24 ++++++++++++++---
 fs/userfaultfd.c     |  8 ++++--
 include/linux/rmap.h |  2 ++
 mm/damon/vaddr.c     | 12 +++++++--
 mm/gup.c             | 13 ++++++++--
 mm/hmm.c             |  5 +++-
 mm/khugepaged.c      | 13 ++++++++--
 mm/ksm.c             |  6 ++++-
 mm/madvise.c         | 16 +++++++++---
 mm/memcontrol.c      | 12 +++++++--
 mm/memory-failure.c  | 11 ++++++--
 mm/memory.c          | 73 +++++++++++++++++++++++++++++++++++++---------------
 mm/mempolicy.c       |  6 ++++-
 mm/migrate.c         | 27 ++++++++++++-------
 mm/mincore.c         |  7 ++++-
 mm/mprotect.c        | 11 +++++---
 mm/page_vma_mapped.c |  4 +++
 mm/pagewalk.c        | 15 ++++++++---
 mm/swapfile.c        |  3 +++
 19 files changed, 209 insertions(+), 59 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..82dd5fd540ce 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -581,6 +581,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -596,10 +597,13 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	 * keeps khugepaged out of here and from collapsing things
 	 * in here.
 	 */
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		goto out;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 out:
 	cond_resched();
 	return 0;
@@ -1124,6 +1128,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -1149,7 +1154,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
@@ -1171,6 +1178,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ClearPageReferenced(page);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 	return 0;
 }
@@ -1410,6 +1418,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
@@ -1482,7 +1491,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	 * We can assume that @vma always points to a valid one and @end never
 	 * goes beyond vma->vm_end.
 	 */
-	orig_pte = pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(walk->mm, pmdp, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		pagemap_entry_t pme;
 
@@ -1492,6 +1503,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			break;
 	}
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmdp, start);
 
 	cond_resched();
 
@@ -1798,6 +1810,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte;
 	pte_t *pte;
+	unsigned long start = addr;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -1815,7 +1828,9 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
-	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
 		if (!page)
@@ -1824,6 +1839,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 	return 0;
 }
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ddbcefa7e0a6..d1e18e5f3a13 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -297,6 +297,8 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pud_present(*pud))
 		goto out;
 	pmd = pmd_offset(pud, address);
+
+retry:
 	/*
 	 * READ_ONCE must function as a barrier with narrower scope
 	 * and it must be equivalent to:
@@ -323,7 +325,9 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 * the pmd is stable (as in !pmd_trans_unstable) so we can re-read it
 	 * and use the standard pte_offset_map() instead of parsing _pmd.
 	 */
-	pte = pte_offset_map(pmd, address);
+	pte = pte_tryget_map(pmd, address);
+	if (!pte)
+		goto retry;
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
@@ -333,7 +337,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
-
+	pte_put(mm, pmd, address);
 out:
 	return ret;
 }
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 221c3c6438a7..5bd76fb8b93a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -222,6 +222,8 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	if (pvmw->pte && !PageHuge(pvmw->page))
+		pte_put(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..8b816f92a563 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -373,6 +373,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 	spinlock_t *ptl;
 
+retry:
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
 		if (pmd_huge(*pmd)) {
@@ -385,12 +386,15 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return 0;
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		goto retry;
 	if (!pte_present(*pte))
 		goto out;
 	damon_ptep_mkold(pte, walk->mm, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(walk->mm, pmd, addr);
 	return 0;
 }
 
@@ -446,6 +450,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct page *page;
 	struct damon_young_walk_private *priv = walk->private;
 
+retry:
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
@@ -473,7 +478,9 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return -EINVAL;
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		goto retry;
 	if (!pte_present(*pte))
 		goto out;
 	page = damon_get_page(pte_pfn(*pte));
@@ -487,6 +494,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	put_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(walk->mm, pmd, addr);
 	return 0;
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index e084111103f0..7b6d024ad5c7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -488,7 +488,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
-	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmd, address, &ptl);
+	if (!ptep)
+		return no_page_table(vma, flags);
 	pte = *ptep;
 	if (!pte_present(pte)) {
 		swp_entry_t entry;
@@ -505,6 +507,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		if (!is_migration_entry(entry))
 			goto no_page;
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		migration_entry_wait(mm, pmd, address);
 		goto retry;
 	}
@@ -512,6 +515,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto no_page;
 	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, address);
 		return NULL;
 	}
 
@@ -600,9 +604,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
@@ -885,7 +891,9 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	if (!pmd_present(*pmd))
 		return -EFAULT;
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	pte = pte_offset_map(pmd, address);
+	pte = pte_tryget_map(pmd, address);
+	if (!pte)
+		return -EFAULT;
 	if (pte_none(*pte))
 		goto unmap;
 	*vma = get_gate_vma(mm);
@@ -905,6 +913,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	ret = 0;
 unmap:
 	pte_unmap(pte);
+	pte_put(mm, pmd, address);
 	return ret;
 }
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 842e26599238..b8917a5ae442 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -383,7 +383,9 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	ptep = pte_offset_map(pmdp, addr);
+	ptep = pte_tryget_map(pmdp, addr);
+	if (!ptep)
+		goto again;
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
 		int r;
 
@@ -394,6 +396,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		}
 	}
 	pte_unmap(ptep - 1);
+	pte_put(walk->mm, pmdp, start);
 	return 0;
 }
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 92b0494f4a00..5842c0774d70 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1249,7 +1249,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
-	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	pte = pte_tryget_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
 	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
@@ -1370,6 +1374,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
+	pte_put(mm, pmd, address);
 	if (ret) {
 		node = khugepaged_find_target_node();
 		/* collapse_huge_page will return with the mmap_lock released */
@@ -1472,7 +1477,9 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!pmd)
 		goto drop_hpage;
 
-	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
+	start_pte = pte_tryget_map_lock(mm, pmd, haddr, &ptl);
+	if (!start_pte)
+		goto drop_hpage;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1510,6 +1517,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
@@ -1531,6 +1539,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+	pte_put(mm, pmd, haddr);
 	goto drop_hpage;
 }
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 0662093237e4..94aeaed42c1f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1140,9 +1140,12 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 				addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto out_mn;
 	if (!pte_same(*ptep, orig_pte)) {
 		pte_unmap_unlock(ptep, ptl);
+		pte_put(mm, pmd, addr);
 		goto out_mn;
 	}
 
@@ -1182,6 +1185,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	put_page(page);
 
 	pte_unmap_unlock(ptep, ptl);
+	pte_put(mm, pmd, addr);
 	err = 0;
 out_mn:
 	mmu_notifier_invalidate_range_end(&range);
diff --git a/mm/madvise.c b/mm/madvise.c
index 82fc40b6dcbf..5cf2832abb98 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -200,9 +200,12 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+		orig_pte = pte_tryget_map_lock(vma->vm_mm, pmd, start, &ptl);
+		if (!orig_pte)
+			continue;
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
+		pte_put(vma->vm_mm, pmd, start);
 
 		if (pte_present(pte) || pte_none(pte))
 			continue;
@@ -317,6 +320,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page = NULL;
+	unsigned long start = addr;
 	LIST_HEAD(page_list);
 
 	if (fatal_signal_pending(current))
@@ -393,7 +397,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		return 0;
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
@@ -471,6 +477,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -592,7 +599,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
+	nr_put++;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..7283044d4f64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5773,6 +5773,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -5789,11 +5790,14 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	return 0;
@@ -5973,6 +5977,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct page *page;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -6008,7 +6013,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 retry:
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
 		bool device = false;
@@ -6058,6 +6065,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 	}
 	pte_unmap_unlock(pte - 1, ptl);
+	pte_put(vma->vm_mm, pmd, start);
 	cond_resched();
 
 	if (addr != end) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f64ebb6226cb..6f281e827c32 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -331,10 +331,13 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 		return 0;
 	if (pmd_devmap(*pmd))
 		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
+	pte = pte_tryget_map(pmd, address);
+	if (!pte)
+		return 0;
 	if (pte_present(*pte) && pte_devmap(*pte))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
+	pte_put(vma->vm_mm, pmd, address);
 	return ret;
 }
 
@@ -634,6 +637,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	int ret = 0;
 	pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
 	if (ptl) {
@@ -645,8 +649,10 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	if (pmd_trans_unstable(pmdp))
 		goto out;
 
-	mapped_pte = ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp,
+	mapped_pte = ptep = pte_tryget_map_lock(walk->vma->vm_mm, pmdp,
 						addr, &ptl);
+	if (!ptep)
+		goto out;
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
 					     hwp->pfn, &hwp->tk);
@@ -654,6 +660,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(walk->vma->vm_mm, pmdp, start);
 out:
 	cond_resched();
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 5cc4ce0af665..e360ecd37a71 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1165,7 +1165,8 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_huge_pmd(*src_pmd)) {
+retry:
+		if (is_huge_pmd(READ_ONCE(*src_pmd))) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1178,9 +1179,14 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
+		if (pte_try_get(src_pmd))
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
@@ -1494,7 +1500,10 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 */
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			goto next;
+		if (pte_try_get(pmd))
+			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
+		pte_put(tlb->mm, pmd, addr);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -2606,18 +2615,26 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 		pmd = pmd_offset(pud, addr);
 	}
 	do {
+		pmd_t pmdval;
+
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd) && !create)
+retry:
+		pmdval = READ_ONCE(*pmd);
+		if (pmd_none(pmdval) && !create)
 			continue;
-		if (WARN_ON_ONCE(pmd_leaf(*pmd)))
+		if (WARN_ON_ONCE(pmd_leaf(pmdval)))
 			return -EINVAL;
-		if (!pmd_none(*pmd) && WARN_ON_ONCE(pmd_bad(*pmd))) {
+		if (!pmd_none(pmdval) && WARN_ON_ONCE(pmd_bad(pmdval))) {
 			if (!create)
 				continue;
 			pmd_clear_bad(pmd);
 		}
+		if (!create && pte_try_get(pmd))
+			goto retry;
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
+		if (!create)
+			pte_put(mm, pmd, addr);
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
@@ -4343,26 +4360,31 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		 * If we find a migration pmd entry or a none pmd entry, which
 		 * should never happen, return SIGBUS
 		 */
-		if (unlikely(!pmd_present(*vmf->pmd)))
+		if (unlikely(!pmd_present(*vmf->pmd))) {
 			ret = VM_FAULT_SIGBUS;
-		else {
-			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
+		} else {
+			vmf->pte = pte_tryget_map_lock(vmf->vma->vm_mm,
 						       vmf->pmd,
 						       vmf->address,
 						       &vmf->ptl);
-			/*
-			 * Make sure this is not a temporary clearing of pte
-			 * by holding ptl and checking again. A R/M/W update
-			 * of pte involves: take ptl, clearing the pte so that
-			 * we don't have concurrent modification by hardware
-			 * followed by an update.
-			 */
-			if (unlikely(pte_none(*vmf->pte)))
+			if (vmf->pte) {
+				/*
+				 * Make sure this is not a temporary clearing of pte
+				 * by holding ptl and checking again. A R/M/W update
+				 * of pte involves: take ptl, clearing the pte so that
+				 * we don't have concurrent modification by hardware
+				 * followed by an update.
+				 */
+				if (unlikely(pte_none(*vmf->pte)))
+					ret = VM_FAULT_SIGBUS;
+				else
+					ret = VM_FAULT_NOPAGE;
+
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				pte_put(vma->vm_mm, vmf->pmd, vmf->address);
+			} else {
 				ret = VM_FAULT_SIGBUS;
-			else
-				ret = VM_FAULT_NOPAGE;
-
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			}
 		}
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
@@ -5016,13 +5038,22 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 					(address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
-	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
+	ptep = pte_tryget_map_lock(mm, pmd, address, ptlp);
+	if (!ptep)
+		goto out;
 	if (!pte_present(*ptep))
 		goto unlock;
+	/*
+	 * when we reach here, it means that the refcount of the pte is at least
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
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 774a3d3183a7..18e57ba515dc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -508,6 +508,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -520,7 +521,9 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
@@ -553,6 +556,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
+	pte_put(walk->mm, pmd, start);
 	cond_resched();
 
 	if (has_unmovable)
diff --git a/mm/migrate.c b/mm/migrate.c
index c03ac25f42a9..5a234ddf36b1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -323,8 +323,12 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long address)
 {
 	spinlock_t *ptl = pte_lockptr(mm, pmd);
-	pte_t *ptep = pte_offset_map(pmd, address);
-	__migration_entry_wait(mm, ptep, ptl);
+	pte_t *ptep = pte_tryget_map(pmd, address);
+
+	if (ptep) {
+		__migration_entry_wait(mm, ptep, ptl);
+		pte_put(mm, pmd, address);
+	}
 }
 
 void migration_entry_wait_huge(struct vm_area_struct *vma,
@@ -2249,21 +2253,23 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	unsigned long addr = start, unmapped = 0;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	pmd_t pmdval;
 
 again:
-	if (pmd_none(*pmdp))
+	pmdval = READ_ONCE(*pmdp);
+	if (pmd_none(pmdvalp))
 		return migrate_vma_collect_hole(start, end, -1, walk);
 
-	if (pmd_trans_huge(*pmdp)) {
+	if (pmd_trans_huge(pmdval)) {
 		struct page *page;
 
 		ptl = pmd_lock(mm, pmdp);
-		if (unlikely(!pmd_trans_huge(*pmdp))) {
+		if (unlikely(!pmd_trans_huge(pmdval))) {
 			spin_unlock(ptl);
 			goto again;
 		}
 
-		page = pmd_page(*pmdp);
+		page = pmd_page(pmdval);
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmdp, addr);
@@ -2284,16 +2290,18 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (ret)
 				return migrate_vma_collect_skip(start, end,
 								walk);
-			if (pmd_none(*pmdp))
+			if (pmd_none(pmdval))
 				return migrate_vma_collect_hole(start, end, -1,
 								walk);
 		}
 	}
 
-	if (unlikely(pmd_bad(*pmdp)))
+	if (unlikely(pmd_bad(pmdval)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
@@ -2416,6 +2424,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(mm, pmdp, start);
 
 	/* Only flush the TLB if we actually modified any entries */
 	if (unmapped)
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..92e56cef2473 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -104,7 +104,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *ptep;
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
 
+retry:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		memset(vec, 1, nr);
@@ -117,7 +119,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	ptep = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto retry;
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
@@ -148,6 +152,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		vec++;
 	}
 	pte_unmap_unlock(ptep - 1, ptl);
+	pte_put(walk->mm, pmd, start);
 out:
 	walk->private += nr;
 	cond_resched();
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2d5064a4631c..5c663270b816 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -234,9 +234,11 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	pmd = pmd_offset(pud, addr);
 	do {
 		unsigned long this_pages;
+		pmd_t pmdval;
 
 		next = pmd_addr_end(addr, end);
-
+retry:
+		pmdval = READ_ONCE(*pmd);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -245,7 +247,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * Hence, it's necessary to atomically read the PMD value
 		 * for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		if (!is_swap_pmd(pmdval) && !pmd_devmap(pmdval) &&
 		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
 			goto next;
 
@@ -257,7 +259,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_huge_pmd(*pmd)) {
+		if (is_huge_pmd(pmdval)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
@@ -276,8 +278,11 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
+		if (pte_try_get(pmd))
+			goto retry;
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
 					      cp_flags);
+		pte_put(vma->vm_mm, pmd, addr);
 		pages += this_pages;
 next:
 		cond_resched();
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..4725a2f78f09 100644
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
+		if (pte_try_get(pvmw->pmd))
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
index 9b3db11a4d1d..72074a34beea 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -110,6 +110,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 again:
 		next = pmd_addr_end(addr, end);
+retry:
 		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -147,10 +148,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				goto again;
 		}
 
-		if (is_hugepd(__hugepd(pmd_val(*pmd))))
+		if (is_hugepd(__hugepd(pmd_val(*pmd)))) {
 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
-		else
-			err = walk_pte_range(pmd, addr, next, walk);
+		} else {
+			if (!walk->no_vma) {
+				if (pte_try_get(pmd))
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
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..175b35fec758 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2023,8 +2023,11 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
+		if (pte_try_get(pmd))
+			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
 				      frontswap, fs_pages_to_unuse);
+		pte_put(vma->vm_mm, pmd, addr);
 		if (ret)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
-- 
2.11.0

