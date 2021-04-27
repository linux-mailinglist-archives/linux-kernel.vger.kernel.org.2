Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBA36C936
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhD0QVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237534AbhD0QOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lFEgDAoL+N1dFJPllx14DTPhPYicaTLYrV4ExkV4x4=;
        b=VSDzPXNwsHnZ2Jlq5TwxUou52RVRiZZIb61Hp3rVboYhqE8EFAOY4p9CO27JQ4oE4qgGMj
        e0T7YUffalybOWuWDqCVChBa315kdcUKOveYG7LuTrKkZCE9+ZMVItE7GMY+Ugt/EUWgsW
        N1qnd9UwEkmU/t5is0TwHbtCiiF6YVk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-4ToYZhL0NiSBhK4Pd4CmJw-1; Tue, 27 Apr 2021 12:13:28 -0400
X-MC-Unique: 4ToYZhL0NiSBhK4Pd4CmJw-1
Received: by mail-qv1-f69.google.com with SMTP id x15-20020a0ce0cf0000b029019cb3e75c62so26247056qvk.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lFEgDAoL+N1dFJPllx14DTPhPYicaTLYrV4ExkV4x4=;
        b=uCPbRNRmBImB+cBE2+qhpjxAasLrCXjNAQ64m9BL+PvVZyGcK6Mc1Ur3u3AHTwu7zl
         y6BWG4k9XcaYbsavz+nE2hZ6i31EwkfaMEub0AUkgUTEcZxxBqjuvA5RtrksYKFg7PSa
         azlSEWWHt+kCCs2TuZSZBP+DIE4owAk3/16ehm4wXzSwGqbEbOVDXbu1Wryi3jBn/5c9
         tchLSEGtzi34Ny1LaRrL1aFeBzudTfw43AiCjXU1RC5m8J4Qf/825Vsa48p+qMyTbYi0
         BviUNfDunqWLTrPDEaD1kdERZgx21TWdpqCFvCTJTdcxmJJrO8BgO/1dQVntrp2ZoRog
         YMoQ==
X-Gm-Message-State: AOAM531OlYaDWceazjzTep57DhZoIycGfI3zbl1Tb7FsBL6mMzPvJPdF
        wwOzFa38ZdUGWecVsy+WEOiv9U2b+qhn7ikAMN70v7Hh+Pbrp6Tns4jAMO95J0/LOSplk7HSvHA
        TFIs5iY+6Tj5ddiK5GoMMzc5v
X-Received: by 2002:a37:8bc2:: with SMTP id n185mr23966097qkd.320.1619540007571;
        Tue, 27 Apr 2021 09:13:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw7paavydyZXFB4Bg3crbIItXrvdV4lxoEZSdyWpDLIhJK10+oLtGvamIwYWO6eoith26Kmg==
X-Received: by 2002:a37:8bc2:: with SMTP id n185mr23966068qkd.320.1619540007167;
        Tue, 27 Apr 2021 09:13:27 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 04/24] mm/swap: Introduce the idea of special swap ptes
Date:   Tue, 27 Apr 2021 12:12:57 -0400
Message-Id: <20210427161317.50682-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index b3c70a612c7a9..ebe213cba9136 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -30,7 +30,7 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
 
