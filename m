Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA72B3ECB1E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhHOV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhHOV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB7C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:27:43 -0700 (PDT)
Message-ID: <20210815211302.144989915@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WIMYaUbQvMHlYNNUFXv+w1HG9bfXJ2KrG4bDzh/ft1Q=;
        b=Lmz/LbxoF5oB/ubs60H6Ezp3TNaaTgdJ1ScYoTP9SYBcC7ZRcvuCEr7d172BOj4v7WAuPD
        POizTLRxhmeNzI2Anfjv7aOs9TR1Ye83LL1fxqpIX3hlC1vYeGNMCybHFdrxI1sCoTPDlP
        WJqQp8Bt4CS5YIOEiUfuWQWobkz0qJ4tWLu0Gvdik+IbwPWm/QZU6QlyGxwhw/vlFTmXl7
        ybUK2l7ssmuReNjDAuhizLTiusuutxHdP7QkWK9ZraRKe9KtTcZm/MsBxTOSOPBZzlg4qv
        Trkw/fyCJOHrAsREY7c7s1Co5HbDzHIh3l8QfLJ3Uhp0TmBDlPvi+rb0BRiOAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WIMYaUbQvMHlYNNUFXv+w1HG9bfXJ2KrG4bDzh/ft1Q=;
        b=acp5FpRNUufDsPbILsLNp9KC38AzsQlSNYWma5Hfdnl8CGHj2Iz10UKGM58IAm7CdGleOG
        IEW/ddqlKtd+3VCQ==
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
Subject: [patch V5 04/72] sched: Introduce TASK_RTLOCK_WAIT
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:41 +0200 (CEST)
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

