Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBCF363F01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhDSJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:42:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:60390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233488AbhDSJmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:25 -0400
IronPort-SDR: fWEf3K+VIsIAFO9zWEGz4QAF3/6SRK975n7BnzqCZMDccIhdyUhf5qCbY8qKoiHZoRlMDQl8Ey
 FxDgxTmNI3Ww==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174787668"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="174787668"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 02:41:54 -0700
IronPort-SDR: 1iYbnCQ3DLo4nrOqfZ5+pFNcIGymZnB8zWI2ixnd2btpFAcywjlQ8MV1LRxSF5n+BTflr+LMg4
 vv17OwAzwcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="452089664"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2021 02:41:51 -0700
From:   alexander.antonov@linux.intel.com
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [RESEND PATCH v5 1/4] perf stat: Basic support for iostat in perf
Date:   Mon, 19 Apr 2021 12:41:44 +0300
Message-Id: <20210419094147.15909-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
References: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Add basic flow for a new iostat mode in perf. Mode is intended to
provide four I/O performance metrics per each PCIe root port: Inbound Read,
Inbound Write, Outbound Read, Outbound Write.

The actual code to compute the metrics and attribute it to
root port is in follow-on patches.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/builtin-stat.c      | 21 +++++++++++++-
 tools/perf/util/Build          |  1 +
 tools/perf/util/iostat.c       | 53 ++++++++++++++++++++++++++++++++++
 tools/perf/util/iostat.h       | 47 ++++++++++++++++++++++++++++++
 tools/perf/util/stat-display.c | 40 ++++++++++++++++++-------
 tools/perf/util/stat-shadow.c  |  5 +++-
 tools/perf/util/stat.h         |  1 +
 7 files changed, 156 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/util/iostat.c
 create mode 100644 tools/perf/util/iostat.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2a2c15cac80a..ba5b31aab86b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -68,6 +68,7 @@
 #include "util/affinity.h"
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
+#include "util/iostat.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -212,7 +213,8 @@ static struct perf_stat_config stat_config = {
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
 	.ctl_fd			= -1,
-	.ctl_fd_ack		= -1
+	.ctl_fd_ack		= -1,
+	.iostat_run		= false,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -1268,6 +1270,9 @@ static struct option stat_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
+			    "measure I/O performance metrics provided by arch/platform",
+			    iostat_parse),
 	OPT_END()
 };
 
@@ -2341,6 +2346,17 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.iostat_run) {
+		status = iostat_prepare(evsel_list, &stat_config);
+		if (status)
+			goto out;
+		if (iostat_mode == IOSTAT_LIST) {
+			iostat_list(evsel_list, &stat_config);
+			goto out;
+		} else if (verbose)
+			iostat_list(evsel_list, &stat_config);
+	}
+
 	if (add_default_attributes())
 		goto out;
 
@@ -2516,6 +2532,9 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	evlist__free_stats(evsel_list);
 out:
