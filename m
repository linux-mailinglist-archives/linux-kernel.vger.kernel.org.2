Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D473C4DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbhGLHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:15:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:25899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240108AbhGLGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209973432"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209973432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916390"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:41 -0700
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
Subject: [PATCH v10 21/24] perf session: Move init into reader__init function
Date:   Mon, 12 Jul 2021 09:46:21 +0300
Message-Id: <68c2f137a3e5ba6c8e4cca8248911a5bbfc513d4.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating initialization code into reader__init function.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2a0d3b3fd979..f25f5f33bec1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2214,28 +2214,25 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 }
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__init(struct reader *rd, bool *one_mmap)
 {
 	struct reader_state *st = &rd->state;
-	u64 page_offset, size;
-	int err = 0, mmap_prot, mmap_flags;
-	char *buf, **mmaps = st->mmaps;
-	union perf_event *event;
-	s64 skip;
+	u64 page_offset;
+	char **mmaps = st->mmaps;
+
+	pr_debug("reader processing %s\n", rd->path);
 
 	page_offset = page_size * (rd->data_offset / page_size);
 	st->file_offset = page_offset;
 	st->head = rd->data_offset - page_offset;
 
-	ui_progress__init_size(prog, rd->data_size, "Processing events...");
-
 	st->data_size = rd->data_size + rd->data_offset;
 
 	st->mmap_size = MMAP_SIZE;
 	if (st->mmap_size > st->data_size) {
 		st->mmap_size = st->data_size;
-		session->one_mmap = true;
+		if (one_mmap)
+			*one_mmap = true;
 	}
 
 	memset(mmaps, 0, sizeof(st->mmaps));
@@ -2243,6 +2240,20 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (zstd_init(&rd->zstd_data, 0))
 		return -1;
 
+	return 0;
+}
+
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
+{
+	struct reader_state *st = &rd->state;
+	u64 page_offset, size;
+	int err = 0, mmap_prot, mmap_flags;
+	char *buf, **mmaps = st->mmaps;
+	union perf_event *event;
+	s64 skip;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2358,6 +2369,9 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
 
+	err = reader__init(rd, &session->one_mmap);
+	if (err)
+		goto out_err;
 	err = reader__process_events(rd, session, &prog);
 	if (err)
 		goto out_err;
-- 
2.19.0

