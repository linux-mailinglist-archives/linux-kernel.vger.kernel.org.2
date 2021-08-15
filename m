Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11D13ECB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhHOVb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhHOV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C51C06129D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:16 -0700 (PDT)
Message-ID: <20210815211303.371269088@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fJADVdH2q12brck4NzvtHNn6yyFVAP01XRTvQyvvUxU=;
        b=dEfz5oNjUKsCApHrhulHxK7j1voHHuZDdcNzBj4HEdmDjxvvKFO+FPW2W/D44z+MmwHro2
        n0F7J3DOt3PlwotMkGViRGnhhMHAXHXhAz5i8Qnez06tEj4adsZWSBV5Z4V5Dd5IAFG1UF
        Y+d+2INFHZccZvyTTgamhQv1K1lI/GajvYjY14+XeOKBgzEeat5XLu2H6mkWfi0tFesx+2
        40fN3EY0GGyPkI42qDeRwdeTVXEx7ObSgr/5vO54MqTLPgLbj/oRQPMJL6aJR7BaRgrxtb
        Z0xj6IG3uo898Xtb1855smLGZKni54sWqhthCPYP6Ef6Us8ctF2I/3LG8nV1Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fJADVdH2q12brck4NzvtHNn6yyFVAP01XRTvQyvvUxU=;
        b=LfVB6CPp/1naxqIZrCH755I5qrMcs9ubDkDRiLRXoOhryAUqFUFYu6lxymYawnOe7PIobc
        0/TL9xffmdxW/SCg==
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
Subject: [patch V5 25/72] locking/spinlock: Split the lock types header
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:14 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move raw_spinlock into its own file. Prepare for RT 'sleeping spinlocks' to
avoid header recursion as RT locks require rtmutex.h which in turn requires
the raw spinlock types.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Remove the duplicate defines
---
 include/linux/rwlock_types.h       |    4 ++
 include/linux/spinlock.h           |    4 ++
 include/linux/spinlock_types.h     |   59 ---------------------------------
 include/linux/spinlock_types_raw.h |   65 +++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/spinlock_types_raw.h
---
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -1,6 +1,10 @@
 #ifndef __LINUX_RWLOCK_TYPES_H
 #define __LINUX_RWLOCK_TYPES_H
 
+#if !defined(__LINUX_SPINLOCK_TYPES_H)
+# error "Do not include directly, include spinlock_types.h"
+#endif
+
 /*
  * include/linux/rwlock_types.h - generic rwlock type definitions
  *				  and initializers
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -12,6 +12,8 @@
  *  asm/spinlock_types.h: contains the arch_spinlock_t/arch_rwlock_t and the
  *                        initializers
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
@@ -31,6 +33,8 @@
  *                        contains the generic, simplified UP spinlock type.
  *                        (which is an empty structure on non-debug builds)
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw RT types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -9,64 +9,7 @@
  * Released under the General Public License (GPL).
  */
 
-#if defined(CONFIG_SMP)
-# include <asm/spinlock_types.h>
-#else
-# include <linux/spinlock_types_up.h>
-#endif
-
-#include <linux/lockdep_types.h>
-
-typedef struct raw_spinlock {
-	arch_spinlock_t raw_lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_cpu;
-	void *owner;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} raw_spinlock_t;
-
-#define SPINLOCK_MAGIC		0xdead4ead
-
-#define SPINLOCK_OWNER_INIT	((void *)-1L)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SPIN,	\
-	}
-# define SPIN_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-	}
-#else
-# define RAW_SPIN_DEP_MAP_INIT(lockname)
-# define SPIN_DEP_MAP_INIT(lockname)
-#endif
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-# define SPIN_DEBUG_INIT(lockname)		\
-	.magic = SPINLOCK_MAGIC,		\
-	.owner_cpu = -1,			\
-	.owner = SPINLOCK_OWNER_INIT,
-#else
-# define SPIN_DEBUG_INIT(lockname)
-#endif
-
-#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
-	{					\
-	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
-	SPIN_DEBUG_INIT(lockname)		\
-	RAW_SPIN_DEP_MAP_INIT(lockname) }
-
-#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
-
-#define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
+#include <linux/spinlock_types_raw.h>
 
 typedef struct spinlock {
 	union {
--- /dev/null
+++ b/include/linux/spinlock_types_raw.h
@@ -0,0 +1,65 @@
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
+#define __LINUX_SPINLOCK_TYPES_RAW_H
+
+#include <linux/types.h>
+
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
+#else
+# include <linux/spinlock_types_up.h>
+#endif
+
+#include <linux/lockdep_types.h>
+
+typedef struct raw_spinlock {
+	arch_spinlock_t raw_lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} raw_spinlock_t;
+
+#define SPINLOCK_MAGIC		0xdead4ead
+
+#define SPINLOCK_OWNER_INIT	((void *)-1L)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SPIN,	\
+	}
+# define SPIN_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+	}
+#else
+# define RAW_SPIN_DEP_MAP_INIT(lockname)
+# define SPIN_DEP_MAP_INIT(lockname)
+#endif
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define SPIN_DEBUG_INIT(lockname)		\
+	.magic = SPINLOCK_MAGIC,		\
+	.owner_cpu = -1,			\
+	.owner = SPINLOCK_OWNER_INIT,
+#else
+# define SPIN_DEBUG_INIT(lockname)
+#endif
+
+#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
+{						\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	RAW_SPIN_DEP_MAP_INIT(lockname) }
+
+#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
+
+#define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
+
+#endif

