Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604873FE57E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhIAWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:30:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhIAWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:30:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CFEA22576;
        Wed,  1 Sep 2021 22:29:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D02A13B03;
        Wed,  1 Sep 2021 22:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMdYN8P+L2FiJgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 22:29:23 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] sched: Move wake_q code below try_to_wake_up()
Date:   Wed,  1 Sep 2021 15:28:24 -0700
Message-Id: <20210901222825.6313-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210901222825.6313-1-dave@stgolabs.net>
References: <20210901222825.6313-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such that wake_up_q() can make use of it instead of
wake_up_process(). No change in code.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sched/core.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4462c454ab9..7fc3d22bc6d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -865,92 +865,6 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
-static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
-{
-	struct wake_q_node *node = &task->wake_q;
-
-	/*
-	 * Atomically grab the task, if ->wake_q is !nil already it means
-	 * it's already queued (either by us or someone else) and will get the
-	 * wakeup due to that.
-	 *
-	 * In order to ensure that a pending wakeup will observe our pending
-	 * state, even in the failed case, an explicit smp_mb() must be used.
-	 */
-	smp_mb__before_atomic();
-	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
-		return false;
-
-	/*
-	 * The head is context local, there can be no concurrency.
-	 */
-	*head->lastp = node;
-	head->lastp = &node->next;
-	return true;
-}
-
-/**
- * wake_q_add() - queue a wakeup for 'later' waking.
- * @head: the wake_q_head to add @task to
- * @task: the task to queue for 'later' wakeup
- *
- * Queue a task for later wakeup, most likely by the wake_up_q() call in the
- * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
- * instantly.
- *
- * This function must be used as-if it were wake_up_process(); IOW the task
- * must be ready to be woken at this location.
- */
-void wake_q_add(struct wake_q_head *head, struct task_struct *task)
-{
-	if (__wake_q_add(head, task))
-		get_task_struct(task);
-}
-
-/**
- * wake_q_add_safe() - safely queue a wakeup for 'later' waking.
- * @head: the wake_q_head to add @task to
- * @task: the task to queue for 'later' wakeup
- *
- * Queue a task for later wakeup, most likely by the wake_up_q() call in the
- * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
- * instantly.
- *
- * This function must be used as-if it were wake_up_process(); IOW the task
- * must be ready to be woken at this location.
- *
- * This function is essentially a task-safe equivalent to wake_q_add(). Callers
- * that already hold reference to @task can call the 'safe' version and trust
- * wake_q to do the right thing depending whether or not the @task is already
- * queued for wakeup.
- */
-void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
-{
-	if (!__wake_q_add(head, task))
-		put_task_struct(task);
-}
-
-void wake_up_q(struct wake_q_head *head)
-{
-	struct wake_q_node *node = head->first;
-
-	while (node != WAKE_Q_TAIL) {
-		struct task_struct *task;
-
-		task = container_of(node, struct task_struct, wake_q);
-		/* Task can safely be re-inserted now: */
-		node = node->next;
-		task->wake_q.next = NULL;
-
-		/*
-		 * wake_up_process() executes a full barrier, which pairs with
-		 * the queueing in wake_q_add() so as not to miss wakeups.
-		 */
-		wake_up_process(task);
-		put_task_struct(task);
-	}
-}
-
 /*
  * resched_curr - mark rq's current task 'to be rescheduled now'.
  *
@@ -4172,6 +4086,92 @@ int wake_up_state(struct task_struct *p, unsigned int state)
 	return try_to_wake_up(p, state, 0);
 }
 
+static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	struct wake_q_node *node = &task->wake_q;
+
+	/*
+	 * Atomically grab the task, if ->wake_q is !nil already it means
+	 * it's already queued (either by us or someone else) and will get the
+	 * wakeup due to that.
+	 *
+	 * In order to ensure that a pending wakeup will observe our pending
+	 * state, even in the failed case, an explicit smp_mb() must be used.
+	 */
+	smp_mb__before_atomic();
+	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
+		return false;
+
+	/*
+	 * The head is context local, there can be no concurrency.
+	 */
+	*head->lastp = node;
+	head->lastp = &node->next;
+	return true;
+}
+
+/**
+ * wake_q_add() - queue a wakeup for 'later' waking.
+ * @head: the wake_q_head to add @task to
+ * @task: the task to queue for 'later' wakeup
+ *
+ * Queue a task for later wakeup, most likely by the wake_up_q() call in the
+ * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
+ * instantly.
+ *
+ * This function must be used as-if it were wake_up_process(); IOW the task
+ * must be ready to be woken at this location.
+ */
+void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	if (__wake_q_add(head, task))
+		get_task_struct(task);
+}
+
+/**
+ * wake_q_add_safe() - safely queue a wakeup for 'later' waking.
+ * @head: the wake_q_head to add @task to
+ * @task: the task to queue for 'later' wakeup
+ *
+ * Queue a task for later wakeup, most likely by the wake_up_q() call in the
+ * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
+ * instantly.
+ *
+ * This function must be used as-if it were wake_up_process(); IOW the task
+ * must be ready to be woken at this location.
+ *
+ * This function is essentially a task-safe equivalent to wake_q_add(). Callers
+ * that already hold reference to @task can call the 'safe' version and trust
+ * wake_q to do the right thing depending whether or not the @task is already
+ * queued for wakeup.
+ */
+void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
+{
+	if (!__wake_q_add(head, task))
+		put_task_struct(task);
+}
+
+void wake_up_q(struct wake_q_head *head)
+{
+	struct wake_q_node *node = head->first;
+
+	while (node != WAKE_Q_TAIL) {
+		struct task_struct *task;
+
+		task = container_of(node, struct task_struct, wake_q);
+		/* Task can safely be re-inserted now: */
+		node = node->next;
+		task->wake_q.next = NULL;
+
+		/*
+		 * wake_up_process() executes a full barrier, which pairs with
+		 * the queueing in wake_q_add() so as not to miss wakeups.
+		 */
+		wake_up_process(task);
+		put_task_struct(task);
+	}
+}
+
 /*
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
-- 
2.26.2

