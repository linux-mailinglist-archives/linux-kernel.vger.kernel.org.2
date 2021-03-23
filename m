Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A62345428
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhCWAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhCWAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDE3yzI45vtOy9qhGrIFbz2SqIX8w7YY3YHbRAtraVY=;
        b=eWWdahbfGIn7FKiNFM27Rse4knSgH5hLTMk606apOKb3enY9+bW/rVIy83NlFryzRJToP9
        4aiGx2S4DXpUABnlg90/jB4+OksGmcNkueDDYxwPAtJKng9cIEpEACbzhV4vMyzCa7umZ/
        wVvqpFJME//0LunwXqC4YB7z+HcqPLI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-EdKIoeiRONuw8VXQo_gW8g-1; Mon, 22 Mar 2021 20:49:23 -0400
X-MC-Unique: EdKIoeiRONuw8VXQo_gW8g-1
Received: by mail-qv1-f72.google.com with SMTP id da16so572403qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDE3yzI45vtOy9qhGrIFbz2SqIX8w7YY3YHbRAtraVY=;
        b=r7tPjanhPv7yjkWLwCiOsRlDmZr8PlJXHZWCawkrzO/Z10tLYIOFxcG3DKyfKK8XCN
         Lns6gpo9j841Elu5zQxd7cVTUM/KrKROtVYIwgkmCm5ZrYhOJ+WM+dnLMeVtKhaoQ+BA
         8JXp10tqr48kkCCgddP1v65THqIXVbwfbBBRK14otiqErzatIVeW6RSOQCDkGrVB9K7J
         zJw9gG641uac0R0GoRfXxr+ffsZGVVnwaYUpt/ZsL1Exfgw5HL8fFk9boUhjwmBBBkJf
         FsbnRqTpVl5ciOM3gsu3+4cuixSRvY8463UGB55KyamV9wcaad3cdGXe4tm9gLcDM5Cq
         DSIQ==
X-Gm-Message-State: AOAM5309WA1SwHCxgu8rAk0UxaiVTPOzHZw9cGavQewe04kg8vtQFG3e
        YBsec7SDmKHdjoqY3uG6/tR+aE6J6g2x/HoyQFpGMtS5OaROADV50gQljJ+2EnAcLdBDvqiaEZd
        lhcZYBqzH950hHr7brhnC+NZaAc7prx60VaMWBaYLIDYt/O4aQPcxj7cvbmAmAm3doRe53HiqQw
        ==
X-Received: by 2002:a37:9f4e:: with SMTP id i75mr3001743qke.283.1616460562196;
        Mon, 22 Mar 2021 17:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCy3pgphUvT2476IhICTto4uU5cu5+czhoWfvrmrBMwW3mKzfYdYM0mnEfxBHC8BLk+kqHHg==
X-Received: by 2002:a37:9f4e:: with SMTP id i75mr3001701qke.283.1616460561699;
        Mon, 22 Mar 2021 17:49:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 04/23] mm/swap: Introduce the idea of special swap ptes
Date:   Mon, 22 Mar 2021 20:48:53 -0400
Message-Id: <20210323004912.35132-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index b3c70a612c7a..ebe213cba913 100644
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
index fc9784544b24..4c95cc57a66a 100644
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
index 7dd57303bb0c..7b7387d2892f 100644
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
index b3e647c8b7ee..53e9ddc3a829 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -474,7 +474,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		if (likely(!(flags & FOLL_MIGRATION)))
 			goto no_page;
-		if (pte_none(pte))
+		if (!pte_has_swap_entry(pte))
 			goto no_page;
 		entry = pte_to_swp_entry(pte);
 		if (!is_migration_entry(entry))
diff --git a/mm/hmm.c b/mm/hmm.c
index 943cb2ba4442..4dba5debf163 100644
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
index b81521dfbb1a..419a6acce326 100644
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
@@ -1248,6 +1248,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
index 01fef79ac761..c77499d21aac 100644
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
index 668d1d7c2645..64b347a15ded 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5558,7 +5558,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
-	else if (is_swap_pte(ptent))
+	else if (pte_has_swap_entry(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
 		page = mc_handle_file_pte(vma, addr, ptent, &ent);
diff --git a/mm/memory.c b/mm/memory.c
index d534eba85756..8c4ed1f9693c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3312,6 +3312,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
index 47df0df8f21a..08425acc2563 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -314,7 +314,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 
 	spin_lock(ptl);
 	pte = *ptep;
-	if (!is_swap_pte(pte))
+	if (!pte_has_swap_entry(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
@@ -2425,7 +2425,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
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
index 94188df1ee55..b3def0a102bf 100644
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
index 6934d199da54..cd9759ede04b 100644
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
index 86e3a3688d59..6b51759d9203 100644
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
index 149e77454e3c..8aa4be074659 100644
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

