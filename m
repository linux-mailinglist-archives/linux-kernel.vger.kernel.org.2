Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C93C73F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGMQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhGMQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:08 -0400
Message-Id: <20210713160746.614718046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=S5tz8SFEJW18l0Y2Rz6umr6puG9JAkAnmuja1nOnxTM=;
        b=yrFv99ZMCQigXV8VeWYg6bO3T/DHSjz5B6A4HxGkKkK3KTzlJc0BOw3BDz+/EAUxhEZsI2
        by4YnzKqeS2pvkfWHAMb34N3JT0NMrDn99+NzfRYE6aPs0otehgzxMkcss0SRSZF2DWh+r
        vAamNFkCBrj6HwaTFHdgYeaCE1Z0bc5ICriEXu94U6Sg52CB5Gb5fuOqesTRU27pjaUPw/
        Jv+ZnrLmSzoqYPKedUVMW0htMEHX9DRTRBFlK9X9DLsuy0h94RJb/hWq5Y3lWq8QWSQQMI
        RQdhDT9bexn6va9X9f2nZ8Fy1MBhjy0iJlyuvgUcXbTO5W53SSyMMXhJyx1Xog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=S5tz8SFEJW18l0Y2Rz6umr6puG9JAkAnmuja1nOnxTM=;
        b=10/PamdiqpI1vDmce9FyZkpki5eljIwqlyKXoyvOmN8zKX7qyReJNYK3FpawQI0AopeaP4
        hOpxMwf0kXgwYbDg==
Date:   Tue, 13 Jul 2021 17:11:01 +0200
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
Subject: [patch 07/50] rtmutex: Convert macros to inlines
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Inlines are typesafe...

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 406818196a9f..f422140e6b51 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,8 +141,19 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_acquire(&lock->owner, old, new) == old;
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_release(&lock->owner, old, new) == old;
+}
 
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we force
@@ -201,8 +212,20 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-# define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
-# define rt_mutex_cmpxchg_release(l,c,n)	(0)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+}
 
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {

