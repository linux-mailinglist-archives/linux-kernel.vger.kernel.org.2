Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD534C472
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhC2HCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhC2HCD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:03 -0400
IronPort-SDR: FB7YuJx8BmJVCknw9oIze1p5wWf7PdZ4w5WEKdCfVjiO00TnyTGaOGL0tGjMxl6/DQBacZX5IZ
 OP38msQoARNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590421"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590421"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:02 -0700
IronPort-SDR: a5VGM1wKdJEIfILEiBMPcz+WoHg2j4/Zpv/o/RL3s8+4KE/M43MtI9kK/E0djlUUXAApqkVbnn
 x9UpPtFZ/VSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677371"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:00 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 08/27] perf parse-events: Create two hybrid hardware events
Date:   Mon, 29 Mar 2021 15:00:27 +0800
Message-Id: <20210329070046.8815-9-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hardware events, they have pre-defined configs. The kernel
needs to know where the event comes from (e.g. from cpu_core pmu
or from cpu_atom pmu). But the perf type 'PERF_TYPE_HARDWARE'
can't carry pmu information.

So the kernel introduces a new type 'PERF_TYPE_HARDWARE_PMU'.
The new attr.config layout for PERF_TYPE_HARDWARE_PMU is:

0xDD000000AA
AA: original hardware event ID
DD: PMU type ID

PMU type ID is retrieved from sysfs. For example,

  cat /sys/devices/cpu_atom/type
  10

  cat /sys/devices/cpu_core/type
  4

When enabling a hybrid hardware event without specified pmu, such as,
'perf stat -e cycles -a', two events are created automatically. One
is for atom, the other is for core.

  # ./perf stat -e cycles -a -vv -- sleep 1
  Control descriptor is not initialized
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0x400000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0x400000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
  ------------------------------------------------------------

  ......

  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0x400000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0xa00000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0xa00000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
  ------------------------------------------------------------

  ......

  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0xa00000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0xa00000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  cycles: 0: 402953 1001514714 1001514714
  cycles: 1: 137456 1001554851 1001554851
  cycles: 2: 130449 1001575948 1001575948
  cycles: 3: 61370 1001600256 1001600256
  cycles: 4: 100084 1001614135 1001614135
  cycles: 5: 62549 1001646802 1001646802
  cycles: 6: 453760 1001703487 1001703487
  cycles: 7: 66527 1001739138 1001739138
  cycles: 8: 80526 1001823867 1001823867
  cycles: 9: 74942 1001863884 1001863884
  cycles: 10: 322356 1001952832 1001952832
  cycles: 11: 1681751 1001846058 1001846058
  cycles: 12: 97608 1001874578 1001874578
  cycles: 13: 62060 1001899200 1001899200
  cycles: 14: 546496 1001920608 1001920608
  cycles: 15: 65631 1001939206 1001939206
  cycles: 0: 59901 1002047096 1002047096
  cycles: 1: 57304 1001995373 1001995373
  cycles: 2: 781291 1002027732 1002027732
  cycles: 3: 99656 1002058466 1002058466
  cycles: 4: 95071 1002092749 1002092749
  cycles: 5: 346827 1002142979 1002142979
  cycles: 6: 183967 1002183046 1002183046
  cycles: 7: 391779 1002218286 1002218286
  cycles: 4346518 16028069564 16028069564
  cycles: 2015796 8016765727 8016765727

   Performance counter stats for 'system wide':

           4,346,518      cpu_core/cycles/
           2,015,796      cpu_atom/cycles/

         1.003685897 seconds time elapsed

type 6 is PERF_TYPE_HARDWARE_PMU.
0x4 in 0x400000000 indicates the cpu_core pmu.
0xa in 0xa00000000 indicates the cpu_atom pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Create new parse-events-hybrid.c/parse-events-hybrid.h
 - Refine the code

 tools/perf/util/Build                 |  1 +
 tools/perf/util/parse-events-hybrid.c | 97 +++++++++++++++++++++++++++
 tools/perf/util/parse-events-hybrid.h | 17 +++++
 tools/perf/util/parse-events.c        | 18 +++++
 tools/perf/util/parse-events.h        |  5 ++
 5 files changed, 138 insertions(+)
 create mode 100644 tools/perf/util/parse-events-hybrid.c
 create mode 100644 tools/perf/util/parse-events-hybrid.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 37a8a63c7195..00c9fb064ba6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -23,6 +23,7 @@ perf-y += llvm-utils.o
 perf-y += mmap.o
 perf-y += memswap.o
 perf-y += parse-events.o
