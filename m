Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D53ECB63
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhHOVdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhHOV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:58 -0400
Message-ID: <20210815211305.967526724@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgyAqMjf5gLWZL0B8o8dHe1HoG2aoWcH5WprrsQ+oUM=;
        b=WWiUy6iB6cFptn4kwXF4aqzQ5/eMS7z6t8um/aHYOPMOlHb3JQWueftgv0gAf7u6hV2GAd
        gR4uWt+o4WIs1CgwEu2Rgn3X35/M1OyPBlQDIXY63EdCGszFDFQjLvAFQqb7XD+AOIQYJm
        GqUf/Q0IKo7tJU6+1Wl2VBK4hRuVWbwSkA/KivsVawkE0+abIJzoUbBha3LWOtf95eVtds
        b289I6bSCqabvARM7C13jGp0lSw5bNEsozO0jBNuAS8REYZ462u6Whz5YNc1b/RwSsYKpb
        h8+tnxlQjJuKIXXNidsEjcZA+TzxUwgevD8iukyf2mg+pDRLWs2htMdDsYy4Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgyAqMjf5gLWZL0B8o8dHe1HoG2aoWcH5WprrsQ+oUM=;
        b=uiqDLcIyKbgg5ENT3/0VjgHe2B+TzHmWicblYJPCam/sIfR5KY2Q7OPBkZFoas0otENvfl
        X/PnhV3J3h1ycjBw==
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
Subject: [patch V5 71/72] locking/spinlock/rt: Prepare for RT local_lock
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:27 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the static and runtime initializer mechanics to support the RT variant
of local_lock, which requires the lock type in the lockdep map to be set
to LD_LOCK_PERCPU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/spinlock_rt.h        |   24 ++++++++++++++++--------
 include/linux/spinlock_types.h     |    6 ++++++
 include/linux/spinlock_types_raw.h |    8 ++++++++
 kernel/locking/spinlock_rt.c       |    7 +++++--
 4 files changed, 35 insertions(+), 10 deletions(-)

--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -8,20 +8,28 @@
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				struct lock_class_key *key);
+				struct lock_class_key *key, bool percpu);
 #else
 static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				       struct lock_class_key *key)
+				struct lock_class_key *key, bool percpu)
 {
 }
 #endif
 
-#define spin_lock_init(slock)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_base_init(&(slock)->lock);		\
-	__rt_spin_lock_init(slock, #slock, &__key);	\
+#define spin_lock_init(slock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+} while (0)
+
+#define local_spin_lock_init(slock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
 
 extern void rt_spin_lock(spinlock_t *lock);
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -60,6 +60,12 @@ typedef struct spinlock {
 		SPIN_DEP_MAP_INIT(name)				\
 	}
 
+#define __LOCAL_SPIN_LOCK_UNLOCKED(name)			\
+	{							\
+		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		LOCAL_SPIN_DEP_MAP_INIT(name)			\
+	}
+
 #define DEFINE_SPINLOCK(name)					\
 	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
 
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -37,9 +37,17 @@ typedef struct raw_spinlock {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 	}
+
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.lock_type = LD_LOCK_PERCPU,		\
+	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
 # define SPIN_DEP_MAP_INIT(lockname)
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -120,10 +120,13 @@ EXPORT_SYMBOL(rt_spin_trylock_bh);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-			 struct lock_class_key *key)
+			 struct lock_class_key *key, bool percpu)
 {
+	u8 type = percpu ? LD_LOCK_PERCPU : LD_LOCK_NORMAL;
+
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+	lockdep_init_map_type(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG,
+			      LD_WAIT_INV, type);
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 #endif

