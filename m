Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA613876E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbhERKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348670AbhERKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:50:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00980C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pc6aeEz+2C/Rp/H+ye4CWak1I9YdRBXisaUiFaldE5A=; b=HNWHGjachMoi1ci9rfZVThXhnj
        ABP2iVCfCDJncmflIafYUFk5XZyglw8jN3z9H5capIIhqelGc+0ztXBghZDT0nYt09Z6hqmqmC64x
        x5XK8Xmw8c2NkCTdP2PhIejXcPVXEOeZNjS0/4wrGfEKyFnF1FJlWb8DLs4bEtj5sLzebv0I5Ffkg
        ki/3AFhzSdvbhCNMVOrs0VZmM0ImZj6un/rBWelI38wQDWRhgOOqVtxSJM9NYTrDWbuj2gCqpjw9m
        EyHkNgsYVmPUUjl7Ztzs8e0QmPRs82jCXbhq+NaIOxqGyrl9uylIBXqIgSFhdxgLCldEttzJ15R4W
        Ohsk4MuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lixHp-000Rd9-6F; Tue, 18 May 2021 10:49:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC8DE300233;
        Tue, 18 May 2021 12:49:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2C9629CB9DB5; Tue, 18 May 2021 12:49:15 +0200 (CEST)
Date:   Tue, 18 May 2021 12:49:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@canonical.com
Subject: Re: [PATCH v3] locking/mutex: clear MUTEX_FLAGS if wait_list is
 empty due to signal
Message-ID: <YKObq4li1qwyEyDa@hirez.programming.kicks-ass.net>
References: <20210517034005.30828-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517034005.30828-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:40:05AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> When a interruptible mutex locker is interrupted by a signal
> without acquiring this lock and removed from the wait queue.
> if the mutex isn't contended enough to have a waiter
> put into the wait queue again, the setting of the WAITER
> bit will force mutex locker to go into the slowpath to
> acquire the lock every time, so if the wait queue is empty,
> the WAITER bit need to be clear.

I'm still interestd in knowing how you found this. Did you have an
actual problem, or were you just reading the code?

AFAICT, this needs:

Fixes: 040a0a371005 ("mutex: Add support for wound/wait style locks")

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Thanks!

Updated patch below.

---
Subject: locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
From: Zqiang <qiang.zhang@windriver.com>
Date: Mon, 17 May 2021 11:40:05 +0800

From: Zqiang <qiang.zhang@windriver.com>

When a interruptible mutex locker is interrupted by a signal
without acquiring this lock and removed from the wait queue.
if the mutex isn't contended enough to have a waiter
put into the wait queue again, the setting of the WAITER
bit will force mutex locker to go into the slowpath to
acquire the lock every time, so if the wait queue is empty,
the WAITER bit need to be clear.

Fixes: 040a0a371005 ("mutex: Add support for wound/wait style locks")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210517034005.30828-1-qiang.zhang@windriver.com
---
 kernel/locking/mutex-debug.c |    4 ++--
 kernel/locking/mutex-debug.h |    2 +-
 kernel/locking/mutex.c       |   18 +++++++++++++-----
 kernel/locking/mutex.h       |    4 +---
 4 files changed, 17 insertions(+), 11 deletions(-)

--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex
 	task->blocked_on = waiter;
 }
 
-void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *l
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
 	task->blocked_on = NULL;
 
-	list_del_init(&waiter->list);
+	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
 }
 
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(stru
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -194,7 +194,7 @@ static inline bool __mutex_waiter_is_fir
  * Add @waiter to a given location in the lock wait_list and set the
  * FLAG_WAITERS flag if it's the first waiter.
  */
-static void __sched
+static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
@@ -205,6 +205,16 @@ __mutex_add_waiter(struct mutex *lock, s
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
@@ -1061,9 +1071,7 @@ __mutex_lock_common(struct mutex *lock,
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
+	__mutex_remove_waiter(lock, &waiter);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -1080,7 +1088,7 @@ __mutex_lock_common(struct mutex *lock,
 
 err:
 	__set_current_state(TASK_RUNNING);
-	mutex_remove_waiter(lock, &waiter, current);
+	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
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
 
