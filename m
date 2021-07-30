Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176D3DBA34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhG3OTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:19:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhG3ORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:09 -0400
Message-ID: <20210730135205.261224640@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nTs1p2n4J1D3S/BguxZ21+Vrl54jpwCg5Ng4ziPe0FE=;
        b=OMv23aCe5mr946Z2/L1pqk05W9saeIqpCIX1Xo8Ak4m9CsngbBFdftsfGl3ePp9u48kZuq
        GPg8OVVGfNdDBKj1xz15cttUXC2oQ2iJ4x8nxEf96ojrLYF/7wigw2XACCPR4TKbKQFHnq
        jevJ93KfevpAJOnMtzeMcCvk5ZIdXZAa/E4vCgLTpkVy9N1Rr4KzGoFjr3CoWA3ikRsGp3
        bokMpAo6x1DaQf+nPfTVDuKrLgF39aPCwk6R8Rk2ZoHd5yLIDlgdfyEZQoZPqztkrH4pKh
        wtXH1nMC58CQkEhdxc5y7vb1vVreh7035ABxpdqbR7jf90bZjAEzzRLAnJYrtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nTs1p2n4J1D3S/BguxZ21+Vrl54jpwCg5Ng4ziPe0FE=;
        b=Rm4baeik6Qvs7+xLP1pmW6VGMQ7JFpjPTyC4bF85Z93aZQzCzZJEoY3Vpuw9Ve7wTKQHIL
        TB9sUzAYlN6+mhCg==
Date:   Fri, 30 Jul 2021 15:50:09 +0200
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
Subject: [patch 02/63] sched: Introduce TASK_RTLOCK_WAIT
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT kernels have an extra quirk for try_to_wake_up() to handle task state
preservation accross blocking on a 'sleeping' spin/rwlock.

For this to function correctly and under all circumstances try_to_wake_up()
must be able to identify whether the wakeup is lock related or not and
whether the task is waiting for a lock or not.

The original approach was to use a special wake_flag argument for
try_to_wake_up() and just use TASK_UNINTERRUPTIBLE for the tasks wait state
and the try_to_wake_up() state argument.

This works in principle, but due to the fact that try_to_wake_up() cannot
determine whether the task is waiting for a RT lock wakeup or for a regular
wakeup it's suboptimal.

RT kernels save the original task state when blocking on a RT lock and
restore it when the lock has been acquired. Any non lock related wakeup is
checked against the saved state and if it matches the saved state is set to
running so that the wakeup is not lost when the state is restored.

While the necessary logic for the wake_flag based solution is trivial the
downside is that any regular wakeup with TASK_UNINTERRUPTIBLE in the state
argument set will wake the task despite the fact that it is still blocked
on the lock. That's not a fatal problem as the lock wait has do deal with
spurious wakeups anyway, but it introduces unneccesary latencies.

Introduce the TASK_RTLOCK_WAIT state bit which will be set when a task
blocks on a RT lock.

The lock wakeup will use wake_up_state(TASK_RTLOCK_WAIT) so both the
waiting state and the wakeup state are distinguishable, which avoids
spurious wakeups and allows better analysis.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,9 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+/* RT specific auxilliary flag to mark RT lock waiters */
+#define TASK_RTLOCK_WAIT		0x1000
+#define TASK_STATE_MAX			0x2000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)

