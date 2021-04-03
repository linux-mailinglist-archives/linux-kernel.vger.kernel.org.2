Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83ED3531C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhDCAbA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Apr 2021 20:31:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235241AbhDCAa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 20:30:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1330Uefs016549
        for <linux-kernel@vger.kernel.org>; Fri, 2 Apr 2021 17:30:58 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37p9549nds-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 17:30:57 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 17:29:58 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D448062E209C; Fri,  2 Apr 2021 17:29:49 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 2/2] perf-stat: introduce config stat.bpf-counter-events
Date:   Fri, 2 Apr 2021 17:29:38 -0700
Message-ID: <20210403002938.390878-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210403002938.390878-1-song@kernel.org>
References: <20210403002938.390878-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I_E8UwIieGB-sV5fbI9yIXRe8Nj4053y
X-Proofpoint-ORIG-GUID: I_E8UwIieGB-sV5fbI9yIXRe8Nj4053y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_16:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 clxscore=1034 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to use BPF to aggregate perf event counters, the user uses
--bpf-counters option. Enable "use bpf by default" events with a config
option, stat.bpf-counter-events. This is limited to hardware events in
evsel__hw_names.

This also enables mixed BPF event and regular event in the same sesssion.
For example:

   perf config stat.bpf-counter-events=instructions
   perf stat -e instructions,cs

The second command will use BPF for "instructions" but not "cs".

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  2 ++
 tools/perf/builtin-stat.c              | 41 ++++++++++++++++----------
 tools/perf/util/bpf_counter.c          | 11 +++++++
 tools/perf/util/config.c               | 32 ++++++++++++++++++++
 tools/perf/util/evsel.c                |  2 ++
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/target.h               |  5 ----
 7 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 744211fa8c186..6d4733eaac170 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -97,6 +97,8 @@ report::
 	Use BPF programs to aggregate readings from perf_events.  This
 	allows multiple perf-stat sessions that are counting the same metric (cycles,
 	instructions, etc.) to share hardware counters.
+	To use BPF programs on common hardware events by default, use
+	"perf config stat.bpf-counter-events=<list_of_events>".
 
 --bpf-attr-map::
 	With option "--bpf-counters", different perf-stat sessions share
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4bb48c6b66980..5adfa708ffe68 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -423,17 +423,28 @@ static int read_affinity_counters(struct timespec *rs)
 	return 0;
 }
 
+/*
+ * Returns:
+ *     0   if all events use BPF;
+ *     1   if some events do NOT use BPF;
+ *     < 0 on errors;
+ */
 static int read_bpf_map_counters(void)
 {
+	bool has_none_bpf_events = false;
 	struct evsel *counter;
 	int err;
 
 	evlist__for_each_entry(evsel_list, counter) {
+		if (!counter->bpf_counter_ops) {
+			has_none_bpf_events = true;
+			continue;
+		}
 		err = bpf_counter__read(counter);
 		if (err)
 			return err;
 	}
-	return 0;
+	return has_none_bpf_events ? 1 : 0;
 }
 
 static void read_counters(struct timespec *rs)
@@ -442,9 +453,10 @@ static void read_counters(struct timespec *rs)
 	int err;
 
 	if (!stat_config.stop_read_counter) {
-		if (target__has_bpf(&target))
-			err = read_bpf_map_counters();
-		else
+		err = read_bpf_map_counters();
+		if (err < 0)
+			return;
+		if (err)
 			err = read_affinity_counters(rs);
 		if (err < 0)
 			return;
@@ -535,12 +547,13 @@ static int enable_counters(void)
 	struct evsel *evsel;
 	int err;
 
-	if (target__has_bpf(&target)) {
-		evlist__for_each_entry(evsel_list, evsel) {
-			err = bpf_counter__enable(evsel);
-			if (err)
-				return err;
-		}
+	evlist__for_each_entry(evsel_list, evsel) {
+		if (!evsel->bpf_counter_ops)
+			continue;
+
+		err = bpf_counter__enable(evsel);
+		if (err)
+			return err;
 	}
 
 	if (stat_config.initial_delay < 0) {
@@ -784,11 +797,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
-	if (target__has_bpf(&target)) {
-		evlist__for_each_entry(evsel_list, counter) {
-			if (bpf_counter__load(counter, &target))
-				return -1;
-		}
+	evlist__for_each_entry(evsel_list, counter) {
+		if (bpf_counter__load(counter, &target))
+			return -1;
 	}
 
 	evlist__for_each_cpu (evsel_list, i, cpu) {
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index df70c8dcf7850..ea45914af1693 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -792,6 +792,17 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
 	else if (target->use_bpf)
 		evsel->bpf_counter_ops = &bperf_ops;
+	else {
+		int i;
+
+		for (i = 0; i < PERF_COUNT_HW_MAX; i++) {
+			if (!strcmp(evsel->name, evsel__hw_names[i])) {
+				if (evsel__use_bpf_counters[i])
+					evsel->bpf_counter_ops = &bperf_ops;
+				break;
+			}
+		}
+	}
 
 	if (evsel->bpf_counter_ops)
 		return evsel->bpf_counter_ops->load(evsel, target);
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 2daeaa9a4a241..fe2ec56258735 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -18,6 +18,7 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
+#include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
@@ -433,6 +434,29 @@ static int perf_buildid_config(const char *var, const char *value)
 	return 0;
 }
 
+static int perf_stat_config_parse_bpf_counter_event(const char *value)
+{
+	char *event_str, *event_str_, *tok, *saveptr = NULL;
+	int i;
+
+	event_str_ = event_str = strdup(value);
+	if (!event_str)
+		return -1;
+
+	while ((tok = strtok_r(event_str, ",", &saveptr)) != NULL) {
+		for (i = 0; i < PERF_COUNT_HW_MAX; i++) {
+			if (!strcmp(tok, evsel__hw_names[i])) {
+				evsel__use_bpf_counters[i] = true;
+				break;
+			}
+		}
+		event_str = NULL;
+	}
+
+	free(event_str_);
+	return 0;
+}
+
 static int perf_default_core_config(const char *var __maybe_unused,
 				    const char *value __maybe_unused)
 {
@@ -454,9 +478,17 @@ static int perf_ui_config(const char *var, const char *value)
 
 static int perf_stat_config(const char *var, const char *value)
 {
+	int err = 0;
+
 	if (!strcmp(var, "stat.big-num"))
 		perf_stat__set_big_num(perf_config_bool(var, value));
 
+	if (!strcmp(var, "stat.bpf-counter-events")) {
+		err = perf_stat_config_parse_bpf_counter_event(value);
+		if (err)
+			return err;
+	}
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2d2614eeaa20e..592d93bcccd04 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -492,6 +492,8 @@ const char *evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"ref-cycles",
 };
 
+bool evsel__use_bpf_counters[PERF_COUNT_HW_MAX] = {false};
+
 static const char *__evsel__hw_name(u64 config)
 {
 	if (config < PERF_COUNT_HW_MAX && evsel__hw_names[config])
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dd4f56f9cfdf5..32439c5684f7d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -247,6 +247,7 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
 extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
 extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
+extern bool evsel__use_bpf_counters[PERF_COUNT_HW_MAX];
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 1bce3eb28ef25..4ff56217f2a65 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -66,11 +66,6 @@ static inline bool target__has_cpu(struct target *target)
 	return target->system_wide || target->cpu_list;
 }
 
-static inline bool target__has_bpf(struct target *target)
-{
-	return target->bpf_str || target->use_bpf;
-}
-
 static inline bool target__none(struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
-- 
2.30.2

