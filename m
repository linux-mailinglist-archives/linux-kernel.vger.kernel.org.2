Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E604442BB24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhJMJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:09:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:48251 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235203AbhJMJJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:09:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290877037"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290877037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="460706044"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2021 02:07:21 -0700
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
Subject: [PATCH v4 8/8] perf session: Introduce reader EOF function
Date:   Wed, 13 Oct 2021 12:06:42 +0300
Message-Id: <b3b0e0904da01f9ec84d4ae9368df99ecd231598.1634113027.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1634113027.git.alexey.v.bayduraev@linux.intel.com>
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
index 9714881839e3..bca92ba7218a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2309,6 +2309,12 @@ reader__read_event(struct reader *rd, struct perf_session *session,
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

