Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B542510A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbhJGK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:28:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:3747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240904AbhJGK2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:28:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532677"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335536"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:26:07 -0700
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
Subject: [PATCH v3 7/8] perf session: Introduce reader return codes
Date:   Thu,  7 Oct 2021 13:25:42 +0300
Message-Id: <73fff3497e39c90ae9c517d00782d99c842748db.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
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
index 6b255b0b23e0..7d88c651ffd7 100644
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
 
 	session->active_decomp = &rd->decomp_data;
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

