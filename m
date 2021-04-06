Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3DC354F14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbhDFIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:52:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:60760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240673AbhDFIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:52:45 -0400
IronPort-SDR: W0vaKA49HleDg3XAM1Ozx7jR36uLz2qzVjzMdpQuz7CeivPAiYo77Wilh9X0aNGrcrxs66PZi8
 Hnt/7JPiqqAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="257009782"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="257009782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:52:37 -0700
IronPort-SDR: PRp6njLo0I2li3oDXlzwe34uGgo78TYdpk49cjTFbF4zyvenp575PZHyLiq9pIZq5t9Yo4rwog
 w7+tYcLVn/iQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="421124123"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.164]) ([10.249.228.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 01:52:34 -0700
Subject: [PATCH v4 11/12] perf session: load data directory files for analysis
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
Message-ID: <a0659ee9-d03c-38f4-dd8c-729efa98c525@linux.intel.com>
Date:   Tue, 6 Apr 2021 11:52:32 +0300
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


Introduce decompressor into trace reader object so that decompression
could be executed on per data file basis separately for every data
file located in data directory.

Load data directory files and provide basic raw dump and aggregated
analysis support of data directories in report mode, still with no
memory consumption optimizations.

Design and implementation are based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 350 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/session.h |   4 +
 2 files changed, 315 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 84f8f29c48a6..26fffadfd6ef 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -35,6 +35,55 @@
 #include "units.h"
 #include <internal/lib.h>
 
+struct reader;
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset,
+			   const char *file_path);
+
+/*
+ * On 64bit we can mmap the data file in one go. No need for tiny mmap
+ * slices. On 32bit we use 32MB.
+ */
+#if BITS_PER_LONG == 64
+#define MMAP_SIZE ULLONG_MAX
+#define NUM_MMAPS 1
+#else
+#define MMAP_SIZE (32 * 1024 * 1024ULL)
+#define NUM_MMAPS 128
+#endif
+
+struct reader_state {
+	char	*mmaps[NUM_MMAPS];
+	size_t	 mmap_size;
+	int	 mmap_idx;
+	char	*mmap_cur;
+	u64	 file_pos;
+	u64	 file_offset;
+	u64	 data_size;
+	u64	 head;
+	bool	 eof;
+	u64	 size;
+};
+
+enum {
+	READER_EOF	=  0,
+	READER_OK	=  1,
+};
+
+struct reader {
+	int		 fd;
+	const char	 *path;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
+	struct zstd_data zstd_data;
+	struct decomp	 *decomp;
+	struct decomp	 *decomp_last;
+	struct reader_state state;
+};
+
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
 						  union perf_event *event, u64 file_offset,
@@ -44,7 +93,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
 	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
-	struct decomp *decomp, *decomp_last = session->decomp_last;
+	struct decomp *decomp, *decomp_last = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
+	struct zstd_data *zstd_data = session->active_reader ?
+		&session->active_reader->zstd_data: &session->zstd_data;
 
 	if (decomp_last) {
 		decomp_last_rem = decomp_last->size - decomp_last->head;
@@ -72,7 +124,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	src = (void *)event + sizeof(struct perf_record_compressed);
 	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
-	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
@@ -82,12 +134,22 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 
 	decomp->size += decomp_size;
 
-	if (session->decomp == NULL) {
-		session->decomp = decomp;
-		session->decomp_last = decomp;
+	if (session->active_reader) {
+		if (session->active_reader->decomp == NULL) {
+			session->active_reader->decomp = decomp;
+			session->active_reader->decomp_last = decomp;
+		} else {
+			session->active_reader->decomp_last->next = decomp;
+			session->active_reader->decomp_last = decomp;
+		}
 	} else {
-		session->decomp_last->next = decomp;
-		session->decomp_last = decomp;
+		if (session->decomp == NULL) {
+			session->decomp = decomp;
+			session->decomp_last = decomp;
+		} else {
+			session->decomp_last->next = decomp;
+			session->decomp_last = decomp;
+		}
 	}
 
 	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
@@ -278,11 +340,10 @@ static void perf_session__delete_threads(struct perf_session *session)
 	machine__delete_threads(&session->machines.host);
 }
 
-static void perf_session__release_decomp_events(struct perf_session *session)
+static void perf_decomp__release_events(struct decomp *next)
 {
-	struct decomp *next, *decomp;
+	struct decomp *decomp;
 	size_t mmap_len;
-	next = session->decomp;
 	do {
 		decomp = next;
 		if (decomp == NULL)
@@ -295,13 +356,21 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 
 void perf_session__delete(struct perf_session *session)
 {
+	int r;
+
 	if (session == NULL)
 		return;
 	auxtrace__free(session);
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
-	perf_session__release_decomp_events(session);
+	if (session->readers) {
+		for (r = 0; r < session->nr_readers; r++)
+			perf_decomp__release_events(session->readers[r].decomp);
+		zfree(&session->readers);
+		session->nr_readers = 0;
+	}
+	perf_decomp__release_events(session->decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data)
@@ -2087,7 +2156,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
 	u64 size;
-	struct decomp *decomp = session->decomp_last;
+	struct decomp *decomp = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
 
 	if (!decomp)
 		return 0;
@@ -2117,33 +2187,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	return 0;
 }
 
-/*
- * On 64bit we can mmap the data file in one go. No need for tiny mmap
- * slices. On 32bit we use 32MB.
- */
-#if BITS_PER_LONG == 64
-#define MMAP_SIZE ULLONG_MAX
-#define NUM_MMAPS 1
-#else
-#define MMAP_SIZE (32 * 1024 * 1024ULL)
-#define NUM_MMAPS 128
-#endif
-
-struct reader;
-
-typedef s64 (*reader_cb_t)(struct perf_session *session,
-			   union perf_event *event,
-			   u64 file_offset,
-			   const char *file_path);
-
-struct reader {
-	int		 fd;
-	const char	 *path;
-	u64		 data_size;
-	u64		 data_offset;
-	reader_cb_t	 process;
-};
-
 static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
@@ -2301,6 +2344,232 @@ static int __perf_session__process_events(struct perf_session *session)
 	return err;
 }
 
+static int
+reader__init(struct reader *rd, bool *one_mmap)
+{
+	struct reader_state *st = &rd->state;
+	char **mmaps = st->mmaps;
+
+	pr_debug("reader processing %s\n", rd->path);
+
+	st->head = rd->data_offset;
+
+	st->data_size = rd->data_size + rd->data_offset;
+
+	st->mmap_size = MMAP_SIZE;
+	if (st->mmap_size > st->data_size) {
+		st->mmap_size = st->data_size;
+		if (one_mmap)
+			*one_mmap = true;
+	}
+
+	memset(mmaps, 0, sizeof(st->mmaps));
+
+	if (zstd_init(&rd->zstd_data, 0))
+		return -1;
+
+	return 0;
+}
+
+static int
+reader__mmap(struct reader *rd, struct perf_session *session)
+{
+	struct reader_state *st = &rd->state;
+	int mmap_prot, mmap_flags;
+	char *buf, **mmaps = st->mmaps;
+	u64 page_offset;
+
+	if (st->file_pos >= st->data_size) {
+		st->eof = true;
+		return READER_EOF;
+	}
+
+	mmap_prot  = PROT_READ;
+	mmap_flags = MAP_SHARED;
+
+	if (session->header.needs_swap) {
+		mmap_prot  |= PROT_WRITE;
+		mmap_flags = MAP_PRIVATE;
+	}
+
+	if (mmaps[st->mmap_idx]) {
+		munmap(mmaps[st->mmap_idx], st->mmap_size);
+		mmaps[st->mmap_idx] = NULL;
+	}
+
+	page_offset = page_size * (st->head / page_size);
+	st->file_offset += page_offset;
+	st->head -= page_offset;
+
+	buf = mmap(NULL, st->mmap_size, mmap_prot, mmap_flags, rd->fd,
+		   st->file_offset);
+	if (buf == MAP_FAILED) {
+		pr_err("failed to mmap file\n");
+		return -errno;
+	}
+	mmaps[st->mmap_idx] = st->mmap_cur = buf;
+	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
+	st->file_pos = st->file_offset + st->head;
+	return READER_OK;
+}
+
+static int
+reader__read_event(struct reader *rd, struct perf_session *session,
+		   struct ui_progress *prog)
+{
+	struct reader_state *st = &rd->state;
+	union perf_event *event;
+	int ret = READER_OK;
+	u64 size;
+	s64 skip;
+
+	event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur, session->header.needs_swap);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	if (!event)
+		return READER_EOF;
+
+	session->active_reader = rd;
+	size = event->header.size;
+	skip = -EINVAL;
+
+	if (size < sizeof(struct perf_event_header) ||
+	    (skip = perf_session__process_event(session, event, st->file_pos, rd->path)) < 0) {
+		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
+		       st->file_offset + st->head, rd->path, event->header.size,
+		       event->header.type, strerror(-skip));
+		ret = skip;
+		goto out;
+	}
+
+	if (skip)
+		size += skip;
+
+	st->size += size;
+	st->head += size;
+	st->file_pos += size;
+
+	skip = __perf_session__process_decomp_events(session);
+	if (skip)
+		ret = skip;
+
+	ui_progress__update(prog, size);
+
+out:
+	session->active_reader = NULL;;
+	return ret;
+}
+/*
+ * This function reads, merge and process directory data.
+ * It assumens the version 1 of directory data, where each
+ * data file holds per-cpu data, already sorted by kernel.
+ */
+static int __perf_session__process_dir_events(struct perf_session *session)
+{
+	struct perf_data *data = session->data;
+	struct perf_tool *tool = session->tool;
+	int i, ret = 0, readers = 1;
+	struct ui_progress prog;
+	u64 total_size = perf_data__size(session->data);
+	struct reader *rd;
+
+	perf_tool__fill_defaults(tool);
+
+	ui_progress__init_size(&prog, total_size, "Sorting events...");
+
+	for (i = 0; i < data->dir.nr; i++) {
+		if (data->dir.files[i].size)
+			readers++;
+	}
+
+	rd = session->readers = zalloc(readers * sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+	session->nr_readers = readers;
+	readers = 0;
+
+	rd[readers] = (struct reader) {
+		.fd		= perf_data__fd(session->data),
+		.path		= session->data->file.path,
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+	};
+	reader__init(&rd[readers], &session->one_mmap);
+	if (reader__mmap(&rd[readers], session) != READER_OK)
+		goto out_err;
+	readers++;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		if (data->dir.files[i].size) {
+			rd[readers] = (struct reader) {
+				.fd		= data->dir.files[i].fd,
+				.path		= data->dir.files[i].path,
+				.data_size	= data->dir.files[i].size,
+				.data_offset	= 0,
+			};
+			reader__init(&rd[readers], &session->one_mmap);
+			if (reader__mmap(&rd[readers], session) != READER_OK)
+				goto out_err;
+			readers++;
+		}
+	}
+
+	i = 0;
+
+	while ((ret >= 0) && readers) {
+		if (session_done())
+			return 0;
+
+		if (rd[i].state.eof) {
+			i = (i + 1) % session->nr_readers;
+			continue;
+		}
+
+		ret = reader__read_event(&rd[i], session, &prog);
+		if (ret < 0)
+			break;
+		if (ret == READER_EOF) {
+			ret = reader__mmap(&rd[i], session);
+			if (ret < 0)
+				goto out_err;
+			if (ret == READER_EOF)
+				readers--;
+		}
+
+		/*
+		 * Processing 10MBs of data from each reader in sequence,
+		 * because that's the way the ordered events sorting works
+		 * most efficiently.
+		 */
+		if (rd[i].state.size >= 10*1024*1024) {
+			rd[i].state.size = 0;
+			i = (i + 1) % session->nr_readers;
+		}
+	}
+
+	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
+	if (ret)
+		goto out_err;
+
+	ret = perf_session__flush_thread_stacks(session);
+out_err:
+	ui_progress__finish();
+
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+
+	session->one_mmap = false;
+
+	return ret;
+}
+
 int perf_session__process_events(struct perf_session *session)
 {
 	if (perf_session__register_idle_thread(session) < 0)
@@ -2309,6 +2578,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 378ffc3e2809..cbc54615d155 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -19,6 +19,7 @@ struct thread;
 
 struct auxtrace;
 struct itrace_synth_opts;
+struct reader;
 
 struct perf_session {
 	struct perf_header	header;
@@ -41,6 +42,9 @@ struct perf_session {
 	struct zstd_data	zstd_data;
 	struct decomp		*decomp;
 	struct decomp		*decomp_last;
+	struct reader		*readers;
+	int			nr_readers;
+	struct reader		*active_reader;
 };
 
 struct decomp {
-- 
2.19.0


