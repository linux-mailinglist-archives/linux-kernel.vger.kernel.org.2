Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B40373056
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhEDTIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:38656 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhEDTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:23 -0400
IronPort-SDR: E+qhf3n+pn+w3icKJJ/2zCu4GiOTTePsSZJHbK8PBhpNmxm4kZXrqeR6hvvOncsZC5pHBZicCF
 pVF6gsYht6/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269900"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269900"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:17 -0700
IronPort-SDR: dpgF/rAXIVRRboh748g/r+IyFdbUsg0n6Fwj+7Cv7Qppg0eO5diMEU/iwinFEKJBibeG3C5ZI/
 RdkCIP71J/Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591736"
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
Subject: [RFC PATCH v5 07/16] x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
Date:   Tue,  4 May 2021 12:05:17 -0700
Message-Id: <20210504190526.22347-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a hardlockup detector that uses the HPET timer as the source of
the non-maskable interrupt. Implement the basic functionality, to start
and stop the timer and configure it issue an MSI interrupt (write directly
to the HPET MSI registers instead the interrupt subsystem). Hence, the
detector relies on an HPET channel capable of Front Side Bus interrupts.

A single CPU, the handling CPU, will service the non-maskable interrupt
from the HPET timer. Then, it will issue an inter-processor interrupt
to the rest of the CPUs monitored by the detector.

The detector is not functional at this stage. A subsequent changeset will
invoke the interfaces implemented in this changeset as well as
functionality to determine if the HPET timer caused the NMI. For now,
implement a stub function.

HPET registers are only accessed to kick the timer after looking for
hardlockups. If the HPET channel is periodic, there is no need to write
to the HPET registers at all in interrupt context. On all the systems I
inspected, only the first channel of the timer is periodic and it will
usually be reserved for the HPET legacy clockevent. Thus, in most of the
cases the detector will be assigned a non-periodic channel.

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
 * Dropped hpet_hld_data.enabled_cpus and instead use cpumask_weight().
 * Renamed hpet_hld_data.cpu_monitored_mask to
   hld_data_data.cpu_monitored_mask and converted it to cpumask_var_t.
 * Flushed out any outstanding interrupt before enabling the HPET channel.
 * Removed unnecessary MSI_DATA_LEVEL_ASSERT from the MSI message.
 * Added comments in hardlockup_detector_nmi_handler() to explain how
   CPUs are targeted for an IPI.
 * Updated code to only issue an IPI when needed (i.e., there are monitored
   CPUs to be inspected via an IPI).
 * Reworked hardlockup_detector_hpet_init() for readability.
 * Now reserve the cpumasks in the hardlockup detector code and not in the
   generic HPET code.
 * Handled the case of watchdog_thresh = 0 when disabling the detector.
 * Made this detector available to i386.
 * Reworked logic to kick the timer to remove a local variable. (Andi)
 * Added a comment on what type of timer channel will be assigned to the
   detector. (Andi)
 * Reworded prompt comment in Kconfig. (Andi)
 * Removed unneeded switch to level interrupt mode when disabling the
   timer. (Andi)
 * Disabled the HPET timer to avoid a race between an incoming interrupt
   and an update of the MSI destination ID. (Ashok)
 * Corrected a typo in an inline comment. (Tony)
 * Made the HPET hardlockup detector depend on HARDLOCKUP_DETECTOR instead
   of selecting it.

Changes since v3:
 * Fixed typo in Kconfig.debug. (Randy Dunlap)
 * Added missing slab.h to include the definition of kfree to fix a build
   break.

Changes since v2:
 * Removed use of struct cpumask in favor of a variable length array in
   conjunction with kzalloc. (Peter Zijlstra)
 * Removed redundant documentation of functions. (Thomas Gleixner)
 * Added CPU as argument hardlockup_detector_hpet_enable()/disable().
   (Thomas Gleixner).

Changes since v1:
 * Do not target CPUs in a round-robin manner. Instead, the HPET timer
   always targets the same CPU; other CPUs are monitored via an
   interprocessor interrupt.
 * Dropped support for IO APIC interrupts and instead use only MSI
   interrupts.
 * Removed use of generic irq code to set interrupt affinity and NMI
   delivery. Instead, configure the interrupt directly in HPET registers.
   (Thomas Gleixner)
 * Fixed unconditional return NMI_HANDLED when the HPET timer is
   programmed for FSB/MSI delivery. (Peter Zijlstra)
---
 arch/x86/Kconfig.debug              |  10 +
 arch/x86/include/asm/hpet.h         |  21 ++
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/watchdog_hld_hpet.c | 384 ++++++++++++++++++++++++++++
 4 files changed, 416 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld_hpet.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 80b57e7f4947..0731da557a6d 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -117,6 +117,16 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR_HPET
