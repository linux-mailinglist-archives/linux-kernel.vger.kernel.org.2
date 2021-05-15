Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8038177E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhEOKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhEOKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2417C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPPa3e2vwrecZzMeY7Go3HEpgtyMNIZBsXe34ZLKSH0=; b=oj2SGYjcWFH8vFvCG7OmXpIJGq
        Nb9ELaqofRFamJBWYqc4aRx14MvQNELTmOEHVmnS3WMxPQmOik9NWnzmBR2ZwRlgFGSOfudSYRTzC
        TuVXAfv5PW72/Liay/2zr0AqMVV2ZyjeuxB6DNRMg7ZruF1/ZWWJs6fKXceja7Pg5ajSL+bun5Eq3
        45dZjcUUa3+iDu11XBQHHfpQ1/n3KzJSp/Wgyl3CF+JBo5IS/7R2pGJR8jZxn63ZlvmVm0u/nSYE6
        z7M3iwO9yJDEWuil1aaz88fUL4xmPGQ6Iriuxkw7qUiDAHAdeHL0xjc/AlAOHzV4gI3A1woZtVXcg
        8q+7si7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhrGV-00B8sz-4e; Sat, 15 May 2021 10:11:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DBAE986476; Sat, 15 May 2021 12:11:22 +0200 (CEST)
Date:   Sat, 15 May 2021 12:11:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex: clear MUTEX_FLAGS if wait_list is empty
 due to signal
Message-ID: <20210515101122.GB21560@worktop.programming.kicks-ass.net>
References: <20210515023010.102985-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515023010.102985-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 10:30:10AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Clear MUTEX_FLAGS when call mutex_lock_interruptible()
> interrupted by a signal and the lock->wait_list is empty.

That's what the patches does; and I can read the C code perfectly fine,
thank you. What the C code doesn't tell me is why, nor how you came to
write this patch, was there an actual problem that is solved? Were you
bored and just reading the code?

That is, your Changelog tells me absolutely nothing.

> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/locking/mutex.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index cb6b112ce155..4ac354ca092b 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -1081,6 +1081,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>  err:
>  	__set_current_state(TASK_RUNNING);
>  	mutex_remove_waiter(lock, &waiter, current);
> +	if (likely(list_empty(&lock->wait_list)))
> +		__mutex_clear_flag(lock, MUTEX_FLAGS);

Would not the nicer patch be something like this?

---
 kernel/locking/mutex-debug.c |  6 +++---
 kernel/locking/mutex-debug.h |  4 ++--
 kernel/locking/mutex.c       | 17 ++++++++++++-----
 kernel/locking/mutex.h       |  4 +---
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a7276aaf2abc..447013815200 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -57,15 +57,15 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	task->blocked_on = waiter;
 }
 
-void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-			 struct task_struct *task)
+void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+			       struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
 	task->blocked_on = NULL;
 
-	list_del_init(&waiter->list);
+	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
 }
 
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f45a4ec..e50afe4cc871 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -22,8 +22,8 @@ extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-				struct task_struct *task);
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+				      struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
 			     struct lock_class_key *key);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112ce155..5598920b49b0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -205,6 +205,16 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 }
 
+static void
+__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	__list_del(waiter->list.prev, waiter->list.next);
+	debug_mutex_remove_waiter(lock, &waiter, current);
+	if (likely(list_empty(&lock->wait_list)))
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
+
+}
+
 /*
  * Give up ownership to a specific task, when @task = NULL, this is equivalent
  * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
@@ -1061,10 +1071,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
-
+	__mutex_remove_waiter(lock, &waiter);
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
@@ -1080,7 +1087,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 err:
 	__set_current_state(TASK_RUNNING);
-	mutex_remove_waiter(lock, &waiter, current);
+	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d3fa71..1d4ddb415c22 100644
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
+#define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
