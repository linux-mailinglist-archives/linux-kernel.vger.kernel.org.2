Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85133AAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCOFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:03:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhCOFCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:02:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B2E0AE1F;
        Mon, 15 Mar 2021 05:02:53 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] futex: Leave the pi lock stealer in a consistent state upon successful fault
Date:   Sun, 14 Mar 2021 22:02:24 -0700
Message-Id: <20210315050224.107056-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315050224.107056-1-dave@stgolabs.net>
References: <20210315050224.107056-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before 34b1a1ce145 (futex: Handle faults correctly for PI futexes) any
concurrent pi_state->owner fixup would assume that the task that fixed
things on our behalf also correctly updated the userspace value. This
is not always the case anymore, and can result in scenarios where a lock
stealer returns a successful FUTEX_PI_LOCK operation but raced during a fault
with an enqueued top waiter in an immutable state so the uval TID was
not updated for the stealer, breaking otherwise expected (and valid)
semantics and confusing the stealer task:

with pi_state->owner == victim.

victim							stealer
futex_lock_pi() {
  queue_me(&q, hb);
  rt_mutex_timed_futex_lock() {
							futex_lock_pi() {
							  // lock steal
							  rt_mutex_timed_futex_lock();
    // timeout
  }

  spin_lock(q.lock_ptr);
  fixup_owner(!locked) {
    fixup_pi_state_owner(NULL) {
      oldowner = pi_state->owner
      newowner = stealer;
      handle_err:
      //drop locks

      ret = fault_in_user_writeable() {			spin_lock(q.lock_ptr);
							fixup_owner(locked) {
      } // -EFAULT					    fixup_pi_state_owner(current) {
							      oldowner = pi_state->owner
							      newowner = current;
							      handle_err:
							      // drop locks
							      ret = fault_in_user_writeable() {

      // take locks
      if (pi_state->owner != oldowner) // false

      pi_state_update_owner(rt_mutex_owner());

							       } // SUCCESS
   }
   // all locks dropped					       // take locks
							       if (pi_state->owner != oldowner) // success
}								 return 1;

This leaves: (pi_state == pi_mutex owner == stealer) AND (uval TID == victim).

This patch proposes for the lock stealer to do a retry upon seeing someone
changed pi_state->owner while all locks were dropped if the fault was
successful. This allows to self-fixup the user state of the lock, albeit
an incorrect order compared to traditionally updating userspace before
pi_state, but this is an extraordinary scenario.

For the cases of a normal fixups, this does add some unnecessary overhead
by having to deal with userspace value when things are already ok, but
this case is pretty rare and we've already given up any inch of performance
when releasing all locks, for faulting/blocking.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ded7af2ba87f..95ce10c4e33d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2460,7 +2460,6 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 
 	case -EAGAIN:
 		cond_resched();
-		err = 0;
 		break;
 
 	default:
@@ -2474,11 +2473,22 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	/*
 	 * Check if someone else fixed it for us:
 	 */
-	if (pi_state->owner != oldowner)
+	if (pi_state->owner != oldowner) {
+		/*
+		 * The change might have come from the rare immutable
+		 * state below, which leaves the userspace value out of
+		 * sync. But if we are the lock stealer and can update
+		 * the uval, do so, instead of reporting a successful
+		 * lock operation with an invalid user state.
+		 */
+		if (!err && argowner == current)
+			goto retry;
+
 		return argowner == current;
+	}
 
 	/* Retry if err was -EAGAIN or the fault in succeeded */
-	if (!err)
+	if (err == -EAGAIN || !err)
 		goto retry;
 
 	/*
-- 
2.26.2

