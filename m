Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3133B77D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhF2SbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:31:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:12481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235103AbhF2SbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:31:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269341965"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="269341965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="408270463"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2021 11:28:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/6] perf/x86/intel/uncore: Add Sapphire Rapids server support
Date:   Tue, 29 Jun 2021 11:13:58 -0700
Message-Id: <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel Sapphire Rapids supports a discovery mechanism, that allows an
uncore driver to discover the different components ("boxes") of the
chip.

All the generic information of the uncore boxes should be retrieved from
the discovery tables. This has been enabled with the commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
use_discovery to indicate the case. The uncore driver doesn't need to
hard code the generic information for each uncore box.

But we still need to enable various functionality that cannot be
directly discovered. This is done here.
 - Add a meaningful name for each uncore block.
 - Add CHA filter support.
 - The layout of the control registers for each uncore block is a little
   bit different from the generic one. Set the platform specific format
   and ops. Expose the common ops which can be reused.
 - Add a fixed counter for IMC

All the undiscovered platform-specific features are hard code in the
spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
to only overwrite these features.

Only the uncore blocks which are inculded in the discovery tables are
enabled here. Other uncore blocks, e.g., free-running counters, will be
supported in the following patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  26 ++-
 arch/x86/events/intel/uncore.h           |   3 +
 arch/x86/events/intel/uncore_discovery.c |  32 ++--
 arch/x86/events/intel/uncore_discovery.h |  21 +++
 arch/x86/events/intel/uncore_snbep.c     | 292 +++++++++++++++++++++++++++++++
 5 files changed, 354 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index df7b07d..7087ce7 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -869,9 +869,13 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 			sprintf(pmu->name, "uncore_%s", type->name);
 		else
 			sprintf(pmu->name, "uncore");
-	} else
-		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
-
+	} else {
+		/*
+		 * Use the box ID from the discovery table if applicable.
+		 */
+		sprintf(pmu->name, "uncore_%s_%d", type->name,
+			type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx);
+	}
 }
 
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
@@ -1667,6 +1671,7 @@ struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
+	bool	use_discovery;
 };
 
 static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
@@ -1769,6 +1774,13 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.mmio_init = snr_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
+	.cpu_init = spr_uncore_cpu_init,
+	.pci_init = spr_uncore_pci_init,
+	.mmio_init = spr_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
@@ -1813,6 +1825,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
@@ -1836,8 +1849,13 @@ static int __init intel_uncore_init(void)
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
-	} else
+	} else {
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
+		if (uncore_no_discover && uncore_init->use_discovery)
+			return -ENODEV;
+		if (uncore_init->use_discovery && !intel_uncore_has_discovery_tables())
+			return -ENODEV;
+	}
 
 	if (uncore_init->pci_init) {
 		pret = uncore_init->pci_init();
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 2917910..6d44b7e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -607,6 +607,9 @@ void snr_uncore_mmio_init(void);
 int icx_uncore_pci_init(void);
 void icx_uncore_cpu_init(void);
 void icx_uncore_mmio_init(void);
+int spr_uncore_pci_init(void);
+void spr_uncore_cpu_init(void);
+void spr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index aba9bff..2de5563 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -337,17 +337,17 @@ static const struct attribute_group generic_uncore_format_group = {
 	.attrs = generic_uncore_formats_attr,
 };
 
-static void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
 }
 
-static void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
 }
 
-static void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrl(uncore_msr_box_ctl(box), 0);
 }
@@ -377,7 +377,7 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
-static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -386,7 +386,7 @@ static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
 }
 
-static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -394,7 +394,7 @@ static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
 
-static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -403,7 +403,7 @@ static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 }
 
 static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
-					    struct perf_event *event)
+						  struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
@@ -411,8 +411,8 @@ static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, hwc->config);
 }
 
-static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
-					     struct perf_event *event)
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
@@ -420,8 +420,8 @@ static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, 0);
 }
 
-static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
-					   struct perf_event *event)
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
@@ -454,7 +454,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
 }
 
-static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
 	struct intel_uncore_type *type = box->pmu->type;
