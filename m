Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FD37306A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhEDTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:09:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:38664 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhEDTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:24 -0400
IronPort-SDR: crraK8QE7BAdhi6/lwAVbA2FFye/kPOd2Lj7XxIARS9YjByR5YfVfklH9CnDbdej+MWud7CHSf
 1AAqxjgpSGCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269908"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269908"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:17 -0700
IronPort-SDR: dDkFuyKk0UREXRiBmg3rV/awumu+rtPp948/d8x2PE4l3KeP27DZWkUa3XOgsivucZ/0IsTT+U
 lGngrRE0Hdtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591746"
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
Subject: [RFC PATCH v5 10/16] watchdog/hardlockup/hpet: Adjust timer expiration on the number of monitored groups
Date:   Tue,  4 May 2021 12:05:20 -0700
Message-Id: <20210504190526.22347-11-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUs monitored by the HPET hardlockup detector are partitioned into
groups based on their location in a given package. The HPET timer only
targets a single CPU per package (or group of packages) at expiration. The
rest of the CPUs in the group are monitored via an IPI issued by the
handling CPU.

Each monitored CPU must be checked for hardlockups every watch_thresh
seconds. This also means that each group of CPUs must be monitored in the
same interval. Therefore, the HPET timer expiration is determined by the
watch_thresh divided by the number of groups to monitor.

Add a new member, hpet_hld_data::ticks_per_group represents the number of
times the HPET timer must tick before interrupting the handling CPU. Derive
this value from the frequency of the HPET timer and the number of groups of
CPUs.

Furthermore, update the timer expiration whenever there is a change
in the number of monitored CPUs. Namely, when enabling or disabling the
hardlockup detector in a given CPU.

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
 * Reworked computation for the number of package groups instead of the
   number of CPUs.
 * Renamed local variable temp as ticks in update_ticks_per_group().
   (Andi)

Changes since v3:
 * None

Changes since v2:
 * Since the round-robin mechanism set the affinity of the HPET timer
   interrupt is in use again, it also becomes necessary to adjust
   the timer expiration.

Changes since v1:
 * Dropped this patch as there was no need to readjust the timer
   expiration when the HPET timer only targets a single CPU.
---
 arch/x86/include/asm/hpet.h         |  3 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 47 +++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index bb76f54effe4..738fcf256b14 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -102,6 +102,8 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @has_periodic:		The HPET channel supports periodic mode
  * @channel:			HPET channel assigned to the detector
  * @ticks_per_second:		Frequency of the HPET timer
+ * @ticks_per_group:		HPET ticks per group that must elapse before
+ *				the timer expires
  * @irq:			IRQ number assigned to the HPET channel
  * @handling_cpu:		CPU handling the HPET interrupt
  * @pkgs_per_group:		Number of physical packages in a group of CPUs
@@ -123,6 +125,7 @@ struct hpet_hld_data {
 	bool		has_periodic;
 	u32		channel;
 	u64		ticks_per_second;
+	u64		ticks_per_group;
 	int		irq;
 	u32		handling_cpu;
 	u32		pkgs_per_group;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 04b354a35e68..bf3ee354907f 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -48,18 +48,26 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 	 * are able to update the comparator before the counter reaches such new
 	 * value.
 	 *
+	 * Each CPU must be monitored every watch_thresh seconds. In order to
+	 * keep the HPET channel interrupt under 1 per second, CPUs are targeted
+	 * by groups. Each group is target separately.
+	 *
+	 *   ticks_per_group = watch_thresh * ticks_per_second / nr_groups
+	 *
+	 * as computed in update_ticks_per_group().
+	 *
 	 * Let it wrap around if needed.
 	 */
 
 	count = hpet_readl(HPET_COUNTER);
-	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+	new_compare = count + watchdog_thresh * hdata->ticks_per_group;
 
 	if (!hdata->has_periodic) {
 		hpet_writel(new_compare, HPET_Tn_CMP(hdata->channel));
 		return;
 	}
 
-	period = watchdog_thresh * hdata->ticks_per_second;
+	period = watchdog_thresh * hdata->ticks_per_group;
 	hpet_set_comparator_periodic(hdata->channel, (u32)new_compare,
 				     (u32)period);
 }
@@ -411,6 +419,27 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 	return ret;
 }
 
+/**
+ * update_ticks_per_group() - Update the number of HPET ticks CPU group
+ * @hdata:     struct with the timer's the ticks-per-second and CPU mask
+ *
+ * From the overall ticks-per-second of the timer, compute the number of ticks
+ * after which the timer should expire to monitor each CPU every watch_thresh
+ * seconds. The monitored CPUs have been partitioned into groups, and the HPET
+ * channel targets one group at a time.
+ */
+static void update_ticks_per_group(struct hpet_hld_data *hdata)
+{
+	u64 ticks = hdata->ticks_per_second;
+
+	/* Only update if there are CPUs to monitor. */
+	if (!hdata->nr_groups)
+		return;
+
+	do_div(ticks, hdata->nr_groups);
+	hdata->ticks_per_group = ticks;
+}
+
 /**
  * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
  * @cpu:	CPU Index in which the watchdog will be enabled.
@@ -424,6 +453,7 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 	cpumask_set_cpu(cpu, hld_data->monitored_cpumask);
 
 	setup_cpu_groups(hld_data);
+	update_ticks_per_group(hld_data);
 
 	update_ipi_target_cpumask(hld_data);
 
@@ -436,7 +466,14 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 		update_msi_destid(hld_data);
 		kick_timer(hld_data, true);
 		enable_timer(hld_data);
+		return;
 	}
+
+	/*
+	 * Kick timer in case the number of monitored CPUs requires a change in
+	 * the timer period.
+	 */
+	kick_timer(hld_data, hld_data->has_periodic);
 }
 
 /**
@@ -469,9 +506,15 @@ void hardlockup_detector_hpet_disable(unsigned int cpu)
 	update_msi_destid(hld_data);
 
 	setup_cpu_groups(hld_data);
+	update_ticks_per_group(hld_data);
 
 	update_ipi_target_cpumask(hld_data);
 
+	/*
+	 * Kick timer in case the number of monitored CPUs requires a change in
+	 * the timer period.
+	 */
+	kick_timer(hld_data, hld_data->has_periodic);
 	enable_timer(hld_data);
 }
 
-- 
2.17.1

