Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED33334366
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCJQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhCJQoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:07 -0500
IronPort-SDR: mecsqfeHhHdbUOGj50dynkBl0u2VwDXRuhTI6xgxXVmoHarcN8oGVzG2ywtPvWfEFnuyvE/BWK
 loNpiXWfkSkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546501"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:06 -0800
IronPort-SDR: AtwnNwoEWc5blfEtf2RhEcECAK9FFXgvLbBiahdhyqsDunOxC8Dmn+5btzQNaHJx6gtBwBMzm9
 DRqrmRBHOsnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729300"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:06 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 17/25] perf/x86: Add structures for the attributes of Hybrid PMUs
Date:   Wed, 10 Mar 2021 08:37:53 -0800
Message-Id: <1615394281-68214-18-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Hybrid PMUs have different events and formats. In theory, Hybrid PMU
specific attributes should be maintained in the dedicated struct
x86_hybrid_pmu, but it wastes space because the events and formats are
similar among Hybrid PMUs.

To reduce duplication, all hybrid PMUs will share a group of attributes
in the following patch. To distinguish an attribute from different
Hybrid PMUs, a PMU aware attribute structure is introduced. A PMU type
is required for the attribute structure. The type is internal usage. It
is not visible in the sysfs API.

Hybrid PMUs may support the same event name, but with different event
encoding, e.g., the mem-loads event on an Atom PMU has different event
encoding from a Core PMU. It brings issue if two attributes are
created for them. Current sysfs_update_group finds an attribute by
searching the attr name (aka event name). If two attributes have the
same event name, the first attribute will be replaced.
To address the issue, only one attribute is created for the event. The
event_str is extended and stores event encodings from all Hybrid PMUs.
Each event encoding is divided by ";". The order of the event encodings
must follow the order of the hybrid PMU index. The event_str is internal
usage as well. When a user wants to show the attribute of a Hybrid PMU,
only the corresponding part of the string is displayed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h | 19 +++++++++++++++++++
 include/linux/perf_event.h   | 12 ++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7dc1430..43f5529 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1864,6 +1864,49 @@ ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			pmu_attr->event_str_noht);
 }
 
+ssize_t events_hybrid_sysfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page)
+{
+	struct perf_pmu_events_hybrid_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_hybrid_attr, attr);
+	struct x86_hybrid_pmu *pmu;
+	const char *str, *next_str;
+	int i;
+
+	if (hweight64(pmu_attr->pmu_type) == 1)
+		return sprintf(page, "%s", pmu_attr->event_str);
+
+	/*
+	 * Hybrid PMUs may support the same event name, but with different
+	 * event encoding, e.g., the mem-loads event on an Atom PMU has
+	 * different event encoding from a Core PMU.
+	 *
+	 * The event_str includes all event encodings. Each event encoding
+	 * is divided by ";". The order of the event encodings must follow
+	 * the order of the hybrid PMU index.
+	 */
+	pmu = container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	str = pmu_attr->event_str;
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
+			continue;
+		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
+			next_str = strchr(str, ';');
+			if (next_str)
+				return snprintf(page, next_str - str + 1, "%s", str);
+			else
+				return sprintf(page, "%s", str);
+		}
+		str = strchr(str, ';');
+		str++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(events_hybrid_sysfs_show);
+
 EVENT_ATTR(cpu-cycles,			CPU_CYCLES		);
 EVENT_ATTR(instructions,		INSTRUCTIONS		);
 EVENT_ATTR(cache-references,		CACHE_REFERENCES	);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 809c036..36a08709 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -964,6 +964,22 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 	.event_str_ht	= ht,						\
 }
 
+#define EVENT_ATTR_STR_HYBRID(_name, v, str, _pmu)			\
+static struct perf_pmu_events_hybrid_attr event_attr_##v = {		\
+	.attr		= __ATTR(_name, 0444, events_hybrid_sysfs_show, NULL),\
+	.id		= 0,						\
+	.event_str	= str,						\
+	.pmu_type	= _pmu,						\
+}
+
+#define FORMAT_HYBRID_PTR(_id) (&format_attr_hybrid_##_id.attr.attr)
+
+#define FORMAT_ATTR_HYBRID(_name, _pmu)					\
+static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
+	.attr		= __ATTR_RO(_name),				\
+	.pmu_type	= _pmu,						\
+}
+
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
@@ -1132,6 +1148,9 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
+ssize_t events_hybrid_sysfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page);
 
 static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fab42cf..21ab3f5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1546,6 +1546,18 @@ struct perf_pmu_events_ht_attr {
 	const char				*event_str_noht;
 };
 
+struct perf_pmu_events_hybrid_attr {
+	struct device_attribute			attr;
+	u64					id;
+	const char				*event_str;
+	u64					pmu_type;
+};
+
+struct perf_pmu_format_hybrid_attr {
+	struct device_attribute			attr;
+	u64					pmu_type;
+};
+
 ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
 			      char *page);
 
-- 
2.7.4

