Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30FF42510B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhJGK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:28:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:3747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240919AbhJGK2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:28:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249532681"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="249532681"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 03:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="657335544"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 03:26:10 -0700
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
Subject: [PATCH v3 8/8] perf session: Introduce reader EOF function
Date:   Thu,  7 Oct 2021 13:25:43 +0300
Message-Id: <80d22da1e90cb6da0d014087351d4cb95675fc4b.1633596227.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a function to check end-of-file status.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d88c651ffd7..f74e153231fa 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2311,6 +2311,12 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	return err;
 }
 
+static inline bool
+reader__eof(struct reader *rd)
+{
+	return (rd->file_pos >= rd->data_size + rd->data_offset);
+}
+
 static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
@@ -2336,7 +2342,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	if (session_done())
 		goto out;
 
-	if (rd->file_pos < rd->data_size + rd->data_offset)
+	if (!reader__eof(rd))
 		goto more;
 
 out:
-- 
2.19.0