+perf-y += parse-events-hybrid.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
new file mode 100644
index 000000000000..bd48563596e0
--- /dev/null
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/zalloc.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/param.h>
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "parse-events-hybrid.h"
+#include "debug.h"
+#include "pmu.h"
+#include "pmu-hybrid.h"
+#include "perf.h"
+
+static void config_hybrid_attr(struct perf_event_attr *attr,
+			       int type, int pmu_type)
+{
+	/*
+	 * attr.config layout:
+	 * PERF_TYPE_HARDWARE_PMU:     0xDD000000AA
+	 *                             AA: hardware event ID
+	 *                             DD: PMU type ID
+	 * PERF_TYPE_HW_CACHE_PMU:     0xDD00CCBBAA
+	 *                             AA: hardware cache ID
+	 *                             BB: hardware cache op ID
+	 *                             CC: hardware cache op result ID
+	 *                             DD: PMU type ID
+	 */
+	attr->type = type;
+	attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
+}
+
+static int create_event_hybrid(__u32 config_type, int *idx,
+			       struct list_head *list,
+			       struct perf_event_attr *attr, char *name,
+			       struct list_head *config_terms,
+			       struct perf_pmu *pmu)
+{
+	struct evsel *evsel;
+	__u32 type = attr->type;
+	__u64 config = attr->config;
+
+	config_hybrid_attr(attr, config_type, pmu->type);
+	evsel = parse_events__add_event_hybrid(list, idx, attr, name,
+					       pmu, config_terms);
+	if (evsel)
+		evsel->pmu_name = strdup(pmu->name);
+	else
+		return -ENOMEM;
+
+	attr->type = type;
+	attr->config = config;
+	return 0;
+}
+
+static int add_hw_hybrid(struct parse_events_state *parse_state,
+			 struct list_head *list, struct perf_event_attr *attr,
+			 char *name, struct list_head *config_terms)
+{
+	struct perf_pmu *pmu;
+	int ret;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		ret = create_event_hybrid(PERF_TYPE_HARDWARE_PMU,
+					  &parse_state->idx, list, attr, name,
+					  config_terms, pmu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
+				     struct list_head *list,
+				     struct perf_event_attr *attr,
+				     char *name, struct list_head *config_terms,
+				     bool *hybrid)
+{
+	*hybrid = false;
+	if (attr->type == PERF_TYPE_SOFTWARE)
+		return 0;
+
+	if (!perf_pmu__has_hybrid())
+		return 0;
+
+	*hybrid = true;
+	if (attr->type != PERF_TYPE_RAW) {
+		return add_hw_hybrid(parse_state, list, attr, name,
+				     config_terms);
+	}
+
+	return -1;
+}
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
new file mode 100644
index 000000000000..d81a76978480
--- /dev/null
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_PARSE_EVENTS_HYBRID_H
+#define __PERF_PARSE_EVENTS_HYBRID_H
+
+#include <linux/list.h>
+#include <stdbool.h>
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include <string.h>
+
+int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
+				     struct list_head *list,
+				     struct perf_event_attr *attr,
+				     char *name, struct list_head *config_terms,
+				     bool *hybrid);
+
+#endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9ecb45bea948..1bbd0ba92ba7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -37,6 +37,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/pfm.h"
+#include "util/parse-events-hybrid.h"
 #include "perf.h"
 
 #define MAX_NAME_LEN 100
@@ -1416,6 +1417,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
+	bool hybrid;
+	int ret;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.type = type;
@@ -1430,6 +1433,12 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			return -ENOMEM;
 	}
 
+	ret = parse_events__add_numeric_hybrid(parse_state, list, &attr,
+					       get_config_name(head_config),
+					       &config_terms, &hybrid);
+	if (hybrid)
+		return ret;
+
 	return add_event(list, &parse_state->idx, &attr,
 			 get_config_name(head_config), &config_terms);
 }
@@ -3182,3 +3191,12 @@ char *parse_events_formats_error_string(char *additional_terms)
 fail:
 	return NULL;
 }
+
+struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
+					     struct perf_event_attr *attr,
+					     char *name, struct perf_pmu *pmu,
+					     struct list_head *config_terms)
+{
+	return __add_event(list, idx, attr, true, name, pmu,
+			   config_terms, false, NULL);
+}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e80c9b74f2f2..c4f2f96304ce 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -263,4 +263,9 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 
 int perf_pmu__test_parse_init(void);
 
+struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
+					     struct perf_event_attr *attr,
+					     char *name, struct perf_pmu *pmu,
+					     struct list_head *config_terms);
+
 #endif /* __PERF_PARSE_EVENTS_H */
-- 
2.17.1

