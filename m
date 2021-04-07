Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBC3560F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347895AbhDGBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:03 -0400
Received: from server.lespinasse.org ([63.205.204.226]:50997 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343701AbhDGBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:49 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Tl7c+fKXT/KEyeD0xB/+YiIdgIzXbLApcUUyx6tYhAc=;
 b=FhQJE30mUdou3MxgfjANMalYk0yghDWwQJi43mxwrXTvsJtXHEht3xYoY0uKAJ6JB1ifc
 I0uHh5I2VEUVnMwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Tl7c+fKXT/KEyeD0xB/+YiIdgIzXbLApcUUyx6tYhAc=;
 b=alvJkzgZCHNhI/J/Oxso+FnyCCyAhh/3VhhOpJiJCr7s9TEQrVPgikpbTw51VxBgDCCQI
 w7FkTc0lTMUagVapscii/LJG9Zm08jY9YDNgDXUE0z4lW5kR1W+S9Bm7eahNxbSt7i1DF/K
 4An6MUsN2GjPOpl1dUda0RSDWa3cLilqgXOLffoFdN0/sfyYZzX5wCQWbvcMLlU4vZczU++
 RshCSwV2fhPQrh/qq33PSljbSoowyZ9Hha9n3Tc6S2Z3iQmF0nZ/D/jZQ3zPPrxmYhm2yiV
 f5fZLHOHzsrbKR0OXKHH9hRON9E8GJ3/o+TyF0pKb2X/3KjsPh7xbhDfDKOg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 7C44916022D;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 68FC519F320; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 03/37] do_anonymous_page: use update_mmu_tlb()
Date:   Tue,  6 Apr 2021 18:44:28 -0700
Message-Id: <20210407014502.24091-4-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_mmu_tlb() can be used instead of update_mmu_cache() when the
page fault handler detects that it lost the race to another page fault.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5efa07fb6cdc..8ee4bd239303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3567,7 +3567,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
 
-- 
2.20.1

