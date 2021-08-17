Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A183EE86D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhHQIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:25:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:11571 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239243AbhHQIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:24:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215746813"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="215746813"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 01:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="471080322"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2021 01:24:06 -0700
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
Subject: [PATCH v11 12/24] perf record: Introduce --threads command line option
Date:   Tue, 17 Aug 2021 11:23:15 +0300
Message-Id: <dbfb747b0f0894b8db3a63b4a98ca744dd67549b.1629186429.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
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
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index f1079ee7f2ec..0408e677c117 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -695,6 +695,10 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads::
+Write collected trace data into several data files using parallel threads.
+The option creates a data streaming thread for each cpu in the system.
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 06160627f975..246a5746a195 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -122,6 +122,11 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
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
@@ -2781,6 +2786,16 @@ static void record__thread_mask_free(struct thread_mask *mask)
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
@@ -3224,6 +3239,9 @@ static struct option __record_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
+			    "write collected trace data into several data files using parallel threads",
+			    record__parse_threads),
 	OPT_END()
 };
 
@@ -3273,6 +3291,27 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
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
+	pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		set_bit(cpus->map[t], rec->thread_masks[t].maps.bits);
+		pr_debug("thread_masks[%d]: maps mask [%d]\n", t, cpus->map[t]);
+		set_bit(cpus->map[t], rec->thread_masks[t].affinity.bits);
+		pr_debug("thread_masks[%d]: affinity mask [%d]\n", t, cpus->map[t]);
+	}
+
+	return 0;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3292,7 +3331,10 @@ static int record__init_thread_masks(struct record *rec)
 {
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
-	return record__init_thread_default_masks(rec, cpus);
+	if (!record__threads_enabled(rec))
+		return record__init_thread_default_masks(rec, cpus);
+
+	return record__init_thread_cpu_masks(rec, cpus);
 }
 
 static void record__fini_thread_masks(struct record *rec)
-- 
2.19.0

