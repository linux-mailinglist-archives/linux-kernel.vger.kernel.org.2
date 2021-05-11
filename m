Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6537B1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEKWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhEKWyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C24026192C;
        Tue, 11 May 2021 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773586;
        bh=33SghJiwy5Jn22f7sV2RV4nt5XTeKYFmP+29pYwkJNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ql2q5h/0eh5fs75KxPAimbTIp1+qky6kB3TynXdPmx2uzVR42OiwRCkQ6HugfBhSM
         +gdvszrMORoMR3xt2E76dr4bgFP8dvrCsZ9uj/EGxcjahPf1z9wuF8UQVQbUlu7ftd
         47ETEeWYu643ejPH041iydL1O3EfMC49oXQp+tomp/Zham/qCi776U3BkGMKWoDjdY
         CwvYOekDLsE/0xvOuVQvhHiZarTj6zyWTSnKBEzhgjJTqlxXux833unl6AhILvAzWD
         uhAx/BUGm9LcjbAmwVOI6rIhzARM6al507qPufasPMZNnrJW/vGRbu57v4hWylVDQ6
         3KKTQhQ/offvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 909245C0D4A; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/19] rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output
Date:   Tue, 11 May 2021 15:52:50 -0700
Message-Id: <20210511225304.2893154-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds ->rt_priority and ->gp_start to show_rcu_gp_kthreads()
output in order to better diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc5cbdf..fb4702570316 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -726,6 +726,7 @@ void show_rcu_gp_kthreads(void)
 	unsigned long j;
 	unsigned long ja;
 	unsigned long jr;
+	unsigned long js;
 	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -734,11 +735,12 @@ void show_rcu_gp_kthreads(void)
 	j = jiffies;
 	ja = j - data_race(rcu_state.gp_activity);
 	jr = j - data_race(rcu_state.gp_req_activity);
+	js = j - data_race(rcu_state.gp_start);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->state : 0x1ffffL,
-		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
+		rcu_state.gp_state, t ? t->state : 0x1ffffL, t ? t->rt_priority : 0xffU,
+		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
 		data_race(rcu_state.gp_flags));
-- 
2.31.1.189.g2e36527f23

