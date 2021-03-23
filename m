Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1F346B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhCWVko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:40:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhCWVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:47 -0400
Message-Id: <20210323213707.896403641@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BXiqdw5YLaQCO/UW4q0lAu9lgCxE4LP127uJgyzyemg=;
        b=niX9uj2WLQ6lSQnIJT3LmUYjVi/ccXsDcPyJLZwXsh5jdGcuDEB8RAC6+ZB7JDGl6Z8qbw
        Qxk33+8TVCEL/IaV0IQHizT167SdHna6JmSta9hKrSorkVxPy1ouF8+BELb34Kv0PcO0xt
        zODNfg9aykhjAqS/hnfb9JHcOTHq+FndUOtY6HHU1vO0gd0z0ahKECI7ZM2rqdQAvEpr/r
        lI0/fpEhje4fUbpc+kNAU9M8cIsskC/LwV9+RWOagP2qybiIRKS5FJz4uAA8e/DAWR6Ucz
        0qPEMi1YHyOi5VKM5kcKV/Qien46xCHPHR5KsnFaKHtSwfCGi+EC/FIhRTKk6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BXiqdw5YLaQCO/UW4q0lAu9lgCxE4LP127uJgyzyemg=;
        b=liDZFhMcQX1+wy0LtQJOR5YgJJVeWuuXE3DraO4fR9bP2apsmWcJlUbqXQj+9LwsddFQTc
        of6NubZiE++7tPCA==
Date:   Tue, 23 Mar 2021 22:30:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 04/14] locking/rtmutex: Consolidate rt_mutex_init()
References: <20210323213019.217008708@linutronix.de>
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

