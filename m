Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6A3AFF82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhFVIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:45:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:57640 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhFVIpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:45:51 -0400
IronPort-SDR: w+E5wbtvNhm2vBSdJLDwUXBno4XPX9N94tUBYYrAVAkBhOUhwqOssE29pkXU7BpWtE0ZhWk5OV
 U13z6eHBiVQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292641600"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292641600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:43:08 -0700
IronPort-SDR: G2fGI174HonWbAeQ6EW9O9DXCGV5yn7mF2gANUlCTaagwqehaB6NZHlYyQeXkp2Xjp3nswFnVE
 4f0/SSVqv00g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="417332597"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2021 01:43:05 -0700
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v7 11/20] perf record: Document parallel data streaming mode
Date:   Tue, 22 Jun 2021 11:42:20 +0300
Message-Id: <c8aaf8b542b751a65434f9db034f5fa7c7cf7e73.1624350588.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document --threads option syntax and parallel data streaming modes
in Documentation/perf-record.txt. Implement compatibility checks for
other modes and related command line options: asynchronous(--aio)
trace streaming and affinity (--affinity) modes, pipe mode, AUX
area tracing --snapshot and --aux-sample options, --switch-output,
--switch-output-event, --switch-max-files and --timestamp-filename
options. Parallel data streaming is compatible with Zstd compression
(--compression-level) and external control commands (--control).
Cpu mask provided via -C option filters --threads specification masks.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 30 +++++++++++++++
 tools/perf/builtin-record.c              | 49 ++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..2046b28d9822 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -695,6 +695,36 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads=<spec>::
+Write collected trace data into several data files using parallel threads.
+<spec> value can be user defined list of masks. Masks separated by colon
+define cpus to be monitored by a thread and affinity mask of that thread
+is separated by slash:
+
+    <cpus mask 1>/<affinity mask 1>:<cpus mask 2>/<affinity mask 2>:...
+
+For example user specification like the following:
+
+    0,2-4/2-4:1,5-7/5-7
+
+specifies parallel threads layout that consists of two threads,
+the first thread monitors cpus 0 and 2-4 with the affinity mask 2-4,
+the second monitors cpus 1 and 5-7 with the affinity mask 5-7.
+
+<spec> value can also be a string meaning predefined parallel threads
+layout:
+
+    cpu    - create new data streaming thread for every monitored cpu
+    core   - create new thread to monitor cpus grouped by a core
+    socket - create new thread to monitor cpus grouped by a socket
+    numa   - create new threed to monitor cpus grouped by a numa domain
+
+Predefined layouts can be used on systems with large number of cpus in
+order not to spawn multiple per-cpu streaming threads but still avoid LOST
+events in data directory files. Option specified with no or empty value
+defaults to cpu layout. Masks defined or provided by the option value are
+filtered through the mask provided by -C option.
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ce3b374d22ea..a0ad4dd074ca 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -800,6 +800,12 @@ static int record__auxtrace_init(struct record *rec)
 {
 	int err;
 
+	if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
+	    && record__threads_enabled(rec)) {
+		pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
+		return -EINVAL;
+	}
+
 	if (!rec->itr) {
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
@@ -2154,6 +2160,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	if (record__threads_enabled(rec)) {
+		if (perf_data__is_pipe(&rec->data)) {
+			pr_err("Parallel trace streaming is not available in pipe mode.\n");
+			return -1;
+		}
+		if (rec->opts.full_auxtrace) {
+			pr_err("Parallel trace streaming is not available in AUX area tracing mode.\n");
+			return -1;
+		}
+	}
+
 	fd = perf_data__fd(data);
 	rec->session = session;
 
@@ -2922,12 +2939,22 @@ static int switch_output_setup(struct record *rec)
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-	if (rec->switch_output_event_set)
+	if (rec->switch_output_event_set) {
+		if (record__threads_enabled(rec)) {
+			pr_warning("WARNING: --switch-output-event option is not available in parallel streaming mode.\n");
+			return 0;
+		}
 		goto do_signal;
+	}
 
 	if (!s->set)
 		return 0;
 
+	if (record__threads_enabled(rec)) {
+		pr_warning("WARNING: --switch-output option is not available in parallel streaming mode.\n");
+		return 0;
+	}
+
 	if (!strcmp(s->str, "signal")) {
 do_signal:
 		s->signal = true;
@@ -3225,8 +3252,8 @@ static struct option __record_options[] = {
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
 #ifdef HAVE_ZSTD_SUPPORT
-	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
-			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
+	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default, "n",
+			    "Compress records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
 			    record__parse_comp_level),
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
@@ -3653,6 +3680,17 @@ int cmd_record(int argc, const char **argv)
 	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
+	if (record__threads_enabled(rec)) {
+		if (rec->opts.affinity != PERF_AFFINITY_SYS) {
+			pr_err("--affinity option is mutually exclusive to parallel streaming mode.\n");
+			goto out_opts;
+		}
+		if (record__aio_enabled(rec)) {
+			pr_err("Asynchronous streaming mode (--aio) is mutually exclusive to parallel streaming mode.\n");
+			goto out_opts;
+		}
+	}
+
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
 		rec->no_buildid = true;
@@ -3686,6 +3724,11 @@ int cmd_record(int argc, const char **argv)
 		}
 	}
 
+	if (rec->timestamp_filename && record__threads_enabled(rec)) {
+		rec->timestamp_filename = false;
+		pr_warning("WARNING: --timestamp-filename option is not available in parallel streaming mode.\n");
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
-- 
2.19.0

