Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C9313D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhBHSRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:17:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234039AbhBHPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:01 -0500
IronPort-SDR: 9d66cPohNsdfbpxKpuNm7IlHNpuFIHt9nZGH7o/oVyAzz2ShrOXY21wVCm3wuOWpeisSUrufbF
 TT7ls5x1cYvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952006"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:29 -0800
IronPort-SDR: oa8+Bw+kGW2qBijXE2yZrgbZeqI3sf8CDXfiDJ+NDRmmoVupwoLBQmvhGOHshWVwZTEva+3t+Z
 Vb8la99RKcIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820800"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 22/49] perf/x86/intel/uncore: Add Alder Lake support
Date:   Mon,  8 Feb 2021 07:25:19 -0800
Message-Id: <1612797946-18784-23-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore subsystem for Alder Lake is similar to the previous Tiger
Lake.

The difference includes:
- New MSR addresses for global control, fixed counters, CBOX and ARB.
  Add a new adl_uncore_msr_ops for uncore operations.
- Add a new threshold field for CBOX.
- New PCIIDs for IMC devices.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |   7 ++
 arch/x86/events/intel/uncore.h     |   1 +
 arch/x86/events/intel/uncore_snb.c | 131 +++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 33c8180..3ad5df2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1625,6 +1625,11 @@ static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
 	.pci_init = skl_uncore_pci_init,
 };
 
+static const struct intel_uncore_init_fun adl_uncore_init __initconst = {
+	.cpu_init = adl_uncore_cpu_init,
+	.mmio_init = tgl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1673,6 +1678,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index a3c6e16..30e6557 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -567,6 +567,7 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
+void adl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 5127128..0f63706 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -62,6 +62,8 @@
 #define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
 #define PCI_DEVICE_ID_INTEL_RKL_1_IMC		0x4c43
 #define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
+#define PCI_DEVICE_ID_INTEL_ADL_1_IMC		0x4660
+#define PCI_DEVICE_ID_INTEL_ADL_2_IMC		0x4641
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -131,12 +133,33 @@
 #define ICL_UNC_ARB_PER_CTR			0x3b1
 #define ICL_UNC_ARB_PERFEVTSEL			0x3b3
 
+/* ADL uncore global control */
+#define ADL_UNC_PERF_GLOBAL_CTL			0x2ff0
+#define ADL_UNC_FIXED_CTR_CTRL                  0x2fde
+#define ADL_UNC_FIXED_CTR                       0x2fdf
+
+/* ADL Cbo register */
+#define ADL_UNC_CBO_0_PER_CTR0			0x2002
+#define ADL_UNC_CBO_0_PERFEVTSEL0		0x2000
+#define ADL_UNC_CTL_THRESHOLD			0x3f000000
+#define ADL_UNC_RAW_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 SNB_UNC_CTL_UMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET | \
+						 SNB_UNC_CTL_INVERT | \
+						 ADL_UNC_CTL_THRESHOLD)
+
+/* ADL ARB register */
+#define ADL_UNC_ARB_PER_CTR0			0x2FD2
+#define ADL_UNC_ARB_PERFEVTSEL0			0x2FD0
+#define ADL_UNC_ARB_MSR_OFFSET			0x8
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
 DEFINE_UNCORE_FORMAT_ATTR(cmask8, cmask, "config:24-31");
+DEFINE_UNCORE_FORMAT_ATTR(threshold, threshold, "config:24-29");
 
 /* Sandy Bridge uncore support */
 static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -422,6 +445,106 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
+static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static void adl_uncore_msr_disable_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+}
+
+static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
+}
+
+static struct intel_uncore_ops adl_uncore_msr_ops = {
+	.init_box	= adl_uncore_msr_init_box,
+	.enable_box	= adl_uncore_msr_enable_box,
+	.disable_box	= adl_uncore_msr_disable_box,
+	.exit_box	= adl_uncore_msr_exit_box,
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
+static struct attribute *adl_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_threshold.attr,
+	NULL,
+};
+
+static const struct attribute_group adl_uncore_format_group = {
+	.name		= "format",
+	.attrs		= adl_uncore_formats_attr,
+};
+
+static struct intel_uncore_type adl_uncore_cbox = {
+	.name		= "cbox",
+	.num_counters   = 2,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ADL_UNC_CBO_0_PER_CTR0,
+	.event_ctl	= ADL_UNC_CBO_0_PERFEVTSEL0,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= ICL_UNC_CBO_MSR_OFFSET,
+	.ops		= &adl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type adl_uncore_arb = {
+	.name		= "arb",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ADL_UNC_ARB_PER_CTR0,
+	.event_ctl	= ADL_UNC_ARB_PERFEVTSEL0,
+	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
+	.msr_offset	= ADL_UNC_ARB_MSR_OFFSET,
+	.constraints	= snb_uncore_arb_constraints,
+	.ops		= &adl_uncore_msr_ops,
+	.format_group	= &snb_uncore_format_group,
+};
+
+static struct intel_uncore_type adl_uncore_clockbox = {
+	.name		= "clock",
+	.num_counters	= 1,
+	.num_boxes	= 1,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= ADL_UNC_FIXED_CTR,
+	.fixed_ctl	= ADL_UNC_FIXED_CTR_CTRL,
+	.single_fixed	= 1,
+	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
+	.format_group	= &icl_uncore_clock_format_group,
+	.ops		= &adl_uncore_msr_ops,
+	.event_descs	= icl_uncore_events,
+};
+
+static struct intel_uncore_type *adl_msr_uncores[] = {
+	&adl_uncore_cbox,
+	&adl_uncore_arb,
+	&adl_uncore_clockbox,
+	NULL,
+};
+
+void adl_uncore_cpu_init(void)
+{
+	adl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	uncore_msr_uncores = adl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1203,6 +1326,14 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_H_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.7.4

