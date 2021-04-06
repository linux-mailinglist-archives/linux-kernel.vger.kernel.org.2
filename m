Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720BF354EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244536AbhDFIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:48:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:41596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232593AbhDFIsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:48:12 -0400
IronPort-SDR: OPPH9WuP1K6bmsWtRX79q1fqp4FFFHQAemEhkdRJsom1KMdYr8umeHqIQJ78I2wq9mV0HFTLE/
 nJrczGd6ixpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213379958"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="213379958"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:48:05 -0700
IronPort-SDR: 92ibK65s1bu6z7TxTfON2qN2WZ9cXL0UgmVJCWUHhD1BCJ41+trr7dqlh+AwuE2YKteOt8frqT
 EXOv2g+CmSDQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421122819"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:48:01 -0700
Subject: [PATCH v4 07/12] perf record: init data file at mmap buffer object
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
Message-ID: <05b01d0b-0308-0e60-f3ec-08ae62614e4f@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:48:00 +0300
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


Initialize data files located at mmap buffer objects so trace data
can be written into several data file located at data directory.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 41 ++++++++++++++++++++++++++++++-------
 tools/perf/util/record.h    |  1 +
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3947c60d905b..c1416d28ac6d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -158,6 +158,11 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
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
@@ -1066,7 +1071,7 @@ static void record__free_thread_data(struct record *rec)
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
-	int ret;
+	int i, ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -1105,6 +1110,18 @@ static int record__mmap_evlist(struct record *rec,
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
 
@@ -1405,8 +1422,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
@@ -1519,7 +1540,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1530,15 +1553,21 @@ static void
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
@@ -2438,8 +2467,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = err;
 
 	record__synthesize(rec, true);
-	/* this will be recalculated during process_buildids() */
-	rec->samples = 0;
 
 	if (!err) {
 		if (!rec->timestamp_filename) {
@@ -3203,7 +3230,7 @@ int cmd_record(int argc, const char **argv)
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


