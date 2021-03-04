Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9B32C927
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356790AbhCDBFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451144AbhCDAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E6C64F49;
        Thu,  4 Mar 2021 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818115;
        bh=EZvf9vO7Ukk1beVFHjJwsml2KTzNj/L49Ra8sQECFfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxGnz2dkH/K5YMJ6rloNBV5qGWrPa5P2iC6KgC2ZlWcGh08CkDEKlExf4t3P5VSkH
         LR7hBboj2WZH8qCgAnLWuh3qvreIPQtlDbyk6Zg09cQ4EYofvGztp8jL0dUeHgt/3m
         bp4dESdr1T+l/rjc+yEe++HjJk6+4+yEadO/42P15vKop8sKYC14LA0SUgvWK3pTGb
         yhAhM06qtWQEKl2znn9pz10s18ERKMGAn9fqdIzRUmHB8LfprLFolmyo+WPxnwLjTc
         TFRSH7HDFn66RqBf7uZ/IJF23teGK/4iPZkaOjIg7FxAXdb+NeduBHtLhVMWRpZBSV
         zdtvvdR8QVtFA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] rcutorture: Replace rcu_torture_stall string with %s
Date:   Wed,  3 Mar 2021 16:35:13 -0800
Message-Id: <20210304003513.24488-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003431.GA24413@paulmck-ThinkPad-P72>
References: <20210304003431.GA24413@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Zhang <stephenzhangzsd@gmail.com>

This commit replaces a hard-coded "rcu_torture_stall" string in a
pr_alert() format with "%s" and __func__.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..271726e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1971,8 +1971,8 @@ static int rcu_torture_stall(void *args)
 			local_irq_disable();
 		else if (!stall_cpu_block)
 			preempt_disable();
-		pr_alert("rcu_torture_stall start on CPU %d.\n",
-			 raw_smp_processor_id());
+		pr_alert("%s start on CPU %d.\n",
+			  __func__, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
 			if (stall_cpu_block)
@@ -1983,7 +1983,7 @@ static int rcu_torture_stall(void *args)
 			preempt_enable();
 		cur_ops->readunlock(idx);
 	}
-	pr_alert("rcu_torture_stall end.\n");
+	pr_alert("%s end.\n", __func__);
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
-- 
2.9.5

