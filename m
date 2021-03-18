Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F5340BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhCRR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhCRR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MKTrxMLfoa+TFhtbx9BBf8vrzmeXw9NoUHAs2FfLwfc=;
        b=W81EAPyVKgoXeH0bzyKQMIfstbWiYwjBjAtnnI/NSH8PQQU+gVO50Z60QsjUtC7xEoVxE7
        TE7AzF0vL4ETfMRQKosNG+xiiFXlrGKFd7omFXOAjsITYaunElg+Z6i8RUQsdOBYQ7VlQM
        znL7axKvebvKITPc/Mjna1dMMbUX4PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-KJbGqldJMvSDA_92LEYqoQ-1; Thu, 18 Mar 2021 13:28:43 -0400
X-MC-Unique: KJbGqldJMvSDA_92LEYqoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9967C1926DA3;
        Thu, 18 Mar 2021 17:28:41 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85BCF5D6A8;
        Thu, 18 Mar 2021 17:28:40 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 5/5] locking/locktorture: locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test
Date:   Thu, 18 Mar 2021 13:28:14 -0400
Message-Id: <20210318172814.4400-6-longman@redhat.com>
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww_acquire_ctx structure for ww_mutex needs to persist for a complete
lock/unlock cycle. In the ww_mutex test in locktorture, however, both
ww_acquire_init() and ww_acquire_fini() are called within the lock
function only. This causes a lockdep splat of "WARNING: Nested lock
was not taken" when lockdep is enabled in the kernel.

To fix this problem, we need to move the ww_acquire_fini() after
the ww_mutex_unlock() in torture_ww_mutex_unlock(). This is done by
allocating a global array of ww_acquire_ctx structures. Each locking
thread is associated with its own ww_acquire_ctx via the unique thread
id it has so that both the lock and unlock functions can access the
same ww_acquire_ctx structure.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/locktorture.c | 39 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 90a975a95a13..b3adb40549bf 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -374,15 +374,27 @@ static struct lock_torture_ops mutex_lock_ops = {
  */
 static DEFINE_WD_CLASS(torture_ww_class);
 static struct ww_mutex torture_ww_mutex_0, torture_ww_mutex_1, torture_ww_mutex_2;
+static struct ww_acquire_ctx *ww_acquire_ctxs;
 
 static void torture_ww_mutex_init(void)
 {
 	ww_mutex_init(&torture_ww_mutex_0, &torture_ww_class);
 	ww_mutex_init(&torture_ww_mutex_1, &torture_ww_class);
 	ww_mutex_init(&torture_ww_mutex_2, &torture_ww_class);
+
+	ww_acquire_ctxs = kmalloc_array(cxt.nrealwriters_stress,
+					sizeof(*ww_acquire_ctxs),
+					GFP_KERNEL);
+	if (!ww_acquire_ctxs)
+		VERBOSE_TOROUT_STRING("ww_acquire_ctx: Out of memory");
+}
+
+static void torture_ww_mutex_exit(void)
+{
+	kfree(ww_acquire_ctxs);
 }
 
-static int torture_ww_mutex_lock(int tid __maybe_unused)
+static int torture_ww_mutex_lock(int tid)
 __acquires(torture_ww_mutex_0)
 __acquires(torture_ww_mutex_1)
 __acquires(torture_ww_mutex_2)
@@ -392,7 +404,7 @@ __acquires(torture_ww_mutex_2)
 		struct list_head link;
 		struct ww_mutex *lock;
 	} locks[3], *ll, *ln;
-	struct ww_acquire_ctx ctx;
+	struct ww_acquire_ctx *ctx = &ww_acquire_ctxs[tid];
 
 	locks[0].lock = &torture_ww_mutex_0;
 	list_add(&locks[0].link, &list);
@@ -403,12 +415,12 @@ __acquires(torture_ww_mutex_2)
 	locks[2].lock = &torture_ww_mutex_2;
 	list_add(&locks[2].link, &list);
 
-	ww_acquire_init(&ctx, &torture_ww_class);
+	ww_acquire_init(ctx, &torture_ww_class);
 
 	list_for_each_entry(ll, &list, link) {
 		int err;
 
-		err = ww_mutex_lock(ll->lock, &ctx);
+		err = ww_mutex_lock(ll->lock, ctx);
 		if (!err)
 			continue;
 
@@ -419,26 +431,29 @@ __acquires(torture_ww_mutex_2)
 		if (err != -EDEADLK)
 			return err;
 
-		ww_mutex_lock_slow(ll->lock, &ctx);
+		ww_mutex_lock_slow(ll->lock, ctx);
 		list_move(&ll->link, &list);
 	}
 
-	ww_acquire_fini(&ctx);
 	return 0;
 }
 
-static void torture_ww_mutex_unlock(int tid __maybe_unused)
+static void torture_ww_mutex_unlock(int tid)
 __releases(torture_ww_mutex_0)
 __releases(torture_ww_mutex_1)
 __releases(torture_ww_mutex_2)
 {
+	struct ww_acquire_ctx *ctx = &ww_acquire_ctxs[tid];
+
 	ww_mutex_unlock(&torture_ww_mutex_0);
 	ww_mutex_unlock(&torture_ww_mutex_1);
 	ww_mutex_unlock(&torture_ww_mutex_2);
+	ww_acquire_fini(ctx);
 }
 
 static struct lock_torture_ops ww_mutex_lock_ops = {
 	.init		= torture_ww_mutex_init,
+	.exit		= torture_ww_mutex_exit,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
@@ -924,16 +939,16 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init) {
-		cxt.cur_ops->init();
-		cxt.init_called = true;
-	}
-
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
 	else
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
+	if (cxt.cur_ops->init) {
+		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
-- 
2.18.1

