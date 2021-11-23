Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A645A4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhKWONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:13:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:23872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237778AbhKWOMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:12:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215736345"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215736345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422684"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:09:26 -0800
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
Subject: [PATCH v12 14/16] perf record: Implement compatibility checks
Date:   Tue, 23 Nov 2021 17:08:10 +0300
Message-Id: <616a1ead48dcc44f71711511fbb1e375b29f4c2f.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement compatibility checks for other modes and related command line
options: asynchronous (--aio) trace streaming and affinity (--affinity)
modes, pipe mode, AUX area tracing --snapshot and --aux-sample options,
--switch-output, --switch-output-event, --switch-max-files and
--timestamp-filename options. Parallel data streaming is compatible with
Zstd compression (--compression-level) and external control commands
(--control).  Cpu mask provided via -C option filters --threads
specification masks.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9299502823f6..c0650c092d2e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -802,6 +802,12 @@ static int record__auxtrace_init(struct record *rec)
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
@@ -2197,6 +2203,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
 
@@ -2965,12 +2982,22 @@ static int switch_output_setup(struct record *rec)
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
@@ -3289,8 +3316,8 @@ static struct option __record_options[] = {
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
@@ -3735,6 +3762,17 @@ int cmd_record(int argc, const char **argv)
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
@@ -3768,6 +3806,11 @@ int cmd_record(int argc, const char **argv)
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

