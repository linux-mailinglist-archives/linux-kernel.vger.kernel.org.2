Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E3DBA60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhG3OWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbhG3OSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB09FC061799
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:18:09 -0700 (PDT)
Message-ID: <20210730135208.199858159@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0gu0xQi9sGzKFU9h4CaUgwBaepCSRqTTRv6F4UUQNeI=;
        b=fnxQwBcIeLjJF1qxVyLAXbd7DTnQK8M2Y9Np5mBFxGDujk/EUowlG8r35ZcALAOMwHCZhh
        8eVfsB/KOBbgmWWasmB2XItPz3vWXMor1WteJ3LuQgos5xVce26p/UzR5hJCVNZXwgRjmr
        ZcicH2zUFbuhRV3laBLx78Dx9+Quvpyjau2syLSyEC0n8N/M9nyg075G6RvVc/AgScwfxi
        SXlUFGnTdNFycROE8OBPBbmZutUXIWXfEwJPy5ag0VR86yHIiQKCZEbvk+mPqbBh1Yrx+E
        iDXx462amvFLjZ+BvdfZbMEJgIipDSBj2we9t+7501gNalOBuUUdO2z0rAElhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0gu0xQi9sGzKFU9h4CaUgwBaepCSRqTTRv6F4UUQNeI=;
        b=Sg7wEWRDwzaWogKdGPkW6v7XO9uCOiKnDpVaWBXq74JyLPXyxjdf6H243br6kNaTjYxV6K
        Zk5qUVGJsPfmC2Aw==
Date:   Fri, 30 Jul 2021 15:51:01 +0200
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
Subject: [patch 54/63] futex: Cleanup stale comments
References: <20210730135007.155909613@linutronix.de>
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
@@ -2618,8 +2618,7 @@ static void futex_wait_queue_me(struct f
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held and a q.key reference on success, and unlocked
- * with no q.key reference on failure.
+ * Return with the hb lock held on success, and unlocked on failure.
  *
  * Return:
  *  -  0 - uaddr contains val and hb has been locked;
@@ -2697,8 +2696,8 @@ static int futex_wait(u32 __user *uaddr,
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
@@ -2709,7 +2708,6 @@ static int futex_wait(u32 __user *uaddr,
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
-	/* unqueue_me() drops q.key ref */
 	if (!unqueue_me(&q))
 		goto out;
 	ret = -ETIMEDOUT;
@@ -3202,8 +3200,8 @@ static int futex_wait_requeue_pi(u32 __u
 	q.requeue_pi_key = &key2;
 
 	/*
-	 * Prepare to wait on uaddr. On success, increments q.key (key1) ref
-	 * count.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -3232,9 +3230,7 @@ static int futex_wait_requeue_pi(u32 __u
 	 * In order for us to be here, we know our q.key == key2, and since
 	 * we took the hb->lock above, we also know that futex_requeue() has
 	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * race with the atomic proxy lock acquisition by the requeue code.
 	 */
 
 	/*

