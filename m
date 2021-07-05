Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663343BC42E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGEXqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 19:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhGEXqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 19:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 990E96194B;
        Mon,  5 Jul 2021 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625528632;
        bh=ibsbKw0bGfPKvmgI3kyEe/l/cxv7GcL0No8b1zbzo54=;
        h=From:To:Cc:Subject:Date:From;
        b=oLJF8GhqwAEQiSVCmVZy+4mz6k+qvPo8SHiNWKUFLVpovsIJNXFscqJMVfoTzMsiy
         lZi8qAt5uzjEgZEN0Yuhlk5JuVp5g89TizGeqUrL6ysQGpTKMh69xdSsvZPmdWBKDr
         ieD2Td6Tr9+ftYSnKvmiUTkosgmtmzywADx6L9qvYB7ljDMxp+v11AtkmJiWU2VaiX
         fccO6g5TttNzfl6gerJFsbEvn1p+zU8aPb13EIq+qIawSmiJfMP8fIb5BGTjjaUXVG
         c0WFA5Ta5MDgQM9zbcn8P3rzwZNHrmVCHc0HyfcbWRg+t2+5x9DWxc6x84YgygkL94
         R8JhpcH0CBUgw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/2] rcu: Explain why rcu_all_qs() is a stub in preemptible TREE RCU
Date:   Tue,  6 Jul 2021 01:43:43 +0200
Message-Id: <20210705234344.104239-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_resched() reports an RCU quiescent state only in non-preemptible
TREE RCU implementation. Provide an explanation for the different
behaviour in CONFIG_PREEMPT_RCU=y.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8fda9a6..db374cb38eb2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7780,6 +7780,19 @@ int __sched __cond_resched(void)
 		preempt_schedule_common();
 		return 1;
 	}
+	/*
+	 * A process spending a long time in the kernel space might
+	 * have too few opportunities to report quiescent states
+	 * when CONFIG_PREEMPT_RCU=n because then the tick can't know
+	 * if it's interrupting an RCU read side critical section. In the
+	 * absence of voluntary sleeps, the last resort resides in tracking
+	 * calls to cond_resched() which always imply quiescent states.
+	 *
+	 * On the other hand, preemptible RCU has a real RCU read side
+	 * tracking that allows the tick for reporting interrupted quiescent
+	 * states or, in the worst case, deferred quiescent states after
+	 * rcu_read_unlock().
+	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
 #endif
-- 
2.25.1

