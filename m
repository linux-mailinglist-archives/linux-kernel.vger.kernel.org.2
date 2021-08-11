Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C203E90E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbhHKM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbhHKMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:13 -0400
Message-ID: <20210811121417.892596310@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8vT2urgWFa2TdnlBtgBLLfuU80IoeKpkiLUDJrloABk=;
        b=xff99sSIDVwoREDg2ZS3iWzoYd5/kUkZRSU+1Si0mCYAz7e4yQKBxFUiMdla/CxB6Nw+L1
        ZGiMBDL76wJ+zpVZTkS9LDgoMFDkgMk5bWYyRFDMZ+cWsf8uE8MZf9U6PV7/BVB5c7ZPjb
        dAykGJTqF9Gn6tZExKJOtTQ2AEi7GmSL9v7huLYek1iFgvG/OUHlX/TT1ym8x4rdmk7vCH
        asY5Ev4bXZ4AIOKYV41vU4++zxB0/lYTBeQU0972kPoOAD270X6CdOSgfTPGw5B3uCyA1X
        Ncoo3TJCgs/rmnra+SO50G3zMgUDtTcxQpz166JxMDgZXhOxcGeiaz6fY8iWew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8vT2urgWFa2TdnlBtgBLLfuU80IoeKpkiLUDJrloABk=;
        b=KbkHSNhzLHLkf0cn9sNatttdpUpAjYvfmwsujuhOOmLfOx+/MpQbWyznPVlorws6s8a8o+
        DotISs7hzGyDegBg==
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
Subject: [patch V4 63/68] futex: Simplify handle_early_requeue_pi_wakeup()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:48 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the futex key match out of handle_early_requeue_pi_wakeup() which
allows to simplify that function. The upcoming state machine for
requeue_pi() will make that go away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch - Suggested by Peter
---
 kernel/futex.c |   50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3070,27 +3070,22 @@ static int futex_unlock_pi(u32 __user *u
 }
 
 /**
- * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial futex
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
  * @hb:		the hash_bucket futex_q was original enqueued on
  * @q:		the futex_q woken while waiting to be requeued
- * @key2:	the futex_key of the requeue target futex
  * @timeout:	the timeout associated with the wait (NULL if none)
  *
- * Detect if the task was woken on the initial futex as opposed to the requeue
- * target futex.  If so, determine if it was a timeout or a signal that caused
- * the wakeup and return the appropriate error code to the caller.  Must be
- * called with the hb lock held.
+ * Determine the cause for the early wakeup.
  *
  * Return:
- *  -  0 = no early wakeup detected;
- *  - <0 = -ETIMEDOUT or -ERESTARTNOINTR
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
  */
 static inline
 int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q, union futex_key *key2,
+				   struct futex_q *q,
 				   struct hrtimer_sleeper *timeout)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * With the hb lock held, we avoid races while we process the wakeup.
@@ -3099,22 +3094,21 @@ int handle_early_requeue_pi_wakeup(struc
 	 * It can't be requeued from uaddr2 to something else since we don't
 	 * support a PI aware source futex for requeue.
 	 */
-	if (!match_futex(&q->key, key2)) {
-		WARN_ON(q->lock_ptr && (&hb->lock != q->lock_ptr));
-		/*
-		 * We were woken prior to requeue by a timeout or a signal.
-		 * Unqueue the futex_q and determine which it was.
-		 */
-		plist_del(&q->list, &hb->chain);
-		hb_waiters_dec(hb);
-
-		/* Handle spurious wakeups gracefully */
-		ret = -EWOULDBLOCK;
-		if (timeout && !timeout->task)
-			ret = -ETIMEDOUT;
-		else if (signal_pending(current))
-			ret = -ERESTARTNOINTR;
-	}
+	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
+
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Unqueue the futex_q and determine which it was.
+	 */
+	plist_del(&q->list, &hb->chain);
+	hb_waiters_dec(hb);
+
+	/* Handle spurious wakeups gracefully */
+	ret = -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -ERESTARTNOINTR;
 	return ret;
 }
 
@@ -3217,7 +3211,9 @@ static int futex_wait_requeue_pi(u32 __u
 	futex_wait_queue_me(hb, &q, to);
 
 	spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	/* Is @q still queued on uaddr1? */
+	if (!match_futex(&q->key, key2))
+		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
 	spin_unlock(&hb->lock);
 	if (ret)
 		goto out;

