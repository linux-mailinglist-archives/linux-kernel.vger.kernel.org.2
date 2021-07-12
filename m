Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD193C4D05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhGLHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:11:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:45864 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239229AbhGLGtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:49:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="197204387"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="197204387"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916152"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:46:42 -0700
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
Subject: [PATCH v10 06/24] perf record: Stop threads in the end of trace streaming
Date:   Mon, 12 Jul 2021 09:46:06 +0300
Message-Id: <dc4ecea0ce2fe0eea75760812fbe31b8a0c5584b.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal thread to terminate by closing write fd of msg pipe.
Receive THREAD_MSG__READY message as the confirmation of the
thread's termination. Stop threads created for parallel trace
streaming prior their stats processing.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dfc5db24e037..2f907186468a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -112,6 +112,16 @@ struct record_thread {
 
 static __thread struct record_thread *thread;
 
+enum thread_msg {
+	THREAD_MSG__UNDEFINED = 0,
+	THREAD_MSG__READY,
+	THREAD_MSG__MAX,
+};
+
+static const char *thread_msg_tags[THREAD_MSG__MAX] = {
+	"UNDEFINED", "READY"
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -1918,6 +1928,24 @@ static void record__uniquify_name(struct record *rec)
 	}
 }
 
+static int record__terminate_thread(struct record_thread *thread_data)
+{
+	int res;
+	enum thread_msg ack = THREAD_MSG__UNDEFINED;
+	pid_t tid = thread_data->tid;
+
+	close(thread_data->pipes.msg[1]);
+	thread_data->pipes.msg[1] = -1;
+	res = read(thread_data->pipes.ack[0], &ack, sizeof(ack));
+	if (res != -1)
+		pr_debug2("threads[%d]: sent %s\n", tid, thread_msg_tags[ack]);
+	else
+		pr_err("threads[%d]: failed to recv msg=%s from tid=%d\n",
+		       thread->tid, thread_msg_tags[ack], tid);
+
+	return 0;
+}
+
 static int record__start_threads(struct record *rec)
 {
 	struct record_thread *thread_data = rec->thread_data;
@@ -1934,6 +1962,9 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
 	int t;
 	struct record_thread *thread_data = rec->thread_data;
 
+	for (t = 1; t < rec->nr_threads; t++)
+		record__terminate_thread(&thread_data[t]);
+
 	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
 		*waking += thread_data[t].waking;
-- 
2.19.0

