Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21FE393702
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhE0UXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235762AbhE0UXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsRTgtg4IeZXx632vvcSV9nqjRspSTIPhkPklzMJhFg=;
        b=I4Yr8gAbqKCHUoDGx0neskqkMnlrBx/4erbupBiXF8glvf280BDABoFgJOtMi1H4IDcltN
        IJi1kiyhcQp9JZA657yBwPQsmKgI+XhZUiBRLLZGSuR4W0YKMaKPNOyt/mSJENUA7Eg7eI
        Es22GuJdoLud/sfJ8Kn+ajhV9agCWeE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-KYroNfmzNEiMei40kYgWvw-1; Thu, 27 May 2021 16:21:22 -0400
X-MC-Unique: KYroNfmzNEiMei40kYgWvw-1
Received: by mail-qk1-f198.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so1345834qkj.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsRTgtg4IeZXx632vvcSV9nqjRspSTIPhkPklzMJhFg=;
        b=i8IkAPorWL/DCThs5ME69l4LZhfjpe1TmmczpBlwoWM3SQmcrIgeZW6CX9A3Qv0ZuL
         y14Ci70TnmuI1lV5cNvlakL9nqQf237E6oNaGEjzK2o7VX6zEm5VFr+XiOKrZHX6yRaX
         oDdCaGoqiquFFSfxIjJfVa5ekPbP6+dH73UiNE0TWLuRoBXnCw+jo3ULvCtmbUTA9Xeg
         DglUHCrw98kQz5OjHwrt6PLpbZqi0PdJGTO//9GmHeTy04+EHwwUoclI6MQD9g85HTEG
         baC2L88SAYXHFFeamXW9D4dwWWs0W5ad/u/WT2A+n1tF+GrZeyt7yp8681VIY5IJg+7s
         zxLg==
X-Gm-Message-State: AOAM531hrTVpOlba8OBzKL+ax9/w3geXAkiv+wYELsb82U2WhIEtAFfS
        U4qPie2sZWLfv/r6Ze8tlhul7PDpSxNUHUVHg34dyoznF5n0bCmJw2pFHnYvnwv8tU1+WMvj15D
        LtmEhJIRQw7fJYQLaDVHhdckR
X-Received: by 2002:ac8:7e95:: with SMTP id w21mr366844qtj.76.1622146882034;
        Thu, 27 May 2021 13:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsu99SqphxaV5fS6RYnOwpaKyYPzTZnLgRLgGScTmj89eNlKWiyekef21U2Dc89wGhI0XgCQ==
X-Received: by 2002:ac8:7e95:: with SMTP id w21mr366795qtj.76.1622146881599;
        Thu, 27 May 2021 13:21:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id g18sm2062201qke.37.2021.05.27.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 05/27] mm/swap: Introduce the idea of special swap ptes
Date:   Thu, 27 May 2021 16:21:17 -0400
Message-Id: <20210527202117.30689-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have special swap entries, like migration entries, hw-poison
entries, device private entries, etc.

Those "special swap entries" reside in the range that they need to be at least
swap entries first, and their types are decided by swp_type(entry).

This patch introduces another idea called "special swap ptes".

It's very easy to get confused against "special swap entries", but a speical
swap pte should never contain a swap entry at all.  It means, it's illegal to
call pte_to_swp_entry() upon a special swap pte.

Make the uffd-wp special pte to be the first special swap pte.

Before this patch, is_swap_pte()==true means one of the below:

   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
         example, when an anonymous page got swapped out.

   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
         example, a migration entry, a hw-poison entry, etc.

After this patch, is_swap_pte()==true means one of the below, where case (b) is
added:

 (a) The pte contains a swap entry.

   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
         example, when an anonymous page got swapped out.

   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
         example, a migration entry, a hw-poison entry, etc.

 (b) The pte does not contain a swap entry at all (so it cannot be passed
     into pte_to_swp_entry()).  For example, uffd-wp special swap pte.

Teach the whole mm core about this new idea.  It's done by introducing another
helper called pte_has_swap_entry() which stands for case (a.1) and (a.2).
Before this patch, it will be the same as is_swap_pte() because there's no
special swap pte yet.  Now for most of the previous use of is_swap_entry() in
mm core, we'll need to use the new helper pte_has_swap_entry() instead, to make
sure we won't try to parse a swap entry from a swap special pte (which does not
contain a swap entry at all!).  We either handle the swap special pte, or it'll
naturally use the default "else" paths.

