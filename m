Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7D410F49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhITFWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:22:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50610 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhITFWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:22:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCA0F20001;
        Mon, 20 Sep 2021 05:20:45 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DA1213AC7;
        Mon, 20 Sep 2021 05:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODPLBSsaSGFsSwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 20 Sep 2021 05:20:43 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] locking/rwbase: Lockless reader waking up a writer
Date:   Sun, 19 Sep 2021 22:20:31 -0700
Message-Id: <20210920052031.54220-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920052031.54220-1-dave@stgolabs.net>
References: <20210920052031.54220-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the RT-lock safe wake_q to allow waking up the writer
without having to hold the wait_lock across the operation.

While this is ideally for batching wakeups, single wakeup
usage has still shown to be beneficial vs the cost of
try_to_wakeup() when the lock is contended, as well as
not having irqs disabled during the wakeup window, albeit
preemption will remain disabled.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/rtmutex.c   | 19 +++++++++++++------
 kernel/locking/rwbase_rt.c |  6 +++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6bb116c559b4..1581674d640b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -446,19 +446,26 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 }
 
 /* RT mutex specific wake_q wrappers */
-static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
-						struct rt_mutex_waiter *w)
+static __always_inline void rt_mutex_wake_q_add_task(struct rt_wake_q_head *wqh,
+						     struct task_struct *task,
+						     unsigned int wake_state)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wake_state != TASK_NORMAL) {
 		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 			WARN_ON_ONCE(wqh->rtlock_task);
-		get_task_struct(w->task);
-		wqh->rtlock_task = w->task;
+		get_task_struct(task);
+		wqh->rtlock_task = task;
 	} else {
-		wake_q_add(&wqh->head, w->task);
+		wake_q_add(&wqh->head, task);
 	}
 }
 
+static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	rt_mutex_wake_q_add_task(wqh, w->task, w->wake_state);
+}
+
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index a9034784a5a0..8cb58758af3d 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -147,6 +147,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	struct task_struct *owner;
+	DEFINE_RT_WAKE_Q(wqh);
 
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
@@ -157,9 +158,12 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	 */
 	owner = rt_mutex_owner(rtm);
 	if (owner)
-		wake_up_state(owner, state);
+		rt_mutex_wake_q_add_task(&wqh, owner, state);
 
+	/* Pairs with the preempt_enable() in rt_mutex_wake_up_q() */
+	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
-- 
2.26.2

