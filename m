Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F07B425106
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhJGK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:28:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:3735 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240894AbhJGK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:28:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532664"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532664"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335479"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:25:57 -0700
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
Subject: [PATCH v3 4/8] perf session: Move map code to separate function
Date:   Thu,  7 Oct 2021 13:25:39 +0300
Message-Id: <7e4309ecdbb54fad42b75ae68e474b17a1f40b07.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
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
 tools/perf/util/session.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 00417b0d29ec..36faa2d598b2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2220,18 +2220,10 @@ reader__release_decomp(struct reader *rd)
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
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2242,13 +2234,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
@@ -2258,6 +2249,28 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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

