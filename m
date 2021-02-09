Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FF314C71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBIKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:04:50 -0500
Received: from foss.arm.com ([217.140.110.172]:48668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhBIKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:00:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEF21042;
        Tue,  9 Feb 2021 01:59:19 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 616373F73B;
        Tue,  9 Feb 2021 01:59:16 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] perf cs-etm: Split up etm queue setup function
Date:   Tue,  9 Feb 2021 11:58:53 +0200
Message-Id: <20210209095857.28419-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210209095857.28419-1-james.clark@arm.com>
References: <20210209095857.28419-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the function into separate allocation and
timestamp search parts. Later the timestamp search
will be done multiple times.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..440001cdd3b8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -765,33 +765,12 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	return NULL;
 }
 
-static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
-			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr)
+static int cs_etm__seach_first_timestamp(struct cs_etm_queue *etmq)
 {
 	int ret = 0;
+	u64 timestamp;
 	unsigned int cs_queue_nr;
 	u8 trace_chan_id;
-	u64 timestamp;
-	struct cs_etm_queue *etmq = queue->priv;
-
-	if (list_empty(&queue->head) || etmq)
-		goto out;
-
-	etmq = cs_etm__alloc_queue(etm);
-
-	if (!etmq) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	queue->priv = etmq;
-	etmq->etm = etm;
-	etmq->queue_nr = queue_nr;
-	etmq->offset = 0;
-
-	if (etm->timeless_decoding)
-		goto out;
 
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
@@ -808,7 +787,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 		 */
 		ret = cs_etm__get_data_block(etmq);
 		if (ret <= 0)
-			goto out;
+			return ret;
 
 		/*
 		 * Run decoder on the trace block.  The decoder will stop when
@@ -817,7 +796,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 		 */
 		ret = cs_etm__decode_data_block(etmq);
 		if (ret)
-			goto out;
+			return ret;
 
 		/*
 		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
@@ -849,10 +828,33 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	 * Note that packets decoded above are still in the traceID's packet
 	 * queue and will be processed in cs_etm__process_queues().
 	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
-	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
-out:
-	return ret;
+	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
+	return auxtrace_heap__add(&etmq->etm->heap, cs_queue_nr, timestamp);
+}
+
+static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
+			       struct auxtrace_queue *queue,
+			       unsigned int queue_nr)
+{
+	struct cs_etm_queue *etmq = queue->priv;
+
+	if (list_empty(&queue->head) || etmq)
+		return 0;
+
+	etmq = cs_etm__alloc_queue(etm);
+
+	if (!etmq)
+		return -ENOMEM;
+
+	queue->priv = etmq;
+	etmq->etm = etm;
+	etmq->queue_nr = queue_nr;
+	etmq->offset = 0;
+
+	if (etm->timeless_decoding)
+		return 0;
+	else
+		return cs_etm__seach_first_timestamp(etmq);
 }
 
 static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
-- 
2.28.0

