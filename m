Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA030624A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhA0Rk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344039AbhA0Rkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:40:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E04864DA3;
        Wed, 27 Jan 2021 17:39:52 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:39:51 -0500
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
Subject: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210127123951.14f8d321@gandalf.local.home>
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

Changes since v3:

  Scrapped the entire idea of having a stub function replace the removed
  tracepoint callback. Instead, simply allocate twice the needed array at
  addition of the tracepoint, and on removal, use the second half of the
  array. This removes the need to allocate anything on removal, which
  removes the possible failure of that allocation.

 kernel/tracepoint.c | 54 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 7261fa0f5e3c..23088f6276a4 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -129,7 +129,7 @@ static struct tracepoint_func *
 func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	 int prio)
 {
-	struct tracepoint_func *old, *new;
+	struct tracepoint_func *old, *new, *tp_funcs;
 	int nr_probes = 0;
 	int pos = -1;
 
@@ -149,10 +149,28 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
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
+	 */
+	tp_funcs->func = tp_funcs + nr_probes + 3;
+	tp_funcs[nr_probes + 3].func = tp_funcs;
+	new = tp_funcs + 1;
 	if (old) {
 		if (pos < 0) {
 			pos = nr_probes;
@@ -164,6 +182,14 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 			memcpy(new + pos + 1, old + pos,
 			       (nr_probes - pos) * sizeof(struct tracepoint_func));
 		}
+		/* Make old point back to the allocated array */
+		old--;
+		/*
+		 * If this is the second half of the array,
+		 * make it point back to the first half.
+		 */
+		if (old->func < old)
+			old = old->func;
 	} else
 		pos = 0;
 	new[pos] = *tp_func;
@@ -202,14 +228,18 @@ static void *func_remove(struct tracepoint_func **funcs,
 		/* N -> 0, (N > 1) */
 		*funcs = NULL;
 		debug_print_probes(*funcs);
+		/* Set old back to what it was allocated to */
+		old--;
+		if (old->func < old)
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
+		new++;
 		for (i = 0; old[i].func; i++)
 			if (old[i].func != tp_func->func
 					|| old[i].data != tp_func->data)
@@ -218,7 +248,7 @@ static void *func_remove(struct tracepoint_func **funcs,
 		*funcs = new;
 	}
 	debug_print_probes(*funcs);
-	return old;
+	return NULL;
 }
 
 static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
@@ -309,8 +339,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		rcu_assign_pointer(tp->funcs, tp_funcs);
 	} else {
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		tracepoint_update_call(tp, tp_funcs,
-				       tp_funcs[0].func != old[0].func);
+		/* Need to sync, if going back to a single caller */
+		tracepoint_update_call(tp, tp_funcs, tp_funcs[1].func == NULL);
 	}
 	release_probes(old);
 	return 0;
-- 
2.25.4

