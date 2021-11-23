Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF645A4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhKWON3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:13:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:40287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237201AbhKWONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:13:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234974717"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="234974717"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422657"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:09:21 -0800
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
Subject: [PATCH v12 13/16] perf record: Extend --threads command line option
Date:   Tue, 23 Nov 2021 17:08:09 +0300
Message-Id: <f103a65518a1a41700f739df75f57cb0b46fbf19.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend --threads option in perf record command line interface.
The option can have a value in the form of masks that specify
cpus to be monitored with data streaming threads and its layout
in system topology. The masks can be filtered using cpu mask
provided via -C option.

The specification value can be user defined list of masks. Masks
separated by colon define cpus to be monitored by one thread and
affinity mask of that thread is separated by slash. For example:
<cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
specifies parallel threads layout that consists of two threads
with corresponding assigned cpus to be monitored.

The specification value can be a string e.g. "cpu", "core" or
"package" meaning creation of data streaming thread for every
cpu or core or package to monitor distinct cpus or cpus grouped
by core or package.

The option provided with no or empty value defaults to per-cpu
parallel threads layout creating data streaming thread for every
cpu being monitored.

Document --threads option syntax and parallel data streaming modes
in Documentation/perf-record.txt.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  30 ++-
 tools/perf/builtin-record.c              | 315 ++++++++++++++++++++++-
 tools/perf/util/record.h                 |   1 +
 3 files changed, 341 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c84cdb3d7ede..2a43fb0cbaa8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -711,9 +711,35 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
---threads::
+--threads=<spec>::
 Write collected trace data into several data files using parallel threads.
-The option creates a data streaming thread for each cpu in the system.
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
+    package - create new thread to monitor cpus grouped by a package
+    numa   - create new threed to monitor cpus grouped by a numa domain
+
+Predefined layouts can be used on systems with large number of cpus in
+order not to spawn multiple per-cpu streaming threads but still avoid LOST
+events in data directory files. Option specified with no or empty value
+defaults to cpu layout. Masks defined or provided by the option value are
+filtered through the mask provided by -C option.
 
 include::intel-hybrid.txt[]
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e9c9ae62f90b..9299502823f6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,6 +51,7 @@
 #include "util/evlist-hybrid.h"
 #include "asm/bug.h"
 #include "perf.h"
+#include "cputopo.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -128,6 +129,15 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
 enum thread_spec {
 	THREAD_SPEC__UNDEFINED = 0,
 	THREAD_SPEC__CPU,
+	THREAD_SPEC__CORE,
+	THREAD_SPEC__PACKAGE,
+	THREAD_SPEC__NUMA,
+	THREAD_SPEC__USER,
+	THREAD_SPEC__MAX,
+};
+
+static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
+	"undefined", "cpu", "core", "package", "numa", "user"
 };
 
 struct record {
@@ -2771,12 +2781,66 @@ static void record__thread_mask_free(struct thread_mask *mask)
 	record__mmap_cpu_mask_free(&mask->affinity);
 }
 
+static int record__thread_mask_or(struct thread_mask *dest, struct thread_mask *src1,
+				   struct thread_mask *src2)
+{
+	if (src1->maps.nbits != src2->maps.nbits ||
+	    dest->maps.nbits != src1->maps.nbits ||
+	    src1->affinity.nbits != src2->affinity.nbits ||
+	    dest->affinity.nbits != src1->affinity.nbits)
+		return -EINVAL;
+
+	bitmap_or(dest->maps.bits, src1->maps.bits,
+		  src2->maps.bits, src1->maps.nbits);
+	bitmap_or(dest->affinity.bits, src1->affinity.bits,
+		  src2->affinity.bits, src1->affinity.nbits);
+
+	return 0;
+}
+
+static int record__thread_mask_intersects(struct thread_mask *mask_1, struct thread_mask *mask_2)
+{
+	int res1, res2;
+
+	if (mask_1->maps.nbits != mask_2->maps.nbits ||
+	    mask_1->affinity.nbits != mask_2->affinity.nbits)
+		return -EINVAL;
+
+	res1 = bitmap_intersects(mask_1->maps.bits, mask_2->maps.bits,
+				 mask_1->maps.nbits);
+	res2 = bitmap_intersects(mask_1->affinity.bits, mask_2->affinity.bits,
+				 mask_1->affinity.nbits);
+	if (res1 || res2)
+		return 1;
+
+	return 0;
+}
+
 static int record__parse_threads(const struct option *opt, const char *str, int unset)
 {
+	int s;
 	struct record_opts *opts = opt->value;
 
-	if (unset || !str || !strlen(str))
+	if (unset || !str || !strlen(str)) {
 		opts->threads_spec = THREAD_SPEC__CPU;
+	} else {
+		for (s = 1; s < THREAD_SPEC__MAX; s++) {
+			if (s == THREAD_SPEC__USER) {
+				opts->threads_user_spec = strdup(str);
+				opts->threads_spec = THREAD_SPEC__USER;
+				break;
+			}
+			if (!strncasecmp(str, thread_spec_tags[s], strlen(thread_spec_tags[s]))) {
+				opts->threads_spec = s;
+				break;
+			}
+		}
+	}
+
+	if (opts->threads_spec == THREAD_SPEC__USER)
+		pr_debug("threads_spec: %s\n", opts->threads_user_spec);
+	else
+		pr_debug("threads_spec: %s\n", thread_spec_tags[opts->threads_spec]);
 
 	return 0;
 }
