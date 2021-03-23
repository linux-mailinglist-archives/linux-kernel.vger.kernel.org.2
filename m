Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0205D346B39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhCWVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCWVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7FEC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:42 -0700 (PDT)
Message-Id: <20210323213707.465154098@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ERv4b/SO2o1L4SIyMqm0aGcbAhBK3azDtTSXDmAG/uY=;
        b=GmIrKw6zgDLn+HzWD0HZFkZE8yVasS2NLop7HUKnwBFP2jp84vLXQcvshg71Erod0jmXM9
        PWZM1OKdn4Y05HFWsu/d4l40vyxr74el70WZwkID56IiACDSKRnEF24Jq3pMxEPDHp3kCW
        vUUEVsV8+HeV+e1iBd1AN+vsx+bnCXKQw1/QrOgCf3eSYKUnPXxVP55eGYY74ezn5D4FAR
        URuMVcUPcS6JQx90kyHXGkLVkBPyup7p7U5AKtys2sRK6SCRlSdDG5zn43cfK+SFtdPiOU
        IbvcxoaDfVkM6jGvS/q86bHwNzwgx5cHeCGA4uoZQTiwXhoRnET++0PqviPpxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ERv4b/SO2o1L4SIyMqm0aGcbAhBK3azDtTSXDmAG/uY=;
        b=A02eaKrm0Xcgc9myeEPvjljZRQDgE4ynedfWsxBytuGdRhfyXvHR2e1KuBPEoTb1VMB1oY
        2ye/qilzxT4599Bg==
Date:   Tue, 23 Mar 2021 22:30:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 01/14] locking/rtmutex: Remove rt_mutex_timed_lock()
References: <20210323213019.217008708@linutronix.de>
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

