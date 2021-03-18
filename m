Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25575340BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhCRR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232298AbhCRR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2iwde0K1UPqVFhSjvTwuxYwkRAX28/yuAwy14z1Dvvg=;
        b=U/E1VsFoGW6wGfQTN/NpvKsGdaKKxnSajWODsIsAQMpQT7UbmUiwCwgJll8sJcpE4LInje
        FFeVB7qxSbegjHyJUr810Ta1rAqSmBvjgGiUVHSdZIAVYgope2Rn94kJ/Hb3uTr5Umu21V
        6VxwAxDkKBXXL6MPcvbXOGMltP/r33Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-FJl2yCScPLiWbpJy0w0tSg-1; Thu, 18 Mar 2021 13:28:41 -0400
X-MC-Unique: FJl2yCScPLiWbpJy0w0tSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D02A10168C0;
        Thu, 18 Mar 2021 17:28:40 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28BC25D6A8;
        Thu, 18 Mar 2021 17:28:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 4/5] locking/locktorture: Pass thread id to lock/unlock functions
Date:   Thu, 18 Mar 2021 13:28:13 -0400
Message-Id: <20210318172814.4400-5-longman@redhat.com>
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow the lock and unlock functions in locktorture to access
per-thread information, we need to pass some hint on how to locate
those information. One way to do this is to pass in a unique thread
id which can then be used to access a global array for thread specific
information.

Change the lock and unlock method to add a thread id parameter which
can be determined by the offset of the lwsp/lrsp pointer from the global
lwsa/lrsa array.

