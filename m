Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BD370196
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhD3Tyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:46 -0400
Received: from server.lespinasse.org ([63.205.204.226]:59681 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhD3Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:36 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=3PnBKJvO5QY1tr24tZ6y3ew9eVWtL5kDFtGxo4ArR+E=;
 b=lXBA0+F6lchhVkLLvb5J6eYEHqc6P+VKSYX9K1A7aPH85rzdTMVLqatH87PnLBZegRP2q
 TKXtRyQ757vAs9hDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=3PnBKJvO5QY1tr24tZ6y3ew9eVWtL5kDFtGxo4ArR+E=;
 b=dzV0TyOIMhHowJCNEtGaYZ4ibmh4ZJg9dIbE7IsVg2FpdmcPq1bssfGyF7kQVPJbkmNvx
 Kwmh7ga4jyZjaIrleHYGhE9SMzXra/cTW9R3dwAPEXGjmhpHT/eXRkPg1Nnry2lXDsNUtpX
 Q1tj9sbYOJfdDX2vfKtOJWW76kguZwY67cwBe0lotTABt7pky5vRkvnSW9lK5xV/zaLk5Gj
 CnerETNmvyR/VGKkoRoM0uLBnldZvqYRqXnVPjbR7aVBlShhTqQB1QZHHYYT0vkuauozP3Z
 VQevU/v/tMkbT3rUnZW6GW59pNgyZ/TP7CaAWcoj/DU2GAB5Uq4fLz+3dcNQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 9870A16033F;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 88DF119F524; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 21/29] mm: implement speculative handling in wp_page_copy()
Date:   Fri, 30 Apr 2021 12:52:22 -0700
Message-Id: <20210430195232.30491-22-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change wp_page_copy() to handle the speculative case.
This involves aborting speculative faults if they have to allocate an
anon_vma, and using pte_map_lock() instead of pte_offset_map_lock()
to complete the page fault.

Also change call sites to clear vmf->pte after unmapping the page table,
in order to satisfy pte_map_lock()'s preconditions.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 286776b7795b..cb66585f5145 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2928,20 +2928,27 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	vm_fault_t ret = VM_FAULT_OOM;
 
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
+	if (unlikely(!vma->anon_vma)) {
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			ret = VM_FAULT_RETRY;
+			goto out;
+		}
+		if (__anon_vma_prepare(vma))
+			goto out;
+	}
 
 	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
 		new_page = alloc_zeroed_user_highpage_movable(vma,
 							      vmf->address);
 		if (!new_page)
-			goto oom;
+			goto out;
 	} else {
 		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
 				vmf->address);
 		if (!new_page)
-			goto oom;
+			goto out;
 
 		if (!cow_user_page(new_page, old_page, vmf)) {
 			/*
@@ -2958,7 +2965,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	}
 
 	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
-		goto oom_free_new;
+		goto out_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
 	__SetPageUptodate(new_page);
@@ -2971,7 +2978,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		/* put_page() will uncharge the page */
+		goto out_free_new;
+	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
@@ -3059,12 +3070,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
-oom_free_new:
+out_free_new:
 	put_page(new_page);
-oom:
+out:
 	if (old_page)
 		put_page(old_page);
-	return VM_FAULT_OOM;
+	return ret;
 }
 
 /**
@@ -3207,6 +3218,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return wp_pfn_shared(vmf);
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		vmf->pte = NULL;
 		return wp_page_copy(vmf);
 	}
 
@@ -3245,6 +3257,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	vmf->pte = NULL;
 	return wp_page_copy(vmf);
 }
 
-- 
2.20.1

