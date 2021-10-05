Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40D42235E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhJEK3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:29:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:46740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhJEK3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:29:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225603035"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225603035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714164532"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 03:27:20 -0700
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
Subject: [PATCH v2 4/5] perf session: Move map/unmap to separate function
Date:   Tue,  5 Oct 2021 13:27:01 +0300
Message-Id: <e55609cec017c7b2a696d74bed582a9984105669.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mapping and unmapping code into reader__mmap, so the mmap
code is located together. Moving head/file_offset computation into
reader__mmap function, so all the offset computation is located
together and in one place only.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 61 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 53cd7a3b5efd..6c825e4a9dfe 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2193,13 +2193,9 @@ static int
 reader__init(struct reader *rd, bool *one_mmap)
 {
 	struct reader_state *st = &rd->state;
-	u64 page_offset;
 	char **mmaps = st->mmaps;
 
-	page_offset = page_size * (rd->data_offset / page_size);
-	st->file_offset = page_offset;
-	st->head = rd->data_offset - page_offset;
-
+	st->head = rd->data_offset;
 	st->data_size = rd->data_size + rd->data_offset;
 
 	st->mmap_size = MMAP_SIZE;
@@ -2226,15 +2222,12 @@ reader__exit(struct reader *rd)
 }
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__mmap(struct reader *rd, struct perf_session *session)
 {
 	struct reader_state *st = &rd->state;
-	u64 page_offset, size;
-	int err = 0, mmap_prot, mmap_flags;
+	int mmap_prot, mmap_flags;
 	char *buf, **mmaps = st->mmaps;
-	union perf_event *event;
-	s64 skip;
+	u64 page_offset;
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2245,20 +2238,45 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		mmap_prot  |= PROT_WRITE;
 		mmap_flags = MAP_PRIVATE;
 	}
-remap:
+
+	if (mmaps[st->mmap_idx]) {
+		munmap(mmaps[st->mmap_idx], st->mmap_size);
+		mmaps[st->mmap_idx] = NULL;
+	}
+
+	page_offset = page_size * (st->head / page_size);
+	st->file_offset += page_offset;
+	st->head -= page_offset;
+
 	buf = mmap(NULL, st->mmap_size, mmap_prot, mmap_flags, rd->fd,
 		   st->file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
-		err = -errno;
-		goto out;
+		return -errno;
 	}
 	mmaps[st->mmap_idx] = st->mmap_cur = buf;
 	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
 	st->file_pos = st->file_offset + st->head;
+	return 0;
+}
+
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
+{
+	struct reader_state *st = &rd->state;
+	u64 size;
+	int err = 0;
+	union perf_event *event;
+	s64 skip;
+
+remap:
+	err = reader__mmap(rd, session);
+	if (err)
+		goto out;
 	if (session->one_mmap) {
-		session->one_mmap_addr = buf;
-		session->one_mmap_offset = st->file_offset;
+		session->one_mmap_addr   = rd->state.mmap_cur;
+		session->one_mmap_offset = rd->state.file_offset;
 	}
 
 more:
@@ -2267,17 +2285,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-	if (!event) {
-		if (mmaps[st->mmap_idx]) {
-			munmap(mmaps[st->mmap_idx], st->mmap_size);
-			mmaps[st->mmap_idx] = NULL;
-		}
-
-		page_offset = page_size * (st->head / page_size);
-		st->file_offset += page_offset;
-		st->head -= page_offset;
+	if (!event)
 		goto remap;
-	}
 
 	session->active_decomp = &rd->decomp_data;
 	size = event->header.size;
-- 
2.19.0

