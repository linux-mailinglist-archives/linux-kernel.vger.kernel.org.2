Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7241AEED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbhI1M0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbhI1M0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78877C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:24:30 -0700 (PDT)
Message-ID: <20210928122411.537994026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oW73QOu3f/AdUzUjhYABHbfaWiFl350ahmGw5qhov+A=;
        b=YbMHQIocAPX857JQyLI+ciu/4JwUhl/kWevL9yHCcloqlareqWFsJZS7Ogy90vSMQ7IYwD
        Y/Ca2QIt0KQ4hJSI3eHnmmKsT6Lj6bTDO5OGI8ekHaxK0bn5iOUkVR5B/orSyHgi3TlFfK
        /kTwtAOUSCNy5jE76ql0+ngMJ7kMmvJHPc7B+b8WpkhHn/PGbqxaCtuqMrCwdZVeB6YYl3
        0SiGJPO6wKq1UicFcxEgLCE7WLp1TemfGxYOomfBLX3t/5is6qgMDNeercJGXzDLFEEMm5
        W6430gUt8mZ/mFIe6J8vMYKMuvwj0SrkB8Ve0FIvykpFdDOafLns1Cx9tv8zIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oW73QOu3f/AdUzUjhYABHbfaWiFl350ahmGw5qhov+A=;
        b=8nUaT9QKvWTbe0LQF8e3uOG1X7h24Kp+GWyhPV183ZH8B0KP8jzzTgn2bskPF71rgDCpGm
        j0sk100LfnxA9OBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 3/5] sched: Move kprobes cleanup out of finish_task_switch()
References: <20210928122339.502270600@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Sep 2021 14:24:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing cleanups in the tail of schedule() is a latency punishment for the
incoming task. The point of invoking kprobes_task_flush() for a dead task
is that the instances are returned and cannot leak when __schedule() is
kprobed.

Move it into the delayed cleanup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/exit.c       |    2 ++
 kernel/kprobes.c    |    8 ++++----
 kernel/sched/core.c |    6 ------
 3 files changed, 6 insertions(+), 10 deletions(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/kprobes.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -168,6 +169,7 @@ static void delayed_put_task_struct(stru
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
 
+	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1250,10 +1250,10 @@ void kprobe_busy_end(void)
 }
 
 /*
- * This function is called from finish_task_switch when task tk becomes dead,
- * so that we can recycle any function-return probe instances associated
- * with this task. These left over instances represent probed functions
- * that have been called but will never return.
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any function-return probe instances
+ * associated with this task. These left over instances represent probed
+ * functions that have been called but will never return.
  */
 void kprobe_flush_task(struct task_struct *tk)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4846,12 +4846,6 @@ static struct rq *finish_task_switch(str
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
-		/*
-		 * Remove function-return probe instances associated with this
-		 * task and put them back on the free list.
-		 */
-		kprobe_flush_task(prev);
-
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 

