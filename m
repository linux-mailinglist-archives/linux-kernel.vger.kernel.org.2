Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA5314CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBIKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:17:59 -0500
Received: from foss.arm.com ([217.140.110.172]:48822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhBIKCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5907B13D5;
        Tue,  9 Feb 2021 01:59:35 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 468803F73B;
        Tue,  9 Feb 2021 01:59:32 -0800 (PST)
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
Subject: [RFC PATCH 5/5] perf cs-etm: split decode by aux records.
Date:   Tue,  9 Feb 2021 11:58:57 +0200
Message-Id: <20210209095857.28419-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210209095857.28419-1-james.clark@arm.com>
References: <20210209095857.28419-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace data between aux records is not continuous, so the decoder
must be reset between each record to ensure that parsing happens
correctly and without any early exits.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 108 ++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0aaa1f6d2822..b0f464a50e2f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -95,6 +95,7 @@ struct cs_etm_queue {
 	int aux_record_list_len;
 	int aux_record_list_idx;
 	struct perf_record_aux *aux_record_list;
+	bool timestamp_found;
 };
 
 /* RB tree for quick conversion between traceID and metadata pointers */
@@ -788,6 +789,9 @@ static int cs_etm__seach_first_timestamp(struct cs_etm_queue *etmq,
 
 	etmq->aux_record_list[etmq->aux_record_list_len++] = *aux_record;
 
+	if (etmq->timestamp_found)
+		return 0;
+
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
 	 * when the code that generated the traces started to execute so that
@@ -796,56 +800,60 @@ static int cs_etm__seach_first_timestamp(struct cs_etm_queue *etmq,
 	 * timestamp.  The timestamp is then added to the auxtrace min heap
 	 * in order to know what nibble (of all the etmqs) to decode first.
 	 */
-	while (1) {
-		/*
-		 * Fetch an aux_buffer from this etmq.  Bail if no more
-		 * blocks or an error has been encountered.
-		 */
-		ret = cs_etm__get_data_block(etmq);
-		if (ret <= 0)
-			return ret;
-
-		/*
-		 * Run decoder on the trace block.  The decoder will stop when
-		 * encountering a timestamp, a full packet queue or the end of
-		 * trace for that block.
-		 */
-		ret = cs_etm__decode_data_block(etmq);
+	/*
+	 * Fetch an aux_buffer from this etmq.  Bail if no more
+	 * blocks or an error has been encountered.
+	 */
+	if (etmq->aux_record_list[etmq->aux_record_list_idx].aux_size <= 0) {
+		etmq->aux_record_list_idx++;
+		ret = cs_etm_decoder__reset(etmq->decoder);
 		if (ret)
 			return ret;
+	}
+	ret = cs_etm__get_data_block(etmq);
+	if (ret <= 0)
+		return ret;
 
-		/*
-		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
-		 * the timestamp calculation for us.
-		 */
-		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+	/*
+	 * Run decoder on the trace block.  The decoder will stop when
+	 * encountering a timestamp, a full packet queue or the end of
+	 * trace for that block.
+	 */
+	ret = cs_etm__decode_data_block(etmq);
+	if (ret)
+		return ret;
 
-		/* We found a timestamp, no need to continue. */
-		if (timestamp)
-			break;
+	/*
+	 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
+	 * the timestamp calculation for us.
+	 */
+	timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
 
+	/* We found a timestamp, no need to continue. */
+	if (timestamp) {
 		/*
-		 * We didn't find a timestamp so empty all the traceid packet
-		 * queues before looking for another timestamp packet, either
-		 * in the current data block or a new one.  Packets that were
-		 * just decoded are useless since no timestamp has been
-		 * associated with them.  As such simply discard them.
+		 * We have a timestamp.  Add it to the min heap to reflect when
+		 * instructions conveyed by the range packets of this traceID queue
+		 * started to execute.  Once the same has been done for all the traceID
+		 * queues of each etmq, redenring and decoding can start in
+		 * chronological order.
+		 *
+		 * Note that packets decoded above are still in the traceID's packet
+		 * queue and will be processed in cs_etm__process_queues().
 		 */
-		cs_etm__clear_all_packet_queues(etmq);
+		etmq->timestamp_found = true;
+		cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
+		return auxtrace_heap__add(&etmq->etm->heap, cs_queue_nr, timestamp);
 	}
-
 	/*
-	 * We have a timestamp.  Add it to the min heap to reflect when
-	 * instructions conveyed by the range packets of this traceID queue
-	 * started to execute.  Once the same has been done for all the traceID
-	 * queues of each etmq, redenring and decoding can start in
-	 * chronological order.
-	 *
-	 * Note that packets decoded above are still in the traceID's packet
-	 * queue and will be processed in cs_etm__process_queues().
+	 * We didn't find a timestamp so empty all the traceid packet
+	 * queues before looking for another timestamp packet, either
+	 * in the current data block or a new one.  Packets that were
+	 * just decoded are useless since no timestamp has been
+	 * associated with them.  As such simply discard them.
 	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
-	return auxtrace_heap__add(&etmq->etm->heap, cs_queue_nr, timestamp);
+	cs_etm__clear_all_packet_queues(etmq);
+	return 0;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
@@ -2012,6 +2020,15 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 {
 	int ret = 0;
 	size_t processed = 0;
+	u64 decode_size;
+
+	if (etmq->aux_record_list_idx >= etmq->aux_record_list_len ||
+		etmq->aux_record_list[etmq->aux_record_list_idx].aux_size > etmq->buf_len) {
+		// Assume that aux records always equally divide up the aux buffer
+		// so aux_size should never exceed the remaining buffer to decode.
+		ret = -1;
+		goto out;
+	}
 
 	/*
 	 * Packets are decoded and added to the decoder's packet queue
@@ -2020,10 +2037,11 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	 * operations that stop processing are a timestamp packet or a full
 	 * decoder buffer queue.
 	 */
+	decode_size = etmq->aux_record_list[etmq->aux_record_list_idx].aux_size;
 	ret = cs_etm_decoder__process_data_block(etmq->decoder,
 						 etmq->offset,
 						 &etmq->buf[etmq->buf_used],
-						 etmq->buf_len,
+						 decode_size,
 						 &processed);
 	if (ret)
 		goto out;
@@ -2031,7 +2049,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	etmq->offset += processed;
 	etmq->buf_used += processed;
 	etmq->buf_len -= processed;
-
+	etmq->aux_record_list[etmq->aux_record_list_idx].aux_size -= processed;
 out:
 	return ret;
 }
@@ -2247,6 +2265,12 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 		 * if need be.
 		 */
 refetch:
+		if (etmq->aux_record_list[etmq->aux_record_list_idx].aux_size <= 0) {
+			etmq->aux_record_list_idx++;
+			ret = cs_etm_decoder__reset(etmq->decoder);
+			if (ret)
+				return ret;
+		}
 		ret = cs_etm__get_data_block(etmq);
 		if (ret < 0)
 			goto out;
-- 
2.28.0

