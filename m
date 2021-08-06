Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22373E2F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbhHFSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242582AbhHFSMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:12:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD7261163;
        Fri,  6 Aug 2021 18:12:30 +0000 (UTC)
Date:   Fri, 6 Aug 2021 14:12:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Fix race between tracepoint static call and its
 callback data
Message-ID: <20210806141228.744aa3f0@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Fix tracepoint race between static_call and callback data

As callbacks to a tracepoint are paired with the data that is passed in when
the callback is registered to the tracepoint, it must have that data passed
to the callback when the tracepoint is triggered, else bad things will
happen. To keep the two together, they are both assigned to a tracepoint
structure and added to an array. The tracepoint call site will dereference
the structure (via RCU) and call the callback in that structure along with
the data in that structure. This keeps the callback and data tightly
coupled.

Because of the overhead that retpolines have on tracepoint callbacks, if
there's only one callback attached to a tracepoint (a common case), then it
is called via a static call (code modified to do a direct call instead of an
indirect call). But to implement this, the data had to be decoupled from the
callback, as now the callback is implemented via a direct call from the
static call and not an indirect call from the dereferenced structure.

Note, the static call only calls a callback used when there's a single
callback attached to the tracepoint. If more than one callback is attached
to the same tracepoint, then the static call will call an iterator
function that goes back to dereferencing the structure keeping the callback
and its data tightly coupled again.

Issues can arise when going from 0 callbacks to one, as the static call is
assigned to the callback, and it must take care that the data passed to it
is loaded before the static call calls the callback. Going from 1 to 2
callbacks is not an issue, as long as the static call is updated to the
iterator before the tracepoint structure array is updated via RCU. Going
from 2 to more or back down to 2 is not an issue as the iterator can handle
all theses cases. But going from 2 to 1, care must be taken as the static
call is now calling a callback and the data that is loaded must be the data
for that callback.

Care was taken to ensure the callback and data would be in-sync, but after
a bug was reported, it became clear that not enough was done to make sure
that was the case. These changes address this.

The first change is to compare the old and new data instead of the old and
new callback, as it's the data that can corrupt the callback, even if the
callback is the same (something getting freed).

The next change is to convert these transitions into states, to make it
easier to know when a synchronization is needed, and to perform those
synchronizations. The problem with this patch is that it slows down
disabling all events from under a second, to making it take over 10 seconds
to do the same work. But that is addressed in the final patch.

The final patch uses the RCU state functions to keep track of the RCU state
between the transitions, and only needs to perform the synchronization if an
RCU synchronization hasn't been done already. This brings the performance of
disabling all events back to its original value. That's because no
synchronization is required between disabling tracepoints but is required
when enabling a tracepoint after its been disabled. If an RCU
synchronization happens after the tracepoint is disabled, and before it is
re-enabled, there's no need to do the synchronization again.

Both the second and third patch have subtle complexities that they are
separated into two patches. But because the second patch causes such a
regression in performance, the third patch adds a "Fixes" tag to the second
patch, such that the two must be backported together and not just the second
patch.


Please pull the latest trace-v5.14-rc4-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-rc4-2

Tag SHA1: a4f3efe0ceaf1870a93b16a8ff72581f728d184f
Head SHA1: 7b40066c97ec66a44e388f82fcf694987451768f


Mathieu Desnoyers (3):
      tracepoint: static call: Compare data on transition from 2->1 callees
      tracepoint: Fix static call function vs data state mismatch
      tracepoint: Use rcu get state and cond sync for static call updates

----
 kernel/tracepoint.c | 155 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 20 deletions(-)
---------------------------
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index fc32821f8240..efd14c79fab4 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -15,12 +15,57 @@
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
 
+enum tp_func_state {
+	TP_FUNC_0,
+	TP_FUNC_1,
+	TP_FUNC_2,
+	TP_FUNC_N,
+};
+
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
 DEFINE_SRCU(tracepoint_srcu);
 EXPORT_SYMBOL_GPL(tracepoint_srcu);
 
+enum tp_transition_sync {
+	TP_TRANSITION_SYNC_1_0_1,
+	TP_TRANSITION_SYNC_N_2_1,
+
+	_NR_TP_TRANSITION_SYNC,
+};
+
+struct tp_transition_snapshot {
+	unsigned long rcu;
+	unsigned long srcu;
+	bool ongoing;
+};
+
+/* Protected by tracepoints_mutex */
+static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANSITION_SYNC];
+
+static void tp_rcu_get_state(enum tp_transition_sync sync)
+{
+	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
+
+	/* Keep the latest get_state snapshot. */
+	snapshot->rcu = get_state_synchronize_rcu();
+	snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
+	snapshot->ongoing = true;
+}
+
+static void tp_rcu_cond_sync(enum tp_transition_sync sync)
+{
+	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
+
+	if (!snapshot->ongoing)
+		return;
+	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
+		synchronize_srcu(&tracepoint_srcu);
+	snapshot->ongoing = false;
+}
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -246,26 +291,29 @@ static void *func_remove(struct tracepoint_func **funcs,
 	return old;
 }
 
