Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCF34AC29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCZQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhCZQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7ECC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:01:33 -0700 (PDT)
Message-Id: <20210326153943.195064296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Yo+AwdHmiilTULO6uV2YUGCHlgzu/1kUJvKTyHSNTGY=;
        b=MZRov+ZEpjp7sEKg4fHXzDqmDH/p+3skiPItb9w4nE2DLV3DmGqTnzlS0t2HxWLQi5q6cb
        3XplNiV0z6+1bPqeHnMKwjP+bcXWGAoEU8MUtmADGj71Uxe3jNolgMj95WasRWx4lDVMPM
        jzBYgwSoPvJRKfdgoeB5kY1r7NJI7vcg8dxkHNCpU+Ral+4zemGrRPFvfz+yuLJDLLfrAq
        icIFnkcAquecuAwdNpfyPX9g/vQwt6WRYh+HgkLQ2EoE78eRY8+I4O6GYRvKypNnL+kS95
        3yGkneH268aWOZqd52zN80vn0bV5LPvhaCbIFOr6fd0e1RoKycNvAJaI73K02Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Yo+AwdHmiilTULO6uV2YUGCHlgzu/1kUJvKTyHSNTGY=;
        b=KAnRoa6kNSVx9fsNGcmxsKSv11Uhe+FbWwXceJq0UcJA7Pv7dp9BmVQVxRC8e5eLLHnPvL
        1fCp5JJKNQWFSuAg==
Date:   Fri, 26 Mar 2021 16:29:31 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 02/15] locking/rtmutex: Remove rtmutex deadlock tester leftovers
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The following debug members of struct rtmutex are unused:

 - save_state: No users

 - file,line: Printed if ::name is NULL. This is only used for non-futex
   	      locks so ::name is never NULL

 - magic:     Assigned to NULL by rt_mutex_destroy(), no further usage

Remove them along with unused inlines and macros leftovers related to
the long gone deadlock tester.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h         |    7 ++-----
 kernel/locking/rtmutex-debug.c  |    7 +------
 kernel/locking/rtmutex-debug.h  |    2 --
 kernel/locking/rtmutex.c        |    3 ---
 kernel/locking/rtmutex.h        |    2 --
 kernel/locking/rtmutex_common.h |    1 -
 6 files changed, 3 insertions(+), 19 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -32,10 +32,7 @@ struct rt_mutex {
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	int			save_state;
-	const char		*name, *file;
-	int			line;
-	void			*magic;
+	const char		*name;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -60,7 +57,7 @@ struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	, .name = #mutexname, .file = __FILE__, .line = __LINE__
+	, .name = #mutexname
 
 # define rt_mutex_init(mutex) \
 do { \
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -42,12 +42,7 @@ static void printk_task(struct task_stru
 
 static void printk_lock(struct rt_mutex *lock, int print_owner)
 {
-	if (lock->name)
-		printk(" [%p] {%s}\n",
-			lock, lock->name);
-	else
-		printk(" [%p] {%s:%d}\n",
-			lock, lock->file, lock->line);
+	printk(" [%p] {%s}\n", lock, lock->name);
 
 	if (print_owner && rt_mutex_owner(lock)) {
 		printk(".. ->owner: %p\n", lock->owner);
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -22,8 +22,6 @@ extern void debug_rt_mutex_deadlock(enum
 				    struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
 extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
-# define debug_rt_mutex_reset_waiter(w)			\
-	do { (w)->deadlock_lock = NULL; } while (0)
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
 						  enum rtmutex_chainwalk walk)
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1594,9 +1594,6 @@ void __sched rt_mutex_futex_unlock(struc
 void rt_mutex_destroy(struct rt_mutex *lock)
 {
 	WARN_ON(rt_mutex_is_locked(lock));
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	lock->magic = NULL;
-#endif
 }
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -11,7 +11,6 @@
  * Non-debug version.
  */
 
-#define rt_mutex_deadlock_check(l)			(0)
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
 #define debug_rt_mutex_lock(l)				do { } while (0)
@@ -21,7 +20,6 @@
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-#define debug_rt_mutex_reset_waiter(w)			do { } while (0)
 
 static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
 {
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -30,7 +30,6 @@ struct rt_mutex_waiter {
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	unsigned long		ip;
 	struct pid		*deadlock_task_pid;
 	struct rt_mutex		*deadlock_lock;
 #endif

