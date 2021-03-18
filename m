Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B3340BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhCRR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhCRR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZusXoMZDaE3Bt2kUKTCnzrcY35m3DzalMZ8qsnjHCWA=;
        b=KE8RlwVEpotFlMss8XftGbNagPgDgSxbGRvGdSLi1hJYaKR20H1vjIEPhxoX560Z9FebnJ
        xxKWlTVfvjt6Xtw2ES4MbVGQHFNnP6E7DEvbifQ5xAyGLzLaGlduwOQAD5SLPKpOinTjXf
        ra43PYBQtEsR5vVTl44oB3WlfdGg7/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-Czyxrn28O7OUwcB1ID7M3A-1; Thu, 18 Mar 2021 13:28:39 -0400
X-MC-Unique: Czyxrn28O7OUwcB1ID7M3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2A910168C7;
        Thu, 18 Mar 2021 17:28:37 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98DC25D6A8;
        Thu, 18 Mar 2021 17:28:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 2/5] locking/locktorture: Fix false positive circular locking splat in ww_mutex test
Date:   Thu, 18 Mar 2021 13:28:11 -0400
Message-Id: <20210318172814.4400-3-longman@redhat.com>
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid false positive circular locking lockdep splat
when runnng the ww_mutex torture test, we need to make sure that
the ww_mutexes have the same lock class as the acquire_ctx. This
means the ww_mutexes must have the same lockdep key as the
acquire_ctx. Unfortunately the current DEFINE_WW_MUTEX() macro fails
to do that. As a result, we add an init method for the ww_mutex test
to do explicit ww_mutex_init()'s of the ww_mutexes to avoid the false
positive warning.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/locktorture.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 0ab94e1f1276..3c27f43ab3e8 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -357,10 +357,20 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
+/*
+ * The torture ww_mutexes should belong to the same lock class as
+ * torture_ww_class to avoid lockdep problem. The ww_mutex_init()
+ * function is called for initialization to ensure that.
+ */
 static DEFINE_WD_CLASS(torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
+static struct ww_mutex torture_ww_mutex_0, torture_ww_mutex_1, torture_ww_mutex_2;
+
+static void torture_ww_mutex_init(void)
+{
+	ww_mutex_init(&torture_ww_mutex_0, &torture_ww_class);
+	ww_mutex_init(&torture_ww_mutex_1, &torture_ww_class);
+	ww_mutex_init(&torture_ww_mutex_2, &torture_ww_class);
+}
 
 static int torture_ww_mutex_lock(void)
 __acquires(torture_ww_mutex_0)
@@ -418,6 +428,7 @@ __releases(torture_ww_mutex_2)
 }
 
 static struct lock_torture_ops ww_mutex_lock_ops = {
+	.init		= torture_ww_mutex_init,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
-- 
2.18.1

