Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3143DBA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhG3OWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbhG3ORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:53 -0400
Message-ID: <20210730135207.202820213@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kP+wkGEMMhh4ymI0Nk33oRqOuFFrSS5KxvL/8gBf+/Q=;
        b=TkYdzjWy/UDc647+1K1h0OF/I/WChqLpDCJOFW2qSYPEJYmV8HESqpiiCS1WN9BtEIO/SN
        Xe/jyOxod9+o9FY7V+Ux0G9NyheYZ/QnXZDGMtdI4kz53RvN5kK3UeHBaIHZkkebQ+RH0u
        KrW9Agt5cOIcwh/CDK5nteOO8xQRQ9AuacM8ZpS38hZJDSPSiW/ddHCT3nAOsrbJh20nbR
        Si6eHmXJKmNKRIrW4kiBnGeknMApo7fM8oRqx2h8v2kY02ei6B5q6T1YPRt8ksEftn8Px1
        JvbpmkCqkZSG5H++O9hv0H/6NxIoMRzZz3h0Rn4mb0TQhEOZ2LVCwkiXOOY5Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kP+wkGEMMhh4ymI0Nk33oRqOuFFrSS5KxvL/8gBf+/Q=;
        b=/+cO+K0KTUogYdRyvMBgFYSRg3zBbBc2T8BLGi1HAASEsKtlnohvAo4Z01byU9gSRSyzzC
        its+8/VDQjgvrWBg==
Date:   Fri, 30 Jul 2021 15:50:43 +0200
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
Subject: [patch 36/63] locking/ww_mutex: Simplify lockdep annotation
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No functional change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/mutex.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)
---
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -949,6 +949,10 @@ static __always_inline int __sched
 		 */
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
 	}
 
 	preempt_disable();
@@ -1102,10 +1106,9 @@ static int __sched
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
-		struct lockdep_map *nest_lock, unsigned long ip,
-		struct ww_acquire_ctx *ww_ctx)
+		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1185,8 +1188,7 @@ ww_mutex_lock(struct ww_mutex *lock, str
 
 	might_sleep();
 	ret =  __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE,
-			       0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			       ctx);
+			       0, _RET_IP_, ctx);
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
 
@@ -1201,8 +1203,7 @@ ww_mutex_lock_interruptible(struct ww_mu
 
 	might_sleep();
 	ret = __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE,
-			      0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			      ctx);
+			      0, _RET_IP_, ctx);
 
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
@@ -1376,7 +1377,7 @@ static noinline int __sched
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 
@@ -1384,7 +1385,7 @@ static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 					    struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 

