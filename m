Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E13B8695
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhF3P6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:58:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:3999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235916AbhF3P6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:58:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230015652"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="230015652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="559099653"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2021 08:55:25 -0700
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
Subject: [PATCH v8 07/22] perf record: Introduce data transferred and compressed stats
Date:   Wed, 30 Jun 2021 18:54:46 +0300
Message-Id: <18fe4fd5ef47792cd31cabc07aafce642e6176ba.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bytes_transferred and bytes_compressed stats so they
would capture statistics for the related data buffer transfers.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
 tools/perf/util/mmap.h      |  3 ++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9b7e7a5dc116..f1a6edc0824c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -198,6 +198,11 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 		return -1;
 	}
 
+	if (map && map->file) {
+		map->bytes_written += size;
+		return 0;
+	}
+
 	rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
@@ -215,8 +220,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 static int record__aio_enabled(struct record *rec);
 static int record__comp_enabled(struct record *rec);
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
-			    void *src, size_t src_size);
+static size_t zstd_compress(struct zstd_data *data,
+			    void *dst, size_t dst_size, void *src, size_t src_size);
 
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
@@ -350,9 +355,13 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 */
 
 	if (record__comp_enabled(aio->rec)) {
-		size = zstd_compress(aio->rec->session, aio->data + aio->size,
-				     mmap__mmap_len(map) - aio->size,
+		struct zstd_data *zstd_data = &aio->rec->session->zstd_data;
+
+		aio->rec->session->bytes_transferred += size;
+		size = zstd_compress(zstd_data,
+				     aio->data + aio->size, mmap__mmap_len(map) - aio->size,
 				     buf, size);
+		aio->rec->session->bytes_compressed += size;
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
 	}
@@ -577,8 +586,22 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
+		struct zstd_data *zstd_data = &rec->session->zstd_data;
+
+		if (map->file) {
+			zstd_data = &map->zstd_data;
+			map->bytes_transferred += size;
+		} else {
+			rec->session->bytes_transferred += size;
+		}
+
+		size = zstd_compress(zstd_data, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
+
+		if (map->file)
+			map->bytes_compressed += size;
+		else
+			rec->session->bytes_compressed += size;
 	}
 
 	thread->samples++;
@@ -1311,18 +1334,15 @@ static size_t process_comp_header(void *record, size_t increment)
 	return size;
 }
 
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+static size_t zstd_compress(struct zstd_data *zstd_data, void *dst, size_t dst_size,
 			    void *src, size_t src_size)
 {
 	size_t compressed;
 	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
 
-	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
+	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
 
-	session->bytes_transferred += src_size;
-	session->bytes_compressed  += compressed;
-
 	return compressed;
 }
 
@@ -2006,8 +2026,10 @@ static int record__start_threads(struct record *rec)
 
 static int record__stop_threads(struct record *rec, unsigned long *waking)
 {
-	int t;
+	int t, tm;
+	struct mmap *map, *overwrite_map;
 	struct thread_data *thread_data = rec->thread_data;
+	u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
 
 	for (t = 1; t < rec->nr_threads; t++)
 		record__terminate_thread(&thread_data[t]);
@@ -2015,9 +2037,25 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
 	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
 		*waking += thread_data[t].waking;
-		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
+		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
+			if (thread_data[t].maps) {
+				map = thread_data[t].maps[tm];
+				bytes_transferred += map->bytes_transferred;
+				bytes_compressed += map->bytes_compressed;
+				bytes_written += map->bytes_written;
+			}
+			if (thread_data[t].overwrite_maps) {
+				overwrite_map = thread_data[t].overwrite_maps[tm];
+				bytes_transferred += overwrite_map->bytes_transferred;
+				bytes_compressed += overwrite_map->bytes_compressed;
+				bytes_written += overwrite_map->bytes_written;
+			}
+		}
+		rec->session->bytes_transferred += bytes_transferred;
+		rec->session->bytes_compressed += bytes_compressed;
+		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld, written=%ld\n",
 			 thread_data[t].tid, thread_data[t].samples, thread_data[t].waking,
-			 rec->session->bytes_transferred, rec->session->bytes_compressed);
+			 bytes_transferred, bytes_compressed, bytes_written);
 	}
 
 	return 0;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index c4aed6e89549..c04ca4b5adf5 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -46,6 +46,9 @@ struct mmap {
 	int		comp_level;
 	struct perf_data_file *file;
 	struct zstd_data      zstd_data;
+	u64		      bytes_transferred;
+	u64		      bytes_compressed;
+	u64		      bytes_written;
 };
 
 struct mmap_params {
-- 
2.19.0

