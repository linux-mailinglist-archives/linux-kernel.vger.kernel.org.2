Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7050537263D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEDHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:18742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhEDHHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:14 -0400
IronPort-SDR: Ffcar/PtFEPBNUsEbcCplT6qiVHNp5kWRDGBcjM6wiwHvUbZOvFfFt2fVyDDdSl7GoPsO0dZnO
 syCQN7pkZaJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="195865964"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="195865964"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:06:18 -0700
IronPort-SDR: aUpzPBEcj5jPyKMVMiAxwgiTgeZUDU9IgcCzRuq9s6i4EhWtQjWMrX7JpdziOpKu8RFnNOe4ze
 iWKTs9cSWUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895743"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:06:15 -0700
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
Subject: [PATCH v5 18/20] perf session: move map/unmap into reader__mmap function
Date:   Tue,  4 May 2021 10:04:53 +0300
Message-Id: <7ef4b029fa1bf0bd3e45494df7181b9568abf4d0.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mapping and unmapping code into reader__mmap, so the mmap
code is located together. Moving head/file_offset computation into
reader__mmap function, so all the offset computation is located
together and in one place only.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 60 +++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 08447376fa92..5bb3babeeb94 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2210,14 +2210,11 @@ static int
 reader__init(struct reader *rd, bool *one_mmap)
 {
 	struct reader_state *st = &rd->state;
-	u64 page_offset;
 	char **mmaps = st->mmaps;
 
 	pr_debug("reader processing %s\n", rd->path);
 
-	page_offset = page_size * (rd->data_offset / page_size);
-	st->file_offset = page_offset;
-	st->head = rd->data_offset - page_offset;
+	st->head = rd->data_offset;
 
 	st->data_size = rd->data_size + rd->data_offset;
 
@@ -2237,15 +2234,12 @@ reader__init(struct reader *rd, bool *one_mmap)
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
@@ -2254,20 +2248,45 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
@@ -2276,17 +2295,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
 
 	session->active_reader = rd;
 	size = event->header.size;
-- 
2.19.0

