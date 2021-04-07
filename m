Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83A0356102
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbhDGBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:36 -0400
Received: from server.lespinasse.org ([63.205.204.226]:38663 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=hNw2E9n5catZ5ChciAAiyAEd51ldZQS2D3FL9TJJQ3Y=;
 b=LdeanG/cHGgwnR5X1yW6N3lnK/QBKoWHRD02KGL1fyNhPOTgq2puWO0/ibCPXZbYgb1lA
 acWdyb1vjbMAdEdAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=hNw2E9n5catZ5ChciAAiyAEd51ldZQS2D3FL9TJJQ3Y=;
 b=aaxklxxmwoZqKEa5hd21kEyumQSxeowwY9l01vrrM5iLdUOjf+YPBOX1buQKr4Tpo6iXn
 PjWEp27BcS9ggHt/rGwAdb43w/7zCOqGOt8OY2xxeogzRt0gQkbxjFyb1BtIwAd7Ymmf4L8
 mR++NEo/XdU2b87VmLebX8/hkpDDaF/HgQOJlJGLPMP2mZB7xSPyMlbIEUetHzIizKXYYrw
 PfYM3zytRhEF2Vv+5tom1RbamQBi6ZH93HkYCrMNDa6FpyhASkN56Hqn8tuAz6cDL0esVO6
 piKK+VlFmJ3tMvrOyIDDQ5K1q3Q5Y1sP6Mtk8rcehQ7J8KevBg7XCKXtHslQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 1F86516038C;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 10D2D19F31D; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 25/37] mm: implement speculative handling in filemap_fault()
Date:   Tue,  6 Apr 2021 18:44:50 -0700
Message-Id: <20210407014502.24091-26-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend filemap_fault() to handle speculative faults.

In the speculative case, we will only be fishing existing pages out of
the page cache. The logic we use mirrors what is done in the
non-speculative case, assuming that pages are found in the page cache,
are up to date and not already locked, and that readahead is not
necessary at this time. In all other cases, the fault is aborted to be
handled non-speculatively.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/filemap.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..6e8505fe5df9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2851,7 +2851,9 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  *
- * vma->vm_mm->mmap_lock must be held on entry.
+ * If FAULT_FLAG_SPECULATIVE is set, this function runs within an rcu
+ * read locked section and with mmap lock not held.
+ * Otherwise, vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
  * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
@@ -2876,6 +2878,47 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct page *page;
 	vm_fault_t ret = 0;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		page = find_get_page(mapping, offset);
+		if (unlikely(!page) || unlikely(PageReadahead(page)))
+			return VM_FAULT_RETRY;
+
+		if (!trylock_page(page))
+			return VM_FAULT_RETRY;
+
+		if (unlikely(compound_head(page)->mapping != mapping))
+			goto page_unlock;
+		VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
+		if (unlikely(!PageUptodate(page)))
+			goto page_unlock;
+
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		if (unlikely(offset >= max_off))
+			goto page_unlock;
+
+		/*
+		 * Update readahead mmap_miss statistic.
+		 *
+		 * Note that we are not sure if finish_fault() will
+		 * manage to complete the transaction. If it fails,
+		 * we'll come back to filemap_fault() non-speculative
+		 * case which will update mmap_miss a second time.
+		 * This is not ideal, we would prefer to guarantee the
+		 * update will happen exactly once.
+		 */
+		if (!(vmf->vma->vm_flags & VM_RAND_READ) && ra->ra_pages) {
+			unsigned int mmap_miss = READ_ONCE(ra->mmap_miss);
+			if (mmap_miss)
+				WRITE_ONCE(ra->mmap_miss, --mmap_miss);
+		}
+
+		vmf->page = page;
+		return VM_FAULT_LOCKED;
+page_unlock:
+		unlock_page(page);
+		return VM_FAULT_RETRY;
+	}
+
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(offset >= max_off))
 		return VM_FAULT_SIGBUS;
-- 
2.20.1

