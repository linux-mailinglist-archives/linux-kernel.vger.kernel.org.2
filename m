Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07031A0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBLOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:47:50 -0500
Received: from foss.arm.com ([217.140.110.172]:38212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhBLOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:47:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011061435;
        Fri, 12 Feb 2021 06:45:55 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A5943F73D;
        Fri, 12 Feb 2021 06:45:51 -0800 (PST)
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
Subject: [PATCH 5/7] perf cs-etm: split decode by aux records.
Date:   Fri, 12 Feb 2021 16:45:11 +0200
Message-Id: <20210212144513.31765-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
References: <20210212144513.31765-1-james.clark@arm.com>
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
 tools/perf/util/cs-etm.c | 109 +++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5ab037c2dabe..3026fcf50b5d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -95,6 +95,7 @@ struct cs_etm_queue {
 	int aux_record_list_len;
 	int aux_record_list_idx;
 	struct perf_record_aux *aux_record_list;
+	bool timestamp_found;
 };
 
 /* RB tree for quick conversion between traceID and metadata pointers */
@@ -784,6 +785,9 @@ static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
 	unsigned int cs_queue_nr;
 	u8 trace_chan_id;
 
+	if (etmq->timestamp_found)
+		return 0;
+
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
 	 * when the code that generated the traces started to execute so that
@@ -792,56 +796,54 @@ static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
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
-		if (ret)
-			return ret;
+	/*
+	 * Fetch an aux_buffer from this etmq.  Bail if no more
+	 * blocks or an error has been encountered.
+	 */
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
@@ -1645,6 +1647,13 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
 	int ret;
 
+	if (etmq->aux_record_list[etmq->aux_record_list_idx].aux_size <= 0) {
+		etmq->aux_record_list_idx++;
+		ret = cs_etm_decoder__reset(etmq->decoder);
+		if (ret)
+			return ret;
+	}
+
 	if (!etmq->buf_len) {
 		ret = cs_etm__get_trace(etmq);
 		if (ret <= 0)
@@ -2016,6 +2025,15 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
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
@@ -2024,10 +2042,11 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
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
@@ -2035,7 +2054,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	etmq->offset += processed;
 	etmq->buf_used += processed;
 	etmq->buf_len -= processed;
-
+	etmq->aux_record_list[etmq->aux_record_list_idx].aux_size -= processed;
 out:
 	return ret;
 }
@@ -2160,7 +2179,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			 */
 			err = cs_etm__process_traceid_queue(etmq, tidq);
 
-		} while (etmq->buf_len);
+		} while (etmq->aux_record_list[etmq->aux_record_list_idx].aux_size > 0);
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-- 
2.28.0

