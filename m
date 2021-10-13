Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDF42BB23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhJMJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:48249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239008AbhJMJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290877023"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290877023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460706030"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:07:10 -0700
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
Subject: [PATCH v4 5/8] perf session: Move unmap code to reader__mmap
Date:   Wed, 13 Oct 2021 12:06:39 +0300
Message-Id: <f1c5e17cfa1ecfe912d10b411be203b55d148bc7.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving unmapping code into reader__mmap, so the mmap code
is located together. Moving head/file_offset computation into
reader__mmap function, so all the offset computation is
located together and in one place only.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 50258319bb26..d7b008837fd6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2187,13 +2187,9 @@ static int
 reader__init(struct reader *rd, bool *one_mmap)
 {
 	u64 data_size = rd->data_size;
-	u64 page_offset;
 	char **mmaps = rd->mmaps;
 
-	page_offset = page_size * (rd->data_offset / page_size);
-	rd->file_offset = page_offset;
-	rd->head = rd->data_offset - page_offset;
-
+	rd->head = rd->data_offset;
 	data_size += rd->data_offset;
 
 	rd->mmap_size = MMAP_SIZE;
@@ -2224,6 +2220,7 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 {
 	int mmap_prot, mmap_flags;
 	char *buf, **mmaps = rd->mmaps;
+	u64 page_offset;
 
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
@@ -2235,6 +2232,15 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 
+	if (mmaps[rd->mmap_idx]) {
+		munmap(mmaps[rd->mmap_idx], rd->mmap_size);
+		mmaps[rd->mmap_idx] = NULL;
+	}
+
+	page_offset = page_size * (rd->head / page_size);
+	rd->file_offset += page_offset;
+	rd->head -= page_offset;
+
 	buf = mmap(NULL, rd->mmap_size, mmap_prot, mmap_flags, rd->fd,
 		   rd->file_offset);
 	if (buf == MAP_FAILED) {
@@ -2256,9 +2262,8 @@ static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
 {
-	u64 page_offset, size;
+	u64 size;
 	int err = 0;
-	char **mmaps = rd->mmaps;
 	union perf_event *event;
 	s64 skip;
 
@@ -2279,17 +2284,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-	if (!event) {
-		if (mmaps[rd->mmap_idx]) {
-			munmap(mmaps[rd->mmap_idx], rd->mmap_size);
-			mmaps[rd->mmap_idx] = NULL;
-		}
-
-		page_offset = page_size * (rd->head / page_size);
-		rd->file_offset += page_offset;
-		rd->head -= page_offset;
+	if (!event)
 		goto remap;
-	}
 
 	size = event->header.size;
 
-- 
2.19.0

