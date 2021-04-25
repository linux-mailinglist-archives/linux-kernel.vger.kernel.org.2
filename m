Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74536A996
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhDYVoh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Apr 2021 17:44:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhDYVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:44:35 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13PLV2Ju023823
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:43:54 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3853dyj7rm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:43:54 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Apr 2021 14:43:53 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 339B562E2330; Sun, 25 Apr 2021 14:43:44 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v5 3/5] perf-stat: introduce config stat.bpf-counter-events
Date:   Sun, 25 Apr 2021 14:43:31 -0700
Message-ID: <20210425214333.1090950-4-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425214333.1090950-1-song@kernel.org>
References: <20210425214333.1090950-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 89o1K3qZLkWUBHRzpfhb8wYYEGTYN7W7
X-Proofpoint-ORIG-GUID: 89o1K3qZLkWUBHRzpfhb8wYYEGTYN7W7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_09:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 clxscore=1034 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to use BPF to aggregate perf event counters, the user uses
--bpf-counters option. Enable "use bpf by default" events with a config
option, stat.bpf-counter-events. Events with name in the option will use
BPF.

This also enables mixed BPF event and regular event in the same sesssion.
For example:

   perf config stat.bpf-counter-events=instructions
   perf stat -e instructions,cs

The second command will use BPF for "instructions" but not "cs".

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  2 ++
 tools/perf/builtin-stat.c              | 42 +++++++++++++++-----------
 tools/perf/util/bpf_counter.c          |  3 +-
 tools/perf/util/config.c               |  4 +++
 tools/perf/util/evsel.c                | 22 ++++++++++++++
 tools/perf/util/evsel.h                |  8 +++++
 tools/perf/util/target.h               |  5 ---
 7 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 6ec5960b08c3d..f10e24da23e90 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -97,6 +97,8 @@ report::
 	Use BPF programs to aggregate readings from perf_events.  This
 	allows multiple perf-stat sessions that are counting the same metric (cycles,
 	instructions, etc.) to share hardware counters.
+	To use BPF programs on common events by default, use
+	"perf config stat.bpf-counter-events=<list_of_events>".
 
 --bpf-attr-map::
 	With option "--bpf-counters", different perf-stat sessions share
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2a2c15cac80a3..8729eed30b668 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -160,6 +160,7 @@ static const char *smi_cost_attrs = {
 };
 
 static struct evlist	*evsel_list;
+static bool all_counters_use_bpf = true;
 
 static struct target target = {
 	.uid	= UINT_MAX,
@@ -399,6 +400,9 @@ static int read_affinity_counters(struct timespec *rs)
 	struct affinity affinity;
 	int i, ncpus, cpu;
 
+	if (all_counters_use_bpf)
+		return 0;
+
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
@@ -413,6 +417,8 @@ static int read_affinity_counters(struct timespec *rs)
 		evlist__for_each_entry(evsel_list, counter) {
 			if (evsel__cpu_iter_skip(counter, cpu))
 				continue;
+			if (evsel__is_bpf(counter))
+				continue;
 			if (!counter->err) {
 				counter->err = read_counter_cpu(counter, rs,
 								counter->cpu_iter - 1);
@@ -429,6 +435,9 @@ static int read_bpf_map_counters(void)
 	int err;
 
 	evlist__for_each_entry(evsel_list, counter) {
+		if (!evsel__is_bpf(counter))
+			continue;
+
 		err = bpf_counter__read(counter);
 		if (err)
 			return err;
@@ -439,14 +448,10 @@ static int read_bpf_map_counters(void)
 static void read_counters(struct timespec *rs)
 {
 	struct evsel *counter;
-	int err;
 
 	if (!stat_config.stop_read_counter) {
-		if (target__has_bpf(&target))
-			err = read_bpf_map_counters();
-		else
-			err = read_affinity_counters(rs);
-		if (err < 0)
+		if (read_bpf_map_counters() ||
+		    read_affinity_counters(rs))
 			return;
 	}
 
@@ -535,12 +540,13 @@ static int enable_counters(void)
 	struct evsel *evsel;
 	int err;
 
-	if (target__has_bpf(&target)) {
-		evlist__for_each_entry(evsel_list, evsel) {
-			err = bpf_counter__enable(evsel);
-			if (err)
-				return err;
-		}
+	evlist__for_each_entry(evsel_list, evsel) {
+		if (!evsel__is_bpf(evsel))
+			continue;
+
+		err = bpf_counter__enable(evsel);
+		if (err)
+			return err;
 	}
 
 	if (stat_config.initial_delay < 0) {
@@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
+		if (!evsel__is_bpf(counter))
+			all_counters_use_bpf = false;
 	}
 
 	evlist__for_each_cpu (evsel_list, i, cpu) {
@@ -805,6 +811,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				continue;
 			if (counter->reset_group || counter->errored)
 				continue;
+			if (evsel__is_bpf(counter))
+				continue;
 try_again:
 			if (create_perf_stat_counter(counter, &stat_config, &target,
 						     counter->cpu_iter - 1) < 0) {
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 5de991ab46af9..33b1888103dfa 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 {
 	if (target->bpf_str)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
-	else if (target->use_bpf)
+	else if (target->use_bpf ||
+		 evsel__match_bpf_counter_events(evsel->name))
 		evsel->bpf_counter_ops = &bperf_ops;
 
 	if (evsel->bpf_counter_ops)
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6bcb5ef221f8c..63d472b336de2 100644
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
@@ -460,6 +461,9 @@ static int perf_stat_config(const char *var, const char *value)
 	if (!strcmp(var, "stat.no-csv-summary"))
 		perf_stat__set_no_csv_summary(perf_config_bool(var, value));
 
+	if (!strcmp(var, "stat.bpf-counter-events"))
+		evsel__bpf_counter_events = strdup(value);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2d2614eeaa20e..080ddcfefbcd2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -492,6 +492,28 @@ const char *evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"ref-cycles",
 };
 
+char *evsel__bpf_counter_events;
+
+bool evsel__match_bpf_counter_events(const char *name)
+{
+	int name_len;
+	bool match;
+	char *ptr;
+
+	if (!evsel__bpf_counter_events)
+		return false;
+
+	ptr = strstr(evsel__bpf_counter_events, name);
+	name_len = strlen(name);
+
+	/* check name matches a full token in evsel__bpf_counter_events */
+	match = (ptr != NULL) &&
+		((ptr == evsel__bpf_counter_events) || (*(ptr - 1) == ',')) &&
+		((*(ptr + name_len) == ',') || (*(ptr + name_len) == '\0'));
+
+	return match;
+}
+
 static const char *__evsel__hw_name(u64 config)
 {
 	if (config < PERF_COUNT_HW_MAX && evsel__hw_names[config])
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eccc4fd5b3eb4..ce4b629d659c2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -239,6 +239,11 @@ void evsel__calc_id_pos(struct evsel *evsel);
 
 bool evsel__is_cache_op_valid(u8 type, u8 op);
 
+static inline bool evsel__is_bpf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL;
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
@@ -246,6 +251,9 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
 extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
 extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
+extern char *evsel__bpf_counter_events;
+bool evsel__match_bpf_counter_events(const char *name);
+
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

