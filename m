Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052F03C7415
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhGMQRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhGMQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:35 -0400
Message-Id: <20210713160748.788002396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nPyjsP03rKZK9+dg2SJRkp1nkxzpwhdNMjS4ws3OJFE=;
        b=MaMEmCCBxyjQ6JYIcsanItXSXpHlnpDYnfx8ktm6ZZSOXDY8mtfdESLcsHv1IlCUhgzU2J
        hKJzFXYNPhYbF8O2cqkwMcwQ3UzPJVGOaslHh/0XNDv9EFY/lYyICICJrca4ro7nCzCyRZ
        kDiXqjXv9i/rcZjTsp4vrv1pLRtuAmBo22x6SKboQFfTcJw1xYIJZA4tiFs4cCfvrC5gd+
        n2Sgmh1s3Ph7G1AU4g7qRIVvoHj12KyFyzx7hCDT+NRSvzG2MEHjafCqLlREtd15S7uyZ3
        MNbW2MGgKhShJiOp+RClqfuI9GZ77FbdCf/pmHu7wVyBdw20T1mcjRBQYgKIZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nPyjsP03rKZK9+dg2SJRkp1nkxzpwhdNMjS4ws3OJFE=;
        b=0szMptFlqzTADNZYaO7Xqmp86frKRY9jxCqdGIrvxNpqxNpv7AWetT5HWR9zrzTKJ9SlxF
        i5ObKw9TNgmmPSBA==
Date:   Tue, 13 Jul 2021 17:11:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 29/50] locking/mutex: Consolidate core headers
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Having two header files which contain just the non-debug and debug variants
is mostly waste of disc space and has no real value. Stick the debug
variants into the common mutex.h file as counterpart to the stubs for the
non-debug case.

That allows to add helpers and defines to the common header for the
upcoming handling of mutexes and ww_mutexes on PREEMPT_RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/mutex-debug.c |  4 +---
 kernel/locking/mutex-debug.h | 29 -----------------------------
 kernel/locking/mutex.c       |  6 +-----
 kernel/locking/mutex.h       | 20 +++++++++++++++++---
 4 files changed, 19 insertions(+), 40 deletions(-)
 delete mode 100644 kernel/locking/mutex-debug.h
---
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index db9301591e3f..7ef5a36857e8 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -1,6 +1,4 @@
 /*
- * kernel/mutex-debug.c
- *
  * Debugging code for mutexes
  *
  * Started by Ingo Molnar:
@@ -22,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 
-#include "mutex-debug.h"
+#include "mutex.h"
 
 /*
  * Must be called with lock->wait_lock held.
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
deleted file mode 100644
index 53e631e1d76d..000000000000
--- a/kernel/locking/mutex-debug.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Mutexes: blocking mutual exclusion locks
- *
- * started by Ingo Molnar:
- *
- *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal declarations,
- * prototypes and inline functions, for the CONFIG_DEBUG_MUTEXES case.
- * More details are in kernel/mutex-debug.c.
- */
-
-/*
- * This must be called with lock->wait_lock held.
- */
-extern void debug_mutex_lock_common(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_wake_waiter(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
-extern void debug_mutex_add_waiter(struct mutex *lock,
-				   struct mutex_waiter *waiter,
-				   struct task_struct *task);
-extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-				struct task_struct *task);
-extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 013e1b08a1bf..68723b49c22e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,11 +30,7 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
-#ifdef CONFIG_DEBUG_MUTEXES
-# include "mutex-debug.h"
-#else
-# include "mutex.h"
-#endif
+#include "mutex.h"
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index f0c710b1d192..183965942cde 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -5,11 +5,24 @@
  * started by Ingo Molnar:
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
+#ifdef CONFIG_DEBUG_MUTEXES
+extern void debug_mutex_lock_common(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_wake_waiter(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
+extern void debug_mutex_add_waiter(struct mutex *lock,
+				   struct mutex_waiter *waiter,
+				   struct task_struct *task);
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+				      struct task_struct *task);
+extern void debug_mutex_unlock(struct mutex *lock);
+extern void debug_mutex_init(struct mutex *lock, const char *name,
+			     struct lock_class_key *key);
+#else /* CONFIG_DEBUG_MUTEXES */
+
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
@@ -21,3 +34,4 @@ static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
 }
+#endif /* !CONFIG_DEBUG_MUTEXES */

