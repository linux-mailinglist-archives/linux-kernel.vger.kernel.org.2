Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9143EE869
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhHQIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:24:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:11537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239196AbhHQIYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:24:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="279763232"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="279763232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 01:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="471080270"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2021 01:23:57 -0700
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
Subject: [PATCH v11 09/24] perf record: Introduce bytes written stats to support --max-size option
Date:   Tue, 17 Aug 2021 11:23:12 +0300
Message-Id: <c5c886094b1657328c7ec030da140b329282ebb7.1629186429.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a function to calculate the total amount of data written
and using it to support the --max-size option.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 30 +++++++++++++++++++++++++++---
 tools/perf/util/mmap.h      |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index eff6f8db60b2..cb155f1ba979 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -186,10 +186,28 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static u64 record__bytes_written(struct record *rec)
+{
+	int t, tm;
+	struct record_thread *thread_data = rec->thread_data;
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
@@ -205,15 +223,21 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 		return -1;
 	}
 
-	rec->bytes_written += size;
+	if (map && map->file)
+		map->bytes_written += size;
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
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index c4aed6e89549..67d41003d82e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -46,6 +46,7 @@ struct mmap {
 	int		comp_level;
 	struct perf_data_file *file;
 	struct zstd_data      zstd_data;
+	u64		      bytes_written;
 };
 
 struct mmap_params {
-- 
2.19.0

