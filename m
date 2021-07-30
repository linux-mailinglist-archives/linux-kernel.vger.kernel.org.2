Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD613DBA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhG3OXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhG3ORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:33 -0400
Message-ID: <20210730135206.416779376@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ieKOLCCK/+zLTg6rsSsHW+t+zU+iLrwqyd0gFaCNi6A=;
        b=3Z2E8hqfSYGQavp5sTZyak2WUgBtau85qA4+8NfDjdxT+on7NnIPd/uxZpvFrSEM/tOzLe
        nIBTUl49PYNpcdoNC5AEfNX6J7Vl+ygylv2XeNN88gG4Tpn675IjlCAy8BXfagPvQKle7s
        POjIGRIR9AUi81uWbOYcpqFXK/EeYrjkxq0mFtS8rRN3ZLZXkyxUgeKFNbyDcZjZe3Ovru
        eQsVhfS3p24GdBpJjglHKn6cqCIj3BvtttguhUSGdjz1LoAJkMqukt1H1hrEKCphcNm+yN
        Ouq72rkP3iJZC0PbAjK6mFSfDN3GJFDkd2vE8A6V3rZYtdA/L195zVfyZszXwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ieKOLCCK/+zLTg6rsSsHW+t+zU+iLrwqyd0gFaCNi6A=;
        b=kMGFrPiB6CeeN0NrErd7l/h59dCD+D4oWrfQVB20BQ2JsCGCG534xQaUUH58TvlRyPH2zX
        6HBbUDNdn2A1HCAw==
Date:   Fri, 30 Jul 2021 15:50:29 +0200
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
Subject: [patch 22/63] locking/spinlock: Split the lock types header
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 include/linux/rwlock_types.h       |    4 ++
 include/linux/spinlock.h           |    4 ++
 include/linux/spinlock_types.h     |   19 ----------
 include/linux/spinlock_types_raw.h |   65 +++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 18 deletions(-)
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
@@ -9,24 +9,7 @@
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
+#include <linux/spinlock_types_raw.h>
 
 #define SPINLOCK_MAGIC		0xdead4ead
 
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

