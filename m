Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD933D78E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhCPPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237948AbhCPPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615908725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=5lg9c5Rv+OApLdaRlqwCByn2jVsrPFVsUvLb5FWI36k=;
        b=K7aDVNGrYx8IRmWb1++9yEzw0I2JF+DohOMjBqJX4qyTP/1ZNGBQURuLNBjDS7rCb32GDz
        ioZEMVbtAwaBSu68/5twFJhMxkzj+2Abuqipa8SNox9LHXCZZfJoH+HhiS5AEIXY3a5Ut9
        27+2CNI3tyvISJkdbiRtqdhXpQ6aZNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-fIiQkzqFMAiWKhVqnxO_9Q-1; Tue, 16 Mar 2021 11:32:02 -0400
X-MC-Unique: fIiQkzqFMAiWKhVqnxO_9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 454B73E741;
        Tue, 16 Mar 2021 15:32:01 +0000 (UTC)
Received: from llong.com (ovpn-117-133.rdu2.redhat.com [10.10.117.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6AA19706;
        Tue, 16 Mar 2021 15:32:00 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/4] locking/ww_mutex: Treat ww_mutex_lock() like a trylock
Date:   Tue, 16 Mar 2021 11:31:18 -0400
Message-Id: <20210316153119.13802-4-longman@redhat.com>
In-Reply-To: <20210316153119.13802-1-longman@redhat.com>
References: <20210316153119.13802-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that running the ww_mutex_lock-torture test produced the
following lockdep splat almost immediately:

[  103.892638] ======================================================
[  103.892639] WARNING: possible circular locking dependency detected
[  103.892641] 5.12.0-rc3-debug+ #2 Tainted: G S      W
[  103.892643] ------------------------------------------------------
[  103.892643] lock_torture_wr/3234 is trying to acquire lock:
[  103.892646] ffffffffc0b35b10 (torture_ww_mutex_2.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892660]
[  103.892660] but task is already holding lock:
[  103.892661] ffffffffc0b35cd0 (torture_ww_mutex_0.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x3e2/0x720 [locktorture]
[  103.892669]
[  103.892669] which lock already depends on the new lock.
[  103.892669]
[  103.892670]
[  103.892670] the existing dependency chain (in reverse order) is:
[  103.892671]
[  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
[  103.892675]        lock_acquire+0x1c5/0x830
[  103.892682]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892687]        ww_mutex_lock+0x4b/0x180
[  103.892690]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892694]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892698]        kthread+0x35f/0x430
[  103.892701]        ret_from_fork+0x1f/0x30
[  103.892706]
[  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
[  103.892709]        lock_acquire+0x1c5/0x830
[  103.892712]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892715]        ww_mutex_lock+0x4b/0x180
[  103.892717]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892721]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892725]        kthread+0x35f/0x430
[  103.892727]        ret_from_fork+0x1f/0x30
[  103.892730]
[  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:
[  103.892733]        check_prevs_add+0x3fd/0x2470
[  103.892736]        __lock_acquire+0x2602/0x3100
[  103.892738]        lock_acquire+0x1c5/0x830
[  103.892740]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
[  103.892743]        ww_mutex_lock+0x4b/0x180
[  103.892746]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
[  103.892749]        lock_torture_writer+0x142/0x3a0 [locktorture]
[  103.892753]        kthread+0x35f/0x430
[  103.892755]        ret_from_fork+0x1f/0x30
[  103.892757]
[  103.892757] other info that might help us debug this:
[  103.892757]
[  103.892758] Chain exists of:
[  103.892758]   torture_ww_mutex_2.base --> torture_ww_mutex_1.base --> torture_ww_mutex_0.base
[  103.892758]
[  103.892763]  Possible unsafe locking scenario:
[  103.892763]
[  103.892764]        CPU0                    CPU1
[  103.892765]        ----                    ----
[  103.892765]   lock(torture_ww_mutex_0.base);
[  103.892767] 				      lock(torture_ww_mutex_1.base);
[  103.892770] 				      lock(torture_ww_mutex_0.base);
[  103.892772]   lock(torture_ww_mutex_2.base);
[  103.892774]
[  103.892774]  *** DEADLOCK ***

Since ww_mutex is supposed to be deadlock-proof if used properly, such
deadlock scenario should not happen. To avoid this false positive splat,
treat ww_mutex_lock() like a trylock().

After applying this patch, the locktorture test can run for a long time
without triggering the circular locking dependency splat.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 622ebdfcd083..bb89393cd3a2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -946,7 +946,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	preempt_disable();
-	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+	/*
+	 * Treat as trylock for ww_mutex.
+	 */
+	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);
 
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
-- 
2.18.1

