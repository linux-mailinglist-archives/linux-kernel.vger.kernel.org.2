Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D732C91B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356382AbhCDBEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244838AbhCDAah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B72F64EBD;
        Thu,  4 Mar 2021 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817797;
        bh=qjT7jsABtEkFjwh3R7KdQ5ewWLKm1ZZKq9tH2fwcEL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH1gj1nhVwEEkWT/5F+plyVTYAFvhmSbNA2Hnsva8yuUuNps9gtOnFSqbX/ZvyUU5
         m2d5AadglPsDt+D0pbosgQwfDKu1sADzHUHMVHu54hVXrQYFTgywCLu+rOh1DyBAaI
         07zXZZTBL4eY1Eem5//tUgs7Dx6MHrvpMkw/5u6mXrecihMhs0EY0Ympnxkx9YTpih
         w32K0uzsCBPBkQ0nv+UguZTMDYubAxjP6HJrwvzodph4aPZAVqJ5cEZ85YROnorNrB
         4Zj337bii8Sp0JKC5xq5FMliks9CXObCkVZiHVHaamUQUh5KFtWCrnYd+F0SRcCiZ1
         euopaoSqlPjCw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/5] rcutorture: Make TREE03 use real-time tree.use_softirq setting
Date:   Wed,  3 Mar 2021 16:29:52 -0800
Message-Id: <20210304002955.24132-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002919.GA24003@paulmck-ThinkPad-P72>
References: <20210304002919.GA24003@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

TREE03 tests RCU priority boosting, which is a real-time feature.
It would also be good if it tested something closer to what is
actually used by the real-time folks.  This commit therefore adds
tree.use_softirq=0 to the TREE03 kernel boot parameters in TREE03.boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 1c21894..64f864f1 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,3 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
+tree.use_softirq=0
-- 
2.9.5

