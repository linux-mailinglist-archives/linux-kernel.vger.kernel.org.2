Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF23BA082
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhGBMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:36:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:32637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhGBMgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:36:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="189107327"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="189107327"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="642660326"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2021 05:33:28 -0700
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
Subject: [PATCH v9 18/24] perf session: Introduce reader_state in reader object
Date:   Fri,  2 Jul 2021 15:32:26 +0300
Message-Id: <20d08766e4bb9a1d9f6b5464149a9b82ac4080e8.1625227739.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need all the state info about reader in separate object to load data
from multiple files, so we can keep multiple readers at the same time.
Adding struct reader_state and adding all items that need to be kept.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 74 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1cfb5655e092..da39ce4acb5a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -55,6 +55,17 @@ typedef s64 (*reader_cb_t)(struct perf_session *session,
 			   u64 file_offset,
 			   const char *file_path);
 
+struct reader_state {
+	char	*mmaps[NUM_MMAPS];
+	size_t	 mmap_size;
+	int	 mmap_idx;
+	char	*mmap_cur;
+	u64	 file_pos;
+	u64	 file_offset;
+	u64	 data_size;
+	u64	 head;
+};
+
 struct reader {
 	int		 fd;
 	const char	 *path;
@@ -62,6 +73,7 @@ struct reader {
 	u64		 data_offset;
 	reader_cb_t	 process;
 	bool		 in_place_update;
+	struct reader_state state;
 };
 
 #ifdef HAVE_ZSTD_SUPPORT
@@ -2178,29 +2190,28 @@ static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
 {
-	u64 data_size = rd->data_size;
-	u64 head, page_offset, file_offset, file_pos, size;
-	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
-	size_t	mmap_size;
-	char *buf, *mmaps[NUM_MMAPS];
+	struct reader_state *st = &rd->state;
+	u64 page_offset, size;
+	int err = 0, mmap_prot, mmap_flags;
+	char *buf, **mmaps = st->mmaps;
 	union perf_event *event;
 	s64 skip;
 
 	page_offset = page_size * (rd->data_offset / page_size);
-	file_offset = page_offset;
-	head = rd->data_offset - page_offset;
+	st->file_offset = page_offset;
+	st->head = rd->data_offset - page_offset;
 
-	ui_progress__init_size(prog, data_size, "Processing events...");
+	ui_progress__init_size(prog, rd->data_size, "Processing events...");
 
-	data_size += rd->data_offset;
+	st->data_size = rd->data_size + rd->data_offset;
 
-	mmap_size = MMAP_SIZE;
-	if (mmap_size > data_size) {
-		mmap_size = data_size;
+	st->mmap_size = MMAP_SIZE;
+	if (st->mmap_size > st->data_size) {
+		st->mmap_size = st->data_size;
 		session->one_mmap = true;
 	}
 
-	memset(mmaps, 0, sizeof(mmaps));
+	memset(mmaps, 0, sizeof(st->mmaps));
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2212,35 +2223,36 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
-		   file_offset);
+	buf = mmap(NULL, st->mmap_size, mmap_prot, mmap_flags, rd->fd,
+		   st->file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
 		err = -errno;
 		goto out;
 	}
-	mmaps[map_idx] = buf;
-	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
-	file_pos = file_offset + head;
+	mmaps[st->mmap_idx] = st->mmap_cur = buf;
+	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
+	st->file_pos = st->file_offset + st->head;
 	if (session->one_mmap) {
 		session->one_mmap_addr = buf;
-		session->one_mmap_offset = file_offset;
+		session->one_mmap_offset = st->file_offset;
 	}
 
 more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
+	event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur,
+				   session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
 	if (!event) {
-		if (mmaps[map_idx]) {
-			munmap(mmaps[map_idx], mmap_size);
-			mmaps[map_idx] = NULL;
+		if (mmaps[st->mmap_idx]) {
+			munmap(mmaps[st->mmap_idx], st->mmap_size);
+			mmaps[st->mmap_idx] = NULL;
 		}
 
-		page_offset = page_size * (head / page_size);
-		file_offset += page_offset;
-		head -= page_offset;
+		page_offset = page_size * (st->head / page_size);
+		st->file_offset += page_offset;
+		st->head -= page_offset;
 		goto remap;
 	}
 
@@ -2249,9 +2261,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	skip = -EINVAL;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
+	    (skip = rd->process(session, event, st->file_pos, rd->path)) < 0) {
 		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
-		       file_offset + head, rd->path, event->header.size,
+		       st->file_offset + st->head, rd->path, event->header.size,
 		       event->header.type, strerror(-skip));
 		err = skip;
 		goto out;
@@ -2260,8 +2272,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
-	head += size;
-	file_pos += size;
+	st->head += size;
+	st->file_pos += size;
 
 	err = __perf_session__process_decomp_events(session);
 	if (err)
@@ -2272,7 +2284,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (file_pos < data_size)
+	if (st->file_pos < st->data_size)
 		goto more;
 
 out:
-- 
2.19.0

