Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97CA340BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhCRR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhCRR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=waGAHDJmcYNLn1hxKaS6CLKhC4HU53XpmhouRWoWeKo=;
        b=I90pUjXYX4fQC01S1wruP+f0Uwe+ifhg+R1ZRBoSQ65fZ5AtNpvEAf3LWCvxELOdm2mvOZ
        LTjq4iG663+83NoTXGRcXlu9n0VYQDCE+HhEjxQLkbUEDDzUd8n2YckQssEn0IWfFWboz2
        8sVub71RvwImgUpMsB6dDuBTqpUvt4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-fudAaJpBPEmTiidNgo9Waw-1; Thu, 18 Mar 2021 13:28:40 -0400
X-MC-Unique: fudAaJpBPEmTiidNgo9Waw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F42056E3AC;
        Thu, 18 Mar 2021 17:28:38 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA8185D71F;
        Thu, 18 Mar 2021 17:28:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 3/5] locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
Date:   Thu, 18 Mar 2021 13:28:12 -0400
Message-Id: <20210318172814.4400-4-longman@redhat.com>
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current DEFINE_WW_MUTEX() macro fails to properly set up the lockdep
key of the ww_mutexes causing potential circular locking dependency
splat. Though it is possible to add more macro magic to make it work,
but the result is rather ugly.

Since locktorture was the only user of DEFINE_WW_MUTEX() and the
previous commit has just removed its use. It is easier to just remove
the macro to force future users of ww_mutexes to use ww_mutex_init()
for initialization.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ww_mutex.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 6ecf2a0220db..b77f39f319ad 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -48,39 +48,26 @@ struct ww_acquire_ctx {
 #endif
 };
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __WW_CLASS_MUTEX_INITIALIZER(lockname, class) \
-		, .ww_class = class
-#else
-# define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
-#endif
-
 #define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
 		{ .stamp = ATOMIC_LONG_INIT(0) \
 		, .acquire_name = #ww_class "_acquire" \
 		, .mutex_name = #ww_class "_mutex" \
 		, .is_wait_die = _is_wait_die }
 
-#define __WW_MUTEX_INITIALIZER(lockname, class) \
-		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
-		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
-
 #define DEFINE_WD_CLASS(classname) \
 	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
 
 #define DEFINE_WW_CLASS(classname) \
 	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
 
-#define DEFINE_WW_MUTEX(mutexname, ww_class) \
-	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
-
 /**
  * ww_mutex_init - initialize the w/w mutex
  * @lock: the mutex to be initialized
  * @ww_class: the w/w class the mutex should belong to
  *
  * Initialize the w/w mutex to unlocked state and associate it with the given
- * class.
+ * class. Static define macro for w/w mutex is not provided and this function
+ * is the only way to properly initialize the w/w mutex.
  *
  * It is not allowed to initialize an already locked mutex.
  */
-- 
2.18.1

