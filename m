Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC70C3790DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEJOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:35:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238391AbhEJOeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:34:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 509601688;
        Mon, 10 May 2021 07:32:59 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.83.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D08C73F719;
        Mon, 10 May 2021 07:32:54 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] perf cs-etm: Refactor timestamp variable names
Date:   Mon, 10 May 2021 17:32:47 +0300
Message-Id: <20210510143248.27423-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210510143248.27423-1-james.clark@arm.com>
References: <20210510143248.27423-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ambiguity in variable names relating to timestamps.
A later commit will save the sample kernel timestamp in one
of the etm structs, so name all elements appropriately to
avoid confusion.

This is also removes some ambiguity arising from the fact
that the --timestamp argument to perf record refers to
sample kernel timestamps, and the /timestamp/ event modifier
refers to CS timestamps, so the term is overloaded.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 ++++----
 tools/perf/util/cs-etm.c                      | 42 +++++++++----------
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 059bcec3f651..b01d363b9301 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -276,13 +276,13 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 				  const uint8_t trace_chan_id)
 {
 	/* No timestamp packet has been received, nothing to do */
-	if (!packet_queue->timestamp)
+	if (!packet_queue->cs_timestamp)
 		return OCSD_RESP_CONT;
 
-	packet_queue->timestamp = packet_queue->next_timestamp;
+	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
 
 	/* Estimate the timestamp for the next range packet */
-	packet_queue->next_timestamp += packet_queue->instr_count;
+	packet_queue->next_cs_timestamp += packet_queue->instr_count;
 	packet_queue->instr_count = 0;
 
 	/* Tell the front end which traceid_queue needs attention */
@@ -308,8 +308,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	 * Function do_soft_timestamp() will report the value to the front end,
 	 * hence asking the decoder to keep decoding rather than stopping.
 	 */
-	if (packet_queue->timestamp) {
-		packet_queue->next_timestamp = elem->timestamp;
+	if (packet_queue->cs_timestamp) {
+		packet_queue->next_cs_timestamp = elem->timestamp;
 		return OCSD_RESP_CONT;
 	}
 
@@ -320,8 +320,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	 * which instructions started by subtracting the number of instructions
 	 * executed to the timestamp.
 	 */
-	packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
-	packet_queue->next_timestamp = elem->timestamp;
+	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
+	packet_queue->next_cs_timestamp = elem->timestamp;
 	packet_queue->instr_count = 0;
 
 	/* Tell the front end which traceid_queue needs attention */
@@ -334,8 +334,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 static void
 cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 {
-	packet_queue->timestamp = 0;
-	packet_queue->next_timestamp = 0;
+	packet_queue->cs_timestamp = 0;
+	packet_queue->next_cs_timestamp = 0;
 	packet_queue->instr_count = 0;
 }
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 7e63e7dedc33..533f6f2f0685 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -38,8 +38,6 @@
 #include <tools/libc_compat.h>
 #include "util/synthetic-events.h"
 
-#define MAX_TIMESTAMP (~0ULL)
-
 struct cs_etm_auxtrace {
 	struct auxtrace auxtrace;
 	struct auxtrace_queues queues;
@@ -86,7 +84,7 @@ struct cs_etm_queue {
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
-	u8 pending_timestamp;
+	u8 pending_timestamp_chan_id;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -208,7 +206,7 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 	 * be more than one channel per cs_etm_queue, we need to specify
 	 * what traceID queue needs servicing.
 	 */
-	etmq->pending_timestamp = trace_chan_id;
+	etmq->pending_timestamp_chan_id = trace_chan_id;
 }
 
 static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
@@ -216,22 +214,22 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet_queue *packet_queue;
 
-	if (!etmq->pending_timestamp)
+	if (!etmq->pending_timestamp_chan_id)
 		return 0;
 
 	if (trace_chan_id)
-		*trace_chan_id = etmq->pending_timestamp;
+		*trace_chan_id = etmq->pending_timestamp_chan_id;
 
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
-						     etmq->pending_timestamp);
+						     etmq->pending_timestamp_chan_id);
 	if (!packet_queue)
 		return 0;
 
 	/* Acknowledge pending status */
-	etmq->pending_timestamp = 0;
+	etmq->pending_timestamp_chan_id = 0;
 
 	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
-	return packet_queue->timestamp;
+	return packet_queue->cs_timestamp;
 }
 
 static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
@@ -814,7 +812,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	int ret = 0;
 	unsigned int cs_queue_nr;
 	u8 trace_chan_id;
-	u64 timestamp;
+	u64 cs_timestamp;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
@@ -854,7 +852,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 
 		/*
 		 * Run decoder on the trace block.  The decoder will stop when
-		 * encountering a timestamp, a full packet queue or the end of
+		 * encountering a CS timestamp, a full packet queue or the end of
 		 * trace for that block.
 		 */
 		ret = cs_etm__decode_data_block(etmq);
@@ -865,10 +863,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
 		 * the timestamp calculation for us.
 		 */
-		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
 
 		/* We found a timestamp, no need to continue. */
-		if (timestamp)
+		if (cs_timestamp)
 			break;
 
 		/*
@@ -892,7 +890,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	 * queue and will be processed in cs_etm__process_queues().
 	 */
 	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
-	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
+	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
 out:
 	return ret;
 }
@@ -2221,7 +2219,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 	int ret = 0;
 	unsigned int cs_queue_nr, queue_nr;
 	u8 trace_chan_id;
-	u64 timestamp;
+	u64 cs_timestamp;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
 	struct cs_etm_traceid_queue *tidq;
@@ -2283,9 +2281,9 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 		if (ret)
 			goto out;
 
-		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
 
-		if (!timestamp) {
+		if (!cs_timestamp) {
 			/*
 			 * Function cs_etm__decode_data_block() returns when
 			 * there is no more traces to decode in the current
@@ -2308,7 +2306,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 		 * this queue/traceID.
 		 */
 		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
-		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
+		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
 	}
 
 out:
@@ -2380,7 +2378,7 @@ static int cs_etm__process_event(struct perf_session *session,
 				 struct perf_tool *tool)
 {
 	int err = 0;
-	u64 timestamp;
+	u64 sample_kernel_timestamp;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
@@ -2394,11 +2392,11 @@ static int cs_etm__process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		sample_kernel_timestamp = sample->time;
 	else
-		timestamp = 0;
+		sample_kernel_timestamp = 0;
 
-	if (timestamp || etm->timeless_decoding) {
+	if (sample_kernel_timestamp || etm->timeless_decoding) {
 		err = cs_etm__update_queues(etm);
 		if (err)
 			return err;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 36428918411e..d65c7b19407d 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -171,8 +171,8 @@ struct cs_etm_packet_queue {
 	u32 head;
 	u32 tail;
 	u32 instr_count;
-	u64 timestamp;
-	u64 next_timestamp;
+	u64 cs_timestamp;
+	u64 next_cs_timestamp;
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 
-- 
2.28.0

