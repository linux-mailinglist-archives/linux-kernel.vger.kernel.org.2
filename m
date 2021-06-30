Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032A93B86B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhF3QCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:02:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:4080 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236159AbhF3QBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:01:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230016105"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="230016105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="559099907"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2021 08:56:14 -0700
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
Subject: [PATCH v8 22/22] perf record: Introduce record__bytes_written and fix --max-size option
Date:   Wed, 30 Jun 2021 18:55:01 +0300
Message-Id: <7fb2b3abe92f1ab91e790ce1885eb5a3de4bab87.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a function to calculate the total amount of data transferred
and using it to fix the --max-size option.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c5954cb3e787..16a81d8a840a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -199,10 +199,28 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static u64 record__bytes_written(struct record *rec)
+{
+	int t, tm;
+	struct thread_data *thread_data = rec->thread_data;
+	u64 bytes_written = rec->bytes_written;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
+			if (thread_data[t].maps)
+				bytes_written += thread_data[t].maps[tm]->bytes_written;
+			if (thread_data[t].overwrite_maps)
+				bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
+		}
+	}
+
+	return bytes_written;
+}
+
 static bool record__output_max_size_exceeded(struct record *rec)
 {
 	return rec->output_max_size &&
-	       (rec->bytes_written >= rec->output_max_size);
+	       (record__bytes_written(rec) >= rec->output_max_size);
 }
 
 static int record__write(struct record *rec, struct mmap *map __maybe_unused,
@@ -218,20 +236,21 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 		return -1;
 	}
 
-	if (map && map->file) {
+	if (map && map->file)
 		map->bytes_written += size;
-		return 0;
-	}
-
-	rec->bytes_written += size;
+	else
+		rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
 		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
 				" stopping session ]\n",
-				rec->bytes_written >> 10);
+				record__bytes_written(rec) >> 10);
 		done = 1;
 	}
 
+	if (map && map->file)
+		return 0;
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
-- 
2.19.0

