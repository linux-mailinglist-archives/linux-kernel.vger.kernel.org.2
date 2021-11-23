Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8781E45A492
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhKWOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:12:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:46784 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237502AbhKWOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:11:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235263579"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="235263579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422369"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:08:27 -0800
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
Subject: [PATCH v12 03/16] perf record: Introduce thread specific data array
Date:   Tue, 23 Nov 2021 17:07:59 +0300
Message-Id: <f3e3d4960cb8becbdf94c55d5c953417ac419c8b.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce thread specific data object and array of such objects
to store and manage thread local data. Implement functions to
allocate, initialize, finalize and release thread specific data.

Thread local maps and overwrite_maps arrays keep pointers to
mmap buffer objects to serve according to maps thread mask.
Thread local pollfd array keeps event fds connected to mmaps
buffers according to maps thread mask.

Thread control commands are delivered via thread local comm pipes
and ctlfd_pos fd. External control commands (--control option)
are delivered via evlist ctlfd_pos fd and handled by the main
tool thread.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 252 +++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 11537971ea3b..88b23ad1407b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -58,6 +58,7 @@
 #include <poll.h>
 #include <pthread.h>
 #include <unistd.h>
+#include <syscall.h>
 #include <sched.h>
 #include <signal.h>
 #ifdef HAVE_EVENTFD_SUPPORT
@@ -92,6 +93,21 @@ struct thread_mask {
 	struct mmap_cpu_mask	affinity;
 };
 
+struct record_thread {
+	pid_t			tid;
+	struct thread_mask	*mask;
+	struct {
+		int		msg[2];
+		int		ack[2];
+	} pipes;
+	struct fdarray		pollfd;
+	int			ctlfd_pos;
+	int			nr_mmaps;
+	struct mmap		**maps;
+	struct mmap		**overwrite_maps;
+	struct record		*rec;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -118,6 +134,7 @@ struct record {
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	int			nr_threads;
 	struct thread_mask	*thread_masks;
+	struct record_thread	*thread_data;
 };
 
 static volatile int done;
@@ -130,6 +147,13 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(__NR_gettid);
+}
+#endif
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -847,9 +871,225 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
 	return kcore_copy(from_dir, kcore_dir);
 }
 
