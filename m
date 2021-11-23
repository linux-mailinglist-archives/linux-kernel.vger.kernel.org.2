Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE6A45A4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbhKWON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:13:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:35019 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237586AbhKWONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:13:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="233748075"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="233748075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422743"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:09:48 -0800
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
Subject: [PATCH v12 16/16] perf report: Output data file name in raw trace dump
Date:   Tue, 23 Nov 2021 17:08:12 +0300
Message-Id: <e73de4ca7a0eaaac1b8510aa8b21893c62470ab1.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print path and name of a data file into raw dump (-D)
<file_offset>@<path/file>:

  0x2226a@perf.data [0x30]: event: 9
or
  0x15cc36@perf.data/data.7 [0x30]: event: 9

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-inject.c      |  3 +-
 tools/perf/builtin-kvm.c         |  2 +-
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/builtin-trace.c       |  2 +-
 tools/perf/util/ordered-events.c |  3 +-
 tools/perf/util/ordered-events.h |  3 +-
 tools/perf/util/session.c        | 75 ++++++++++++++++++++------------
 tools/perf/util/session.h        |  3 +-
 tools/perf/util/tool.h           |  3 +-
 9 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bc5259db5fd9..f512e5b5024c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -110,7 +110,8 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
 
 static int perf_event__repipe_op4_synth(struct perf_session *session,
 					union perf_event *event,
-					u64 data __maybe_unused)
+					u64 data __maybe_unused,
+					const char *str __maybe_unused)
 {
 	return perf_event__repipe_synth(session->tool, event);
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c6f352ee57e6..b23a1f3eaeda 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -771,7 +771,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			return -1;
 		}
 
-		err = perf_session__queue_event(kvm->session, event, timestamp, 0);
+		err = perf_session__queue_event(kvm->session, event, timestamp, 0, NULL);
 		/*
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1fc390f136dd..92b314fa7223 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -888,7 +888,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (ret && ret != -1)
 			break;
 
-		ret = ordered_events__queue(top->qe.in, event, last_timestamp, 0);
+		ret = ordered_events__queue(top->qe.in, event, last_timestamp, 0, NULL);
 		if (ret)
 			break;
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0b52e08e558e..882541639b6f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3769,7 +3769,7 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 	if (err && err != -1)
 		return err;
 
-	err = ordered_events__queue(&trace->oe.data, event, trace->oe.last, 0);
+	err = ordered_events__queue(&trace->oe.data, event, trace->oe.last, 0, NULL);
 	if (err)
 		return err;
 
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 48c8f609441b..b887dfeea673 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -192,7 +192,7 @@ void ordered_events__delete(struct ordered_events *oe, struct ordered_event *eve
 }
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
-			  u64 timestamp, u64 file_offset)
+			  u64 timestamp, u64 file_offset, const char *file_path)
 {
 	struct ordered_event *oevent;
 
@@ -217,6 +217,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 		return -ENOMEM;
 
 	oevent->file_offset = file_offset;
+	oevent->file_path = file_path;
 	return 0;
 }
 
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 75345946c4b9..0b05c3c0aeaa 100644
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
@@ -53,7 +54,7 @@ struct ordered_events {
 };
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
-			  u64 timestamp, u64 file_offset);
+			  u64 timestamp, u64 file_offset, const char *file_path);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
 int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a8e3f106e95..88d71c466569 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -38,7 +38,8 @@
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
-						  union perf_event *event, u64 file_offset)
+						  union perf_event *event, u64 file_offset,
+						  const char *file_path)
 {
 	void *src;
 	size_t decomp_size, src_size;
@@ -60,6 +61,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
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
 
 static int perf_session__open(struct perf_session *session, int repipe_fd)
 {
@@ -181,7 +184,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 						    ordered_events);
 
 	return perf_session__deliver_event(session, event->event,
-					   session->tool, event->file_offset);
+					   session->tool, event->file_offset,
+					   event->file_path);
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
@@ -470,7 +474,8 @@ static int process_event_time_conv_stub(struct perf_session *perf_session __mayb
 
 static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
 						       union perf_event *event __maybe_unused,
-						       u64 file_offset __maybe_unused)
+						       u64 file_offset __maybe_unused,
+						       const char *file_path __maybe_unused)
 {
        dump_printf(": unhandled!\n");
        return 0;
@@ -1071,9 +1076,9 @@ static int process_finished_round(struct perf_tool *tool __maybe_unused,
 }
 
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
-			      u64 timestamp, u64 file_offset)
+			      u64 timestamp, u64 file_offset, const char *file_path)
 {
-	return ordered_events__queue(&s->ordered_events, event, timestamp, file_offset);
+	return ordered_events__queue(&s->ordered_events, event, timestamp, file_offset, file_path);
 }
 
 static void callchain__lbr_callstack_printf(struct perf_sample *sample)
@@ -1276,13 +1281,14 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
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
@@ -1485,12 +1491,13 @@ static int machines__deliver_event(struct machines *machines,
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
 
@@ -1571,7 +1578,8 @@ static int machines__deliver_event(struct machines *machines,
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
-				       u64 file_offset)
+				       u64 file_offset,
+				       const char *file_path)
 {
 	struct perf_sample sample;
 	int ret = evlist__parse_sample(session->evlist, event, &sample);
@@ -1588,7 +1596,7 @@ static int perf_session__deliver_event(struct perf_session *session,
 		return 0;
 
 	ret = machines__deliver_event(&session->machines, session->evlist,
-				      event, &sample, tool, file_offset);
+				      event, &sample, tool, file_offset, file_path);
 
 	if (dump_trace && sample.aux_sample.size)
 		auxtrace__dump_auxtrace_sample(session, &sample);
@@ -1598,7 +1606,8 @@ static int perf_session__deliver_event(struct perf_session *session,
 
 static s64 perf_session__process_user_event(struct perf_session *session,
 					    union perf_event *event,
-					    u64 file_offset)
+					    u64 file_offset,
+					    const char *file_path)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
@@ -1608,7 +1617,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 
 	if (event->header.type != PERF_RECORD_COMPRESSED ||
 	    tool->compressed == perf_session__process_compressed_event_stub)
-		dump_event(session->evlist, event, file_offset, &sample);
+		dump_event(session->evlist, event, file_offset, &sample, file_path);
 
 	/* These events are processed right away */
 	switch (event->header.type) {
@@ -1667,9 +1676,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
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
@@ -1686,9 +1695,9 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-		return perf_session__process_user_event(session, event, 0);
+		return perf_session__process_user_event(session, event, 0, NULL);
 
-	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0);
+	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
 }
 
 static void event_swap(union perf_event *event, bool sample_id_all)
