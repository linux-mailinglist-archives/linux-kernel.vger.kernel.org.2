Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2504633754E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhCKOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:18:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhCKOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:18:19 -0500
Message-Id: <20210311141704.277918568@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615472297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NA+cKUl60TKT2nkDl2yR85HAvsU/wki3E5wIm6XMrpU=;
        b=aH08KUVXEGLEG0fqT8WddyHhqtUr0NZr1yqYRD5JDzgWbgYjJ9zRo07esCXM49ROUd2QRI
        Ytp0TIfsLYT+zZ44sAdykeIeUcS9wjwx3IrosUB0rc2oWzgz7VnON9tv8pmwPx5cYoKemU
        G5l8aeMzLWW+A34jBnr6EWkLMpYFKLuBc9PNtUIZVQbvm1cYjtafUq7ULI0kISN/JmUnuI
        c4l4cHt0zigtuIwelD1M5mzqAkFiaHcEy0i8mtczfNT9QsSvW7USKRKWkSPgO28VoV65T7
        dHBL/uTUyY7HBBuZt85/VbbLSi/eb+NNh7hZ2AhuoCH2jJFphcD4MP3KW7ziCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615472297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NA+cKUl60TKT2nkDl2yR85HAvsU/wki3E5wIm6XMrpU=;
        b=MkF9AptnQd96orEOvFLer8nBFlC+hxM7z37qslGOuLOdSUG5axguqfYm7Jav362aZlIzD5
        Ni4v16x1XiHeq7Cw==
Date:   Thu, 11 Mar 2021 14:20:38 +0100
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
Subject: [patch V2 2/3] signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()
References: <20210311132036.228542540@linutronix.de>
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
 
@@ -1122,7 +1123,8 @@ static int __send_signal(int sig, struct
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
+	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
 		switch ((unsigned long) info) {
@@ -1816,12 +1818,7 @@ EXPORT_SYMBOL(kill_pid);
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

