Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3B3560FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347918AbhDGBwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347819AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE6C061760
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=qFFkvrhk4zVFpz6vGg/7+He914LTpz3CtnbnmIYjjhw=;
 b=QiPmsuFxjp6vtGaBEF+syYCj20gQ4wqnl9mlmMdhGAQ74iz4ri7g5S0O/C9jaB5SvkIMD
 Mk8++zIFSTpWU1eBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=qFFkvrhk4zVFpz6vGg/7+He914LTpz3CtnbnmIYjjhw=;
 b=bYxYuhgP8J1pVW2XF9UT2txE3O37aOVg3E95O1q4kbVTuMfS4TSwZL9PB9koMcsp7qgu5
 6+zPaNIuKQ7cVsabNyU6BRNDQ0JGlWmyMqTmT3ifOxmubQD/9Hx77kVZRc/TMTuyf6xjPZB
 /8Li4+djjpxq7BIUDXBP/Pdk5/UgmmlZluecW96DBqBFSmQ4xBtQnMYxc80s/jIDWGjSZ5/
 VTMX7zDyyXpJtZE85hOnaaoxCxowhNeuO8BiaCPtGeG93XCHsWyCrAfHowl6z4ZepkJBWjK
 JKNRwXrDPWyaPK3MpS+vZJVN7z2zIIaj1UNrTvTFQTLOY1l/KdOcjRR8apEg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 80273160233;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 700D219F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 04/37] do_anonymous_page: reduce code duplication
Date:   Tue,  6 Apr 2021 18:44:29 -0700
Message-Id: <20210407014502.24091-5-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_anonymous_page(), we have separate cases for the zero page vs
allocating new anonymous pages. However, once the pte entry has been
computed, the rest of the handling (mapping and locking the page table,
checking that we didn't lose a race with another page fault handler, etc)
is identical between the two cases.

This change reduces the code duplication between the two cases.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 85 +++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8ee4bd239303..477c98bfdd9d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3495,7 +3495,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page;
+	struct page *page = NULL;
 	vm_fault_t ret = 0;
 	pte_t entry;
 
@@ -3525,77 +3525,66 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			!mm_forbids_zeropage(vma->vm_mm)) {
 		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
 						vma->vm_page_prot));
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				vmf->address, &vmf->ptl);
-		if (!pte_none(*vmf->pte)) {
-			update_mmu_tlb(vma, vmf->address, vmf->pte);
-			goto unlock;
-		}
-		ret = check_stable_address_space(vma->vm_mm);
-		if (ret)
-			goto unlock;
-		/* Deliver the page fault to userland, check inside PT lock */
-		if (userfaultfd_missing(vma)) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
-		}
-		goto setpte;
+	} else {
+		/* Allocate our own private page. */
+		if (unlikely(anon_vma_prepare(vma)))
+			goto oom;
+		page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
+		if (!page)
+			goto oom;
+
+		if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
+			goto oom_free_page;
+		cgroup_throttle_swaprate(page, GFP_KERNEL);
+
+		/*
+		 * The memory barrier inside __SetPageUptodate makes sure that
+		 * preceding stores to the page contents become visible before
+		 * the set_pte_at() write.
+		 */
+		__SetPageUptodate(page);
+
+		entry = mk_pte(page, vma->vm_page_prot);
+		if (vma->vm_flags & VM_WRITE)
+			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
-	/* Allocate our own private page. */
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
-	page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
-	if (!page)
-		goto oom;
-
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
-		goto oom_free_page;
-	cgroup_throttle_swaprate(page, GFP_KERNEL);
-
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
-	__SetPageUptodate(page);
-
-	entry = mk_pte(page, vma->vm_page_prot);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
-
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
-		goto release;
+		goto unlock;
 	}
 
 	ret = check_stable_address_space(vma->vm_mm);
 	if (ret)
-		goto release;
+		goto unlock;
 
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		put_page(page);
+		if (page)
+			put_page(page);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	lru_cache_add_inactive_or_unevictable(page, vma);
-setpte:
+	if (page) {
+		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		lru_cache_add_inactive_or_unevictable(page, vma);
+	}
+
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (page)
+		put_page(page);
 	return ret;
-release:
-	put_page(page);
-	goto unlock;
 oom_free_page:
 	put_page(page);
 oom:
-- 
2.20.1

