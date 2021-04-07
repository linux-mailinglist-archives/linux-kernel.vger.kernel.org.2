Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41453560FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbhDGBwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:10 -0400
Received: from server.lespinasse.org ([63.205.204.226]:57789 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=oDsaekR07u2ZtR1enj5FUb1cWHHQoW5twL22pxVnaDw=;
 b=aVLbPOwuUGPHPf1Ujhsv2FvPJz0fLCHY7Qk5nH/FdfC6t9RP45dBC+UVkh7OEJwRA5NGO
 gINHLP2nA2rEEImAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=oDsaekR07u2ZtR1enj5FUb1cWHHQoW5twL22pxVnaDw=;
 b=IPnOCuRQxi3KY+ZyKablrM9wkR6ZD4fXn+28c+kkjDkkYrkusvUcQX/piob3616D3gf62
 867C15f7ac0Z7Yfe2+ANNkmYV/Cdn2iHdUIvLzrvtXTwyzroXU/F5+tdBV5gCgTsZ3DRPD+
 OFCC83+W+Btw7i/N6KVbq6llm0/a8KLfAe8uAGtIzc7jsTC3lMCAcfScT/Pn6mbPtVzzzBp
 DIryKpr1+tOH7RwTYt56bIOomT/HwAqSgI7HR+WPaGM4BMfuzgA2XHI1YwuXQfFKmdmvBqU
 q1Cav343GpyKux7Qqo3LPUSsXtGPMH/GpzC+UyOiansbtZ54CG0zffUbwEcA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id DDE761602FF;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id CC30019F320; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 17/37] mm: implement speculative handling in do_numa_page()
Date:   Tue,  6 Apr 2021 18:44:42 -0700
Message-Id: <20210407014502.24091-18-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index a2c5bf29f989..78cc36749754 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4181,8 +4181,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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

