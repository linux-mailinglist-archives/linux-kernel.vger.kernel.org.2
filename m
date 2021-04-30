Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DB370192
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhD3Tyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:39 -0400
Received: from server.lespinasse.org ([63.205.204.226]:37183 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhD3Txf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:35 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=xyC4YWMYQXg5okBOT+I25AzHoSz3IJwuaB8/iA0p/AY=;
 b=4alexkTsyC3uZni2zW955kLIH7/cxJEXaY5kAd+KYDy1zPDGn17cBxujc6Cmd2xX8mlsi
 9BjuR3Z6KRJsIohCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=xyC4YWMYQXg5okBOT+I25AzHoSz3IJwuaB8/iA0p/AY=;
 b=F9lBNAo30q0ql99dAFCdVKf27nzoKGBO6/YkgLB360VcrFXl9oOJn/NiXASR/OpX6yu5q
 AYM1MAxJgm+qsk5q1FYDKUbOplpLlwf8c6J1NbjZN/N6L+5dTdI3pxu2ZjmTK+6IVX+nuH5
 LMrFAIzKe0xIJwC3UqPVQlQBLow7LKLo6lS4ULhcubgcjVWe7ZzrvfbqAW6+/ukLUWOGY/b
 Enp2whRD+IPVFO3yWGpb5vwaAVi84bDRLUYwoIVDyFE0wwYC//bioKbWK0vm8u+PPo6Z4uA
 SITn326/KMoS5eM2sILhnDcUVF5qUpYVtm71XlOCgBfBLHuQ55YAnrE5CuOA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 8ACF116033B;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 7D23219F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 19/29] mm: implement speculative handling in do_numa_page()
Date:   Fri, 30 Apr 2021 12:52:20 -0700
Message-Id: <20210430195232.30491-20-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change do_numa_page() to use pte_spinlock() when locking the page table,
so that the mmap sequence counter will be validated in the speculative case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eceb1b6e904c..a2230269e034 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4198,8 +4198,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * validation through pte_unmap_same(). It's of NUMA type but
 	 * the pfn may be screwed if the read is non atomic.
 	 */
-	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
-	spin_lock(vmf->ptl);
+	if (!pte_spinlock(vmf))
+		return VM_FAULT_RETRY;
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
-- 
2.20.1

