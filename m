Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1570942235D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhJEK3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:29:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:46740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234002AbhJEK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:29:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225603024"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225603024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714164513"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 03:27:16 -0700
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
Subject: [PATCH v2 3/5] perf session: Move init/exit code to separate functions
Date:   Tue,  5 Oct 2021 13:27:00 +0300
Message-Id: <62fe2c88cf00300c8e27d7056e6640a7db0aff7a.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating init/exit code into reader__init and reader__exit functions.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 50f2ec523ae0..53cd7a3b5efd 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2190,28 +2190,23 @@ struct reader {
 };
 
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
@@ -2220,6 +2215,27 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		return -1;
 	rd->decomp_data.zstd_decomp = &rd->zstd_data;
 
+	return 0;
+}
+
+static void
+reader__exit(struct reader *rd)
+{
+	perf_decomp__release_events(rd->decomp_data.decomp);
+	zstd_fini(&rd->zstd_data);
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
 
@@ -2297,8 +2313,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 out:
 	session->active_decomp = &session->decomp_data;
-	perf_decomp__release_events(rd->decomp_data.decomp);
-	zstd_fini(&rd->zstd_data);
 	return err;
 }
 
@@ -2330,6 +2344,9 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
 
+	err = reader__init(&rd, &session->one_mmap);
+	if (err)
+		goto out_err;
 	err = reader__process_events(&rd, session, &prog);
 	if (err)
 		goto out_err;
@@ -2352,6 +2369,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	ordered_events__reinit(&session->ordered_events);
 	auxtrace__free_events(session);
 	session->one_mmap = false;
+	reader__exit(&rd);
 	return err;
 }
 
-- 
2.19.0

