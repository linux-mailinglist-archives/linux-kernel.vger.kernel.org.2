Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADF39158D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhEZK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:57:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:1593 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234241AbhEZK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:56:49 -0400
IronPort-SDR: YB9HHhpKe5BXwRVFUYADLlOrVOFBGcr3DlnX57pPB5WyOOuKXR/VQHMXXbo8mGgKORZtdMhGkv
 MFYFdranEWfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189556546"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189556546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 03:54:20 -0700
IronPort-SDR: ZhN0A6C1jucEvhDr2RYqMv+IvGukqlNxIwCTwCzfHvzat0hh3wG12Uhl/iIyy0atNp6BTEwyC7
 aAtbvYnjAYxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="436079452"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2021 03:54:17 -0700
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
Subject: [PATCH v6 20/20] perf session: Load data directory files for analysis
Date:   Wed, 26 May 2021 13:53:13 +0300
Message-Id: <be40346cdb384e0721f79d918067ff9026743845.1622025774.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 129 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 041601810b85..dd4ef9749cd0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -65,6 +65,7 @@ struct reader_state {
 	u64	 data_size;
 	u64	 head;
 	bool	 eof;
+	u64	 size;
 };
 
 enum {
@@ -2319,6 +2320,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
+	st->size += size;
 	st->head += size;
 	st->file_pos += size;
 
@@ -2418,6 +2420,130 @@ static int __perf_session__process_events(struct perf_session *session)
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
+		if (data->dir.files[i].size) {
+			rd[readers] = (struct reader) {
+				.fd		 = data->dir.files[i].fd,
+				.path		 = data->dir.files[i].path,
+				.data_size	 = data->dir.files[i].size,
+				.data_offset	 = 0,
+				.in_place_update = session->data->in_place_update,
+			};
+			ret = reader__init(&rd[readers], NULL);
+			if (ret)
+				goto out_err;
+			ret = reader__mmap(&rd[readers], session);
+			if (ret != READER_OK) {
+				if (ret == READER_EOF)
+					ret = -EINVAL;
+				goto out_err;
+			}
+			readers++;
+		}
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
+		if (ret == READER_EOF) {
+			ret = reader__mmap(&rd[i], session);
+			if (ret < 0)
+				goto out_err;
+			if (ret == READER_EOF)
+				readers--;
+		}
+
+		/*
+		 * Processing 10MBs of data from each reader in sequence,
+		 * because that's the way the ordered events sorting works
+		 * most efficiently.
+		 */
+		if (rd[i].state.size >= 10*1024*1024) {
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
@@ -2426,6 +2552,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
-- 
2.19.0

