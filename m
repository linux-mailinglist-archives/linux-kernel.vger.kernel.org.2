Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF0340BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhCRR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhCRR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kati+3lR7e32NnwVgM+5Ff6p8bWZG0ckkiG5fyAh1vk=;
        b=Zzig2FAnXy4CaCD0kpSN8gfVh1+arySkVGx/6mP3EKz40e05rpWOQ9wXe7aN6cY//Mq1XX
        NHNbg9qM4sS9UKAfSnV6JQtvXMe4GGJKD/j6skr2TZUsd2CWiMW/LBTxe1hvnFZ4o5gMNg
        mdfTfRZGqYcMhXjIqzaIyfC/UNr+Rbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-ulG23zIHMBaO9GWBWCUu6w-1; Thu, 18 Mar 2021 13:28:38 -0400
X-MC-Unique: ulG23zIHMBaO9GWBWCUu6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAF1107ACCA;
        Thu, 18 Mar 2021 17:28:36 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 524665D6A8;
        Thu, 18 Mar 2021 17:28:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 1/5] locking/ww_mutex: Revert "Treat ww_mutex_lock() like a trylock"
Date:   Thu, 18 Mar 2021 13:28:10 -0400
Message-Id: <20210318172814.4400-2-longman@redhat.com>
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that treating ww_mutex_lock() as a trylock will fail to catch
real deadlock hazard like:

	mutex_lock(&A);			ww_mutex_lock(&B, ctx);
	ww_mutex_lock(&B, ctx);		mutex_lock(&A);

The current lockdep code should be able to handle mixed lock ordering
of ww_mutexes as long as

 1) there is a top level nested lock that is acquired before hand, and
 2) the nested lock and the ww_mutex are of the same lock class.

Any ww_mutex use cases that do not provide the above guarantee will
have to be modified to avoid lockdep problem.

Revert the previous commit b058f2e4d0a7 ("locking/ww_mutex: Treat
ww_mutex_lock() like a trylock").

Fixes: commit b058f2e4d0a7 ("locking/ww_mutex: Treat ww_mutex_lock() like a trylock")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mutex.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index bb89393cd3a2..622ebdfcd083 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -946,10 +946,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	preempt_disable();
-	/*
-	 * Treat as trylock for ww_mutex.
-	 */
-	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
-- 
2.18.1

