Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DF3C4DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbhGLHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:15:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:25896 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240109AbhGLGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209973441"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209973441"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916408"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:48 -0700
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
Subject: [PATCH v10 23/24] perf session: Load single file for analysis
Date:   Mon, 12 Jul 2021 09:46:23 +0300
Message-Id: <7ffae24097badab68c14f9ece236a0597c70abbd.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 72 ++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8be60ad6c818..63811fec2583 100644
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
@@ -2248,6 +2255,11 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	char *buf, **mmaps = st->mmaps;
 	u64 page_offset;
 
+	if (st->file_pos >= st->data_size) {
+		st->eof = true;
+		return READER_EOF;
+	}
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2276,36 +2288,26 @@ reader__mmap(struct reader *rd, struct perf_session *session)
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
@@ -2327,18 +2329,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
@@ -2382,9 +2378,31 @@ static int __perf_session__process_events(struct perf_session *session)
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

