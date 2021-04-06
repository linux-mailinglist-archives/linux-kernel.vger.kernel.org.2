Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BD354EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbhDFIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:50:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:22599 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232593AbhDFIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:50:12 -0400
IronPort-SDR: wGGOv+tERv6NkpA1fYM0qIfzUdymCJ5IYzZWW11cNm0z306PcfAG4rePeTnZr7FbIJCjcN56KY
 CPvVtsSywn+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="192555406"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="192555406"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:50:00 -0700
IronPort-SDR: v+Ecdand/TE53SH7pK4xAiCffeJLlylv4+OG0vHgSHcz67CczJPdZDISn6+YYE6dIdGx1ALWWW
 0IchlFbksN4Q==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421123382"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:49:56 -0700
Subject: [PATCH v4 09/12] perf record: document parallel data streaming mode
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
Organization: Intel Corporation
Message-ID: <e4a28c4d-ffab-8f3a-7c80-6ebff0e4cefd@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:49:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
 tools/perf/Documentation/perf-record.txt | 18 ++++++++++
 tools/perf/builtin-record.c              | 43 ++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index f3161c9673e9..d6f9bc97f060 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -695,6 +695,24 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads=<spec>::
+Write collected trace data into several data files using parallel threads.
+<spec> value can be user defined list of masks. Masks separated by colon
+define cpus to be monitored by a thread and affinity mask of that thread
+is separated by slash. For example user specification like the following:
+<cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2> specifies
+parallel threads layout that consists of two threads with corresponding
+assigned cpus to be monitored. <spec> value can also be a string meaning
+predefined parallel threads layout:
+    cpu    - create new data streaming thread for every monitored cpu
+    core   - create new thread to monitor cpus grouped by a core
+    socket - create new thread to monitor cpus grouped by a socket
+    numa   - create new threed to monitor cpus grouped by a numa domain
+Predefined layouts can be used on systems with large number of cpus in
+order not to spawn multiple per-cpu streaming threads but still avoid LOST
+events in data directory files. Option specified with no or empty value
+defaults to cpu layout. Masks defined or provided by the option value are
+filtered through the mask provided by -C option.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 41a22f48037d..23aab359f110 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -798,6 +798,12 @@ static int record__auxtrace_init(struct record *rec)
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
@@ -2109,6 +2115,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	if (record__threads_enabled(rec) && perf_data__is_pipe(&rec->data)) {
+		pr_err("Parallel trace streaming is not available in pipe mode.\n");
+		return -1;
+	}
+
 	fd = perf_data__fd(data);
 	rec->session = session;
 
@@ -2854,12 +2865,22 @@ static int switch_output_setup(struct record *rec)
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
@@ -3144,8 +3165,8 @@ static struct option __record_options[] = {
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
@@ -3543,6 +3564,17 @@ int cmd_record(int argc, const char **argv)
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
@@ -3576,6 +3608,11 @@ int cmd_record(int argc, const char **argv)
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


