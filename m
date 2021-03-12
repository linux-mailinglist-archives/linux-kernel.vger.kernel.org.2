Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC80C3393BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhCLQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:41:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:14817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232398AbhCLQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:40:32 -0500
IronPort-SDR: rAZUWHzfJT70VS6L9481BCQOhv+cVNe4Q/fiLmd/FdLs6JSgShL77kFQJgt9T+7BIcTS+9TKyo
 1sj7MolXeKrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188219740"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188219740"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:40:32 -0800
IronPort-SDR: jTQYy+zNIlcIISoRaXE3Y4QV8oolu1HBzBJVssr7SdAC2O1MfycTc9PN63fKSyIv/bwsfvXtjA
 bmIaco+yVpJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="404469086"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2021 08:40:31 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/5] perf/x86/intel/uncore: Generic support for the MMIO type of uncore blocks
Date:   Fri, 12 Mar 2021 08:34:38 -0800
Message-Id: <1615566878-70244-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The discovery table provides the generic uncore block information
for the MMIO type of uncore blocks, which is good enough to provide
basic uncore support.

The box control field is composed of the BAR address and box control
offset. When initializing the uncore blocks, perf should ioremap the
address from the box control field.

Implement the generic support for the MMIO type of uncore block.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  1 +
 arch/x86/events/intel/uncore.h           |  1 +
 arch/x86/events/intel/uncore_discovery.c | 98 ++++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h |  1 +
 4 files changed, 101 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 762a8e8..7143d9d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1751,6 +1751,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
+	.mmio_init = intel_uncore_generic_uncore_mmio_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 76fc898..549cfb2 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -70,6 +70,7 @@ struct intel_uncore_type {
 	union {
 		unsigned *msr_offsets;
 		unsigned *pci_offsets;
+		unsigned *mmio_offsets;
 	};
 	unsigned *box_ids;
 	struct event_constraint unconstrainted;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7a73da7..a3abea8 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -446,6 +446,90 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 	.read_counter	= intel_generic_uncore_pci_read_counter,
 };
 
+#define UNCORE_GENERIC_MMIO_SIZE		0x4000
+
+static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
+{
+	struct intel_uncore_type *type = box->pmu->type;
+
+	if (!type->box_ctls || !type->box_ctls[box->dieid] || !type->mmio_offsets)
+		return 0;
+
+	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
+}
+
+static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+{
+	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
+	struct intel_uncore_type *type = box->pmu->type;
+	resource_size_t addr;
+
+	if (!box_ctl) {
+		pr_warn("Uncore type %d box %d: Invalid box control address.\n",
+			type->type_id, type->box_ids[box->pmu->pmu_idx]);
+		return;
+	}
+
+	addr = box_ctl;
+	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
+	if (!box->io_addr) {
+		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
+			type->type_id, type->box_ids[box->pmu->pmu_idx],
+			(unsigned long long)addr);
+		return;
+	}
+
+	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(GENERIC_PMON_BOX_CTL_FRZ, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(0, box->io_addr);
+}
+
+static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					      struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	writel(0, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops generic_uncore_mmio_ops = {
+	.init_box	= intel_generic_uncore_mmio_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= intel_generic_uncore_mmio_disable_box,
+	.enable_box	= intel_generic_uncore_mmio_enable_box,
+	.disable_event	= intel_generic_uncore_mmio_disable_event,
+	.enable_event	= intel_generic_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
 static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 				      struct intel_uncore_type *uncore,
 				      struct intel_uncore_discovery_type *type)
@@ -472,6 +556,15 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 		uncore->box_ctls = type->box_ctrl_die;
 		uncore->pci_offsets = type->box_offset;
 		break;
+	case UNCORE_ACCESS_MMIO:
+		uncore->ops = &generic_uncore_mmio_ops;
+		uncore->perf_ctr = (unsigned int)type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->ctl_offset;
+		uncore->box_ctl = (unsigned int)type->box_ctrl;
+		uncore->box_ctls = type->box_ctrl_die;
+		uncore->mmio_offsets = type->box_offset;
+		uncore->mmio_map_size = UNCORE_GENERIC_MMIO_SIZE;
+		break;
 	default:
 		return false;
 	}
@@ -526,3 +619,8 @@ int intel_uncore_generic_uncore_pci_init(void)
 
 	return 0;
 }
+
+void intel_uncore_generic_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO);
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 9e69e2b..60d70aa 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -128,3 +128,4 @@ bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
+void intel_uncore_generic_uncore_mmio_init(void);
-- 
2.7.4

