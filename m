Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE73E1868
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbhHEPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:43:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbhHEPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:02 -0400
Message-ID: <20210805153954.446652036@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fT3l3HJQchbNTggPTFF8rMzyk++cOOz1/cpvRfZOaj0=;
        b=XTqTyjx3vUwizzcDMw7rdX/Fnc8aMV5bpjlJ2UQxfA6kTn6sR8mZbtC8EIqHVT9sNOX7U+
        eyJQkGWa6j5UepG+lS0FLEVaj9h8K1J1fWF86f/ldaRk1M73vmOHkM4+SG1bBwlt7aV/4j
        jy60u1Jy1TN3bFdpPDkL6Y3xnROekLwhz6gkanMT2WZaJBW7vKqs+hW0/6iQpv3jifcXPr
        0WLsWqBU09YNKrD59YPv/dd6cm9Iej48LT61tcVvSP9BwZIUMvUSTqbhMFTt2rGgY4c1F9
        e2/3ERegUTgIthwAhmhg050jEHHH0FCfbEkftbqZAwEXy/dqh4uXLgKVPTlLDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fT3l3HJQchbNTggPTFF8rMzyk++cOOz1/cpvRfZOaj0=;
        b=JZeU3Vx2PE7z4qLjZUO8B3asYUE3e20YRJcQvvGqVvuSqDnu0mSQscyvSEEDqQs16uJ4/E
        5jDOD7GbeTvAwwAw==
Date:   Thu, 05 Aug 2021 17:13:28 +0200
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
Subject: [patch V3 28/64] locking/spinlock: Provide RT specific spinlock type
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

