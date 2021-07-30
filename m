Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA03DBA47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhG3OV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhG3ORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:45 -0400
Message-ID: <20210730135206.696939121@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QJmP+ZWrvcKIphqxWJVnNjBXhaJqFhE594/qM5BJ198=;
        b=EFYrpdnrQIVZZL7XTohvehZA52yD+yek0dx7whzg9Id3c7hIaM5MRG7L7avQ3xQTnzCHKr
        dIgv8QHMdrBzARWBnV95+yfLMN8DRLhD5MHfxyGJUhdDr6J2yMEMCpI9JHvUDdir2MfzNI
        In/xVhE8DoFRKcYPfdw1+8c/nqiE+mGhtMi3+fiObsN7xDwFOe/CGCNSywSU6GZv97IPSL
        X6zOysWX5OUxRyaEKFjA+YMxGCHXx22hWQMqyVjIUJvKTyEej2UHkc1omf/zXiMeYUw3nv
        1bsZjIgDKPyQ4QwxLNjhLCasAIb0Z0gkeyYy+sqCzm/UOjnCnK1P77wIp0mjUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QJmP+ZWrvcKIphqxWJVnNjBXhaJqFhE594/qM5BJ198=;
        b=HeVZ5RPKOqBeLmo0JNtdgoqznR6CBaW+3BSlh9UByjRt+pZsMG+LjHVkuZh0iCvcB4rU5r
        O++g+xqPfnA8UzAg==
Date:   Fri, 30 Jul 2021 15:50:34 +0200
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
Subject: [patch 27/63] locking/spinlock: Provide RT specific spinlock type
References: <20210730135007.155909613@linutronix.de>
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
 include/linux/spinlock_types.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
---
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

