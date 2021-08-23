Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41D3F4984
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhHWLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:17:53 -0400
Received: from foss.arm.com ([217.140.110.172]:51998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236347AbhHWLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:17:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F02143D;
        Mon, 23 Aug 2021 04:17:07 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F036A3F66F;
        Mon, 23 Aug 2021 04:17:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 2/2] sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle
Date:   Mon, 23 Aug 2021 12:17:00 +0100
Message-Id: <20210823111700.2842997-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823111700.2842997-1-valentin.schneider@arm.com>
References: <20210823111700.2842997-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a system with some NOHZ-idle CPUs, such that

  nohz.idle_cpus_mask = S
  nohz.next_balance = T

When a new CPU k goes NOHZ idle (nohz_balance_enter_idle()), we end up
with:

  nohz.idle_cpus_mask = S \U {k}
  nohz.next_balance = T

Note that the nohz.next_balance hasn't changed - it won't be updated until
a NOHZ balance is triggered. This is problematic if the newly NOHZ idle CPU
has an earlier rq.next_balance than the other NOHZ idle CPUs, IOW if:

  cpu_rq(k).next_balance < nohz.next_balance

In such scenarios, the existing nohz.next_balance will prevent any NOHZ
balance from happening, which itself will prevent nohz.next_balance from
being updated to this new cpu_rq(k).next_balance. Unnecessary load balance
delays of over 12ms caused by this were observed on an arm64 RB5 board.

Use the new nohz.needs_update flag to mark the presence of newly-idle CPUs
that need their rq->next_balance to be collated into
nohz.next_balance. Trigger a NOHZ_NEXT_KICK when the flag is set.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a91f3027c92..081a9e54058a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5754,6 +5754,7 @@ static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
+	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -10417,6 +10418,9 @@ static void nohz_balancer_kick(struct rq *rq)
 unlock:
 	rcu_read_unlock();
 out:
+	if (READ_ONCE(nohz.needs_update))
+		flags |= NOHZ_NEXT_KICK;
+
 	if (flags)
 		kick_ilb(flags);
 }
@@ -10513,12 +10517,13 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
-	 * store.
+	 * and @needs_update stores.
 	 */
 	smp_mb__after_atomic();
 
 	set_cpu_sd_state_idle(cpu);
 
+	WRITE_ONCE(nohz.needs_update, 1);
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
@@ -10567,13 +10572,17 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	/*
 	 * We assume there will be no idle load after this update and clear
 	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
-	 * set the has_blocked flag and trig another update of idle load.
+	 * set the has_blocked flag and trigger another update of idle load.
 	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
+	 *
+	 * Same applies to idle_cpus_mask vs needs_update.
 	 */
 	if (flags & NOHZ_STATS_KICK)
 		WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_NEXT_KICK)
+		WRITE_ONCE(nohz.needs_update, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10597,6 +10606,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		if (need_resched()) {
 			if (flags & NOHZ_STATS_KICK)
 				has_blocked_load = true;
+			if (flags & NOHZ_NEXT_KICK)
+				WRITE_ONCE(nohz.needs_update, 1);
 			goto abort;
 		}
 
-- 
2.25.1

