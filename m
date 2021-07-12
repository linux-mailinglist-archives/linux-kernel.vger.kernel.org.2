Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF03C4D27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbhGLHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:12:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:45774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239762AbhGLGuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209748973"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209748973"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916250"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:09 -0700
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
Subject: [PATCH v10 12/24] perf record: Introduce --threads command line option
Date:   Mon, 12 Jul 2021 09:46:12 +0300
Message-Id: <61d475a0976886a4ce947597135272d411f65991.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide --threads option in perf record command line interface.
The option creates a data streaming thread for each cpu in the system.
Document --threads option in Documentation/perf-record.txt.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..ca2771b80fd5 100644
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
index 791926ddc0b0..65e2d1837bec 100644
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
@@ -2811,6 +2816,16 @@ static void record__thread_mask_free(struct thread_mask *mask)
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
@@ -3254,6 +3269,9 @@ static struct option __record_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
+			    "write collected trace data into several data files using parallel threads",
+			    record__parse_threads),
 	OPT_END()
 };
 
@@ -3303,6 +3321,27 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
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
@@ -3322,7 +3361,10 @@ static int record__init_thread_masks(struct record *rec)
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

