Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFCB3ECB40
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhHOVb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhHOV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:54 -0400
Message-ID: <20210815211303.654230709@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fT3l3HJQchbNTggPTFF8rMzyk++cOOz1/cpvRfZOaj0=;
        b=oL4QtNYqvJ0VgYh4/RKqzs54cI8HUOLQOUoeGtd9KhUiqeEMOIOH3eHzzkiHIglqCryyLS
        6eaklwwr2WIw2wTWQ76gMgIPU+T5Vkl9MIuYopkuPraLbp5a7bWEEhPdppMEXmgemyYtrz
        nc0S0/g7glHYKhPSolUsTLPbxbrJRw9988YFhH4Z9DUTsGMfDIs5OY1xt8LbyNcQY2JIqk
        Q8D9Y5zw2+CyOt1J/RIxMEo1GKIvE6T1T2ys2S46rwFc3xsV6fG6Lxlzak3lpcsfobmQG/
        dLEfRGKeDUS/t4uVYaJv2EAeqdNs49VSX5+MtM4JQGdu3fzkwGHIJkfQSXkQKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fT3l3HJQchbNTggPTFF8rMzyk++cOOz1/cpvRfZOaj0=;
        b=tj1xr5Xcf3c1Y9DqqKUL9V0/5dFA1D5e4KNUFi4UWh9tMGlavx1+cL9kifjcKJ7EYCogK+
        2zqR7wGnBvhYzcDw==
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
Subject: [patch V5 30/72] locking/spinlock: Provide RT specific spinlock type
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT replaces spinlocks with a simple wrapper around a rtmutex which turns
spinlocks on RT into 'sleeping' spinlocks. The actual implementation of the
spinlock API differs from a regular rtmutex as it does neither handle
timeouts nor signals and it is state preserving across the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/spinlock_types.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
---
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -11,6 +11,9 @@
 
 #include <linux/spinlock_types_raw.h>
 
+#ifndef CONFIG_PREEMPT_RT
+
+/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
 typedef struct spinlock {
 	union {
 		struct raw_spinlock rlock;
@@ -39,6 +42,29 @@ typedef struct spinlock {
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
+#else /* !CONFIG_PREEMPT_RT */
+
+/* PREEMPT_RT kernels map spinlock to rt_mutex */
+#include <linux/rtmutex.h>
+
+typedef struct spinlock {
+	struct rt_mutex_base	lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} spinlock_t;
+
+#define __SPIN_LOCK_UNLOCKED(name)				\
+	{							\
+		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		SPIN_DEP_MAP_INIT(name)				\
+	}
+
+#define DEFINE_SPINLOCK(name)					\
+	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #include <linux/rwlock_types.h>
 
 #endif /* __LINUX_SPINLOCK_TYPES_H */

