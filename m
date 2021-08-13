Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356E13EB242
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhHMIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbhHMIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:06:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96419C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:06:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628841960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8SDlxxfnQkj2M+ncAfzmCafpk/C/r3y8fM/XSbU8v0=;
        b=KI080ac6VkRGwAZSPpxwBC0cOPJFXJP+vnIB3Gv7YEtzweO/DLNd0bGyd4pX7B1NowXtQL
        ZhoYStsMO/oPZu4IRpbW/HzNhMU/ZeWTTRU0XOzwZz0FwXto5RStM0HYirhVT0u+i+o0C2
        uZZ3u9Ir1xvo6OOrfr19mInblnsewkiuMFu9+1O4JistR7pqSkom0TzUWHaGxGBcQnFc1z
        Djq5MyIDFBwCmOek6h3fU3UXi2zwi0x8kWdSNXgpzwNvh/3/LHCtRgQp0b/UqhEX/lLhqH
        OAYCaR1wvnDMCmN8Z3ChPF3Bd7ggbEf2+l9gx8y72QiTVsD0qwbBOPLZEm7JMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628841960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8SDlxxfnQkj2M+ncAfzmCafpk/C/r3y8fM/XSbU8v0=;
        b=c0LMWYFXKr1hNg1ePE/m7uL85AwDW8SyFlxaocNm3lhekpuTdAvKeia65T5Bx8+RqsNeIR
        Ja2aTY/TCkNtM+DA==
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
Subject: [patch V4 69/68] locking/rt: Add missing __might_sleep() to
 spin/rwlocks
In-Reply-To: <20210811120348.855823694@linutronix.de>
References: <20210811120348.855823694@linutronix.de>
Date:   Fri, 13 Aug 2021 10:05:59 +0200
Message-ID: <87wnopbwgo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On RT enabled kernels the substituted spin_lock and rw_lock acquisition
functions can sleep.

Add the missing __might_sleep() invocations.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4+: This should have been part of the V4 submission, but got lost
     during patch juggling.
---
 kernel/locking/spinlock_rt.c |    3 +++
 1 file changed, 3 insertions(+)
---
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -32,6 +32,7 @@ static __always_inline void rtlock_lock(
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
+	___might_sleep(__FILE__, __LINE__, 0);
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -206,6 +207,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
+	___might_sleep(__FILE__, __LINE__, 0);
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -215,6 +217,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
+	___might_sleep(__FILE__, __LINE__, 0);
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
