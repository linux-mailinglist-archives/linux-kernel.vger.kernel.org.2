Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860363B89FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhF3VMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:12:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:4263 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235053AbhF3VMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:12:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720718"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720718"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558431166"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 14:10:14 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 02/16] perf/x86/intel/uncore: Add Sapphire Rapids server CHA support
Date:   Wed, 30 Jun 2021 14:08:26 -0700
Message-Id: <1625087320-194204-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

CHA merges the caching agent and Home Agent (HA) responsibilities of the
chip into a single block. It's one of the Sapphire Rapids server uncore
units.

The layout of the control registers for a CHA uncore unit is a little
bit different from the generic one. The CHA uncore unit also supports a
filter register for TID. So a specific format and ops are required.
Expose the common MSR ops which can be reused.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c |  6 +--
 arch/x86/events/intel/uncore_discovery.h |  4 ++
 arch/x86/events/intel/uncore_snbep.c     | 90 +++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 93148e2..25f1c01 100644
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
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 05ef64f..c3bbb83 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -130,5 +130,9 @@ void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
 
+void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 0daa1e8..79d9f67 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -448,6 +448,17 @@
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
@@ -460,6 +471,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
+DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
 DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
@@ -5350,10 +5362,86 @@ void icx_uncore_mmio_init(void)
 
 /* SPR uncore support */
 
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
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
-	NULL,
+	&spr_uncore_chabox,
 	NULL,
 	NULL,
 	NULL,
-- 
2.7.4

