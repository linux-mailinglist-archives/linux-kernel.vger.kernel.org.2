Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12E31A0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhBLOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:46:52 -0500
Received: from foss.arm.com ([217.140.110.172]:38078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhBLOq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:46:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE950139F;
        Fri, 12 Feb 2021 06:45:42 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03DEE3F73D;
        Fri, 12 Feb 2021 06:45:38 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] perf cs-etm: Only search timestamp in current sample's queue.
Date:   Fri, 12 Feb 2021 16:45:08 +0200
Message-Id: <20210212144513.31765-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
References: <20210212144513.31765-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change initial timestamp search to only operate on the queue
related to the current event. In a later change the bounds
of the aux record will also be used to reset the decoder and
the record is only relevant to a single queue.

This change makes some files that had coresight data
but didn't syntesise any events start working and generating
events. I'm not sure of the reason for that. I'd expect this
change to only affect the ordering of events.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 27894facae5e..8f8b448632fb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -97,7 +97,7 @@ struct cs_etm_queue {
 /* RB tree for quick conversion between traceID and metadata pointers */
 static struct intlist *traceid_list;
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
@@ -524,7 +524,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 static int cs_etm__flush_events(struct perf_session *session,
 				struct perf_tool *tool)
 {
-	int ret;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
@@ -534,11 +533,6 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	ret = cs_etm__update_queues(etm);
-
-	if (ret < 0)
-		return ret;
-
 	if (etm->timeless_decoding)
 		return cs_etm__process_timeless_queues(etm, -1);
 
@@ -851,10 +845,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	etmq->offset = 0;
 
-	if (etm->timeless_decoding)
-		return 0;
-	else
-		return cs_etm__search_first_timestamp(etmq);
+	return 0;
 }
 
 static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
@@ -874,14 +865,20 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
 {
+	int ret;
 	if (etm->queues.new_data) {
 		etm->queues.new_data = false;
-		return cs_etm__setup_queues(etm);
+		ret = cs_etm__setup_queues(etm);
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	if (!etm->timeless_decoding)
+		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
+	else
+		return 0;
 }
 
 static inline
@@ -2358,8 +2355,9 @@ static int cs_etm__process_event(struct perf_session *session,
 	else
 		timestamp = 0;
 
-	if (timestamp || etm->timeless_decoding) {
-		err = cs_etm__update_queues(etm);
+	if ((timestamp || etm->timeless_decoding)
+			&& event->header.type == PERF_RECORD_AUX) {
+		err = cs_etm__update_queues(etm, sample->cpu);
 		if (err)
 			return err;
 	}
-- 
2.28.0

