Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44E356119
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbhDGBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAECC0613DA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=JYD3Wgnyn5x/hzU8kfQiO6ZPV5GuIxiA+PXDzohUvGA=;
 b=zcbm6TYGSbg1fogm0a+YNIILcHGu1mT6vUKLDLx8xjYgGqbgnupaWpyFUw2L92FSmnjah
 aEpUwZWtViFUqIICw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=JYD3Wgnyn5x/hzU8kfQiO6ZPV5GuIxiA+PXDzohUvGA=;
 b=lMWJGAHOqeFns527xMlZ3Fyq6hnMk8R4Zi2s4J9BM4hIMv3x4lvNwIXSLvh4Re3SmRDIp
 QGdMUOLpTfyjweRiRr7ZfG6L/r96l8Q2zb9f40lLLvOEJjDy1dbzpNDwgBwHsux6qykTCmt
 XjTi6WRidOzS4QLMOOBd6GxKcUgtXKRBWI37pGuwdjraLXfHcYfFMJa4SA38fN+jOoYr5GQ
 klq7PozMEUef5/a5ixDM0l4FrhbuhaVk3X4jtOHqYrc8HtYOqWZJCPiDRK9waQs5f1YlVvU
 hH4vEg45qTroyA2tacBcSHTZIlQxGzBz9XwxiZT/OV1aW6mLHzBgv+owcBbQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 274A0160390;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 17FCA19F31E; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 26/37] mm: implement speculative fault handling in finish_fault()
Date:   Tue,  6 Apr 2021 18:44:51 -0700
Message-Id: <20210407014502.24091-27-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the speculative case, we want to avoid direct pmd checks (which
would require some extra synchronization to be safe), and rely on
pte_map_lock which will both lock the page table and verify that the
pmd has not changed from its initial value.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7139004c624d..13e2aaf900e5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3915,23 +3915,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
-	if (pmd_none(*vmf->pmd)) {
-		if (PageTransCompound(page)) {
-			ret = do_set_pmd(vmf, page);
-			if (ret != VM_FAULT_FALLBACK)
-				return ret;
+	if (!(vmf->flags & FAULT_FLAG_SPECULATIVE)) {
+		if (pmd_none(*vmf->pmd)) {
+			if (PageTransCompound(page)) {
+				ret = do_set_pmd(vmf, page);
+				if (ret != VM_FAULT_FALLBACK)
+					return ret;
+			}
+
+			if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+				return VM_FAULT_OOM;
 		}
 
-		if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		/* See comment in __handle_mm_fault() */
+		if (pmd_devmap_trans_unstable(vmf->pmd))
+			return 0;
 	}
 
-	/* See comment in __handle_mm_fault() */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
-		return 0;
-
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				      vmf->address, &vmf->ptl);
+	if (!pte_map_lock(vmf))
+		return VM_FAULT_RETRY;
 	ret = 0;
 	/* Re-check under ptl */
 	if (likely(pte_none(*vmf->pte)))
-- 
2.20.1

