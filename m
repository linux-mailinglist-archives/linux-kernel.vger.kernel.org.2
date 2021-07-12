Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494E3C4D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbhGLHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:11:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:45893 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239285AbhGLGth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:49:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="197204400"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="197204400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916163"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:46:45 -0700
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
Subject: [PATCH v10 07/24] perf record: Start threads in the beginning of trace streaming
Date:   Mon, 12 Jul 2021 09:46:07 +0300
Message-Id: <993b734f362b2740e9758abd68a61f2362a9a119.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start thread in detached state because its management is implemented
via messaging to avoid any scaling issues. Block signals prior thread
start so only main tool thread would be notified on external async
signals during data collection. Thread affinity mask is used to assign
eligible cpus for the thread to run. Wait and sync on thread start using
thread ack pipe.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 109 +++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2f907186468a..cb8d320d20a9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1484,6 +1484,67 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
+static void *record__thread(void *arg)
+{
+	enum thread_msg msg = THREAD_MSG__READY;
+	bool terminate = false;
+	struct fdarray *pollfd;
+	int err, ctlfd_pos;
+
+	thread = arg;
+	thread->tid = gettid();
+
+	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_err("threads[%d]: failed to notify on start: %s", thread->tid, strerror(errno));
+
+	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
+
+	pollfd = &thread->pollfd;
+	ctlfd_pos = thread->ctlfd_pos;
+
+	for (;;) {
+		unsigned long long hits = thread->samples;
+
+		if (record__mmap_read_all(thread->rec, false) < 0 || terminate)
+			break;
+
+		if (hits == thread->samples) {
+
+			err = fdarray__poll(pollfd, -1);
+			/*
+			 * Propagate error, only if there's any. Ignore positive
+			 * number of returned events and interrupt error.
+			 */
+			if (err > 0 || (err < 0 && errno == EINTR))
+				err = 0;
+			thread->waking++;
+
+			if (fdarray__filter(pollfd, POLLERR | POLLHUP,
+					    record__thread_munmap_filtered, NULL) == 0)
+				break;
+		}
+
+		if (pollfd->entries[ctlfd_pos].revents & POLLHUP) {
+			terminate = true;
+			close(thread->pipes.msg[0]);
+			thread->pipes.msg[0] = -1;
+			pollfd->entries[ctlfd_pos].fd = -1;
+			pollfd->entries[ctlfd_pos].events = 0;
+		}
+
+		pollfd->entries[ctlfd_pos].revents = 0;
+	}
+	record__mmap_read_all(thread->rec, true);
+
+	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_err("threads[%d]: failed to notify on termination: %s",
+		       thread->tid, strerror(errno));
+
+	return NULL;
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -1948,13 +2009,59 @@ static int record__terminate_thread(struct record_thread *thread_data)
 
 static int record__start_threads(struct record *rec)
 {
+	int t, tt, ret = 0, nr_threads = rec->nr_threads;
 	struct record_thread *thread_data = rec->thread_data;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_err("Failed to block signals on threads start: %s\n", strerror(errno));
+		return -1;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	for (t = 1; t < nr_threads; t++) {
+		enum thread_msg msg = THREAD_MSG__UNDEFINED;
+
+		pthread_attr_setaffinity_np(&attrs,
+					    MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
+					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
+
+		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
+			for (tt = 1; tt < t; tt++)
+				record__terminate_thread(&thread_data[t]);
+			pr_err("Failed to start threads: %s\n", strerror(errno));
+			ret = -1;
+			goto out_err;
+		}
+
+		if (read(thread_data[t].pipes.ack[0], &msg, sizeof(msg)) > 0)
+			pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
+				 thread_msg_tags[msg]);
+	}
+
+	if (nr_threads > 1) {
+		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread_data[0].mask->affinity),
+				  (cpu_set_t *)thread_data[0].mask->affinity.bits);
+	}
 
 	thread = &thread_data[0];
 
 	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
 
-	return 0;
+out_err:
+	pthread_attr_destroy(&attrs);
+
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_err("Failed to unblock signals on threads start: %s\n", strerror(errno));
+		ret = -1;
+	}
+
+	return ret;
 }
 
 static int record__stop_threads(struct record *rec, unsigned long *waking)
-- 
2.19.0

