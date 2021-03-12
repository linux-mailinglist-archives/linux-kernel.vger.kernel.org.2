Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05C93393B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhCLQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:40:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:14817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhCLQk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:40:28 -0500
IronPort-SDR: Km9S9vRqEwZE6qM9avIlctNJzp6RlF6xauibrrwfgyZwH49MPKlzHnNeY3yp0LOkHJWp9Fprfz
 zcxLfVgIU4Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188219730"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188219730"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:40:28 -0800
IronPort-SDR: MN2v2Z+lmLrC2/yoa6DLpl5aaqegU+W93aAbPEoijDkVmik42UTE8qYEC/1GdjAr3y0sVuBdBz
 CA0kdncwDrEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="404469073"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2021 08:40:27 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/5] perf/x86/intel/uncore: Generic support for the MSR type of uncore blocks
Date:   Fri, 12 Mar 2021 08:34:35 -0800
Message-Id: <1615566878-70244-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
References: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The discovery table provides the generic uncore block information for
the MSR type of uncore blocks, e.g., the counter width, the number of
counters, the location of control/counter registers, which is good
enough to provide basic uncore support. It can be used as a fallback
solution when the kernel doesn't support a platform.

The name of the uncore box cannot be retrieved from the discovery table.
uncore_type_&typeID_&boxID will be used as its name. Save the type ID
and the box ID information in the struct intel_uncore_type.
Factor out uncore_get_pmu_name() to handle different naming methods.

Implement generic support for the MSR type of uncore block.

Some advanced features, such as filters and constraints, cannot be
retrieved from discovery tables. Features that rely on that
information are not be supported here.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  45 ++++++++---
 arch/x86/events/intel/uncore.h           |   3 +
 arch/x86/events/intel/uncore_discovery.c | 126 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h |  18 +++++
 4 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f5b5b8b..af6010d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -6,7 +6,7 @@
 #include "uncore.h"
 #include "uncore_discovery.h"
 
-static struct intel_uncore_type *empty_uncore[] = { NULL, };
+struct intel_uncore_type *empty_uncore[] = { NULL, };
 struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
 struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
 struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
@@ -830,6 +830,34 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
+{
+	struct intel_uncore_type *type = pmu->type;
+
+	/*
+	 * No uncore block name in discovery table.
+	 * Use uncore_type_&typeid_&boxid as name.
+	 */
+	if (!type->name) {
+		if (type->num_boxes == 1)
+			sprintf(pmu->name, "uncore_type_%u", type->type_id);
+		else {
+			sprintf(pmu->name, "uncore_type_%u_%d",
+				type->type_id, type->box_ids[pmu->pmu_idx]);
+		}
+		return;
+	}
+
+	if (type->num_boxes == 1) {
+		if (strlen(type->name) > 0)
+			sprintf(pmu->name, "uncore_%s", type->name);
+		else
+			sprintf(pmu->name, "uncore");
+	} else
+		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
+
+}
+
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 {
 	int ret;
@@ -856,15 +884,7 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu.attr_update = pmu->type->attr_update;
 	}
 
-	if (pmu->type->num_boxes == 1) {
-		if (strlen(pmu->type->name) > 0)
-			sprintf(pmu->name, "uncore_%s", pmu->type->name);
-		else
-			sprintf(pmu->name, "uncore");
-	} else {
-		sprintf(pmu->name, "uncore_%s_%d", pmu->type->name,
-			pmu->pmu_idx);
-	}
+	uncore_get_pmu_name(pmu);
 
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (!ret)
@@ -905,6 +925,10 @@ static void uncore_type_exit(struct intel_uncore_type *type)
 		kfree(type->pmus);
 		type->pmus = NULL;
 	}
+	if (type->box_ids) {
+		kfree(type->box_ids);
+		type->box_ids = NULL;
+	}
 	kfree(type->events_group);
 	type->events_group = NULL;
 }
@@ -1639,6 +1663,7 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 };
 
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
+	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index a3c6e16..05c8e06 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -50,6 +50,7 @@ struct intel_uncore_type {
 	int perf_ctr_bits;
 	int fixed_ctr_bits;
 	int num_freerunning_types;
+	int type_id;
 	unsigned perf_ctr;
 	unsigned event_ctl;
 	unsigned event_mask;
@@ -66,6 +67,7 @@ struct intel_uncore_type {
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
 	unsigned *msr_offsets;
+	unsigned *box_ids;
 	struct event_constraint unconstrainted;
 	struct event_constraint *constraints;
 	struct intel_uncore_pmu *pmus;
@@ -547,6 +549,7 @@ uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
 void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
 u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
 
+extern struct intel_uncore_type *empty_uncore[];
 extern struct intel_uncore_type **uncore_msr_uncores;
 extern struct intel_uncore_type **uncore_pci_uncores;
 extern struct intel_uncore_type **uncore_mmio_uncores;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 3e1645c..c14a650 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -320,3 +320,129 @@ void intel_uncore_clear_discovery_tables(void)
 		kfree(type);
 	}
 }