+	if (stat_config.iostat_run)
+		iostat_release(evsel_list);
+
 	zfree(&stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e3e12f9d4733..7dd815712d60 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -102,6 +102,7 @@ perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
 perf-y += topdown.o
+perf-y += iostat.o
 perf-y += stream.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
new file mode 100644
index 000000000000..57dd49da28fe
--- /dev/null
+++ b/tools/perf/util/iostat.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/iostat.h"
+#include "util/debug.h"
+
+enum iostat_mode_t iostat_mode = IOSTAT_NONE;
+
+__weak int iostat_prepare(struct evlist *evlist __maybe_unused,
+			  struct perf_stat_config *config __maybe_unused)
+{
+	return -1;
+}
+
+__weak int iostat_parse(const struct option *opt __maybe_unused,
+			 const char *str __maybe_unused,
+			 int unset __maybe_unused)
+{
+	pr_err("iostat mode is not supported on current platform\n");
+	return -1;
+}
+
+__weak void iostat_list(struct evlist *evlist __maybe_unused,
+		       struct perf_stat_config *config __maybe_unused)
+{
+}
+
+__weak void iostat_release(struct evlist *evlist __maybe_unused)
+{
+}
+
+__weak void iostat_print_header_prefix(struct perf_stat_config *config __maybe_unused)
+{
+}
+
+__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
+				struct evsel *evsel __maybe_unused,
+				struct perf_stat_output_ctx *out __maybe_unused)
+{
+}
+
+__weak void iostat_prefix(struct evlist *evlist __maybe_unused,
+			  struct perf_stat_config *config __maybe_unused,
+			  char *prefix __maybe_unused,
+			  struct timespec *ts __maybe_unused)
+{
+}
+
+__weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
+				  struct perf_stat_config *config __maybe_unused,
+				  struct timespec *ts __maybe_unused,
+				  char *prefix __maybe_unused,
+				  iostat_print_counter_t print_cnt_cb __maybe_unused)
+{
+}
diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
new file mode 100644
index 000000000000..23c1c46a331a
--- /dev/null
+++ b/tools/perf/util/iostat.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * perf iostat
+ *
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
+ */
+
+#ifndef _IOSTAT_H
+#define _IOSTAT_H
+
+#include <subcmd/parse-options.h>
+#include "util/stat.h"
+#include "util/parse-events.h"
+#include "util/evlist.h"
+
+struct option;
+struct perf_stat_config;
+struct evlist;
+struct timespec;
+
+enum iostat_mode_t {
+	IOSTAT_NONE		= -1,
+	IOSTAT_RUN		= 0,
+	IOSTAT_LIST		= 1
+};
+
+extern enum iostat_mode_t iostat_mode;
+
+typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, char *);
+
+int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
+int iostat_parse(const struct option *opt, const char *str,
+		 int unset __maybe_unused);
+void iostat_list(struct evlist *evlist, struct perf_stat_config *config);
+void iostat_release(struct evlist *evlist);
+void iostat_prefix(struct evlist *evlist, struct perf_stat_config *config,
+		   char *prefix, struct timespec *ts);
+void iostat_print_header_prefix(struct perf_stat_config *config);
+void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			 struct perf_stat_output_ctx *out);
+void iostat_print_counters(struct evlist *evlist,
+			   struct perf_stat_config *config, struct timespec *ts,
+			   char *prefix, iostat_print_counter_t print_cnt_cb);
+
+#endif /* _IOSTAT_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d3137bc17065..98664caef6af 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -17,6 +17,7 @@
 #include "cgroup.h"
 #include <api/fs/fs.h>
 #include "util.h"
+#include "iostat.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -310,6 +311,11 @@ static void print_metric_header(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	char tbuf[1024];
 
+	/* In case of iostat, print metric header for first root port only */
+	if (config->iostat_run &&
+	    os->evsel->priv != os->evsel->evlist->selected->priv)
+		return;
+
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
@@ -958,8 +964,11 @@ static void print_metric_headers(struct perf_stat_config *config,
 	if (config->csv_output) {
 		if (config->interval)
 			fputs("time,", config->output);
-		fputs(aggr_header_csv[config->aggr_mode], config->output);
+		if (!config->iostat_run)
+			fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
+	if (config->iostat_run)
+		iostat_print_header_prefix(config);
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
@@ -989,7 +998,8 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	if (!config->iostat_run)
+		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
@@ -1025,9 +1035,11 @@ static void print_interval(struct perf_stat_config *config,
 			break;
 		case AGGR_GLOBAL:
 		default:
-			fprintf(output, "#           time");
-			if (!metric_only)
-				fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			if (!config->iostat_run) {
+				fprintf(output, "#           time");
+				if (!metric_only)
+					fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			}
 		case AGGR_UNSET:
 			break;
 		}
@@ -1220,6 +1232,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	struct evsel *counter;
 	char buf[64], *prefix = NULL;
 
+	if (config->iostat_run)
+		evlist->selected = evlist__first(evlist);
+
 	if (interval)
 		print_interval(config, evlist, prefix = buf, ts);
 	else
@@ -1232,7 +1247,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			print_metric_headers(config, evlist, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
 	}
 
@@ -1249,11 +1264,16 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		}
 		break;
 	case AGGR_GLOBAL:
-		evlist__for_each_entry(evlist, counter) {
-			print_counter_aggr(config, counter, prefix);
+		if (config->iostat_run)
+			iostat_print_counters(evlist, config, ts, prefix = buf,
+					      print_counter_aggr);
+		else {
+			evlist__for_each_entry(evlist, counter) {
+				print_counter_aggr(config, counter, prefix);
+			}
+			if (metric_only)
+				fputc('\n', config->output);
 		}
-		if (metric_only)
-			fputc('\n', config->output);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3f800e71126f..39967a45f55b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -11,6 +11,7 @@
 #include "cgroup.h"
 #include "units.h"
 #include <linux/zalloc.h>
+#include "iostat.h"
 
 /*
  * AGGR_GLOBAL: Use CPU 0
@@ -962,7 +963,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	struct metric_event *me;
 	int num = 1;
 
-	if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
+	if (config->iostat_run) {
+		iostat_print_metric(config, evsel, out);
+	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
 
 		if (total) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 48e6a06233fa..32c8527de347 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -133,6 +133,7 @@ struct perf_stat_config {
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
 	bool			 quiet;
+	bool			 iostat_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.21.3

