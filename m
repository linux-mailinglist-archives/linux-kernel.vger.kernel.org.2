Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BAB3ECB61
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHOVd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhHOVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:30:00 -0400
Message-ID: <20210815211306.023630962@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1on1mIZkev5m+YtxfYiTVz0T9iY08TWioTt3tPXij6s=;
        b=NGlEXE+7x9bdlGcLBarp+eth52fN8Yjl2wzejataKcwcxavrf54VEzWZ5gEvQaBoDCtr8r
        oVNr9LpLGqdc8GO0yNSZ7EiLM/vZlel0VgN6L6Iw0Ed2hkq31EQnyRgQ1+SbUElpnkSwwR
        Tunp9dFxIRATDL1ZVdwx07/EOE6juBWZFUu6H0mpvVo+FVIpA3N5nyF2LmIDv+7EVvMtee
        3RynjYiJqaJZsggT4cN4Br1Do3exNMh3ltKZ2un/thNyfvLw6yjPwrfCVRashNDTBGRDix
        xUXyuSWjAYMZN3QUzKIgMyGOc7KYw4fvYIzA3zcnjgUcL2qMof3Xcjst4TKFlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1on1mIZkev5m+YtxfYiTVz0T9iY08TWioTt3tPXij6s=;
        b=7E/IikQscZtOXNAgIffll4eTi52kzPSzL5MZlxH+6O3Y2oPitrWy8sI2ejn26Wt1AQpCpY
        FvFtIbNYbznH72AA==
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
Subject: [patch V5 72/72] locking/local_lock: Add PREEMPT_RT support
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT enabled kernels local_lock maps to a per CPU 'sleeping'
spinlock which protects the critical section while staying preemptible. CPU
locality is established by disabling migration.

Provide the necessary types and macros to substitute the non-RT variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/local_lock_internal.h |   48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -6,6 +6,8 @@
 #include <linux/percpu-defs.h>
 #include <linux/lockdep.h>
 
+#ifndef CONFIG_PREEMPT_RT
+
 typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -95,3 +97,49 @@ do {								\
 		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
+
+#else /* !CONFIG_PREEMPT_RT */
+
+/*
+ * On PREEMPT_RT local_lock maps to a per CPU spinlock which protects the
+ * critical section while staying preemptible.
+ */
+typedef struct {
+	spinlock_t		lock;
+} local_lock_t;
+
+#define INIT_LOCAL_LOCK(lockname) {				\
+		__LOCAL_SPIN_LOCK_UNLOCKED((lockname).lock)	\
+	}
+
+#define __local_lock_init(l)					\
+	do {							\
+		local_spin_lock_init(&(l)->lock);		\
+	} while (0)
+
+#define __local_lock(__lock)					\
+	do {							\
+		migrate_disable();				\
+		spin_lock(&(this_cpu_ptr((__lock)))->lock);	\
+	} while (0)
+
+#define __local_lock_irq(lock)			__local_lock(lock)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__local_lock(lock);				\
+	} while (0)
+
+#define __local_unlock(__lock)					\
+	do {							\
+		spin_unlock(&(this_cpu_ptr((__lock)))->lock);	\
+		migrate_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)		__local_unlock(lock)
+
+#define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
+
+#endif /* CONFIG_PREEMPT_RT */

