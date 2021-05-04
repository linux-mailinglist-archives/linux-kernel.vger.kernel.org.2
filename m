Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DC37307E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhEDTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:18330 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhEDTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:37 -0400
IronPort-SDR: lU9RgXe944TDXg6GwSX3wo3fOYQwt4GT7K9dAAAm1UHa6o6e4INCyN+Zgbngr7oKBpfE+YCmdX
 6/MtyZx2oYSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="177599157"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="177599157"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:41 -0700
IronPort-SDR: L+c1poPB/6U0UrTibGWyGf6yG6X42kx+7mMI6iJsAfAi+PloL+6GLUjp0nmMu6l3ZK7X6CUq1A
 GWav4vbSnuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245307"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:41 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     woodhouse@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [RFC PATCH v5 7/7] x86/watchdog/hardlockup/hpet: Support interrupt remapping
Date:   Tue,  4 May 2021 12:10:49 -0700
Message-Id: <20210504191049.22661-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interrupt remapping is enabled in the system, the MSI interrupt
address and data fields must follow a special format that the IOMMU
defines.

However, the HPET hardlockup detector must rely on the interrupt
subsystem to have the interrupt remapping drivers allocate, activate,
and set the affinity of HPET timer interrupt. Hence, it must use
request_irq() to use such functionality.

In x86 there is not an IRQF_NMI flag to indicate to the interrupt
subsystem the delivery mode of the interrupt. A previous changset added
functionality to detect the interrupt of the HPET hardlockup detector
and fixup the delivery mode accordingly.

Also, since request_irq() is used, a non-NMI interrupt handler must be
defined. Even if it is not needed.

When Interrupt Remapping is enabled, use the new facility to ensure
interrupt is plumbed properly to work with interrupt remapping.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org> (supporter:INTEL IOMMU (VT-d))
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com> (supporter:INTEL IOMMU (VT-d))
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org (open list:INTEL IOMMU (VT-d))
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Use request_irq() to obtain an IRTE for the HPET hardlockup detector
   instead of the custom interfaces previously implemented in the
   interrupt remapping drivers.
 * Simplified detection of interrupt remapping by checking the parent
   of the HPET irq domain.
 * Stopped using the HPET magic fields of struct irq_alloc_info. They
   were removed in commit 2bf1e7bcedb8 ("x86/msi: Consolidate HPET
   allocation")
 * Rephrased commit message for clarity. (Ashok)
 * Clarified error message of non-NMI handler. (Ashok)

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch. Added custom functions in the Intel IOMMU driver
   to allocate an IRTE for the HPET hardlockup detector.
---
 arch/x86/include/asm/hpet.h         |  2 ++
 arch/x86/kernel/hpet.c              |  3 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 48 +++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 5bf675970d4b..d130285ddc96 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -109,6 +109,7 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @tsc_ticks_per_group:	TSC ticks that must elapse for each group of
  *				monitored CPUs.
  * @irq:			IRQ number assigned to the HPET channel
+ * @int_remap_enabled:		True if interrupt remapping is enabled
  * @handling_cpu:		CPU handling the HPET interrupt
  * @pkgs_per_group:		Number of physical packages in a group of CPUs
  *				receiving an IPI
@@ -133,6 +134,7 @@ struct hpet_hld_data {
 	u64		tsc_next;
 	u64		tsc_ticks_per_group;
 	int		irq;
+	bool		intr_remap_enabled;
 	u32		handling_cpu;
 	u32		pkgs_per_group;
 	u32		nr_groups;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3e43e0f348b8..ff4abdef5e15 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1464,6 +1464,9 @@ struct hpet_hld_data *hpet_hld_get_timer(void)
 	if (!hpet_domain)
 		goto err;
 
+	if (hpet_domain->parent != x86_vector_domain)
+		hld_data->intr_remap_enabled = true;
+
 	hc->mode = HPET_MODE_NMI_WATCHDOG;
 	irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 	if (irq <= 0)
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 3fd2405b31fa..265641d001ac 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -176,6 +176,14 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
 {
 	u32 destid;
 
+	if (hdata->intr_remap_enabled) {
+		int ret;
+
+		ret = irq_set_affinity(hdata->irq,
+				       cpumask_of(hdata->handling_cpu));
+		return ret;
+	}
+
 	destid = apic->calc_dest_apicid(hdata->handling_cpu);
 	/*
 	 * HPET only supports a 32-bit MSI address register. Thus, only
@@ -393,26 +401,52 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
 	return NMI_DONE;
 }
 
+/*
+ * When interrupt remapping is enabled, we request the irq for the detector
+ * using request_irq() and then we fixup the delivery mode to NMI using
+ * is_hpet_irq_hardlockup_detector(). If the latter fails, we will see a non-
+ * NMI interrupt.
+ *
+ */
+static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
+{
+	pr_err_once("Received a non-NMI interrupt. The HLD detector always uses NMIs!\n");
+	return IRQ_HANDLED;
+}
+
 /**
  * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
  * @data:	Data associated with the instance of the HPET timer to configure
  *
  * Configure the HPET timer to deliver interrupts via the Front-
  * Side Bus.
+ *
+ * Returns:
+ * 0 success. An error code if setup was unsuccessful.
  */
-static void setup_irq_msi_mode(struct hpet_hld_data *hdata)
+static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
 {
+	s32 ret;
 	u32 v;
 
-	compose_msi_msg(hdata);
-	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->channel));
-	hpet_writel(hdata->msi_msg.address_lo,
-		    HPET_Tn_ROUTE(hdata->channel) + 4);
+	if (hdata->intr_remap_enabled) {
+		ret = request_irq(hld_data->irq, hardlockup_detector_irq_handler,
+				  IRQF_TIMER, "hpet_hld", hld_data);
+		if (ret)
+			return ret;
+	} else {
+		compose_msi_msg(hdata);
+		hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->channel));
+		hpet_writel(hdata->msi_msg.address_lo,
+			    HPET_Tn_ROUTE(hdata->channel) + 4);
+	}
 
 	v = hpet_readl(HPET_Tn_CFG(hdata->channel));
 	v |= HPET_TN_FSB;
 
 	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+
+	return 0;
 }
 
 /**
@@ -430,7 +464,9 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 {
 	int ret;
 
-	setup_irq_msi_mode(hdata);
+	ret = setup_irq_msi_mode(hdata);
+	if (ret)
+		return ret;
 
 	ret = register_nmi_handler(NMI_WATCHDOG,
 				   hardlockup_detector_nmi_handler, 0,
-- 
2.17.1

