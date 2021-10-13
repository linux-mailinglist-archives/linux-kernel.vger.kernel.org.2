Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7174C42BB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhJMJJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:55079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239015AbhJMJJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227281672"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="227281672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460705963"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:06:58 -0700
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
Subject: [PATCH v4 3/8] perf session: Move init/release code to separate functions
Date:   Wed, 13 Oct 2021 12:06:37 +0300
Message-Id: <8bacf247de220be8e57af1d2b796322175f5e257.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating init/release code into reader__init and reader__release_decomp
functions. Removing a duplicate call to ui_progress__init_size, the same
call can be found in __perf_session__process_events. For multiple traces
ui_progress should be initialized by total size before reader__init calls.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ff09869ab075..396f8279757e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2184,28 +2184,23 @@ struct reader {
 };
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__init(struct reader *rd, bool *one_mmap)
 {
 	u64 data_size = rd->data_size;
-	u64 page_offset, size;
-	int err = 0, mmap_prot, mmap_flags;
-	char *buf, **mmaps = rd->mmaps;
-	union perf_event *event;
-	s64 skip;
+	u64 page_offset;
+	char **mmaps = rd->mmaps;
 
 	page_offset = page_size * (rd->data_offset / page_size);
 	rd->file_offset = page_offset;
 	rd->head = rd->data_offset - page_offset;
 
-	ui_progress__init_size(prog, data_size, "Processing events...");
-
 	data_size += rd->data_offset;
 
 	rd->mmap_size = MMAP_SIZE;
 	if (rd->mmap_size > data_size) {
 		rd->mmap_size = data_size;
-		session->one_mmap = true;
+		if (one_mmap)
+			*one_mmap = true;
 	}
 
 	memset(mmaps, 0, sizeof(rd->mmaps));
@@ -2213,6 +2208,31 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (zstd_init(&rd->zstd_data, 0))
 		return -1;
 	rd->decomp_data.zstd_decomp = &rd->zstd_data;
+
+	return 0;
+}
+
+static void
+reader__release_decomp(struct reader *rd)
+{
+	perf_decomp__release_events(rd->decomp_data.decomp);
+	zstd_fini(&rd->zstd_data);
+}
+
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
+{
+	u64 page_offset, size;
+	int err = 0, mmap_prot, mmap_flags;
+	char *buf, **mmaps = rd->mmaps;
+	union perf_event *event;
+	s64 skip;
+
+	err = reader__init(rd, &session->one_mmap);
+	if (err)
+		goto out;
+
 	session->active_decomp = &rd->decomp_data;
 
 	mmap_prot  = PROT_READ;
@@ -2286,7 +2306,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (rd->file_pos < data_size)
+	if (rd->file_pos < rd->data_size + rd->data_offset)
 		goto more;
 
 out:
@@ -2343,8 +2363,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	 */
 	ordered_events__reinit(&session->ordered_events);
 	auxtrace__free_events(session);
-	perf_decomp__release_events(rd.decomp_data.decomp);
-	zstd_fini(&rd.zstd_data);
+	reader__release_decomp(&rd);
 	session->one_mmap = false;
 	return err;
 }
-- 
2.19.0

