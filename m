Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16073C7424
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhGMQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhGMQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:52 -0400
Message-Id: <20210713160750.256384485@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgbMQDUtNVZeuYadpblHH951S1lFx4cWCdT8LoJIwp4=;
        b=aQMEz+ONqOtQkaqVcfdWEaZ6/D3jUtBxEPCId9mupC5ZcQNeMOXBF8Cv+N28FD5nqJLyQQ
        HI5CLLANGNeUk2qJ8quSv5C2lzbof8qZAGTb6wkBfTObNBzuS/QoXd03/6UwHdcPAoIhuI
        +EyAQGnPBRu2FzxqXQ9c9CmjnqssLiaJta+SPWG9mPO4D5qtSjUM2i8pYUrYe3Y6nVsmbH
        5U9DnagtoGsHSEtqzca6+f5thXEDknfEOUOLzJulZiVBTUXS2lge4MiivzMeflDm7hCIX9
        ha4/KwkzDbHIvsUqbUGLntOkRjQQa0mkT67Q3Ya+4niP5qmD5UDlpbN6ttABUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgbMQDUtNVZeuYadpblHH951S1lFx4cWCdT8LoJIwp4=;
        b=Byk/+UC6K5+21aLP+2ZEqlV5DA3Mn2YoZxtgVMEdGhlQ4DyCZTs+Xps2Wb7tqa7dr3vGdL
        6B1LfHG/jRC/ANAg==
Date:   Tue, 13 Jul 2021 17:11:38 +0200
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
Subject: [patch 44/50] futex: Restructure futex_requeue()
References: <20210713151054.700719949@linutronix.de>
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
 kernel/futex.c | 90 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)
---
diff --git a/kernel/futex.c b/kernel/futex.c
index 3b037ebd04f0..8ffeb9871476 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2119,20 +2119,17 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
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
@@ -2140,50 +2137,45 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
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
 			/*
-			 * Prepare the waiter to take the rt_mutex. Take a
-			 * refcount on the pi_state and store the pointer in
-			 * the futex_q object of the waiter.
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so.
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
+			/*
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
+			 */
+			break;
 		}
+		/* Waiter is queued, move it to hb2 */
 		requeue_futex(this, hb1, hb2, &key2);
+		task_count++;
 	}
 
 	/*

