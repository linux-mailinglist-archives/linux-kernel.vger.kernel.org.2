Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F1356109
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbhDGBw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347836AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7713C061764
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=AZPl31a+Qwjg2yKK4/58wswJf9/r+P5+G7HgfFwgwPw=;
 b=myO1JlTLVwjj24PaAXDauPLhrNYZf5SriBcRFoxRq6uYNze2pldTo0iqgg/1h9Tk22dkA
 lmYyTY+Bn1u8AvOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=AZPl31a+Qwjg2yKK4/58wswJf9/r+P5+G7HgfFwgwPw=;
 b=LpXTrEgOQVv1SNRQC0QiFxqtt5r3kW1xS0lKV129jQ3pGExTQLhVAfhaY4ophF2qd9GPM
 uGdaUjRHHgg/cP2jS10ipaOcP2chwNgqYP7lIJCCkO1TYdBA2Uj42Nzr3HGPQ98ywqLCNZU
 wzKEZVBj0iYDunZ850zmNvpx0p69hMJ3GQMHiSQzgUYmUNKFhKheqm4Cc2AIAHsKRBoODwU
 PpvRQPAzz4QgLLQvr5iXXjiYa4nZOwdnPUo77vKtDVwue3bzaanPHOHhoPE9n9Zmktm4Iez
 1rE0/jqbi44fDIfdauryJOpQyygXVN/sHP49P9/8OIvq80NkuOX3/i4FFtlA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 301ED16046E;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 1F68A19F320; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 27/37] mm: implement speculative handling in do_fault_around()
Date:   Tue,  6 Apr 2021 18:44:52 -0700
Message-Id: <20210407014502.24091-28-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the vm_ops->map_pages method within an rcu read locked section.
In the speculative case, verify the mmap sequence lock at the start of
the section. A match guarantees that the original vma is still valid
at that time, and that the associated vma->vm_file stays valid while
the vm_ops->map_pages() method is running.

Do not test vmf->pmd in the speculative case - we only speculate when
a page table already exists, and and this saves us from having to handle
synchronization around the vmf->pmd read.

Change xfs_filemap_map_pages() account for the fact that it can not
block anymore, as it is now running within an rcu read lock.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 fs/xfs/xfs_file.c |  3 +++
 mm/memory.c       | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a007ca0711d9..b360732b20ae 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1387,6 +1387,9 @@ xfs_filemap_map_pages(
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
 	vm_fault_t ret;
 
+	if (!xfs_ilock_nowait(XFS_I(inode), XFS_MMAPLOCK_SHARED))
+		return (vmf->flags & FAULT_FLAG_SPECULATIVE) ?
+			VM_FAULT_RETRY : 0;
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
 	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
diff --git a/mm/memory.c b/mm/memory.c
index 13e2aaf900e5..a20e13d84145 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4012,6 +4012,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	pgoff_t start_pgoff = vmf->pgoff;
 	pgoff_t end_pgoff;
 	int off;
+	vm_fault_t ret;
 
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
@@ -4030,14 +4031,31 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	end_pgoff = min3(end_pgoff, vma_pages(vmf->vma) + vmf->vma->vm_pgoff - 1,
 			start_pgoff + nr_pages - 1);
 
-	if (pmd_none(*vmf->pmd)) {
+	if (!(vmf->flags & FAULT_FLAG_SPECULATIVE) &&
+	    pmd_none(*vmf->pmd)) {
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
-	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	rcu_read_lock();
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq)) {
+			rcu_read_unlock();
+			return VM_FAULT_RETRY;
+		}
+		/*
+		 * the mmap sequence check verified that vmf->vma was still
+		 * current at that point in time.
+		 * The rcu read lock ensures vmf->vma->vm_file stays valid.
+		 */
+	}
+#endif
+	ret = vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	rcu_read_unlock();
+	return ret;
 }
 
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
-- 
2.20.1

