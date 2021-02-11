Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503A1318375
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBKCKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhBKCKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:10:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48B764EC9;
        Thu, 11 Feb 2021 02:09:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QS-00BAUh-Vf; Wed, 10 Feb 2021 21:09:48 -0500
Message-ID: <20210211020948.863725704@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [for-next][PATCH 03/12] tracepoints: Do not punish non static call users
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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

Link: https://lkml.kernel.org/r/20210208201050.909329787@goodmis.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 42bb5b753b33..2aad1c10821a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -152,9 +152,19 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #ifdef TRACEPOINTS_ENABLED
 
 #ifdef CONFIG_HAVE_STATIC_CALL
-#define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
+#define __DO_TRACE_CALL(name, args)					\
+	do {								\
+		struct tracepoint_func *it_func_ptr;			\
+		void *__data;						\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
+		if (it_func_ptr) {					\
+			__data = (it_func_ptr)->data;			\
+			static_call(tp_func_##name)(__data, args);	\
+		}							\
+	} while (0)
 #else
-#define __DO_TRACE_CALL(name)	__traceiter_##name
+#define __DO_TRACE_CALL(name, args)	__traceiter_##name(NULL, args)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
@@ -163,9 +173,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define __DO_TRACE(name, args, cond, rcuidle)				\
 	do {								\
-		struct tracepoint_func *it_func_ptr;			\
 		int __maybe_unused __idx = 0;				\
-		void *__data;						\
 									\
 		if (!(cond))						\
 			return;						\
@@ -185,12 +193,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
-		it_func_ptr =						\
-			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
-		if (it_func_ptr) {					\
-			__data = (it_func_ptr)->data;			\
-			__DO_TRACE_CALL(name)(__data, args);		\
-		}							\
+		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
 		if (rcuidle) {						\
 			rcu_irq_exit_irqson();				\
-- 
2.29.2


