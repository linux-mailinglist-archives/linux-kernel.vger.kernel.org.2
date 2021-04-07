Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2579335611A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbhDGBxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347847AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D71C0613D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=6AcV49LGNOIZDA+U0gUwsONW88L3iArajwLBo0wi7SM=;
 b=F/JpeEdbZWigeVCVPTTSdqZJ3RmaCAHjRMzqvo/hTl26Yo6cwAedoClDxm9iWkPyKyi+O
 VKNDqSGQWJJeSSUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=6AcV49LGNOIZDA+U0gUwsONW88L3iArajwLBo0wi7SM=;
 b=lOJnzzUAMXbVIAnQXUc17f7ODQpWkTLCGso6d9sNX2p5sFxA+RybJ/ZRVZnHdHU7FaNJg
 IfHJX/dxb0wlOIz+fQZs0lG8Q9BG/eQdeBCAUqG6kQFusXFdR0h6ztBi4yUyVGGFAS2m9+K
 xtdu6TgWjUuI5s4nYBdpYef3SiHwztecJhR9uDtW/78irlsStfiyMLvBZvGtXNjQMxIbSDt
 yOGmSHGUhrGfKyAsFTWwFk5iUlb6h3VqlVEtQIshhVrGvkzY2JJSac4ItU9CtuSUucZJQBB
 7A+n6k5oyhzd11dcLHzh+Q/ozbJrXboZhwyKnbNg4U+8azA7seHZbHbxF9nQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id AA2801602A5;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 9A4F419F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 10/37] mm: rcu safe vma freeing
Date:   Tue,  6 Apr 2021 18:44:35 -0700
Message-Id: <20210407014502.24091-11-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for speculative page faults looking up and copying vmas
under protection of an rcu read lock, instead of the usual mmap read lock.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h | 16 +++++++++++-----
 kernel/fork.c            | 11 ++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 70882e628908..024970635921 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -304,12 +304,18 @@ struct vm_userfaultfd_ctx {};
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
-	unsigned long vm_start;		/* Our start address within vm_mm. */
-	unsigned long vm_end;		/* The first byte after our end address
-					   within vm_mm. */
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start, vm_end;
 
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
+			/* linked list of VMAs per task, sorted by address */
+			struct vm_area_struct *vm_next, *vm_prev;
+		};
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
 
 	struct rb_node vm_rb;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 426cd0c51f9e..b6078e546114 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -369,11 +369,20 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
-void vm_area_free(struct vm_area_struct *vma)
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static void __vm_area_free(struct rcu_head *head)
 {
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
+void vm_area_free(struct vm_area_struct *vma)
+{
+	call_rcu(&vma->vm_rcu, __vm_area_free);
+}
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	void *stack = task_stack_page(tsk);
-- 
2.20.1

