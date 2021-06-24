Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790F23B2493
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFXBjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:8652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhFXBjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:16 -0400
IronPort-SDR: fiEZHI7KKLUID24+JACL71vSZbRq8SmVxHoORo8+AHWeJbotNp45zIt5xBYJxtLwie5INmsy/p
 YL2qxvj/v2Xg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187756992"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187756992"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:36:58 -0700
IronPort-SDR: sHmcMBjRyYeFjI70969dxqkeXWNm7DEtroX5wF0xOZUCL2soB8lyQpLQu0Ocvh/iI2ufy5zML4
 x93pJBNYlNfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928476"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:36:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/7] perf/x86/intel/uncore: Create a symlink for an uncore PMU
Date:   Wed, 23 Jun 2021 18:22:05 -0700
Message-Id: <1624497729-158864-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The platform specific support for Sapphire Rapids will apply a
meaningful name for each uncore PMU. The script which works well with
the old name may not work anymore because of the name change. To avoid
the issue, a symlink should be created from the new name to the old
name.

Add an variable link_name to store the new name.

The rule to name a new meaningful uncore name is the same as the
previous platforms. Factor out __uncore_get_pmu_name().

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 28 ++++++++++++++++++++--------
 arch/x86/events/intel/uncore.h |  2 ++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9bf4dbb..04e5d37 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -842,6 +842,18 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static void __uncore_get_pmu_name(char *pmu_name, const char *type_name,
+				  int num_boxes, int idx)
+{
+	if (num_boxes == 1) {
+		if (strlen(type_name) > 0)
+			sprintf(pmu_name, "uncore_%s", type_name);
+		else
+			sprintf(pmu_name, "uncore");
+	} else
+		sprintf(pmu_name, "uncore_%s_%d", type_name, idx);
+}
+
 static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 {
 	struct intel_uncore_type *type = pmu->type;
@@ -857,17 +869,17 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 			sprintf(pmu->name, "uncore_type_%u_%d",
 				type->type_id, type->box_ids[pmu->pmu_idx]);
 		}
+
+		if (type->link_name) {
+			__uncore_get_pmu_name(pmu->link_name, type->link_name,
+					      type->num_boxes, type->box_ids[pmu->pmu_idx]);
+			pmu->pmu.link_name = pmu->link_name;
+		}
 		return;
 	}
 
-	if (type->num_boxes == 1) {
-		if (strlen(type->name) > 0)
-			sprintf(pmu->name, "uncore_%s", type->name);
-		else
-			sprintf(pmu->name, "uncore");
-	} else
-		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
-
+	__uncore_get_pmu_name(pmu->name, type->name,
+			      type->num_boxes, pmu->pmu_idx);
 }
 
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 187d728..2fc8565 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -46,6 +46,7 @@ struct intel_uncore_topology;
 
 struct intel_uncore_type {
 	const char *name;
+	const char *link_name;
 	int num_counters;
 	int num_boxes;
 	int perf_ctr_bits;
@@ -118,6 +119,7 @@ struct intel_uncore_ops {
 struct intel_uncore_pmu {
 	struct pmu			pmu;
 	char				name[UNCORE_PMU_NAME_LEN];
+	char				link_name[UNCORE_PMU_NAME_LEN];
 	int				pmu_idx;
 	int				func_id;
 	bool				registered;
-- 
2.7.4

