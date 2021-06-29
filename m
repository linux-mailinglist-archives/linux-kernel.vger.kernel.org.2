Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC13B77D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhF2SbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:31:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:12481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235128AbhF2SbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:31:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269341966"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="269341966"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="408270471"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2021 11:28:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/6] perf/x86/intel/uncore: Add alias PMU name
Date:   Tue, 29 Jun 2021 11:13:59 -0700
Message-Id: <1624990443-168533-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
server supports the discovery mechanism. Without the platform-specific
support, an uncore PMU is named by a type ID plus a box ID, e.g.,
uncore_type_0_0, because the real name of the uncore PMU cannot be
retrieved from the discovery table. With the platform-specific support
later, perf has the mapping information from a type ID to a specific
uncore unit. Just like the previous platforms, the uncore PMU is named
by the real PMU name, e.g., uncore_cha_0. The user scripts which work
well with the old numeric name may not work anymore.

Add a new attribute "alias" to indicate the old numeric name. The
following userspace perf tool patch will handle both names. The user
scripts should work properly with the updated perf tool.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: gregkh@linuxfoundation.org
---
 arch/x86/events/intel/uncore.c       | 19 +++++++++++++------
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7087ce7..ff07472 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -846,6 +846,18 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
+{
+	struct intel_uncore_type *type = pmu->type;
+
+	if (type->num_boxes == 1)
+		sprintf(pmu_name, "uncore_type_%u", type->type_id);
+	else {
+		sprintf(pmu_name, "uncore_type_%u_%d",
+			type->type_id, type->box_ids[pmu->pmu_idx]);
+	}
+}
+
 static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 {
 	struct intel_uncore_type *type = pmu->type;
@@ -855,12 +867,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 	 * Use uncore_type_&typeid_&boxid as name.
 	 */
 	if (!type->name) {
-		if (type->num_boxes == 1)
-			sprintf(pmu->name, "uncore_type_%u", type->type_id);
-		else {
-			sprintf(pmu->name, "uncore_type_%u_%d",
-				type->type_id, type->box_ids[pmu->pmu_idx]);
-		}
+		uncore_get_alias_name(pmu->name, pmu);
 		return;
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 6d44b7e..f65fb73 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -560,6 +560,7 @@ struct event_constraint *
 uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
 void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
 u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
+void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu);
 
 extern struct intel_uncore_type *empty_uncore[];
 extern struct intel_uncore_type **uncore_msr_uncores;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 44f2469..332e556 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5429,6 +5429,26 @@ static const struct attribute_group spr_uncore_chabox_format_group = {
 	.attrs = spr_uncore_cha_formats_attr,
 };
 
+static ssize_t alias_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
+	char pmu_name[UNCORE_PMU_NAME_LEN];
+
+	uncore_get_alias_name(pmu_name, pmu);
+	return sysfs_emit(buf, "%s\n", pmu_name);
+}
+
+static DEVICE_ATTR_RO(alias);
+
+static struct attribute *uncore_alias_attrs[] = {
+	&dev_attr_alias.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(uncore_alias);
+
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
@@ -5436,6 +5456,7 @@ static struct intel_uncore_type spr_uncore_chabox = {
 	.num_shared_regs	= 1,
 	.ops			= &spr_uncore_chabox_ops,
 	.format_group		= &spr_uncore_chabox_format_group,
+	.attr_update		= uncore_alias_groups,
 };
 
 static struct intel_uncore_type spr_uncore_iio = {
@@ -5443,6 +5464,7 @@ static struct intel_uncore_type spr_uncore_iio = {
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= uncore_alias_groups,
 };
 
 static struct attribute *spr_uncore_raw_formats_attr[] = {
@@ -5462,7 +5484,8 @@ static const struct attribute_group spr_uncore_raw_format_group = {
 #define SPR_UNCORE_COMMON_FORMAT()				\
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,	\
 	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,	\
-	.format_group		= &spr_uncore_raw_format_group
+	.format_group		= &spr_uncore_raw_format_group,	\
+	.attr_update		= uncore_alias_groups
 
 static struct intel_uncore_type spr_uncore_irp = {
 	SPR_UNCORE_COMMON_FORMAT(),
@@ -5477,6 +5500,7 @@ static struct intel_uncore_type spr_uncore_m2pcie = {
 
 static struct intel_uncore_type spr_uncore_pcu = {
 	.name			= "pcu",
+	.attr_update		= uncore_alias_groups,
 };
 
 static void spr_uncore_mmio_enable_event(struct intel_uncore_box *box,
@@ -5602,6 +5626,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->event_descs = from_type->event_descs;
 	if (from_type->format_group)
 		to_type->format_group = from_type->format_group;
+	if (from_type->attr_update)
+		to_type->attr_update = from_type->attr_update;
 }
 
 static struct intel_uncore_type **
-- 
2.7.4

