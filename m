Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4233DBA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhG3OWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhG3OR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962AC0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:49 -0700 (PDT)
Message-ID: <20210730135207.313395742@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=jGG8pJWP45OkP8ykza7kYMpJLrSbGLEb4Bf3vy6/njrTIcuw/CTAe5khCnZGy4RVbsSSmU
        4KoB3UOc1wW4+hnZspNRlDVEL+DmSPIr4KZC+lZaT8Nwwe9gVj1L+MyjLPPt7Gto+NGpcm
        zkTiSveKfTCt0lU+UzSwhpF8QPr4KFnqErX2lmJ0hAu1z47CBkQEuUtGgPVI7arMHaXKHb
        2kDio3qyk+WASIfD40Ishvta4xDrSd9cx/m6O//XNQmHCjsP4F/snTVd36rFQf7OS9ztXS
        G5jN5+K5YcSgcKPK/Zx3WktNzAgRv1sVBf7qY6rzgDgEd0FagQy/sBuHOB44MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=+gCSRs9s1j/h9mxAIfBcSfVFCoUnL8250w4lEq0s9zYOMRC6WziecEUBQpJowEibT/FVV9
        WszIg/TxXKeiLVBg==
Date:   Fri, 30 Jul 2021 15:50:45 +0200
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
Subject: [patch 38/63] locking/ww_mutex: Split up ww_mutex_unlock()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Split the ww related part out into a helper function so it can be reused
for a rtmutex based ww_mutex implementation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/mutex.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
---
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -750,19 +750,7 @@ EXPORT_SYMBOL(mutex_unlock);
  */
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
-#endif
-		if (lock->ctx->acquired > 0)
-			lock->ctx->acquired--;
-		lock->ctx = NULL;
-	}
-
+	__ww_mutex_unlock(lock);
 	mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
@@ -915,6 +903,18 @@ static inline int __sched
 	return 0;
 }
 
+static void __ww_mutex_unlock(struct ww_mutex *lock)
+{
+	if (lock->ctx) {
+#ifdef CONFIG_DEBUG_MUTEXES
+		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
+#endif
+		if (lock->ctx->acquired > 0)
+			lock->ctx->acquired--;
+		lock->ctx = NULL;
+	}
+}
+
 /*
  * Lock a mutex (possibly interruptible), slowpath:
  */

