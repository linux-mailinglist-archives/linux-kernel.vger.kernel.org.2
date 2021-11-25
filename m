Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16A945DD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356043AbhKYPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:25:18 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:37089 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355990AbhKYPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:23:17 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 98340FB314
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 15:20:03 +0000 (GMT)
Received: (qmail 26004 invoked from network); 25 Nov 2021 15:20:03 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 25 Nov 2021 15:20:03 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in find_busiest_group
Date:   Thu, 25 Nov 2021 15:19:40 +0000
Message-Id: <20211125151941.8710-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211125151941.8710-1-mgorman@techsingularity.net>
References: <20211125151941.8710-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_busiest_group uses the child domain's group weight instead of
the sched_domain's weight that has SD_NUMA set when calculating the
allowed imbalance between NUMA nodes. This is wrong and inconsistent
with find_idlest_group.

This patch uses the SD_NUMA weight in both.

Fixes: c4e8f691d926 ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCS")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..0a969affca76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9397,7 +9397,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, busiest->group_weight);
+				busiest->sum_nr_running, env->sd->span_weight);
 		}
 
 		return;
-- 
2.31.1

