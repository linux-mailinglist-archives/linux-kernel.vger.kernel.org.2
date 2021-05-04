Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A393372642
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhEDHHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:37659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhEDHHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:23 -0400
IronPort-SDR: UPzwMp19a9dt1lze+fdBTf9lk8ww3Q44BwqBToF0w0jMXeZa8M+64bY2az36HoG0uhlJjivWK8
 loPQR8zhlM2g==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197971034"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197971034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:06:17 -0700
IronPort-SDR: aKKAxjOmMi3pXkULd2dhYtWVO4WhWgMhg0uxYaZAbHX+VgzSgCeaLUtQAOcqruok+OYvg79Edq
 HlqZQDvOJcGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895728"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:06:05 -0700
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
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH v5 15/20] perf session: introduce reader objects in session object
Date:   Tue,  4 May 2021 10:04:50 +0300
Message-Id: <2c7236b460a578f8ff7e34244cd38ce813c4ea15.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to allocate multiple reader objects, so we could load multiple
data files located in data directory at the same time.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 31 ++++++++++++++++++++-----------
 tools/perf/util/session.h |  3 +++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 054f4d04eea9..65ce798eb27d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -341,6 +341,10 @@ void perf_session__delete(struct perf_session *session)
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
+	if (session->readers) {
+		zfree(&session->readers);
+		session->nr_readers = 0;
+	}
 	perf_session__release_decomp_events(session);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
@@ -2295,13 +2299,7 @@ static s64 process_simple(struct perf_session *session,
 
 static int __perf_session__process_events(struct perf_session *session)
 {
-	struct reader rd = {
-		.fd		= perf_data__fd(session->data),
-		.data_size	= session->header.data_size,
-		.data_offset	= session->header.data_offset,
-		.process	= process_simple,
-		.path		= session->data->file.path,
-	};
+	struct reader *rd;
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
@@ -2309,12 +2307,23 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	perf_tool__fill_defaults(tool);
 
-	if (rd.data_size == 0)
-		return -1;
+	rd = session->readers = zalloc(sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+
+	session->nr_readers = 1;
+
+	*rd = (struct reader) {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
+		.path		= session->data->file.path,
+	};
 
-	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
+	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
 
-	err = reader__process_events(&rd, session, &prog);
+	err = reader__process_events(rd, session, &prog);
 	if (err)
 		goto out_err;
 	/* do the final flush for ordered samples */
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 6895a22ab5b7..2815d00b5467 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -19,6 +19,7 @@ struct thread;
 
 struct auxtrace;
 struct itrace_synth_opts;
+struct reader;
 
 struct perf_session {
 	struct perf_header	header;
@@ -41,6 +42,8 @@ struct perf_session {
 	struct zstd_data	zstd_data;
 	struct decomp		*decomp;
 	struct decomp		*decomp_last;
+	struct reader		*readers;
+	int			nr_readers;
 };
 
 struct decomp {
-- 
2.19.0

