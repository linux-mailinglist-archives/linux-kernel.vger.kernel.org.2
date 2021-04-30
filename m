Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB08A37019D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhD3TzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:12 -0400
Received: from server.lespinasse.org ([63.205.204.226]:39015 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhD3Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:36 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=0Db61unRWfcOHO6d229/jewgQ0C/qszooUu2NMYgmHo=;
 b=wECn2pFk6yfclXbzl4xeFMOTpkfBKYUUEUA9L2CmfdZCgVHwuNdtOLagIcDKQWaDDliB3
 adzhucR//qTZdnACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=0Db61unRWfcOHO6d229/jewgQ0C/qszooUu2NMYgmHo=;
 b=p3VnJ3pqGKo0IRSSphAfvBns7M9kpQHPho8pBepwe2qRrsusie9ZtBcrtOJo3aZtUirya
 zWaUa1TwgHgqn3lvgFfpbynhYbmhBWuCRKftrOzNT34vRXgBKDvaU0f0WOVbEmu1TqB1sUT
 KhEd1OiSOVM5eTGcmumsE1RgAp5Afwty8iskFi0dCnmBD6oDlUDd1Kipa0HNgaNvtNkXQlo
 PW2EY2Pb2tVn7QYrOwamlD6R2BmF3zK9bbjpNIMoAaIRZKDDlqAjeBCUAhqUKVwhKfB6rv8
 d7mHt6xB/Sc5RRvTztw8bY2eU5ysjleebk93JIvJV1pjCv3cXpO4DE1Dgc4w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id A332216035D;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 9594C19F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 23/29] mm: implement speculative handling in do_swap_page()
Date:   Fri, 30 Apr 2021 12:52:24 -0700
Message-Id: <20210430195232.30491-24-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pte is larger than long, use pte_spinlock() to lock the page table
when verifying the pte - pte_spinlock() is necessary to ensure the page
table is still valid when we are locking it.

Abort speculative faults if the pte is not a swap entry, or if the desired
page is not found in swap cache, to keep things as simple as possible.

Only use trylock when locking the swapped page - again to keep things
simple, and also the usual lock_page_or_retry would otherwise try to
release the mmap lock which is not held in the speculative case.

Use pte_map_lock() to ensure proper synchronization when finally committing
the faulted page to the mm address space.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c3cd29d3acc6..a3708b4a616c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2654,30 +2654,6 @@ bool __pte_map_lock(struct vm_fault *vmf)
 
 #endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
-/*
- * handle_pte_fault chooses page fault handler according to an entry which was
- * read non-atomically.  Before making any commitment, on those architectures
- * or configurations (e.g. i386 with PAE) which might give a mix of unmatched
- * parts, do_swap_page must check under lock before unmapping the pte and
- * proceeding (but do_wp_page is only called after already making such a check;
- * and do_anonymous_page can safely check later on).
- */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-				pte_t *page_table, pte_t orig_pte)
-{
-	int same = 1;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
-	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(mm, pmd);
-		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
-		spin_unlock(ptl);
-	}
-#endif
-	pte_unmap(page_table);
-	return same;
-}
-
 static inline bool cow_user_page(struct page *dst, struct page *src,
 				 struct vm_fault *vmf)
 {
@@ -3386,12 +3362,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 	}
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
-		goto out;
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
+	if (sizeof(pte_t) > sizeof(unsigned long)) {
+		/*
+		 * vmf->orig_pte was read non-atomically. Before making
+		 * any commitment, on those architectures or configurations
+		 * (e.g. i386 with PAE) which might give a mix of
+		 * unmatched parts, we must check under lock before
+		 * unmapping the pte and proceeding.
+		 *
+		 * (but do_wp_page is only called after already making
+		 * such a check; and do_anonymous_page can safely
+		 * check later on).
+		 */
+		if (!pte_spinlock(vmf))
+			return VM_FAULT_RETRY;
+		if (!pte_same(*vmf->pte, vmf->orig_pte))
+			goto unlock;
+		spin_unlock(vmf->ptl);
+	}
+#endif
+	pte_unmap(vmf->pte);
+	vmf->pte = NULL;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
-		if (is_migration_entry(entry)) {
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			ret = VM_FAULT_RETRY;
+		} else if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
 		} else if (is_device_private_entry(entry)) {
@@ -3412,8 +3410,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = page;
 
 	if (!page) {
-		struct swap_info_struct *si = swp_swap_info(entry);
+		struct swap_info_struct *si;
 
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+			return VM_FAULT_RETRY;
+		}
+
+		si = swp_swap_info(entry);
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
@@ -3476,7 +3480,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		locked = trylock_page(page);
+	else
+		locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
 
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 	if (!locked) {
@@ -3504,10 +3511,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
 	/*
-	 * Back out if somebody else already faulted in this pte.
+	 * Back out if the VMA has changed in our back during a speculative
+	 * page fault or if somebody else already faulted in this pte.
 	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		goto out_page;
+	}
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
 		goto out_nomap;
 
-- 
2.20.1

