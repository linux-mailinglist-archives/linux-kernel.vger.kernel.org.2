Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF334AC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCZQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:01:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCZQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:35 -0400
Message-Id: <20210326153943.437405350@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BXiqdw5YLaQCO/UW4q0lAu9lgCxE4LP127uJgyzyemg=;
        b=vmr7btZlR++lUsXKGnOz+lfQvK6CZDvX8sbJiRP3zTt0wZvgj0F4RUVbJMiuGNRQVf+I60
        WcSCbzTKhYjh+0rF0K3tGVZil1UIrHKOX4hKYSwnPzuiVUdgAz957pdVsQSJ1CP+RtZnOH
        Nm/OaSIKfVsWRbkqkGAKQmsawlMMV6Bx+KcU3BWG7XgZ3QAwmiqxRqrfkhIdz+ZJP1c/Uz
        5yNbdOFgKvegbc8slQvRyYo1ruo1w5O/ygsMLwWDyGMNKQZeczIJUy2t77Z6XmVSGZARX2
        BU43YM/bbFdrcwxZiAbnUUhFoloXgShLv/cWsWzT5fy1vTqP+DUEvJw1dF+w2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BXiqdw5YLaQCO/UW4q0lAu9lgCxE4LP127uJgyzyemg=;
        b=1kpoHrRVVJC6dcTpufS0UKF58dCOTylIf3SdUHYG7QtKYKpuA7ljdDVQX1xmD5XhpnU1+0
        3op3iJGsGd6pdFCA==
Date:   Fri, 26 Mar 2021 16:29:33 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 04/15] locking/rtmutex: Consolidate rt_mutex_init()
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rt_mutex_init() only initializes lockdep if CONFIG_DEBUG_RT_MUTEXES is
enabled which is fine because all lockdep variants select it, but there is
no reason to do so.

Move the function outside of the CONFIG_DEBUG_RT_MUTEXES block which
removes #ifdeffery.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -43,6 +43,7 @@ struct hrtimer_sleeper;
  extern int rt_mutex_debug_check_no_locks_freed(const void *from,
 						unsigned long len);
  extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
+ extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
  static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
 						       unsigned long len)
@@ -50,22 +51,15 @@ struct hrtimer_sleeper;
 	return 0;
  }
 # define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
+# define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-
-# define rt_mutex_init(mutex) \
+#define rt_mutex_init(mutex) \
 do { \
 	static struct lock_class_key __key; \
 	__rt_mutex_init(mutex, __func__, &__key); \
 } while (0)
 
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
-#else
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
-#endif
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
 	, .dep_map = { .name = #mutexname }

