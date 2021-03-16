Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EE33D78F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhCPPcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238003AbhCPPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615908728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=/aryRHmvAYxNYzA0eFxgiG5XyJHPeCSVTHSDkPFs8YA=;
        b=AaoYJpDXk98ycAZgtGs7D6ys+2/kjRWNPyH6e4oL9FByW1v4OuYDWmT+0JDxlovVszxUaa
        fBUvBwPaYdPMMjiKdo4xy4HCjFpP4EE9XII1EMOnxF+SkLYHYZFuPxy62r+43JE5umch7c
        OTzBRlZ8LiLM4tuaYXmU6YPEn2yLszo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-kypjFUdJNoSC1UqcM_2P8Q-1; Tue, 16 Mar 2021 11:32:04 -0400
X-MC-Unique: kypjFUdJNoSC1UqcM_2P8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E7A880D6AA;
        Tue, 16 Mar 2021 15:32:02 +0000 (UTC)
Received: from llong.com (ovpn-117-133.rdu2.redhat.com [10.10.117.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0A61992D;
        Tue, 16 Mar 2021 15:32:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/4] locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test
Date:   Tue, 16 Mar 2021 11:31:19 -0400
Message-Id: <20210316153119.13802-5-longman@redhat.com>
In-Reply-To: <20210316153119.13802-1-longman@redhat.com>
References: <20210316153119.13802-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww_acquire_ctx structure for ww_mutex needs to persist for a complete
lock/unlock cycle. In the ww_mutex test in locktorture, however, both
ww_acquire_init() and ww_acquire_fini() are called within the lock
function only. This causes a lockdep splat of "WARNING: Nested lock
was not taken" when lockdep is enabled in the kernel.

To fix this problem, we need to move the ww_acquire_fini() after the
ww_mutex_unlock() in torture_ww_mutex_unlock(). In other word, we need
to pass state information from the lock function to the unlock function.
Change the writelock and writeunlock function prototypes to allow that
and change the torture_ww_mutex_lock() and torture_ww_mutex_unlock()
accordingly.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/locktorture.c | 86 +++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 0ab94e1f1276..782925dcf5d9 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -76,10 +76,10 @@ static void lock_torture_cleanup(void);
 struct lock_torture_ops {
 	void (*init)(void);
 	void (*exit)(void);
-	int (*writelock)(void);
+	int (*writelock)(void **parg);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
-	void (*writeunlock)(void);
+	void (*writeunlock)(void *arg);
 	int (*readlock)(void);
 	void (*read_delay)(struct torture_random_state *trsp);
 	void (*readunlock)(void);
@@ -105,7 +105,7 @@ static struct lock_torture_cxt cxt = { 0, 0, false, false,
  * Definitions for lock torture testing.
  */
 
-static int torture_lock_busted_write_lock(void)
+static int torture_lock_busted_write_lock(void **parg __maybe_unused)
 {
 	return 0;  /* BUGGY, do not use in real life!!! */
 }
@@ -122,7 +122,7 @@ static void torture_lock_busted_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_lock_busted_write_unlock(void)
+static void torture_lock_busted_write_unlock(void *arg __maybe_unused)
 {
 	  /* BUGGY, do not use in real life!!! */
 }
@@ -145,7 +145,8 @@ static struct lock_torture_ops lock_busted_ops = {
 
 static DEFINE_SPINLOCK(torture_spinlock);
 
-static int torture_spin_lock_write_lock(void) __acquires(torture_spinlock)
+static int torture_spin_lock_write_lock(void **parg __maybe_unused)
+__acquires(torture_spinlock)
 {
 	spin_lock(&torture_spinlock);
 	return 0;
@@ -169,7 +170,8 @@ static void torture_spin_lock_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_spin_lock_write_unlock(void) __releases(torture_spinlock)
+static void torture_spin_lock_write_unlock(void *arg __maybe_unused)
+__releases(torture_spinlock)
 {
 	spin_unlock(&torture_spinlock);
 }
@@ -185,7 +187,7 @@ static struct lock_torture_ops spin_lock_ops = {
 	.name		= "spin_lock"
 };
 
-static int torture_spin_lock_write_lock_irq(void)
+static int torture_spin_lock_write_lock_irq(void **parg __maybe_unused)
 __acquires(torture_spinlock)
 {
 	unsigned long flags;
@@ -195,7 +197,7 @@ __acquires(torture_spinlock)
 	return 0;
 }
 
-static void torture_lock_spin_write_unlock_irq(void)
+static void torture_lock_spin_write_unlock_irq(void *arg __maybe_unused)
 __releases(torture_spinlock)
 {
 	spin_unlock_irqrestore(&torture_spinlock, cxt.cur_ops->flags);
@@ -214,7 +216,8 @@ static struct lock_torture_ops spin_lock_irq_ops = {
 
 static DEFINE_RWLOCK(torture_rwlock);
 
-static int torture_rwlock_write_lock(void) __acquires(torture_rwlock)
+static int torture_rwlock_write_lock(void **parg __maybe_unused)
+__acquires(torture_rwlock)
 {
 	write_lock(&torture_rwlock);
 	return 0;
@@ -235,7 +238,8 @@ static void torture_rwlock_write_delay(struct torture_random_state *trsp)
 		udelay(shortdelay_us);
 }
 
-static void torture_rwlock_write_unlock(void) __releases(torture_rwlock)
+static void torture_rwlock_write_unlock(void *arg __maybe_unused)
+__releases(torture_rwlock)
 {
 	write_unlock(&torture_rwlock);
 }
@@ -277,7 +281,8 @@ static struct lock_torture_ops rw_lock_ops = {
 	.name		= "rw_lock"
 };
 
-static int torture_rwlock_write_lock_irq(void) __acquires(torture_rwlock)
+static int torture_rwlock_write_lock_irq(void **parg __maybe_unused)
+__acquires(torture_rwlock)
 {
 	unsigned long flags;
 
@@ -286,7 +291,7 @@ static int torture_rwlock_write_lock_irq(void) __acquires(torture_rwlock)
 	return 0;
 }
 
-static void torture_rwlock_write_unlock_irq(void)
+static void torture_rwlock_write_unlock_irq(void *arg __maybe_unused)
 __releases(torture_rwlock)
 {
 	write_unlock_irqrestore(&torture_rwlock, cxt.cur_ops->flags);
@@ -320,7 +325,8 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 
 static DEFINE_MUTEX(torture_mutex);
 
-static int torture_mutex_lock(void) __acquires(torture_mutex)
+static int torture_mutex_lock(void **parg __maybe_unused)
+__acquires(torture_mutex)
 {
 	mutex_lock(&torture_mutex);
 	return 0;
@@ -340,7 +346,8 @@ static void torture_mutex_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_mutex_unlock(void) __releases(torture_mutex)
+static void torture_mutex_unlock(void *arg __maybe_unused)
+__releases(torture_mutex)
 {
 	mutex_unlock(&torture_mutex);
 }
@@ -362,7 +369,7 @@ static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
 
-static int torture_ww_mutex_lock(void)
+static int torture_ww_mutex_lock(void **parg)
 __acquires(torture_ww_mutex_0)
 __acquires(torture_ww_mutex_1)
 __acquires(torture_ww_mutex_2)
@@ -372,7 +379,12 @@ __acquires(torture_ww_mutex_2)
 		struct list_head link;
 		struct ww_mutex *lock;
 	} locks[3], *ll, *ln;
-	struct ww_acquire_ctx ctx;
+	struct ww_acquire_ctx *ctx;
+
+	ctx = kmalloc(sizeof(struct ww_acquire_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	*parg = ctx;
 
 	locks[0].lock = &torture_ww_mutex_0;
 	list_add(&locks[0].link, &list);
@@ -383,12 +395,12 @@ __acquires(torture_ww_mutex_2)
 	locks[2].lock = &torture_ww_mutex_2;
 	list_add(&locks[2].link, &list);
 
-	ww_acquire_init(&ctx, &torture_ww_class);
+	ww_acquire_init(ctx, &torture_ww_class);
 
 	list_for_each_entry(ll, &list, link) {
 		int err;
 
-		err = ww_mutex_lock(ll->lock, &ctx);
+		err = ww_mutex_lock(ll->lock, ctx);
 		if (!err)
 			continue;
 
@@ -399,22 +411,28 @@ __acquires(torture_ww_mutex_2)
 		if (err != -EDEADLK)
 			return err;
 
-		ww_mutex_lock_slow(ll->lock, &ctx);
+		ww_mutex_lock_slow(ll->lock, ctx);
 		list_move(&ll->link, &list);
 	}
 
-	ww_acquire_fini(&ctx);
 	return 0;
 }
 
-static void torture_ww_mutex_unlock(void)
+static void torture_ww_mutex_unlock(void *arg)
 __releases(torture_ww_mutex_0)
 __releases(torture_ww_mutex_1)
 __releases(torture_ww_mutex_2)
 {
+	struct ww_acquire_ctx *ctx = arg;
+
+	if (!ctx)
+		return;
+
 	ww_mutex_unlock(&torture_ww_mutex_0);
 	ww_mutex_unlock(&torture_ww_mutex_1);
 	ww_mutex_unlock(&torture_ww_mutex_2);
+	ww_acquire_fini(ctx);
+	kfree(ctx);
 }
 
 static struct lock_torture_ops ww_mutex_lock_ops = {
@@ -431,7 +449,8 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
 
-static int torture_rtmutex_lock(void) __acquires(torture_rtmutex)
+static int torture_rtmutex_lock(void **parg __maybe_unused)
+__acquires(torture_rtmutex)
 {
 	rt_mutex_lock(&torture_rtmutex);
 	return 0;
@@ -487,7 +506,8 @@ static void torture_rtmutex_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_rtmutex_unlock(void) __releases(torture_rtmutex)
+static void torture_rtmutex_unlock(void *arg __maybe_unused)
+__releases(torture_rtmutex)
 {
 	rt_mutex_unlock(&torture_rtmutex);
 }
@@ -505,7 +525,8 @@ static struct lock_torture_ops rtmutex_lock_ops = {
 #endif
 
 static DECLARE_RWSEM(torture_rwsem);
-static int torture_rwsem_down_write(void) __acquires(torture_rwsem)
+static int torture_rwsem_down_write(void **parg __maybe_unused)
+__acquires(torture_rwsem)
 {
 	down_write(&torture_rwsem);
 	return 0;
@@ -525,7 +546,8 @@ static void torture_rwsem_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_rwsem_up_write(void) __releases(torture_rwsem)
+static void torture_rwsem_up_write(void *arg __maybe_unused)
+__releases(torture_rwsem)
 {
 	up_write(&torture_rwsem);
 }
@@ -579,13 +601,15 @@ static void torture_percpu_rwsem_exit(void)
 	percpu_free_rwsem(&pcpu_rwsem);
 }
 
-static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
+static int torture_percpu_rwsem_down_write(void **parg __maybe_unused)
+__acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
 	return 0;
 }
 
-static void torture_percpu_rwsem_up_write(void) __releases(pcpu_rwsem)
+static void torture_percpu_rwsem_up_write(void *arg __maybe_unused)
+__releases(pcpu_rwsem)
 {
 	percpu_up_write(&pcpu_rwsem);
 }
@@ -618,7 +642,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
  * Lock torture writer kthread.  Repeatedly acquires and releases
  * the lock, checking for duplicate acquisitions.
  */
-static int lock_torture_writer(void *arg)
+static int lock_torture_writer(void *arg __maybe_unused)
 {
 	struct lock_stress_stats *lwsp = arg;
 	DEFINE_TORTURE_RANDOM(rand);
@@ -627,11 +651,13 @@ static int lock_torture_writer(void *arg)
 	set_user_nice(current, MAX_NICE);
 
 	do {
+		void *arg = NULL;
+
 		if ((torture_random(&rand) & 0xfffff) == 0)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->task_boost(&rand);
-		cxt.cur_ops->writelock();
+		cxt.cur_ops->writelock(&arg);
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
 		lock_is_write_held = true;
@@ -642,7 +668,7 @@ static int lock_torture_writer(void *arg)
 		cxt.cur_ops->write_delay(&rand);
 		lock_is_write_held = false;
 		WRITE_ONCE(last_lock_release, jiffies);
-		cxt.cur_ops->writeunlock();
+		cxt.cur_ops->writeunlock(arg);
 
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
-- 
2.18.1

