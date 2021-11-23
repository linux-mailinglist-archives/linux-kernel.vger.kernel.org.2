Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21F845A496
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhKWOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:12:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:23927 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237600AbhKWOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:11:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215736201"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215736201"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422442"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:08:45 -0800
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
Subject: [PATCH v12 06/16] perf record: Stop threads in the end of trace streaming
Date:   Tue, 23 Nov 2021 17:08:02 +0300
Message-Id: <fa7d96e0ff2304b5839393d5221105d09ce7e133.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
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
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fcd915e2e5ca..7a9c0c7daeaa 100644
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
@@ -1890,6 +1900,23 @@ static void record__uniquify_name(struct record *rec)
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
+		pr_err("threads[%d]: failed to receive message from tid: %d\n", thread->tid, tid);
+
+	return 0;
+}
+
 static int record__start_threads(struct record *rec)
 {
 	struct record_thread *thread_data = rec->thread_data;
@@ -1906,6 +1933,9 @@ static int record__stop_threads(struct record *rec)
 	int t;
 	struct record_thread *thread_data = rec->thread_data;
 
+	for (t = 1; t < rec->nr_threads; t++)
+		record__terminate_thread(&thread_data[t]);
+
 	for (t = 0; t < rec->nr_threads; t++)
 		rec->samples += thread_data[t].samples;
 
-- 
2.19.0

