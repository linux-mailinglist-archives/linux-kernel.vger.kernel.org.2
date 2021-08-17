Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A783EE85E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhHQIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:24:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:11537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235120AbhHQIYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:24:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="279763165"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="279763165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 01:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="471080175"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2021 01:23:31 -0700
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
Subject: [PATCH v11 01/24] perf record: Introduce thread affinity and mmap masks
Date:   Tue, 17 Aug 2021 11:23:04 +0300
Message-Id: <328c6ae8904139d1fba882a2daa75405a086e5cf.1629186429.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce affinity and mmap thread masks. Thread affinity mask
defines cpus that a thread is allowed to run on. Thread maps
mask defines mmap data buffers the thread serves to stream
profiling data from.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 135 ++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 548c1dbde6c5..021a607510b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -87,6 +87,11 @@ struct switch_output {
 	int		 cur_file;
 };
 
+struct thread_mask {
+	struct mmap_cpu_mask	maps;
+	struct mmap_cpu_mask	affinity;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -111,6 +116,8 @@ struct record {
 	unsigned long long	samples;
 	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
+	int			nr_threads;
+	struct thread_mask	*thread_masks;
 };
 
 static volatile int done;
@@ -2187,6 +2194,54 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
+{
+	mask->nbits = nr_bits;
+	mask->bits = bitmap_alloc(mask->nbits);
+	if (!mask->bits) {
+		pr_err("Failed to allocate mmap_cpu mask\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
+{
+	bitmap_free(mask->bits);
+	mask->nbits = 0;
+}
+
+static void record__thread_mask_clear(struct thread_mask *mask)
+{
+	bitmap_zero(mask->maps.bits, mask->maps.nbits);
+	bitmap_zero(mask->affinity.bits, mask->affinity.nbits);
+}
+
+static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
+{
+	int ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
+
+	if (ret) {
+		mask->affinity.bits = NULL;
+		return ret;
+	}
+
+	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
+	if (ret) {
+		record__mmap_cpu_mask_free(&mask->maps);
+		mask->maps.bits = NULL;
+	}
+
+	return ret;
+}
+
+static void record__thread_mask_free(struct thread_mask *mask)
+{
+	record__mmap_cpu_mask_free(&mask->maps);
+	record__mmap_cpu_mask_free(&mask->affinity);
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -2635,6 +2690,79 @@ static struct option __record_options[] = {
 
 struct option *record_options = __record_options;
 
+static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
+{
+	int c;
+
+	for (c = 0; c < cpus->nr; c++)
+		set_bit(cpus->map[c], mask->bits);
+}
+
+static void record__free_thread_masks(struct record *rec, int nr_threads)
+{
+	int t;
+
+	if (rec->thread_masks)
+		for (t = 0; t < nr_threads; t++)
+			record__thread_mask_free(&rec->thread_masks[t]);
+
+	zfree(&rec->thread_masks);
+}
+
+static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
+{
+	int t, ret;
+
+	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
+	if (!rec->thread_masks) {
+		pr_err("Failed to allocate thread masks\n");
+		return -ENOMEM;
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
+		if (ret)
+			goto out_free;
+		record__thread_mask_clear(&rec->thread_masks[t]);
+	}
+
+	return 0;
+
+out_free:
+	record__free_thread_masks(rec, nr_threads);
+
+	return ret;
+}
+
+static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+
+	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());
+	if (ret)
+		return ret;
+
+	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
+
+	rec->nr_threads = 1;
+
+	return 0;
+}
+
+static int record__init_thread_masks(struct record *rec)
+{
+	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
+
+	return record__init_thread_default_masks(rec, cpus);
+}
+
+static void record__fini_thread_masks(struct record *rec)
+{
+	record__free_thread_masks(rec, rec->nr_threads);
+
+	rec->nr_threads = 0;
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -2883,6 +3011,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	err = record__init_thread_masks(rec);
+	if (err) {
+		pr_err("record__init_thread_masks failed, error %d\n", err);
+		goto out;
+	}
+
 	if (rec->opts.nr_cblocks > nr_cblocks_max)
 		rec->opts.nr_cblocks = nr_cblocks_max;
 	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
@@ -2901,6 +3035,7 @@ int cmd_record(int argc, const char **argv)
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
+	record__fini_thread_masks(rec);
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
 	return err;
 }
-- 
2.19.0

