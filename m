Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FAB3560FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347944AbhDGBwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:19 -0400
Received: from server.lespinasse.org ([63.205.204.226]:45811 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347821AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=7VQ5ACimMolgPW4s1A3qwSpAn4d6FTK3GCINFHzHKDI=;
 b=eoRVwI4VRjX6AijehpC7K3tU1RbT1JP295NDDl/XBGqvnKyJaXaUPR05Zgk1H6zM6EGZ1
 u9NTXZPxmckNnhYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=7VQ5ACimMolgPW4s1A3qwSpAn4d6FTK3GCINFHzHKDI=;
 b=B99SXq/PA3x+rlEbA0HjxJukiKRbVLDPhETEfSwSgzxEn+W9W06Uf2s5k9EroMwNl4xav
 7NZeXigGVzV5aRvtNC5NWBkCKJtYRKHbtiXpjNex0oEdrMrneYB7rYvSW0O2603yNKvxSRR
 q80ALnrADxKmUhjyzYZOpjQ8i1FyAKRlRJj1LusRsAWcyJ/YNLqE8dPdmY+f141Q57CSUX/
 DsPjOqypmX+BuOBIPyXCowz87r1zD8tlu3XmF6BLwrlhnnLfDy3RSdwVl4eCnRwAEuzDFPY
 0YWa70k+FHAYSd6yR44f4WEHzjhB6k+E1R6+PETGVFqYf0mGkGvOQYorrk+Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id E2DAD160302;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D29FC19F321; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 18/37] mm: enable speculative fault handling in do_numa_page()
Date:   Tue,  6 Apr 2021 18:44:43 -0700
Message-Id: <20210407014502.24091-19-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change handle_pte_fault() to allow speculative fault execution to proceed
through do_numa_page().

do_swap_page() does not implement speculative execution yet, so it
needs to abort with VM_FAULT_RETRY in that case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78cc36749754..eea72bd78d06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3346,6 +3346,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
 		goto out;
 
@@ -4342,17 +4347,17 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
-		pte_unmap(vmf->pte);
-		return VM_FAULT_RETRY;
-	}
-
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
-- 
2.20.1

