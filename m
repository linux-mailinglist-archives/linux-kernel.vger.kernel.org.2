Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053E3354EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbhDFIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:45:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:13152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244417AbhDFIpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:10 -0400
IronPort-SDR: lHG7cnUsRlPRyBca8alj83PDGKetGrNeb5HxMEHRYVO256dZBcZddIK1iXEtm+93ZMneF6okS/
 GYnUHLWo48Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180152156"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180152156"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:45:03 -0700
IronPort-SDR: Dj6hVveqLK/PFJOSjVdTlEInJUKchM6ygtBa7FhhJ7pAH8Kx9OMRXXBIT0QrgLRHBn4r5KJgdE
 EoNAK+rDXz+w==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421121773"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:45:00 -0700
Subject: [PATCH v4 04/12] perf record: stop threads in the end of trace
 streaming
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
Message-ID: <3113338a-a17e-cc3e-2d1a-fb1b468d5dcd@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:44:57 +0300
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


Signal thread to terminate by closing write fd of msg pipe.
Receive THREAD_MSG__READY message as the confirmation of the
thread's termination. Stop threads created for parallel trace
streaming prior their stats processing.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ecb6bf33ed85..4612314853c1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -110,6 +110,16 @@ struct thread_data {
 
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
@@ -1820,6 +1830,23 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
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
@@ -1836,6 +1863,9 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
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


