Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A26354EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhDFIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:47:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:18132 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhDFIrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:47:15 -0400
IronPort-SDR: zxBlNSdFcyAzPCbLdkJRlFf3kIoxG6H8aPVVj+wiiQlCQ9J3U1u/8i4S4CqpUBkQu3C0LH8J6m
 78EJNDnP7yqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="190852447"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="190852447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:47:08 -0700
IronPort-SDR: 6M4IzRU6FK0O5TF+2Mb8SDh7Q/UZhn354fl70noQzigSUhAdNoT6hXoJL47lPDRpvfhPKscYTn
 bT3vOwKqAZDg==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421122470"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:47:05 -0700
Subject: [PATCH v4 06/12] perf record: introduce data file at mmap buffer
 object
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
Organization: Intel Corporation
Message-ID: <f52da8db-beb8-ec63-56aa-ce6def088951@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:47:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce data file and compressor objects into mmap object so
they could be used to process and store data stream from the
corresponding kernel data buffer. Introduce bytes_transferred
and bytes_compressed stats so they would capture statistics for
the related data buffer transfers. Make use of the introduced
per mmap file, compressor and stats when they are initialized
and available.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
 tools/perf/util/mmap.c      |  6 ++++
 tools/perf/util/mmap.h      |  6 ++++
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 339198b2e37d..3947c60d905b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -188,11 +188,19 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 {
 	struct perf_data_file *file = &rec->session->data->file;
 
+	if (map && map->file)
+		file = map->file;
+
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
 	}
 
+	if (map && map->file) {
+		map->bytes_written += size;
+		return 0;
+	}
+
 	rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
@@ -210,8 +218,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 static int record__aio_enabled(struct record *rec);
 static int record__comp_enabled(struct record *rec);
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
-			    void *src, size_t src_size);
+static size_t zstd_compress(struct zstd_data *data,
+			    void *dst, size_t dst_size, void *src, size_t src_size);
 
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
@@ -345,9 +353,13 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
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
@@ -572,8 +584,22 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
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
@@ -1297,18 +1323,15 @@ static size_t process_comp_header(void *record, size_t increment)
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
 
@@ -1961,8 +1984,9 @@ static int record__start_threads(struct record *rec)
 
 static int record__stop_threads(struct record *rec, unsigned long *waking)
 {
-	int t;
+	int t, tm;
 	struct thread_data *thread_data = rec->thread_data;
+	u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
 
 	for (t = 1; t < rec->nr_threads; t++)
 		record__terminate_thread(&thread_data[t]);
@@ -1970,9 +1994,23 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
 	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
 		*waking += thread_data[t].waking;
-		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
+		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
+			if (thread_data[t].maps) {
+				bytes_transferred += thread_data[t].maps[tm]->bytes_transferred;
+				bytes_compressed += thread_data[t].maps[tm]->bytes_compressed;
+				bytes_written += thread_data[t].maps[tm]->bytes_written;
+			}
+			if (thread_data[t].overwrite_maps) {
+				bytes_transferred += thread_data[t].overwrite_maps[tm]->bytes_transferred;
+				bytes_compressed += thread_data[t].overwrite_maps[tm]->bytes_compressed;
+				bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
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
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428..a2c5e4237592 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
 
+	zstd_fini(&map->zstd_data);
+
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
@@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	map->core.flush = mp->flush;
 
 	map->comp_level = mp->comp_level;
+	if (zstd_init(&map->zstd_data, map->comp_level)) {
+		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
+		return -1;
+	}
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9d5f589f02ae..c04ca4b5adf5 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -13,6 +13,7 @@
 #endif
 #include "auxtrace.h"
 #include "event.h"
+#include "util/compress.h"
 
 struct aiocb;
 
@@ -43,6 +44,11 @@ struct mmap {
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
+	struct perf_data_file *file;
+	struct zstd_data      zstd_data;
+	u64		      bytes_transferred;
+	u64		      bytes_compressed;
+	u64		      bytes_written;
 };
 
 struct mmap_params {
-- 
2.19.0


