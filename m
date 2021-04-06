Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B052354F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbhDFIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:51:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:13614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232593AbhDFIvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:51:41 -0400
IronPort-SDR: /MxSHODYnW7mDojWyoTgO5sypLLmIRWYdQDv8ROT9cMMDHR7Q90hBrNtH+EQ0g/iUWmfXZWwLJ
 VNzVpZojWczg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180152938"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180152938"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:51:34 -0700
IronPort-SDR: H4EjAJG1JSvfDfB4ESFOgI4qjTY0MbCC8inBZPCyH0siX6ma7IWL2J8rcc6D0KrVlFISyeC1bU
 sN2aLpALVPQA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421123855"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:51:30 -0700
Subject: [PATCH v4 10/12] perf report: output data file name in raw trace dump
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
Message-ID: <e07415b5-8aaf-cda1-8730-fe5b5802b11b@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:51:27 +0300
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


Print path and name of a data file into raw dump (-D)
<file_offset>@<path/file>. Print offset of PERF_RECORD_COMPRESSED
record instead of zero for decompressed records:
  0x2226a@perf.data [0x30]: event: 9
or
  0x15cc36@perf.data/data.7 [0x30]: event: 9

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-inject.c      |  3 +-
 tools/perf/util/ordered-events.h |  1 +
 tools/perf/util/session.c        | 77 +++++++++++++++++++-------------
 tools/perf/util/session.h        |  1 +
 tools/perf/util/tool.h           |  3 +-
 5 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6fe44d97fde5..90a75739cda1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -106,7 +106,8 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
 
 static int perf_event__repipe_op4_synth(struct perf_session *session,
 					union perf_event *event,
-					u64 data __maybe_unused)
+					u64 data __maybe_unused,
+					const char *str __maybe_unused)
 {
 	return perf_event__repipe_synth(session->tool, event);
 }
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 75345946c4b9..42c9764c6b5b 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -9,6 +9,7 @@ struct perf_sample;
 struct ordered_event {
 	u64			timestamp;
 	u64			file_offset;
+	const char		*file_path;
 	union perf_event	*event;
 	struct list_head	list;
 };
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9a8808507bd9..84f8f29c48a6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -37,7 +37,8 @@
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
-						  union perf_event *event, u64 file_offset)
+						  union perf_event *event, u64 file_offset,
+						  const char *file_path)
 {
 	void *src;
 	size_t decomp_size, src_size;
@@ -59,6 +60,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	}
 
 	decomp->file_pos = file_offset;
+	decomp->file_path = file_path;
 	decomp->mmap_len = mmap_len;
 	decomp->head = 0;
 
@@ -99,7 +101,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
-				       u64 file_offset);
+				       u64 file_offset,
+				       const char *file_path);
 
 static int perf_session__open(struct perf_session *session)
 {
@@ -181,7 +184,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 						    ordered_events);
 
 	return perf_session__deliver_event(session, event->event,
-					   session->tool, event->file_offset);
+					   session->tool, event->file_offset,
+					   event->file_path);
 }
 
 struct perf_session *perf_session__new(struct perf_data *data,
@@ -453,7 +457,8 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
 
 static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
 						       union perf_event *event __maybe_unused,
-						       u64 file_offset __maybe_unused)
+						       u64 file_offset __maybe_unused,
+						       const char *file_path __maybe_unused)
 {
        dump_printf(": unhandled!\n");
        return 0;
@@ -1243,13 +1248,14 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 }
 
 static void dump_event(struct evlist *evlist, union perf_event *event,
-		       u64 file_offset, struct perf_sample *sample)
+		       u64 file_offset, struct perf_sample *sample,
+		       const char *file_path)
 {
 	if (!dump_trace)
 		return;
 
-	printf("\n%#" PRIx64 " [%#x]: event: %d\n",
-	       file_offset, event->header.size, event->header.type);
+	printf("\n%#" PRIx64 "@%s [%#x]: event: %d\n",
+	       file_offset, file_path, event->header.size, event->header.type);
 
 	trace_event(event);
 	if (event->header.type == PERF_RECORD_SAMPLE && evlist->trace_event_sample_raw)
@@ -1450,12 +1456,13 @@ static int machines__deliver_event(struct machines *machines,
 				   struct evlist *evlist,
 				   union perf_event *event,
 				   struct perf_sample *sample,
-				   struct perf_tool *tool, u64 file_offset)
+				   struct perf_tool *tool, u64 file_offset,
+				   const char *file_path)
 {
 	struct evsel *evsel;
 	struct machine *machine;
 
-	dump_event(evlist, event, file_offset, sample);
+	dump_event(evlist, event, file_offset, sample, file_path);
 
 	evsel = evlist__id2evsel(evlist, sample->id);
 
@@ -1532,7 +1539,8 @@ static int machines__deliver_event(struct machines *machines,
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
-				       u64 file_offset)
+				       u64 file_offset,
+				       const char *file_path)
 {
 	struct perf_sample sample;
 	int ret = evlist__parse_sample(session->evlist, event, &sample);
@@ -1549,7 +1557,7 @@ static int perf_session__deliver_event(struct perf_session *session,
 		return 0;
 
 	ret = machines__deliver_event(&session->machines, session->evlist,
-				      event, &sample, tool, file_offset);
+				      event, &sample, tool, file_offset, file_path);
 
 	if (dump_trace && sample.aux_sample.size)
 		auxtrace__dump_auxtrace_sample(session, &sample);
@@ -1559,7 +1567,8 @@ static int perf_session__deliver_event(struct perf_session *session,
 
 static s64 perf_session__process_user_event(struct perf_session *session,
 					    union perf_event *event,
-					    u64 file_offset)
+					    u64 file_offset,
+					    const char *file_path)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
@@ -1569,7 +1578,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 
 	if (event->header.type != PERF_RECORD_COMPRESSED ||
 	    tool->compressed == perf_session__process_compressed_event_stub)
-		dump_event(session->evlist, event, file_offset, &sample);
+		dump_event(session->evlist, event, file_offset, &sample, file_path);
 
 	/* These events are processed right away */
 	switch (event->header.type) {
@@ -1628,9 +1637,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_HEADER_FEATURE:
 		return tool->feature(session, event);
 	case PERF_RECORD_COMPRESSED:
-		err = tool->compressed(session, event, file_offset);
+		err = tool->compressed(session, event, file_offset, file_path);
 		if (err)
-			dump_event(session->evlist, event, file_offset, &sample);
+			dump_event(session->evlist, event, file_offset, &sample, file_path);
 		return err;
 	default:
 		return -EINVAL;
@@ -1647,9 +1656,9 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-		return perf_session__process_user_event(session, event, 0);
+		return perf_session__process_user_event(session, event, 0, NULL);
 
-	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0);
+	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
 }
 
 static void event_swap(union perf_event *event, bool sample_id_all)
