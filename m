Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7205432B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhJSAKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234015AbhJSAKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9BAB6128B;
        Tue, 19 Oct 2021 00:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602111;
        bh=ViTp2jIMens7hopgg9RgvB7hsFRzd0DdA+WKqwt/ZJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIXbPvlY3tkhbejR2axAhP8O6CZYub5Y2lMTODLWyY18zLUt40SBNt2x9LpDm8l3e
         T75k2yMqNHIg1KYWr4aszOn71JGM/wMNyYWhmLAMSOAeh1eLg38FxMSno8wTAM8dCL
         Cv+NJi2ymrn0JUlwlgcoBlCa3z2XJTXotNyhEQT/qk+9P/Xc+QriPlbbLwgouZi1sK
         EQOfBdl/JXg+szHT3FKzX3gOmHBsBZRH/ztCXS2On+F5Yi1mWToK5d8dwMK0TEtafg
         3wafqeLQBTOz5yagEyl5+OJ0MHo4goL8IMman3LgjriVjhg8PMpE58k4eWBbrNNeGr
         mCmgi6YKO/2QQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/10] rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
Date:   Tue, 19 Oct 2021 02:08:09 +0200
Message-Id: <20211019000816.455375-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

While reporting a quiescent state for a given CPU, rcu_core() takes
advantage of the freshly loaded grace period sequence number and the
locked rnp to accelerate the callbacks whose sequence number have been
assigned a stale value.

This action is only necessary when the rdp isn't offloaded, otherwise
the NOCB kthreads already take care of the callbacks progression.

However the check for the offloaded state is volatile because it is
performed outside the IRQs disabled section. It's possible for the
offloading process to preempt rcu_core() at that point on PREEMPT_RT.

This is dangerous because rcu_core() may end up accelerating callbacks
concurrently with NOCB kthreads without appropriate locking.

Fix this with moving the offloaded check inside the rnp locking section.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b236271b9022..4869a6856bf1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2288,7 +2288,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2315,8 +2314,10 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		/*
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
+		 *
+		 * NOCB kthreads have their own way to deal with that.
 		 */
-		if (!offloaded)
+		if (!rcu_rdp_is_offloaded(rdp))
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
 		rcu_disable_urgency_upon_qs(rdp);
-- 
2.25.1

