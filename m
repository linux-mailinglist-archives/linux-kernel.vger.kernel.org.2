Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A630CCF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhBBUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:20:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:59905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhBBUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:18:29 -0500
IronPort-SDR: RGcEp1UdFQakkzjF+ihAXpUc24gVNHWgkc7e4kQe5jHd7BLrcZCgIa7c0MUgf4Tr/hYrjpvZj2
 CqSTXmdI7Zbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148797"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:12 -0800
IronPort-SDR: cUWzp3oSc2CMRdvOKJUqmlRjSjHLxqnPVnxHw3tq0TzDCBZQESa9hC5GIK6zNO7kGuXAJFrsm+
 5uYxovT1vORQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442511"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:11 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/9] perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
Date:   Tue,  2 Feb 2021 12:09:09 -0800
Message-Id: <1612296553-21962-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
PERF_SAMPLE_WEIGHT sample type. Users can apply either the
PERF_SAMPLE_WEIGHT sample type or the PERF_SAMPLE_WEIGHT_STRUCT sample
type to retrieve the sample weight, but they cannot apply both sample
types simultaneously. The new sample type shares the same space as the
PERF_SAMPLE_WEIGHT sample type. The lower 32 bits are exactly the same
for both sample type. The higher 32 bits may be different for different
architecture.

Add arch specific arch_evsel__set_sample_weight() to set the new sample
type for X86. Only store the lower 32 bits for the sample->weight if the
new sample type is applied. In practice, no memory access could last
than 4G cycles. No data will be lost.

If the kernel doesn't support the new sample type. Fall back to the
PERF_SAMPLE_WEIGHT sample type.

There is no impact for other architectures.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/Build            |  1 +
 tools/perf/arch/x86/util/evsel.c          |  8 ++++++++
 tools/perf/util/evsel.c                   | 28 ++++++++++++++++++++++++----
 tools/perf/util/evsel.h                   |  3 +++
 tools/perf/util/intel-pt.c                | 22 +++++++++++++++++++---
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/session.c                 |  2 +-
 tools/perf/util/synthetic-events.c        |  6 ++++--
 8 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/evsel.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index d73f548..18848b3 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -7,6 +7,7 @@ perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
 perf-y += mem-events.o
+perf-y += evsel.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
new file mode 100644
index 0000000..2f733cd
--- /dev/null
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include "util/evsel.h"
+
+void arch_evsel__set_sample_weight(struct evsel *evsel)
+{
+	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c48f6de..0a2a307 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1012,6 +1012,11 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
 	return found_term;
 }
 
+void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
+{
+	evsel__set_sample_bit(evsel, WEIGHT);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1166,7 +1171,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	}
 
 	if (opts->sample_weight)
-		evsel__set_sample_bit(evsel, WEIGHT);
+		arch_evsel__set_sample_weight(evsel);
 
 	attr->task  = track;
 	attr->mmap  = track;
@@ -1735,6 +1740,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 fallback_missing_features:
+	if (perf_missing_features.weight_struct) {
+		evsel__set_sample_bit(evsel, WEIGHT);
+		evsel__reset_sample_bit(evsel, WEIGHT_STRUCT);
+	}
 	if (perf_missing_features.clockid_wrong)
 		evsel->core.attr.clockid = CLOCK_MONOTONIC; /* should always work */
 	if (perf_missing_features.clockid) {
@@ -1873,7 +1882,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-        if (!perf_missing_features.data_page_size &&
+	if (!perf_missing_features.weight_struct &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
+		perf_missing_features.weight_struct = true;
+		pr_debug2("switching off weight struct support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.data_page_size &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
 		perf_missing_features.data_page_size = true;
 		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
@@ -2316,9 +2330,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		}
 	}
 
-	if (type & PERF_SAMPLE_WEIGHT) {
+	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
+		union perf_sample_weight weight;
+
 		OVERFLOW_CHECK_u64(array);
-		data->weight = *array;
+		weight.full = *array;
+		if (type & PERF_SAMPLE_WEIGHT)
+			data->weight = weight.full;
+		else
+			data->weight = weight.var1_dw;
 		array++;
 	}
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd1d8dd..5c161a2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -145,6 +145,7 @@ struct perf_missing_features {
 	bool branch_hw_idx;
 	bool cgroup;
 	bool data_page_size;
+	bool weight_struct;
 };
 
 extern struct perf_missing_features perf_missing_features;
@@ -239,6 +240,8 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
 
 void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
+void arch_evsel__set_sample_weight(struct evsel *evsel);
+
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 60214de..a929f6d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1853,13 +1853,29 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
 		sample.addr = items->mem_access_address;
 
-	if (sample_type & PERF_SAMPLE_WEIGHT) {
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		/*
 		 * Refer kernel's setup_pebs_adaptive_sample_data() and
 		 * intel_hsw_weight().
 		 */
-		if (items->has_mem_access_latency)
-			sample.weight = items->mem_access_latency;
+		if (items->has_mem_access_latency) {
+			u64 weight = items->mem_access_latency >> 32;
+
+			/*
+			 * Starts from SPR, the mem access latency field
+			 * contains both cache latency [47:32] and instruction
+			 * latency [15:0]. The cache latency is the same as the
+			 * mem access latency on previous platforms.
+			 *
+			 * In practice, no memory access could last than 4G
+			 * cycles. Use latency >> 32 to distinguish the
+			 * different format of the mem access latency field.
+			 */
+			if (weight > 0)
+				sample.weight = weight & 0xffff;
+			else
+				sample.weight = items->mem_access_latency;
+		}
 		if (!sample.weight && items->has_tsx_aux_info) {
 			/* Cycles last block */
 			sample.weight = (u32)items->tsx_aux_info;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index fb0bb66..e972e63 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(WEIGHT_STRUCT),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 25adbcc..a35d8c2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1297,7 +1297,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_STACK_USER)
 		stack_user__printf(&sample->user_stack);
 
-	if (sample_type & PERF_SAMPLE_WEIGHT)
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
 		printf("... weight: %" PRIu64 "\n", sample->weight);
 
 	if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2947e3f..bc16268 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1384,7 +1384,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		}
 	}
 
-	if (type & PERF_SAMPLE_WEIGHT)
+	if (type & PERF_SAMPLE_WEIGHT_TYPE)
 		result += sizeof(u64);
 
 	if (type & PERF_SAMPLE_DATA_SRC)
@@ -1555,8 +1555,10 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		}
 	}
 
-	if (type & PERF_SAMPLE_WEIGHT) {
+	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
 		*array = sample->weight;
+		if (type & PERF_SAMPLE_WEIGHT_STRUCT)
+			*array &= 0xffffffff;
 		array++;
 	}
 
-- 
2.7.4

