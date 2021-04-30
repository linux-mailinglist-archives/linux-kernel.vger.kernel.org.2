Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71820370191
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhD3Tyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:33 -0400
Received: from server.lespinasse.org ([63.205.204.226]:44459 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhD3Txc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:32 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=1L50YJ40ZUGhKi7U56okv5p4ypQrfJ9Qy1e+oZQLfEs=;
 b=Brwwj7gJyZRfaNkZXJQVGbs8sZpxuIJtgdHMAi1QT3YHt8Bee/ZoafHWKKtqdak76+hm7
 Zkxt0jIKt4dvdwkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=1L50YJ40ZUGhKi7U56okv5p4ypQrfJ9Qy1e+oZQLfEs=;
 b=ouNOvDWkDxT2pSbRkmI32QMVAK9o/l9HE++tUyWfAi5lB/O0izySgxB6nzXJ+UKfpnHmx
 +n7kKQ2SWEHvsaTGG90ts4eyff88aM3tiLqQOmAEnz9AXk5kHBJ2L+aANfN7P/HfDqQCXL5
 4hmfCw4JsNphr/TmFIYIJrnBWT5/2zMSnD84vK5AqH8mZ9S/h6EEtmt4R8x9RXkcdi2NJXY
 QCmVi9n1n0vvwDg6lR7ogUk7bR4uz7bSPyUCsNZz1m4dCBHBkNqRdGgmWdzK4QSNzjI/qlz
 XCvGtDkIE1sX7/T4etK/S4N4HWmfKfIJIocGbiT19PAprQylJxc6pSF04W7Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 90A4D16033C;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 8343919F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 20/29] mm: enable speculative fault handling in do_numa_page()
Date:   Fri, 30 Apr 2021 12:52:21 -0700
Message-Id: <20210430195232.30491-21-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
index a2230269e034..286776b7795b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3363,6 +3363,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
 		goto out;
 
@@ -4359,17 +4364,17 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
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

