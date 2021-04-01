Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07C3522C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDAWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:30:29 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:44420 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhDAWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:30:26 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 1CBBC5A22061; Thu,  1 Apr 2021 23:30:19 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: page_owner: detect page_owner recursion via task_struct
Date:   Thu,  1 Apr 2021 23:30:10 +0100
Message-Id: <20210401223010.3580480-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change page_owner recursion was detected via fetching
backtrace and inspecting it for current instruction pointer.
It has a few problems:
- it is slightly slow as it requires extra backtrace and a linear
  stack scan of the result
- it is too late to check if backtrace fetching required memory
  allocation itself (ia64's unwinder requires it).

To simplify recursion tracking let's use page_owner recursion depth
as a counter in 'struct task_struct'.

The change make page_owner=on work on ia64 bu avoiding infinite
recursion in:
  kmalloc()
  -> __set_page_owner()
  -> save_stack()
  -> unwind() [ia64-specific]
  -> build_script()
  -> kmalloc()
  -> __set_page_owner() [we short-circuit here]
  -> save_stack()
  -> unwind() [recursion]

CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 include/linux/sched.h |  9 +++++++++
 init/init_task.c      |  3 +++
 mm/page_owner.c       | 41 +++++++++++++++++------------------------
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164c..35771703fd89 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1371,6 +1371,15 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+#ifdef CONFIG_PAGE_OWNER
+	/*
+	 * Used by page_owner=on to detect recursion in page tracking.
+	 * Is it fine to have non-atomic ops here if we ever access
+	 * this variable via current->page_owner_depth?
+	 */
+	unsigned int page_owner_depth;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/init_task.c b/init/init_task.c
index 3711cdaafed2..f579f2b2eca8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -213,6 +213,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_PAGE_OWNER
+	.page_owner_depth	= 0,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 7147fd34a948..422558605fcc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -20,6 +20,16 @@
  */
 #define PAGE_OWNER_STACK_DEPTH (16)
 
+/*
+ * How many reenters we allow to page_owner.
+ *
+ * Sometimes metadata allocation tracking requires more memory to be allocated:
+ * - when new stack trace is saved to stack depot
+ * - when backtrace itself is calculated (ia64)
+ * Instead of falling to infinite recursion give it a chance to recover.
+ */
+#define PAGE_OWNER_MAX_RECURSION_DEPTH (1)
+
 struct page_owner {
 	unsigned short order;
 	short last_migrate_reason;
@@ -97,42 +107,25 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 	return (void *)page_ext + page_owner_ops.offset;
 }
 
-static inline bool check_recursive_alloc(unsigned long *entries,
-					 unsigned int nr_entries,
-					 unsigned long ip)
-{
-	unsigned int i;
-
-	for (i = 0; i < nr_entries; i++) {
-		if (entries[i] == ip)
-			return true;
-	}
-	return false;
-}
-
 static noinline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
 	depot_stack_handle_t handle;
 	unsigned int nr_entries;
 
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
-
-	/*
-	 * We need to check recursion here because our request to
-	 * stackdepot could trigger memory allocation to save new
-	 * entry. New memory allocation would reach here and call
-	 * stack_depot_save_entries() again if we don't catch it. There is
-	 * still not enough memory in stackdepot so it would try to
-	 * allocate memory again and loop forever.
-	 */
-	if (check_recursive_alloc(entries, nr_entries, _RET_IP_))
+	/* Avoid recursion. Used in stack trace generation code. */
+	if (current->page_owner_depth >= PAGE_OWNER_MAX_RECURSION_DEPTH)
 		return dummy_handle;
 
+	current->page_owner_depth++;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
+
 	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
 
+	current->page_owner_depth--;
 	return handle;
 }
 
-- 
2.31.1

