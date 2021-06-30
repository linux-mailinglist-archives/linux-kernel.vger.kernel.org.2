Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17C3B86AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhF3QCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:02:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:4075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236177AbhF3QBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:01:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230016087"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="230016087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="559099899"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2021 08:56:11 -0700
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
Subject: [PATCH v8 21/22] perf session: Introduce READER_NODATA state
Date:   Wed, 30 Jun 2021 18:55:00 +0300
Message-Id: <17c991ec0d814a5718dc49ae08cabc3210b4a133.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding READER_NODATA state to differentiate it from the real end-of-file
state. Also an indent depth in reades initialization loop is reduced.

Suggested-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 45 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b11a502c22a3..c2b6c5f4e119 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -70,7 +70,8 @@ struct reader_state {
 
 enum {
 	READER_EOF	=  0,
-	READER_OK	=  1,
+	READER_NODATA	=  1,
+	READER_OK	=  2,
 };
 
 struct reader {
@@ -2305,7 +2306,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 		return PTR_ERR(event);
 
 	if (!event)
-		return READER_EOF;
+		return READER_NODATA;
 
 	session->active_reader = rd;
 	size = event->header.size;
@@ -2395,7 +2396,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		err = reader__read_event(rd, session, &prog);
 		if (err < 0)
 			break;
-		if (err == READER_EOF) {
+		if (err == READER_NODATA) {
 			err = reader__mmap(rd, session);
 			if (err <= 0)
 				break;
@@ -2472,25 +2473,25 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	readers++;
 
 	for (i = 0; i < data->dir.nr; i++) {
-		if (data->dir.files[i].size) {
-			rd[readers] = (struct reader) {
-				.fd		 = data->dir.files[i].fd,
-				.path		 = data->dir.files[i].path,
-				.data_size	 = data->dir.files[i].size,
-				.data_offset	 = 0,
-				.in_place_update = session->data->in_place_update,
-			};
-			ret = reader__init(&rd[readers], NULL);
-			if (ret)
-				goto out_err;
-			ret = reader__mmap(&rd[readers], session);
-			if (ret != READER_OK) {
-				if (ret == READER_EOF)
-					ret = -EINVAL;
-				goto out_err;
-			}
-			readers++;
+		if (!data->dir.files[i].size)
+			continue;
+		rd[readers] = (struct reader) {
+			.fd		 = data->dir.files[i].fd,
+			.path		 = data->dir.files[i].path,
+			.data_size	 = data->dir.files[i].size,
+			.data_offset	 = 0,
+			.in_place_update = session->data->in_place_update,
+		};
+		ret = reader__init(&rd[readers], NULL);
+		if (ret)
+			goto out_err;
+		ret = reader__mmap(&rd[readers], session);
+		if (ret != READER_OK) {
+			if (ret == READER_EOF)
+				ret = -EINVAL;
+			goto out_err;
 		}
+		readers++;
 	}
 
 	i = 0;
@@ -2507,7 +2508,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 		ret = reader__read_event(&rd[i], session, &prog);
 		if (ret < 0)
 			break;
-		if (ret == READER_EOF) {
+		if (ret == READER_NODATA) {
 			ret = reader__mmap(&rd[i], session);
 			if (ret < 0)
 				goto out_err;
-- 
2.19.0

