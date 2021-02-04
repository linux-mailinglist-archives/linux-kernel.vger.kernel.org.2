Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78830FCD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhBDTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236482AbhBDTar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:30:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693BD64F38;
        Thu,  4 Feb 2021 19:30:06 +0000 (UTC)
Date:   Thu, 4 Feb 2021 14:30:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, steven@rostedt.org
Subject: [PATCH v2] tracepoints: Code clean up
Message-ID: <20210204143004.61126582@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Restructure the code a bit to make it simpler, fix some formatting problems
and add READ_ONCE/WRITE_ONCE to make sure there's no compiler load/store
tearing to the variables that can be accessed across CPUs.

Started with Mathieu Desnoyers's patch:

  Link: https://lore.kernel.org/lkml/20210203175741.20665-1-mathieu.desnoyers@efficios.com/

And will keep his signature, but I will take the responsibility of this
being correct, and keep the authorship.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h |  2 +-
 kernel/tracepoint.c        | 91 +++++++++++++++-----------------------
 2 files changed, 36 insertions(+), 57 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 966ed8980327..dc1d4c612cc3 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -309,7 +309,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
 		if (it_func_ptr) {					\
 			do {						\
-				it_func = (it_func_ptr)->func;		\
+				it_func = READ_ONCE((it_func_ptr)->func); \
 				__data = (it_func_ptr)->data;		\
 				((void(*)(void *, proto))(it_func))(__data, args); \
 			} while ((++it_func_ptr)->func);		\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index e8f20ae29c18..9f478d29b926 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -136,9 +136,9 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	 int prio)
 {
 	struct tracepoint_func *old, *new;
-	int nr_probes = 0;
-	int stub_funcs = 0;
-	int pos = -1;
+	int iter_probes;	/* Iterate over old probe array. */
+	int nr_probes = 0;	/* Counter for probes */
+	int pos = -1;		/* Insertion position into new array */
 
 	if (WARN_ON(!tp_func->func))
 		return ERR_PTR(-EINVAL);
@@ -147,54 +147,38 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	old = *funcs;
 	if (old) {
 		/* (N -> N+1), (N != 0, 1) probes */
-		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
-			/* Insert before probes of lower priority */
-			if (pos < 0 && old[nr_probes].prio < prio)
-				pos = nr_probes;
-			if (old[nr_probes].func == tp_func->func &&
-			    old[nr_probes].data == tp_func->data)
+		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func == tp_stub_func)
+				continue;	/* Skip stub functions. */
+			if (old[iter_probes].func == tp_func->func &&
+			    old[iter_probes].data == tp_func->data)
 				return ERR_PTR(-EEXIST);
-			if (old[nr_probes].func == tp_stub_func)
-				stub_funcs++;
+			nr_probes++;
 		}
 	}
-	/* + 2 : one for new probe, one for NULL func - stub functions */
-	new = allocate_probes(nr_probes + 2 - stub_funcs);
+	/* + 2 : one for new probe, one for NULL func */
+	new = allocate_probes(nr_probes + 2);
 	if (new == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (old) {
-		if (stub_funcs) {
-			/* Need to copy one at a time to remove stubs */
-			int probes = 0;
-
-			pos = -1;
-			for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
-				if (old[nr_probes].func == tp_stub_func)
-					continue;
-				if (pos < 0 && old[nr_probes].prio < prio)
-					pos = probes++;
-				new[probes++] = old[nr_probes];
-			}
-			nr_probes = probes;
-			if (pos < 0)
-				pos = probes;
-			else
-				nr_probes--; /* Account for insertion */
-
-		} else if (pos < 0) {
-			pos = nr_probes;
-			memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
-		} else {
-			/* Copy higher priority probes ahead of the new probe */
-			memcpy(new, old, pos * sizeof(struct tracepoint_func));
-			/* Copy the rest after it. */
-			memcpy(new + pos + 1, old + pos,
-			       (nr_probes - pos) * sizeof(struct tracepoint_func));
+		nr_probes = 0;
+		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func == tp_stub_func)
+				continue;
+			/* Insert before probes of lower priority */
+			if (pos < 0 && old[iter_probes].prio < prio)
+				pos = nr_probes++;
+			new[nr_probes++] = old[iter_probes];
 		}
-	} else
+		if (pos < 0)
+			pos = nr_probes++;
+		/* nr_probes now points to the end of the new array */
+	} else {
 		pos = 0;
+		nr_probes = 1; /* must point at end of array */
+	}
 	new[pos] = *tp_func;
-	new[nr_probes + 1].func = NULL;
+	new[nr_probes].func = NULL;
 	*funcs = new;
 	debug_print_probes(*funcs);
 	return old;
@@ -237,11 +221,12 @@ static void *func_remove(struct tracepoint_func **funcs,
 		/* + 1 for NULL */
 		new = allocate_probes(nr_probes - nr_del + 1);
 		if (new) {
-			for (i = 0; old[i].func; i++)
-				if ((old[i].func != tp_func->func
-				     || old[i].data != tp_func->data)
-				    && old[i].func != tp_stub_func)
+			for (i = 0; old[i].func; i++) {
+				if ((old[i].func != tp_func->func ||
+				     old[i].data != tp_func->data) &&
+				    old[i].func != tp_stub_func)
 					new[j++] = old[i];
+			}
 			new[nr_probes - nr_del].func = NULL;
 			*funcs = new;
 		} else {
@@ -249,17 +234,11 @@ static void *func_remove(struct tracepoint_func **funcs,
 			 * Failed to allocate, replace the old function
 			 * with calls to tp_stub_func.
 			 */
-			for (i = 0; old[i].func; i++)
+			for (i = 0; old[i].func; i++) {
 				if (old[i].func == tp_func->func &&
-				    old[i].data == tp_func->data) {
-					old[i].func = tp_stub_func;
-					/* Set the prio to the next event. */
-					if (old[i + 1].func)
-						old[i].prio =
-							old[i + 1].prio;
-					else
-						old[i].prio = -1;
-				}
+				    old[i].data == tp_func->data)
+					WRITE_ONCE(old[i].func, tp_stub_func);
+			}
 			*funcs = old;
 		}
 	}
-- 
2.25.4