+static void record__thread_data_init_pipes(struct record_thread *thread_data)
+{
+	thread_data->pipes.msg[0] = -1;
+	thread_data->pipes.msg[1] = -1;
+	thread_data->pipes.ack[0] = -1;
+	thread_data->pipes.ack[1] = -1;
+}
+
+static int record__thread_data_open_pipes(struct record_thread *thread_data)
+{
+	if (pipe(thread_data->pipes.msg)) {
+		pr_err("Failed to create thread msg communication pipe: %s\n", strerror(errno));
+		return -ENOMEM;
+	}
+
+	if (pipe(thread_data->pipes.ack)) {
+		pr_err("Failed to create thread ack communication pipe: %s\n", strerror(errno));
+		close(thread_data->pipes.msg[0]);
+		thread_data->pipes.msg[0] = -1;
+		close(thread_data->pipes.msg[1]);
+		thread_data->pipes.msg[1] = -1;
+		return -ENOMEM;
+	}
+
+	pr_debug2("thread_data[%p]: msg=[%d,%d], ack=[%d,%d]\n", thread_data,
+		 thread_data->pipes.msg[0], thread_data->pipes.msg[1],
+		 thread_data->pipes.ack[0], thread_data->pipes.ack[1]);
+
+	return 0;
+}
+
+static void record__thread_data_close_pipes(struct record_thread *thread_data)
+{
+	if (thread_data->pipes.msg[0] != -1) {
+		close(thread_data->pipes.msg[0]);
+		thread_data->pipes.msg[0] = -1;
+	}
+	if (thread_data->pipes.msg[1] != -1) {
+		close(thread_data->pipes.msg[1]);
+		thread_data->pipes.msg[1] = -1;
+	}
+	if (thread_data->pipes.ack[0] != -1) {
+		close(thread_data->pipes.ack[0]);
+		thread_data->pipes.ack[0] = -1;
+	}
+	if (thread_data->pipes.ack[1] != -1) {
+		close(thread_data->pipes.ack[1]);
+		thread_data->pipes.ack[1] = -1;
+	}
+}
+
+static int record__thread_data_init_maps(struct record_thread *thread_data, struct evlist *evlist)
+{
+	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
+	struct mmap *mmap = evlist->mmap;
+	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
+
+	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
+					      thread_data->mask->maps.nbits);
+	if (mmap) {
+		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->maps) {
+			pr_err("Failed to allocate thread maps\n");
+			return -ENOMEM;
+		}
+	}
+	if (overwrite_mmap) {
+		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->overwrite_maps) {
+			pr_err("Failed to allocate thread overwrite maps\n");
+			zfree(&thread_data->maps);
+			return -ENOMEM;
+		}
+	}
+	pr_debug2("thread_data[%p]: nr_mmaps=%d, maps=%p, ow_maps=%p\n", thread_data,
+		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
+
+	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
+		if (test_bit(cpus->map[m], thread_data->mask->maps.bits)) {
+			if (thread_data->maps) {
+				thread_data->maps[tm] = &mmap[m];
+				pr_debug2("thread_data[%p]: maps[%d] -> mmap[%d], cpus[%d]\n",
+					  thread_data, tm, m, cpus->map[m]);
+			}
+			if (thread_data->overwrite_maps) {
+				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
+				pr_debug2("thread_data[%p]: ow_maps[%d] -> ow_mmap[%d], cpus[%d]\n",
+					  thread_data, tm, m, cpus->map[m]);
+			}
+			tm++;
+		}
+	}
+
+	return 0;
+}
+
+static int record__thread_data_init_pollfd(struct record_thread *thread_data, struct evlist *evlist)
+{
+	int f, tm, pos;
+	struct mmap *map, *overwrite_map;
+
+	fdarray__init(&thread_data->pollfd, 64);
+
+	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
+		map = thread_data->maps ? thread_data->maps[tm] : NULL;
+		overwrite_map = thread_data->overwrite_maps ?
+				thread_data->overwrite_maps[tm] : NULL;
+
+		for (f = 0; f < evlist->core.pollfd.nr; f++) {
+			void *ptr = evlist->core.pollfd.priv[f].ptr;
+
+			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
+				pos = fdarray__dup_entry_from(&thread_data->pollfd, f,
+							      &evlist->core.pollfd);
+				if (pos < 0) {
+					pr_err("Failed to duplicate descriptor in thread pollfd\n");
+					return pos;
+				}
+				pr_debug2("thread_data[%p]: pollfd[%d] <- event_fd=%d\n",
+					 thread_data, pos, evlist->core.pollfd.entries[f].fd);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void record__free_thread_data(struct record *rec)
+{
+	int t;
+	struct record_thread *thread_data = rec->thread_data;
+
+	if (thread_data == NULL)
+		return;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		record__thread_data_close_pipes(&thread_data[t]);
+		zfree(&thread_data[t].maps);
+		zfree(&thread_data[t].overwrite_maps);
+		fdarray__exit(&thread_data[t].pollfd);
+	}
+
+	zfree(&rec->thread_data);
+}
+
+static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
+{
+	int t, ret;
+	struct record_thread *thread_data;
+
+	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
+	if (!rec->thread_data) {
+		pr_err("Failed to allocate thread data\n");
+		return -ENOMEM;
+	}
+	thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		record__thread_data_init_pipes(&thread_data[t]);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		thread_data[t].rec = rec;
+		thread_data[t].mask = &rec->thread_masks[t];
+		ret = record__thread_data_init_maps(&thread_data[t], evlist);
+		if (ret)
+			goto out_free;
+		ret = record__thread_data_init_pollfd(&thread_data[t], evlist);
+		if (ret) {
+			pr_err("Failed to initialize thread pollfd\n");
+			goto out_free;
+		}
+		if (t) {
+			thread_data[t].tid = -1;
+			ret = record__thread_data_open_pipes(&thread_data[t]);
+			if (ret)
+				goto out_free;
+			thread_data[t].ctlfd_pos = fdarray__add(&thread_data[t].pollfd,
+								thread_data[t].pipes.msg[0],
+								POLLIN | POLLERR | POLLHUP,
+								fdarray_flag__nonfilterable);
+			if (thread_data[t].ctlfd_pos < 0) {
+				pr_err("Failed to add descriptor to thread pollfd\n");
+				ret = -ENOMEM;
+				goto out_free;
+			}
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 thread_data[t].pipes.msg[0]);
+		} else {
+			thread_data[t].tid = gettid();
+			if (evlist->ctl_fd.pos == -1)
+				continue;
+			thread_data[t].ctlfd_pos = fdarray__dup_entry_from(&thread_data[t].pollfd,
+									   evlist->ctl_fd.pos,
+									   &evlist->core.pollfd);
+			if (thread_data[t].ctlfd_pos < 0) {
+				pr_err("Failed to duplicate descriptor in thread pollfd\n");
+				ret = -ENOMEM;
+				goto out_free;
+			}
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
+		}
+	}
+
+	return 0;
+
+out_free:
+	record__free_thread_data(rec);
+
+	return ret;
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
+	int ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -880,6 +1120,14 @@ static int record__mmap_evlist(struct record *rec,
 				return -EINVAL;
 		}
 	}
+
+	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		return -1;
+
+	ret = record__alloc_thread_data(rec, evlist);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1861,9 +2109,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		evlist__start_workload(rec->evlist);
 	}
 
-	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
-		goto out_child;
-
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -2021,6 +2266,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_child:
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
+	record__free_thread_data(rec);
 	record__aio_mmap_read_sync(rec);
 
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
-- 
2.19.0

