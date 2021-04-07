Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B59356100
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbhDGBw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347831AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6372C061762
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=8COoG1kyMAyzmcjmtCVhUuZfAMmUT556bb2lAEkl2Jk=;
 b=PHxlIUq8Gez4GGg1T1vZB3f/iGsF8+rBmKPA5lGRVNAhdo4q0AcUCTl4jG0ud1ymS98BV
 pXuyifekidg4jc1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=8COoG1kyMAyzmcjmtCVhUuZfAMmUT556bb2lAEkl2Jk=;
 b=Xj0qGgONLfNk5zEaM5IEBqutABXQbilGjAJuQCGy/NJElYzNQNWVz/qj9s1C6jR2zMKsp
 CjgSDeSQCsFCM+kAwSicmrOf/jMLccvhMVOhjghOl1FsBmbeoi8ks/+cPqSCRaAA0S5gXBo
 wH6j2k0bx/8iypailFquYrsYVPFz097+Hi4V3IjA75FYXoRM5H3/nt2VmtdgV28sESHbThT
 nPem9Matb4e4goClyC4hD+hIaDWZ5mKOjFOWWWxDQ0KasRhTnPowHxV9A95siPdM+tgbJcM
 rKG/7yOOiDxRufdYxGz6E0iQRg9rMSq43GJ4K/9MnRhNIYT5b2usXjV3CPcA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id E7B4016031A;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D9CBE19F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 19/37] mm: implement speculative handling in wp_page_copy()
Date:   Tue,  6 Apr 2021 18:44:44 -0700
Message-Id: <20210407014502.24091-20-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index eea72bd78d06..547d9d0ee962 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2911,20 +2911,27 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
@@ -2941,7 +2948,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	}
 
 	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
-		goto oom_free_new;
+		goto out_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
 	__SetPageUptodate(new_page);
@@ -2954,7 +2961,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
@@ -3042,12 +3053,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
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
@@ -3190,6 +3201,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return wp_pfn_shared(vmf);
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		vmf->pte = NULL;
 		return wp_page_copy(vmf);
 	}
 
@@ -3228,6 +3240,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	vmf->pte = NULL;
 	return wp_page_copy(vmf);
 }
 
-- 
2.20.1

