Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825633B8693
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhF3P6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:58:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:3990 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236005AbhF3P6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:58:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230015623"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="230015623"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="559099623"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2021 08:55:22 -0700
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
Subject: [PATCH v8 06/22] perf record: Introduce data file at mmap buffer object
Date:   Wed, 30 Jun 2021 18:54:45 +0300
Message-Id: <ace86f5d00ddb901a79196bb1863ed1395c408fd.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce data file and compressor objects into mmap object so
they could be used to process and store data stream from the
corresponding kernel data buffer. Make use of the introduced
per mmap file and compressor when they are initialized and
available.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 3 +++
 tools/perf/util/mmap.c      | 6 ++++++
 tools/perf/util/mmap.h      | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cead2b3c56d7..9b7e7a5dc116 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -190,6 +190,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 {
 	struct perf_data_file *file = &rec->session->data->file;
 
+	if (map && map->file)
+		file = map->file;
+
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
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
index 9d5f589f02ae..c4aed6e89549 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -13,6 +13,7 @@
 #endif
 #include "auxtrace.h"
 #include "event.h"
+#include "util/compress.h"
 
 struct aiocb;
 
@@ -43,6 +44,8 @@ struct mmap {
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
+	struct perf_data_file *file;
+	struct zstd_data      zstd_data;
 };
 
 struct mmap_params {
-- 
2.19.0

