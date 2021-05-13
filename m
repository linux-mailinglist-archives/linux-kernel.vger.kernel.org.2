Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF037FB07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhEMPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:51:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:24119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232252AbhEMPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:51:11 -0400
IronPort-SDR: ElIRBMQRiS/G86U5W1o1Tl9TOhW2WFpCxFmxjO7gCR2xFNsFpoTrfwYBz67txNye5qKuDY9RBl
 4dBMj96sz+Pw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179568902"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179568902"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:49:59 -0700
IronPort-SDR: 48GPGX80/FKoQNuZAKLX2BUGOpZX9w5im4An1klZaYK53SAzVUP+aQjoG45yTrf0HOLSAd6pCu
 ud+/rfcOoFwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610418825"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2021 08:49:59 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 1/6] sched/topology: Introduce sched_group::flags
Date:   Thu, 13 May 2021 08:49:04 -0700
Message-Id: <20210513154909.6385-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exist situations in which the load balance needs to know the
properties of the CPUs in a scheduling group. When using asymmetric
packing, for instance, the load balancer needs to know not only the
state of dst_cpu but also of its SMT siblings, if any.

Use the flags of the child scheduling domains to initialize scheduling
group flags. This will reflect the properties of the CPUs in the
group.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/sched.h    | 1 +
 kernel/sched/topology.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f0194cee0ba..1afd82c1743d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1795,6 +1795,7 @@ struct sched_group {
 	unsigned int		group_weight;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
+	int			flags;
 
 	/*
 	 * The CPUs this group covers.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 053115b55f89..1caab1a5e5c8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -916,10 +916,12 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 		return NULL;
 
 	sg_span = sched_group_span(sg);
-	if (sd->child)
+	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
+		sg->flags = sd->child->flags;
+	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
+	}
 
 	atomic_inc(&sg->ref);
 	return sg;
@@ -1169,6 +1171,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		sg->flags = child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
-- 
2.17.1

