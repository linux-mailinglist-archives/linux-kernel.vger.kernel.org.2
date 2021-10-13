Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92EA42BB21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhJMJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:48244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238895AbhJMJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290877026"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290877026"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460706033"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:07:15 -0700
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
Subject: [PATCH v4 6/8] perf session: Move event read code to separate function
Date:   Wed, 13 Oct 2021 12:06:40 +0300
Message-Id: <ffe570d937138dd24f282978ce7ed9c46a06ff9b.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating reading code of single event into reader__read_event
function.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 46 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d7b008837fd6..68d130fe51c2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2259,33 +2259,21 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 }
 
 static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
+reader__read_event(struct reader *rd, struct perf_session *session,
+		   struct ui_progress *prog)
 {
 	u64 size;
 	int err = 0;
 	union perf_event *event;
 	s64 skip;
 
-	err = reader__init(rd, &session->one_mmap);
-	if (err)
-		goto out;
-
-	session->active_decomp = &rd->decomp_data;
-
-remap:
-	err = reader__mmap(rd, session);
-	if (err)
-		goto out;
-
-more:
 	event = fetch_mmaped_event(rd->head, rd->mmap_size, rd->mmap_cur,
 				   session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
 	if (!event)
-		goto remap;
+		return 1;
 
 	size = event->header.size;
 
@@ -2312,6 +2300,34 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	ui_progress__update(prog, size);
 
+out:
+	return err;
+}
+
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
+{
+	int err;
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
+more:
+	err = reader__read_event(rd, session, prog);
+	if (err < 0)
+		goto out;
+	else if (err == 1)
+		goto remap;
+
 	if (session_done())
 		goto out;
 
-- 
2.19.0

