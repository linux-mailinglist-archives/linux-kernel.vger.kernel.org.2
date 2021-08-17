Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23D3EE870
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhHQIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:25:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:18130 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239334AbhHQIYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:24:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214171931"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="214171931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 01:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="471080381"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2021 01:24:16 -0700
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
Subject: [PATCH v11 15/24] perf report: Output non-zero offset for decompressed records
Date:   Tue, 17 Aug 2021 11:23:18 +0300
Message-Id: <7d2a35f3087ae0df686655aec777981d15c27282.1629186429.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
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
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d2e27ff96030..0f4471c361e4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2107,7 +2107,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
 static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
-	u64 size, file_pos = 0;
+	u64 size;
 	struct decomp *decomp = session->decomp_last;
 
 	if (!decomp)
@@ -2123,7 +2123,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		size = event->header.size;
 
 		if (size < sizeof(struct perf_event_header) ||
-		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
 			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 				decomp->file_pos + decomp->head, event->header.size, event->header.type);
 			return -EINVAL;
-- 
2.19.0

