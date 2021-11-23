Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FA45A48E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhKWOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:12:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:23917 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237489AbhKWOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:11:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215736182"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215736182"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422416"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:08:38 -0800
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
Subject: [PATCH v12 05/16] perf record: Introduce thread local variable
Date:   Tue, 23 Nov 2021 17:08:01 +0300
Message-Id: <c9f2747f11fcce59b879b547f8128f2ae5a7f8c0.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce thread local variable and use it for threaded trace streaming.
Use thread affinity mask instead or record affinity mask in affinity
modes. Move waking and sample statistic to struct record_thread and
introduce record__waking function to calculate the total number of
wakes.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 140 ++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 88b23ad1407b..fcd915e2e5ca 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -106,8 +106,12 @@ struct record_thread {
 	struct mmap		**maps;
 	struct mmap		**overwrite_maps;
 	struct record		*rec;
+	unsigned long long	samples;
+	unsigned long		waking;
 };
 
+static __thread struct record_thread *thread;
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -130,7 +134,6 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
-	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	int			nr_threads;
 	struct thread_mask	*thread_masks;
@@ -572,7 +575,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 		bf   = map->data;
 	}
 
-	rec->samples++;
+	thread->samples++;
 	return record__write(rec, map, bf, size);
 }
 
@@ -1319,15 +1322,17 @@ static struct perf_event_header finished_round_event = {
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
-	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
-			  rec->affinity_mask.nbits)) {
-		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
-		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
-			  map->affinity_mask.bits, rec->affinity_mask.nbits);
-		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
-				  (cpu_set_t *)rec->affinity_mask.bits);
-		if (verbose == 2)
-			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
+	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
+			  thread->mask->affinity.nbits)) {
+		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
+		bitmap_or(thread->mask->affinity.bits, thread->mask->affinity.bits,
+			  map->affinity_mask.bits, thread->mask->affinity.nbits);
+		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
+					(cpu_set_t *)thread->mask->affinity.bits);
+		if (verbose == 2) {
+			pr_debug("threads[%d]: running on cpu=%d\n", thread->tid, sched_getcpu());
+			mmap_cpu_mask__scnprintf(&thread->mask->affinity, "thread");
+		}
 	}
 }
 
@@ -1368,14 +1373,17 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	u64 bytes_written = rec->bytes_written;
 	int i;
 	int rc = 0;
-	struct mmap *maps;
+	int nr_mmaps;
+	struct mmap **maps;
 	int trace_fd = rec->data.file.fd;
 	off_t off = 0;
 
 	if (!evlist)
 		return 0;
 
-	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
+	nr_mmaps = thread->nr_mmaps;
+	maps = overwrite ? thread->overwrite_maps : thread->maps;
+
 	if (!maps)
 		return 0;
 
@@ -1385,9 +1393,9 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
-	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+	for (i = 0; i < nr_mmaps; i++) {
 		u64 flush = 0;
-		struct mmap *map = &maps[i];
+		struct mmap *map = maps[i];
 
 		if (map->core.base) {
 			record__adjust_affinity(rec, map);
@@ -1450,6 +1458,15 @@ static int record__mmap_read_all(struct record *rec, bool synch)
 	return record__mmap_read_evlist(rec, rec->evlist, true, synch);
 }
 
+static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
+					   void *arg __maybe_unused)
+{
+	struct perf_mmap *map = fda->priv[fd].ptr;
+
+	if (map)
+		perf_mmap__put(map);
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -1873,11 +1890,44 @@ static void record__uniquify_name(struct record *rec)
 	}
 }
 
+static int record__start_threads(struct record *rec)
+{
+	struct record_thread *thread_data = rec->thread_data;
+
+	thread = &thread_data[0];
+
+	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
+
+	return 0;
+}
+
+static int record__stop_threads(struct record *rec)
+{
+	int t;
+	struct record_thread *thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		rec->samples += thread_data[t].samples;
+
+	return 0;
+}
+
+static unsigned long record__waking(struct record *rec)
+{
+	int t;
+	unsigned long waking = 0;
+	struct record_thread *thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		waking += thread_data[t].waking;
+
+	return waking;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
 	int status = 0;
-	unsigned long waking = 0;
 	const bool forks = argc > 0;
 	struct perf_tool *tool = &rec->tool;
 	struct record_opts *opts = &rec->opts;
@@ -1981,7 +2031,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (record__open(rec) != 0) {
 		err = -1;
-		goto out_child;
+		goto out_free_threads;
 	}
 	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
@@ -1989,7 +2039,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = record__kcore_copy(&session->machines.host, data);
 		if (err) {
 			pr_err("ERROR: Failed to copy kcore\n");
-			goto out_child;
+			goto out_free_threads;
 		}
 	}
 
