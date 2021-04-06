Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A3354ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhDFIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:39:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:42866 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhDFIjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:39:53 -0400
IronPort-SDR: p7kkqVIhWDtI5r3Vt/kyejmp/wZ7ryLdr7nlRLu/FER9eXKPoR6XcVnHzuQvOh29KvmE3v582T
 YydZQCgrRfMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180554031"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180554031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:39:46 -0700
IronPort-SDR: kMe0mtaPh16jU8b5TrnBZyHq/bCF+OVEZCnWHnU1QGwt6hC0J3Km3R9DLmzyrW6pDtiHWv8uGf
 c9ahY9W4FnUQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421119632"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:39:43 -0700
Subject: [PATCH v4 02/12] perf record: introduce thread specific data array
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
Message-ID: <aff91ec1-10d8-0e18-caf4-69e82179240a@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:39:41 +0300
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

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/lib/api/fd/array.c    |  17 ++++
 tools/lib/api/fd/array.h    |   1 +
 tools/perf/builtin-record.c | 194 +++++++++++++++++++++++++++++++++++-
 3 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 5e6cb9debe37..de8bcbaea3f1 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
 	return pos;
 }
 
+int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base)
+{
+	struct pollfd *entry;
+	int npos;
+
+	if (pos >= base->nr)
+		return -EINVAL;
+
+	entry = &base->entries[pos];
+
+	npos = fdarray__add(fda, entry->fd, entry->events, base->priv[pos].flags);
+	if (npos >= 0)
+		fda->priv[npos] = base->priv[pos];
+
+	return npos;
+}
+
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
 		    void *arg)
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index 7fcf21a33c0c..4a03da7f1fc1 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
 int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
+int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e0cbf05d255c..d74fea2d1ca9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -56,6 +56,7 @@
 #include <poll.h>
 #include <pthread.h>
 #include <unistd.h>
+#include <sys/syscall.h>
 #include <sched.h>
 #include <signal.h>
 #ifdef HAVE_EVENTFD_SUPPORT
@@ -90,6 +91,23 @@ struct thread_mask {
 	struct mmap_cpu_mask	affinity;
 };
 
+struct thread_data {
+	pid_t			tid;
+	struct thread_mask	*mask;
+	struct {
+		int		msg[2];
+		int		ack[2];
+	} pipes;
+	struct fdarray		pollfd;
+	int			ctlfd_pos;
+	struct mmap		**maps;
+	struct mmap		**overwrite_maps;
+	int			nr_mmaps;
+	struct record		*rec;
+	unsigned long long	samples;
+	unsigned long		waking;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -115,6 +133,7 @@ struct record {
 	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	struct thread_mask	*thread_masks;
+	struct thread_data	*thread_data;
 	int			nr_threads;
 };
 
@@ -845,9 +864,172 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
 	return kcore_copy(from_dir, kcore_dir);
 }
 
