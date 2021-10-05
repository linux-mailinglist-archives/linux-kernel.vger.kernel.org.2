Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CA42235F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhJEK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:29:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:46740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhJEK3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:29:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225603044"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225603044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714164551"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 03:27:24 -0700
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
Subject: [PATCH v2 5/5] perf session: Load single file for analysis
Date:   Tue,  5 Oct 2021 13:27:02 +0300
Message-Id: <ccf01f8ac3bb9c29ef10f7b1c31db6a2fe8173c4.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding reader EOF return code and moving the check of EOF state to
reader__mmap. Adding reader OK and NODATA return codes to simplify
the code and separating reading code of single event into
reader__read_event function. Introducing read_event/remap loop
in __perf_session__process_events.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 74 +++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6c825e4a9dfe..1915714747a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2167,6 +2167,12 @@ typedef s64 (*reader_cb_t)(struct perf_session *session,
 			   union perf_event *event,
 			   u64 file_offset);
 
+enum {
+	READER_OK,
+	READER_NODATA,
+	READER_EOF,
+};
+
 struct reader_state {
 	char	*mmaps[NUM_MMAPS];
 	size_t	 mmap_size;
@@ -2229,6 +2235,9 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	char *buf, **mmaps = st->mmaps;
 	u64 page_offset;
 
+	if (st->file_pos >= st->data_size)
+		return READER_EOF;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2257,36 +2266,26 @@ reader__mmap(struct reader *rd, struct perf_session *session)
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
 
 	session->active_decomp = &rd->decomp_data;
 	size = event->header.size;
@@ -2308,18 +2307,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
 	session->active_decomp = &session->decomp_data;
 	return err;
@@ -2356,9 +2349,36 @@ static int __perf_session__process_events(struct perf_session *session)
 	err = reader__init(&rd, &session->one_mmap);
 	if (err)
 		goto out_err;
-	err = reader__process_events(&rd, session, &prog);
-	if (err)
+
+	err = reader__mmap(&rd, session);
+	if (err < 0) {
 		goto out_err;
+	} else if (err == READER_EOF) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	if (session->one_mmap) {
+		session->one_mmap_addr   = rd.state.mmap_cur;
+		session->one_mmap_offset = rd.state.file_offset;
+	}
+
+	while (true) {
+		if (session_done())
+			break;
+
+		err = reader__read_event(&rd, session, &prog);
+		if (err < 0) {
+			goto out_err;
+		} else if (err == READER_NODATA) {
+			err = reader__mmap(&rd, session);
+			if (err < 0)
+				goto out_err;
+			else if (err == READER_EOF)
+				break;
+		}
+	}
+
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
 	if (err)
-- 
2.19.0

