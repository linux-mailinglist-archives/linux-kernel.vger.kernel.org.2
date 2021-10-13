Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95C42BB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhJMJJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:55079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238971AbhJMJI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:08:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227281648"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="227281648"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460705920"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:06:50 -0700
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
Subject: [PATCH v4 1/8] perf session: Move all state items to reader object
Date:   Wed, 13 Oct 2021 12:06:35 +0300
Message-Id: <5c7bdebfaadd7fcb729bd999b181feccaa292e8e.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need all the state info about reader in separate object to load data
from multiple files, so we can keep multiple readers at the same time.
Moving all items that need to be kept from reader__process_events to
the reader object. Introducing mmap_cur to keep current mapping.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 63 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 069c2cfdd3be..bf73e8c1f15c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2171,6 +2171,13 @@ struct reader {
 	u64		 data_offset;
 	reader_cb_t	 process;
 	bool		 in_place_update;
+	char		 *mmaps[NUM_MMAPS];
+	size_t		 mmap_size;
+	int		 mmap_idx;
+	char		 *mmap_cur;
+	u64		 file_pos;
+	u64		 file_offset;
+	u64		 head;
 };
 
 static int
@@ -2178,28 +2185,27 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
 {
 	u64 data_size = rd->data_size;
-	u64 head, page_offset, file_offset, file_pos, size;
-	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
-	size_t	mmap_size;
-	char *buf, *mmaps[NUM_MMAPS];
+	u64 page_offset, size;
+	int err = 0, mmap_prot, mmap_flags;
+	char *buf, **mmaps = rd->mmaps;
 	union perf_event *event;
 	s64 skip;
 
 	page_offset = page_size * (rd->data_offset / page_size);
-	file_offset = page_offset;
-	head = rd->data_offset - page_offset;
+	rd->file_offset = page_offset;
+	rd->head = rd->data_offset - page_offset;
 
 	ui_progress__init_size(prog, data_size, "Processing events...");
 
 	data_size += rd->data_offset;
 
-	mmap_size = MMAP_SIZE;
-	if (mmap_size > data_size) {
-		mmap_size = data_size;
+	rd->mmap_size = MMAP_SIZE;
+	if (rd->mmap_size > data_size) {
+		rd->mmap_size = data_size;
 		session->one_mmap = true;
 	}
 
-	memset(mmaps, 0, sizeof(mmaps));
+	memset(mmaps, 0, sizeof(rd->mmaps));
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2211,35 +2217,36 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
-		   file_offset);
+	buf = mmap(NULL, rd->mmap_size, mmap_prot, mmap_flags, rd->fd,
+		   rd->file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
 		err = -errno;
 		goto out;
 	}
-	mmaps[map_idx] = buf;
-	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
-	file_pos = file_offset + head;
+	mmaps[rd->mmap_idx] = rd->mmap_cur = buf;
+	rd->mmap_idx = (rd->mmap_idx + 1) & (ARRAY_SIZE(rd->mmaps) - 1);
+	rd->file_pos = rd->file_offset + rd->head;
 	if (session->one_mmap) {
 		session->one_mmap_addr = buf;
-		session->one_mmap_offset = file_offset;
+		session->one_mmap_offset = rd->file_offset;
 	}
 
 more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
+	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
+				   session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
 	if (!event) {
-		if (mmaps[map_idx]) {
-			munmap(mmaps[map_idx], mmap_size);
-			mmaps[map_idx] = NULL;
+		if (mmaps[rd->mmap_idx]) {
+			munmap(mmaps[rd->mmap_idx], rd->mmap_size);
+			mmaps[rd->mmap_idx] = NULL;
 		}
 
-		page_offset = page_size * (head / page_size);
-		file_offset += page_offset;
-		head -= page_offset;
+		page_offset = page_size * (rd->head / page_size);
+		rd->file_offset += page_offset;
+		rd->head -= page_offset;
 		goto remap;
 	}
 
@@ -2248,9 +2255,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	skip = -EINVAL;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, file_pos)) < 0) {
+	    (skip = rd->process(session, event, rd->file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
-		       file_offset + head, event->header.size,
+		       rd->file_offset + rd->head, event->header.size,
 		       event->header.type, strerror(-skip));
 		err = skip;
 		goto out;
@@ -2259,8 +2266,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
-	head += size;
-	file_pos += size;
+	rd->head += size;
+	rd->file_pos += size;
 
 	err = __perf_session__process_decomp_events(session);
 	if (err)
@@ -2271,7 +2278,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (file_pos < data_size)
+	if (rd->file_pos < data_size)
 		goto more;
 
 out:
-- 
2.19.0

