Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39EC343CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCVJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCVJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:28:40 -0700 (PDT)
Message-Id: <20210322092258.898677147@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616405319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SqTHQ9A3FGkP/7czdHAUfMbvQp7ls004iQE9zc8VZx8=;
        b=OtC/phBrkTBpJlHB79LWzD9ps3YjG1NdT3y4hzD2w9Ne6JNh9w5PtCo1CTeaijK7N/lef1
        PIJAaaHZ3pozjl7yWqIT4NaXt+bcFthp3Ju+LwlycUBNj+Xknzv+5D2rU6V0RAb6RaNJZr
        ycdtZHoDp4mX78n+qsYe22BWvpHmOfDSOzFJ/CT5xG/SRLe2GYCPP9e2+ytWRzHAAoI/cH
        nd+WAP1LJjIhQjP1+f8vrbNQiS9qQP/j4MF2Ahw7PJKygxrTOi6pCMJCqHMGQubYK+txHY
        ssLIWCjtaJUkS83YpCEflufL7xiRuv/Ety6JQSIF0weSulf3mB7xzT7OKHNMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616405319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SqTHQ9A3FGkP/7czdHAUfMbvQp7ls004iQE9zc8VZx8=;
        b=QE2ktIAVixaBZE5jPHMB53YicBIoORpEfyI4sp/reg1gnndQWBaaot2fyiBxobjetpW0cv
        c0fAugDWCWh3EPCg==
Date:   Mon, 22 Mar 2021 10:19:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [patch V4 1/2] signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()
References: <20210322091941.909544288@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having the conditional at the callsite.

Just hand in the allocation mode flag to __sigqueue_alloc() and use it to
initialize sigqueue::flags.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -410,7 +410,8 @@ void task_join_group_stop(struct task_st
  *   appropriate lock must be held to stop the target task from exiting
  */
 static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimit)
+__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+		 int override_rlimit, const unsigned int sigqueue_flags)
 {
 	struct sigqueue *q = NULL;
 	struct user_struct *user;
@@ -432,7 +433,7 @@ static struct sigqueue *
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, flags);
+		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -442,7 +443,7 @@ static struct sigqueue *
 			free_uid(user);
 	} else {
 		INIT_LIST_HEAD(&q->list);
-		q->flags = 0;
+		q->flags = sigqueue_flags;
 		q->user = user;
 	}
 
@@ -1113,7 +1114,8 @@ static int __send_signal(int sig, struct
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
+	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
 		switch ((unsigned long) info) {
@@ -1807,12 +1809,7 @@ EXPORT_SYMBOL(kill_pid);
  */
 struct sigqueue *sigqueue_alloc(void)
 {
-	struct sigqueue *q = __sigqueue_alloc(-1, current, GFP_KERNEL, 0);
-
-	if (q)
-		q->flags |= SIGQUEUE_PREALLOC;
-
-	return q;
+	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
 }
 
 void sigqueue_free(struct sigqueue *q)

