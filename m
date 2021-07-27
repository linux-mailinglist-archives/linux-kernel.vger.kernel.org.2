Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0628B3D7951
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhG0PG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:06:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:36140 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhG0PGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:06:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 61C15350237;
        Tue, 27 Jul 2021 11:06:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ss5ovKjgJl33; Tue, 27 Jul 2021 11:06:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C309C33FF66;
        Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C309C33FF66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627398380;
        bh=ZwSxJkX1USdw84WJsqByGcd2s0tZ3larauw1AMP5ayA=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=faSggLucQDfYsZQpduGeqkLKLFSy0osbp+L7/Emvd9mhvbCyDxKAwgyMm6mcwgW3y
         ZU9lbvk+ZOqkzt7V7VWb1Rk9GAwwdMuRvUBdG83G0dgCKARBK0HeALKdhm8GtnZ5Ny
         JjemNDkjtfrF6aBhQW4jvl3708DtPzehx4uO01I5L5e1xZh9MqLrKSNA2rJaqlgAmk
         vNevy/877E8MKDWt788wsFiXOloDhOV9OTOXliLVQke2XVIsRabZ65m9CeZMf7fyPQ
         AGVrzICs6vu8RbC0cfnuIH1hCSTL65nvP62sDMYL3DMsiisB56b2webmZYqd7R+Ybe
         6WLDr4OsexZag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KoVppCzpmatt; Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id 1C9AA350513;
        Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 2/3] Fix: tracepoint: static call function vs data state mismatch
Date:   Tue, 27 Jul 2021 11:06:12 -0400
Message-Id: <20210727150613.20886-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
References: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a 1->0->1 callbacks transition, there is an issue with the new
callback using the old callback's data.

Considering __DO_TRACE_CALL:

        do {                                                            \
                struct tracepoint_func *it_func_ptr;                    \
                void *__data;                                           \
                it_func_ptr =3D                                          =
 \
                        rcu_dereference_raw((&__tracepoint_##name)->funcs=
); \
                if (it_func_ptr) {                                      \
                        __data =3D (it_func_ptr)->data;                  =
 \

----> [ delayed here on one CPU (e.g. vcpu preempted by the host) ]

                        static_call(tp_func_##name)(__data, args);      \
                }                                                       \
        } while (0)

It has loaded the tp->funcs of the old callback, so it will try to use th=
e old
data. This can be fixed by adding a RCU sync anywhere in the 1->0->1
transition chain.

On a N->2->1 transition, we need an rcu-sync because you may have a
sequence of 3->2->1 (or 1->2->1) where the element 0 data is unchanged
between 2->1, but was changed from 3->2 (or from 1->2), which may be
observed by the static call. This can be fixed by adding an
unconditional RCU sync in transition 2->1.

A follow up fix will introduce a more lightweight scheme based on RCU
get_state and cond_sync.

[ Build tested only. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/tracepoint.c | 100 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 133b6454b287..a85e7dc8b490 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -15,6 +15,13 @@
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
=20
+enum tp_func_state {
+	TP_FUNC_0,
+	TP_FUNC_1,
+	TP_FUNC_2,
+	TP_FUNC_N,
+};
+
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
=20
@@ -246,26 +253,29 @@ static void *func_remove(struct tracepoint_func **f=
uncs,
 	return old;
 }
=20
-static void tracepoint_update_call(struct tracepoint *tp, struct tracepo=
int_func *tp_funcs, bool sync)
+/*
+ * Count the number of functions (enum tp_func_state) in a tp_funcs arra=
y.
+ */
+static enum tp_func_state nr_func_state(const struct tracepoint_func *tp=
_funcs)
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
+static void tracepoint_update_call(struct tracepoint *tp, struct tracepo=
int_func *tp_funcs)
 {
 	void *func =3D tp->iterator;
=20
 	/* Synthetic events do not have static call sites */
 	if (!tp->static_call_key)
 		return;
-
-	if (!tp_funcs[1].func) {
+	if (nr_func_state(tp_funcs) =3D=3D TP_FUNC_1)
 		func =3D tp_funcs[0].func;
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
=20
@@ -299,9 +309,31 @@ static int tracepoint_add_func(struct tracepoint *tp=
,
 	 * a pointer to it.  This array is referenced by __DO_TRACE from
 	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
-	tracepoint_update_call(tp, tp_funcs, false);
-	rcu_assign_pointer(tp->funcs, tp_funcs);
-	static_key_enable(&tp->key);
+	switch (nr_func_state(tp_funcs)) {
+	case TP_FUNC_1:		/* 0->1 */
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
+		rcu_assign_pointer(tp->funcs, tp_funcs);
+		break;
+	case TP_FUNC_N:		/* N->N+1 (N>1) */
+		rcu_assign_pointer(tp->funcs, tp_funcs);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
=20
 	release_probes(old);
 	return 0;
@@ -328,17 +360,45 @@ static int tracepoint_remove_func(struct tracepoint=
 *tp,
 		/* Failed allocating new tp_funcs, replaced func with stub */
 		return 0;
=20
-	if (!tp_funcs) {
+	switch (nr_func_state(tp_funcs)) {
+	case TP_FUNC_0:		/* 1->0 */
 		/* Removed last function */
 		if (tp->unregfunc && static_key_enabled(&tp->key))
 			tp->unregfunc();
=20
 		static_key_disable(&tp->key);
+		/* Set iterator static call */
+		tracepoint_update_call(tp, tp_funcs);
+		/* Both iterator and static call handle NULL tp->funcs */
+		rcu_assign_pointer(tp->funcs, NULL);
+		/*
+		 * Make sure new func never uses old data after a 1->0->1
+		 * transition sequence.
+		 * Considering that transition 0->1 is the common case
+		 * and don't have rcu-sync, issue rcu-sync after
+		 * transition 1->0 to break that sequence by waiting for
+		 * readers to be quiescent.
+		 */
+		tracepoint_synchronize_unregister();
+		break;
+	case TP_FUNC_1:		/* 2->1 */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-	} else {
+		/*
+		 * On 2->1 transition, RCU sync is needed before setting
+		 * static call to first callback, because the observer
+		 * may have loaded any prior tp->funcs after the last one
+		 * associated with an rcu-sync.
+		 */
+		tracepoint_synchronize_unregister();
+		/* Set static call to first function */
+		tracepoint_update_call(tp, tp_funcs);
+		break;
+	case TP_FUNC_N:		/* N->N-1 (N>2) */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		tracepoint_update_call(tp, tp_funcs,
-				       tp_funcs[0].data !=3D old[0].data);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 	release_probes(old);
 	return 0;
--=20
2.20.1

