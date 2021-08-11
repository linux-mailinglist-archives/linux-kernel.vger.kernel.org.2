Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D133E90D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhHKMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhHKMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:43 -0400
Message-ID: <20210811121416.473109118@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=SdC/hJMFTOPQSrDDwjlm99PLvZamcO8xK7EZZS+RtN35hLFcOV6eUtDoHzQnlGG/+L6UL+
        J667nO2SwG45G+bIQpDrsN3kiSXfSn9pefy/do+JG31AdS10XUlZwouE8AMcUjkx/fkM9o
        9yj2MzAbIVGT67T+AukPCYz2C3kEYd6IPjsW2OmjgbRxJHwHgBHtdQIpqTlxY+LAjozlKd
        OWbAVMYkgCib/YIW6HH8S1dYBXoE8Fr7l48GEh0+JxXCkAJQWVY5YZURU7gwn4KKzM46c3
        +RSj3ypL3nA06+btusm6LlPY1MI8ttSvtP6WxfoX0DmZpoW7X6BLvOtZrscubw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=UUrnZlO9ewWYV5VAZLqMMUWjfrj44Caw7KuuekU2QRgCle8N0bL/npivdkCrbaeA/C5Xs5
        +Bk6y91RysPRIxBg==
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
Subject: [patch V4 39/68] locking/ww_mutex: Gather mutex_waiter initialization
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:18 +0200 (CEST)
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