Warn properly (e.g., in do_swap_page()) when we see a special swap pte - we
should never call do_swap_page() upon those ptes, but just to bail out early if
it happens.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/kernel/mte.c |  2 +-
 fs/proc/task_mmu.c      | 14 ++++++++------
 include/linux/swapops.h | 39 ++++++++++++++++++++++++++++++++++++++-
 mm/gup.c                |  2 +-
 mm/hmm.c                |  2 +-
 mm/khugepaged.c         | 11 ++++++++++-
 mm/madvise.c            |  4 ++--
 mm/memcontrol.c         |  2 +-
 mm/memory.c             |  7 +++++++
 mm/migrate.c            |  4 ++--
 mm/mincore.c            |  2 +-
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 mm/page_vma_mapped.c    |  6 +++---
 mm/swapfile.c           |  2 +-
 15 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 125a10e413e9..a6fd3fb3eacb 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -36,7 +36,7 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
 
-	if (check_swap && is_swap_pte(old_pte)) {
+	if (check_swap && pte_has_swap_entry(old_pte)) {
 		swp_entry_t entry = pte_to_swp_entry(old_pte);
 
 		if (!non_swap_entry(entry) && mte_restore_tags(entry, page))
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..9c5af77b5290 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -498,7 +498,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (!non_swap_entry(swpent)) {
@@ -516,8 +516,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			}
 		} else if (is_pfn_swap_entry(swpent))
 			page = pfn_swap_entry_to_page(swpent);
-	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
-							&& pte_none(*pte))) {
+	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) &&
+			    mss->check_shmem_swap &&
+			    /* Here swap special pte is the same as none pte */
+			    (pte_none(*pte) || is_swap_special_pte(*pte)))) {
 		page = xa_load(&vma->vm_file->f_mapping->i_pages,
 						linear_page_index(vma, addr));
 		if (xa_is_value(page))
@@ -689,7 +691,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (is_pfn_swap_entry(swpent))
@@ -1071,7 +1073,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_has_swap_entry(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1374,7 +1376,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else if (pte_has_swap_entry(pte)) {
 		swp_entry_t entry;
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index af3d2661e41e..4a316c015fe0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -5,6 +5,7 @@
 #include <linux/radix-tree.h>
 #include <linux/bug.h>
 #include <linux/mm_types.h>
+#include <linux/userfaultfd_k.h>
 
 #ifdef CONFIG_MMU
 
@@ -52,12 +53,48 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/* check whether a pte points to a swap entry */
+/*
+ * is_swap_pte() returns true for three cases:
+ *
+ * (a) The pte contains a swap entry.
+ *
+ *   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
+ *         example, when an anonymous page got swapped out.
+ *
+ *   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
+ *         example, a migration entry, a hw-poison entry, etc.
+ *
+ * (b) The pte does not contain a swap entry at all (so it cannot be passed
+ *     into pte_to_swp_entry()).  For example, uffd-wp special swap pte.
+ */
 static inline int is_swap_pte(pte_t pte)
 {
 	return !pte_none(pte) && !pte_present(pte);
 }
 
+/*
+ * A swap-like special pte should only be used as special marker to trigger a
+ * page fault.  We should treat them similarly as pte_none() in most cases,
+ * except that it may contain some special information that can persist within
+ * the pte.  Currently the only special swap pte is UFFD_WP_SWP_PTE_SPECIAL.
+ *
+ * Note: we should never call pte_to_swp_entry() upon a special swap pte,
+ * Because a swap special pte does not contain a swap entry!
+ */
+static inline bool is_swap_special_pte(pte_t pte)
+{
+	return pte_swp_uffd_wp_special(pte);
+}
+
+/*
+ * Returns true if the pte contains a swap entry.  This includes not only the
+ * normal swp entry case, but also for migration entries, etc.
+ */
+static inline bool pte_has_swap_entry(pte_t pte)
+{
+	return is_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
diff --git a/mm/gup.c b/mm/gup.c
index 29a0c7d87024..e03590c9c68e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -485,7 +485,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		if (likely(!(flags & FOLL_MIGRATION)))
 			goto no_page;
-		if (pte_none(pte))
+		if (!pte_has_swap_entry(pte))
 			goto no_page;
 		entry = pte_to_swp_entry(pte);
 		if (!is_migration_entry(entry))
diff --git a/mm/hmm.c b/mm/hmm.c
index fad6be2bf072..aba1bf2c6742 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -239,7 +239,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	pte_t pte = *ptep;
 	uint64_t pfn_req_flags = *hmm_pfn;
 
-	if (pte_none(pte)) {
+	if (pte_none(pte) || is_swap_special_pte(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..7376a9b5bfc9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1018,7 +1018,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 
 		vmf.pte = pte_offset_map(pmd, address);
 		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte)) {
+		if (!pte_has_swap_entry(vmf.orig_pte)) {
 			pte_unmap(vmf.pte);
 			continue;
 		}
@@ -1245,6 +1245,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
+			if (is_swap_special_pte(pteval)) {
+				/*
+				 * Reuse SCAN_PTE_UFFD_WP.  If there will be
+				 * new users of is_swap_special_pte(), we'd
+				 * better introduce a new result type.
+				 */
+				result = SCAN_PTE_UFFD_WP;
+				goto out_unmap;
+			}
 			if (++unmapped <= khugepaged_max_ptes_swap) {
 				/*
 				 * Always be strict with uffd-wp
diff --git a/mm/madvise.c b/mm/madvise.c
index 012129fbfaf8..ebde36d685ad 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -204,7 +204,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
-		if (pte_present(pte) || pte_none(pte))
+		if (!pte_has_swap_entry(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
@@ -596,7 +596,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
-		if (pte_none(ptent))
+		if (pte_none(ptent) || is_swap_special_pte(ptent))
 			continue;
 		/*
 		 * If the pte has swp_entry, just clear page table to
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb864f87b01d..f684f6cf6fce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5719,7 +5719,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
-	else if (is_swap_pte(ptent))
+	else if (pte_has_swap_entry(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
 		page = mc_handle_file_pte(vma, addr, ptent, &ent);
diff --git a/mm/memory.c b/mm/memory.c
index 0ccaae2647c0..2b24af4616df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3445,6 +3445,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
+	/*
+	 * We should never call do_swap_page upon a swap special pte; just be
+	 * safe to bail out if it happens.
+	 */
+	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
+		goto out;
+
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
diff --git a/mm/migrate.c b/mm/migrate.c
index 91ee6f0941b4..2468c5d00f30 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -294,7 +294,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 
 	spin_lock(ptl);
 	pte = *ptep;
-	if (!is_swap_pte(pte))
+	if (!pte_has_swap_entry(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
@@ -2248,7 +2248,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 		pte = *ptep;
 
-		if (pte_none(pte)) {
+		if (pte_none(pte) || is_swap_special_pte(pte)) {
 			if (vma_is_anonymous(vma)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..5728c3e6473f 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -121,7 +121,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
-		if (pte_none(pte))
+		if (pte_none(pte) || is_swap_special_pte(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..4b743394afbe 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -139,7 +139,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_has_swap_entry(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index b7523589f218..64cd6581e05a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -125,7 +125,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else if (pte_has_swap_entry(pte))
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f535bcb4950c..c2f9bcee2273 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -36,7 +36,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 			 * For more details on device private memory see HMM
 			 * (include/linux/hmm.h or mm/hmm.c).
 			 */
-			if (is_swap_pte(*pvmw->pte)) {
+			if (pte_has_swap_entry(*pvmw->pte)) {
 				swp_entry_t entry;
 
 				/* Handle un-addressable ZONE_DEVICE memory */
@@ -90,7 +90,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-		if (!is_swap_pte(*pvmw->pte))
+		if (!pte_has_swap_entry(*pvmw->pte))
 			return false;
 		entry = pte_to_swp_entry(*pvmw->pte);
 
@@ -99,7 +99,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 
 		pfn = swp_offset(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (pte_has_swap_entry(*pvmw->pte)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cbb4c0795284..2401b2a90443 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1972,7 +1972,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	si = swap_info[type];
 	pte = pte_offset_map(pmd, addr);
 	do {
-		if (!is_swap_pte(*pte))
+		if (!pte_has_swap_entry(*pte))
 			continue;
 
 		entry = pte_to_swp_entry(*pte);
-- 
2.31.1

