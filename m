Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEEE3E188F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbhHEPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbhHEPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:51 -0400
Message-ID: <20210805153956.217994397@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jtIA73edouYDKIgRb/zcI/a4VI8yIHiv7LIhDcalKJc=;
        b=H6a9CI0qhHqExcjmTerHaC9XhGI7HJz03Lj1sF4kCMGxBRMPfFT6aZ0RwUH66FhtcwXlZp
        57j29PzdLKtUHE9WVuKout/WAjfQPIqPi9p/ja8Xn8Ax1+OFOay4ZbQcSj5qGMADAH0HDv
        KVGYAKSr1H5RQcRzwRDp7Uy9PMpLz/8SOzRpf8dLI6VokrTcsfvyqtBP5MSwZidNbrOSpD
        tUKiZcXiYPImLwkPIalgM2qOzjuOJ9d9eZcuSJaDAISOE2TTZePIEVO9D5dUwTdhVK6wvJ
        14Twl7w3I36xzoB2P5DfzH3uUcuL3I/b3fGYqrtq4y9B0l+QqFX61AC47Tax+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jtIA73edouYDKIgRb/zcI/a4VI8yIHiv7LIhDcalKJc=;
        b=sYvu0IP/q0XZDQr4b5irMBve+08X/fC41Zxsi+xEOAr7zOkF/sK6oS3Rnw3VlnZgrdM/qN
        SOePvUyy+fUi9GDQ==
Date:   Thu, 05 Aug 2021 17:13:59 +0200
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
Subject: [patch V3 59/64] futex: Simplify handle_early_requeue_pi_wakeup()
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
@@ -3085,27 +3085,22 @@ static int futex_unlock_pi(u32 __user *u
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
@@ -3114,22 +3109,21 @@ int handle_early_requeue_pi_wakeup(struc
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
 
@@ -3232,7 +3226,9 @@ static int futex_wait_requeue_pi(u32 __u
 	futex_wait_queue_me(hb, &q, to);
 
 	spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	/* Is @q still queued on uaddr1? */
+	if (!match_futex(&q->key, key2))
+		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
 	spin_unlock(&hb->lock);
 	if (ret)
 		goto out;

