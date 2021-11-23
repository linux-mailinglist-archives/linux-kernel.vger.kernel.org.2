Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630F045A4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhKWON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:13:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:40296 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237489AbhKWOND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:13:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234974703"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="234974703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422630"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:09:14 -0800
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
Subject: [PATCH v12 12/16] perf record: Introduce --threads command line option
Date:   Tue, 23 Nov 2021 17:08:08 +0300
Message-Id: <fff4c247e671a268c9f6646ac465821f44fbf21f.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide --threads option in perf record command line interface.
The option creates a data streaming thread for each cpu in the system.
Document --threads option in Documentation/perf-record.txt.

Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++
 tools/perf/builtin-record.c              | 48 +++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 3cf7bac67239..c84cdb3d7ede 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -711,6 +711,10 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads::
+Write collected trace data into several data files using parallel threads.
+The option creates a data streaming thread for each cpu in the system.
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 67181102c18f..e9c9ae62f90b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -125,6 +125,11 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
 	"UNDEFINED", "READY"
 };
 
+enum thread_spec {
+	THREAD_SPEC__UNDEFINED = 0,
+	THREAD_SPEC__CPU,
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -2766,6 +2771,16 @@ static void record__thread_mask_free(struct thread_mask *mask)
 	record__mmap_cpu_mask_free(&mask->affinity);
 }
 
+static int record__parse_threads(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = opt->value;
+
+	if (unset || !str || !strlen(str))
+		opts->threads_spec = THREAD_SPEC__CPU;
+
+	return 0;
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -3232,6 +3247,9 @@ static struct option __record_options[] = {
 		      parse_control_option),
 	OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
 		     "Fine-tune event synthesis: default=all", parse_record_synth_option),
+	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
+			    "write collected trace data into several data files using parallel threads",
+			    record__parse_threads),
 	OPT_END()
 };
 
@@ -3281,6 +3299,31 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
 	return ret;
 }
 
+static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret, nr_cpus = perf_cpu_map__nr(cpus);
+
+	ret = record__alloc_thread_masks(rec, nr_cpus, cpu__max_cpu());
+	if (ret)
+		return ret;
+
+	rec->nr_threads = nr_cpus;
+	pr_debug("nr_threads: %d\n", rec->nr_threads);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		set_bit(cpus->map[t], rec->thread_masks[t].maps.bits);
+		set_bit(cpus->map[t], rec->thread_masks[t].affinity.bits);
+		if (verbose) {
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].affinity, "affinity");
+		}
+	}
+
+	return 0;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3300,7 +3343,10 @@ static int record__init_thread_masks(struct record *rec)
 {
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
-	return record__init_thread_default_masks(rec, cpus);
+	if (!record__threads_enabled(rec))
+		return record__init_thread_default_masks(rec, cpus);
+
+	return record__init_thread_cpu_masks(rec, cpus);
 }
 
 int cmd_record(int argc, const char **argv)
-- 
2.19.0

