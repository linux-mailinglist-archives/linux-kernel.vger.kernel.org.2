Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9457032C973
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355386AbhCDBD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450980AbhCDA0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5653D64E67;
        Thu,  4 Mar 2021 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817594;
        bh=wniLB1TxgvumUojHEAHMXuGZIzDZFhceB41We0iTPwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puY7oayPLWaX13rkWvOS8SGPyL5epEGzVV8CM64rFodTHzgtaZLgxRvshoFnUKjjU
         W0XIXVKcUfh7q+y+fSQHZQf2VI0mMzlpk51yAAM3dVsh0S/exZbAkLPo4iKMQf1y9Q
         15vxQs0T5lIVh5mGElbJtCR4XNR9C3YtUhQOhIji0GCXvombXrnECwirPFiWPzl+aY
         p3rVHg80jgQaz1OHBN914sNrVfUIdx7qMslJarDGIcBffqtxZVBQFflOMyT+9yspR0
         cME+2btPPSI81znZv0ZALxAGUsFZRoq+sgIp4E/MuGrjsJiDAGxB0RhBeggKdTgvdY
         x4OXhLUdywh0A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] rcutorture: Test start_poll_synchronize_rcu() and poll_state_synchronize_rcu()
Date:   Wed,  3 Mar 2021 16:26:32 -0800
Message-Id: <20210304002632.23870-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002605.GA23785@paulmck-ThinkPad-P72>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes rcutorture to test the new start_poll_synchronize_rcu()
and poll_state_synchronize_rcu() functions.  Because of the difficulty of
determining the nature of a synchronous RCU grace (expedited or not),
the test that insisted that poll_state_synchronize_rcu() detect an
intervening synchronize_rcu() had to be dropped.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..956e6bf 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -494,6 +494,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
 	.get_gp_state	= get_state_synchronize_rcu,
+	.start_gp_poll	= start_poll_synchronize_rcu,
+	.poll_gp_state	= poll_state_synchronize_rcu,
 	.cond_sync	= cond_synchronize_rcu,
 	.call		= call_rcu,
 	.cb_barrier	= rcu_barrier,
@@ -1223,14 +1225,6 @@ rcu_torture_writer(void *arg)
 				WARN_ON_ONCE(1);
 				break;
 			}
-			if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-				WARN_ONCE(rcu_torture_writer_state != RTWS_DEF_FREE &&
-					  !cur_ops->poll_gp_state(cookie),
-					  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
-					  __func__,
-					  rcu_torture_writer_state_getname(),
-					  rcu_torture_writer_state,
-					  cookie, cur_ops->get_gp_state());
 		}
 		WRITE_ONCE(rcu_torture_current_version,
 			   rcu_torture_current_version + 1);
@@ -1589,7 +1583,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_enable();
 	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
 		WARN_ONCE(cur_ops->poll_gp_state(cookie),
-			  "%s: Cookie check 3 failed %s(%d) %lu->%lu\n",
+			  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
 			  __func__,
 			  rcu_torture_writer_state_getname(),
 			  rcu_torture_writer_state,
-- 
2.9.5

