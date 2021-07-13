Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6E3C73FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGMQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhGMQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:12 -0400
Message-Id: <20210713160747.007091053@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wwr9p65KrIBqhTuLW+nKLDCjJCbfB++v+eHJkbm6SuI=;
        b=U2lVEfdqF5IF4w9HcHiqUQvg8+A6z5H7QMoPNG0MZyavNWredWB5r8MoU9qlAyWASd2ZQ5
        GBAaOA9lJ0FSLRROzyKFg67ckulZJG1+i3nuaet4V+H2y7YuWRe6ZCvKJ0+UDiFbJy8of4
        lvHyvUfgfeN8RvirouFfWXcauvkfxxVMBYMKMpmDul0Ai5IDBlenGisRKUh7c29bOIHxOC
        T3I/3yRWQZEB05DTL6tmkx3QTOvTHc/F5AtGedIZ9SxI7Ky1AKdcRO5LHHIVJ0jTVz6FEz
        cssOEZVXPIx6C5UmzOhrB9h3Da/4kayNPZtcYDS1kfm5M/h6q837M+fiKWoWYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wwr9p65KrIBqhTuLW+nKLDCjJCbfB++v+eHJkbm6SuI=;
        b=wgdvzLF9GYJ4toR1RXzzlI5vWnPPRz4bmt6OYEMnSYef+dHUH+Lb1nrqqPLNuQNdJyZxls
        3rc6lFNIeZfHyoAg==
Date:   Tue, 13 Jul 2021 17:11:05 +0200
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
Subject: [patch 11/50] locking/rtmutex: Provide lockdep less variants of
 rtmutex interfaces
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The existing rtmutex_() functions are used by code which uses rtmutex
directly. These interfaces contain rtmutex specific lockdep operations.

The inner code can be reused for lock implementations which build on top of
rtmutexes, i.e. the lock substitutions for RT enabled kernels. But as these
are different lock types they have their own lockdep operations. Calling
the existing rtmutex interfaces for those would cause double lockdep checks
and longer lock chains for no value.

Provide rwsem_rt_mutex_lock_state(), rwsem_rt_mutex_trylock() and
rwsem_rt_mutex_unlock() which are not doing any lockdep operations on the
rtmutex itself. The caller has to do them on the lock type which embeds the
rtmutex.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex_api.c    |   50 ++++++++++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex_common.h |    3 ++
 2 files changed, 53 insertions(+)
---
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -464,4 +464,54 @@ int __sched rwsem_rt_mutex_slowlock_lock
 {
 	return __rt_mutex_slowlock_locked(lock, state);
 }
+
+/**
+ * rwsem_rt_mutex_lock_state - Lock a rt_mutex with a given state
+ * @lock:      The rt_mutex to be locked
+ * @state:     The state to set when blocking on the rt_mutex
+ *
+ * The function does no lockdep operations on @lock. The lockdep state
+ * changes have to be done on the callsite related to the locking primitive
+ * which embeds the rtmutex. Otherwise lockdep has double tracking.
+ */
+int __sched rwsem_rt_mutex_lock_state(struct rt_mutex *lock, unsigned int state)
+{
+	return __rt_mutex_lock(lock, state);
+}
+
+/**
+ * rwsem_rt_mutex_trylock - Try to lock a rt_mutex
+ * @lock:      The rt_mutex to be locked
+ *
+ * The function does no lockdep operations on @lock. The lockdep state
+ * changes have to be done on the callsite related to the locking primitive
+ * which embeds the rtmutex. Otherwise lockdep has double tracking.
+ */
+int __sched rwsem_rt_mutex_trylock(struct rt_mutex *lock)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) &&
+	    WARN_ON_ONCE(in_nmi() | in_hardirq()))
+			return 0;
+
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(lock);
+}
+
+/**
+ * rwsem_rt_mutex_unlock - Unlock a rt_mutex
+ * @lock:      The rt_mutex to be unlocked
+ *
+ * The function does no lockdep operations on @lock. The lockdep state
+ * changes have to be done on the callsite related to the locking primitive
+ * which embeds the rtmutex. Otherwise lockdep has double tracking.
+ */
+void rwsem_rt_mutex_unlock(struct rt_mutex *lock)
+{
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
+}
 #endif
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -66,6 +66,9 @@ extern void rt_mutex_postunlock(struct w
 
 /* Special interfaces for RT lock substitutions */
 int rwsem_rt_mutex_slowlock_locked(struct rt_mutex *lock, unsigned int state);
+int rwsem_rt_mutex_lock_state(struct rt_mutex *lock, unsigned int state);
+int rwsem_rt_mutex_trylock(struct rt_mutex *lock);
+void rwsem_rt_mutex_unlock(struct rt_mutex *lock);
 
 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h

