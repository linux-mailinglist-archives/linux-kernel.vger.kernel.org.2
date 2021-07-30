Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7859D3DBA5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhG3OWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbhG3OSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:17 -0400
Message-ID: <20210730135208.364023771@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CBkg0DxaX9wXWU6TQkV2hJdx88bMZNqdLHHbULUl/20=;
        b=Xt/kBc8quUElmsPcc0aihNbILMhhIjxDtiWjFePagBbJ9YLWzbUkIIbxoPD2b89bgBt+bn
        GZRbU+yj70HAFh7n8r9GWx71sHDMBbGqRDkfns6r8C9VuU1NkXrbzGO4eo9+BHcVaBP+TH
        CTBSdJwGwiWIuPTueLZTDTx//eouN+ydKVzOeIODsb2mnGd6DvJqMWnaViI3doWiQ6KHcM
        DTNXTzoa4PN8Hzr+9Lui3txshESGomgQpL2uKNd9/UnvqJ+H1fvRb2rer7FZe+hsQP5db+
        ICLDBrK6RlMA4TFNRUyjddvSgWXO+vKm5FWwBLz/DRS+CR/PfEpeegszTPJ9kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CBkg0DxaX9wXWU6TQkV2hJdx88bMZNqdLHHbULUl/20=;
        b=PNUS5o83DDH3KQAzhEomLwIQbIhXXamw/EeFq9RQk4+7MYH86CTnbLG90Izr+MtR4qxJLt
        FA07nycUOA+1i9Bw==
Date:   Fri, 30 Jul 2021 15:51:04 +0200
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
Subject: [patch 57/63] futex: Clarify comment in futex_requeue()
References: <20210730135007.155909613@linutronix.de>
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
@@ -1957,15 +1957,27 @@ static int futex_requeue(u32 __user *uad
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

