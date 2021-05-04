Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BAD373057
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhEDTIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhEDTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:23 -0400
IronPort-SDR: 8aBq/27BnGoiyUS12szBPjkqF7XUmdnZf3TzjPY5TdiKLpq2hckq6b8m/mVfdplaKeeeAx29oP
 zIr/hV129yUg==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269903"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269903"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:17 -0700
IronPort-SDR: U/NyCVzWayfVpmrawAypOZI2By1aCUc5jzHX8DZ0kxMBjt2lg8jRobdKD2AwhJtI4l/7cjZPyB
 Is0FWO5lC86w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591740"
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
Subject: [RFC PATCH v5 08/16] x86/watchdog/hardlockup/hpet: Introduce a target_cpumask
Date:   Tue,  4 May 2021 12:05:18 -0700
Message-Id: <20210504190526.22347-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET hardlockup detector uses struct hpet_hld_data::monitored_cpumask
to keep track of the CPUs that must be monitored for hard lockups. When
the HPET timer expires, the CPU handling the interrupt issues an IPI to
a subset of those monitored CPUs. The IPI will be sent only to the
monitored CPUs that reside in the same package as the CPU handling the
HPET interrupt. Designate this subset of monitored CPUs as target CPUs and
track them using hpet_hld_data::target_cpumask.

In order to check all the monitored CPUs at the HPET timer expiration,
rotate target_cpumask to now target the CPUs in the next package. Also
the CPU handling the next HPET interrupt accordingly. Do all this from
irq_work started from the NMI handler.

Changes in the monitored CPUs mask may change the handling CPU or the set
of CPUs targeted for the next HPET interrupt. Thus, update both when the
hardlockup detector is enabled or disabled on any CPU.

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
 * Moved configuration of IPI of target CPUs and affinity of the HPET
   interrupt to an irq_work. (Thomas Gleixner)

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h         |   7 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 114 +++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index b1c8d5ce7e13..8aea54f412e0 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -105,10 +105,15 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @irq:			IRQ number assigned to the HPET channel
  * @handling_cpu:		CPU handling the HPET interrupt
  * @msi_msg:			MSI message to be written it the HPET registers
+ * @affinity_work:		Used to update the affinity of the detector
+ *				interrupts, both IPI and NMI.
  * @monitored_cpumask:		CPUs monitored by the hardlockup detector
  * @ipi_cpumask:		Auxiliary mask to handle IPIs. Both sending and
  *				receiving CPUs write to it. Hence, we cannot
  *				reuse @monitored_cpumask.
+ * @target_cpumask:		Subset of @monitored_cpumask receiving a
+ *				particular IPI upon HPET interrupt. It changes
+ *				based on which CPU handles such interrupt.
  */
 struct hpet_hld_data {
 	bool		has_periodic;
@@ -117,8 +122,10 @@ struct hpet_hld_data {
 	int		irq;
 	u32		handling_cpu;
 	struct msi_msg	msi_msg;
+	struct irq_work	affinity_work;
 	cpumask_var_t	monitored_cpumask;
 	cpumask_var_t	ipi_cpumask;
+	cpumask_var_t	target_cpumask;
 };
 
 extern struct hpet_hld_data *hpet_hld_get_timer(void);
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 47fc2cb540de..a363f3cd45dd 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -169,6 +169,103 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
 	return 0;
 }
 
