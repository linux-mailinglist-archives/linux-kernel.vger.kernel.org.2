Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E33B866C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhF3PpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhF3PpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:45:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA2C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2hdvY05lg7IflWRpLH9FzHf5vvhAFMGhIYa0tWNvg7g=; b=KWNzHn2/tsqup0QHYcOrnwl4Lg
        wNWgle6r4VMVzt2EMv43rnIs6CLXdjqXfxoFIiQtIXiOKQV587gPk/rbUzvOuWsT52tNHFuXg0lZr
        HmMh/02OTmw44wTGpoErMckaktDriFn6RhNgC+JMWn7r067zJCKVAn0gsTewIJylj1Cm+DW126wBN
        GzZgVZLC13HiXyS3QYWCcL5ZllJBD69EYVRMIQYNo0Qnd1YBxcy6bhohWnAQet2Kj34ME2GqYDOeK
        6UebwAt2h9JU/VZvUgLcGGcEdAoc9ysu/GRcmBk70B7khuX23wGOOybJ/3pg5vap98i32Z6WCnXCO
        Qb9GyuXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lycLo-005Vpa-Fy; Wed, 30 Jun 2021 15:42:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490973002D3;
        Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2EECD2C59D76E; Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Message-ID: <20210630154114.834438545@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 17:35:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        yanfei.xu@windriver.com
Subject: [RFC][PATCH 1/4] locking/mutex: Use try_cmpxchg()
References: <20210630153516.832731403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For simpler and better code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/mutex.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -100,7 +100,7 @@ static inline struct task_struct *__mute
 
 	owner = atomic_long_read(&lock->owner);
 	for (;;) { /* must loop, can race against a flag */
-		unsigned long old, flags = __owner_flags(owner);
+		unsigned long flags = __owner_flags(owner);
 		unsigned long task = owner & ~MUTEX_FLAGS;
 
 		if (task) {
@@ -124,11 +124,8 @@ static inline struct task_struct *__mute
 		 */
 		flags &= ~MUTEX_FLAG_HANDOFF;
 
-		old = atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
-		if (old == owner)
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, curr | flags))
 			return NULL;
-
-		owner = old;
 	}
 
 	return __owner_task(owner);
@@ -168,10 +165,7 @@ static __always_inline bool __mutex_unlo
 {
 	unsigned long curr = (unsigned long)current;
 
-	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
-		return true;
-
-	return false;
+	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
 #endif
 
@@ -226,7 +220,7 @@ static void __mutex_handoff(struct mutex
 	unsigned long owner = atomic_long_read(&lock->owner);
 
 	for (;;) {
-		unsigned long old, new;
+		unsigned long new;
 
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
@@ -238,11 +232,8 @@ static void __mutex_handoff(struct mutex
 		if (task)
 			new |= MUTEX_FLAG_PICKUP;
 
-		old = atomic_long_cmpxchg_release(&lock->owner, owner, new);
-		if (old == owner)
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, new))
 			break;
-
-		owner = old;
 	}
 }
 
@@ -1237,8 +1228,6 @@ static noinline void __sched __mutex_unl
 	 */
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
-		unsigned long old;
-
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
 		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
@@ -1247,16 +1236,12 @@ static noinline void __sched __mutex_unl
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
 
-		old = atomic_long_cmpxchg_release(&lock->owner, owner,
-						  __owner_flags(owner));
-		if (old == owner) {
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, __owner_flags(owner))) {
 			if (owner & MUTEX_FLAG_WAITERS)
 				break;
 
 			return;
 		}
-
-		owner = old;
 	}
 
 	spin_lock(&lock->wait_lock);


