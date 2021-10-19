Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7C432B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhJSAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhJSAKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2D761350;
        Tue, 19 Oct 2021 00:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602117;
        bh=fLn6ocTx+EWXy4W8OwuxYR9lzwO3sB18/WU7q3DT7N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmvnEs53fr7xd+DsBJmpm16OHymFltUE9MjwF45FApHFSP46172kMNRtqrPoh/7hu
         ClDCiTJfSo+nDbB+j5U+xeeKizaZXBRyEUr/MbKRjrlPhLGhKvHkz9R3JAo06JOqj9
         AQHo+bwiY1QtYzS3B33pxxChyI05OOf5dyb+WphzAUP4oNNvY1LxOsDlOiPFVX1lJo
         yZra795hj2t74H3o4+b3syBfx3o/o8wOaAeOggk/VJQGFs800I3xoYl8P3c3qDX98N
         evm+i+4x6a6JmZ/WzEFgO6JoJtAsQh+0JDSjZ1YQtstuRpTbfokKHfPIcWni14m9kG
         UDVD/JDhVOyXA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/10] rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
Date:   Tue, 19 Oct 2021 02:08:11 +0200
Message-Id: <20211019000816.455375-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not entirely obvious why rdp->qlen_last_fqs_check is updated before
processing the queue only on offloaded rdp. There can be different
effect to that, either in favour of triggering the force quiescent state
path or not. For example:

1) If the number of callbacks has decreased since the last
   rdp->qlen_last_fqs_check update (because we recently called
   rcu_do_batch() and we executed below qhimark callbacks) and the number
   of processed callbacks on a subsequent do_batch() arranges for
   exceeding qhimark on non-offloaded but not on offloaded setup, then we
   may spare a later run to the force quiescent state
   slow path on __call_rcu_nocb_wake(), as compared to the non-offloaded
   counterpart scenario.

   Here is such an offloaded scenario instance:

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 1000 callback
        rcu_segcblist_n_cbs(rdp) = 1000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // not taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 2001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 1000 and the fqs slowpath would have executed.

2) If the number of callbacks has increased since the last
   rdp->qlen_last_fqs_check update (because we recently queued below
   qhimark callbacks) and the number of callbacks executed in rcu_do_batch()
   doesn't exceed qhimark for either offloaded or non-offloaded setup,
   then it's possible that the offloaded scenario later run the force
   quiescent state slow path on __call_rcu_nocb_wake() while the
   non-offloaded doesn't.

    qhimark = 1000
    rdp->last_qlen_last_fqs_check = 3000
    rcu_segcblist_n_cbs(rdp) = 2000

    rcu_do_batch() {
        if (offloaded)
            rdp->last_qlen_last_fqs_check = rcu_segcblist_n_cbs(rdp) // 2000
        // run 100 callbacks
        // concurrent queued 100
        rcu_segcblist_n_cbs(rdp) = 2000
        // Not updating rdp->qlen_last_fqs_check
        if (count < rdp->qlen_last_fqs_check - qhimark)
            rdp->qlen_last_fqs_check = count;
    }

    call_rcu() * 1001 {
        __call_rcu_nocb_wake() {
            // Taking the fqs slowpath:
            // rcu_segcblist_n_cbs(rdp) == 3001
            // rdp->qlen_last_fqs_check == 2000
            // qhimark == 1000
            if (len > rdp->qlen_last_fqs_check + qhimark)
                ...
    }

    In the case of a non-offloaded scenario, rdp->qlen_last_fqs_check
    would be 3000 and the fqs slowpath would have executed.

The reason for updating rdp->qlen_last_fqs_check when invoking callbacks
for offloaded CPUs is that there is usually no point in waking up either
the rcuog or rcuoc kthreads while in this state.  After all, both threads
are prohibited from indefinite sleeps.

The exception is when some huge number of callbacks are enqueued while
rcu_do_batch() is in the midst of invoking, in which case interrupting
the rcuog kthread's timed sleep might get more callbacks set up for the
next grace period.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Original-patch-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a43924244000..27500981d4b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2508,7 +2508,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-	if (offloaded)
+	if (rcu_rdp_is_offloaded(rdp))
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
-- 
2.25.1

