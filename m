Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCEE3AFF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFVIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:45:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:57595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhFVIpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:45:14 -0400
IronPort-SDR: yDl1/wIjJQIEh7H3zB8HSW7jTpX/F9rwmMVCfwuFrJ3D3obX2KQvUG5YKGG/9T7m52Z0YC1ZyW
 zsy0XLjwVhkw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292641565"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292641565"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:42:58 -0700
IronPort-SDR: D18rjCsHIdTQn4PHLi3GSow2jkYTyqzp1nqqiQg7TI/7XWyq7T7navPStt6rvei/fyxre0v9lk
 QSVE+mPOzMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="417332548"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2021 01:42:55 -0700
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
Subject: [PATCH v7 08/20] perf record: Init data file at mmap buffer object
Date:   Tue, 22 Jun 2021 11:42:17 +0300
Message-Id: <a2a5c32e85f660b6a989fd01dddc7bdee0cd6168.1624350588.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize data files located at mmap buffer objects so trace data
can be written into several data file located at data directory.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 41 ++++++++++++++++++++++++++++++-------
 tools/perf/util/record.h    |  1 +
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c9fd31211600..1b6716778650 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -160,6 +160,11 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int record__threads_enabled(struct record *rec)
+{
+	return rec->opts.threads_spec;
+}
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -1070,7 +1075,7 @@ static void record__free_thread_data(struct record *rec)
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
-	int ret;
+	int i, ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -1109,6 +1114,18 @@ static int record__mmap_evlist(struct record *rec,
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
 
@@ -1416,8 +1433,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
@@ -1532,7 +1553,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1543,15 +1566,21 @@ static void
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
@@ -2489,8 +2518,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = err;
 
 	record__synthesize(rec, true);
-	/* this will be recalculated during process_buildids() */
-	rec->samples = 0;
 
 	if (!err) {
 		if (!rec->timestamp_filename) {
@@ -3277,7 +3304,7 @@ int cmd_record(int argc, const char **argv)
 		rec->no_buildid = true;
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

