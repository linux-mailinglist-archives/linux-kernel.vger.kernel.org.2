Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90623FE57F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbhIAWaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:30:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbhIAWa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:30:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE40020248;
        Wed,  1 Sep 2021 22:29:30 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D03EE13B03;
        Wed,  1 Sep 2021 22:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CPw7Kcb+L2FiJgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 22:29:26 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
Date:   Wed,  1 Sep 2021 15:28:25 -0700
Message-Id: <20210901222825.6313-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210901222825.6313-1-dave@stgolabs.net>
References: <20210901222825.6313-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with the rest of our sleeping locks, use a wake_q to
allow waking up the writer without having to hold the
wait_lock across the operation. While this is ideally
for batching wakeups, single wakeup usage as still shown
to be beneficial vs the cost of try_to_wakeup when the
lock is contended.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/rwbase_rt.c |  4 +++-
 kernel/sched/core.c        | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba15088e640..3444bc709973 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -141,6 +141,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	struct task_struct *owner;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
@@ -151,9 +152,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	 */
 	owner = rt_mutex_owner(rtm);
 	if (owner)
-		wake_up_state(owner, state);
+		wake_q_add(&wake_q, owner);
 
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	wake_up_q_state(&wake_q, state);
 }
 
 static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7fc3d22bc6d8..22c77742f1a7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4151,7 +4151,7 @@ void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
 		put_task_struct(task);
 }
 
-void wake_up_q(struct wake_q_head *head)
+static void __wake_up_q(struct wake_q_head *head, unsigned int state)
 {
 	struct wake_q_node *node = head->first;
 
@@ -4164,14 +4164,24 @@ void wake_up_q(struct wake_q_head *head)
 		task->wake_q.next = NULL;
 
 		/*
-		 * wake_up_process() executes a full barrier, which pairs with
+		 * try_to_wake_up() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
-		wake_up_process(task);
+		try_to_wake_up(task, state, 0);
 		put_task_struct(task);
 	}
 }
 
+void wake_up_q(struct wake_q_head *head)
+{
+	__wake_up_q(head, TASK_NORMAL);
+}
+
+void wake_up_q_state(struct wake_q_head *head, unsigned int state)
+{
+	__wake_up_q(head, state);
+}
+
 /*
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
-- 
2.26.2