-	if (check_swap && is_swap_pte(old_pte)) {
+	if (check_swap && pte_has_swap_entry(old_pte)) {
 		swp_entry_t entry = pte_to_swp_entry(old_pte);
 
 		if (!non_swap_entry(entry) && mte_restore_tags(entry, page))
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc9784544b241..4c95cc57a66a8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -498,7 +498,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (!non_swap_entry(swpent)) {
@@ -518,8 +518,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			page = migration_entry_to_page(swpent);
 		else if (is_device_private_entry(swpent))
 			page = device_private_entry_to_page(swpent);
-	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
-							&& pte_none(*pte))) {
+	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) &&
+			    mss->check_shmem_swap &&
+			    /* Here swap special pte is the same as none pte */
+			    (pte_none(*pte) || is_swap_special_pte(*pte)))) {
 		page = xa_load(&vma->vm_file->f_mapping->i_pages,
 						linear_page_index(vma, addr));
 		if (xa_is_value(page))
@@ -691,7 +693,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (is_migration_entry(swpent))
@@ -1075,7 +1077,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_has_swap_entry(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1375,7 +1377,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		page = vm_normal_page(vma, addr, pte);
 		if (pte_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else if (pte_has_swap_entry(pte)) {
 		swp_entry_t entry;
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7dd57303bb0c3..7b7387d2892ff 100644
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
index aa09535cf4d47..63a079e361a3d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -473,7 +473,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		if (likely(!(flags & FOLL_MIGRATION)))
 			goto no_page;
-		if (pte_none(pte))
+		if (!pte_has_swap_entry(pte))
 			goto no_page;
 		entry = pte_to_swp_entry(pte);
 		if (!is_migration_entry(entry))
diff --git a/mm/hmm.c b/mm/hmm.c
index 943cb2ba44423..4dba5debf1630 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -237,7 +237,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	pte_t pte = *ptep;
 	uint64_t pfn_req_flags = *hmm_pfn;
 
-	if (pte_none(pte)) {
+	if (pte_none(pte) || is_swap_special_pte(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ea74da3232ab6..e8b299aa32d06 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 
 		vmf.pte = pte_offset_map(pmd, address);
 		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte)) {
+		if (!pte_has_swap_entry(vmf.orig_pte)) {
 			pte_unmap(vmf.pte);
 			continue;
 		}
@@ -1246,6 +1246,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
index 01fef79ac761b..c77499d21aac9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -202,7 +202,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
-		if (pte_present(pte) || pte_none(pte))
+		if (!pte_has_swap_entry(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
@@ -594,7 +594,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
-		if (pte_none(ptent))
+		if (pte_none(ptent) || is_swap_special_pte(ptent))
 			continue;
 		/*
 		 * If the pte has swp_entry, just clear page table to
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3004afb6d0901..f3f21ce908dd2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5550,7 +5550,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
-	else if (is_swap_pte(ptent))
+	else if (pte_has_swap_entry(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
 		page = mc_handle_file_pte(vma, addr, ptent, &ent);
diff --git a/mm/memory.c b/mm/memory.c
index 955a0bb6b855c..235857ccfaa11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3323,6 +3323,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
index 6b37d00890ca5..415961ed7a6cb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -287,7 +287,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 
 	spin_lock(ptl);
 	pte = *ptep;
-	if (!is_swap_pte(pte))
+	if (!pte_has_swap_entry(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
@@ -2381,7 +2381,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 		pte = *ptep;
 
-		if (pte_none(pte)) {
+		if (pte_none(pte) || is_swap_special_pte(pte)) {
 			if (vma_is_anonymous(vma)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d67..5728c3e6473f0 100644
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
index 94188df1ee557..b3def0a102bf4 100644
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
index d22629ff8f3c0..67d2b84671a5a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -124,7 +124,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else if (pte_has_swap_entry(pte))
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 86e3a3688d592..6b51759d9203f 100644
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
@@ -89,7 +89,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-		if (!is_swap_pte(*pvmw->pte))
+		if (!pte_has_swap_entry(*pvmw->pte))
 			return false;
 		entry = pte_to_swp_entry(*pvmw->pte);
 
@@ -97,7 +97,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 
 		pfn = migration_entry_to_pfn(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (pte_has_swap_entry(*pvmw->pte)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c5..8aa4be0746593 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1964,7 +1964,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	si = swap_info[type];
 	pte = pte_offset_map(pmd, addr);
 	do {
-		if (!is_swap_pte(*pte))
+		if (!pte_has_swap_entry(*pte))
 			continue;
 
 		entry = pte_to_swp_entry(*pte);
-- 
2.26.2

