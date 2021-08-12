Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE7A3E9B05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhHKWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHKWoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:44:04 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17030C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:43:40 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id r14-20020a6b440e0000b029057f73c98d95so2364080ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PNTKYAZgcXAwr31S6UMFikzfj5+3SYwlGm3zWc2kFyc=;
        b=ovAFTTlOHFMR8BcZ8LMzL/787WIUaxV+89RFJrtAXefPocxr1rLGkAH99LBZ1UtXvs
         nPznZuny5q9VoVsAJcGsRRbH+v/Dt3ScSLgO45lxF9SGYPxLnQHGSoV/lrdin5MyiBp+
         kJjldkmnBjQlKZ3eWAjPGSeSmXSBOA66pT79NjEjRjmzoxFNW413x8ho8m+pcVEQXUUW
         PC9zTTUnoQ+ro//KTur/WeRBT4Ij+KU03OMkTEp9vQ8exjg/MR2hrAZQNuvB3w3KqcHi
         cGHFj5WMxYyiMefsHqBAJXTBoUSQXyVjZKtXCPTmZmdTTZRT2EiHSf6ZuRxGcKWLJ+FO
         KDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PNTKYAZgcXAwr31S6UMFikzfj5+3SYwlGm3zWc2kFyc=;
        b=gAHDWKOu4+XkIPa4s9ZkCdFIYw/JglGKs+uIxFSjvZgkxZyZs2aoBlMhbFjc90EqSR
         dR/YBIeK/Yck5hVxSIWWuqmxAMrv3Q8nBGrMGJ1jkaJDXsIl+/5mTDeEJQskoP5fBMra
         tjtijZdUKbV+PGJHhqpKt5F4NAJtMGGK0DPF7UZ4u0iSziRcGaQHE5NQUTIOpvQD5Wos
         4kYVgHUWOjxlegBJIRUl4LXH196qIZtLeeqjE25QGNNZ9jVYCEsO2VbszYz4/iU3w41k
         xMML6fsugIWkg4k0EBKbBJa2Lfhn+xgHEV9EX46aWUhrQmKCbFnsXRzWTy1JA7Hhsxdg
         k5vA==
X-Gm-Message-State: AOAM530YWLVAQDpZ82/tmYuq0DEFRRDoNI/3NIe31KiAJFSQdvwZw7FR
        FSHo64opEZs5AY3FUYY3VgI010wGZwA=
X-Google-Smtp-Source: ABdhPJzH4LDkssG+tjn8Eo2TV5X7izSCX//JC7/IJ9SJWsmx6I1rEnGFoVmZ+7IQSbxAA6PzFyUPFs2A0RA=
X-Received: from cjense.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:6d0])
 (user=cjense job=sendgmr) by 2002:a05:6e02:1b88:: with SMTP id
 h8mr565426ili.48.1628721819306; Wed, 11 Aug 2021 15:43:39 -0700 (PDT)
Date:   Wed, 11 Aug 2021 22:43:18 +0000
Message-Id: <20210811224317.1811618-1-cjense@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 1/1] perf stat: Add JSON output option and testing.
From:   Claire Jensen <cjense@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        song@kernel.org, andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Claire Jensen <cjense@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSV output is tricky to format and column layout changes are susceptible
to breaking parsers. New JSON-formatted output has variable names to
identify fields that are consistent and informative, making
the output parseable.

CSV output example:

1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
0,,context-switches:u,1204272,100.00,0.000,/sec
0,,cpu-migrations:u,1204272,100.00,0.000,/sec
70,,page-faults:u,1204272,100.00,58.126,K/sec

JSON output example:

