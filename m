Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F24391586
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhEZK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:56:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:1596 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234315AbhEZK4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:56:14 -0400
IronPort-SDR: vJuseGlwK/QrL+/NXiwkrSwWVqU2Pb/GAyfTazdt3k7D7XtsiZq/ZWg2V+dcpdhWzBILI1eauH
 n1EekmMHOakw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189556511"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189556511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 03:54:07 -0700
IronPort-SDR: 19ofcU29n48ff0+eqSt1NoQN1cuN/UQQ3iCGNCs4iMWexLgYx9LvY/+hst7Lva5BKnDA+427lS
 ArEgLqYhHkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="436079412"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2021 03:54:04 -0700
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
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH v6 16/20] perf session: Introduce decompressor into trace reader object
Date:   Wed, 26 May 2021 13:53:09 +0300
Message-Id: <ec370117b49575be493add488a07450517c78aaf.1622025774.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce decompressor into trace reader object so that decompression
could be executed on per data file basis separately for every data
file located in data directory.

Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 51 +++++++++++++++++++++++++++++----------
 tools/perf/util/session.h |  1 +
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 335c073bae87..6c9a682eb291 100644
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
@@ -319,11 +335,10 @@ static void perf_session__delete_threads(struct perf_session *session)
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
@@ -336,6 +351,8 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 
 void perf_session__delete(struct perf_session *session)
 {
+	int r;
+
 	if (session == NULL)
 		return;
 	auxtrace__free(session);
@@ -343,10 +360,12 @@ void perf_session__delete(struct perf_session *session)
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
 	if (session->readers) {
+		for (r = 0; r < session->nr_readers; r++)
+			perf_decomp__release_events(session->readers[r].decomp);
 		zfree(&session->readers);
 		session->nr_readers = 0;
 	}
-	perf_session__release_decomp_events(session);
+	perf_decomp__release_events(session->decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data)
@@ -2157,7 +2176,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
 	u64 size;
-	struct decomp *decomp = session->decomp_last;
+	struct decomp *decomp = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
 
 	if (!decomp)
 		return 0;
@@ -2214,6 +2234,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	memset(mmaps, 0, sizeof(st->mmaps));
 
+	if (zstd_init(&rd->zstd_data, 0))
+		return -1;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2257,12 +2280,13 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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
@@ -2289,6 +2313,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
+	session->active_reader = NULL;
 	return err;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 2815d00b5467..e0a8712f8770 100644
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