+
+DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
+DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
+DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
+DEFINE_UNCORE_FORMAT_ATTR(thresh, thresh, "config:24-31");
+
+static struct attribute *generic_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh.attr,
+	NULL,
+};
+
+static const struct attribute_group generic_uncore_format_group = {
+	.name = "format",
+	.attrs = generic_uncore_formats_attr,
+};
+
+static void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+}
+
+static void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+}
+
+static void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), 0);
+}
+
+static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	wrmsrl(hwc->config_base, hwc->config);
+}
+
+static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	wrmsrl(hwc->config_base, 0);
+}
+
+static struct intel_uncore_ops generic_uncore_msr_ops = {
+	.init_box		= intel_generic_uncore_msr_init_box,
+	.disable_box		= intel_generic_uncore_msr_disable_box,
+	.enable_box		= intel_generic_uncore_msr_enable_box,
+	.disable_event		= intel_generic_uncore_msr_disable_event,
+	.enable_event		= intel_generic_uncore_msr_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+};
+
+static bool uncore_update_uncore_type(enum uncore_access_type type_id,
+				      struct intel_uncore_type *uncore,
+				      struct intel_uncore_discovery_type *type)
+{
+	uncore->type_id = type->type;
+	uncore->num_boxes = type->num_boxes;
+	uncore->num_counters = type->num_counters;
+	uncore->perf_ctr_bits = type->counter_width;
+	uncore->box_ids = type->ids;
+
+	switch (type_id) {
+	case UNCORE_ACCESS_MSR:
+		uncore->ops = &generic_uncore_msr_ops;
+		uncore->perf_ctr = (unsigned int)type->box_ctrl + type->ctr_offset;
+		uncore->event_ctl = (unsigned int)type->box_ctrl + type->ctl_offset;
+		uncore->box_ctl = (unsigned int)type->box_ctrl;
+		uncore->msr_offsets = type->box_offset;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static struct intel_uncore_type **
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
+{
+	struct intel_uncore_discovery_type *type;
+	struct intel_uncore_type **uncores;
+	struct intel_uncore_type *uncore;
+	struct rb_node *node;
+	int i = 0;
+
+	uncores = kcalloc(num_discovered_types[type_id] + 1,
+			  sizeof(struct intel_uncore_type *), GFP_KERNEL);
+	if (!uncores)
+		return empty_uncore;
+
+	for (node = rb_first(&discovery_tables); node; node = rb_next(node)) {
+		type = rb_entry(node, struct intel_uncore_discovery_type, node);
+		if (type->access_type != type_id)
+			continue;
+
+		uncore = kzalloc(sizeof(struct intel_uncore_type), GFP_KERNEL);
+		if (!uncore)
+			break;
+
+		uncore->event_mask = GENERIC_PMON_RAW_EVENT_MASK;
+		uncore->format_group = &generic_uncore_format_group;
+
+		if (!uncore_update_uncore_type(type_id, uncore, type)) {
+			kfree(uncore);
+			continue;
+		}
+		uncores[i++] = uncore;
+	}
+
+	return uncores;
+}
+
+void intel_uncore_generic_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
+}
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index dd61e06..81b7711 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -28,6 +28,23 @@
 	 unit.table1 == -1ULL || unit.ctl == -1ULL ||	\
 	 unit.table3 == -1ULL)
 
+#define GENERIC_PMON_CTL_EV_SEL_MASK	0x000000ff
+#define GENERIC_PMON_CTL_UMASK_MASK	0x0000ff00
+#define GENERIC_PMON_CTL_EDGE_DET	(1 << 18)
+#define GENERIC_PMON_CTL_INVERT		(1 << 23)
+#define GENERIC_PMON_CTL_TRESH_MASK	0xff000000
+#define GENERIC_PMON_RAW_EVENT_MASK	(GENERIC_PMON_CTL_EV_SEL_MASK | \
+					 GENERIC_PMON_CTL_UMASK_MASK | \
+					 GENERIC_PMON_CTL_EDGE_DET | \
+					 GENERIC_PMON_CTL_INVERT | \
+					 GENERIC_PMON_CTL_TRESH_MASK)
+
+#define GENERIC_PMON_BOX_CTL_FRZ	(1 << 0)
+#define GENERIC_PMON_BOX_CTL_RST_CTRL	(1 << 8)
+#define GENERIC_PMON_BOX_CTL_RST_CTRS	(1 << 9)
+#define GENERIC_PMON_BOX_CTL_INT	(GENERIC_PMON_BOX_CTL_RST_CTRL | \
+					 GENERIC_PMON_BOX_CTL_RST_CTRS)
+
 enum uncore_access_type {
 	UNCORE_ACCESS_MSR	= 0,
 	UNCORE_ACCESS_MMIO,
@@ -103,3 +120,4 @@ struct intel_uncore_discovery_type {
 
 bool intel_uncore_has_discovery_tables(void);
 void intel_uncore_clear_discovery_tables(void);
+void intel_uncore_generic_uncore_cpu_init(void);
-- 
2.7.4

