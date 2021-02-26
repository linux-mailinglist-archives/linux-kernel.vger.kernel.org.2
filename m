Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86832667E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBZRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:52:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhBZRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:51:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C637AFE6;
        Fri, 26 Feb 2021 17:51:06 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/4] kernel/futex: Move hb unlock out of unqueue_me_pi()
Date:   Fri, 26 Feb 2021 09:50:28 -0800
Message-Id: <20210226175029.50335-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226175029.50335-1-dave@stgolabs.net>
References: <20210226175029.50335-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves the code readability, and the locking more obvious
as it becomes symmetric for the caller.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ee09995d707b..dcd6132485e1 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2318,19 +2318,15 @@ static int unqueue_me(struct futex_q *q)
 
 /*
  * PI futexes can not be requeued and must remove themself from the
- * hash bucket. The hash bucket lock (i.e. lock_ptr) is held on entry
- * and dropped here.
+ * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
 static void unqueue_me_pi(struct futex_q *q)
-	__releases(q->lock_ptr)
 {
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
 	q->pi_state = NULL;
-
-	spin_unlock(q->lock_ptr);
 }
 
 static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2913,8 +2909,8 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	if (res)
 		ret = (res < 0) ? res : 0;
 
-	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
+	spin_unlock(q.lock_ptr);
 	goto out;
 
 out_unlock_put_key:
@@ -3290,8 +3286,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (res)
 			ret = (res < 0) ? res : 0;
 
-		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
+		spin_unlock(q.lock_ptr);
 	}
 
 	if (ret == -EINTR) {
-- 
2.26.2

