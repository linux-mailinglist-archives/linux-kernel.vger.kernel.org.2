Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994C5370197
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhD3Tyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:51 -0400
Received: from server.lespinasse.org ([63.205.204.226]:60163 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhD3Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:36 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=6izgSjuxJC/sQuVYlPY55kmOkeAgaUYZ6vcRO71jz20=;
 b=6MkGLKvM/4VtjyiymcFk2dABknx20mqKn0lGnp7hMFyHV9yFVB5srF0QXxkBHbz+uWWsP
 ZNa4wxs6B3JQuVwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=6izgSjuxJC/sQuVYlPY55kmOkeAgaUYZ6vcRO71jz20=;
 b=A01bdPoVLNR+cYeuMSIDL5MvLvHSWzUFdNnBnPCOojMiIGawDh+laCnZlI26QdeJgQ2d7
 HtJ8ez8EsInqYn47P5AqrtvW44W2A4iaJ+DXOm4cyjpK1gHE1ei9ThzshowQotc/PYU71GR
 NWtJNkcpJEYKx0QA9/204+L3r8e07/58DiEs56YhlJrr6RGoN6/EGStz6dOvMYGS1SaTjGj
 JkP/bRYRI6D/AyQCI+ZvWaOz/Snj3vfs9GJgyUEh3uA/9KfMI0l7ulaFCwoqbHCnxX4TJtK
 4LOh2CSRTHTUxH1RfGFRbGOVN0+ndlqMVNKzGdVxrUVbX4nlsb6k6JOl3l0g==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 9E4B616035C;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 8ED4019F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 22/29] mm: implement and enable speculative fault handling in handle_pte_fault()
Date:   Fri, 30 Apr 2021 12:52:23 -0700
Message-Id: <20210430195232.30491-23-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
index cb66585f5145..c3cd29d3acc6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3120,6 +3120,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
 	if (vma->vm_ops && vma->vm_ops->pfn_mkwrite) {
 		vm_fault_t ret;
 
@@ -3140,6 +3141,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = VM_FAULT_WRITE;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	get_page(vmf->page);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
@@ -3193,6 +3196,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
@@ -4383,13 +4388,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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

