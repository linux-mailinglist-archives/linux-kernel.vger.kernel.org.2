Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C181B372641
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhEDHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:37660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhEDHHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:18 -0400
IronPort-SDR: fm0k9Mcb0OpvnABFmaHWk1OUZZobdr5Dx8xhF3y9KI4Efz39f1L0RzszSNkx4yu7Dyh+sH4C8M
 EebFHkbLnJlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197971032"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197971032"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:06:16 -0700
IronPort-SDR: ETVj0vz9mkMZBPUm0qzID18/mYq7zII3k5S5+JBc1s+aKm6cn9DVtgBV+gf0o9pBy7zPwK140a
 iNZH5p/a+AiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895726"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:06:02 -0700
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
Subject: [PATCH v5 14/20] perf session: introduce reader_state in reader object
Date:   Tue,  4 May 2021 10:04:49 +0300
Message-Id: <ec2cf935f980bab130dbdc39d4cc4673b67f6805.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 74 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a4d225e0569c..054f4d04eea9 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -55,12 +55,24 @@ typedef s64 (*reader_cb_t)(struct perf_session *session,
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
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
+	struct reader_state state;
 };
 
 #ifdef HAVE_ZSTD_SUPPORT
@@ -2174,29 +2186,28 @@ static int
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
@@ -2206,35 +2217,36 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
 
@@ -2243,9 +2255,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
@@ -2254,8 +2266,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
-	head += size;
-	file_pos += size;
+	st->head += size;
+	st->file_pos += size;
 
 	err = __perf_session__process_decomp_events(session);
 	if (err)
@@ -2266,7 +2278,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (file_pos < data_size)
+	if (st->file_pos < st->data_size)
 		goto more;
 
 out:
-- 
2.19.0