+static int record__thread_data_init_pipes(struct thread_data *thread_data)
+{
+	if (pipe(thread_data->pipes.msg) || pipe(thread_data->pipes.ack)) {
+		pr_err("Failed to create thread communication pipes, error %m\n");
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
+static int record__thread_data_init_maps(struct thread_data *thread_data, struct evlist *evlist)
+{
+	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
+	struct mmap *mmap = evlist->mmap;
+	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
+
+	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits, thread_data->mask->maps.nbits);
+	if (mmap) {
+		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->maps) {
+			pr_err("Failed to allocate maps thread data\n");
+			return -ENOMEM;
+		}
+	}
+	if (overwrite_mmap) {
+		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->overwrite_maps) {
+			pr_err("Failed to allocate overwrite maps thread data\n");
+			return -ENOMEM;
+		}
+	}
+	pr_debug2("thread_data[%p]: nr_mmaps=%d, maps=%p, overwrite_maps=%p\n", thread_data,
+		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
+
+	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
+		if (test_bit(cpus->map[m], thread_data->mask->maps.bits)) {
+			if (thread_data->maps) {
+				thread_data->maps[tm] = &mmap[m];
+				pr_debug2("thread_data[%p]: maps[%d] -> mmap[%d], cpus[%d]\n",
+					 thread_data, tm, m, cpus->map[m]);
+			}
+			if (thread_data->overwrite_maps) {
+				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
+				pr_debug2("thread_data[%p]: overwrite_maps[%d] -> overwrite_mmap[%d], cpus[%d]\n",
+					 thread_data, tm, m, cpus->map[m]);
+			}
+			tm++;
+		}
+	}
+
+	return 0;
+}
+
+static int record__thread_data_init_pollfd(struct thread_data *thread_data, struct evlist *evlist)
+{
+	int f, tm, pos;
+	struct mmap *map, *overwrite_map;
+
+	fdarray__init(&thread_data->pollfd, 64);
+
+	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
+		map = thread_data->maps ? thread_data->maps[tm] : NULL;
+		overwrite_map = thread_data->overwrite_maps ? thread_data->overwrite_maps[tm] : NULL;
+
+		for (f = 0; f < evlist->core.pollfd.nr; f++) {
+			void *ptr = evlist->core.pollfd.priv[f].ptr;
+
+			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
+				pos = fdarray__clone(&thread_data->pollfd, f, &evlist->core.pollfd);
+				if (pos < 0)
+					return pos;
+				pr_debug2("thread_data[%p]: pollfd[%d] <- event_fd=%d\n",
+					 thread_data, pos, evlist->core.pollfd.entries[f].fd);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
+{
+	int t, ret;
+	struct thread_data *thread_data;
+
+	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
+	if (!rec->thread_data) {
+		pr_err("Failed to allocate thread data\n");
+		return -ENOMEM;
+	}
+	thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		thread_data[t].rec = rec;
+		thread_data[t].mask = &rec->thread_masks[t];
+		ret = record__thread_data_init_maps(&thread_data[t], evlist);
+		if (ret)
+			return ret;
+		ret = record__thread_data_init_pollfd(&thread_data[t], evlist);
+		if (ret)
+			return ret;
+		if (t) {
+			thread_data[t].tid = -1;
+			ret = record__thread_data_init_pipes(&thread_data[t]);
+			if (ret)
+				return ret;
+			thread_data[t].ctlfd_pos = fdarray__add(&thread_data[t].pollfd,
+								thread_data[t].pipes.msg[0],
+								POLLIN | POLLERR | POLLHUP,
+								fdarray_flag__nonfilterable);
+			if (thread_data[t].ctlfd_pos < 0)
+				return -ENOMEM;
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 thread_data[t].pipes.msg[0]);
+		} else {
+			thread_data[t].tid = syscall(SYS_gettid);
+			if (evlist->ctl_fd.pos == -1)
+				continue;
+			thread_data[t].ctlfd_pos = fdarray__clone(&thread_data[t].pollfd,
+								  evlist->ctl_fd.pos,
+								  &evlist->core.pollfd);
+			if (thread_data[t].ctlfd_pos < 0)
+				return -ENOMEM;
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
+		}
+	}
+
+	return 0;
+}
+
+static void record__free_thread_data(struct record *rec)
+{
+	int t;
+
+	if (rec->thread_data == NULL)
+		return;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		if (rec->thread_data[t].pipes.msg[0])
+			close(rec->thread_data[t].pipes.msg[0]);
+		if (rec->thread_data[t].pipes.msg[1])
+			close(rec->thread_data[t].pipes.msg[1]);
+		if (rec->thread_data[t].pipes.ack[0])
+			close(rec->thread_data[t].pipes.ack[0]);
+		if (rec->thread_data[t].pipes.ack[1])
+			close(rec->thread_data[t].pipes.ack[1]);
+		zfree(&rec->thread_data[t].maps);
+		zfree(&rec->thread_data[t].overwrite_maps);
+		fdarray__exit(&rec->thread_data[t].pollfd);
+	}
+
+	zfree(&rec->thread_data);
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
+	int ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -878,6 +1060,14 @@ static int record__mmap_evlist(struct record *rec,
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
 
@@ -1844,9 +2034,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		evlist__start_workload(rec->evlist);
 	}
 
-	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
-		goto out_child;
-
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1998,6 +2185,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__free_thread_data(rec);
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
-- 
2.19.0


