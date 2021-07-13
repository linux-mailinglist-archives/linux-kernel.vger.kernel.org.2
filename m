Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42E3C73F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGMQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54140 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGMQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:01 -0400
Message-Id: <20210713160746.090756246@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=AAkiP3DXZkJSPUHAxuuDkMnzy2WxPke0v+vOmA3RY+s=;
        b=S2a1ID1oZBFzyRaxCCF1lQ5Jt2IL7D0e/D4dD9xbxWOa4enjg8JbT9JABr32kz8kQKgUvf
        HyEhbCP3OouTFgk/R29Xp4aerYzY1U77oTBAs66uj7BhlcYchsTKvCiZyMxfo89FBwHp7S
        kMPZs/rbpDbeOjsH4FIL+cuh182cl3bti8tqvsXzV8gm2pbHaIXWlqnySQAmSFZ3AKiAwu
        ILVpIICiFQ7I2lzM52CGBs6+UjduEN0GrIy8s2vsdnuP9sY5kxthCcGRLWCgzHAHwX8LAt
        TOAAYUOiOtvV/R7B5KTn8SNQ5FRo92M/TM+TjCgQ1PtmUVGixm9AQ6HwzPLBlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=AAkiP3DXZkJSPUHAxuuDkMnzy2WxPke0v+vOmA3RY+s=;
        b=UnAuqzsQUqkGZZDOArwzV8XSUyHFAFOuVfriX1e3fYCQ/SGNV7FSPp8ENmdqGCD3CSPyKJ
        gT55P6/onlQAJGCw==
Date:   Tue, 13 Jul 2021 17:10:56 +0200
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
Subject: [patch 02/50] sched: Introduce TASK_RTLOCK_WAIT
References: <20210713151054.700719949@linutronix.de>
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
 include/linux/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 32813c345115..372dd72cf604 100644
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

