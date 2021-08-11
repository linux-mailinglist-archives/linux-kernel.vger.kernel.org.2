Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28B3E90E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhHKM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhHKMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:09 -0400
Message-ID: <20210811121417.711347054@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0iQSJAKuvhXdV/N4anh2roIn8NWfIZkM0MbhCkCUeY4=;
        b=XbjTrTm+rxTwqjQd09ybm8t8+H2mUWWSQBwE3Oj3iV9J27cok/iAh5XcLUbHpPkFry+cRo
        +7WOSGReQmbmaPIN1Ee7RhlNgwcIEgwVpDi1qIOfgMTO5Oh15m7jExI6mE+DN8WnrWLwL8
        U/5dus0DDqn4OnnciTqy97mXm/XSLtgC+HJnw1YRhwJ2YIHEhi/wEjb64XxxYXa3R72SU3
        vcTyYqMcR2DgkYVAW9Xj93k/7UCulEzN25wetmqC+erE2Go3zy/LllHDAbbsraBSWoY49K
        oRrwvPW7xQi+6Ohnhp8TPtJZdCZcU/I7Ui2rVXK35HhMOIHk8tEiE1rA8yAOjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0iQSJAKuvhXdV/N4anh2roIn8NWfIZkM0MbhCkCUeY4=;
        b=v+Ltge3T+vunC2WkOCqfZAT1XgFYkTnI2YkSVkoFO3nL7Ch9N+50DuaLjs636ERK0oc582
        zW2zwzjF1ogGeCAw==
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
Subject: [patch V4 60/68] futex: Restructure futex_requeue()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:44 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No point in taking two more 'requeue_pi' conditionals just to get to the
requeue. Same for the requeue_pi case just the other way round.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   90 +++++++++++++++++++++++++--------------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2104,20 +2104,17 @@ static int futex_requeue(u32 __user *uad
 			break;
 		}
 
-		/*
-		 * Wake nr_wake waiters.  For requeue_pi, if we acquired the
-		 * lock, we already woke the top_waiter.  If not, it will be
-		 * woken by futex_unlock_pi().
-		 */
-		if (++task_count <= nr_wake && !requeue_pi) {
-			mark_wake_futex(&wake_q, this);
+		/* Plain futexes just wake or requeue and are done */
+		if (!requeue_pi) {
+			if (++task_count <= nr_wake)
+				mark_wake_futex(&wake_q, this);
+			else
+				requeue_futex(this, hb1, hb2, &key2);
 			continue;
 		}
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
-			/* Don't account for it */
-			task_count--;
+		if (!match_futex(this->requeue_pi_key, &key2)) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2125,50 +2122,45 @@ static int futex_requeue(u32 __user *uad
 		/*
 		 * Requeue nr_requeue waiters and possibly one more in the case
 		 * of requeue_pi if we couldn't acquire the lock atomically.
+		 *
+		 * Prepare the waiter to take the rt_mutex. Take a refcount
+		 * on the pi_state and store the pointer in the futex_q
+		 * object of the waiter.
 		 */
-		if (requeue_pi) {
+		get_pi_state(pi_state);
+		this->pi_state = pi_state;
+		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+						this->rt_waiter, this->task);
+		if (ret == 1) {
+			/*
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so.
+			 */
+			requeue_pi_wake_futex(this, &key2, hb2);
+			task_count++;
+			continue;
+		} else if (ret) {
+			/*
+			 * rt_mutex_start_proxy_lock() detected a potential
+			 * deadlock when we tried to queue that waiter.
+			 * Drop the pi_state reference which we took above
+			 * and remove the pointer to the state from the
+			 * waiters futex_q object.
+			 */
+			this->pi_state = NULL;
+			put_pi_state(pi_state);
 			/*
-			 * Prepare the waiter to take the rt_mutex. Take a
-			 * refcount on the pi_state and store the pointer in
-			 * the futex_q object of the waiter.
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
 			 */
-			get_pi_state(pi_state);
-			this->pi_state = pi_state;
-			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-							this->rt_waiter,
-							this->task);
-			if (ret == 1) {
-				/*
-				 * We got the lock. We do neither drop the
-				 * refcount on pi_state nor clear
-				 * this->pi_state because the waiter needs the
-				 * pi_state for cleaning up the user space
-				 * value. It will drop the refcount after
-				 * doing so.
-				 */
-				requeue_pi_wake_futex(this, &key2, hb2);
-				continue;
-			} else if (ret) {
-				/*
-				 * rt_mutex_start_proxy_lock() detected a
-				 * potential deadlock when we tried to queue
-				 * that waiter. Drop the pi_state reference
-				 * which we took above and remove the pointer
-				 * to the state from the waiters futex_q
-				 * object.
-				 */
-				this->pi_state = NULL;
-				put_pi_state(pi_state);
-				/* Don't account for it */
-				task_count--;
-				/*
-				 * We stop queueing more waiters and let user
-				 * space deal with the mess.
-				 */
-				break;
-			}
+			break;
 		}
+		/* Waiter is queued, move it to hb2 */
 		requeue_futex(this, hb1, hb2, &key2);
+		task_count++;
 	}
 
 	/*

