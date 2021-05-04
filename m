Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33B7372634
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhEDHGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:06:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:41320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhEDHGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:06:30 -0400
IronPort-SDR: FBxF+zwr3Di0pFY90kuwtY2zNGqpdAETXJ1WTKPL1IbumKQuEUTIZnsaaRJCutABTMTe4vgNs4
 yoVo7Pw3ziOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194779409"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="194779409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 00:05:36 -0700
IronPort-SDR: 9GwNLvPUxQCKsuWGggXg30uf1ts0ML/nsQ2Jd/NTz4F85Ejm9GXj3QHgvugKuX+Urc2NrNgZEH
 7h2Pd+8+bLnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450895416"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 00:05:31 -0700
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
Subject: [PATCH v5 07/20] perf record: introduce data transferred and compressed stats
Date:   Tue,  4 May 2021 10:04:42 +0300
Message-Id: <38f10168eac1c188c5f791bf7d05079d60ee6ab5.1619781188.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bytes_transferred and bytes_compressed stats so they
would capture statistics for the related data buffer transfers.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
 tools/perf/util/mmap.h      |  3 ++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b0ca61f1d265..75cebec57357 100644
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
@@ -1305,18 +1328,15 @@ static size_t process_comp_header(void *record, size_t increment)
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
 
@@ -1997,8 +2017,10 @@ static int record__start_threads(struct record *rec)
 
 static int record__stop_threads(struct record *rec, unsigned long *waking)
 {
-	int t;
+	int t, tm;
+	struct mmap *map, *overwrite_map;
 	struct thread_data *thread_data = rec->thread_data;
+	u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
 
 	for (t = 1; t < rec->nr_threads; t++)
 		record__terminate_thread(&thread_data[t]);
@@ -2006,9 +2028,25 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
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

