Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E138DB42
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhEWNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhEWNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:36:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA2C06138A
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 06:34:37 -0700 (PDT)
Date:   Sun, 23 May 2021 13:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621776874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tEPc64+Dc6IZrpVtAzOzj+VXMu6ftIUj+NRUDDGMKJ8=;
        b=Hbmo0Dq1A2Vr1EA1jDO4HJzVm0g7e9ZQY3lzR7K2lEoGTZUZgI0IyiwPb/8AwuILFYt2pd
        iSkt1wUcz46kCX6dazELjLH2DcSjrA6EQkNgXKIE8JKNvoikzWIgfthAIJQ7hYKMiumwQw
        lUB592QalmFIAe41s92+/HqzRGvp5HuyqODDWXRf/a9rdKoqgBWFZp8GrGcksDh9vNc2vs
        PfkofyfE6R4gzxh6pLoAfuwQsFfkv3Ou2sw1Sn3ym+h2ibPhw+xK0GrQurRvqC1UZglf0z
        tLFQfrcvxurIyJLCpd3JuA9OFTt5rxGlqlGJQq7iDds7N2X0y5tGYMJRtU1JMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621776874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tEPc64+Dc6IZrpVtAzOzj+VXMu6ftIUj+NRUDDGMKJ8=;
        b=VLB6aA2IZzmbWrZpWSa6orIVbZIDPl6PLk/LUuTOWnnGx6Z1wo/kzxcAatjrXRrkvxqRc6
        0MjcWhi5HZHNseBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.13-rc3
References: <162177682324.10917.7221704858691713254.tglx@nanos>
Message-ID: <162177682445.10917.1808156686282700079.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-23

up to:  3a010c493271: locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal


Two locking fixes:

 - Invoke the lockdep tracepoints in the correct place so the ordering
   is correct again.

 - Don't leave the mutex WAITER bit stale when the last waiter is dropping
   out early due to a signal as that forces all subsequent lock operations
   needlessly into the slowpath until it's cleaned up again.


Thanks,

	tglx

------------------>
Leo Yan (1):
      locking/lockdep: Correct calling tracepoints

Zqiang (1):
      locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal


 kernel/locking/lockdep.c     |  4 ++--
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex-debug.h |  2 +-
 kernel/locking/mutex.c       | 18 +++++++++++++-----
 kernel/locking/mutex.h       |  4 +---
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736aa03b2..7641bd407239 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5736,7 +5736,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_acquired(lock, ip);
+	trace_lock_contended(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
@@ -5754,7 +5754,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_contended(lock, ip);
+	trace_lock_acquired(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a7276aaf2abc..db9301591e3f 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	task->blocked_on = waiter;
 }
 
-void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
 	task->blocked_on = NULL;
 
-	list_del_init(&waiter->list);
+	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
 }
 
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f45a4ec..53e631e1d76d 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112ce155..013e1b08a1bf 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -194,7 +194,7 @@ static inline bool __mutex_waiter_is_first(struct mutex *lock, struct mutex_wait
  * Add @waiter to a given location in the lock wait_list and set the
  * FLAG_WAITERS flag if it's the first waiter.
  */
-static void __sched
+static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
@@ -205,6 +205,16 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 }
 
+static void
+__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	list_del(&waiter->list);
+	if (likely(list_empty(&lock->wait_list)))
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
+
+	debug_mutex_remove_waiter(lock, waiter, current);
+}
+
 /*
  * Give up ownership to a specific task, when @task = NULL, this is equivalent
  * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
@@ -1061,9 +1071,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
+	__mutex_remove_waiter(lock, &waiter);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -1080,7 +1088,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 err:
 	__set_current_state(TASK_RUNNING);
-	mutex_remove_waiter(lock, &waiter, current);
+	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d3fa71..f0c710b1d192 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -10,12 +10,10 @@
  * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define mutex_remove_waiter(lock, waiter, task) \
-		__list_del((waiter)->list.prev, (waiter)->list.next)
-
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 

