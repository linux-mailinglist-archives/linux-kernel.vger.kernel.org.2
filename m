Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8B3C4D37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbhGLHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:12:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:25894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239996AbhGLGub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209973415"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209973415"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916299"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:22 -0700
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
Subject: [PATCH v10 15/24] perf report: Output non-zero offset for decompressed records
Date:   Mon, 12 Jul 2021 09:46:15 +0300
Message-Id: <169ba9534c2de573713664fa8799c09414eba047.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print offset of PERF_RECORD_COMPRESSED record instead of zero for
decompressed records in raw trace dump (-D option of perf-report):

0x17cf08 [0x28]: event: 9

instead of:

0 [0x28]: event: 9

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9c929a39973..d5c29d903274 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2105,7 +2105,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
 static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
-	u64 size, file_pos = 0;
+	u64 size;
 	struct decomp *decomp = session->decomp_last;
 
 	if (!decomp)
@@ -2121,7 +2121,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		size = event->header.size;
 
 		if (size < sizeof(struct perf_event_header) ||
-		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
 			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 				decomp->file_pos + decomp->head, event->header.size, event->header.type);
 			return -EINVAL;
-- 
2.19.0

