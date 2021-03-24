Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1239E347AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhCXObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:31:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:34034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236133AbhCXOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:30:46 -0400
IronPort-SDR: DoATUIPPtNXGyscnbOc1fR9a3E0pPYJaqPSCMsV3GQyvkrqWtZ9BGjIJTn7X1Dub2Knq4R2PXf
 nT6lBW/Amxhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188412866"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="188412866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:30:45 -0700
IronPort-SDR: xgLaExai/w0MQFAkSD6k+IoRp9xI2dwjyk09Dc0Qnd9UCisZFwsXC9MbOP0iu500RbaCuuUbIA
 mT3ODR4VDMWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="391319460"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2021 07:30:42 -0700
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v5 1/4] perf stat: Basic support for iostat in perf
Date:   Wed, 24 Mar 2021 17:30:34 +0300
Message-Id: <20210324143037.3810-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
References: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic flow for a new iostat mode in perf. Mode is intended to
provide four I/O performance metrics per each PCIe root port: Inbound Read,
Inbound Write, Outbound Read, Outbound Write.

The actual code to compute the metrics and attribute it to
root port is in follow-on patches.

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
index 2e2e4a8345ea..4cef64ce9261 100644
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
@@ -1247,6 +1249,9 @@ static struct option stat_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
+			    "measure I/O performance metrics provided by arch/platform",
+			    iostat_parse),
 	OPT_END()
 };
 
@@ -2320,6 +2325,17 @@ int cmd_stat(int argc, const char **argv)
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
 
@@ -2495,6 +2511,9 @@ int cmd_stat(int argc, const char **argv)
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
index 7f09cdaf5b60..aabe78dc6836 100644
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
@@ -952,8 +958,11 @@ static void print_metric_headers(struct perf_stat_config *config,
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
@@ -983,7 +992,8 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	if (!config->iostat_run)
+		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
@@ -1019,9 +1029,11 @@ static void print_interval(struct perf_stat_config *config,
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
@@ -1214,6 +1226,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	struct evsel *counter;
 	char buf[64], *prefix = NULL;
 
+	if (config->iostat_run)
+		evlist->selected = evlist__first(evlist);
+
 	if (interval)
 		print_interval(config, evlist, prefix = buf, ts);
 	else
@@ -1226,7 +1241,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			print_metric_headers(config, evlist, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
 	}
 
@@ -1243,11 +1258,16 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
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
index 41107b8deac5..96ed00eb609e 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -132,6 +132,7 @@ struct perf_stat_config {
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
 	bool			 quiet;
+	bool			 iostat_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.19.1

