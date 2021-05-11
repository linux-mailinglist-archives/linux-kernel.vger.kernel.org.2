Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A331337B1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhEKWy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhEKWyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050AD61937;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=msoNn3F/3mMAWHlQO41JH41TKO4DJu3n00p097tSHDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9M20CAYLthzVsdVmHwReGZD3EDUvgQ5ASyYkZzsI5bFasZqfUaYZcGZiQLFEdztP
         F2OhT+0c5xs8SKgtupNvW2pxymi5kVQkz05HnKvu3bB2G/5I9RVYxvpMP4sFRqtpUx
         EtxP62CmZtB7wJyche0f90+lctxxEp0DCkpFSnT9SyehjEJlR93bu/Ayzyg/Vq+lye
         YrI/1wN6kfDUoWf+2eNCiUenxuyQfvVTDNEf4GABQwUNW3rS3xwnQMMoW4XtujcvL0
         N4tWhfYjU0LD5lGB5nBtmm4zjpUjqCC1iHVDkUGfBNEpdIfY0aCl1ZDW9eWNDiJ0Xk
         GomyH0MRDxSJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 925B45C0DB3; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/19] rcu: Add ->gp_max to show_rcu_gp_kthreads() output
Date:   Tue, 11 May 2021 15:52:51 -0700
Message-Id: <20210511225304.2893154-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds ->gp_max to show_rcu_gp_kthreads() output in order to
better diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index fb4702570316..a4e2bb3bdce7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -737,12 +737,13 @@ void show_rcu_gp_kthreads(void)
 	jr = j - data_race(rcu_state.gp_req_activity);
 	js = j - data_race(rcu_state.gp_start);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
 		rcu_state.gp_state, t ? t->state : 0x1ffffL, t ? t->rt_priority : 0xffU,
 		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
+		data_race(rcu_state.gp_max),
 		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
-- 
2.31.1.189.g2e36527f23

