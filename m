Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5A41C0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbhI2Inz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:43:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:13702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244582AbhI2Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:43:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288550391"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="288550391"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 01:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="520757372"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2021 01:42:08 -0700
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
Subject: [PATCH 4/6] perf session: Move init/exit into reader__init/reader__exit functions
Date:   Wed, 29 Sep 2021 11:41:52 +0300
Message-Id: <6445b7cd6eeca98ceb287df5b6b41b5817d7f379.1632900802.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating init/exit code into reader__init and reader__exit function.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3bea0830b3b8..85142d2a9a5a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2203,28 +2203,23 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
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
@@ -2232,6 +2227,27 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (zstd_init(&rd->zstd_data, 0))
 		return -1;
 
+	return 0;
+}
+
+static void
+reader__exit(struct reader *rd)
+{
+	perf_decomp__release_events(rd->decomp);
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
 
@@ -2309,8 +2325,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 out:
 	session->active_reader = NULL;
-	perf_decomp__release_events(rd->decomp);
-	zstd_fini(&rd->zstd_data);
 	return err;
 }
 
@@ -2342,6 +2356,9 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
 
+	err = reader__init(&rd, &session->one_mmap);
+	if (err)
+		goto out_err;
 	err = reader__process_events(&rd, session, &prog);
 	if (err)
 		goto out_err;
@@ -2364,6 +2381,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	ordered_events__reinit(&session->ordered_events);
 	auxtrace__free_events(session);
 	session->one_mmap = false;
+	reader__exit(&rd);
 	return err;
 }
 
-- 
2.19.0

