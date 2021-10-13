Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6B42BB20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbhJMJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:48244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235203AbhJMJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290877020"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290877020"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460706000"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:07:03 -0700
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
Subject: [PATCH v4 4/8] perf session: Move map code to separate function
Date:   Wed, 13 Oct 2021 12:06:38 +0300
Message-Id: <e445de5bb85bbd91287986802d6ed0ce1b419b5a.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mapping code into separate reader__mmap function.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 43 +++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 396f8279757e..50258319bb26 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2220,20 +2220,10 @@ reader__release_decomp(struct reader *rd)
 }
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__mmap(struct reader *rd, struct perf_session *session)
 {
-	u64 page_offset, size;
-	int err = 0, mmap_prot, mmap_flags;
+	int mmap_prot, mmap_flags;
 	char *buf, **mmaps = rd->mmaps;
-	union perf_event *event;
-	s64 skip;
-
-	err = reader__init(rd, &session->one_mmap);
-	if (err)
-		goto out;
-
-	session->active_decomp = &rd->decomp_data;
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2244,13 +2234,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		mmap_prot  |= PROT_WRITE;
 		mmap_flags = MAP_PRIVATE;
 	}
-remap:
+
 	buf = mmap(NULL, rd->mmap_size, mmap_prot, mmap_flags, rd->fd,
 		   rd->file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
-		err = -errno;
-		goto out;
+		return -errno;
 	}
 	mmaps[rd->mmap_idx] = rd->mmap_cur = buf;
 	rd->mmap_idx = (rd->mmap_idx + 1) & (ARRAY_SIZE(rd->mmaps) - 1);
@@ -2260,6 +2249,30 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		session->one_mmap_offset = rd->file_offset;
 	}
 
+	return 0;
+}
+
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
+{
+	u64 page_offset, size;
+	int err = 0;
+	char **mmaps = rd->mmaps;
+	union perf_event *event;
+	s64 skip;
+
+	err = reader__init(rd, &session->one_mmap);
+	if (err)
+		goto out;
+
+	session->active_decomp = &rd->decomp_data;
+
+remap:
+	err = reader__mmap(rd, session);
+	if (err)
+		goto out;
+
 more:
 	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
 				   session->header.needs_swap);
-- 
2.19.0

