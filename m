Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07265346B47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCWVlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhCWVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:53 -0400
Message-Id: <20210323213708.503445251@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LUAqshVxSYW5QfCTrVTJwzZZ1jvU6362nJtvwcdZi1o=;
        b=cJAigTMQKp95TvuXYZSYP6ZtjGz4FwQdQak1Bl/rKlS2XIpuCStZE1VrotqEvvbGiXaJs/
        Q0WCldTy+ZUwaxzyYunORRDUUz9FttVLa1fr2yjZ3BCmeol31VBA7TctEcctpX2nbU0lR3
        hMyEkPnDClj1FH9CU8PTxKVTRT21cYNmHhqdLTb9SZLiwXRVnNPzNxI6YmLACTN6vMJJjp
        jfMRj513c0mM4JGqMQ7pIxWJ/NZ6Z1dXa36f7ZZZOBeUk8X/CIBQGHTYKCxTh3FpMaFT55
        TsI4YG17zELo8iQ44gKQr2VoMlNvpaWqx7j6fcEjmo+JkRLM4KZM942G6/Fffg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LUAqshVxSYW5QfCTrVTJwzZZ1jvU6362nJtvwcdZi1o=;
        b=lrY2U7rp2l5d+73YGzMFhUMxLC7qluPoXkQysEePN9PkEC0PvKB88SueCo4KRimPG33Dga
        Yi5NNe4EK6c1XYAQ==
Date:   Tue, 23 Mar 2021 22:30:29 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 10/14] locking/rtmutex: Move debug functions as inlines into
 common header
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no value in having two header files providing just empty stubs and
a C file which implements trivial debug functions which can just be inlined.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/Makefile         |    2 -
 kernel/locking/rtmutex-debug.c  |   65 ----------------------------------------
 kernel/locking/rtmutex-debug.h  |   26 ----------------
 kernel/locking/rtmutex.h        |   24 --------------
 kernel/locking/rtmutex_common.h |   30 +++++++++++++++---
 5 files changed, 25 insertions(+), 122 deletions(-)

--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -12,7 +12,6 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_mutex-debug.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_rtmutex-debug.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
@@ -26,7 +25,6 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
-obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
--- a/kernel/locking/rtmutex-debug.c
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This code is based on the rt.c implementation in the preempt-rt tree.
- * Portions of said code are
- *
- *  Copyright (C) 2004  LynuxWorks, Inc., Igor Manyilov, Bill Huey
- *  Copyright (C) 2006  Esben Nielsen
- *  Copyright (C) 2006  Kihon Technologies Inc.,
- *			Steven Rostedt <rostedt@goodmis.org>
- *
- * See rt.c in preempt-rt for proper credits and further information
- */
-#include <linux/sched.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/debug.h>
-#include <linux/delay.h>
-#include <linux/export.h>
-#include <linux/spinlock.h>
-#include <linux/kallsyms.h>
-#include <linux/syscalls.h>
-#include <linux/interrupt.h>
-#include <linux/rbtree.h>
-#include <linux/fs.h>
-#include <linux/debug_locks.h>
-
-#include "rtmutex_common.h"
-
-void debug_rt_mutex_unlock(struct rt_mutex *lock)
-{
-	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
-}
-
-void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
-{
-	DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
-}
-
-void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
-{
-	memset(waiter, 0x11, sizeof(*waiter));
-}
-
-void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
-{
-	memset(waiter, 0x22, sizeof(*waiter));
-}
-
-void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key)
-{
-	/*
-	 * Make sure we are not reinitializing a held lock:
-	 */
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_init_map(&lock->dep_map, name, key, 0);
-#endif
-}
--- a/kernel/locking/rtmutex-debug.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This file contains macros used solely by rtmutex.c. Debug version.
- */
-
-extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
-extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
-extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void debug_rt_mutex_lock(struct rt_mutex *lock);
-extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
-				      struct task_struct *powner);
-extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-
-static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
-						  enum rtmutex_chainwalk walk)
-{
-	return (waiter != NULL);
-}
--- a/kernel/locking/rtmutex.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * RT-Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This file contains macros used solely by rtmutex.c.
- * Non-debug version.
- */
-
-#define debug_rt_mutex_init_waiter(w)			do { } while (0)
-#define debug_rt_mutex_free_waiter(w)			do { } while (0)
-#define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
-#define debug_rt_mutex_unlock(l)			do { } while (0)
-#define debug_rt_mutex_init(m, n, k)			do { } while (0)
-
-static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
-						  enum rtmutex_chainwalk walk)
-{
-	return walk == RT_MUTEX_FULL_CHAINWALK;
-}
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -13,6 +13,7 @@
 #ifndef __KERNEL_RTMUTEX_COMMON_H
 #define __KERNEL_RTMUTEX_COMMON_H
 
+#include <linux/debug_locks.h>
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
@@ -124,10 +125,29 @@ extern bool __rt_mutex_futex_unlock(stru
 
 extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-# include "rtmutex-debug.h"
-#else
-# include "rtmutex.h"
-#endif
+/* Debug functions */
+static inline void debug_rt_mutex_unlock(struct rt_mutex *lock)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
+}
+
+static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
+}
+
+static inline void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		memset(waiter, 0x11, sizeof(*waiter));
+}
+
+static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+		memset(waiter, 0x22, sizeof(*waiter));
+}
 
 #endif

