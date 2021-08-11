Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3650D3E909B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhHKMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhHKMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:57 -0400
Message-ID: <20210811121414.241020698@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WIMYaUbQvMHlYNNUFXv+w1HG9bfXJ2KrG4bDzh/ft1Q=;
        b=hVL0ZfFpRPPPyYtxL/Rl1UP78rppJtEUjadx8uqA8o/R2jHUF+QMsD4KJm/vZL2+slqhU0
        fxJ+UvC7gKZK09O3wXEEAkRtZyTxY3rextuDc3QjF2R4dTiHVFbnIonyTvHsttr+gSRbIq
        ZoFNp4dUS9ZlWjXaMuORI1t2OQCimPWfMeFQg9JDZgCWPtPnpHBT+ksgvtqFfNxin5rZIe
        RdkrhhM6OOU/LCgpYaCzeyyag3JQyidfP7KxaHE8717fOPiVOhkXOGUtfluUGzlQNlWnxb
        n89PwP8whKtgoCamGwwENPL1L+Oz9s1y7wmEYOvS0nyTiSdn3euYY7JFKzjiPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WIMYaUbQvMHlYNNUFXv+w1HG9bfXJ2KrG4bDzh/ft1Q=;
        b=8FvxzauiMweZTmJftEZUCtREXA9usz4CnGliWmQ4vCyKX/meY7O8ogbv0fGYjIAQIzYX1R
        cAdg08c4ZiwHhEDg==
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
Subject: [patch V4 02/68] sched: Introduce TASK_RTLOCK_WAIT
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:32 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT kernels have an extra quirk for try_to_wake_up() to handle task state
preservation across blocking on a 'sleeping' spin/rwlock.

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
spurious wakeups anyway, but it introduces unnecessary latencies.

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

