Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71223C4DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhGLHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:15:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:25896 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240073AbhGLGup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209973426"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209973426"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 23:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="491916361"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2021 23:47:38 -0700
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
Subject: [PATCH v10 20/24] perf session: Introduce decompressor into trace reader object
Date:   Mon, 12 Jul 2021 09:46:20 +0300
Message-Id: <2f3e12e63c2d1b9809445642c328f7e9c36164f7.1626072009.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce decompressor into trace reader object so that decompression
could be executed on per data file basis separately for every data
file located in data directory.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 54 +++++++++++++++++++++++++++++----------
 tools/perf/util/session.h |  1 +
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index cf8491bc398b..2a0d3b3fd979 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -73,6 +73,9 @@ struct reader {
 	u64		 data_offset;
 	reader_cb_t	 process;
 	bool		 in_place_update;
+	struct zstd_data zstd_data;
+	struct decomp	 *decomp;
+	struct decomp	 *decomp_last;
 	struct reader_state state;
 };
 
@@ -85,7 +88,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
 	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
-	struct decomp *decomp, *decomp_last = session->decomp_last;
+	struct decomp *decomp, *decomp_last = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
+	struct zstd_data *zstd_data = session->active_reader ?
+		&session->active_reader->zstd_data : &session->zstd_data;
 
 	if (decomp_last) {
 		decomp_last_rem = decomp_last->size - decomp_last->head;
@@ -113,7 +119,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	src = (void *)event + sizeof(struct perf_record_compressed);
 	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
-	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
@@ -123,12 +129,22 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 
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
@@ -319,11 +335,11 @@ static void perf_session__delete_threads(struct perf_session *session)
 	machine__delete_threads(&session->machines.host);
 }
 
-static void perf_session__release_decomp_events(struct perf_session *session)
+static void perf_decomp__release_events(struct decomp *next)
 {
-	struct decomp *next, *decomp;
+	struct decomp *decomp;
 	size_t mmap_len;
-	next = session->decomp;
+
 	do {
 		decomp = next;
 		if (decomp == NULL)
@@ -336,6 +352,8 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 
 void perf_session__delete(struct perf_session *session)
 {
+	int r;
+
 	if (session == NULL)
 		return;
 	auxtrace__free(session);
@@ -343,10 +361,14 @@ void perf_session__delete(struct perf_session *session)
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
 	if (session->readers) {
+		for (r = 0; r < session->nr_readers; r++) {
+			perf_decomp__release_events(session->readers[r].decomp);
+			zstd_fini(&session->readers[r].zstd_data);
+		}
 		zfree(&session->readers);
 		session->nr_readers = 0;
 	}
-	perf_session__release_decomp_events(session);
+	perf_decomp__release_events(session->decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data) {
@@ -2160,7 +2182,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
 	u64 size;
-	struct decomp *decomp = session->decomp_last;
+	struct decomp *decomp = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
 
 	if (!decomp)
 		return 0;
@@ -2217,6 +2240,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	memset(mmaps, 0, sizeof(st->mmaps));
 
+	if (zstd_init(&rd->zstd_data, 0))
+		return -1;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2260,12 +2286,13 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto remap;
 	}
 
+	session->active_reader = rd;
 	size = event->header.size;
 
 	skip = -EINVAL;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, st->file_pos, rd->path)) < 0) {
+	    (skip = perf_session__process_event(session, event, st->file_pos, rd->path)) < 0) {
 		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
 		       st->file_offset + st->head, rd->path, event->header.size,
 		       event->header.type, strerror(-skip));
@@ -2292,6 +2319,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
+	session->active_reader = NULL;
 	return err;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index a03e028d09e8..7ff6a6b37afd 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -44,6 +44,7 @@ struct perf_session {
 	struct decomp		*decomp_last;
 	struct reader		*readers;
 	int			nr_readers;
+	struct reader		*active_reader;
 };
 
 struct decomp {
-- 
2.19.0