@@ -2000,7 +2050,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
 		pr_err("ERROR: Apply config to BPF failed: %s\n",
 			 errbuf);
-		goto out_child;
+		goto out_free_threads;
 	}
 
 	/*
@@ -2018,11 +2068,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe) {
 		err = perf_header__write_pipe(fd);
 		if (err < 0)
-			goto out_child;
+			goto out_free_threads;
 	} else {
 		err = perf_session__write_header(session, rec->evlist, fd, false);
 		if (err < 0)
-			goto out_child;
+			goto out_free_threads;
 	}
 
 	err = -1;
@@ -2030,16 +2080,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	    && !perf_header__has_feat(&session->header, HEADER_BUILD_ID)) {
 		pr_err("Couldn't generate buildids. "
 		       "Use --no-buildid to profile anyway.\n");
-		goto out_child;
+		goto out_free_threads;
 	}
 
 	err = record__setup_sb_evlist(rec);
 	if (err)
-		goto out_child;
+		goto out_free_threads;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
-		goto out_child;
+		goto out_free_threads;
 
 	if (rec->realtime_prio) {
 		struct sched_param param;
@@ -2048,10 +2098,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (sched_setscheduler(0, SCHED_FIFO, &param)) {
 			pr_err("Could not set realtime priority.\n");
 			err = -1;
-			goto out_child;
+			goto out_free_threads;
 		}
 	}
 
+	if (record__start_threads(rec))
+		goto out_free_threads;
+
 	/*
 	 * When perf is starting the traced process, all the events
 	 * (apart from group members) have enable_on_exec=1 set,
@@ -2122,7 +2175,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
 	for (;;) {
-		unsigned long long hits = rec->samples;
+		unsigned long long hits = thread->samples;
 
 		/*
 		 * rec->evlist->bkw_mmap_state is possible to be
@@ -2176,8 +2229,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 			if (!quiet)
 				fprintf(stderr, "[ perf record: dump data: Woken up %ld times ]\n",
-					waking);
-			waking = 0;
+					record__waking(rec));
+			thread->waking = 0;
 			fd = record__switch_output(rec, false);
 			if (fd < 0) {
 				pr_err("Failed to switch to new file\n");
@@ -2191,20 +2244,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				alarm(rec->switch_output.time);
 		}
 
-		if (hits == rec->samples) {
+		if (hits == thread->samples) {
 			if (done || draining)
 				break;
-			err = evlist__poll(rec->evlist, -1);
+			err = fdarray__poll(&thread->pollfd, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
 			if (err > 0 || (err < 0 && errno == EINTR))
 				err = 0;
-			waking++;
+			thread->waking++;
 
-			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
+					    record__thread_munmap_filtered, NULL) == 0)
 				draining = true;
+
+			evlist__ctlfd_update(rec->evlist,
+				&thread->pollfd.entries[thread->ctlfd_pos]);
 		}
 
 		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
@@ -2258,15 +2315,18 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (!quiet)
-		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
+		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n",
+			record__waking(rec));
 
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
 
 out_child:
-	evlist__finalize_ctlfd(rec->evlist);
+	record__stop_threads(rec);
 	record__mmap_read_all(rec, true);
+out_free_threads:
 	record__free_thread_data(rec);
+	evlist__finalize_ctlfd(rec->evlist);
 	record__aio_mmap_read_sync(rec);
 
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
@@ -3158,17 +3218,6 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
-	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
-		rec->affinity_mask.nbits = cpu__max_cpu();
-		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
-		if (!rec->affinity_mask.bits) {
-			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
-			err = -ENOMEM;
-			goto out_opts;
-		}
-		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
-	}
-
 	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
@@ -3313,7 +3362,6 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	bitmap_free(rec->affinity_mask.bits);
 	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
-- 
2.19.0