@@ -1745,7 +1754,8 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
 }
 
 static s64 perf_session__process_event(struct perf_session *session,
-				       union perf_event *event, u64 file_offset)
+				       union perf_event *event, u64 file_offset,
+				       const char *file_path)
 {
 	struct evlist *evlist = session->evlist;
 	struct perf_tool *tool = session->tool;
@@ -1760,7 +1770,7 @@ static s64 perf_session__process_event(struct perf_session *session,
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-		return perf_session__process_user_event(session, event, file_offset);
+		return perf_session__process_user_event(session, event, file_offset, file_path);
 
 	if (tool->ordered_events) {
 		u64 timestamp = -1ULL;
@@ -1774,7 +1784,7 @@ static s64 perf_session__process_event(struct perf_session *session,
 			return ret;
 	}
 
-	return perf_session__deliver_event(session, event, tool, file_offset);
+	return perf_session__deliver_event(session, event, tool, file_offset, file_path);
 }
 
 void perf_event_header__bswap(struct perf_event_header *hdr)
@@ -1994,7 +2004,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 		}
 	}
 
-	if ((skip = perf_session__process_event(session, event, head)) < 0) {
+	skip = perf_session__process_event(session, event, head, "pipe");
+	if (skip < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       head, event->header.size, event->header.type);
 		err = -EINVAL;
@@ -2075,7 +2086,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
 static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
-	u64 size, file_pos = 0;
+	u64 size;
 	struct decomp *decomp = session->decomp_last;
 
 	if (!decomp)
@@ -2089,9 +2100,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 			break;
 
 		size = event->header.size;
-
-		if (size < sizeof(struct perf_event_header) ||
-		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+		skip = perf_session__process_event(session, event, decomp->file_pos,
+						   decomp->file_path);
+		if (size < sizeof(struct perf_event_header) || skip < 0) {
 			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 				decomp->file_pos + decomp->head, event->header.size, event->header.type);
 			return -EINVAL;
@@ -2122,10 +2133,12 @@ struct reader;
 
 typedef s64 (*reader_cb_t)(struct perf_session *session,
 			   union perf_event *event,
-			   u64 file_offset);
+			   u64 file_offset,
+			   const char *file_path);
 
 struct reader {
 	int		 fd;
+	const char	 *path;
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
@@ -2204,9 +2217,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	skip = -EINVAL;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
-		       file_offset + head, event->header.size,
+	    (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
+		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
+		       file_offset + head, rd->path, event->header.size,
 		       event->header.type, strerror(-skip));
 		err = skip;
 		goto out;
@@ -2236,9 +2249,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 static s64 process_simple(struct perf_session *session,
 			  union perf_event *event,
-			  u64 file_offset)
+			  u64 file_offset,
+			  const char *file_path)
 {
-	return perf_session__process_event(session, event, file_offset);
+	return perf_session__process_event(session, event, file_offset, file_path);
 }
 
 static int __perf_session__process_events(struct perf_session *session)
@@ -2248,6 +2262,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.path		= session->data->file.path,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index f76480166d38..378ffc3e2809 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -46,6 +46,7 @@ struct perf_session {
 struct decomp {
 	struct decomp *next;
 	u64 file_pos;
+	const char *file_path;
 	size_t mmap_len;
 	u64 head;
 	size_t size;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index bbbc0dcd461f..c966531d3eca 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -28,7 +28,8 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
-typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
+typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data,
+			 const char *str);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
-- 
2.19.0


