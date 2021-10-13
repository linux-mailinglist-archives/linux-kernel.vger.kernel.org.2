Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3151642BB22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhJMJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:48244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239006AbhJMJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290877029"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290877029"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460706035"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:07:18 -0700
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
Subject: [PATCH v4 7/8] perf session: Introduce reader return codes
Date:   Wed, 13 Oct 2021 12:06:41 +0300
Message-Id: <5fca481e91c3c5d2ba033d4c6e9b969f8033ab0f.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding reader READER_OK and READER_NODATA return codes to make
the code more clear.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 68d130fe51c2..9714881839e3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2258,12 +2258,17 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	return 0;
 }
 
+enum {
+	READER_OK,
+	READER_NODATA,
+};
+
 static int
 reader__read_event(struct reader *rd, struct perf_session *session,
 		   struct ui_progress *prog)
 {
 	u64 size;
-	int err = 0;
+	int err = READER_OK;
 	union perf_event *event;
 	s64 skip;
 
@@ -2273,7 +2278,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 		return PTR_ERR(event);
 
 	if (!event)
-		return 1;
+		return READER_NODATA;
 
 	size = event->header.size;
 
@@ -2325,7 +2330,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	err = reader__read_event(rd, session, prog);
 	if (err < 0)
 		goto out;
-	else if (err == 1)
+	else if (err == READER_NODATA)
 		goto remap;
 
 	if (session_done())
-- 
2.19.0

