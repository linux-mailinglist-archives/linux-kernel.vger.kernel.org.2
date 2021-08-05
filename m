Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA403E1888
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbhHEPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbhHEPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:44 -0400
Message-ID: <20210805153955.997745091@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FHs0Hmzwzb7omYphryYDUD2EJ1prXGFg4eqnxc8XxoY=;
        b=wEI3SehbxSRyuenmttMmwLLT9QBrAKXaNPoTYklYb/G0F+FzIBJWN/DfZHpVyAU3Ebpjxs
        wPGZawIpFgJ8snkgDDvYSPq9naQ/B22fr210k8h0JbSz5wq8+jXxSB9BR4c07xAMs/nDit
        ZNCmtww55hClK65DFIj2rXUQwzmach1bizrRk8VKQG0tQ9lVy4iZ6rUnqeX5BOtGqqU47W
        4SnbNbyDI0H0JGhXrEbi7bpFflsboZyVSTnO5/UYgJMIRpXuhsllQVpw+Q8b/3AmBgIA8s
        QynzXFKC/kttfobu0VQvrSt1Yc0BLXAhMnCAEBvznzNjYPInRIln53CROXj7zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FHs0Hmzwzb7omYphryYDUD2EJ1prXGFg4eqnxc8XxoY=;
        b=TqgsW2Gn+FeATvuetm1MWZg/Rz9tslccBPiSo9Sum6PPjrJWu2lwP9fIbkqNDJUtEWUNig
        32ovHfTzfkmSnBDQ==
Date:   Thu, 05 Aug 2021 17:13:55 +0200
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
Subject: [patch V3 55/64] futex: Cleanup stale comments
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The futex key reference mechanism is long gone. Cleanup the stale comments
which still mention it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Cleanup more key ref comments - Andre
---
 kernel/futex.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1354,7 +1354,7 @@ static int lock_pi_update_atomic(u32 __u
  *  -  1 - acquired the lock;
  *  - <0 - error
  *
- * The hb->lock and futex_key refs shall be held by the caller.
+ * The hb->lock must be held by the caller.
  *
  * @exiting is only set when the return value is -EBUSY. If so, this holds
  * a refcount on the exiting task on return and the caller needs to drop it
@@ -2621,8 +2621,7 @@ static void futex_wait_queue_me(struct f
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held and a q.key reference on success, and unlocked
- * with no q.key reference on failure.
+ * Return with the hb lock held on success, and unlocked on failure.
  *
  * Return:
  *  -  0 - uaddr contains val and hb has been locked;
@@ -2700,8 +2699,8 @@ static int futex_wait(u32 __user *uaddr,
 			       current->timer_slack_ns);
 retry:
 	/*
-	 * Prepare to wait on uaddr. On success, holds hb lock and increments
-	 * q.key refs.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -2712,7 +2711,6 @@ static int futex_wait(u32 __user *uaddr,
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
-	/* unqueue_me() drops q.key ref */
 	if (!unqueue_me(&q))
 		goto out;
 	ret = -ETIMEDOUT;
@@ -3205,8 +3203,8 @@ static int futex_wait_requeue_pi(u32 __u
 	q.requeue_pi_key = &key2;
 
 	/*
-	 * Prepare to wait on uaddr. On success, increments q.key (key1) ref
-	 * count.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -3235,9 +3233,7 @@ static int futex_wait_requeue_pi(u32 __u
 	 * In order for us to be here, we know our q.key == key2, and since
 	 * we took the hb->lock above, we also know that futex_requeue() has
 	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * race with the atomic proxy lock acquisition by the requeue code.
 	 */
 
 	/*

