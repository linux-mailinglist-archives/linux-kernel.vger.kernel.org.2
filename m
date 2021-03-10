Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2A334367
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhCJQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhCJQoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:08 -0500
IronPort-SDR: /qXyp97eJ7pJcZL8b8bG5BBNtuWYNtN4plelh6+DZCyVBZIeWRR5iQXoA8uP3XnDWQLfqNXojh
 j3Tq6kbBDJvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546507"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:07 -0800
IronPort-SDR: 96KuVI+YYoE9ydJiMC6auXTS9PrXPjrMqcZxWIE+eWjXUivAiqiOrTI3VMDM++6OSibjQyep3d
 n3Jw+p8YpRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729312"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:07 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 18/25] perf/x86/intel: Add attr_update for Hybrid PMUs
Date:   Wed, 10 Mar 2021 08:37:54 -0800
Message-Id: <1615394281-68214-19-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The attribute_group for Hybrid PMUs should be different from the previous
cpu PMU. For example, cpumask is required for a Hybrid PMU. The PMU type
should be included in the event and format attribute.

Add hybrid_attr_update for the Hybrid PMU.
Check the PMU type in is_visible() function. Only display the event or
format for the matched Hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 120 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0026a54..8ac948a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5266,6 +5266,106 @@ static const struct attribute_group *attr_update[] = {
 	NULL,
 };
 
+static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+	struct perf_pmu_events_hybrid_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_hybrid_attr, attr.attr);
+
+	return pmu->cpu_type & pmu_attr->pmu_type;
+}
+
+static umode_t hybrid_events_is_visible(struct kobject *kobj,
+					struct attribute *attr, int i)
+{
+	return is_attr_for_this_pmu(kobj, attr) ? attr->mode : 0;
+}
+
+static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
+{
+	int cpu = cpumask_first(&pmu->supported_cpus);
+
+	return (cpu >= nr_cpu_ids) ? -1 : cpu;
+}
+
+static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+	int cpu = hybrid_find_supported_cpu(pmu);
+
+	return (cpu >= 0) && is_attr_for_this_pmu(kobj, attr) && cpu_has(&cpu_data(cpu), X86_FEATURE_RTM) ? attr->mode : 0;
+}
+
+static umode_t hybrid_format_is_visible(struct kobject *kobj,
+					struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+	struct perf_pmu_format_hybrid_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_format_hybrid_attr, attr.attr);
+	int cpu = hybrid_find_supported_cpu(pmu);
+
+	return (cpu >= 0) && (pmu->cpu_type & pmu_attr->pmu_type) ? attr->mode : 0;
+}
+
+static struct attribute_group hybrid_group_events_td  = {
+	.name		= "events",
+	.is_visible	= hybrid_events_is_visible,
+};
+
+static struct attribute_group hybrid_group_events_mem = {
+	.name		= "events",
+	.is_visible	= hybrid_events_is_visible,
+};
+
+static struct attribute_group hybrid_group_events_tsx = {
+	.name		= "events",
+	.is_visible	= hybrid_tsx_is_visible,
+};
+
+static struct attribute_group hybrid_group_format_extra = {
+	.name		= "format",
+	.is_visible	= hybrid_format_is_visible,
+};
+
+static ssize_t intel_hybrid_get_attr_cpus(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct x86_hybrid_pmu *pmu =
+		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->supported_cpus);
+}
+
+static DEVICE_ATTR(cpus, S_IRUGO, intel_hybrid_get_attr_cpus, NULL);
+static struct attribute *intel_hybrid_cpus_attrs[] = {
+	&dev_attr_cpus.attr,
+	NULL,
+};
+
+static struct attribute_group hybrid_group_cpus = {
+	.attrs		= intel_hybrid_cpus_attrs,
+};
+
+static const struct attribute_group *hybrid_attr_update[] = {
+	&hybrid_group_events_td,
+	&hybrid_group_events_mem,
+	&hybrid_group_events_tsx,
+	&group_caps_gen,
+	&group_caps_lbr,
+	&hybrid_group_format_extra,
+	&group_default,
+	&hybrid_group_cpus,
+	NULL,
+};
+
 static struct attribute *empty_attrs;
 
 __init int intel_pmu_init(void)
@@ -5896,14 +5996,22 @@ __init int intel_pmu_init(void)
 
 	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
 
+	if (!is_hybrid()) {
+		group_events_td.attrs  = td_attr;
+		group_events_mem.attrs = mem_attr;
+		group_events_tsx.attrs = tsx_attr;
+		group_format_extra.attrs = extra_attr;
+		group_format_extra_skl.attrs = extra_skl_attr;
 
-	group_events_td.attrs  = td_attr;
-	group_events_mem.attrs = mem_attr;
-	group_events_tsx.attrs = tsx_attr;
-	group_format_extra.attrs = extra_attr;
-	group_format_extra_skl.attrs = extra_skl_attr;
+		x86_pmu.attr_update = attr_update;
+	} else {
+		hybrid_group_events_td.attrs  = td_attr;
+		hybrid_group_events_mem.attrs = mem_attr;
+		hybrid_group_events_tsx.attrs = tsx_attr;
+		hybrid_group_format_extra.attrs = extra_attr;
 
-	x86_pmu.attr_update = attr_update;
+		x86_pmu.attr_update = hybrid_attr_update;
+	}
 
 	intel_pmu_check_num_counters(&x86_pmu.num_counters,
 				     &x86_pmu.num_counters_fixed,
-- 
2.7.4

