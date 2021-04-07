Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F103560F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347890AbhDGBwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbhDGBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:49 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=CjG9cXBfCGz37cJgHr3H1dKyoE0oEoz4J1dkmh5NNCg=;
 b=yM6xNR3TMq76ZYckpLMGjkzx0S/w7f/gz1/7CSWCS9RX/0FOrYG+SfxcWVhU1zxZJBmOD
 /HlPaPF2xGrhS5hBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=CjG9cXBfCGz37cJgHr3H1dKyoE0oEoz4J1dkmh5NNCg=;
 b=q0/QAhX2NFAO+hY4Y//y0LFODZO05QGiHTCbTcypAuapYNan4SDX7zfsyzfEt1XdUkjr7
 2KVgBZm7Sxj37H/8sMXwgaOt4pNU6ISdqlxBHJ0oACTMN+bFbaj1KbpnlXvuk+HEMHnlV9k
 BM80kjgIYIBVMbDF14NTSi51Vnfz3GkYiggzBWUTur9OWzbefrZ6DUXChgzsLZxoBGGrSh0
 lpCPsKML05GVhgOWfIPLGOOOQ1jTOSeYb8oWE8z55oIj99zsZ9ILV2I34xYo68E7Nw4uv3p
 DmODchp4sYxTrYsb8lFUKDXU2IgXjF4tIyCCmzCzh47MYSEEJ0e6/veFr7VA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 023FA160350;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id E81F619F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 21/37] mm: implement speculative handling in do_swap_page()
Date:   Tue,  6 Apr 2021 18:44:46 -0700
Message-Id: <20210407014502.24091-22-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index fc555fae0844..ab3160719bf3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2637,30 +2637,6 @@ bool __pte_map_lock(struct vm_fault *vmf)
 
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
@@ -3369,12 +3345,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3395,8 +3393,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3459,7 +3463,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		locked = trylock_page(page);
+	else
+		locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
 
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 	if (!locked) {
@@ -3487,10 +3494,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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

