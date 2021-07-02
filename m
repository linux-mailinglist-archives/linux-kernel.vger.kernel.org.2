Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25183BA07B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhGBMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:35:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:32627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhGBMfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:35:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="189107261"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="189107261"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="642660268"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2021 05:33:07 -0700
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
Subject: [PATCH v9 11/24] perf record: Init data file at mmap buffer object
Date:   Fri,  2 Jul 2021 15:32:19 +0300
Message-Id: <370ca676350c4cc41a38bc6b1179a8811e86fa7c.1625227739.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize data files located at mmap buffer objects so trace data
can be written into several data file located at data directory.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 41 ++++++++++++++++++++++++++++++-------
 tools/perf/util/record.h    |  1 +
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4d1571234ba2..ba3f60f7882a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -167,6 +167,11 @@ static inline pid_t gettid(void)
 }
 #endif
 
+static int record__threads_enabled(struct record *rec)
+{
+	return rec->opts.threads_spec;
+}
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -1146,7 +1151,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
-	int ret;
+	int i, ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -1185,6 +1190,18 @@ static int record__mmap_evlist(struct record *rec,
 	if (ret)
 		return ret;
 
+	if (record__threads_enabled(rec)) {
+		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
+		if (ret)
+			return ret;
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
+			if (evlist->mmap)
+				evlist->mmap[i].file = &rec->data.dir.files[i];
+			if (evlist->overwrite_mmap)
+				evlist->overwrite_mmap[i].file = &rec->data.dir.files[i];
+		}
+	}
+
 	return 0;
 }
 
@@ -1494,8 +1511,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
+	 *
+	 * No need for round events in directory mode,
+	 * because per-cpu maps and files have data
+	 * sorted by kernel.
 	 */
-	if (bytes_written != rec->bytes_written)
+	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
 		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
@@ -1611,7 +1632,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1622,15 +1645,21 @@ static void
 record__finish_output(struct record *rec)
 {
 	struct perf_data *data = &rec->data;
-	int fd = perf_data__fd(data);
+	int i, fd = perf_data__fd(data);
 
 	if (data->is_pipe)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	if (record__threads_enabled(rec)) {
+		for (i = 0; i < data->dir.nr; i++)
+			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
+	}
 
 	if (!rec->no_buildid) {
+		/* this will be recalculated during process_buildids() */
+		rec->samples = 0;
 		process_buildids(rec);
 
 		if (rec->buildid_all)
@@ -2576,8 +2605,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = err;
 
 	record__synthesize(rec, true);
-	/* this will be recalculated during process_buildids() */
-	rec->samples = 0;
 
 	if (!err) {
 		if (!rec->timestamp_filename) {
@@ -3378,7 +3405,7 @@ int cmd_record(int argc, const char **argv)
 		goto out_opts;
 	}
 
-	if (rec->opts.kcore)
+	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
 	if (rec->opts.comp_level != 0) {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 68f471d9a88b..4d68b7e27272 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -77,6 +77,7 @@ struct record_opts {
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
+	int	      threads_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.19.0