+	bool "HPET Timer for Hard Lockup Detection"
+	select HARDLOCKUP_DETECTOR_CORE
+	depends on HARDLOCKUP_DETECTOR && HPET_TIMER && HPET && (X86_64 || X86_32)
+	help
+	  The hardlockup detector is driven by one counter of the Performance
+	  Monitoring Unit (PMU) per CPU. Say y to instead drive the
+	  hardlockup detector using a High-Precision Event Timer and make the
+	  PMU counters available for other purposes.
+
 config X86_DECODER_SELFTEST
 	bool "x86 instruction decoder selftest"
 	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index f1e41c11c29f..b1c8d5ce7e13 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_HPET_H
 
 #include <linux/msi.h>
+#include <linux/irq_work.h>
 
 #ifdef CONFIG_HPET_TIMER
 
@@ -102,15 +103,35 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @channel:			HPET channel assigned to the detector
  * @ticks_per_second:		Frequency of the HPET timer
  * @irq:			IRQ number assigned to the HPET channel
+ * @handling_cpu:		CPU handling the HPET interrupt
+ * @msi_msg:			MSI message to be written it the HPET registers
+ * @monitored_cpumask:		CPUs monitored by the hardlockup detector
+ * @ipi_cpumask:		Auxiliary mask to handle IPIs. Both sending and
+ *				receiving CPUs write to it. Hence, we cannot
+ *				reuse @monitored_cpumask.
  */
 struct hpet_hld_data {
 	bool		has_periodic;
 	u32		channel;
 	u64		ticks_per_second;
 	int		irq;
+	u32		handling_cpu;
+	struct msi_msg	msi_msg;
+	cpumask_var_t	monitored_cpumask;
+	cpumask_var_t	ipi_cpumask;
 };
 
 extern struct hpet_hld_data *hpet_hld_get_timer(void);
