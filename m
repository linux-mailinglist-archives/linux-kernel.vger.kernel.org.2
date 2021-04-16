Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF5362ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhDPWOW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 18:14:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55962 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235705AbhDPWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:14:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GMDjOA024667
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37ybbnjuc5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:46 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 15:13:42 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E3B7262E1FDE; Fri, 16 Apr 2021 15:13:38 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 3/4] perf-stat: introduce config stat.bpf-counter-events
Date:   Fri, 16 Apr 2021 15:13:24 -0700
Message-ID: <20210416221325.2373497-4-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416221325.2373497-1-song@kernel.org>
References: <20210416221325.2373497-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X-Nr0BhRJm_-9bzYOJnm7cwSc5WNH4q2
X-Proofpoint-ORIG-GUID: X-Nr0BhRJm_-9bzYOJnm7cwSc5WNH4q2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160155
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
 tools/perf/builtin-stat.c              | 43 +++++++++++++++++---------
 tools/perf/util/bpf_counter.c          |  2 ++
 tools/perf/util/config.c               |  4 +++
 tools/perf/util/evsel.c                | 22 +++++++++++++
 tools/perf/util/evsel.h                |  8 +++++
 tools/perf/util/target.h               |  5 ---
 7 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 6ec5960b08c3d..78afe13cd7d47 100644
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
index 2a2c15cac80a3..0c76271f3ef53 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -413,6 +413,8 @@ static int read_affinity_counters(struct timespec *rs)
 		evlist__for_each_entry(evsel_list, counter) {
 			if (evsel__cpu_iter_skip(counter, cpu))
 				continue;
+			if (evsel__is_bpf(counter))
+				continue;
 			if (!counter->err) {
 				counter->err = read_counter_cpu(counter, rs,
 								counter->cpu_iter - 1);
@@ -423,17 +425,28 @@ static int read_affinity_counters(struct timespec *rs)
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
+		if (!evsel__is_bpf(counter)) {
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
@@ -442,9 +455,10 @@ static void read_counters(struct timespec *rs)
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
@@ -535,12 +549,13 @@ static int enable_counters(void)
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
@@ -784,11 +799,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
index 5de991ab46af9..3189b63714371 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -792,6 +792,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
 	else if (target->use_bpf)
 		evsel->bpf_counter_ops = &bperf_ops;
+	else if (evsel__match_bpf_counter_events(evsel->name))
+		evsel->bpf_counter_ops = &bperf_ops;
 
 	if (evsel->bpf_counter_ops)
 		return evsel->bpf_counter_ops->load(evsel, target);
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

