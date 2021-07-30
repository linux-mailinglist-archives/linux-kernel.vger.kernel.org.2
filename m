Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167563DBA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhG3OWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhG3OSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:16 -0400
Message-ID: <20210730135208.309317951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nc56ITYoTDbK+/OR8K4wKKWggLR9IrPVbYS+M+N/8LY=;
        b=OWLWi3m7Y4k6bMr+Qu43IO3/CDLj7WMBk61r2VRkRON69ie/6DKgy74FmSgOMf2oxhaNGb
        mEVG4F27I22DDixZ/W9XEAkH3RE4eJGnqaCWs+OD6Rq1FyHkA3z2pThc5bnpf/5jcoEOZx
        vDfk3cVDXX8ZzL7FHHaLGQNNOhxNwuwEAjtfl0xr8FUzf7zeYREouHXET52Xh5WXRa+Jtt
        ZwsYoJy4oofYhePToiiiXFIUWCHtBoRy9DFB24VeotEX0ZoOXa0NTRSzKzOEdjRgqZFTY6
        F2I4nbtqXuSjzbYl6g6Ym+HBb/OCm+u9o0THDd/Bl3IcISqonOkbNJ9f8zhSzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nc56ITYoTDbK+/OR8K4wKKWggLR9IrPVbYS+M+N/8LY=;
        b=JbCeTRGfA3fR1RAQhskfS5ZfwWrRYC8QK2nziVtWHH90QeWKpb/aOUOjQ6PFVceDVzOO81
        iFce2seCSyMIEHCA==
Date:   Fri, 30 Jul 2021 15:51:03 +0200
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
Subject: [patch 56/63] futex: Restructure futex_requeue()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
@@ -2116,20 +2116,17 @@ static int futex_requeue(u32 __user *uad
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
@@ -2137,50 +2134,45 @@ static int futex_requeue(u32 __user *uad
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

