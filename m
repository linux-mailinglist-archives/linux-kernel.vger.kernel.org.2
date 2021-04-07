Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB7356124
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhDGB4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:56:49 -0400
Received: from server.lespinasse.org ([63.205.204.226]:33301 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDGB4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:56:47 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=XkD4f0ULJymIOIeAqVxcBhuCK1FNqNRxb6Ygkc1ApCs=;
 b=T+2gjG7c+P1JGIgyykqnKaQiD2Wtt2L+tO+pRnvCt2JO1FKjXP26ZCM6hHIjsZg0F91Pv
 IUbkovCOPxRyi8dAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=XkD4f0ULJymIOIeAqVxcBhuCK1FNqNRxb6Ygkc1ApCs=;
 b=RTBwrQVEuGgTfXMpMfbrh/D5mOUGsMVm80V0u7rXaSdXDkPKYPpLKgLTiCRWVRop96qn6
 0H69mSmJu7OkmjqPwNX7g+7lzVmBTBOnkqtihAaT+U/O2gxSb293SkAW7EIfEHbmGHMYZWk
 pOscXZjW7Z0CSgRkvL7L15AFZtvdGsJOlu2QZxqeLxSHccd/OsdnNeVdL56bmw0Rd1+uEX3
 VukmTQUvytixFC1AIzrmU1IDhnsHFdOkwUHs5+5/3GbtMI8p+2GamYUAQkZO2nK072EtqZp
 iyjY45FT2zBP25QHQ+U8WOHV240vWPDjZQGCB3bXmbBMsDK2fiPRHyEjp86w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 35EA7160531;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 26A2B19F31D; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 28/37] mm: implement speculative handling in filemap_map_pages()
Date:   Tue,  6 Apr 2021 18:44:53 -0700
Message-Id: <20210407014502.24091-29-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the speculative case, we know the page table already exists, and it
must be locked with pte_map_lock(). In the case where no page is found
for the given address, return VM_FAULT_RETRY which will abort the
fault before we get into the vm_ops->fault() callback. This is fine
because if filemap_map_pages does not find the page in page cache,
vm_ops->fault() will not either.

Initialize addr and last_pgoff to correspond to the pte at the original
fault address (which was mapped with pte_map_lock()), rather than the
pte at start_pgoff. The choice of initial values doesn't matter as
they will all be adjusted together before use, so they just need to be
consistent with each other, and using the original fault address and
pte allows us to reuse pte_map_lock() without any changes to it.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/filemap.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6e8505fe5df9..d496771749e6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3136,25 +3136,31 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t last_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-	vm_fault_t ret = 0;
+	vm_fault_t ret = (vmf->flags & FAULT_FLAG_SPECULATIVE) ?
+		VM_FAULT_RETRY : 0;
 
-	rcu_read_lock();
+	/* filemap_map_pages() is called within an rcu read lock already. */
 	head = first_map_page(mapping, &xas, end_pgoff);
 	if (!head)
-		goto out;
+		return ret;
 
-	if (filemap_map_pmd(vmf, head)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
+	if (!(vmf->flags & FAULT_FLAG_SPECULATIVE) &&
+	    filemap_map_pmd(vmf, head))
+		return VM_FAULT_NOPAGE;
+
+	if (!pte_map_lock(vmf)) {
+		unlock_page(head);
+		put_page(head);
+		return VM_FAULT_RETRY;
 	}
+	addr = vmf->address;
+	last_pgoff = vmf->pgoff;
 
-	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
 		page = find_subpage(head, xas.xa_index);
 		if (PageHWPoison(page))
@@ -3184,8 +3190,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		put_page(head);
 	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
-	rcu_read_unlock();
+	vmf->pte = NULL;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 	return ret;
 }
-- 
2.20.1

