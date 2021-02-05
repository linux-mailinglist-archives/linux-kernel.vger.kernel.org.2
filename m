Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF23119DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhBFDVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBFClz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:41:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D4D64F91;
        Fri,  5 Feb 2021 21:55:04 +0000 (UTC)
Date:   Fri, 5 Feb 2021 16:55:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracepoints: Do not punish non static call users
Message-ID: <20210205165503.70baa91a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

With static calls, a tracepoint can call the callback directly if there is
only one callback registered to that tracepoint. When there is more than
one, the static call will call the tracepoint's "iterator" function, which
needs to reload the tracepoint's "funcs" array again, as it could have
changed since the first time it was loaded.

But an arch without static calls is punished by having to load the
tracepoint's "funcs" array twice. Once in the DO_TRACE macro, and once
again in the iterator macro.

For archs without static calls, there's no reason to load the array macro
in the first place, since the iterator function will do it anyway.

Change the __DO_TRACE_CALL() macro to do the load and call of the
tracepoints funcs array only for architectures with static calls, and just
call the iterator function directly for architectures without static calls.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:
  - Updated change log (no double calls)
  - Added "__maybe_unused" to void *__data

 include/linux/tracepoint.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 966ed8980327..db2c8484b4b1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -152,9 +152,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #ifdef TRACEPOINTS_ENABLED
 
 #ifdef CONFIG_HAVE_STATIC_CALL
-#define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
+#define __DO_TRACE_CALL(name, args)					\
+	do {								\
+		struct tracepoint_func *it_func_ptr;			\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
+		if (it_func_ptr) {					\
+			__data = (it_func_ptr)->data;			\
+			static_call(tp_func_##name)(args);		\
+		}							\
+	} while (0)
 #else
-#define __DO_TRACE_CALL(name)	__traceiter_##name
+#define __DO_TRACE_CALL(name, args)	__traceiter_##name(args)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
@@ -168,9 +177,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define __DO_TRACE(name, proto, args, cond, rcuidle)			\
 	do {								\
-		struct tracepoint_func *it_func_ptr;			\
 		int __maybe_unused __idx = 0;				\
-		void *__data;						\
+		void __maybe_unused *__data;				\
 									\
 		if (!(cond))						\
 			return;						\
@@ -190,12 +198,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
-		it_func_ptr =						\
-			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
-		if (it_func_ptr) {					\
-			__data = (it_func_ptr)->data;			\
-			__DO_TRACE_CALL(name)(args);			\
-		}							\
+		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
 		if (rcuidle) {						\
 			rcu_irq_exit_irqson();				\
-- 
2.25.4

