Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62357372640
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEDHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:07:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:37661 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhEDHHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:07:18 -0400
IronPort-SDR: uBMqWYgR5kYLOujq30jmGXxUcvY8+EhZd33Jk5YV3XO1c/Mv0NDeBuOFu5EeirdItjICrlz+h7
 sASECSwKx2eg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197971031"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197971031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:06:16 -0700
IronPort-SDR: /twEElXSPwR6Hrr6PY+Em64rgrnV+USAP/cDA+YEUWo/0j/RzKAuARQbmltxJR7zzj5DKj56d+
 OCROL7xYDBGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895642"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:05:59 -0700
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
Subject: [PATCH v5 13/20] perf session: move reader structure to the top
Date:   Tue,  4 May 2021 10:04:48 +0300
Message-Id: <0b89a40e0200b1180e6dbfdb56694e3f8436e8fa.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving reader structure to the top of the file. This is necessary
for the further use of this structure in the decompressor.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 573bdb2f446b..a4d225e0569c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,6 +36,33 @@
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
+};
+
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
 						  union perf_event *event, u64 file_offset,
@@ -2143,33 +2170,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
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
-};
-
 static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
-- 
2.19.0

