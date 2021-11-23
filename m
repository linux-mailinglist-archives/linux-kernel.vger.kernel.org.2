Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C245A49D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhKWOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:12:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:59350 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237861AbhKWOMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:12:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="295833864"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="295833864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422554"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:09:01 -0800
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
Subject: [PATCH v12 09/16] perf record: Introduce bytes written stats
Date:   Tue, 23 Nov 2021 17:08:05 +0300
Message-Id: <b235542dee6bfaa8966dabf124ec4b7c0b2dc9f9.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a function to calculate the total amount of data written
and use it to support the --max-size option.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ce660691df1d..cd4f74c311e8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -108,6 +108,7 @@ struct record_thread {
 	struct record		*rec;
 	unsigned long long	samples;
 	unsigned long		waking;
+	u64			bytes_written;
 };
 
 static __thread struct record_thread *thread;
@@ -191,10 +192,22 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static u64 record__bytes_written(struct record *rec)
+{
+	int t;
+	u64 bytes_written = rec->bytes_written;
+	struct record_thread *thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		bytes_written += thread_data[t].bytes_written;
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
@@ -210,13 +223,15 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 		return -1;
 	}
 
-	if (!(map && map->file))
+	if (map && map->file)
+		thread->bytes_written += size;
+	else
 		rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
 		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
 				" stopping session ]\n",
-				rec->bytes_written >> 10);
+				record__bytes_written(rec) >> 10);
 		done = 1;
 	}
 
-- 
2.19.0

