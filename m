Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE0370199
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhD3Ty5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:57 -0400
Received: from server.lespinasse.org ([63.205.204.226]:59481 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhD3Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:36 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=3M8/87TWLrXUkV85tkfyDqeQTIij8rhB4JQYDhsc088=;
 b=IZjIOz6DZDI+XBf2HUWjGljUENDtk9JZDSEfDvngxRCnnk8zbadfNKvDaZKujidNQsLue
 opWTz5oBYI1wlRSCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=3M8/87TWLrXUkV85tkfyDqeQTIij8rhB4JQYDhsc088=;
 b=t7R2CPkdcuf0Gtgd++7LItWfcxuIgKHJzCb7pW1eIcDGF66HMlZ+vKl1dmodbHzkmn4XY
 uX99g0LXMoO9BY+cYVTdhCe9dOIoWjm4OGn76klITLZI9OtrTr1DJoh6yK+j7cnmDPs/vvy
 6OKuko1PQapizZu+rs42+H1clr6su6rn0M5EzzUzjdUobY6IJjfrB1fAKROAhpKnpPq1bpx
 M2YUFn1HRw+hrmrfnCXrbuAqU8qOxZX1Aw37EwxS2pZmyFalbAe0npuqcutQrKKDWM+a6pJ
 PEhvvDkTl8iSpJKt6TuzvJhxnrZfVOQCo3/r4QjS7G+AjVIoAnj2vUiMTmEg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 7F1CD16032A;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 6F2ED19F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 17/29] mm: implement speculative handling in do_anonymous_page()
Date:   Fri, 30 Apr 2021 12:52:18 -0700
Message-Id: <20210430195232.30491-18-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change do_anonymous_page() to handle the speculative case.
This involves aborting speculative faults if they have to allocate a new
anon_vma, and using pte_map_lock() instead of pte_offset_map_lock()
to complete the page fault.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2f9e4c096dd..d95826c48f1d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3615,8 +3615,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 						vma->vm_page_prot));
 	} else {
 		/* Allocate our own private page. */
-		if (unlikely(anon_vma_prepare(vma)))
-			goto oom;
+		if (unlikely(!vma->anon_vma)) {
+			if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+				return VM_FAULT_RETRY;
+			if (__anon_vma_prepare(vma))
+				goto oom;
+		}
 		page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
 		if (!page)
 			goto oom;
@@ -3637,8 +3641,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		goto release;
+	}
 	if (!pte_none(*vmf->pte)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto unlock;
@@ -3653,6 +3659,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		if (page)
 			put_page(page);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
@@ -3670,6 +3678,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return 0;
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+release:
 	if (page)
 		put_page(page);
 	return ret;
-- 
2.20.1

