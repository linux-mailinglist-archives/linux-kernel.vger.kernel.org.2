Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A123C7422
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhGMQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhGMQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:50 -0400
Message-Id: <20210713160750.053836299@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1UsSumVcIpKPg7SHarB7OCju5ysCnPoD8s5+TZzWUsw=;
        b=R2CncGzL/iPVPgVMnjPtjeiPifJfkqejJcsWC3s6ugX8o3vN2aLU9ptYpcyLuDmZXcQVR1
        u8x4vWgGl5YPy83TnRRkmwgNYmhmSWIvlkjDH1NGfVU2+6Vw5wWp/ZYecQnFgnGG/7GTei
        pw0yq/kQU6W2FfcGDgEI5NnRTLphYAWmem2GtrGqNNJ5dNN7KwrH5g8p0UCNS4p71npTlT
        tVDoRYSPMHXuc582aZq5fmfloKjauM2nWWk7SXWepImkhzrGw2K7fcfBcbjLUKNQBhZa+r
        u4+lOzClQtvrFvA3kU4tVZUjKCHzd8U1jjwnVNBZb27SvavLVP3Fyt6kqH5bKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1UsSumVcIpKPg7SHarB7OCju5ysCnPoD8s5+TZzWUsw=;
        b=yQc9cZFNppPcJlVjLgPQFt4fRFYgyWPZVabIi6yFeO8ctgFEgB6MK133Zi8z3QSjjbQXOh
        Kyrev7uxzbmoztDA==
Date:   Tue, 13 Jul 2021 17:11:36 +0200
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
Subject: [patch 42/50] futex: Cleanup stale comments
References: <20210713151054.700719949@linutronix.de>
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
 kernel/futex.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
---
diff --git a/kernel/futex.c b/kernel/futex.c
index b8eab7a2934b..e0f266fa7249 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1354,7 +1354,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
  *  -  1 - acquired the lock;
  *  - <0 - error
  *
- * The hb->lock and futex_key refs shall be held by the caller.
+ * The hb->lock must be held by the caller.
  *
  * @exiting is only set when the return value is -EBUSY. If so, this holds
  * a refcount on the exiting task on return and the caller needs to drop it
@@ -2621,8 +2621,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held and a q.key reference on success, and unlocked
- * with no q.key reference on failure.
+ * Return with the hb lock held on success, and unlocked on failure.
  *
  * Return:
  *  -  0 - uaddr contains val and hb has been locked;
@@ -3235,9 +3234,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * In order for us to be here, we know our q.key == key2, and since
 	 * we took the hb->lock above, we also know that futex_requeue() has
 	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * race with the atomic proxy lock acquisition by the requeue code.
 	 */
 
 	/*

