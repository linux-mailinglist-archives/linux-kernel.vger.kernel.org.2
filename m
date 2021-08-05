Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86A53E1877
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhHEPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbhHEPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B2C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:42:06 -0700 (PDT)
Message-ID: <20210805153955.080395947@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=l5STZGnPxWN6J23qeCy7xPqUPd4UGrMGFZTrhVUepovYiWYIhbTdBIbmUOTg1LGVO2eUu6
        K3Z2fu8kRVlz6lPI/8MBK/bKW+8bDcmcYNt2TWXcgx1Rrwh5kzYgQlosDAdHzr4/PvVSdv
        vfQFxVUu7+y0lSISZZNYs+e5yt3rUAkFSWGxAReKHnWz8E7m1kmOc9zG/I5OTj27rCwWhk
        ryDp5uYSGQua6tOsOrw8Aps7qdOcKlPI1s2zzKHBoB5J3mX5RaHsDE+h2z7CkBei7nK7Su
        NqUeyGAih1ooXCNCkDj2++mRmEEdby+SMo9fjHnXFm0z30hWWQGbI2K2ElWvPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKUD652qEqq/h2PfUER+Dah0Y3gklh6mO5qTzyZc3oY=;
        b=mevbT+AJsYmDtPmErH/mxQKUV1NO9R+jUoN9HAvDgBN1C+21kT4lDfmIcUymuc7xgHYgen
        JoauDRkeT+awvfDA==
Date:   Thu, 05 Aug 2021 17:13:39 +0200
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
Subject: [patch V3 39/64] locking/ww_mutex: Split up ww_mutex_unlock()
References: <20210805151300.330412127@linutronix.de>
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

