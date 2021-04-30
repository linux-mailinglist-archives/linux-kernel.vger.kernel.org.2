Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21095370182
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhD3Txl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:41 -0400
Received: from server.lespinasse.org ([63.205.204.226]:42153 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhD3TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:22 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=XrNJKiD+gmmouaQBEDV3mKD7UNcz8msknbq0XbuTisY=;
 b=c/51/1unLYjIqVdN/mCnwDipupc8y9BaUfUWoaPw+8lcfZzM8MTrGl0GR8iCl86G/el+9
 VkBqOtDJ9Dy7dbLAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=XrNJKiD+gmmouaQBEDV3mKD7UNcz8msknbq0XbuTisY=;
 b=WpKVbH3zCSFSsOUWUEnw+ZlensRRNG8hYH+1jHHA3Hyq1YoY2rSXA/wnfwQ2Jc2ePKIeO
 eWfcLF3MFa7LhjKg4RzrswI+/6Lydp+qTR0Tt98CAhdDUki3z08/wYDH6Ulm41YdbbRgA50
 r6AMvdvhQN2OO1GXwCcjLxj8tDxcX7HgfD8vGOL60hYuAJkE7QYQO8KSbZFJBEfIcrjeQf8
 lSVKjvYwHUvz0RnDbdJwU+f3+Kr4q/GMwN6YXyeVLiU4MZQo9tXfg28en2dVA1y+GeSKHnJ
 W1Vv+qI7lse73tZxG0LvC5oySnCnQqHqywx2us2XmTIDnarGZZgsuI9PWLrA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 2635516030E;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 144E919F525; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 04/29] do_anonymous_page: use update_mmu_tlb()
Date:   Fri, 30 Apr 2021 12:52:05 -0700
Message-Id: <20210430195232.30491-5-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_mmu_tlb() can be used instead of update_mmu_cache() when the
page fault handler detects that it lost the race to another page fault.

(TODO double check with Bibo Mao <maobibo@loongson.cn>)

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 550405fc3b5e..59ff65cb3ab4 100644
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

