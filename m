Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4293E186F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbhHEPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbhHEPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:10 -0400
Message-ID: <20210805153954.736278485@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=reRzed86Pe+3Vy1p3TGh3C7MLppPCF3yiEkMuDYTBRU=;
        b=hrIQkB2jb2poy33viAaF+T9jVBrJJvKyiGOtoJF76lN1E4sI3QKYuXpHFpQGl9ZdYMteCb
        GyGrcKYDw6Jsel0fZE73aUfsmE/gbwVS+fMdWCQ+7S4FsAcGZI0pJxCktluT2aVIF2uoP5
        quQGlcJzn0IaDO7jdng/T6DAu6KrjJfyyCaUpFdmFDzd9WKuKWJXejqsMt7O9663hZPpLi
        8UkCOxls0YOZBL3T+OUAOf8jBd0cSGVw/7QOetcf6Iw8styKL2Zn8+dxzUGA7czp+PKgns
        y9xod4Cmo5Bd67jMlwIOW8n7Wqyjd26HbZTDw/h4DdhmkH9sTtD49Na2MK3pOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=reRzed86Pe+3Vy1p3TGh3C7MLppPCF3yiEkMuDYTBRU=;
        b=L2bRAS1jbPCniL5K06WFYQJmcDjuei93K701HowasbVJienMJihgIVSM/N56PZrD78qUJN
        p6OviJr563QnfECA==
Date:   Thu, 05 Aug 2021 17:13:33 +0200
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
Subject: [patch V3 33/64] locking/mutex: Consolidate core headers
References: <20210805151300.330412127@linutronix.de>
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
 kernel/locking/mutex-debug.c |    4 +---
 kernel/locking/mutex-debug.h |   29 -----------------------------
 kernel/locking/mutex.c       |    6 +-----
 kernel/locking/mutex.h       |   20 +++++++++++++++++---
 4 files changed, 19 insertions(+), 40 deletions(-)
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

