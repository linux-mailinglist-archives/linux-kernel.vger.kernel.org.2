Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0523AFF78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFVIpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:45:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:57595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhFVIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:45:01 -0400
IronPort-SDR: O7tdQ9laaISJksED3B+ldxMAnnw0dYwBK9lMq5LAkLNBtpC91GSrTM5IRsFPl1yUO8OtiSp0co
 T8XmA3TTPYpA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292641529"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292641529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:42:46 -0700
IronPort-SDR: VBGjeMk0cT4qxksYPbCu1rZDhD4lSCiZ8QV5+B5P9v5ot8cX2ZrxMO+Dgp65T52ragNnh09md4
 fW1hQ7G/r67w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="417332490"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2021 01:42:43 -0700
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
Subject: [PATCH v7 04/20] perf record: Stop threads in the end of trace streaming
Date:   Tue, 22 Jun 2021 11:42:13 +0300
Message-Id: <26565cdb34d0e0d310c5d89d591fdac178cced2e.1624350588.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 00d77e90d7c2..d30e0c5bece3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -112,6 +112,16 @@ struct thread_data {
 
 static __thread struct thread_data *thread;
 
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
@@ -1857,6 +1867,23 @@ static void record__uniquify_name(struct record *rec)
 	}
 }
 
+static int record__terminate_thread(struct thread_data *thread_data)
+{
+	int res;
+	enum thread_msg ack = THREAD_MSG__UNDEFINED;
+	pid_t tid = thread_data->tid;
+
+	close(thread_data->pipes.msg[1]);
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
 	struct thread_data *thread_data = rec->thread_data;
@@ -1873,6 +1900,9 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
 	int t;
 	struct thread_data *thread_data = rec->thread_data;
 
+	for (t = 1; t < rec->nr_threads; t++)
+		record__terminate_thread(&thread_data[t]);
+
 	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
 		*waking += thread_data[t].waking;
-- 
2.19.0

