Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0333C7425
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhGMQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C613DC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:14:04 -0700 (PDT)
Message-Id: <20210713160750.348812588@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qKfo8hoK5mdLLprCPlz2wh/fAdk0XRdu+5gusV+BHiw=;
        b=ZI87rQXTk+Ih2OcAIkuZAKOGj7XJVJraLk/Y4d/PKMOtJnAdgL2qnbbdYkWBXAXIhfQ8I0
        /hZg+7aYxq9lxNuJ4xgMlGQ6mSwEfVIyl8GSsJb76tpko0rx4/6TVTfDY9v+/kcM7w7Ls4
        rszyH65m6fm4+hsgaAxHro9GcbwxZkIGtar7Duhc2g/wDQJjEsyiTuJF3F5J4/W+Jn0cg0
        HNymTlkSNqxcwxmGMh/65JIK3y3a6i9bjIHvrMu8pOxEP+RKN4gHK/eipA3e57DbkH194B
        KFlsZI9P98ouucSqf+47W4t3h1snJRikFt610f9SnhDR9iBG6MQCnwowKaOEGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qKfo8hoK5mdLLprCPlz2wh/fAdk0XRdu+5gusV+BHiw=;
        b=SYe4woQGR70YMPBNordvMGLfXkfIDcwHPuAZdseViMRdRaPeTql4+azXYzHfTbrStiBwJ1
        zQ7C8EQoT4PJimAw==
Date:   Tue, 13 Jul 2021 17:11:39 +0200
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
Subject: [patch 45/50] futex: Clarify comment in futex_requeue()
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The comment about the restriction of the number of waiters to wake for the
REQUEUE_PI case is confusing at best. Rewrite it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)
---
diff --git a/kernel/futex.c b/kernel/futex.c
index 8ffeb9871476..e92c871aa133 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1960,15 +1960,27 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		 */
 		if (refill_pi_state_cache())
 			return -ENOMEM;
+
 		/*
-		 * requeue_pi must wake as many tasks as it can, up to nr_wake
-		 * + nr_requeue, since it acquires the rt_mutex prior to
-		 * returning to userspace, so as to not leave the rt_mutex with
-		 * waiters and no owner.  However, second and third wake-ups
-		 * cannot be predicted as they involve race conditions with the
-		 * first wake and a fault while looking up the pi_state.  Both
-		 * pthread_cond_signal() and pthread_cond_broadcast() should
-		 * use nr_wake=1.
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=1.
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;

