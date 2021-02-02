Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365EF30CCE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBBUQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:16:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:59912 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhBBUPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:15:55 -0500
IronPort-SDR: ukvoKbRTzcWdAHeFf64CXqnhVlg8fcNyX+L7a5nrgzAFc2LN0hKWKcgr7+x4iHUcAaZSxLV30I
 p7LvQUuFw+Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148777"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:09 -0800
IronPort-SDR: 6kRv1kG882DkQgVZiedRNOOQjGpeLAK8YrNneLd3PzXynrdgpPDan4UWbKlAPL9WJh33U8aefm
 S/pTeS7ktqJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442504"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:08 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/9] perf tools: Support the auxiliary event
Date:   Tue,  2 Feb 2021 12:09:06 -0800
Message-Id: <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

On the Intel Sapphire Rapids server, an auxiliary event has to be
enabled simultaneously with the load latency event to retrieve complete
Memory Info.

Add X86 specific perf_mem_events__name() to handle the auxiliary event.
- Users are only interested in the samples of the mem-loads event.
  Sample read the auxiliary event.
- The auxiliary event must be in front of the load latency event in a
  group. Assume the second event to sample if the auxiliary event is the
  leader.
- Add a weak is_mem_loads_aux_event() to check the auxiliary event for
  X86. For other ARCHs, it always return false.

Parse the unique event name, mem-loads-aux, for the auxiliary event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/Build        |  1 +
 tools/perf/arch/x86/util/mem-events.c | 44 +++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c               |  3 +++
 tools/perf/util/mem-events.c          |  5 ++++
 tools/perf/util/mem-events.h          |  2 ++
 tools/perf/util/parse-events.l        |  1 +
 tools/perf/util/record.c              |  5 +++-
 7 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/x86/util/mem-events.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 347c39b..d73f548 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += mem-events.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
new file mode 100644
index 0000000..11b8469
--- /dev/null
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/pmu.h"
+#include "map_symbol.h"
+#include "mem-events.h"
+
+static char mem_loads_name[100];
+static bool mem_loads_name__init;
+
+#define MEM_LOADS_AUX		0x8203
+#define MEM_LOADS_AUX_NAME	"{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
+
+bool is_mem_loads_aux_event(struct evsel *leader)
+{
+	if (!pmu_have_event("cpu", "mem-loads-aux"))
+		return false;
+
+	return leader->core.attr.config == MEM_LOADS_AUX;
+}
+
+char *perf_mem_events__name(int i)
+{
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (!e)
+		return NULL;
+
+	if (i == PERF_MEM_EVENTS__LOAD) {
+		if (mem_loads_name__init)
+			return mem_loads_name;
+
+		mem_loads_name__init = true;
+
+		if (pmu_have_event("cpu", "mem-loads-aux")) {
+			scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
+				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
+		} else {
+			scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				  e->name, perf_mem_events__loads_ldlat);
+		}
+		return mem_loads_name;
+	}
+
+	return (char *)e->name;
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c26ea822..c48f6de 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2689,6 +2689,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
+	case ENODATA:
+		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
+				 "Please add an auxiliary event in front of the load latency event.");
 	default:
 		break;
 	}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 19007e4..3edfb88 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -56,6 +56,11 @@ char * __weak perf_mem_events__name(int i)
 	return (char *)e->name;
 }
 
+__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
+{
+	return false;
+}
+
 int perf_mem_events__parse(const char *str)
 {
 	char *tok, *saveptr = NULL;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 5ef1782..045a507 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -9,6 +9,7 @@
 #include <linux/refcount.h>
 #include <linux/perf_event.h>
 #include "stat.h"
+#include "evsel.h"
 
 struct perf_mem_event {
 	bool		record;
@@ -39,6 +40,7 @@ int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
 struct perf_mem_event *perf_mem_events__ptr(int i);
+bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_mem_events__list(void);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097..0b36285 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -356,6 +356,7 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
 cycles-ct				|
 cycles-t				|
 mem-loads				|
+mem-loads-aux				|
 mem-stores				|
 topdown-[a-z-]+				|
 tx-capacity-[a-z-]+			|
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index e70c9dd..d0735fb 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -15,6 +15,8 @@
 #include "record.h"
 #include "../perf-sys.h"
 #include "topdown.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 
 /*
  * evsel__config_leader_sampling() uses special rules for leader sampling.
@@ -25,7 +27,8 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
 {
 	struct evsel *leader = evsel->leader;
 
-	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader)) {
+	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
+	    is_mem_loads_aux_event(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->leader == leader && evsel != evsel->leader)
 				return evsel;
-- 
2.7.4