{"counter-value" : "3805.723968", "unit" : "msec", "event" :
"cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
: 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
{"counter-value" : "6166.000000", "unit" : "", "event" :
"context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
: 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
{"counter-value" : "466.000000", "unit" : "", "event" :
"cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
: 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
{"counter-value" : "208.000000", "unit" : "", "event" :
"page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
: 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}

Add field checking tests for perf stat JSON output.
Counts number of fields to make sure expected fields are present.

Also added documentation for JSON option.

Signed-off-by: Claire Jensen <cjense@google.com>
---
 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   2 +
 .../tests/shell/lib/perf_json_output_test.py  |  49 ++
 tools/perf/tests/shell/stat+json_output.sh    | 114 +++++
 tools/perf/util/stat-display.c                | 429 +++++++++++++-----
 tools/perf/util/stat-shadow.c                 |   5 +-
 tools/perf/util/stat.h                        |   1 +
 7 files changed, 502 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_test.py
 create mode 100644 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 45c2467e4eb2..80ae3802a904 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -554,6 +554,27 @@ Additional metrics may be printed with all earlier fields being empty.
 
 include::intel-hybrid.txt[]
 
+JSON FORMAT
+-----------
+
+With -j, perf stat is able to print out a JSON format output
+that can be used for parsing.
+
+- timestamp : optional usec time stamp in fractions of second (with -I)
+- optional aggregate options:
+		- core : core identifier (with --per-core)
+		- die : die identifier (with --per-die)
+		- socket : socket identifier (with --per-socket)
+		- node : node identifier (with --per-node)
+		- thread : thread identifier (with --per-thread)
+- counter-value : counter value
+- unit : unit of the counter value or empty
+- event : event name
+- variance : optional variance if multiple values are collected (with -r)
+- runtime : run time of counter
+- metric-value : optional metric value
+- metric-unit : optional unit of metric
+
 SEE ALSO
 --------
 linkperf:perf-top[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 634375937db9..71b8418a2a06 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1218,6 +1218,8 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
+	OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
+		   "print counts in JSON format"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
 		     "monitor event in cgroup name only", parse_stat_cgroups),
 	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
diff --git a/tools/perf/tests/shell/lib/perf_json_output_test.py b/tools/perf/tests/shell/lib/perf_json_output_test.py
new file mode 100644
index 000000000000..93328e1d9f48
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_test.py
@@ -0,0 +1,49 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+
+from __future__ import print_function
+import argparse
+import sys
+
+# Basic sanity check of perf JSON output as specified in the man page.
+# Currently just checks the number of fields per line in output.
+
+ap = argparse.ArgumentParser()
+ap.add_argument('--no-args', action='store_true')
+ap.add_argument('--interval', action='store_true')
+ap.add_argument('--all-cpus-no-aggr', action='store_true')
+ap.add_argument('--all-cpus', action='store_true')
+ap.add_argument('--event', action='store_true')
+ap.add_argument('--per-core', action='store_true')
+ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-die', action='store_true')
+ap.add_argument('--per-node', action='store_true')
+ap.add_argument('--per-socket', action='store_true')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+ch = ','
+
+
+def check_json_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = 0
+      count = line.count(ch)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError('wrong number of fields. counted {0}'
+                           ' expected {1} in {2}\n'.format(count, exp, line))
+
+
+try:
+  if args.no_args or args.all_cpus or args.event:
+    check_json_output(6)
+  if args.interval or args.per_thread:
+    check_json_output(7)
+  if args.per_core or args.per_socket or args.per_node or args.per_die:
+    check_json_output(8)
+
+except:
+  sys.stdout.write('Test failed for input:\n' + ''.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
new file mode 100644
index 000000000000..bb05d5060680
--- /dev/null
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf stat JSON output linter
+# Tests various perf stat JSON output commands for the
+# correct number of fields.
+
+set -e
+set -x
+
+pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
+file="/proc/sys/kernel/perf_event_paranoid"
+paranoia=$(cat "$file" | grep -o -E '[0-9]+')
+
+check_no_args()
+{
+	perf stat -j sleep 1 2>&1 | \
+	python $pythonchecker --no-args
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_all_cpus()
+	{
+		perf stat -j -a 2>&1 sleep 1 | \
+		python $pythonchecker --all-cpus
+	}
+	check_all_cpus
+fi
+
+check_interval()
+{
+	perf stat -j -I 1000 2>&1 sleep 1 | \
+	python $pythonchecker --interval
+}
+
+check_all_cpus_no_aggr()
+{
+	perf stat -j -A -a --no-merge 2>&1 sleep 1 | \
+	python $pythonchecker --all-cpus-no-aggr
+}
+
+check_event()
+{
+	perf stat -j -e cpu-clock 2>&1 sleep 1 | \
+	python $pythonchecker --event
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_core()
+	{
+		perf stat -j --per-core -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-core
+	}
+	check_per_core
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_thread()
+	{
+		perf stat -j --per-thread -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-thread
+	}
+	check_per_thread
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_die test skipped because of paranoia level.
+else
+	check_per_die()
+	{
+		perf stat -j --per-die -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-die
+	}
+	check_per_die
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_node test skipped because of paranoia level.
+else
+	check_per_node()
+	{
+		perf stat -j --per-node -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-node
+	}
+	check_per_node
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_socket test skipped because of paranoia level.
+else
+	check_per_socket()
+	{
+		perf stat -j --per-socket -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-socket
+	}
+	check_per_socket
+fi
+
+check_no_args
+check_interval
+check_all_cpus_no_aggr
+check_event
+exit 0
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..82d23fd0df46 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,25 +1,25 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <inttypes.h>
-#include <linux/string.h>
-#include <linux/time64.h>
+#include "third_party/linux_tools/src/tools/include/linux/string.h"
+#include "third_party/linux_tools/src/tools/include/linux/time64.h"
 #include <math.h>
-#include "color.h"
-#include "counts.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "stat.h"
-#include "top.h"
-#include "thread_map.h"
-#include "cpumap.h"
-#include "string2.h"
-#include <linux/ctype.h>
-#include "cgroup.h"
-#include <api/fs/fs.h>
-#include "util.h"
-#include "iostat.h"
-#include "pmu-hybrid.h"
-#include "evlist-hybrid.h"
+#include "third_party/linux_tools/src/tools/perf/util/color.h"
+#include "third_party/linux_tools/src/tools/perf/util/counts.h"
+#include "third_party/linux_tools/src/tools/perf/util/evlist.h"
+#include "third_party/linux_tools/src/tools/perf/util/evsel.h"
+#include "third_party/linux_tools/src/tools/perf/util/stat.h"
+#include "third_party/linux_tools/src/tools/perf/util/top.h"
+#include "third_party/linux_tools/src/tools/perf/util/thread_map.h"
+#include "third_party/linux_tools/src/tools/perf/util/cpumap.h"
+#include "third_party/linux_tools/src/tools/perf/util/string2.h"
+#include "third_party/linux_tools/src/tools/include/linux/ctype.h"
+#include "third_party/linux_tools/src/tools/perf/util/cgroup.h"
+#include "third_party/linux_tools/src/tools/lib/api/fs/fs.h"
+#include "third_party/linux_tools/src/tools/perf/util/util.h"
+#include "third_party/linux_tools/src/tools/perf/util/iostat.h"
+#include "third_party/linux_tools/src/tools/perf/util/pmu-hybrid.h"
+#include "third_party/linux_tools/src/tools/perf/util/evlist-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -27,15 +27,21 @@
 static void print_running(struct perf_stat_config *config,
 			  u64 run, u64 ena)
 {
-	if (config->csv_output) {
-		fprintf(config->output, "%s%" PRIu64 "%s%.2f",
-					config->csv_sep,
-					run,
-					config->csv_sep,
-					ena ? 100.0 * run / ena : 100.0);
-	} else if (run != ena) {
+
+	double enabled_percent = 100;
+
+	if (run != ena)
+		enabled_percent = 100 * run / ena;
+	if (config->json_output)
+		fprintf(config->output,
+						"\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",
+						 run, enabled_percent);
+	else if (config->csv_output)
+		fprintf(config->output,
+						"%s%" PRIu64 "%s%.2f", config->csv_sep,
+						 run, config->csv_sep, enabled_percent);
+	else if (run != ena)
 		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
-	}
 }
 
 static void print_noise_pct(struct perf_stat_config *config,
@@ -43,7 +49,9 @@ static void print_noise_pct(struct perf_stat_config *config,
 {
 	double pct = rel_stddev_stats(total, avg);
 
-	if (config->csv_output)
+	if (config->json_output)
+		fprintf(config->output, "\"variance\" : %.2f, ", pct);
+	else if (config->csv_output)
 		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
 	else if (pct)
 		fprintf(config->output, "  ( +-%6.2f%% )", pct);
@@ -63,9 +71,16 @@ static void print_noise(struct perf_stat_config *config,
 
 static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 {
-	if (nr_cgroups) {
+	if (config->json_output && nr_cgroups) {
 		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
+
+		fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
+	} else {
+		if (nr_cgroups) {
+			const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
+
 		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+		}
 	}
 }
 
@@ -73,8 +88,20 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 static void aggr_printout(struct perf_stat_config *config,
 			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
 {
+
+
+	if (config->json_output && !config->interval)
+		fprintf(config->output, "{");
+
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+		if (config->json_output) {
+			fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\", \"cpu\" : %d, ",
+						 id.socket,
+						 id.die,
+						 id.core,
+						 nr);
+	} else {
 		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
 			id.socket,
 			id.die,
@@ -84,56 +111,95 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_output ? 0 : 4,
 			nr,
 			config->csv_sep);
+	}
 		break;
 	case AGGR_DIE:
-		fprintf(config->output, "S%d-D%*d%s%*d%s",
-			id.socket,
-			config->csv_output ? 0 : -8,
-			id.die,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
+			if (config->json_output) {
+				fprintf(config->output, "\"die\" : \"S%d-D%d\", \"cpu\" : %d, ",
+					 id.socket,
+					 id.die,
+					 nr);
+		} else {
+			fprintf(config->output, "S%d-D%*d%s%*d%s",
+				id.socket,
+				config->csv_output ? 0 : -8,
+				id.die,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
 		break;
 	case AGGR_SOCKET:
-		fprintf(config->output, "S%*d%s%*d%s",
-			config->csv_output ? 0 : -5,
-			id.socket,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
+			if (config->json_output) {
+				fprintf(config->output, "\"socket\" : \"S%d\", \"number\" : %d, ",
+					 id.socket,
+					 nr);
+		} else {
+			fprintf(config->output, "S%*d%s%*d%s",
+				config->csv_output ? 0 : -5,
+				id.socket,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
 			break;
 	case AGGR_NODE:
-		fprintf(config->output, "N%*d%s%*d%s",
-			config->csv_output ? 0 : -5,
-			id.node,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
+			if (config->json_output) {
+				fprintf(config->output, "\"node\" : \"N%d\", \"cpu\" : %d, ",
+					 id.node,
+					 nr);
+		} else {
+			fprintf(config->output, "N%*d%s%*d%s",
+				config->csv_output ? 0 : -5,
+				id.node,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
 			break;
 	case AGGR_NONE:
-		if (evsel->percore && !config->percore_show_thread) {
-			fprintf(config->output, "S%d-D%d-C%*d%s",
-				id.socket,
-				id.die,
-				config->csv_output ? 0 : -3,
-				id.core, config->csv_sep);
+		if (config->json_output) {
+			if (evsel->percore && !config->percore_show_thread) {
+				fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\"",
+					id.socket,
+					id.die,
+					id.core);
+			} else if (id.core > -1) {
+				fprintf(config->output, "\"cpu\" : \"%d\", ",
+					evsel__cpus(evsel)->map[id.core]);
+			}
+		} else {
+			if (evsel->percore && !config->percore_show_thread) {
+				fprintf(config->output, "S%d-D%d-C%*d%s",
+					id.socket,
+					id.die,
+					config->csv_output ? 0 : -3,
+					id.core, config->csv_sep);
 		} else if (id.core > -1) {
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
 				evsel__cpus(evsel)->map[id.core],
 				config->csv_sep);
-		}
+			}
+	}
+
 		break;
 	case AGGR_THREAD:
-		fprintf(config->output, "%*s-%*d%s",
-			config->csv_output ? 0 : 16,
-			perf_thread_map__comm(evsel->core.threads, id.thread),
-			config->csv_output ? 0 : -8,
-			perf_thread_map__pid(evsel->core.threads, id.thread),
-			config->csv_sep);
+			if (config->json_output) {
+				fprintf(config->output, "\"thread\" : \"%s-%d\", ",
+					 perf_thread_map__comm(evsel->core.threads, id.thread),
+					 perf_thread_map__pid(evsel->core.threads, id.thread));
+		} else {
+			fprintf(config->output, "%*s-%*d%s",
+				config->csv_output ? 0 : 16,
+				perf_thread_map__comm(evsel->core.threads, id.thread),
+				config->csv_output ? 0 : -8,
+				perf_thread_map__pid(evsel->core.threads, id.thread),
+				config->csv_sep);
+		}
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_UNSET:
@@ -184,20 +250,56 @@ static void print_metric_std(struct perf_stat_config *config,
 
 	os->newline = false;
 
+		if (unit == NULL || fmt == NULL) {
+			fprintf(out, "%-*s", METRIC_LEN, "");
+			return;
+		}
+
+		if (newline)
+			do_new_line_std(config, os);
+
+		n = fprintf(out, " # ");
+		if (color)
+			n += color_fprintf(out, color, fmt, val);
+		else
+			n += fprintf(out, fmt, val);
+		fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
+}
+
+static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
+			     void *ctx,
+			     const char *color __maybe_unused,
+			     const char *fmt, const char *unit, double val)
+{
+	struct outstate *os = ctx;
+	FILE *out = os->fh;
+	char buf[64], *vals, *ends;
+
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%-*s", METRIC_LEN, "");
+		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
 		return;
 	}
+	snprintf(buf, sizeof(buf), fmt, val);
+	ends = vals = skip_spaces(buf);
+	while (isdigit(*ends) || *ends == '.')
+		ends++;
+	*ends = 0;
+	fprintf(out, "%s%s%s%s", config->csv_sep, vals,
+					 config->csv_sep, skip_spaces(unit));
+}
 
-	if (newline)
-		do_new_line_std(config, os);
+static void print_metric_json(struct perf_stat_config *config __maybe_unused,
+			     void *ctx,
+			     const char *color __maybe_unused,
+			     const char *fmt, const char *unit, double val)
+{
+	struct outstate *os = ctx;
+	FILE *out = os->fh;
 
-	n = fprintf(out, " # ");
-	if (color)
-		n += color_fprintf(out, color, fmt, val);
-	else
-		n += fprintf(out, fmt, val);
-	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
+	fprintf(out, "\"metric-value\" : %f, ", val);
+	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (!config->metric_only)
+		fprintf(out, "}");
 }
 
 static void new_line_csv(struct perf_stat_config *config, void *ctx)
@@ -213,25 +315,14 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 		fputs(config->csv_sep, os->fh);
 }
 
-static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
-			     void *ctx,
-			     const char *color __maybe_unused,
-			     const char *fmt, const char *unit, double val)
+static void new_line_json(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
-	FILE *out = os->fh;
-	char buf[64], *vals, *ends;
 
-	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
-		return;
-	}
-	snprintf(buf, sizeof(buf), fmt, val);
-	ends = vals = skip_spaces(buf);
-	while (isdigit(*ends) || *ends == '.')
-		ends++;
-	*ends = 0;
-	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
+	fputc('\n', os->fh);
+	if (os->prefix)
+		fprintf(os->fh, "%s", os->prefix);
+	aggr_printout(config, os->evsel, os->id, os->nr);
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
@@ -292,7 +383,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	snprintf(buf, sizeof buf, fmt, val);
+	snprintf(buf, sizeof(buf), fmt, val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
@@ -300,6 +391,27 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	fprintf(out, "%s%s", vals, config->csv_sep);
 }
 
+static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
+				  void *ctx, const char *color __maybe_unused,
+				  const char *fmt,
+				  const char *unit, double val)
+{
+	struct outstate *os = ctx;
+	FILE *out = os->fh;
+	char buf[64], *vals, *ends;
+	char tbuf[1024];
+
+	if (!valid_only_metric(unit))
+		return;
+	unit = fixunit(tbuf, os->evsel, unit);
+	snprintf(buf, sizeof(buf), fmt, val);
+	ends = vals = skip_spaces(buf);
+	while (isdigit(*ends) || *ends == '.')
+		ends++;
+	*ends = 0;
+	fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
+}
+
 static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 			    void *ctx __maybe_unused)
 {
@@ -318,10 +430,13 @@ static void print_metric_header(struct perf_stat_config *config,
 	    os->evsel->priv != os->evsel->evlist->selected->priv)
 		return;
 
-	if (!valid_only_metric(unit))
+	if (!valid_only_metric(unit) && !config->json_output)
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	if (config->csv_output)
+
+	if (config->json_output)
+		fprintf(os->fh, "\"unit\" : \"%s\"", unit);
+	else if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
@@ -369,14 +484,28 @@ static void abs_printout(struct perf_stat_config *config,
 
 	aggr_printout(config, evsel, id, nr);
 
-	fprintf(output, fmt, avg, config->csv_sep);
+	if (config->json_output)
+		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+	else
+		fprintf(output, fmt, avg, config->csv_sep);
 
-	if (evsel->unit)
-		fprintf(output, "%-*s%s",
-			config->csv_output ? 0 : config->unit_width,
-			evsel->unit, config->csv_sep);
+	if (config->json_output) {
+		if (evsel->unit) {
+			fprintf(output, "\"unit\" : \"%s\", ",
+				evsel->unit);
+		}
+	} else {
+		if (evsel->unit)
+			fprintf(output, "%-*s%s",
+				config->csv_output ? 0 : config->unit_width,
+				evsel->unit, config->csv_sep);
+	}
 
-	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
+
+	if (config->json_output)
+		fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
+	else
+		fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
 
 	print_cgroup(config, evsel);
 }
@@ -425,6 +554,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		nl = new_line_metric;
 		if (config->csv_output)
 			pm = print_metric_only_csv;
+		else if (config->json_output)
+			pm = print_metric_only_json;
 		else
 			pm = print_metric_only;
 	} else
@@ -448,6 +579,24 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			os.nfields++;
 	}
 
+	if (config->json_output && !config->metric_only) {
+		static int aggr_fields[] = {
+			[AGGR_GLOBAL] = 0,
+			[AGGR_THREAD] = 1,
+			[AGGR_NONE] = 1,
+			[AGGR_SOCKET] = 2,
+			[AGGR_DIE] = 2,
+			[AGGR_CORE] = 2,
+		};
+
+		pm = print_metric_json;
+		nl = new_line_json;
+		os.nfields = 3;
+		os.nfields += aggr_fields[config->aggr_mode];
+		if (counter->cgrp)
+			os.nfields++;
+	}
+
 	if (!config->no_csv_summary && config->csv_output &&
 	    config->summary && !config->interval) {
 		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
@@ -460,10 +609,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		}
 		aggr_printout(config, counter, id, nr);
 
-		fprintf(config->output, "%*s%s",
-			config->csv_output ? 0 : 18,
-			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
-			config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output, "\"counter-value\" : \"%s\", ",
+					counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED);
+		} else {
+			fprintf(config->output, "%*s%s",
+				config->csv_output ? 0 : 18,
+				counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
+				config->csv_sep);
+		}
 
 		if (counter->supported) {
 			if (!evlist__has_hybrid(counter->evlist)) {
@@ -473,21 +627,32 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			}
 		}
 
-		fprintf(config->output, "%-*s%s",
-			config->csv_output ? 0 : config->unit_width,
-			counter->unit, config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output, "\"unit\" : \"%s\", ", counter->unit);
+		} else {
+			fprintf(config->output, "%-*s%s",
+				config->csv_output ? 0 : config->unit_width,
+				counter->unit, config->csv_sep);
+		}
 
-		fprintf(config->output, "%*s",
-			config->csv_output ? 0 : -25, evsel__name(counter));
+		if (config->json_output) {
+			fprintf(config->output, "\"event\" : \"%s\", ",
+				evsel__name(counter));
+		} else {
+			fprintf(config->output, "%*s",
+				 config->csv_output ? 0 : -25, evsel__name(counter));
+		}
 
 		print_cgroup(config, counter);
 
-		if (!config->csv_output)
+		if (!config->csv_output && !config->json_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 		if (config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
+		else if (config->json_output)
+			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
 
@@ -502,12 +667,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	if (config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
+	} else if (config->json_output && !config->metric_only) {
+		print_noise(config, counter, noise);
+		print_running(config, run, ena);
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(config, counter, id),
 				&out, &config->metric_events, st);
-	if (!config->csv_output && !config->metric_only) {
+	if (!config->csv_output && !config->metric_only && !config->json_output) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -866,7 +1034,8 @@ static void print_counter_aggr(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = cd.avg * counter->scale;
-	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter, uval, prefix, cd.avg_running,
+	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter,
+		 uval, prefix, cd.avg_running,
 		 cd.avg_enabled, cd.avg, &rt_stat);
 	if (!metric_only)
 		fprintf(output, "\n");
@@ -981,8 +1150,12 @@ static void print_metric_headers(struct perf_stat_config *config,
 	struct outstate os = {
 		.fh = config->output
 	};
+	bool first = true;
 
-	if (prefix)
+		if (config->json_output && !config->interval)
+			fprintf(config->output, "{");
+
+	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
 
 	if (!config->csv_output && !no_indent)
@@ -1002,6 +1175,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 		os.evsel = counter;
 		out.ctx = &os;
 		out.print_metric = print_metric_header;
+		if (!first && config->json_output)
+			fprintf(config->output, ", ");
+		first = false;
 		out.new_line = new_line_metric;
 		out.force_header = true;
 		perf_stat__print_shadow_stats(config, counter, 0,
@@ -1010,6 +1186,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 					      &config->metric_events,
 					      &rt_stat);
 	}
+	if (config->json_output)
+		fprintf(config->output, "}");
 	fputc('\n', config->output);
 }
 
@@ -1025,10 +1203,18 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	if (!config->iostat_run)
-		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
-
-	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
+	if (!config->iostat_run && !config->json_output)
+		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
+				 ts->tv_nsec, config->csv_sep);
+	if (!config->iostat_run && config->json_output && !config->metric_only)
+		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+	if (!config->iostat_run && config->json_output && config->metric_only)
+		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+
+	if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
+			 || config->interval_clear) {
 		switch (config->aggr_mode) {
 		case AGGR_NODE:
 			fprintf(output, "#           time node   cpus");
@@ -1072,8 +1258,14 @@ static void print_interval(struct perf_stat_config *config,
 		}
 	}
 
-	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
+	if ((num_print_interval == 0 || config->interval_clear)
+			 && metric_only && !config->json_output)
+		print_metric_headers(config, evlist, " ", true);
+	if ((num_print_interval == 0 || config->interval_clear)
+			 && metric_only && config->json_output) {
+		fprintf(output, "{");
 		print_metric_headers(config, evlist, " ", true);
+	}
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
@@ -1087,7 +1279,7 @@ static void print_header(struct perf_stat_config *config,
 
 	fflush(stdout);
 
-	if (!config->csv_output) {
+	if (!config->csv_output && !config->json_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
 		if (_target->bpf_str)
@@ -1276,6 +1468,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
+
+		if (config->json_output && !config->metric_only)
+			fprintf(config->output, "}");
 	}
 
 	switch (config->aggr_mode) {
@@ -1319,7 +1514,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
-	if (!interval && !config->csv_output)
+	if (!interval && !config->csv_output && !config->json_output)
 		print_footer(config);
 
 	fflush(config->output);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 34a7f5c1fff7..8a04b6433591 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -981,8 +981,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		total = max(total, runtime_stat_avg(st,
 						    STAT_STALLED_CYCLES_BACK,
 						    cpu, &rsd));
-
-		if (total && avg) {
+// TODO: Refactor code to avoid errors in JSON output b/194436171
+// !config->json_output is temporary workaround for JSON linter.
+		if (total && avg && !config->json_output) {
 			out->new_line(config, ctxp);
 			ratio = total / avg;
 			print_metric(config, ctxp, NULL, "%7.2f ",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 32c8527de347..2bde525e7630 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -117,6 +117,7 @@ struct perf_stat_config {
 	bool			 no_inherit;
 	bool			 identifier;
 	bool			 csv_output;
+	bool			 json_output;
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
-- 
2.32.0.605.g8dce9f2422-goog