@@ -478,7 +478,7 @@ static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -486,7 +486,7 @@ static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_FRZ, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -505,7 +505,7 @@ static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
 	writel(hwc->config, box->io_addr + hwc->config_base);
 }
 
-static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
 					      struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -568,7 +568,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 	return true;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 {
 	struct intel_uncore_discovery_type *type;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 1d65293..b85655b 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -129,3 +129,24 @@ void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
+
+void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
+
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event);
+
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event);
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event);
+
+struct intel_uncore_type **
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a75a2c..44f2469 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
 #include "uncore.h"
+#include "uncore_discovery.h"
 
 /* SNB-EP pci bus to socket mapping */
 #define SNBEP_CPUNODEID			0x40
@@ -447,6 +448,17 @@
 #define ICX_NUMBER_IMC_CHN			2
 #define ICX_IMC_MEM_STRIDE			0x4
 
+/* SPR */
+#define SPR_RAW_EVENT_MASK_EXT			0xffffff
+
+/* SPR CHA */
+#define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
+#define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
+						 SPR_CHA_PMON_CTL_TID_EN)
+#define SPR_CHA_PMON_BOX_FILTER_TID		0x3ff
+
+#define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -459,6 +471,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
+DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
 DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
@@ -5346,3 +5359,282 @@ void icx_uncore_mmio_init(void)
 }
 
 /* end of ICX uncore support */
