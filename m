Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490BE373059
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhEDTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:38656 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhEDTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:23 -0400
IronPort-SDR: SofH/Poc41IR21xjvuly5ZR085G+TSVktqZthzswU36QjurIB5/NSvqdsMwutZIf8o2qyk672l
 eS8QODJqd80w==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269905"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:17 -0700
IronPort-SDR: Mx/j1/4XE3+IyWKhH6tc5iBLzyUbD5r2rBBywE9dZ0HjsJTxkrfQF32M+d9temv00HEYLgQDoG
 ljr4xTXVTlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591743"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:17 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>
Subject: [RFC PATCH v5 09/16] watchdog/hardlockup/hpet: Group packages receiving IPIs when needed
Date:   Tue,  4 May 2021 12:05:19 -0700
Message-Id: <20210504190526.22347-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep the HPET interrupts of the hardlockup detector at a rate
of one per second or less frequent, the HPET timer only targets one of
the CPUs monitored by the detector. This is the handling CPU. The rest of
the CPUs are monitored via an IPI issued by the handling CPUs.
Furthermore, the monitored CPUs are partitioned into groups. Groups are
targeted by the HPET timer in a round-robin manner. A group is composed of
of all the CPUs in a physical package.

There may be situations in which it is not possible to keep the
aforementioned HPET interrupt rate. This may happen if, for instance,
watchdog_thresh is set to 1 second and there are more than one package in
the system. In such case, the HPET timer should expire 1/nr_packages
seconds.

It is possible to keep the HPET timer expiration at one second or less
frequent if the packages receiving the IPI are grouped together. Hence,
in the example above, all packages would be grouped together.

This approach has the drawback of having to issue IPIs across packages
However, these cases should be rare: only when there are more packages
than the value of watchdog_thresh in seconds.

Implement functionality to use the logic above: when the hardlockup
detector is enabled in a CPU, check if grouping is necessary based in the
value of watchdog_thresh. When updating target_cpumask, do it as many
times as packages in the group.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Introduced this patch.

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 *N/A
---
 arch/x86/include/asm/hpet.h         |  6 +++
 arch/x86/kernel/watchdog_hld_hpet.c | 75 ++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 8aea54f412e0..bb76f54effe4 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -104,6 +104,10 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @ticks_per_second:		Frequency of the HPET timer
  * @irq:			IRQ number assigned to the HPET channel
  * @handling_cpu:		CPU handling the HPET interrupt
+ * @pkgs_per_group:		Number of physical packages in a group of CPUs
+ *				receiving an IPI
+ * @nr_groups:			Number of groups into which @monitored_cpumask
+ *				is partitioned
  * @msi_msg:			MSI message to be written it the HPET registers
  * @affinity_work:		Used to update the affinity of the detector
  *				interrupts, both IPI and NMI.
@@ -121,6 +125,8 @@ struct hpet_hld_data {
 	u64		ticks_per_second;
 	int		irq;
 	u32		handling_cpu;
+	u32		pkgs_per_group;
+	u32		nr_groups;
 	struct msi_msg	msi_msg;
 	struct irq_work	affinity_work;
 	cpumask_var_t	monitored_cpumask;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index a363f3cd45dd..04b354a35e68 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -235,26 +235,71 @@ static void update_ipi_target_cpumask(struct hpet_hld_data *hdata)
 retry:
 	cpumask_clear(hdata->target_cpumask);
 
-	next_cpu = get_first_cpu_in_next_pkg(next_cpu, hdata);
-	if (next_cpu < 0 || next_cpu >= nr_cpu_ids) {
-		/*
-		 * If a CPU in a next package was not identified,
-		 * fallback to the first monitored CPU instead of
-		 * bailing out.
-		 */
-		next_cpu = cpumask_first(hdata->monitored_cpumask);
-		goto retry;
+	for (i = 0 ; i < hdata->pkgs_per_group; i++) {
+		next_cpu = get_first_cpu_in_next_pkg(next_cpu, hdata);
+		if (next_cpu < 0 || next_cpu >= nr_cpu_ids) {
+			/*
+			 * If a CPU in a next package was not identified,
+			 * fallback to the first monitored CPU instead of
+			 * bailing out.
+			 */
+			next_cpu = cpumask_first(hdata->monitored_cpumask);
+			goto retry;
+		}
+
+		/* Select all the CPUs in the same package as @next_cpu */
+		cpumask_or(hdata->target_cpumask, hdata->target_cpumask,
+			   topology_core_cpumask(next_cpu));
 	}
 
-	/* Select all the CPUs in the same package as @next_cpu */
-	cpumask_or(hdata->target_cpumask, hdata->target_cpumask,
-		   topology_core_cpumask(next_cpu));
-
 	/* Only select the CPUs that need to be monitored */
 	cpumask_and(hdata->target_cpumask, hdata->target_cpumask,
 		    hdata->monitored_cpumask);
 }
 
+/**
+ * count_monitored_packages() - Count the packages with monitored CPUs
+ * @hdata:	A data structure with the monitored cpumask
+ *
+ * Return the number of packages with at least one CPU in the monitored_cpumask
+ * of @hdata
+ */
+static u32 count_monitored_packages(struct hpet_hld_data *hdata)
+{
+	int c = cpumask_first(hdata->monitored_cpumask);
+	u16 start_id, id;
+	u32 nr_pkgs = 0;
+
+	start_id = topology_physical_package_id(c);
+
+	do {
+		nr_pkgs++;
+		c = get_first_cpu_in_next_pkg(c, hdata);
+		id = topology_physical_package_id(c);
+	} while (start_id != id);
+
+	return nr_pkgs;
+}
+
+static void setup_cpu_groups(struct hpet_hld_data *hdata)
+{
+	u32 monitored_pkgs = count_monitored_packages(hdata);
+
+	hdata->pkgs_per_group = 0;
+	hdata->nr_groups = U32_MAX;
+
+	/*
+	 * To keep the HPET timer to fire each 1 second or less frequently,
+	 * the condition watchdog_thresh >= nr_groups nust be met. Thus,
+	 * group together one or more packages until such condition is reached.
+	 */
+	while (watchdog_thresh < hdata->nr_groups) {
+		hdata->pkgs_per_group++;
+		hdata->nr_groups = DIV_ROUND_UP(monitored_pkgs,
+						hdata->pkgs_per_group);
+	}
+}
+
 static void update_timer_irq_affinity(struct irq_work *work)
 {
 	struct hpet_hld_data *hdata = container_of(work, struct hpet_hld_data,
@@ -378,6 +423,8 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, hld_data->monitored_cpumask);
 
+	setup_cpu_groups(hld_data);
+
 	update_ipi_target_cpumask(hld_data);
 
 	/*
@@ -421,6 +468,8 @@ void hardlockup_detector_hpet_disable(unsigned int cpu)
 	hld_data->handling_cpu = cpumask_first(hld_data->monitored_cpumask);
 	update_msi_destid(hld_data);
 
+	setup_cpu_groups(hld_data);
+
 	update_ipi_target_cpumask(hld_data);
 
 	enable_timer(hld_data);
-- 
2.17.1

