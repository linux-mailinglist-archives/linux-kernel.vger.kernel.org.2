Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEB3C7410
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhGMQQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54378 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhGMQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:28 -0400
Message-Id: <20210713160748.288862984@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RACUEYQWWTuTg5rIuaS/OKtL0LjmH9/maMT9DMgtSP0=;
        b=2tejnREXqcOiBV3mieJr2+O/TwSVL58xSVl5T1iJf7lzhfaQy537sd/sJakWe2dXEZdyNp
        qAptbfJbkVWLLR1glK3E6rTwWhCGyAaS29cXxIavWgZbzN7OShHTqvpxT56P0muayDdkSx
        6/R9tG25ITm6ktb6i7fIAD6ClIWI+8kr87DPsqaVljxGopGdCPM2W8eBMS2Z9Barh351lX
        cKeKrz6ZqCWIrA+ny7mCpKOW3nl+dRJfjXccgiLBHoMsiQF0RqPVfu/jAYFzIn0MpJeRa8
        YEkEPYAG43Nwc7jjURzuCkcoyuapO35BayEYrdj/J4qfK+ZiUQB5SPz+/8Z+xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RACUEYQWWTuTg5rIuaS/OKtL0LjmH9/maMT9DMgtSP0=;
        b=yl6K3ITp46aJZa0X7XMkdoJEUv0+rwBb7PsS/vxm5kmWuylCivEm4686meZ5oiYbX816hg
        TBPBjdNKaOnxjfDQ==
Date:   Tue, 13 Jul 2021 17:11:18 +0200
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
Subject: [patch 24/50] locking/spinlock: Provide RT specific spinlock type
References: <20210713151054.700719949@linutronix.de>
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
timeouts nor signals and it is state preserving accross the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/spinlock_types.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
---
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 7c8107c280c0..98d498f9e4fc 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -51,6 +51,9 @@
 
 #define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
 
+#ifndef CONFIG_PREEMPT_RT
+
+/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
 typedef struct spinlock {
 	union {
 		struct raw_spinlock rlock;
@@ -79,6 +82,29 @@ typedef struct spinlock {
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
+#else /* !CONFIG_PREEMPT_RT */
+
+/* PREEMPT_RT kernels map spinlock to rt_mutex */
+#include <linux/rtmutex.h>
+
+typedef struct spinlock {
+	struct rt_mutex		lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} spinlock_t;
+
+#define __SPIN_LOCK_UNLOCKED(name)				\
+	{							\
+		.lock = __RT_MUTEX_INITIALIZER(name.lock),	\
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

