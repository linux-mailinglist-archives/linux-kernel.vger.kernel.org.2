Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F793ECB45
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhHOVby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhHOV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6AC0617AE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:43 -0700 (PDT)
Message-ID: <20210815211304.340166556@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=EhnfSJ6/4YabYTULE0Qo2WEb+3ZuPD03mKWdXWSbaTFK51+KYP9NFQIKYFs7v4wC4Zabb8
        KboQVZHKrEAh+LHNKorGHjSKeP1MEMym0VznUU0KgDz4IjTQSISrCYW2hsuSAs2WZV0hm6
        uliVh+TATZoRhBZMW/24uNZLLckiBhw9rTAr2Zl+onG2ua6v9nJAx0/nXPQUfbT4OrLc7Z
        mb2sXhr5ZJDQFpP5rkMjD2CjA+RMKxUfTMNEahOpLz3zLA+h2TuiLW2wRvnbjVHcIpiLFF
        PwGcz0kDNh75YYMdasHDtP26pHNYNZvhAVJRtO62o8sX56VjvlfailPJ2yO9vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=fd6rcM0b+r6IB34ng9ZHMRbnBC3xVirRlZ2/hsEIGiUHp56H5UL8EX0oFHagdrlmAatoP/
        Ts+VdmlNDlBSpCBg==
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
Subject: [patch V5 42/72] locking/ww_mutex: Split up ww_mutex_unlock()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:41 +0200 (CEST)
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

