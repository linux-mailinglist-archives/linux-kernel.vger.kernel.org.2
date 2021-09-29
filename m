Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0C41C0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244865AbhI2Inu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:43:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:13702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244854AbhI2Int (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:43:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288550383"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="288550383"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 01:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="520757349"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2021 01:42:05 -0700
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
Subject: [PATCH 3/6] perf session: Introduce decompressor into reader object
Date:   Wed, 29 Sep 2021 11:41:51 +0300
Message-Id: <92dd8a7b9cf92f856cdd38114fc33eda4c5aba1a.1632900802.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce decompressor into reader object so that decompression
could be executed separately for each data file. Adding active_reader
into perf_session object to select current decompressor.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++----------
 tools/perf/util/session.h |  2 ++
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 262efc18caac..3bea0830b3b8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -71,6 +71,9 @@ struct reader {
 	u64		 data_offset;
 	reader_cb_t	 process;
 	bool		 in_place_update;
+	struct zstd_data zstd_data;
+	struct decomp	 *decomp;
+	struct decomp	 *decomp_last;
 	struct reader_state state;
 };
 
@@ -82,7 +85,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
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
@@ -109,7 +115,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	src = (void *)event + sizeof(struct perf_record_compressed);
 	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
-	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
@@ -119,12 +125,22 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 
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
@@ -314,11 +330,11 @@ static void perf_session__delete_threads(struct perf_session *session)
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
@@ -337,7 +353,7 @@ void perf_session__delete(struct perf_session *session)
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
-	perf_session__release_decomp_events(session);
+	perf_decomp__release_events(session->decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data) {
@@ -2155,7 +2171,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
 	u64 size, file_pos = 0;
-	struct decomp *decomp = session->decomp_last;
+	struct decomp *decomp = session->active_reader ?
+		session->active_reader->decomp_last : session->decomp_last;
 
 	if (!decomp)
 		return 0;
@@ -2212,6 +2229,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	memset(mmaps, 0, sizeof(st->mmaps));
 
+	if (zstd_init(&rd->zstd_data, 0))
+		return -1;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2255,6 +2275,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto remap;
 	}
 
+	session->active_reader = rd;
 	size = event->header.size;
 
 	skip = -EINVAL;
@@ -2287,6 +2308,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
+	session->active_reader = NULL;
+	perf_decomp__release_events(rd->decomp);
+	zstd_fini(&rd->zstd_data);
 	return err;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 5d8bd14a0a39..45f9f652a12a 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -19,6 +19,7 @@ struct thread;
 
 struct auxtrace;
 struct itrace_synth_opts;
+struct reader;
 
 struct perf_session {
 	struct perf_header	header;
@@ -41,6 +42,7 @@ struct perf_session {
 	struct zstd_data	zstd_data;
 	struct decomp		*decomp;
 	struct decomp		*decomp_last;
+	struct reader           *active_reader;
 };
 
 struct decomp {
-- 
2.19.0

