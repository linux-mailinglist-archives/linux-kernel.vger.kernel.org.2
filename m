Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38B39157F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhEZKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:55:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:1593 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhEZKzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:55:31 -0400
IronPort-SDR: r16bszrY6cJD4mCsth4rpu6lrnoTU3DDXbpd4eRAiF0taK8mgRH2gldxA3R1PAP7jFaPM+BRN6
 47btJ6gtLrcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189556477"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189556477"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 03:53:58 -0700
IronPort-SDR: 56d1KKqtAS8YCoEgMk4+sja0w1L4RLUKZl7sUzkJWcePi/kF/hL6U14PtLcLogtMPmDIJMYSNu
 MiNp08Krpxzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="436079342"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2021 03:53:55 -0700
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
Subject: [PATCH v6 13/20] perf session: Move reader structure to the top
Date:   Wed, 26 May 2021 13:53:06 +0300
Message-Id: <9686f087319de7d9f19505404ec26b804c91ee02.1622025774.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving reader structure to the top of the file. This is necessary
for the further use of this structure in the decompressor.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 09efd7c02400..6ba7da8c5daa 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,6 +36,34 @@
 #include "units.h"
 #include <internal/lib.h>
 
+/*
+ * On 64bit we can mmap the data file in one go. No need for tiny mmap
+ * slices. On 32bit we use 32MB.
+ */
+#if BITS_PER_LONG == 64
+#define MMAP_SIZE ULLONG_MAX
+#define NUM_MMAPS 1
+#else
+#define MMAP_SIZE (32 * 1024 * 1024ULL)
+#define NUM_MMAPS 128
+#endif
+
+struct reader;
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset,
+			   const char *file_path);
+
+struct reader {
+	int		 fd;
+	const char	 *path;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
+	bool		 in_place_update;
+};
+
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
 						  union perf_event *event, u64 file_offset,
@@ -2143,34 +2171,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	return 0;
 }
 
-/*
- * On 64bit we can mmap the data file in one go. No need for tiny mmap
- * slices. On 32bit we use 32MB.
- */
-#if BITS_PER_LONG == 64
-#define MMAP_SIZE ULLONG_MAX
-#define NUM_MMAPS 1
-#else
-#define MMAP_SIZE (32 * 1024 * 1024ULL)
-#define NUM_MMAPS 128
-#endif
-
-struct reader;
-
-typedef s64 (*reader_cb_t)(struct perf_session *session,
-			   union perf_event *event,
-			   u64 file_offset,
-			   const char *file_path);
-
-struct reader {
-	int		 fd;
-	const char	 *path;
-	u64		 data_size;
-	u64		 data_offset;
-	reader_cb_t	 process;
-	bool		 in_place_update;
-};
-
 static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
-- 
2.19.0