-static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
+/*
+ * Count the number of functions (enum tp_func_state) in a tp_funcs array.
+ */
+static enum tp_func_state nr_func_state(const struct tracepoint_func *tp_funcs)
+{
+	if (!tp_funcs)
+		return TP_FUNC_0;
+	if (!tp_funcs[1].func)
+		return TP_FUNC_1;
+	if (!tp_funcs[2].func)
+		return TP_FUNC_2;
+	return TP_FUNC_N;	/* 3 or more */
+}
+
+static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs)
 {
 	void *func = tp->iterator;
 
 	/* Synthetic events do not have static call sites */
 	if (!tp->static_call_key)
 		return;
-
-	if (!tp_funcs[1].func) {
+	if (nr_func_state(tp_funcs) == TP_FUNC_1)
 		func = tp_funcs[0].func;
-		/*
-		 * If going from the iterator back to a single caller,
-		 * we need to synchronize with __DO_TRACE to make sure
-		 * that the data passed to the callback is the one that
-		 * belongs to that callback.
-		 */
-		if (sync)
-			tracepoint_synchronize_unregister();
-	}
-
 	__static_call_update(tp->static_call_key, tp->static_call_tramp, func);
 }
 
@@ -299,9 +347,41 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * a pointer to it.  This array is referenced by __DO_TRACE from
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
-	tracepoint_update_call(tp, tp_funcs, false);
-	rcu_assign_pointer(tp->funcs, tp_funcs);
-	static_key_enable(&tp->key);
+	switch (nr_func_state(tp_funcs)) {
+	case TP_FUNC_1:		/* 0->1 */
+		/*
+		 * Make sure new static func never uses old data after a
+		 * 1->0->1 transition sequence.
+		 */
+		tp_rcu_cond_sync(TP_TRANSITION_SYNC_1_0_1);
+		/* Set static call to first function */
+		tracepoint_update_call(tp, tp_funcs);
+		/* Both iterator and static call handle NULL tp->funcs */
+		rcu_assign_pointer(tp->funcs, tp_funcs);
+		static_key_enable(&tp->key);
+		break;
+	case TP_FUNC_2:		/* 1->2 */
+		/* Set iterator static call */
+		tracepoint_update_call(tp, tp_funcs);
+		/*
+		 * Iterator callback installed before updating tp->funcs.
+		 * Requires ordering between RCU assign/dereference and
+		 * static call update/call.
+		 */
+		fallthrough;
+	case TP_FUNC_N:		/* N->N+1 (N>1) */
+		rcu_assign_pointer(tp->funcs, tp_funcs);
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>1) transition sequence.
+		 */
+		if (tp_funcs[0].data != old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 
 	release_probes(old);
 	return 0;
@@ -328,17 +408,52 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		/* Failed allocating new tp_funcs, replaced func with stub */
 		return 0;
 
-	if (!tp_funcs) {
+	switch (nr_func_state(tp_funcs)) {
+	case TP_FUNC_0:		/* 1->0 */
 		/* Removed last function */
 		if (tp->unregfunc && static_key_enabled(&tp->key))
 			tp->unregfunc();
 
 		static_key_disable(&tp->key);
+		/* Set iterator static call */
+		tracepoint_update_call(tp, tp_funcs);
+		/* Both iterator and static call handle NULL tp->funcs */
+		rcu_assign_pointer(tp->funcs, NULL);
+		/*
+		 * Make sure new static func never uses old data after a
+		 * 1->0->1 transition sequence.
+		 */
+		tp_rcu_get_state(TP_TRANSITION_SYNC_1_0_1);
+		break;
+	case TP_FUNC_1:		/* 2->1 */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-	} else {
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>2) transition sequence. If the first
+		 * element's data has changed, then force the synchronization
+		 * to prevent current readers that have loaded the old data
+		 * from calling the new function.
+		 */
+		if (tp_funcs[0].data != old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
+		tp_rcu_cond_sync(TP_TRANSITION_SYNC_N_2_1);
+		/* Set static call to first function */
+		tracepoint_update_call(tp, tp_funcs);
+		break;
+	case TP_FUNC_2:		/* N->N-1 (N>2) */
+		fallthrough;
+	case TP_FUNC_N:
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		tracepoint_update_call(tp, tp_funcs,
-				       tp_funcs[0].func != old[0].func);
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>2) transition sequence.
+		 */
+		if (tp_funcs[0].data != old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 	release_probes(old);
 	return 0;
