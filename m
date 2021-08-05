Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9C3E188A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhHEPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbhHEPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:49 -0400
Message-ID: <20210805153956.161214930@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zDbJOU97IQurUO8kF4WxZNgLkAG7qo6kSYRC7UzhOBU=;
        b=3K5SQ6OBW7s/GYacjIblXhGTF14wAFmTw9fDHIs9izMr5w39evDYOgwjCC+28vjoXDNqTb
        NxdEfTUdGGIUL+OXmgunFeaxXiWFOMAh8NDonBK5DS57vo3X7lMJo4cKt2ojJvvkQ98yBh
        5dvhozn3eHXhJdLl0pyx67W7CuASgTc743/KeF10ebtWIRO76F1F9KQYIC3LPnIrgYmubL
        /xqvb7Mvfo7FdUUuPyTrBBdXr7pK2GCX5WboXMDJriR6u5CJb/yDq1ZPwXUmFx3LzXQ4Hw
        OjyyIYGdDfFm58f5C5fqbVyv0D8idozoEEHeNXLh25Mn0prs9Xav3LlB9gTHEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zDbJOU97IQurUO8kF4WxZNgLkAG7qo6kSYRC7UzhOBU=;
        b=7biyHmoCIKs+jPx3DaWwhKteUxNTRY3QMYQTjyCbEvN77YVP1gy3V8hDclaNgxqezSkiBd
        lQs7lHR2rPkHM4CA==
Date:   Thu, 05 Aug 2021 17:13:58 +0200
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
Subject: [patch V3 58/64] futex: Clarify comment in futex_requeue()
References: <20210805151300.330412127@linutronix.de>
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
 kernel/futex.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1960,15 +1960,27 @@ static int futex_requeue(u32 __user *uad
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

