Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDC3C740B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhGMQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:22 -0400
Message-Id: <20210713160747.809752662@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hMSFNx5ea+xhPh9GeDC2KixS3GC8A4R7NFMfDf4P38Q=;
        b=YpXCiOb1C/AccCyqXMTeHn38iWywfOKmvdUsouhMl/3392PituhYUO8JioD7mC1nbmI+S7
        kJukx0zwhAKKemE9Ndfw6cf4CYqMreppRbtVWyh0tRFmMV/KU+y7c0xeHFcMFhnuwxxgg9
        kbzACr5sJMJKWcNTE9Gw4RCBRkHyztYZfdQk4l6/LbrJ62jQnpOZDEwxoBpx+A28Z8mnQV
        se4r4OBDTaApXV47k6l3OBUOu49Uh9z8yXSKXx3TtFMVETC0sTHLNO5vIIGAfrDKcztwTP
        ENrH2aKFrM3DOQFm/UWGGeeIMLXQNWgnIP2w3zgAVlLX9NRXjccECm3PU0dT9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hMSFNx5ea+xhPh9GeDC2KixS3GC8A4R7NFMfDf4P38Q=;
        b=97NZ2hOMDfiPMJK3vb7WiQu2ESwKlmNte9osdOTuQRPwBHX9K5+jrYocrIQzbxjWCLv5B2
        QMG0RHzQBQKaQCCA==
Date:   Tue, 13 Jul 2021 17:11:13 +0200
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
Subject: [patch 19/50] locking/spinlock: Split the lock types header
References: <20210713151054.700719949@linutronix.de>
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
 include/linux/rwlock_types.h       |  4 ++-
 include/linux/spinlock.h           |  4 ++-
 include/linux/spinlock_types.h     | 19 +-----------
 include/linux/spinlock_types_raw.h | 65 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/spinlock_types_raw.h
---
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3bd03e18061c..0ad226b5d8fd 100644
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
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2cc..5803b56622a8 100644
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
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index b981caafe8bf..7c8107c280c0 100644
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
 
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
new file mode 100644
index 000000000000..1d4a180e983d
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

