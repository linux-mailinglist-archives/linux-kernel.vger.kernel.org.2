Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8133ECB3D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhHOVbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhHOV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A324EC0612A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:25 -0700 (PDT)
Message-ID: <20210815211303.712897671@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cfurVzYm4Qgk1p5Cqv8iXL5gXcKPyGKyHAXc/uF2Y5k=;
        b=iY07rWuKDTTsFArucqRSfUfFOC+1KqgFx7d0GI8ClL36fmICoC2vDrHB+OFX64LBCdr3/c
        WvazNjAbB2dIyuKsK10RfO24mpjSrICVlmK5kcLCnaJInaMQP3RTD0yA7Ad5z96VpSK3lN
        DqdilEVEjThNIIT5a8AA99IDIWHLQXRaSHouc+sWdNhy4Rr8vCDXFtR1I2J6vcNN+krG2g
        A113vAW36SXHvSL+HqHxdS0MP9aUqWp3XP71incHIANcmWp16hwE3kyaDCEfO/UBTWxrGr
        mZXfd+mkX1NXDaEbRdYcxHt99HGvB4F3eB27/kSpPsqZqvxveR+Y0ZuexUdLVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cfurVzYm4Qgk1p5Cqv8iXL5gXcKPyGKyHAXc/uF2Y5k=;
        b=VQlkn40IrI2FeUhOA0SO8TPxh9npB8rx9AlSBRC0HXGsSoO5Hv36ngTgv9qYJ/aKj9e+7R
        uBGd8F/WcGRqCdCw==
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
Subject: [patch V5 31/72] locking/spinlock: Provide RT variant header
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:23 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide the necessary wrappers around the actual rtmutex based spinlock
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: spin_unlock() -> rt_spin_unlock() (Peter)
---
 include/linux/spinlock.h         |   11 ++
 include/linux/spinlock_api_smp.h |    3 
 include/linux/spinlock_rt.h      |  149 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/spinlock_rt.h
---
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -312,8 +312,10 @@ static inline void do_raw_spin_unlock(ra
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
-/* Include rwlock functions */
+#ifndef CONFIG_PREEMPT_RT
+/* Include rwlock functions for !RT */
 #include <linux/rwlock.h>
+#endif
 
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
@@ -324,6 +326,9 @@ static inline void do_raw_spin_unlock(ra
 # include <linux/spinlock_api_up.h>
 #endif
 
+/* Non PREEMPT_RT kernel map to raw spinlocks */
+#ifndef CONFIG_PREEMPT_RT
+
 /*
  * Map the spin_lock functions to the raw variants for PREEMPT_RT=n
  */
@@ -458,6 +463,10 @@ static __always_inline int spin_is_conte
 
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
 
+#else  /* !CONFIG_PREEMPT_RT */
+# include <linux/spinlock_rt.h>
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Pull the atomic_t declaration:
  * (asm-mips/atomic.h needs above definitions)
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -187,6 +187,9 @@ static inline int __raw_spin_trylock_bh(
 	return 0;
 }
 
+/* PREEMPT_RT has it's own rwlock implementation */
+#ifndef CONFIG_PREEMPT_RT
 #include <linux/rwlock_api_smp.h>
+#endif
 
 #endif /* __LINUX_SPINLOCK_API_SMP_H */
--- /dev/null
+++ b/include/linux/spinlock_rt.h
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_SPINLOCK_RT_H
+#define __LINUX_SPINLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_H
+#error Do not include directly. Use spinlock.h
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				struct lock_class_key *key);
+#else
+static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				       struct lock_class_key *key)
+{
+}
+#endif
+
+#define spin_lock_init(slock)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	rt_mutex_base_init(&(slock)->lock);		\
+	__rt_spin_lock_init(slock, #slock, &__key);	\
+} while (0)
+
+extern void rt_spin_lock(spinlock_t *lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock);
+extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock_unlock(spinlock_t *lock);
+extern int rt_spin_trylock_bh(spinlock_t *lock);
+extern int rt_spin_trylock(spinlock_t *lock);
+
+static __always_inline void spin_lock(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#ifdef CONFIG_LOCKDEP
+# define __spin_lock_nested(lock, subclass)				\
+	rt_spin_lock_nested(lock, subclass)
+
+# define __spin_lock_nest_lock(lock, nest_lock)				\
+	do {								\
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		rt_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__spin_lock_nested(lock, subclass);		\
+	} while (0)
+
+#else
+ /*
+  * Always evaluate the 'subclass' argument to avoid that the compiler
+  * warns about set-but-not-used variables when building with
+  * CONFIG_DEBUG_LOCK_ALLOC=n and with W=1.
+  */
+# define __spin_lock_nested(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define __spin_lock_nest_lock(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	spin_lock_irqsave(((void)(subclass), (lock)), flags)
+#endif
+
+#define spin_lock_nested(lock, subclass)		\
+	__spin_lock_nested(lock, subclass)
+
+#define spin_lock_nest_lock(lock, nest_lock)		\
+	__spin_lock_nest_lock(lock, nest_lock)
+
+#define spin_lock_irqsave_nested(lock, flags, subclass)	\
+	__spin_lock_irqsave_nested(lock, flags, subclass)
+
+static __always_inline void spin_lock_bh(spinlock_t *lock)
+{
+	/* Investigate: Drop bh when blocking ? */
+	local_bh_disable();
+	rt_spin_lock(lock);
+}
+
+static __always_inline void spin_lock_irq(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#define spin_lock_irqsave(lock, flags)			 \
+	do {						 \
+		typecheck(unsigned long, flags);	 \
+		flags = 0;				 \
+		spin_lock(lock);			 \
+	} while (0)
+
+static __always_inline void spin_unlock(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_bh(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+	local_bh_enable();
+}
+
+static __always_inline void spin_unlock_irq(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
+						   unsigned long flags)
+{
+	rt_spin_unlock(lock);
+}
+
+#define spin_trylock(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define spin_trylock_bh(lock)				\
+	__cond_lock(lock, rt_spin_trylock_bh(lock))
+
+#define spin_trylock_irq(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define __spin_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags = 0;					\
+	__locked = spin_trylock(lock);			\
+	__locked;					\
+})
+
+#define spin_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
+
+#define spin_is_contended(lock)		(((void)(lock), 0))
+
+static inline int spin_is_locked(spinlock_t *lock)
+{
+	return rt_mutex_base_is_locked(&lock->lock);
+}
+
+#define assert_spin_locked(lock) BUG_ON(!spin_is_locked(lock))
+
+#endif

