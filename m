Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F03E1875
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhHEPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbhHEPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00BC061384
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:42:04 -0700 (PDT)
Message-ID: <20210805153955.023328409@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=JXtSRO6Byd9N3CwXT5lHfuEyPKWmHHLtXDbK9iN0ta2PGY+6XSX8+ooPJLhmiblGCZjtAK
        DdNH7nCpXhGkYuTUNZMIyx/GJMynng+tqoht9DaTHrILqiX5l1VFW5BhGXwdn9kam+2/+g
        QNlY4DlNBghEqZ+0AxmAgfLXr1qivPjhMQ46vOi3EpCE3zW7ii9Yj0LUYo21CvkFTJ+fh4
        lglZqcpKDo5zIUXx3Ah9cjSNGoENITUq+9wb91hDdbm4nPRNasLvYs0UuIhieuBZe7e0nL
        p9bIskbmWDH+mvEdwiZApXT+oVCwfzmrfqmEnOpLZX5Aq8jSJPcL77hOTcDVeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NJxRI30XqhVh8/VqD5+ZkYUWJvNUwWO5e2tTeZWJUgs=;
        b=BbBej3fnQCQeGT6yc96lFOOTFemy2YUXJ/H8J+G5plx7/dUy1zn8lhW5Winb5kB9+YmFXM
        kDyPy/4TdAjUnSDQ==
Date:   Thu, 05 Aug 2021 17:13:38 +0200
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
Subject: [patch V3 38/64] locking/ww_mutex: Gather mutex_waiter initialization
References: <20210805151300.330412127@linutronix.de>
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

