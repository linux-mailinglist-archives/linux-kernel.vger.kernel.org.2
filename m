Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1746E3BA077
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGBMfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:35:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:3514 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhGBMfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:35:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230397115"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="230397115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="642660238"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2021 05:32:58 -0700
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
Subject: [PATCH v9 08/24] perf record: Introduce data file at mmap buffer object
Date:   Fri,  2 Jul 2021 15:32:16 +0300
Message-Id: <3c2a7ec01bbdf76b45fa68f51bb5bcb60e1129e8.1625227739.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
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
index 8be20d8f73fc..ac9bc1bbdff4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -197,6 +197,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
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

