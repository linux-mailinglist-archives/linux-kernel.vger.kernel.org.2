Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC993B8669
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhF3Pos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbhF3Pom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:44:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB2C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dxR9ukSOwJyqIa3HUHGmgbEdSwL7D1JcPCim4eS+28Y=; b=McWVf+SbtkMbSGoIK+jqkLF7iX
        WtFBCWlDF9r8HUNkI6/MYReFDlvoPyS3sOZthg00Nm2fPptTjEgM6QjndchJPqFilED/zhQutHlqV
        5AX12FhU997Rsi9RWXBBpeNNx3Fi9MV3tDbzLeWMbBNeKUZeqUjJJjObsShHyzraMzWZQ2BOoM1wa
        CpMJ1uYcfaxRNRg8TB2rCU/45i5eEJJ6CmiLOnTA7Q5Y+C9WPWKuzaDz/HjeeaTwZh0vDjYufP7yo
        RHz7duYmwW3dyxTj4Udm5C1fabZHqKv46/izAaz+BjzldHTCS2LnU85tHMr+RQr55L4k/afVZNdCH
        CKTfn1uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lycLn-00DD5Y-6C; Wed, 30 Jun 2021 15:42:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56B2B30031C;
        Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3AEF72C7151A1; Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Message-ID: <20210630154115.020298650@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 17:35:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        yanfei.xu@windriver.com
Subject: [RFC][PATCH 4/4] locking/mutex: Add MUTEX_WARN_ON
References: <20210630153516.832731403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup some #ifdef'fery.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/mutex.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -32,8 +32,10 @@
 
 #ifdef CONFIG_DEBUG_MUTEXES
 # include "mutex-debug.h"
+# define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
 #else
 # include "mutex.h"
+# define MUTEX_WARN_ON(cond)
 #endif
 
 void
@@ -113,9 +115,7 @@ static inline struct task_struct *__mute
 				break;
 			}
 		} else {
-#ifdef CONFIG_DEBUG_MUTEXES
-			DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
-#endif
+			MUTEX_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
 			task = curr;
 		}
 
@@ -236,10 +236,8 @@ static void __mutex_handoff(struct mutex
 	for (;;) {
 		unsigned long new;
 
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) != current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
 		new = (owner & MUTEX_FLAG_WAITERS);
 		new |= (unsigned long)task;
@@ -764,9 +762,7 @@ void __sched ww_mutex_unlock(struct ww_m
 	 * into 'unlocked' state:
 	 */
 	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
-#endif
+		MUTEX_WARN_ON(!lock->ctx->acquired);
 		if (lock->ctx->acquired > 0)
 			lock->ctx->acquired--;
 		lock->ctx = NULL;
@@ -941,9 +937,7 @@ __mutex_lock_common(struct mutex *lock,
 
 	might_sleep();
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-#endif
+	MUTEX_WARN_ON(lock->magic != lock);
 
 	ww = container_of(lock, struct ww_mutex, base);
 	if (ww_ctx) {
@@ -1235,10 +1229,8 @@ static noinline void __sched __mutex_unl
 	 */
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) != current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
@@ -1404,9 +1396,7 @@ int __sched mutex_trylock(struct mutex *
 {
 	bool locked;
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-#endif
+	MUTEX_WARN_ON(lock->magic != lock);
 
 	locked = __mutex_trylock(lock);
 	if (locked)


