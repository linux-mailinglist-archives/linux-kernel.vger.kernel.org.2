Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8496D3EE87C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhHQI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:26:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:18151 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239407AbhHQIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:25:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214171976"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="214171976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 01:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="471080453"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2021 01:24:41 -0700
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
Subject: [PATCH v11 23/24] perf session: Load single file for analysis
Date:   Tue, 17 Aug 2021 11:23:26 +0300
Message-Id: <90484cdd55c4b995def42e01e35c5c2fef1f673d.1629186429.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding eof flag to reader state and moving the check to reader__mmap.
Separating reading code of single event into reader__read_event function.
Adding basic reader return codes to simplify the code and introducing
reader remmap/read_event loop based on them.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 72 ++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9a7cba31194..b49b52768681 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -64,6 +64,13 @@ struct reader_state {
 	u64	 file_offset;
 	u64	 data_size;
 	u64	 head;
+	bool	 eof;
+};
+
+enum {
+	READER_EOF,
+	READER_NODATA,
+	READER_OK,
 };
 
 struct reader {
@@ -2250,6 +2257,11 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	char *buf, **mmaps = st->mmaps;
 	u64 page_offset;
 
+	if (st->file_pos >= st->data_size) {
+		st->eof = true;
+		return READER_EOF;
+	}
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2278,36 +2290,26 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	mmaps[st->mmap_idx] = st->mmap_cur = buf;
 	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
 	st->file_pos = st->file_offset + st->head;
-	return 0;
+	return READER_OK;
 }
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__read_event(struct reader *rd, struct perf_session *session,
+		   struct ui_progress *prog)
 {
 	struct reader_state *st = &rd->state;
-	u64 size;
-	int err = 0;
+	int err = READER_OK;
 	union perf_event *event;
+	u64 size;
 	s64 skip;
 
-remap:
-	err = reader__mmap(rd, session);
-	if (err)
-		goto out;
-	if (session->one_mmap) {
-		session->one_mmap_addr   = rd->state.mmap_cur;
-		session->one_mmap_offset = rd->state.file_offset;
-	}
-
-more:
 	event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur,
 				   session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
 	if (!event)
-		goto remap;
+		return READER_NODATA;
 
 	session->active_reader = rd;
 	size = event->header.size;
@@ -2329,18 +2331,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	st->head += size;
 	st->file_pos += size;
 
-	err = __perf_session__process_decomp_events(session);
-	if (err)
-		goto out;
+	skip = __perf_session__process_decomp_events(session);
+	if (skip)
+		err = skip;
 
 	ui_progress__update(prog, size);
 
-	if (session_done())
-		goto out;
-
-	if (st->file_pos < st->data_size)
-		goto more;
-
 out:
 	session->active_reader = NULL;
 	return err;
@@ -2384,9 +2380,31 @@ static int __perf_session__process_events(struct perf_session *session)
 	err = reader__init(rd, &session->one_mmap);
 	if (err)
 		goto out_err;
-	err = reader__process_events(rd, session, &prog);
-	if (err)
+	err = reader__mmap(rd, session);
+	if (err != READER_OK) {
+		if (err == READER_EOF)
+			err = -EINVAL;
 		goto out_err;
+	}
+	if (session->one_mmap) {
+		session->one_mmap_addr   = rd->state.mmap_cur;
+		session->one_mmap_offset = rd->state.file_offset;
+	}
+
+	while (true) {
+		if (session_done())
+			break;
+
+		err = reader__read_event(rd, session, &prog);
+		if (err < 0)
+			break;
+		if (err == READER_NODATA) {
+			err = reader__mmap(rd, session);
+			if (err <= 0)
+				break;
+		}
+	}
+
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
 	if (err)
-- 
2.19.0

