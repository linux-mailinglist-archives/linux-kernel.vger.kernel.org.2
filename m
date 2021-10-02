Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2638541FDFB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhJBUGA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Oct 2021 16:06:00 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:39238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233950AbhJBUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:05:56 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B6C2A1808B2BD;
        Sat,  2 Oct 2021 20:04:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 2163A18A612;
        Sat,  2 Oct 2021 20:04:09 +0000 (UTC)
Date:   Sat, 02 Oct 2021 16:04:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC][PATCH] tracing: Define "fake" struct trace_pid_list
User-Agent: K-9 Mail for Android
Message-ID: <7E585A79-A705-4CB9-9E4C-0E73DCE237E2@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2163A18A612
X-Stat-Signature: 1irdst9r91rgkk1ib775z5esxknmegrc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18dRtjbUDlWD37tbp7U62Ij/tCT8F1QKhw=
X-HE-Tag: 1633205049-972717
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Note, this is on top of my tree in ftrace/core, but wanted to ask if
  this is the proper "fix". I moved the struct trace_pid_list into a
  separate file to have more control over it, and only declare the
  structure to be passed by pointers. It is protected by RCU sched, and
  uses the rcu_dereference_sched() to retrieve the pointer, but while
  testing it against gcc 8, it gave the error below. It compiles fine
  on gcc 10. The issue is that on gcc 8, the "typeof(*p)" used in
  rcu_dereference_sched() causes the "incomplete type" error, because
  it does a "*p" where p is a pointer to the undefined struct
  trace_pid_list. To get around this error, I declared struct
  trace_pid_list as the following:

    struct trace_pid_list {
	volatile void *ignore;
    };

  With a #ifdef around it to allow it to be declared properly where it
  is modified, but all other uses has this fake structure pointer.
  This is obviously a hack workaround. But since we support gcc 8, and
  I don't want to expose this structure for anything else, is this OK
  to do?
]

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Some compilers give this error:

kernel/trace/ftrace.c: In function 'ftrace_filter_pid_sched_switch_probe':
include/linux/rcupdate.h:389:9: error: dereferencing pointer to incomplete type 'struct trace_pid_list'
  typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
         ^
include/linux/rcupdate.h:558:2: note: in expansion of macro '__rcu_dereference_check'
  __rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
  ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/rcupdate.h:612:34: note: in expansion of macro 'rcu_dereference_sched_check'
 #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c:7101:13: note: in expansion of macro 'rcu_dereference_sched'
  pid_list = rcu_dereference_sched(tr->function_pids);
             ^~~~~~~~~~~~~~~~~~~~~

The reason is that rcu_dereference_sched() has a check that uses
typeof(*p) of the pointer passed to it. But here, the pointer is of type
"struct trace_pid_list *" which is abstracted out, and nothing outside of
pid_list.c should care what the content of it is. But the check uses
typeof(*p) and on some (not all) compilers, it errors with the
dereferencing pointer to incomplete type, which is totally bogus here.

Instead of just declaring "struct trace_pid_list", define it as a
structure with a volatile pointer (just to keep the compiler from doing any
optimization tricks).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/pid_list.c |  1 +
 kernel/trace/trace.h    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 6d1e6cda6973..c4b1bbc59b7b 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/irq_work.h>
 #include <linux/slab.h>
+#define DEFINED_PID_LIST
 #include "trace.h"
 
 /*
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fe13a0542486..46323ceed8e8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -188,7 +188,19 @@ struct trace_options {
 	struct trace_option_dentry	*topts;
 };
 
-struct trace_pid_list;
+#ifndef DEFINED_PID_LIST
+/*
+ * rcu_dereference_sched() does typeof(*p) on struct trace_pid_list *, and that
+ * causes some compiler versions to error, with "dereferencing pointer to incomplete type"
+ * because the "*p" of "typeof(*p)" dereferences the pointer to trace_pid_list.
+ * As nothing should need to know that structure, and it should remain
+ * abstracted, define a fake structure for all uses, and define it where it is
+ * actually updated.
+ */
+struct trace_pid_list {
+	volatile void *ignore;	/* Add volatile just to keep from any tricky optimizations */
+};
+#endif
 
 struct trace_pid_list *trace_pid_list_alloc(void);
 void trace_pid_list_free(struct trace_pid_list *pid_list);
-- 
2.31.1


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
