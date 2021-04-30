Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA744370184
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhD3Txq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:46 -0400
Received: from server.lespinasse.org ([63.205.204.226]:45039 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhD3TxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:23 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=L3Bw9EVL1MYkwLbI9Xaunh3Hgdst8TtQR/SFegAk96c=;
 b=dgCd4PjRE2gRf4Fvqw/3C0vbv1RI67Lc5tiLnsYvcOefclwXVvfmLlYs5DRsYQv8k1q/r
 50pZgxYv532WNKDBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=L3Bw9EVL1MYkwLbI9Xaunh3Hgdst8TtQR/SFegAk96c=;
 b=DKKWNug2D0nEHRfHWZkXtQrfqBuob06IxxmDvfQFn2hznrY9WylKR9Ccof2HLGZsjtp7S
 2FmaRVMf0xslg7o2vheP+jGauUS20xpkBolDtINNlgJnv1lbHLVzpVcveZhBUq7ZUiNm4MC
 Hj460hi2GoUX1GpqD7eEp5M4AXVEteG8pY0Q9RUexOzp58SghweGhBz2z3WQLrrI6fq7XCW
 BC8Lui4j9v304CWh/t6Xmfx2SrkjOSi/SQRHWbWynMW6MDfvY1icVxfeilv7M+BdlSy9abF
 0MY9BL6CoNWEykmhw2nR/38Pb5RNWT6+NrPyjAmvzV+SBy8kdnlfzSdzhN0w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 2A14E16030F;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 1A3DA19F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 05/29] do_anonymous_page: reduce code duplication
Date:   Fri, 30 Apr 2021 12:52:06 -0700
Message-Id: <20210430195232.30491-6-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
index 59ff65cb3ab4..217c31c616f4 100644
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