+/**
+ * get_first_cpu_in_next_pkg() - Find the first CPU in the next package
+ * @start_cpu:	CPU from which we start looking
+ * @hdata:	A data structure with the monitored CPUs mask
+ *
+ * Find the first CPU in the package next to the package of @start_cpu.
+ * If there is only one package in the system, return @start_cpu.
+ */
+static unsigned int get_first_cpu_in_next_pkg(int start_cpu,
+					      struct hpet_hld_data *hdata)
+{
+	u16 this_cpu_pkg_id, next_cpu_pkg_id;
+	int next_cpu = start_cpu;
+
+	if (start_cpu < 0 || start_cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!cpumask_test_cpu(start_cpu, hdata->monitored_cpumask))
+		return -ENODEV;
+
+	this_cpu_pkg_id = topology_physical_package_id(start_cpu);
+	next_cpu_pkg_id = this_cpu_pkg_id;
+
+	/* If there is only one online package, return @start_cpu */
+	while (this_cpu_pkg_id == next_cpu_pkg_id) {
+		next_cpu = cpumask_next_wrap(next_cpu,
+					     hdata->monitored_cpumask,
+					     nr_cpu_ids,
+					     true);
+		/* Wrapped-around */
+		if (next_cpu >= nr_cpu_ids)
+			continue;
+
+		/* Returned to starting point */
+		next_cpu_pkg_id = topology_physical_package_id(next_cpu);
+		if (next_cpu == start_cpu)
+			break;
+	}
+
+	return next_cpu;
+}
+
+/**
+ * update_ipi_target_cpumask() - Update IPI mask for the next HPET interrupt
+ * @hdata:	 Data strucure with the monitored cpumask and handling CPU info
+ *
+ * Update the target_cpumask of @hdata with the set of CPUs to which the
+ * handling_cpu of @hdata will issue an IPI. Normally, the handling_cpu and the
+ * CPUs in the updated target_cpumask are in the same package.
+ */
+static void update_ipi_target_cpumask(struct hpet_hld_data *hdata)
+{
+	int next_cpu, i;
+
+	next_cpu = hld_data->handling_cpu;
+
+	/*
+	 * If we start from an invalid CPU, instead of failing, just use the
+	 * first monitored CPU.
+	 */
+	if (next_cpu < 0 || next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(hdata->monitored_cpumask);
+
+retry:
+	cpumask_clear(hdata->target_cpumask);
+
+	next_cpu = get_first_cpu_in_next_pkg(next_cpu, hdata);
+	if (next_cpu < 0 || next_cpu >= nr_cpu_ids) {
+		/*
+		 * If a CPU in a next package was not identified,
+		 * fallback to the first monitored CPU instead of
+		 * bailing out.
+		 */
+		next_cpu = cpumask_first(hdata->monitored_cpumask);
+		goto retry;
+	}
+
+	/* Select all the CPUs in the same package as @next_cpu */
+	cpumask_or(hdata->target_cpumask, hdata->target_cpumask,
+		   topology_core_cpumask(next_cpu));
+
+	/* Only select the CPUs that need to be monitored */
+	cpumask_and(hdata->target_cpumask, hdata->target_cpumask,
+		    hdata->monitored_cpumask);
+}
+
+static void update_timer_irq_affinity(struct irq_work *work)
+{
+	struct hpet_hld_data *hdata = container_of(work, struct hpet_hld_data,
+						   affinity_work);
+
+	update_ipi_target_cpumask(hdata);
+
+	hdata->handling_cpu = cpumask_first(hdata->target_cpumask);
+	update_msi_destid(hdata);
+}
+
 /**
  * hardlockup_detector_nmi_handler() - NMI Interrupt handler
  * @type:	Type of NMI handler; not used.
@@ -176,7 +273,8 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
  *
  * Check if it was caused by the expiration of the HPET timer. If yes, inspect
  * for lockups by issuing an IPI to all the monitored CPUs. Also, kick the
- * timer if it is non-periodic.
+ * timer if it is non-periodic. Lastly, start IRQ work to update the
+ * target_cpumask
  *
  * Returns:
  * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
@@ -195,7 +293,7 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
 		 * Also, target_cpumask will be updated in a workqueue for the
 		 * next NMI IPI.
 		 */
-		cpumask_copy(hld_data->ipi_cpumask, hld_data->monitored_cpumask);
+		cpumask_copy(hld_data->ipi_cpumask, hld_data->target_cpumask);
 		/*
 		 * Even though the NMI IPI will be sent to all CPUs but self,
 		 * clear the CPU to identify a potential unrelated NMI.
@@ -205,6 +303,7 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
 			apic->send_IPI_mask_allbutself(hld_data->ipi_cpumask,
 						       NMI_VECTOR);
 
+		irq_work_queue(&hdata->affinity_work);
 		kick_timer(hdata, !(hdata->has_periodic));
 
 		inspect_for_hardlockups(regs);
@@ -263,6 +362,7 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 				   hardlockup_detector_nmi_handler, 0,
 				   "hpet_hld");
 
+	init_irq_work(&hdata->affinity_work, update_timer_irq_affinity);
 	return ret;
 }
 
@@ -278,6 +378,8 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, hld_data->monitored_cpumask);
 
+	update_ipi_target_cpumask(hld_data);
+
 	/*
 	 * If this is the first CPU on which the detector is enabled,
 	 * start everything.
@@ -318,6 +420,9 @@ void hardlockup_detector_hpet_disable(unsigned int cpu)
 
 	hld_data->handling_cpu = cpumask_first(hld_data->monitored_cpumask);
 	update_msi_destid(hld_data);
+
+	update_ipi_target_cpumask(hld_data);
+
 	enable_timer(hld_data);
 }
 
@@ -365,6 +470,9 @@ int __init hardlockup_detector_hpet_init(void)
 	if (!zalloc_cpumask_var(&hld_data->ipi_cpumask, GFP_KERNEL))
 		goto err_no_ipi_cpumask;
 
+	if (!zalloc_cpumask_var(&hld_data->target_cpumask, GFP_KERNEL))
+		goto err_no_target_cpumask;
+
 	v = hpet_readl(HPET_Tn_CFG(hld_data->channel));
 	v |= HPET_TN_32BIT;
 
@@ -372,6 +480,8 @@ int __init hardlockup_detector_hpet_init(void)
 
 	return ret;
 
+err_no_target_cpumask:
+	free_cpumask_var(hld_data->ipi_cpumask);
 err_no_ipi_cpumask:
 	free_cpumask_var(hld_data->monitored_cpumask);
 err_no_monitored_cpumask:
-- 
2.17.1