+
+/* SPR uncore support */
+
+static void spr_uncore_msr_enable_event(struct intel_uncore_box *box,
+					struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+
+	if (reg1->idx != EXTRA_REG_NONE)
+		wrmsrl(reg1->reg, reg1->config);
+
+	wrmsrl(hwc->config_base, hwc->config);
+}
+
+static void spr_uncore_msr_disable_event(struct intel_uncore_box *box,
+					 struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event_extra *reg1 = &hwc->extra_reg;
+
+	if (reg1->idx != EXTRA_REG_NONE)
+		wrmsrl(reg1->reg, 0);
+
+	wrmsrl(hwc->config_base, 0);
+}
+
+static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
+	bool tie_en = !!(event->hw.config & SPR_CHA_PMON_CTL_TID_EN);
+	struct intel_uncore_type *type = box->pmu->type;
+
+	if (tie_en) {
+		reg1->reg = SPR_C0_MSR_PMON_BOX_FILTER0 +
+			    HSWEP_CBO_MSR_OFFSET * type->box_ids[box->pmu->pmu_idx];
+		reg1->config = event->attr.config1 & SPR_CHA_PMON_BOX_FILTER_TID;
+		reg1->idx = 0;
+	}
+
+	return 0;
+}
+
+static struct intel_uncore_ops spr_uncore_chabox_ops = {
+	.init_box		= intel_generic_uncore_msr_init_box,
+	.disable_box		= intel_generic_uncore_msr_disable_box,
+	.enable_box		= intel_generic_uncore_msr_enable_box,
+	.disable_event		= spr_uncore_msr_disable_event,
+	.enable_event		= spr_uncore_msr_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= spr_cha_hw_config,
+	.get_constraint		= uncore_get_constraint,
+	.put_constraint		= uncore_put_constraint,
+};
+
+static struct attribute *spr_uncore_cha_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_tid_en2.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	&format_attr_filter_tid5.attr,
+	NULL,
+};
+static const struct attribute_group spr_uncore_chabox_format_group = {
+	.name = "format",
+	.attrs = spr_uncore_cha_formats_attr,
+};
+
+static struct intel_uncore_type spr_uncore_chabox = {
+	.name			= "cha",
+	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.num_shared_regs	= 1,
+	.ops			= &spr_uncore_chabox_ops,
+	.format_group		= &spr_uncore_chabox_format_group,
+};
+
+static struct intel_uncore_type spr_uncore_iio = {
+	.name			= "iio",
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.format_group		= &snr_uncore_iio_format_group,
+};
+
+static struct attribute *spr_uncore_raw_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group spr_uncore_raw_format_group = {
+	.name = "format",
+	.attrs = spr_uncore_raw_formats_attr,
+};
+
+#define SPR_UNCORE_COMMON_FORMAT()				\
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,	\
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,	\
+	.format_group		= &spr_uncore_raw_format_group
+
+static struct intel_uncore_type spr_uncore_irp = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "irp",
+
+};
+
+static struct intel_uncore_type spr_uncore_m2pcie = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "m2pcie",
+};
+
+static struct intel_uncore_type spr_uncore_pcu = {
+	.name			= "pcu",
+};
+
+static void spr_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					 struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	if (uncore_pmc_fixed(hwc->idx))
+		writel(SNBEP_PMON_CTL_EN, box->io_addr + hwc->config_base);
+	else
+		writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops spr_uncore_mmio_ops = {
+	.init_box		= intel_generic_uncore_mmio_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= spr_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type spr_uncore_imc = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "imc",
+	.fixed_ctr_bits		= 48,
+	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.ops			= &spr_uncore_mmio_ops,
+};
+
+static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
+					struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+	pci_write_config_dword(pdev, hwc->config_base, (u32)hwc->config);
+}
+
+static struct intel_uncore_ops spr_uncore_pci_ops = {
+	.init_box		= intel_generic_uncore_pci_init_box,
+	.disable_box		= intel_generic_uncore_pci_disable_box,
+	.enable_box		= intel_generic_uncore_pci_enable_box,
+	.disable_event		= intel_generic_uncore_pci_disable_event,
+	.enable_event		= spr_uncore_pci_enable_event,
+	.read_counter		= intel_generic_uncore_pci_read_counter,
+};
+
+#define SPR_UNCORE_PCI_COMMON_FORMAT()			\
+	SPR_UNCORE_COMMON_FORMAT(),			\
+	.ops			= &spr_uncore_pci_ops
+
+static struct intel_uncore_type spr_uncore_m2m = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m2m",
+};
+
+static struct intel_uncore_type spr_uncore_upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "upi",
+};
+
+static struct intel_uncore_type spr_uncore_m3upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m3upi",
+};
+
+static struct intel_uncore_type spr_uncore_mdf = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "mdf",
+};
+
+#define UNCORE_SPR_NUM_UNCORE_TYPES		12
+
+static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
+	&spr_uncore_chabox,
+	&spr_uncore_iio,
+	&spr_uncore_irp,
+	&spr_uncore_m2pcie,
+	&spr_uncore_pcu,
+	NULL,
+	&spr_uncore_imc,
+	&spr_uncore_m2m,
+	&spr_uncore_upi,
+	&spr_uncore_m3upi,
+	NULL,
+	&spr_uncore_mdf,
+};
+
+static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
+					struct intel_uncore_type *from_type)
+{
+	if (!to_type || !from_type)
+		return;
+
+	if (from_type->name)
+		to_type->name = from_type->name;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->event_mask)
+		to_type->event_mask = from_type->event_mask;
+	if (from_type->event_mask_ext)
+		to_type->event_mask_ext = from_type->event_mask_ext;
+	if (from_type->fixed_ctr)
+		to_type->fixed_ctr = from_type->fixed_ctr;
+	if (from_type->fixed_ctl)
+		to_type->fixed_ctl = from_type->fixed_ctl;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->num_shared_regs)
+		to_type->num_shared_regs = from_type->num_shared_regs;
+	if (from_type->constraints)
+		to_type->constraints = from_type->constraints;
+	if (from_type->ops)
+		to_type->ops = from_type->ops;
+	if (from_type->event_descs)
+		to_type->event_descs = from_type->event_descs;
+	if (from_type->format_group)
+		to_type->format_group = from_type->format_group;
+}
+
+static struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id)
+{
+	struct intel_uncore_type **types, **start_types;
+
+	start_types = types = intel_uncore_generic_init_uncores(type_id);
+
+	/* Only copy the customized features */
+	for (; *types; types++) {
+		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
+			continue;
+		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
+	}
+
+	return start_types;
+}
+
+void spr_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR);
+}
+
+int spr_uncore_pci_init(void)
+{
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI);
+	return 0;
+}
+
+void spr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO);
+}
+
+/* end of SPR uncore support */
-- 
2.7.4

