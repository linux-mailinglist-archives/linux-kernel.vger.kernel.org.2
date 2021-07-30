Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314523DBA79
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbhG3OX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbhG3ORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F5C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:48 -0700 (PDT)
Message-ID: <20210730135207.258152319@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=TKY7BU27/vWhcWqv7hX7qFVpFiKVqBLiPcCcnaUjQPZgwVrIMGsXOcW+1ecR1+DAtQqAIz
        0eL+CS9zvicfIZtEAe72BuffjTwL/Brr6AMkjZJE4xnIdg1Sd/eC4tweDNy4XuzEXpFzh3
        ULoZNvsACgqZqOIJx+dwHkE299TPCr4cDtVwWq8c9DMP1qaxvEeSNaXy7+JaUqR2o1ldM4
        4tj6qNw6nMl9sF2LxKFDKJr2nDNzjYLRxD7iQofT27R1QzSt3Yt5RACeCoieJEq5zHnMVh
        7ekEsgyWqUtYD0DVmNnTdnnMa2NLHhhyUeY7JeCoCE2uk4lgMVIG5FoIdPx8Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=cY4xGQMoNu1/Wt1FcR9txNyaQxjU/JoUBs8BMK1XOrmr0vNBpyeWqj8j24/NURmwRk7upx
        K54VsRSfXuWyFyBg==
Date:   Fri, 30 Jul 2021 15:50:44 +0200
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
Subject: [patch 37/63] locking/ww_mutex: Gather mutex_waiter initialization
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/mutex-debug.c |    1 +
 kernel/locking/mutex.c       |   12 +++---------
 2 files changed, 4 insertions(+), 9 deletions(-)
---
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -30,6 +30,7 @@ void debug_mutex_lock_common(struct mute
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
+	waiter->ww_ctx = MUTEX_POISON_WW_CTX;
 }
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -980,17 +980,15 @@ static __always_inline int __sched
 	}
 
 	debug_mutex_lock_common(lock, &waiter);
+	waiter.task = current;
+	if (ww_ctx)
+		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
 
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
-
-
-#ifdef CONFIG_DEBUG_MUTEXES
-		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
-#endif
 	} else {
 		/*
 		 * Add in stamp order, waking up waiters that must kill
@@ -999,12 +997,8 @@ static __always_inline int __sched
 		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
-
-		waiter.ww_ctx = ww_ctx;
 	}
 
-	waiter.task = current;
-
 	set_current_state(state);
 	for (;;) {
 		/*

