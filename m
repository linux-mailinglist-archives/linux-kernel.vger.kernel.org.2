Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48853560F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbhDGBvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbhDGBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:48 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Apr 2021 18:51:40 PDT
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E73C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Iko8U1DIjbSXvB60SArqfpM0eO/JE4XY/9ww0rF5/tY=;
 b=JVh6JjMxzNn89HcbkhtljBCgR0nVPb//5K8shZAbIxj2Lntf8NNBDz3YEx3UFhO1kxgKJ
 5YqE9FEx0+LD369DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Iko8U1DIjbSXvB60SArqfpM0eO/JE4XY/9ww0rF5/tY=;
 b=dQPZHYw1jXJV689ACtM7eUIebt/kBXCd1dvdwBsYusq7L0GLbnqv2wFVikzZALG4eQHo0
 hoYZ698ZhW9JVnYeTvVtYzKqNbyqh3sPMi8zirwDBwYhqXnd3a1YM2zYR+HuhFYu7FhwnJk
 VxWIMqJfqNWERV00aB2/UL2n2xZ2W6Rk2nQIPywaAzkmH+w2K6j4UepxDlR4xyiX9KSqoF0
 lAwEqlEnrdlUjWpgBD+rlPCDDg75oOc+D9ZigT09EvxvepHfigE3X9S5ubzIc+GPWGt8qAy
 nyTOnIaOpDbdhTh2qphkLIKriI8niYvWYpvqDBXm8jrwEDynAzF4+3+P9+LQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id CE9BA1602D7;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id BE65319F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 15/37] mm: implement speculative handling in do_anonymous_page()
Date:   Tue,  6 Apr 2021 18:44:40 -0700
Message-Id: <20210407014502.24091-16-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index 3e192d5f89a6..fd84576f9c01 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3598,8 +3598,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
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
@@ -3620,8 +3624,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
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
@@ -3636,6 +3642,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		if (page)
 			put_page(page);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
@@ -3653,6 +3661,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return 0;
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+release:
 	if (page)
 		put_page(page);
 	return ret;
-- 
2.20.1

