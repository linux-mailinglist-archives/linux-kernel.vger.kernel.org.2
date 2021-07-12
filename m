Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346AC3C4EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbhGLHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:20:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:45862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239069AbhGLGt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:49:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="197204350"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="197204350"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916118"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:46:33 -0700
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
Subject: [PATCH v10 03/24] perf record: Introduce thread specific data array
Date:   Mon, 12 Jul 2021 09:46:03 +0300
Message-Id: <6d1a042708fcd492158bbb1cfd7a1c96068a523c.1626072008.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 254 +++++++++++++++++++++++++++++++++++-
 1 file changed, 251 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3d6e565342dc..a25b23affc43 100644
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
@@ -92,6 +93,23 @@ struct thread_mask {
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
+	unsigned long long	samples;
+	unsigned long		waking;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -118,6 +136,7 @@ struct record {
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	int			nr_threads;
 	struct thread_mask	*thread_masks;
+	struct record_thread	*thread_data;
 };
 
 static volatile int done;
@@ -130,6 +149,13 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
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
@@ -847,9 +873,225 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
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
@@ -880,6 +1122,14 @@ static int record__mmap_evlist(struct record *rec,
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
 
@@ -1881,9 +2131,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		evlist__start_workload(rec->evlist);
 	}
 
-	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
-		goto out_child;
-
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -2041,6 +2288,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_child:
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
+	record__free_thread_data(rec);
 	record__aio_mmap_read_sync(rec);
 
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
-- 
2.19.0

