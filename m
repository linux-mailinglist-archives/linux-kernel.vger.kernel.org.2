Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10CB354B88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhDFEL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:11:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:56296 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhDFELv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:11:51 -0400
IronPort-SDR: f5fGHwGnAyYrvABB3i145FR+3dBDpsQmbWxVyEJQ6dMxVBT5SoMHBOwGUns6sbkA0ePkyOurpV
 T9HSKCqJlf4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193017355"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="193017355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:11:43 -0700
IronPort-SDR: U7f8v77ta9srv9t/vHtODEMchscXV7VNeRzGEoQmv8dwKTrSltxf1obTc+QDhJ+5XELn9CZzGI
 3TWhPgOBIOCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="518864624"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2021 21:11:42 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
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
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 4/4] x86/sched: Enable checks of the state of SMT siblings in load balancing
Date:   Mon,  5 Apr 2021 21:11:08 -0700
Message-Id: <20210406041108.7416-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITMT relies on asymmetric packing of tasks to ensure CPUs are populated in
priority order. When balancing load, the scheduler compares scheduling
groups in pairs, and compares only the priority of the CPUs of highest
priority in the group. This may result on CPUs with medium priority being
overlooked. A recent change introduced logic to also consider the idle
state of the SMT siblings of the CPU doing the load balance. Enable those
checks for x86 when using ITMT.

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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/itmt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 1afbdd1dd777..1407120af82d 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -28,6 +28,8 @@ DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
 
 /* Boolean to track if system has ITMT capabilities */
 static bool __read_mostly sched_itmt_capable;
+/* Boolean to activate checks on the state of SMT siblings */
+static bool __read_mostly sched_itmt_smt_checks;
 
 /*
  * Boolean to control whether we want to move processes to cpu capable
@@ -124,6 +126,8 @@ int sched_set_itmt_support(void)
 
 	sysctl_sched_itmt_enabled = 1;
 
+	sched_itmt_smt_checks = true;
+
 	x86_topology_update = true;
 	rebuild_sched_domains();
 
@@ -160,6 +164,7 @@ void sched_clear_itmt_support(void)
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */
 		sysctl_sched_itmt_enabled = 0;
+		sched_itmt_smt_checks = false;
 		x86_topology_update = true;
 		rebuild_sched_domains();
 	}
@@ -167,6 +172,16 @@ void sched_clear_itmt_support(void)
 	mutex_unlock(&itmt_update_mutex);
 }
 
+bool arch_asym_check_smt_siblings(void)
+{
+	return sched_itmt_smt_checks;
+}
+
+bool arch_sched_asym_prefer_early(int a, int b)
+{
+	return sched_itmt_smt_checks;
+}
+
 int arch_asym_cpu_priority(int cpu)
 {
 	return per_cpu(sched_core_priority, cpu);
-- 
2.17.1

