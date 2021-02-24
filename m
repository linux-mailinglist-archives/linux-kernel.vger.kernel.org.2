Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8670932384A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBXIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:06:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:27997 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBXIGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:06:49 -0500
IronPort-SDR: DVBEM5nC088uzGWSRlAaZW48ZY/EHW4pCYq4r1aufXRgxdmSBFBux1LTS6ab/w89HLA+1+VgK1
 QgoMMKFgyRng==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="164304608"
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="scan'208";a="164304608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 00:06:08 -0800
IronPort-SDR: G+vnAu6JCZJLXYRZd3lK1ODn3Lvab4u5CdsUjcUy8A8UT0ZWqp3xLY+LWd3Iyvr1j8PocUiVrh
 R+rGtI4zw+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="scan'208";a="423955222"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.27])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2021 00:06:05 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        mgorman@techsingularity.net, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v2] sched/fair: reduce long-tail newly idle balance cost
Date:   Wed, 24 Feb 2021 16:15:49 +0800
Message-Id: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A long-tail load balance cost is observed on the newly idle path,
this is caused by a race window between the first nr_running check
of the busiest runqueue and its nr_running recheck in detach_tasks.

Before the busiest runqueue is locked, the tasks on the busiest
runqueue could be pulled by other CPUs and nr_running of the busiest
runqueu becomes 1 or even 0 if the running task becomes idle, this
causes detach_tasks breaks with LBF_ALL_PINNED flag set, and triggers
load_balance redo at the same sched_domain level.

In order to find the new busiest sched_group and CPU, load balance will
recompute and update the various load statistics, which eventually leads
to the long-tail load balance cost.

This patch clears LBF_ALL_PINNED flag for this race condition, and hence
reduces the long-tail cost of newly idle balance.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce2..5c67804 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7675,6 +7675,15 @@ static int detach_tasks(struct lb_env *env)
 
 	lockdep_assert_held(&env->src_rq->lock);
 
+	/*
+	 * Source run queue has been emptied by another CPU, clear
+	 * LBF_ALL_PINNED flag as we will not test any task.
+	 */
+	if (env->src_rq->nr_running <= 1) {
+		env->flags &= ~LBF_ALL_PINNED;
+		return 0;
+	}
+
 	if (env->imbalance <= 0)
 		return 0;
 
-- 
2.7.4