@@ -3263,6 +3327,17 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
 		set_bit(cpus->map[c], mask->bits);
 }
 
+static void record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
+{
+	struct perf_cpu_map *cpus;
+
+	cpus = perf_cpu_map__new(mask_spec);
+	if (cpus) {
+		record__mmap_cpu_mask_init(mask, cpus);
+		perf_cpu_map__put(cpus);
+	}
+}
+
 static void record__free_thread_masks(struct record *rec, int nr_threads)
 {
 	int t;
@@ -3324,6 +3399,214 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	return 0;
 }
 
+static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
+					  const char **maps_spec, const char **affinity_spec,
+					  u32 nr_spec)
+{
+	u32 s;
+	int ret = 0, t = 0;
+	struct mmap_cpu_mask cpus_mask;
+	struct thread_mask thread_mask, full_mask, *prev_masks;
+
+	ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
+	if (ret)
+		goto out;
+	record__mmap_cpu_mask_init(&cpus_mask, cpus);
+	ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
+	if (ret)
+		goto out_free_cpu_mask;
+	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
+	if (ret)
+		goto out_free_thread_mask;
+	record__thread_mask_clear(&full_mask);
+
+	for (s = 0; s < nr_spec; s++) {
+		record__thread_mask_clear(&thread_mask);
+
+		record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
+		record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
+
+		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
+				cpus_mask.bits, thread_mask.maps.nbits) ||
+		    !bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
+				cpus_mask.bits, thread_mask.affinity.nbits))
+			continue;
+
+		ret = record__thread_mask_intersects(&thread_mask, &full_mask);
+		if (ret)
+			goto out_free_full_mask;
+		record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
+
+		prev_masks = rec->thread_masks;
+		rec->thread_masks = realloc(rec->thread_masks,
+					    (t + 1) * sizeof(struct thread_mask));
+		if (!rec->thread_masks) {
+			pr_err("Failed to allocate thread masks\n");
+			rec->thread_masks = prev_masks;
+			ret = -ENOMEM;
+			goto out_free_full_mask;
+		}
+		rec->thread_masks[t] = thread_mask;
+		if (verbose) {
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].affinity, "affinity");
+		}
+		t++;
+		ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
+		if (ret)
+			goto out_free_full_mask;
+	}
+
+	rec->nr_threads = t;
+	pr_debug("nr_threads: %d\n", rec->nr_threads);
+
+	if (rec->nr_threads <= 0)
+		ret = -EINVAL;
+
+out_free_full_mask:
+	record__thread_mask_free(&full_mask);
+out_free_thread_mask:
+	record__thread_mask_free(&thread_mask);
+out_free_cpu_mask:
+	record__mmap_cpu_mask_free(&cpus_mask);
+out:
+	return ret;
+}
+
+static int record__init_thread_core_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo)
+		return -EINVAL;
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->core_cpus_list,
+					     topo->core_cpus_list, topo->core_cpus_lists);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_package_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo)
+		return -EINVAL;
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->package_cpus_list,
+					     topo->package_cpus_list, topo->package_cpus_lists);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_numa_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	u32 s;
+	int ret;
+	const char **spec;
+	struct numa_topology *topo;
+
+	topo = numa_topology__new();
+	if (!topo)
+		return -EINVAL;
+	spec = zalloc(topo->nr * sizeof(char *));
+	if (!spec) {
+		ret = -ENOMEM;
+		goto out_delete_topo;
+	}
+	for (s = 0; s < topo->nr; s++)
+		spec[s] = topo->nodes[s].cpus;
+
+	ret = record__init_thread_masks_spec(rec, cpus, spec, spec, topo->nr);
+
+	zfree(&spec);
+
+out_delete_topo:
+	numa_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_user_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret;
+	u32 s, nr_spec = 0;
+	char **maps_spec = NULL, **affinity_spec = NULL, **prev_spec;
+	char *spec, *spec_ptr, *user_spec, *mask, *mask_ptr;
+
+	for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ; t++, user_spec = NULL) {
+		spec = strtok_r(user_spec, ":", &spec_ptr);
+		if (spec == NULL)
+			break;
+		pr_debug2("threads_spec[%d]: %s\n", t, spec);
+		mask = strtok_r(spec, "/", &mask_ptr);
+		if (mask == NULL)
+			break;
+		pr_debug2("  maps mask: %s\n", mask);
+		prev_spec = maps_spec;
+		maps_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char *));
+		if (!maps_spec) {
+			pr_err("Failed to reallocate maps_spec\n");
+			maps_spec = prev_spec;
+			ret = -ENOMEM;
+			goto out_free_all_specs;
+		}
+		maps_spec[nr_spec] = strdup(mask);
+		if (!maps_spec[nr_spec]) {
+			pr_err("Failed to allocate maps_spec[%d]\n", nr_spec);
+			ret = -ENOMEM;
+			goto out_free_all_specs;
+		}
+		mask = strtok_r(NULL, "/", &mask_ptr);
+		if (mask == NULL) {
+			free(maps_spec[nr_spec]);
+			ret = -EINVAL;
+			goto out_free_all_specs;
+		}
+		pr_debug2("  affinity mask: %s\n", mask);
+		prev_spec = affinity_spec;
+		affinity_spec = realloc(affinity_spec, (nr_spec + 1) * sizeof(char *));
+		if (!affinity_spec) {
+			pr_err("Failed to reallocate affinity_spec\n");
+			affinity_spec = prev_spec;
+			free(maps_spec[nr_spec]);
+			ret = -ENOMEM;
+			goto out_free_all_specs;
+		}
+		affinity_spec[nr_spec] = strdup(mask);
+		if (!affinity_spec[nr_spec]) {
+			pr_err("Failed to allocate affinity_spec[%d]\n", nr_spec);
+			free(maps_spec[nr_spec]);
+			ret = -ENOMEM;
+			goto out_free_all_specs;
+		}
+		nr_spec++;
+	}
+
+	ret = record__init_thread_masks_spec(rec, cpus, (const char **)maps_spec,
+					     (const char **)affinity_spec, nr_spec);
+
+out_free_all_specs:
+	for (s = 0; s < nr_spec; s++) {
+		if (maps_spec)
+			free(maps_spec[s]);
+		if (affinity_spec)
+			free(affinity_spec[s]);
+	}
+	free(affinity_spec);
+	free(maps_spec);
+
+	return ret;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3341,12 +3624,33 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
 
 static int record__init_thread_masks(struct record *rec)
 {
+	int ret = 0;
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
 	if (!record__threads_enabled(rec))
 		return record__init_thread_default_masks(rec, cpus);
 
-	return record__init_thread_cpu_masks(rec, cpus);
+	switch (rec->opts.threads_spec) {
+	case THREAD_SPEC__CPU:
+		ret = record__init_thread_cpu_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__CORE:
+		ret = record__init_thread_core_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__PACKAGE:
+		ret = record__init_thread_package_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__NUMA:
+		ret = record__init_thread_numa_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__USER:
+		ret = record__init_thread_user_masks(rec, cpus);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
 int cmd_record(int argc, const char **argv)
@@ -3599,7 +3903,12 @@ int cmd_record(int argc, const char **argv)
 
 	err = record__init_thread_masks(rec);
 	if (err) {
-		pr_err("record__init_thread_masks failed, error %d\n", err);
+		if (err > 0)
+			pr_err("Parallel data streaming masks (--threads) intersect\n");
+		else if (err == -EINVAL)
+			pr_err("Invalid parallel data streaming masks (--threads)\n");
+		else
+			pr_err("record__init_thread_masks failed, error %d\n", err);
 		goto out;
 	}
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index ad08c092f3dd..be9a957501f4 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	bool	      ctl_fd_close;
 	int	      synth;
 	int	      threads_spec;
+	const char    *threads_user_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.19.0

