Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFB306700
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhA0WIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbhA0WIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:08:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7933164D9D;
        Wed, 27 Jan 2021 22:07:23 +0000 (UTC)
Date:   Wed, 27 Jan 2021 17:07:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210127170721.58bce7cc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The list of tracepoint callbacks is managed by an array that is protected
by RCU. To update this array, a new array is allocated, the updates are
copied over to the new array, and then the list of functions for the
tracepoint is switched over to the new array. After a completion of an RCU
grace period, the old array is freed.

This process happens for both adding a callback as well as removing one.
But on removing a callback, if the new array fails to be allocated, the
callback is not removed, and may be used after it is freed by the clients
of the tracepoint.

The handling of a failed allocation for removing an event can break use
cases as the error report is not propagated up to the original callers. To
make matters worse, there's some paths that can not handle error cases.

Instead of allocating a new array for removing a tracepoint, allocate twice
the needed size when adding tracepoints to the array. On removing, use the
second half of the allocated array. This removes the need to allocate memory
for removing a tracepoint, as the allocation for removals will already have
been done.

Link: https://lkml.kernel.org/r/20201115055256.65625-1-mmullins@mmlx.us
Link: https://lkml.kernel.org/r/20201116175107.02db396d@gandalf.local.home
Link: https://lkml.kennel.org/r/20201118093405.7a6d2290@gandalf.local.home

Reported-by: Matt Mullins <mmullins@mmlx.us>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v4:

  Added synchronization logic to make sure that two back to back removals
  of the same tracepoint do not happen without a full RCU synchronization
  between them.

Note, I may prefer to take v3, but this is here just in case there's
too much trouble in taking something that technically has undefined
behavior. Even though, that same undefined behavior is used by the
static calls logic.

 kernel/tracepoint.c | 101 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 7261fa0f5e3c..9e654f44eca1 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
+#include <linux/workqueue.h>
 
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
@@ -43,6 +44,10 @@ static DEFINE_MUTEX(tracepoints_mutex);
 static struct rcu_head *early_probes;
 static bool ok_to_free_tracepoints;
 
+static struct work_struct tracepoint_removal_work;
+static int released_probe_counter;
+static int released_probe_next;
+
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -70,6 +75,15 @@ static void rcu_free_old_probes(struct rcu_head *head)
 	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
 }
 
+static void tracepoint_removal_sync(struct work_struct *work)
+{
+	mutex_lock(&tracepoints_mutex);
+	tracepoint_synchronize_unregister();
+	released_probe_counter = released_probe_next;
+	mutex_unlock(&tracepoints_mutex);
+}
+
+
 static __init int release_early_probes(void)
 {
 	struct rcu_head *tmp;
@@ -82,6 +96,8 @@ static __init int release_early_probes(void)
 		call_rcu(tmp, rcu_free_old_probes);
 	}
 
+	INIT_WORK(&tracepoint_removal_work, tracepoint_removal_sync);
+
 	return 0;
 }
 
@@ -129,7 +145,7 @@ static struct tracepoint_func *
 func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	 int prio)
 {
-	struct tracepoint_func *old, *new;
+	struct tracepoint_func *old, *new, *tp_funcs;
 	int nr_probes = 0;
 	int pos = -1;
 
@@ -149,10 +165,33 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 				return ERR_PTR(-EEXIST);
 		}
 	}
-	/* + 2 : one for new probe, one for NULL func */
-	new = allocate_probes(nr_probes + 2);
-	if (new == NULL)
+	/*
+	 * The size of the tp_funcs will be the current size, plus
+	 * one for the new probe, one for the NULL func, and one for
+	 * the pointer to the "removal" array.
+	 * And then double the size to create the "removal" array.
+	 */
+	tp_funcs = allocate_probes((nr_probes + 3) * 2);
+	if (tp_funcs == NULL)
 		return ERR_PTR(-ENOMEM);
