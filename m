Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71323C4E19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhGLHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:16:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:25894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240156AbhGLGus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209973443"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209973443"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916419"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:50 -0700
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
Subject: [PATCH v10 24/24] perf session: Load data directory files for analysis
Date:   Mon, 12 Jul 2021 09:46:24 +0300
Message-Id: <7038392fb4eeb0fe0c59bc6769d72fb7c831373f.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load data directory files and provide basic raw dump and aggregated
analysis support of data directories in report mode, still with no
memory consumption optimizations.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 131 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 63811fec2583..021f543c22a4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -48,6 +48,13 @@
 #define NUM_MMAPS 128
 #endif
 
+/*
+ * Processing 10MBs of data from each reader in sequence,
+ * because that's the way the ordered events sorting works
+ * most efficiently.
+ */
+#define READER_MAX_SIZE (10 * 1024 * 1024)
+
 struct reader;
 
 typedef s64 (*reader_cb_t)(struct perf_session *session,
@@ -65,6 +72,7 @@ struct reader_state {
 	u64	 data_size;
 	u64	 head;
 	bool	 eof;
+	u64	 size;
 };
 
 enum {
@@ -2326,6 +2334,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
+	st->size += size;
 	st->head += size;
 	st->file_pos += size;
 
@@ -2425,6 +2434,125 @@ static int __perf_session__process_events(struct perf_session *session)
 	return err;
 }
 
+/*
+ * This function reads, merge and process directory data.
+ * It assumens the version 1 of directory data, where each
+ * data file holds per-cpu data, already sorted by kernel.
+ */
+static int __perf_session__process_dir_events(struct perf_session *session)
+{
+	struct perf_data *data = session->data;
+	struct perf_tool *tool = session->tool;
+	int i, ret = 0, readers = 1;
+	struct ui_progress prog;
+	u64 total_size = perf_data__size(session->data);
+	struct reader *rd;
+
+	perf_tool__fill_defaults(tool);
+
+	ui_progress__init_size(&prog, total_size, "Sorting events...");
+
+	for (i = 0; i < data->dir.nr; i++) {
+		if (data->dir.files[i].size)
+			readers++;
+	}
+
+	rd = session->readers = zalloc(readers * sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+	session->nr_readers = readers;
+	readers = 0;
+
+	rd[readers] = (struct reader) {
+		.fd		 = perf_data__fd(session->data),
+		.path		 = session->data->file.path,
+		.data_size	 = session->header.data_size,
+		.data_offset	 = session->header.data_offset,
+		.in_place_update = session->data->in_place_update,
+	};
+	ret = reader__init(&rd[readers], NULL);
+	if (ret)
+		goto out_err;
+	ret = reader__mmap(&rd[readers], session);
+	if (ret != READER_OK) {
+		if (ret == READER_EOF)
+			ret = -EINVAL;
+		goto out_err;
+	}
+	readers++;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		if (!data->dir.files[i].size)
+			continue;
+		rd[readers] = (struct reader) {
+			.fd		 = data->dir.files[i].fd,
+			.path		 = data->dir.files[i].path,
+			.data_size	 = data->dir.files[i].size,
+			.data_offset	 = 0,
+			.in_place_update = session->data->in_place_update,
+		};
+		ret = reader__init(&rd[readers], NULL);
+		if (ret)
+			goto out_err;
+		ret = reader__mmap(&rd[readers], session);
+		if (ret != READER_OK) {
+			if (ret == READER_EOF)
+				ret = -EINVAL;
+			goto out_err;
+		}
+		readers++;
+	}
+
+	i = 0;
+
+	while ((ret >= 0) && readers) {
+		if (session_done())
+			return 0;
+
+		if (rd[i].state.eof) {
+			i = (i + 1) % session->nr_readers;
+			continue;
+		}
+
+		ret = reader__read_event(&rd[i], session, &prog);
+		if (ret < 0)
+			break;
+		if (ret == READER_NODATA) {
+			ret = reader__mmap(&rd[i], session);
+			if (ret < 0)
+				goto out_err;
+			if (ret == READER_EOF)
+				readers--;
+		}
+
+		if (rd[i].state.size >= READER_MAX_SIZE) {
+			rd[i].state.size = 0;
+			i = (i + 1) % session->nr_readers;
+		}
+	}
+
+	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
+	if (ret)
+		goto out_err;
+
+	ret = perf_session__flush_thread_stacks(session);
+out_err:
+	ui_progress__finish();
+
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+
+	session->one_mmap = false;
+
+	return ret;
+}
+
 int perf_session__process_events(struct perf_session *session)
 {
 	if (perf_session__register_idle_thread(session) < 0)
@@ -2433,6 +2561,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
-- 
2.19.0