@@ -1785,7 +1794,8 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
 }
 
 static s64 perf_session__process_event(struct perf_session *session,
-				       union perf_event *event, u64 file_offset)
+				       union perf_event *event, u64 file_offset,
+				       const char *file_path)
 {
 	struct evlist *evlist = session->evlist;
 	struct perf_tool *tool = session->tool;
@@ -1800,7 +1810,7 @@ static s64 perf_session__process_event(struct perf_session *session,
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-		return perf_session__process_user_event(session, event, file_offset);
+		return perf_session__process_user_event(session, event, file_offset, file_path);
 
 	if (tool->ordered_events) {
 		u64 timestamp = -1ULL;
@@ -1809,12 +1819,12 @@ static s64 perf_session__process_event(struct perf_session *session,
 		if (ret && ret != -1)
 			return ret;
 
-		ret = perf_session__queue_event(session, event, timestamp, file_offset);
+		ret = perf_session__queue_event(session, event, timestamp, file_offset, file_path);
 		if (ret != -ETIME)
 			return ret;
 	}
 
-	return perf_session__deliver_event(session, event, tool, file_offset);
+	return perf_session__deliver_event(session, event, tool, file_offset, file_path);
 }
 
 void perf_event_header__bswap(struct perf_event_header *hdr)
@@ -2041,7 +2051,7 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 		}
 	}
 
-	if ((skip = perf_session__process_event(session, event, head)) < 0) {
+	if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       head, event->header.size, event->header.type);
 		err = -EINVAL;
@@ -2138,7 +2148,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		size = event->header.size;
 
 		if (size < sizeof(struct perf_event_header) ||
-		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
+		    (skip = perf_session__process_event(session, event, decomp->file_pos,
+							decomp->file_path)) < 0) {
 			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 				decomp->file_pos + decomp->head, event->header.size, event->header.type);
 			return -EINVAL;
@@ -2169,10 +2180,12 @@ struct reader;
 
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
@@ -2292,7 +2305,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	skip = -EINVAL;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, rd->file_pos)) < 0) {
+	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
 		       rd->file_offset + rd->head, event->header.size,
 		       event->header.type, strerror(-skip));
@@ -2360,15 +2373,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
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
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
+		.path		= session->data->file.path,
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
@@ -2449,6 +2464,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 
 	rd[0] = (struct reader) {
 		.fd		 = perf_data__fd(session->data),
+		.path		 = session->data->file.path,
 		.data_size	 = session->header.data_size,
 		.data_offset	 = session->header.data_offset,
 		.process	 = process_simple,
@@ -2467,6 +2483,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 			continue;
 		rd[readers] = (struct reader) {
 			.fd		 = data->dir.files[i].fd,
+			.path		 = data->dir.files[i].path,
 			.data_size	 = data->dir.files[i].size,
 			.data_offset	 = 0,
 			.process	 = process_simple,
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 46c854292ad6..34500a3da735 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -52,6 +52,7 @@ struct perf_session {
 struct decomp {
 	struct decomp *next;
 	u64 file_pos;
+	const char *file_path;
 	size_t mmap_len;
 	u64 head;
 	size_t size;
@@ -87,7 +88,7 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
 int perf_session__process_events(struct perf_session *session);
 
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
-			      u64 timestamp, u64 file_offset);
+			      u64 timestamp, u64 file_offset, const char *file_path);
 
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index ef873f2cc38f..f2352dba1875 100644
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

