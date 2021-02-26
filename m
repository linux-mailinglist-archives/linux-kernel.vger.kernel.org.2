Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4BC32667D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBZRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:52:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhBZRvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:51:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34CB4ACF6;
        Fri, 26 Feb 2021 17:51:04 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/4] kernel/futex: Make futex_wait_requeue_pi() only call fixup_owner()
Date:   Fri, 26 Feb 2021 09:50:27 -0800
Message-Id: <20210226175029.50335-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226175029.50335-1-dave@stgolabs.net>
References: <20210226175029.50335-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small cleanup that allows for fixup_pi_state_owner() only to be
called from fixup_owner(), and make the requeue_pi uniformly call
fixup_owner() regardless of the state in which the fixup is actually
needed. Of course this makes the caller's first pi_state->owner != current
check redundant, but that should't really matter.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index db8002dbca7a..ee09995d707b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3241,15 +3241,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * reference count.
 	 */
 
-	/* Check if the requeue code acquired the second futex for us. */
+	/*
+	 * Check if the requeue code acquired the second futex for us and do
+	 * any pertinent fixup.
+	 */
 	if (!q.rt_waiter) {
-		/*
-		 * Got the lock. We might not be the anticipated owner if we
-		 * did a lock-steal - fix up the PI-state in that case.
-		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
 			spin_lock(q.lock_ptr);
-			ret = fixup_pi_state_owner(uaddr2, &q, current);
+			ret = fixup_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
-- 
2.26.2

