Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25903358FE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhDHWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhDHWj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 549F761165;
        Thu,  8 Apr 2021 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921557;
        bh=DissE8U3DRnE1ay9O3SVEncS+sw4x8zMMt0Y+lNb+dM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEueUkeTDI3mGLqfiBjA61G5mYhY7n7EbanRkDb/uSwKZAxOKCr7N13x06RKhnqvN
         KCvvBaMMG4ex2bRvO6Sc+L8hjfHm3rfuCw+J1PtkrhhNC5cOCLgIs5VmHVCkv7Dail
         N8hO+UXqZpYc0xlw90WIziqw0su5lsrAFt+OUANLRxFOoz/1RFiqrFnRk7OVl6KxLy
         PyekkUJbUQUjsCBuf1vFsWDsflJExQ9xrdF3q1GqS9qwzCDPOPhhs1UMK2TEnk2DWP
         neLGDIM2X2G5YX2uM0thAgEKgYiVAgujxXZDDWtpKiOpYZk2PI+4Ykzz7n8DvCKOyn
         u+/DI76spUqww==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/5] srcu: Queue a callback in case of early started poll
Date:   Fri,  9 Apr 2021 00:39:01 +0200
Message-Id: <20210408223902.6405-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408223902.6405-1-frederic@kernel.org>
References: <20210408223902.6405-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SRCU polling is used before SRCU initialization, it won't benefit
from the callback requeue performed after rcu_init_geometry() in order
to fix the node hierarchy reshuffle. This is because polling start grace
periods that don't rely on callbacks. Therefore the grace period started
may be lost upon srcu_init().

To fix this, queue an empty callback in case of early use of
start_poll_synchronize_srcu() so that it can later get requeued with
the preserved order against other early calls to either call_srcu()
or start_poll_synchronize_srcu().

Since it can be called early any number of time, have at least two
struct rcu_head per ssp dedicated to this early enqueue. The two first
calls to start_poll_synchronize_srcu() will each start one new grace
period, if no call_srcu() happen before or in-between. Any subsequent
early call to start_poll_synchronize_srcu() will wait for the second
grace period so there is no need to queue empty callbacks beyond the
second call.

Suggested-by: Paul E . McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index a2422c442470..9d4fbfc2c109 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -84,6 +84,7 @@ struct srcu_struct {
 	struct delayed_work work;
 	struct lockdep_map dep_map;
 	struct list_head early_init;
+	struct rcu_head early_poll[2];
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7ca1bd0067c4..2fa35e5bfbc9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -190,6 +190,8 @@ static void reset_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
 	struct lockdep_map dep_map;
+	struct rcu_head early_poll[2];
+	int i;
 	struct rcu_cblist pendcbs;
 	struct rcu_head *rhp;
 	struct srcu_data __percpu *sda;
@@ -218,10 +220,16 @@ static void reset_srcu_struct(struct srcu_struct *ssp)
 	sda = ssp->sda;
 	/* Save the lockdep map, it may not suffer double-initialization */
 	dep_map = ssp->dep_map;
+	/* Save the early_poll callback links. They may be queued to pendcbs */
+	for (i = 0; i < ARRAY_SIZE(ssp->early_poll); i++)
+		early_poll[i] = ssp->early_poll[i];
 
 	memset(ssp, 0, sizeof(*ssp));
 	ssp->sda = sda;
 	ssp->dep_map = dep_map;
+	for (i = 0; i < ARRAY_SIZE(ssp->early_poll); i++)
+		ssp->early_poll[i] = early_poll[i];
+
 	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	init_srcu_struct_fields(ssp, true);
 
@@ -1079,6 +1087,10 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
 
+static void early_poll_func(struct rcu_head *rhp)
+{
+}
+
 /**
  * start_poll_synchronize_srcu - Provide cookie and start grace period
  * @ssp: srcu_struct to provide cookie for.
@@ -1091,7 +1103,30 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
  */
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
-	return srcu_gp_start_if_needed(ssp, NULL, true);
+	struct rcu_head *rhp = NULL;
+
+	/*
+	 * After rcu_init_geometry(), we need to reset the ssp and restart
+	 * the early started grace periods. Callbacks can be requeued but
+	 * callback-less grace periods are harder to track, especially if
+	 * we want to preserve the order among all the early calls to
+	 * call_srcu() and start_poll_synchronize_srcu(). So queue empty
+	 * callbacks to solve this. We may initialize at most two grace periods
+	 * that early, no need to queue more than two callbacks per ssp, any
+	 * further early call to start_poll_synchronize_srcu() will wait for
+	 * the second grace period.
+	 */
+	if (!srcu_init_done) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(ssp->early_poll); i++) {
+			if (!ssp->early_poll[i].func) {
+				rhp = &ssp->early_poll[i];
+				rhp->func = early_poll_func;
+				break;
+			}
+		}
+	}
+	return srcu_gp_start_if_needed(ssp, rhp, true);
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
 
-- 
2.25.1

