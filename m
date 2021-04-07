Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53183560F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347902AbhDGBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:05 -0400
Received: from server.lespinasse.org ([63.205.204.226]:58579 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbhDGBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:49 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=amUPmRB3lhaJkohzuLZ4RtQ8DU3T54MYn5RloG5fdOk=;
 b=z2Fs4Sr8tgnyNRxzBI/Qpcy1P6DLuAkRsEWkyC+RTtb0wEJIEd05hnB2MY0kNtj3w4TPx
 izNmbCPXX4Oli6tCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=amUPmRB3lhaJkohzuLZ4RtQ8DU3T54MYn5RloG5fdOk=;
 b=STR1621+RtKTEUrfNGZuKFxncsNgsYjBbFmP0TY1i7nINnGvGd8RC7HxYZylM4TwF9ipc
 2lJKhgHBNzrI/mmtaYhir2hDOmgFM0uMh2+9qOId0KEXhtaP/BYpzV/1c0420if3gvpykh2
 q9FoAdafWcOOGwVE6Llm1KbgxG63CwFM3Dzf4b3fB8u3iUZNPLvGVlYBu29QFKF+igMX3bv
 Lcnb2SWEBQKu+0iLdI9bRaoQ7UYa4nEnI6AiUFRWpcLtXmiHhcmXP4x+Bk+ezGFAp4Q11Zt
 ehgmwHil39XlGZvKvXYkBiSkRNfP8THZyYuG9Y/SJYaePQGz3RwdeWVRGYlw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id EF7E4160330;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id E0F2F19F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 20/37] mm: implement and enable speculative fault handling in handle_pte_fault()
Date:   Tue,  6 Apr 2021 18:44:45 -0700
Message-Id: <20210407014502.24091-21-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_pte_fault(), allow speculative execution to proceed.

Use pte_spinlock() to validate the mmap sequence count when locking
the page table.

If speculative execution proceeds through do_wp_page(), ensure that we
end up in the wp_page_reuse() or wp_page_copy() paths, rather than
wp_pfn_shared() or wp_page_shared() (both unreachable as we only
handle anon vmas so far) or handle_userfault() (needs an explicit
abort to handle non-speculatively).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 547d9d0ee962..fc555fae0844 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3103,6 +3103,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
 	if (vma->vm_ops && vma->vm_ops->pfn_mkwrite) {
 		vm_fault_t ret;
 
@@ -3123,6 +3124,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = VM_FAULT_WRITE;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	get_page(vmf->page);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
@@ -3176,6 +3179,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
@@ -4366,13 +4371,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
-	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
-		pte_unmap(vmf->pte);
+	if (!pte_spinlock(vmf))
 		return VM_FAULT_RETRY;
-	}
-
-	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
-	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(*vmf->pte, entry))) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
-- 
2.20.1

