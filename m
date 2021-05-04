Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B384F372644
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhEDHHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:37661 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhEDHHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:24 -0400
IronPort-SDR: mhal7IoFPOBhJCwl1i92sgBBXLbbl+D/+IaHHKSKOfoz74kNImI7OF21qKxytCrbttJ+UHd5qd
 pAi6g8aMolSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197971035"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197971035"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:06:18 -0700
IronPort-SDR: 1J5YtLS4f0oS4pvKBX248SnNH+3Wba/83+6pdPLJJuS4FRij8LCxUa39SCwQt4CLxH4YHZVtWu
 7LWKL+i4nPOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895737"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:06:11 -0700
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
Subject: [PATCH v5 17/20] perf session: move init into reader__init function
Date:   Tue,  4 May 2021 10:04:52 +0300
Message-Id: <753d1244e8d3151075adbea5f7d0d9c4000b34cc.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
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
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 81214052b2e3..08447376fa92 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2207,28 +2207,25 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
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
@@ -2236,6 +2233,20 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
 
@@ -2348,6 +2359,9 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
 
+	err = reader__init(rd, &session->one_mmap);
+	if (err)
+		goto out_err;
 	err = reader__process_events(rd, session, &prog);
 	if (err)
 		goto out_err;
-- 
2.19.0

