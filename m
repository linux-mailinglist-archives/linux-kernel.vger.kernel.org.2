Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EBB42235C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhJEK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:29:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:46740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhJEK3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:29:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225603018"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225603018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="714164500"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2021 03:27:11 -0700
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
Subject: [PATCH v2 2/5] perf session: Introduce decompressor in reader object
Date:   Tue,  5 Oct 2021 13:26:59 +0300
Message-Id: <f549ee7d25f10a8bacef6fa337566b8028c4433f.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing decompressor data structure with pointers to decomp
objects and to zstd object. We cannot just move session->zstd_data to
decomp_data as session->zstd_data is used not only for decompression.
Adding decompressor data object to reader object and introducing
active_decomp into perf_session object to select current decompressor.
Thus decompression could be executed separately for each data file.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 36 ++++++++++++++++++++++++------------
 tools/perf/util/session.h | 10 ++++++++--
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f29b106b1b17..50f2ec523ae0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -44,7 +44,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
 	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
-	struct decomp *decomp, *decomp_last = session->decomp_last;
+	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
 
 	if (decomp_last) {
 		decomp_last_rem = decomp_last->size - decomp_last->head;
@@ -71,7 +71,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	src = (void *)event + sizeof(struct perf_record_compressed);
 	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
-	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
@@ -81,12 +81,12 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 
 	decomp->size += decomp_size;
 
-	if (session->decomp == NULL) {
-		session->decomp = decomp;
-		session->decomp_last = decomp;
+	if (session->active_decomp->decomp == NULL) {
+		session->active_decomp->decomp = decomp;
+		session->active_decomp->decomp_last = decomp;
 	} else {
-		session->decomp_last->next = decomp;
-		session->decomp_last = decomp;
+		session->active_decomp->decomp_last->next = decomp;
+		session->active_decomp->decomp_last = decomp;
 	}
 
 	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
@@ -197,6 +197,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 
 	session->repipe = repipe;
 	session->tool   = tool;
+	session->decomp_data.zstd_decomp = &session->zstd_data;
+	session->active_decomp = &session->decomp_data;
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	machines__init(&session->machines);
 	ordered_events__init(&session->ordered_events,
@@ -276,11 +278,11 @@ static void perf_session__delete_threads(struct perf_session *session)
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
@@ -299,7 +301,7 @@ void perf_session__delete(struct perf_session *session)
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
 	perf_session__delete_threads(session);
-	perf_session__release_decomp_events(session);
+	perf_decomp__release_events(session->decomp_data.decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data) {
@@ -2117,7 +2119,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 {
 	s64 skip;
 	u64 size, file_pos = 0;
-	struct decomp *decomp = session->decomp_last;
+	struct decomp *decomp = session->active_decomp->decomp_last;
 
 	if (!decomp)
 		return 0;
@@ -2183,6 +2185,8 @@ struct reader {
 	reader_cb_t	 process;
 	bool		 in_place_update;
 	struct reader_state state;
+	struct zstd_data    zstd_data;
+	struct decomp_data  decomp_data;
 };
 
 static int
@@ -2212,6 +2216,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	memset(mmaps, 0, sizeof(st->mmaps));
 
+	if (zstd_init(&rd->zstd_data, 0))
+		return -1;
+	rd->decomp_data.zstd_decomp = &rd->zstd_data;
+
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
@@ -2255,6 +2263,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto remap;
 	}
 
+	session->active_decomp = &rd->decomp_data;
 	size = event->header.size;
 
 	skip = -EINVAL;
@@ -2287,6 +2296,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
+	session->active_decomp = &session->decomp_data;
+	perf_decomp__release_events(rd->decomp_data.decomp);
+	zstd_fini(&rd->zstd_data);
 	return err;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 5d8bd14a0a39..46c854292ad6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -20,6 +20,12 @@ struct thread;
 struct auxtrace;
 struct itrace_synth_opts;
 
+struct decomp_data {
+	struct decomp	 *decomp;
+	struct decomp	 *decomp_last;
+	struct zstd_data *zstd_decomp;
+};
+
 struct perf_session {
 	struct perf_header	header;
 	struct machines		machines;
@@ -39,8 +45,8 @@ struct perf_session {
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
-	struct decomp		*decomp;
-	struct decomp		*decomp_last;
+	struct decomp_data	decomp_data;
+	struct decomp_data	*active_decomp;
 };
 
 struct decomp {
-- 
2.19.0

