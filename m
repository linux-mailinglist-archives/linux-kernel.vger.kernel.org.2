Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA03354F16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbhDFIxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:53:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:28944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240689AbhDFIxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:53:47 -0400
IronPort-SDR: V5GdoCFcye3ImF3aCsyxW2u5VvZ78qrycv63oZArVoJw913yHVDrRFo4JHFQ/dGtJrHetkRnTL
 5BbiSwRv6NEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193063769"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="193063769"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:53:39 -0700
IronPort-SDR: 5SVblAfBOXDgu0edAkFGNLxEARuprTR9leZc/MnNXJIC49LN0vLjjeRBzGVqb8iI66YpPs2WJp
 /o/157qfl0AQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421124385"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:53:36 -0700
Subject: [PATCH v4 12/12] perf session: use reader functions to load perf data
 file
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
Message-ID: <990c4b5f-6a30-2c71-2794-d900da71dba5@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:53:34 +0300
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


Use the reader functions to load data file similar to loading of
data directory files.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 215 ++++++++++++--------------------------
 1 file changed, 66 insertions(+), 149 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 26fffadfd6ef..e60b0212f64e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2187,109 +2187,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	return 0;
 }
 
-static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
-{
-	u64 data_size = rd->data_size;
-	u64 head, page_offset, file_offset, file_pos, size;
-	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
-	size_t	mmap_size;
-	char *buf, *mmaps[NUM_MMAPS];
-	union perf_event *event;
-	s64 skip;
-
-	page_offset = page_size * (rd->data_offset / page_size);
-	file_offset = page_offset;
-	head = rd->data_offset - page_offset;
-
-	ui_progress__init_size(prog, data_size, "Processing events...");
-
-	data_size += rd->data_offset;
-
-	mmap_size = MMAP_SIZE;
-	if (mmap_size > data_size) {
-		mmap_size = data_size;
-		session->one_mmap = true;
-	}
-
-	memset(mmaps, 0, sizeof(mmaps));
-
-	mmap_prot  = PROT_READ;
-	mmap_flags = MAP_SHARED;
-
-	if (session->header.needs_swap) {
-		mmap_prot  |= PROT_WRITE;
-		mmap_flags = MAP_PRIVATE;
-	}
-remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
-		   file_offset);
-	if (buf == MAP_FAILED) {
-		pr_err("failed to mmap file\n");
-		err = -errno;
-		goto out;
-	}
-	mmaps[map_idx] = buf;
-	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
-	file_pos = file_offset + head;
-	if (session->one_mmap) {
-		session->one_mmap_addr = buf;
-		session->one_mmap_offset = file_offset;
-	}
-
-more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
-	if (IS_ERR(event))
-		return PTR_ERR(event);
-
-	if (!event) {
-		if (mmaps[map_idx]) {
-			munmap(mmaps[map_idx], mmap_size);
-			mmaps[map_idx] = NULL;
-		}
-
-		page_offset = page_size * (head / page_size);
-		file_offset += page_offset;
-		head -= page_offset;
-		goto remap;
-	}
-
-	size = event->header.size;
-
-	skip = -EINVAL;
-
-	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
-		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
-		       file_offset + head, rd->path, event->header.size,
-		       event->header.type, strerror(-skip));
-		err = skip;
-		goto out;
-	}
-
-	if (skip)
-		size += skip;
-
-	head += size;
-	file_pos += size;
-
-	err = __perf_session__process_decomp_events(session);
-	if (err)
-		goto out;
-
-	ui_progress__update(prog, size);
-
-	if (session_done())
-		goto out;
-
-	if (file_pos < data_size)
-		goto more;
-
-out:
-	return err;
-}
-
 static s64 process_simple(struct perf_session *session,
 			  union perf_event *event,
 			  u64 file_offset,
@@ -2298,52 +2195,6 @@ static s64 process_simple(struct perf_session *session,
 	return perf_session__process_event(session, event, file_offset, file_path);
 }
 
-static int __perf_session__process_events(struct perf_session *session)
-{
-	struct reader rd = {
-		.fd		= perf_data__fd(session->data),
-		.data_size	= session->header.data_size,
-		.data_offset	= session->header.data_offset,
-		.process	= process_simple,
-		.path		= session->data->file.path,
-	};
-	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
-	struct ui_progress prog;
-	int err;
-
-	perf_tool__fill_defaults(tool);
-
-	if (rd.data_size == 0)
-		return -1;
-
-	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
-
-	err = reader__process_events(&rd, session, &prog);
-	if (err)
-		goto out_err;
-	/* do the final flush for ordered samples */
-	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
-	if (err)
-		goto out_err;
-	err = auxtrace__flush_events(session, tool);
-	if (err)
-		goto out_err;
-	err = perf_session__flush_thread_stacks(session);
-out_err:
-	ui_progress__finish();
-	if (!tool->no_warn)
-		perf_session__warn_about_errors(session);
-	/*
-	 * We may switching perf.data output, make ordered_events
-	 * reusable.
-	 */
-	ordered_events__reinit(&session->ordered_events);
-	auxtrace__free_events(session);
-	session->one_mmap = false;
-	return err;
-}
-
 static int
 reader__init(struct reader *rd, bool *one_mmap)
 {
@@ -2460,6 +2311,72 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	session->active_reader = NULL;;
 	return ret;
 }
+
+static int __perf_session__process_events(struct perf_session *session)
+{
+	struct reader *rd;
+	struct ordered_events *oe = &session->ordered_events;
+	struct perf_tool *tool = session->tool;
+	struct ui_progress prog;
+	int err;
+
+	perf_tool__fill_defaults(tool);
+
+	rd = session->readers = zalloc(sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+
+	session->nr_readers = 1;
+
+	*rd = (struct reader) {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
+		.path		= session->data->file.path,
+	};
+
+	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
+
+	reader__init(rd, &session->one_mmap);
+	if (reader__mmap(rd, session) != READER_OK)
+		goto out_err;
+
+	while (true) {
+		if (session_done())
+			break;
+
+		err = reader__read_event(rd, session, &prog);
+		if (err < 0)
+			break;
+		if (err == READER_EOF) {
+			err = reader__mmap(rd, session);
+			if (err <= 0)
+				break;
+		}
+	}
+
+	/* do the final flush for ordered samples */
+	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
+	if (err)
+		goto out_err;
+	err = auxtrace__flush_events(session, tool);
+	if (err)
+		goto out_err;
+	err = perf_session__flush_thread_stacks(session);
+out_err:
+	ui_progress__finish();
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+	auxtrace__free_events(session);
+	session->one_mmap = false;
+	return err;
+}
 /*
  * This function reads, merge and process directory data.
  * It assumens the version 1 of directory data, where each
-- 
2.19.0