There is no other functional change in this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/locktorture.c | 94 ++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 3c27f43ab3e8..90a975a95a13 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -76,13 +76,13 @@ static void lock_torture_cleanup(void);
 struct lock_torture_ops {
 	void (*init)(void);
 	void (*exit)(void);
-	int (*writelock)(void);
+	int (*writelock)(int tid);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
-	void (*writeunlock)(void);
-	int (*readlock)(void);
+	void (*writeunlock)(int tid);
+	int (*readlock)(int tid);
 	void (*read_delay)(struct torture_random_state *trsp);
-	void (*readunlock)(void);
+	void (*readunlock)(int tid);
 
 	unsigned long flags; /* for irq spinlocks */
 	const char *name;
@@ -105,7 +105,7 @@ static struct lock_torture_cxt cxt = { 0, 0, false, false,
  * Definitions for lock torture testing.
  */
 
-static int torture_lock_busted_write_lock(void)
+static int torture_lock_busted_write_lock(int tid __maybe_unused)
 {
 	return 0;  /* BUGGY, do not use in real life!!! */
 }
@@ -122,7 +122,7 @@ static void torture_lock_busted_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_lock_busted_write_unlock(void)
+static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 {
 	  /* BUGGY, do not use in real life!!! */
 }
@@ -145,7 +145,8 @@ static struct lock_torture_ops lock_busted_ops = {
 
 static DEFINE_SPINLOCK(torture_spinlock);
 
-static int torture_spin_lock_write_lock(void) __acquires(torture_spinlock)
+static int torture_spin_lock_write_lock(int tid __maybe_unused)
+__acquires(torture_spinlock)
 {
 	spin_lock(&torture_spinlock);
 	return 0;
@@ -169,7 +170,8 @@ static void torture_spin_lock_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_spin_lock_write_unlock(void) __releases(torture_spinlock)
+static void torture_spin_lock_write_unlock(int tid __maybe_unused)
+__releases(torture_spinlock)
 {
 	spin_unlock(&torture_spinlock);
 }
@@ -185,7 +187,7 @@ static struct lock_torture_ops spin_lock_ops = {
 	.name		= "spin_lock"
 };
 
-static int torture_spin_lock_write_lock_irq(void)
+static int torture_spin_lock_write_lock_irq(int tid __maybe_unused)
 __acquires(torture_spinlock)
 {
 	unsigned long flags;
@@ -195,7 +197,7 @@ __acquires(torture_spinlock)
 	return 0;
 }
 
-static void torture_lock_spin_write_unlock_irq(void)
+static void torture_lock_spin_write_unlock_irq(int tid __maybe_unused)
 __releases(torture_spinlock)
 {
 	spin_unlock_irqrestore(&torture_spinlock, cxt.cur_ops->flags);
@@ -214,7 +216,8 @@ static struct lock_torture_ops spin_lock_irq_ops = {
 
 static DEFINE_RWLOCK(torture_rwlock);
 
-static int torture_rwlock_write_lock(void) __acquires(torture_rwlock)
+static int torture_rwlock_write_lock(int tid __maybe_unused)
+__acquires(torture_rwlock)
 {
 	write_lock(&torture_rwlock);
 	return 0;
@@ -235,12 +238,14 @@ static void torture_rwlock_write_delay(struct torture_random_state *trsp)
 		udelay(shortdelay_us);
 }
 
-static void torture_rwlock_write_unlock(void) __releases(torture_rwlock)
+static void torture_rwlock_write_unlock(int tid __maybe_unused)
+__releases(torture_rwlock)
 {
 	write_unlock(&torture_rwlock);
 }
 
-static int torture_rwlock_read_lock(void) __acquires(torture_rwlock)
+static int torture_rwlock_read_lock(int tid __maybe_unused)
+__acquires(torture_rwlock)
 {
 	read_lock(&torture_rwlock);
 	return 0;
@@ -261,7 +266,8 @@ static void torture_rwlock_read_delay(struct torture_random_state *trsp)
 		udelay(shortdelay_us);
 }
 
-static void torture_rwlock_read_unlock(void) __releases(torture_rwlock)
+static void torture_rwlock_read_unlock(int tid __maybe_unused)
+__releases(torture_rwlock)
 {
 	read_unlock(&torture_rwlock);
 }
@@ -277,7 +283,8 @@ static struct lock_torture_ops rw_lock_ops = {
 	.name		= "rw_lock"
 };
 
-static int torture_rwlock_write_lock_irq(void) __acquires(torture_rwlock)
+static int torture_rwlock_write_lock_irq(int tid __maybe_unused)
+__acquires(torture_rwlock)
 {
 	unsigned long flags;
 
@@ -286,13 +293,14 @@ static int torture_rwlock_write_lock_irq(void) __acquires(torture_rwlock)
 	return 0;
 }
 
-static void torture_rwlock_write_unlock_irq(void)
+static void torture_rwlock_write_unlock_irq(int tid __maybe_unused)
 __releases(torture_rwlock)
 {
 	write_unlock_irqrestore(&torture_rwlock, cxt.cur_ops->flags);
 }
 
-static int torture_rwlock_read_lock_irq(void) __acquires(torture_rwlock)
+static int torture_rwlock_read_lock_irq(int tid __maybe_unused)
+__acquires(torture_rwlock)
 {
 	unsigned long flags;
 
@@ -301,7 +309,7 @@ static int torture_rwlock_read_lock_irq(void) __acquires(torture_rwlock)
 	return 0;
 }
 
-static void torture_rwlock_read_unlock_irq(void)
+static void torture_rwlock_read_unlock_irq(int tid __maybe_unused)
 __releases(torture_rwlock)
 {
 	read_unlock_irqrestore(&torture_rwlock, cxt.cur_ops->flags);
@@ -320,7 +328,8 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 
 static DEFINE_MUTEX(torture_mutex);
 
-static int torture_mutex_lock(void) __acquires(torture_mutex)
+static int torture_mutex_lock(int tid __maybe_unused)
+__acquires(torture_mutex)
 {
 	mutex_lock(&torture_mutex);
 	return 0;
@@ -340,7 +349,8 @@ static void torture_mutex_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_mutex_unlock(void) __releases(torture_mutex)
+static void torture_mutex_unlock(int tid __maybe_unused)
+__releases(torture_mutex)
 {
 	mutex_unlock(&torture_mutex);
 }
@@ -372,7 +382,7 @@ static void torture_ww_mutex_init(void)
 	ww_mutex_init(&torture_ww_mutex_2, &torture_ww_class);
 }
 
-static int torture_ww_mutex_lock(void)
+static int torture_ww_mutex_lock(int tid __maybe_unused)
 __acquires(torture_ww_mutex_0)
 __acquires(torture_ww_mutex_1)
 __acquires(torture_ww_mutex_2)
@@ -417,7 +427,7 @@ __acquires(torture_ww_mutex_2)
 	return 0;
 }
 
-static void torture_ww_mutex_unlock(void)
+static void torture_ww_mutex_unlock(int tid __maybe_unused)
 __releases(torture_ww_mutex_0)
 __releases(torture_ww_mutex_1)
 __releases(torture_ww_mutex_2)
@@ -442,7 +452,8 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
 
-static int torture_rtmutex_lock(void) __acquires(torture_rtmutex)
+static int torture_rtmutex_lock(int tid __maybe_unused)
+__acquires(torture_rtmutex)
 {
 	rt_mutex_lock(&torture_rtmutex);
 	return 0;
@@ -498,7 +509,8 @@ static void torture_rtmutex_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_rtmutex_unlock(void) __releases(torture_rtmutex)
+static void torture_rtmutex_unlock(int tid __maybe_unused)
+__releases(torture_rtmutex)
 {
 	rt_mutex_unlock(&torture_rtmutex);
 }
@@ -516,7 +528,8 @@ static struct lock_torture_ops rtmutex_lock_ops = {
 #endif
 
 static DECLARE_RWSEM(torture_rwsem);
-static int torture_rwsem_down_write(void) __acquires(torture_rwsem)
+static int torture_rwsem_down_write(int tid __maybe_unused)
+__acquires(torture_rwsem)
 {
 	down_write(&torture_rwsem);
 	return 0;
@@ -536,12 +549,14 @@ static void torture_rwsem_write_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_rwsem_up_write(void) __releases(torture_rwsem)
+static void torture_rwsem_up_write(int tid __maybe_unused)
+__releases(torture_rwsem)
 {
 	up_write(&torture_rwsem);
 }
 
-static int torture_rwsem_down_read(void) __acquires(torture_rwsem)
+static int torture_rwsem_down_read(int tid __maybe_unused)
+__acquires(torture_rwsem)
 {
 	down_read(&torture_rwsem);
 	return 0;
@@ -561,7 +576,8 @@ static void torture_rwsem_read_delay(struct torture_random_state *trsp)
 		torture_preempt_schedule();  /* Allow test to be preempted. */
 }
 
-static void torture_rwsem_up_read(void) __releases(torture_rwsem)
+static void torture_rwsem_up_read(int tid __maybe_unused)
+__releases(torture_rwsem)
 {
 	up_read(&torture_rwsem);
 }
@@ -590,24 +606,28 @@ static void torture_percpu_rwsem_exit(void)
 	percpu_free_rwsem(&pcpu_rwsem);
 }
 
-static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
+static int torture_percpu_rwsem_down_write(int tid __maybe_unused)
+__acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
 	return 0;
 }
 
-static void torture_percpu_rwsem_up_write(void) __releases(pcpu_rwsem)
+static void torture_percpu_rwsem_up_write(int tid __maybe_unused)
+__releases(pcpu_rwsem)
 {
 	percpu_up_write(&pcpu_rwsem);
 }
 
-static int torture_percpu_rwsem_down_read(void) __acquires(pcpu_rwsem)
+static int torture_percpu_rwsem_down_read(int tid __maybe_unused)
+__acquires(pcpu_rwsem)
 {
 	percpu_down_read(&pcpu_rwsem);
 	return 0;
 }
 
-static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
+static void torture_percpu_rwsem_up_read(int tid __maybe_unused)
+__releases(pcpu_rwsem)
 {
 	percpu_up_read(&pcpu_rwsem);
 }
@@ -632,6 +652,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 static int lock_torture_writer(void *arg)
 {
 	struct lock_stress_stats *lwsp = arg;
+	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
@@ -642,7 +663,7 @@ static int lock_torture_writer(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		cxt.cur_ops->task_boost(&rand);
-		cxt.cur_ops->writelock();
+		cxt.cur_ops->writelock(tid);
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
 		lock_is_write_held = true;
@@ -653,7 +674,7 @@ static int lock_torture_writer(void *arg)
 		cxt.cur_ops->write_delay(&rand);
 		lock_is_write_held = false;
 		WRITE_ONCE(last_lock_release, jiffies);
-		cxt.cur_ops->writeunlock();
+		cxt.cur_ops->writeunlock(tid);
 
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
@@ -670,6 +691,7 @@ static int lock_torture_writer(void *arg)
 static int lock_torture_reader(void *arg)
 {
 	struct lock_stress_stats *lrsp = arg;
+	int tid = lrsp - cxt.lrsa;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("lock_torture_reader task started");
@@ -679,7 +701,7 @@ static int lock_torture_reader(void *arg)
 		if ((torture_random(&rand) & 0xfffff) == 0)
 			schedule_timeout_uninterruptible(1);
 
-		cxt.cur_ops->readlock();
+		cxt.cur_ops->readlock(tid);
 		lock_is_read_held = true;
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lrsp->n_lock_fail++; /* rare, but... */
@@ -687,7 +709,7 @@ static int lock_torture_reader(void *arg)
 		lrsp->n_lock_acquired++;
 		cxt.cur_ops->read_delay(&rand);
 		lock_is_read_held = false;
-		cxt.cur_ops->readunlock();
+		cxt.cur_ops->readunlock(tid);
 
 		stutter_wait("lock_torture_reader");
 	} while (!torture_must_stop());
-- 
2.18.1

