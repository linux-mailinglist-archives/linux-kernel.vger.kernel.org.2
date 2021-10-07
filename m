Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC8425107
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhJGK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:28:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:3734 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240892AbhJGK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:28:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532657"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335463"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:25:54 -0700
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
Subject: [PATCH v3 3/8] perf session: Move init/release code to separate functions
Date:   Thu,  7 Oct 2021 13:25:38 +0300
Message-Id: <e3021f0d398380da0ff6cf9111534b249bc0b3bb.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
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
 tools/perf/util/session.c | 44 +++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c3930c49da7a..00417b0d29ec 100644
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
@@ -2214,6 +2209,30 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		return -1;
 	rd->decomp_data.zstd_decomp = &rd->zstd_data;
 
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
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2286,7 +2305,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (rd->file_pos < data_size)
+	if (rd->file_pos < rd->data_size + rd->data_offset)
 		goto more;
 
 out:
@@ -2343,8 +2362,7 @@ static int __perf_session__process_events(struct perf_session *session)
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