+extern int hardlockup_detector_hpet_init(void);
+extern void hardlockup_detector_hpet_stop(void);
+extern void hardlockup_detector_hpet_enable(unsigned int cpu);
+extern void hardlockup_detector_hpet_disable(unsigned int cpu);
+#else
+static inline int hardlockup_detector_hpet_init(void)
+{ return -ENODEV; }
+static inline void hardlockup_detector_hpet_stop(void) {}
+static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
+static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0704c2a94272..5d1a90b23577 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
new file mode 100644
index 000000000000..47fc2cb540de
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hardlockup detector driven by an HPET timer.
+ *
+ * Copyright (C) Intel Corporation 2021
+ *
+ * A hardlockup detector driven by an HPET timer. It implements the same
+ * interfaces as the PMU-based hardlockup detector.
+ *
+ * A single HPET timer is used to monitor all the CPUs from the allowed_mask
+ * from kernel/watchdog.c. Thus, the timer is programmed to expire every
+ * watchdog_thresh/cpumask_weight(watchdog_allowed_cpumask). The timer targets
+ * CPUs in round robin manner. Thus, every cpu in watchdog_allowed_mask is
+ * monitored every watchdog_thresh seconds.
+ */
+
+#define pr_fmt(fmt) "NMI hpet watchdog: " fmt
+
+#include <linux/nmi.h>
+#include <linux/slab.h>
+
+#include <asm/apic.h>
+#include <asm/hpet.h>
+
+static struct hpet_hld_data *hld_data;
+static bool hardlockup_use_hpet;
+
+/**
+ * kick_timer() - Reprogram timer to expire in the future
+ * @hdata:	A data structure with the timer instance to update
+ * @force:	Force reprogramming
+ *
+ * Reprogram the timer to expire within watchdog_thresh seconds in the future.
+ * If the timer supports periodic mode, it is not kicked unless @force is
+ * true.
+ */
+static void kick_timer(struct hpet_hld_data *hdata, bool force)
+{
+	u64 new_compare, count, period = 0;
+
+	/* kick the timer only when needed */
+	if (!force && hdata->has_periodic)
+		return;
+
+	/*
+	 * Update the comparator in increments of watch_thresh seconds relative
+	 * to the current count. Since watch_thresh is given in seconds, we
+	 * are able to update the comparator before the counter reaches such new
+	 * value.
+	 *
+	 * Let it wrap around if needed.
+	 */
+
+	count = hpet_readl(HPET_COUNTER);
+	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+
+	if (!hdata->has_periodic) {
+		hpet_writel(new_compare, HPET_Tn_CMP(hdata->channel));
+		return;
+	}
+
+	period = watchdog_thresh * hdata->ticks_per_second;
+	hpet_set_comparator_periodic(hdata->channel, (u32)new_compare,
+				     (u32)period);
+}
+
+static void disable_timer(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->channel));
+	v &= ~HPET_TN_ENABLE;
+	if (hld_data->has_periodic)
+		v &= ~HPET_TN_PERIODIC;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+}
+
+static void enable_timer(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->channel));
+	/* Make sure we flush any outstanding interrupt. */
+	v |= HPET_TN_LEVEL;
+	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+	hpet_writel(1 << hdata->channel, HPET_STATUS);
+
+	v &= ~HPET_TN_LEVEL;
+	if (hld_data->has_periodic)
+		v |= HPET_TN_PERIODIC;
+	else
+		v &= ~HPET_TN_PERIODIC;
+
+	v |= HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+}
+
+/**
+ * is_hpet_wdt_interrupt() - Check if an HPET timer caused the interrupt
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * Returns:
+ * True if the HPET watchdog timer caused the interrupt. False otherwise.
+ */
+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+	return false;
+}
+
+/**
+ * compose_msi_msg() - Populate address and data fields of an MSI message
+ * @hdata:	A data strucure with the message to populate
+ *
+ * Initialize the fields of the MSI message to deliver an NMI interrupt. This
+ * function only initialize the files that don't change during the operation of
+ * the detector. This function does not populate the Destination ID; which
+ * should be populated using update_msi_destid().
+ */
+static void compose_msi_msg(struct hpet_hld_data *hdata)
+{
+	struct msi_msg *msg = &hdata->msi_msg;
+
+	memset(msg, 0, sizeof(*msg));
+	/*
+	 * The HPET FSB Interrupt Route register does not have an
+	 * address_hi part.
+	 */
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
+
+	/*
+	 * Since delivery mode is NMI, no irq vector is needed.
+	 */
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_NMI;
+}
+
+/**
+ * update_msi_destid() - Update APIC destid of handling CPU
+ * @hdata:	A data strucure with the MSI message to update
+ *
+ * Update the APIC destid of the MSI message generated by the HPET timer
+ * on expiration.
+ */
+static int update_msi_destid(struct hpet_hld_data *hdata)
+{
+	u32 destid;
+
+	destid = apic->calc_dest_apicid(hdata->handling_cpu);
+	/*
+	 * HPET only supports a 32-bit MSI address register. Thus, only
+	 * 8-bit APIC IDs are supported. Systems with more than 256 CPUs
+	 * should use interrupt remapping.
+	 */
+	WARN_ON_ONCE(destid > 0xff);
+
+	hdata->msi_msg.arch_addr_lo.destid_0_7 = destid & 0xff;
+
+	/*
+	 * Disable the timer to avoid getting an interrupt while updating
+	 * the handlingt CPU.
+	 */
+	disable_timer(hdata);
+	hpet_writel(hdata->msi_msg.address_lo,
+		    HPET_Tn_ROUTE(hdata->channel) + 4);
+	enable_timer(hdata);
+
+	return 0;
+}
+
+/**
+ * hardlockup_detector_nmi_handler() - NMI Interrupt handler
+ * @type:	Type of NMI handler; not used.
+ * @regs:	Register values as seen when the NMI was asserted
+ *
+ * Check if it was caused by the expiration of the HPET timer. If yes, inspect
+ * for lockups by issuing an IPI to all the monitored CPUs. Also, kick the
+ * timer if it is non-periodic.
+ *
+ * Returns:
+ * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
+ * otherwise.
+ */
+static int hardlockup_detector_nmi_handler(unsigned int type,
+					   struct pt_regs *regs)
+{
+	struct hpet_hld_data *hdata = hld_data;
+	int cpu = smp_processor_id();
+
+	if (is_hpet_wdt_interrupt(hdata)) {
+		/*
+		 * Make a copy of the target mask. We need this as once a CPU
+		 * gets the watchdog NMI it will clear itself from ipi_cpumask.
+		 * Also, target_cpumask will be updated in a workqueue for the
+		 * next NMI IPI.
+		 */
+		cpumask_copy(hld_data->ipi_cpumask, hld_data->monitored_cpumask);
+		/*
+		 * Even though the NMI IPI will be sent to all CPUs but self,
+		 * clear the CPU to identify a potential unrelated NMI.
+		 */
+		cpumask_clear_cpu(cpu, hld_data->ipi_cpumask);
+		if (cpumask_weight(hld_data->ipi_cpumask))
+			apic->send_IPI_mask_allbutself(hld_data->ipi_cpumask,
+						       NMI_VECTOR);
+
+		kick_timer(hdata, !(hdata->has_periodic));
+
+		inspect_for_hardlockups(regs);
+
+		return NMI_HANDLED;
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, hld_data->ipi_cpumask)) {
+		inspect_for_hardlockups(regs);
+		return NMI_HANDLED;
+	}
+
+	return NMI_DONE;
+}
+
+/**
+ * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the HPET timer to deliver interrupts via the Front-
+ * Side Bus.
+ */
+static void setup_irq_msi_mode(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	compose_msi_msg(hdata);
+	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->channel));
+	hpet_writel(hdata->msi_msg.address_lo,
+		    HPET_Tn_ROUTE(hdata->channel) + 4);
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->channel));
+	v |= HPET_TN_FSB;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+}
+
+/**
+ * setup_hpet_irq() - Configure the interrupt delivery of an HPET timer
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the interrupt parameters of an HPET timer. If supported, configure
+ * interrupts to be delivered via the Front-Side Bus. Also, install an interrupt
+ * handler.
+ *
+ * Returns:
+ * 0 success. An error code if setup was unsuccessful.
+ */
+static int setup_hpet_irq(struct hpet_hld_data *hdata)
+{
+	int ret;
+
+	setup_irq_msi_mode(hdata);
+
+	ret = register_nmi_handler(NMI_WATCHDOG,
+				   hardlockup_detector_nmi_handler, 0,
+				   "hpet_hld");
+
+	return ret;
+}
+
+/**
+ * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
+ * @cpu:	CPU Index in which the watchdog will be enabled.
+ *
+ * Enable the hardlockup detector in @cpu. This means adding it to the
+ * cpumask of monitored CPUs and starting the detectot if not done
+ * before.
+ */
+void hardlockup_detector_hpet_enable(unsigned int cpu)
+{
+	cpumask_set_cpu(cpu, hld_data->monitored_cpumask);
+
+	/*
+	 * If this is the first CPU on which the detector is enabled,
+	 * start everything.
+	 */
+	if (cpumask_weight(hld_data->monitored_cpumask) == 1) {
+		hld_data->handling_cpu = cpu;
+		update_msi_destid(hld_data);
+		kick_timer(hld_data, true);
+		enable_timer(hld_data);
+	}
+}
+
+/**
+ * hardlockup_detector_hpet_disable() - Disable the hardlockup detector
+ * @cpu:	CPU index in which the watchdog will be disabled
+ *
+ * @cpu is removed from the cpumask of monitored CPUs. If @cpu is also the CPU
+ * handling the timer interrupt, update it to be the next available, monitored,
+ * CPU.
+ */
+void hardlockup_detector_hpet_disable(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, hld_data->monitored_cpumask);
+
+	if (hld_data->handling_cpu != cpu)
+		return;
+
+	disable_timer(hld_data);
+	if (!cpumask_weight(hld_data->monitored_cpumask))
+		return;
+
+	/*
+	 * If watchdog_thresh is zero, then the hardlockup detector is being
+	 * disabled.
+	 */
+	if (!watchdog_thresh)
+		return;
+
+	hld_data->handling_cpu = cpumask_first(hld_data->monitored_cpumask);
+	update_msi_destid(hld_data);
+	enable_timer(hld_data);
+}
+
+void hardlockup_detector_hpet_stop(void)
+{
+	disable_timer(hld_data);
+}
+
+/**
+ * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
+ *
+ * Only initialize and configure the detector if an HPET is available on the
+ * system.
+ *
+ * Returns:
+ * 0 success. An error code if initialization was unsuccessful.
+ */
+int __init hardlockup_detector_hpet_init(void)
+{
+	int ret;
+	u32 v;
+
+	if (!hardlockup_use_hpet)
+		return -ENODEV;
+
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	if (check_tsc_unstable())
+		return -ENODEV;
+
+	hld_data = hpet_hld_get_timer();
+	if (!hld_data)
+		return -ENODEV;
+
+	disable_timer(hld_data);
+
+	ret = setup_hpet_irq(hld_data);
+	if (ret)
+		goto err_no_irq;
+
+	if (!zalloc_cpumask_var(&hld_data->monitored_cpumask, GFP_KERNEL))
+		goto err_no_monitored_cpumask;
+
+	if (!zalloc_cpumask_var(&hld_data->ipi_cpumask, GFP_KERNEL))
+		goto err_no_ipi_cpumask;
+
+	v = hpet_readl(HPET_Tn_CFG(hld_data->channel));
+	v |= HPET_TN_32BIT;
+
+	hpet_writel(v, HPET_Tn_CFG(hld_data->channel));
+
+	return ret;
+
+err_no_ipi_cpumask:
+	free_cpumask_var(hld_data->monitored_cpumask);
+err_no_monitored_cpumask:
+	ret = -ENOMEM;
+err_no_irq:
+	kfree(hld_data);
+	hld_data = NULL;
+
+	return ret;
+}
-- 
2.17.1