+	/*
+	 * When removing a probe and there are more probes left,
+	 * we cannot rely on allocation to succeed to create the new
+	 * RCU array. Thus, the array is doubled here, and on removal of
+	 * a probe with other probes still in the array, the second half
+	 * of the array is used.
+	 *
+	 * The first element of the array has its "func" field point to
+	 * the start of the other half of the array.
+	 *
+	 * The prio field is used to detect back to back removals, and
+	 * force a synchronization to complete before updating.
+	 */
+	tp_funcs->func = tp_funcs + nr_probes + 3;
+	tp_funcs->prio = released_probe_counter;
+	tp_funcs[nr_probes + 3].func = tp_funcs;
+	tp_funcs[nr_probes + 3].prio = released_probe_counter;
+	new = tp_funcs + 1;
 	if (old) {
 		if (pos < 0) {
 			pos = nr_probes;
@@ -164,6 +203,14 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 			memcpy(new + pos + 1, old + pos,
 			       (nr_probes - pos) * sizeof(struct tracepoint_func));
 		}
+		/* Make old point back to the allocated array */
+		old--;
+		/*
+		 * If this is the second half of the array,
+		 * make it point back to the first half.
+		 */
+		if (old->func < (void *)old)
+			old = old->func;
 	} else
 		pos = 0;
 	new[pos] = *tp_func;
@@ -173,6 +220,28 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	return old;
 }
 
+/*
+ * If multiple removals are done on the same tracepoint back to back,
+ * the other half of the tracepoint funcs array may still be in use.
+ * Need to test the "prio" field to see if it can be used, and if
+ * not, need to run the synchronization here.
+ */
+static void sync_if_needed(struct tracepoint_func *old,
+			   struct tracepoint_func *new)
+{
+	/*
+	 * If the new prio is greater than the counter,
+	 * then the sync hasn't finished since it was removed.
+	 * Have to do our own sync now.
+	 */
+	if ((released_probe_counter - new->prio) < 0) {
+		tracepoint_synchronize_unregister();
+		/* These are only updated under tracepoints_mutex */
+		released_probe_counter = released_probe_next;
+	}
+	old->prio = ++released_probe_next;
+}
+
 static void *func_remove(struct tracepoint_func **funcs,
 		struct tracepoint_func *tp_func)
 {
@@ -202,14 +271,19 @@ static void *func_remove(struct tracepoint_func **funcs,
 		/* N -> 0, (N > 1) */
 		*funcs = NULL;
 		debug_print_probes(*funcs);
+		/* Set old back to what it was allocated to */
+		old--;
+		if (old->func < (void *)old)
+			old = old->func;
 		return old;
 	} else {
 		int j = 0;
-		/* N -> M, (N > 1, M > 0) */
-		/* + 1 for NULL */
-		new = allocate_probes(nr_probes - nr_del + 1);
-		if (new == NULL)
-			return ERR_PTR(-ENOMEM);
+
+		/* Use the other half of the array for the new probes */
+		new = old - 1;
+		new = new->func;
+		sync_if_needed(old - 1, new);
+		new++;
 		for (i = 0; old[i].func; i++)
 			if (old[i].func != tp_func->func
 					|| old[i].data != tp_func->data)
@@ -218,7 +292,7 @@ static void *func_remove(struct tracepoint_func **funcs,
 		*funcs = new;
 	}
 	debug_print_probes(*funcs);
-	return old;
+	return NULL;
 }
 
 static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
@@ -309,9 +383,12 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		rcu_assign_pointer(tp->funcs, tp_funcs);
 	} else {
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		tracepoint_update_call(tp, tp_funcs,
-				       tp_funcs[0].func != old[0].func);
+		/* Need to sync, if going back to a single caller */
+		tracepoint_update_call(tp, tp_funcs, tp_funcs[1].func == NULL);
 	}
+	if (ok_to_free_tracepoints &&
+	    released_probe_counter != released_probe_next)
+		schedule_work(&tracepoint_removal_work);
 	release_probes(old);
 	return 0;
 }
-- 
2.25.4

