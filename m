Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0D425108
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbhJGK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:28:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:3735 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240899AbhJGK2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:28:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532674"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335528"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:26:04 -0700
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
Subject: [PATCH v3 6/8] perf session: Move event read code to separate function
Date:   Thu,  7 Oct 2021 13:25:41 +0300
Message-Id: <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
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
 tools/perf/util/session.c | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6289fcafdc86..6b255b0b23e0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2259,31 +2259,21 @@ reader__mmap(struct reader *rd, struct perf_session *session)
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
 
 	session->active_decomp = &rd->decomp_data;
 	size = event->header.size;
@@ -2311,6 +2301,33 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	ui_progress__update(prog, size);
 
+out:
+	session->active_decomp = &session->decomp_data;
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
 
@@ -2318,7 +2335,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
-	session->active_decomp = &session->decomp_data;
 	return err;
 }
 
-- 
2.19.0

