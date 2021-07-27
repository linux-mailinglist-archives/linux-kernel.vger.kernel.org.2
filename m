Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1B3D7E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhG0TNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:13:25 -0400
Received: from mail.efficios.com ([167.114.26.124]:37570 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhG0TNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:13:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 32CED35253C;
        Tue, 27 Jul 2021 15:13:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SZY693FB4GSv; Tue, 27 Jul 2021 15:13:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4F11C35216D;
        Tue, 27 Jul 2021 15:13:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4F11C35216D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627413202;
        bh=o6EZ0lYKHzdNKTjPO1vcjh3+jaECndVQNKQ6K+1O7t0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=tfspZcPwb8G+AWXXAkJ/BJoeQjWxBImlrRP3ttdRReleBN/5hWmPvIqGUM/mcq2on
         ppGIBbL7oxkxyPWVqJlpX1RsBa3n2ZaD7YcbdjCjYVarLXaAxqCurMPf8USnXFiLpZ
         ScqGrc+DG7CoJpjSGkcMNsGMX53d8ZBg8MzvPs0kPRg7UqbWGVzmkHc37QfHu7TEuu
         iz5zzPwWXkT5chmBipc0yq3D9pB7vTocU2pMyKIpjcyKx0i/uqlApz5DjAygW5b3rC
         8ktrkgtzfKIFCH7sLcXdHa/0qEsh/QSZaXq67N712cebgDge4mWg4lopdN3/F682pD
         1QTfFr4yFaLlw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q1YLN3B-xrsu; Tue, 27 Jul 2021 15:13:22 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id 04114352495;
        Tue, 27 Jul 2021 15:13:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2] Fix: tracepoint: rcu get state and cond sync for static call updates
Date:   Tue, 27 Jul 2021 15:13:11 -0400
Message-Id: <20210727191311.26061-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727150613.20886-4-mathieu.desnoyers@efficios.com>
References: <20210727150613.20886-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

State transitions from 1->0->1 and N->2->1 callbacks require RCU
synchronization. Rather than performing the RCU synchronization every
time the state change occurs, which is quite slow when many tracepoints
are registered in batch, instead keep a snapshot of the RCU state on the
most recent transitions which belong to a chain, and conditionally wait
for a grace period on the last transition of the chain if one g.p. has
not elapsed since the last snapshot.

This applies to both RCU and SRCU.

[ Build tested only. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
Changes since v1:
- Use tp_rcu_get_state/tp_rcu_cond_sync on 2->1 transition when
  tp_funcs[0].data !=3D old[0].data rather than
  tracepoint_synchronize_unregister.
---
 kernel/tracepoint.c | 81 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index a85e7dc8b490..1140599988a1 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -28,6 +28,44 @@ extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 DEFINE_SRCU(tracepoint_srcu);
 EXPORT_SYMBOL_GPL(tracepoint_srcu);
=20
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
+static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANS=
ITION_SYNC];
+
+static void tp_rcu_get_state(enum tp_transition_sync sync)
+{
+	struct tp_transition_snapshot *snapshot =3D &tp_transition_snapshot[syn=
c];
+
+	/* Keep the latest get_state snapshot. */
+	snapshot->rcu =3D get_state_synchronize_rcu();
+	snapshot->srcu =3D start_poll_synchronize_srcu(&tracepoint_srcu);
+	snapshot->ongoing =3D true;
+}
+
+static void tp_rcu_cond_sync(enum tp_transition_sync sync)
+{
+	struct tp_transition_snapshot *snapshot =3D &tp_transition_snapshot[syn=
c];
+
+	if (!snapshot->ongoing)
+		return;
+	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
+		synchronize_srcu(&tracepoint_srcu);
+	snapshot->ongoing =3D false;
+}
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
=20
@@ -311,6 +349,11 @@ static int tracepoint_add_func(struct tracepoint *tp=
,
 	 */
 	switch (nr_func_state(tp_funcs)) {
 	case TP_FUNC_1:		/* 0->1 */
+		/*
+		 * Make sure new static func never uses old data after a
+		 * 1->0->1 transition sequence.
+		 */
+		tp_rcu_cond_sync(TP_TRANSITION_SYNC_1_0_1);
 		/* Set static call to first function */
 		tracepoint_update_call(tp, tp_funcs);
 		/* Both iterator and static call handle NULL tp->funcs */
@@ -326,9 +369,21 @@ static int tracepoint_add_func(struct tracepoint *tp=
,
 		 * static call update/call.
 		 */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * 1->...->2->1 transition sequence.
+		 */
+		if (tp_funcs[0].data !=3D old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
 		break;
 	case TP_FUNC_N:		/* N->N+1 (N>1) */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>1) transition sequence.
+		 */
+		if (tp_funcs[0].data !=3D old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -372,29 +427,31 @@ static int tracepoint_remove_func(struct tracepoint=
 *tp,
 		/* Both iterator and static call handle NULL tp->funcs */
 		rcu_assign_pointer(tp->funcs, NULL);
 		/*
-		 * Make sure new func never uses old data after a 1->0->1
-		 * transition sequence.
-		 * Considering that transition 0->1 is the common case
-		 * and don't have rcu-sync, issue rcu-sync after
-		 * transition 1->0 to break that sequence by waiting for
-		 * readers to be quiescent.
+		 * Make sure new static func never uses old data after a
+		 * 1->0->1 transition sequence.
 		 */
-		tracepoint_synchronize_unregister();
+		tp_rcu_get_state(TP_TRANSITION_SYNC_1_0_1);
 		break;
 	case TP_FUNC_1:		/* 2->1 */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
 		/*
-		 * On 2->1 transition, RCU sync is needed before setting
-		 * static call to first callback, because the observer
-		 * may have loaded any prior tp->funcs after the last one
-		 * associated with an rcu-sync.
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>2) transition sequence.
 		 */
-		tracepoint_synchronize_unregister();
+		if (tp_funcs[0].data !=3D old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
+		tp_rcu_cond_sync(TP_TRANSITION_SYNC_N_2_1);
 		/* Set static call to first function */
 		tracepoint_update_call(tp, tp_funcs);
 		break;
 	case TP_FUNC_N:		/* N->N-1 (N>2) */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
+		/*
+		 * Make sure static func never uses incorrect data after a
+		 * N->...->2->1 (N>2) transition sequence.
+		 */
+		if (tp_funcs[0].data !=3D old[0].data)
+			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
 		break;
 	default:
 		WARN_ON_ONCE(1);
--=20
2.20.1

