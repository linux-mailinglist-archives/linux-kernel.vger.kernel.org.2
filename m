Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62EF407458
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhIKBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:20:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:21357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234989AbhIKBUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:20:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208325814"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="208325814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 18:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="695261613"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2021 18:19:07 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 1/6] x86/sched: Decrease further the priorities of SMT siblings
Date:   Fri, 10 Sep 2021 18:18:14 -0700
Message-Id: <20210911011819.12184-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scheduling, it is better to prefer a separate physical core rather
than the SMT sibling of a high priority core. The existing formula to
compute priorities takes such fact in consideration. There may exist,
however, combinations of priorities (i.e., maximum frequencies) in which
the priority of high-numbered SMT siblings of high-priority cores collides
with the priority of low-numbered SMT siblings of low-priority cores.

Consider for instance an SMT2 system with CPUs [0, 1] with priority 60 and
[2, 3] with priority 30(CPUs in brackets are SMT siblings. In such a case,
the resulting priorities would be [120, 60], [60, 30]. Thus, to ensure
that CPU2 has higher priority than CPU1, divide the raw priority by the
squared SMT iterator. The resulting priorities are [120, 30]. [60, 15].

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Originally-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
  * None

Changes since v3:
  * Introduced this patch

Changes since v2:
  * N/A

Changes since v1:
  * N/A
---
 arch/x86/kernel/itmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 1afbdd1dd777..9ff480e94511 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -198,7 +198,7 @@ void sched_set_itmt_core_prio(int prio, int core_cpu)
 		 * of the priority chain and only used when
 		 * all other high priority cpus are out of capacity.
 		 */
-		smt_prio = prio * smp_num_siblings / i;
+		smt_prio = prio * smp_num_siblings / (i * i);
 		per_cpu(sched_core_priority, cpu) = smt_prio;
 		i++;
 	}
-- 
2.17.1

