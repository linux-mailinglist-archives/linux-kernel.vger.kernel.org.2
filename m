Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E35318376
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBKCLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhBKCKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:10:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6AEC60230;
        Thu, 11 Feb 2021 02:09:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QS-00BAUD-R2; Wed, 10 Feb 2021 21:09:48 -0500
Message-ID: <20210211020948.718057244@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [for-next][PATCH 02/12] tracepoints: Remove unnecessary "data_args" macro parameter
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While working on a clean up that would restructure the difference between
architectures that have static calls vs those that do not, I was stumbling
over the "data_args" parameter that includes "__data" in the arguments. The
issue was that one version didn't even need it, while the other one did.
Instead of injecting a "__data = NULL;" into the macro for the unneeded
version, just remove it completely.

The original idea behind data_args is that there may be a case of a
tracepoint with no arguments. But this is considered bad practice, and all
tracepoints should pass something to that location (that's what tracepoints
were created for).

Link: https://lkml.kernel.org/r/20210208201050.768074128@goodmis.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 966ed8980327..42bb5b753b33 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -160,13 +160,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 /*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
- *
- * Note, the proto and args passed in includes "__data" as the first parameter.
- * The reason for this is to handle the "void" prototype. If a tracepoint
- * has a "void" prototype, then it is invalid to declare a function
- * as "(void *, void)".
  */
-#define __DO_TRACE(name, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(name, args, cond, rcuidle)				\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		int __maybe_unused __idx = 0;				\
@@ -194,7 +189,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
 		if (it_func_ptr) {					\
 			__data = (it_func_ptr)->data;			\
-			__DO_TRACE_CALL(name)(args);			\
+			__DO_TRACE_CALL(name)(__data, args);		\
 		}							\
 									\
 		if (rcuidle) {						\
@@ -206,17 +201,16 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	} while (0)
 
 #ifndef MODULE
-#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
+#define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
-				TP_PROTO(data_proto),			\
-				TP_ARGS(data_args),			\
+				TP_ARGS(args),				\
 				TP_CONDITION(cond), 1);			\
 	}
 #else
-#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args)
+#define __DECLARE_TRACE_RCU(name, proto, args, cond)
 #endif
 
 /*
@@ -231,7 +225,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * even when this tracepoint is off. This code has no purpose other than
  * poking RCU a bit.
  */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
@@ -239,8 +233,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
 			__DO_TRACE(name,				\
-				TP_PROTO(data_proto),			\
-				TP_ARGS(data_args),			\
+				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			rcu_read_lock_sched_notrace();			\
@@ -249,7 +242,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
+			    PARAMS(cond))				\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -332,7 +325,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline void trace_##name##_rcuidle(proto)		\
@@ -412,14 +405,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define DECLARE_TRACE(name, proto, args)				\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
-			PARAMS(void *__data, proto),			\
-			PARAMS(__data, args))
+			PARAMS(void *__data, proto))
 
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
-			PARAMS(void *__data, proto),			\
-			PARAMS(__data, args))
+			PARAMS(void *__data, proto))
 
 #define TRACE_EVENT_FLAGS(event, flag)
 
-- 
2.29.2


