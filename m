Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1C3A2FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFJPwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFJPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:52:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFEE61376;
        Thu, 10 Jun 2021 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623340236;
        bh=DgGdJqIKAoxqN2PVGkeutE+hR+bSiyT05Kgawa3NJ3s=;
        h=From:To:Cc:Subject:Date:From;
        b=DJmfsIgK2+/zvxTMjgyEcAPdy1I9VG1rfkQGi1jgXY0oUSPFkveYvwOqYW9BpJY0c
         b4ZK4nzCYIt7iI+aNERT6228mI7tI1XNZ1DyE1fdnB1G1HBPc6RVqOxppEENlNlMyd
         v5IrgxLYfzKCElf1fT0tnSvBwXeecaGAYg71+rQ9MgeEUaFULNJheA2IwbXFBYJA+c
         ULzSigdku/mAVF0ve6brfD154PrZk+dXbUMOGVpAjJmykQVm1A36nXEy6KwveoMXY7
         mYbZTnf/onOeSLUI1BQjA8nF1eQfagKgnVgd6NfmujmDIBqgW9tjpq/rOAicCbm4QG
         YTMTMJLVqsx8A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
Date:   Thu, 10 Jun 2021 17:50:29 +0200
Message-Id: <20210610155029.130812-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some missing critical pieces of explanation to understand the need
for full memory barriers throughout the whole grace period state machine,
thanks to Paul's explanations.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 .../Tree-RCU-Memory-Ordering.rst              | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 11cdab037bff..f21432115627 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -112,6 +112,39 @@ on PowerPC.
 The ``smp_mb__after_unlock_lock()`` invocations prevent this
 ``WARN_ON()`` from triggering.
 
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But the whole chain of rnp locking is enough for the readers to see   |
+| all the pre-grace-period accesses from the updater and for the updater|
+| to see all the accesses from the readers performed before the end of  |
+| the grace period. So why do we need to enforce full ordering at all   |
+| through smp_mb__after_unlock_lock()?                                  |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because we still need to take care of the lockless counterparts of    |
+| RCU. The first key example here is grace period polling. Using        |
+| poll_state_synchronize_rcu() or cond_synchronize_rcu(), an updater    |
+| can rely solely on lockess full ordering to benefit from the usual    |
+| TREE RCU ordering guarantees.                                         |
+|                                                                       |
+| The second example lays behind the fact that a grace period still     |
+| claims to imply full memory ordering. Therefore in the following      |
+| scenario:                                                             |
+|                                                                       |
+| CPU 0                     CPU 1                                       |
+| ----                      ----                                        |
+| WRITE_ONCE(X, 1)          WRITE_ONCE(Y, 1)                            |
+| synchronize_rcu()         smp_mb()                                    |
+| r0 = READ_ONCE(Y)         r1 = READ_ONCE(X)                           |
+|                                                                       |
+| It must be impossible to have r0 == 0 && r1 == 0 after both CPUs      |
+| have completed their sequences, even if CPU 1 is in an RCU extended   |
+| quiescent state (idle mode) and thus won't report a quiescent state   |
+| throughout the common rnp locking chain.                              |
++-----------------------------------------------------------------------+
+
 This approach must be extended to include idle CPUs, which need
 RCU's grace-period memory ordering guarantee to extend to any
 RCU read-side critical sections preceding and following the current
-- 
2.25.1

