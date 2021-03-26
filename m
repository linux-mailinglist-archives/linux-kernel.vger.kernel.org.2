Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA734AC27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCZQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:01:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCZQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:31 -0400
Message-Id: <20210326153943.061103415@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ERv4b/SO2o1L4SIyMqm0aGcbAhBK3azDtTSXDmAG/uY=;
        b=M65nQCvXF9lZt2B4rX6D+6B4p+YGqegGdoYCSMQlepacG9+YoprzAnfi8h4/dpeQTm+giT
        3V6WQExhYYoU+CAHA9eoFGpjhkdWz7UhH+V9O+y3ZZTQjt6ZqlJd/QBBU5wvnmbMGxJLXW
        siBToDO6975UdH09LUrxju3I82l1HOBe/1BjJ2bRW4DHfKdSa0RnkQdZm8Y23ygU88vT6u
        FwlYKk/zVCkTifSTihcmEGfzPfa6Il5J6DgT7lXV/B29MEnfNC5SZHVUGuEy9wqdAoRizB
        ytxKLe6uue1AZFhk2lUb5b75jVUbNIgTFMpb/fg6K5uy91sjL0IfZn78Sew1MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ERv4b/SO2o1L4SIyMqm0aGcbAhBK3azDtTSXDmAG/uY=;
        b=8h4+uQwD/OIhh5ijQYqvMmN53/v/C2i2Pkrexj4hqOf9tH0Xf5derZaK1oqkPx5cf7vfXh
        BpJ7alC1/FbQfbAw==
Date:   Fri, 26 Mar 2021 16:29:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 01/15] locking/rtmutex: Remove rt_mutex_timed_lock()
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rt_mutex_timed_lock() has no callers since commit c051b21f71d1f ("rtmutex:
Confine deadlock logic to futex")

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h  |    3 ---
 kernel/locking/rtmutex.c |   46 ----------------------------------------------
 2 files changed, 49 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -115,9 +115,6 @@ extern void rt_mutex_lock(struct rt_mute
 #endif
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
-extern int rt_mutex_timed_lock(struct rt_mutex *lock,
-			       struct hrtimer_sleeper *timeout);
-
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1395,21 +1395,6 @@ rt_mutex_fastlock(struct rt_mutex *lock,
 }
 
 static inline int
-rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout,
-			enum rtmutex_chainwalk chwalk,
-			int (*slowfn)(struct rt_mutex *lock, int state,
-				      struct hrtimer_sleeper *timeout,
-				      enum rtmutex_chainwalk chwalk))
-{
-	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
-	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
-
-	return slowfn(lock, state, timeout, chwalk);
-}
-
-static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
@@ -1517,37 +1502,6 @@ int __sched __rt_mutex_futex_trylock(str
 }
 
 /**
- * rt_mutex_timed_lock - lock a rt_mutex interruptible
- *			the timeout structure is provided
- *			by the caller
- *
- * @lock:		the rt_mutex to be locked
- * @timeout:		timeout structure or NULL (no timeout)
- *
- * Returns:
- *  0		on success
- * -EINTR	when interrupted by a signal
- * -ETIMEDOUT	when the timeout expired
- */
-int
-rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
-{
-	int ret;
-
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       RT_MUTEX_MIN_CHAINWALK,
-				       rt_mutex_slowlock);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
-
-/**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
  * @lock:	the rt_mutex to be locked

