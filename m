Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449F43A3205
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFJR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFJR2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:28:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203BF601FD;
        Thu, 10 Jun 2021 17:26:57 +0000 (UTC)
Date:   Thu, 10 Jun 2021 13:26:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zhengyejian (Zetta)" <zhengyejian1@huawei.com>
Cc:     <20201106023546.720372267@goodmis.org>, <keescook@chromium.org>,
        <ccross@android.com>, <linux-kernel@vger.kernel.org>,
        Zhangjinhao <zhangjinhao2@huawei.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [BUG] I found a bug when try to enable record_ftrace
Message-ID: <20210610132655.0201ab3d@oasis.local.home>
In-Reply-To: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
References: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 15:42:23 +0800
"Zhengyejian (Zetta)" <zhengyejian1@huawei.com> wrote:

> Enabling 'record_ftrace' seems a basic operation of pstore/ftrace, Does 
> it mean this feature is not available for a while?

I think the update to the recursion protection of ftrace caused this to
trigger. There's a time during context switch into an interrupt and
before the context state is set where the recursion protection would
trigger when it wasn't a real recursion. To handle this, the recursion
protection allows for a single recursion to occur.

But if this protection is used to protect against grabbing a lock, then
it wont work, because a single recursion can cause a deadlock (as it
looks to be what happened here).

The below patch adds a version called ftrace_test_recursion_trylock_safe()
that goes back to the old method, and not allow any recursion at the
same context level (normal, softirq, irq and NMI), and will once again
miss the case when a trace happens at the start of an interrupt but
before the state is set to the interrupt context. But if you are
grabbing locks, you should not be tracing in that area anyway.

Does the below patch fix the issue for you?

-- Steve

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 5939595f0115..941df90a4506 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -41,7 +41,11 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	if (unlikely(oops_in_progress))
 		return;
 
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	/* Locking is not safe to be taken in NMI */
+	if (in_nmi())
+		return;
+
+	bit = ftrace_test_recursion_trylock_safe(ip, parent_ip);
 	if (bit < 0)
 		return;
 
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index a9f9c5714e65..302b895d806c 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -159,8 +159,9 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
-static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
-							int start, int max)
+static __always_inline int __trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
+							  int start, int max,
+							  bool safe)
 {
 	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
@@ -176,7 +177,7 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		 * a switch between contexts. Allow for a single recursion.
 		 */
 		bit = TRACE_TRANSITION_BIT;
-		if (val & (1 << bit)) {
+		if (safe || (val & (1 << bit))) {
 			do_ftrace_record_recursion(ip, pip);
 			return -1;
 		}
@@ -192,6 +193,28 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	return bit + 1;
 }
 
+static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
+							int start, int max)
+{
+	return __trace_test_and_set_recursion(ip, pip, start, max, false);
+}
+
+/*
+ * The safe version does not let any recursion happen.
+ * The unsafe version will allow for a single recursion to deal with
+ * the period during a context switch from normal to interrupt to NMI
+ * that may be in the wrong context. But if the caller is expecting
+ * this to be safe for grabbing locks, it must use the safe version
+ * otherwise it could cause a deadlock. But it may still miss events
+ * in the period of context switches, but if it is grabbing locks
+ * it shouldn't be tracing in that period anyway.
+ */
+static __always_inline int trace_test_and_set_recursion_safe(unsigned long ip, unsigned long pip,
+							int start, int max)
+{
+	return __trace_test_and_set_recursion(ip, pip, start, max, true);
+}
+
 static __always_inline void trace_clear_recursion(int bit)
 {
 	if (!bit)
@@ -208,6 +231,14 @@ static __always_inline void trace_clear_recursion(int bit)
  * Use this for ftrace callbacks. This will detect if the function
  * tracing recursed in the same context (normal vs interrupt),
  *
+ * Note, this may allow one nested level of recursion, because of the
+ * way interrupts are tracked. If a trace happens at the start of
+ * an interrupt before the interrupts state is set, it needs to allow
+ * one recursion to handle this case.
+ *
+ * If this is used to protect locks, use the
+ * ftrace_test_recursion_trylock_safe() version instead.
+ * 
  * Returns: -1 if a recursion happened.
  *           >= 0 if no recursion
  */
@@ -216,6 +247,29 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 {
 	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
 }
+/**
+ * ftrace_test_recursion_trylock_safe - tests for recursion in same context
+ *
+ * Use this for ftrace callbacks. This will detect if the function
+ * tracing recursed in the same context (normal vs interrupt),
+ *
+ * Use this version if you depend on it for grabbing locks.
+ * You should also not be tracing in NMI either.
+ *
+ * This version is the same as the ftrace_test_recursion_trylock() except that
+ * it does not allow any recursion. It may produce a false positive if
+ * a trace occurs at the start of an interrupt but before the interrupt
+ * state is set. Any event that happens in that case will be considered
+ * a "recursion".
+ *
+ * Returns: -1 if a recursion happened.
+ *           >= 0 if no recursion
+ */
+static __always_inline int ftrace_test_recursion_trylock_safe(unsigned long ip,
+							 unsigned long parent_ip)
+{
+	return trace_test_and_set_recursion_safe(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+}
 
 /**
  * ftrace_test_recursion_unlock - called when function callback is complete
