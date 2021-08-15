Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883623ECB3B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhHOVbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhHOV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEBC0612A9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:33 -0700 (PDT)
Message-ID: <20210815211303.995350521@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=H1uaomP1PqNWSFpqhK4EkbKQuTn0Qlj2gIDP/e+KYHY=;
        b=WlgLByKlKLyoXGyZsOXm15/dVLXTYVi/Qargtetl4u+JP4hJSTZiZHcC8Bil6NCbUyxBSv
        1ArULVzNB7ZWAolol8tWgSQL96rTfT6XIX1IjmjiY3i02mDCWtqgw3ZZLzXpv5sPHeoYv2
        IlexKXXjDmZU1GLF0CZzId5NmWoc3/p2aLDOQLVdCfy/W2hi5hp2hElFtccFUffsI2czYY
        7tfE6bB0U6zab4aeSO2WfA3xrHGoZ+cwKoAIxH0kp5J4FtkuJA+Iu5VNykJCG343diUNq8
        yk+9oCbftODTRAbmJgbjJS5HFGH2MTb936zPBE/NqyCteR6/8gN7QRlKnMCztA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=H1uaomP1PqNWSFpqhK4EkbKQuTn0Qlj2gIDP/e+KYHY=;
        b=oOpKntv4kevcLECir6RGgiPbrUz16wWVpetasgZfRD+U2kEYM4X3nJmZy+vuxCMRE6i5MT
        tS6sEDwvqfvRs0AQ==
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 36/72] locking/mutex: Consolidate core headers
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:31 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Having two header files which contain just the non-debug and debug variants
is mostly waste of disc space and has no real value. Stick the debug
variants into the common mutex.h file as counterpart to the stubs for the
non-debug case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/mutex-debug.c |    4 +---
 kernel/locking/mutex-debug.h |   29 -----------------------------
 kernel/locking/mutex.c       |    6 +-----
 kernel/locking/mutex.h       |   37 +++++++++++++++++++++++--------------
 4 files changed, 25 insertions(+), 51 deletions(-)
 delete mode 100644 kernel/locking/mutex-debug.h
---
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
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -5,19 +5,28 @@
  * started by Ingo Molnar:
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
-#define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
-#define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name, key)		do { } while (0)
-
-static inline void
-debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
-{
-}
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
+# define debug_mutex_lock_common(lock, waiter)		do { } while (0)
+# define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+# define debug_mutex_free_waiter(waiter)		do { } while (0)
+# define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_unlock(lock)			do { } while (0)
+# define debug_mutex_init(lock, name, key)		do { } while (0)
+#endif /* !CONFIG_DEBUG_MUTEXES */

