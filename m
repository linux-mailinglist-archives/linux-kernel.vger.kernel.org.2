Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328837018A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhD3Tx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:59 -0400
Received: from server.lespinasse.org ([63.205.204.226]:56935 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhD3TxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:24 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=0J/hy/JQlPleTiIXPLrlBogxDyG+sG63ZteLm7sGfKo=;
 b=wyAG608rKGunu7qqRpNcV3RhywqilJmsoDkuatV7pMb2CuBB2Z5fN14HlhxI88n50qQXn
 JOext8U+9dt1WmYDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=0J/hy/JQlPleTiIXPLrlBogxDyG+sG63ZteLm7sGfKo=;
 b=I7GqfkMzcJrmxSVWKzaFi3Mbfg0My9nLk6La+4wSu0ynTAHGbVd/YLF+eo94NlSin0y2x
 5UJRM0G2jchXTm699A4f2yZErshAfuGTcwTU1+KKv7fPd1guFKelgOEdbBOltZG1xjZF6Hr
 cu7453EsgVC4XX/ZmrD7UtuP5ToQJjNcX3bWRZE95xJsL4I79FyjIFIr80NBa5p4b08KDHM
 XKTi1v+b5tKZc28JAcJGdSPPF4ww/d2hsg//WZqoozCHPYBVygjUUATnUIQ147goNNaLGCk
 M9dUpDnqaZNX8DgV5FOjh+BWX1KVhPjjD8OvB/QV47TAysg3vXstHO+Jy0Lw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 531B2160320;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 44ACA19F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 11/29] mm: rcu safe vma freeing
Date:   Fri, 30 Apr 2021 12:52:12 -0700
Message-Id: <20210430195232.30491-12-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for speculative page faults looking up and copying vmas
under protection of an rcu read lock, instead of the usual mmap read lock.

Note - it might also be feasible to just use SLAB_TYPESAFE_BY_RCU when
creating the vm_area_cachep, but that's probably too subtle to consider here.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h | 16 +++++++++++-----
 kernel/fork.c            | 13 +++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

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
index 426cd0c51f9e..7c22bf2b1f9d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -369,9 +369,22 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static void __vm_area_free(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+#endif
+
 void vm_area_free(struct vm_area_struct *vma)
 {
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	call_rcu(&vma->vm_rcu, __vm_area_free);
+#else
 	kmem_cache_free(vm_area_cachep, vma);
+#endif
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.20.1

