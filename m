Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27431A0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBLOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:47:42 -0500
Received: from foss.arm.com ([217.140.110.172]:38210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBLOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:47:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A766143D;
        Fri, 12 Feb 2021 06:45:59 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4AA83F73D;
        Fri, 12 Feb 2021 06:45:55 -0800 (PST)
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
Subject: [PATCH 6/7] perf cs-etm: Use existing decode code path for --dump-raw-trace
Date:   Fri, 12 Feb 2021 16:45:12 +0200
Message-Id: <20210212144513.31765-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
References: <20210212144513.31765-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the dump mode created a new decoder for each buffer
and had a different decode loop to the main code paths.

This change uses more of the existing code path which tracks
aux records and resets the decoder between each one. Unfortunately
the decoder is quite noisy when being reset, so printing has to
be suppressed around each call to reset.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 91 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3026fcf50b5d..dc4885794859 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -474,56 +474,21 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 	return ret;
 }
 
-static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
-			       struct auxtrace_buffer *buffer)
+static void cs_etm__dump_event(struct cs_etm_queue *etmq)
 {
-	int ret;
 	const char *color = PERF_COLOR_BLUE;
-	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params *t_params;
-	struct cs_etm_decoder *decoder;
-	size_t buffer_used = 0;
+
+	if (etmq->aux_record_list_idx >= etmq->aux_record_list_len)
+		return;
 
 	fprintf(stdout, "\n");
 	color_fprintf(stdout, color,
 		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
-		     buffer->size);
-
-	/* Use metadata to fill in trace parameters for trace decoder */
-	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
-
-	if (!t_params)
-		return;
-
-	if (cs_etm__init_trace_params(t_params, etm))
-		goto out_free;
-
-	/* Set decoder parameters to simply print the trace packets */
-	if (cs_etm__init_decoder_params(&d_params, NULL,
-					CS_ETM_OPERATION_PRINT))
-		goto out_free;
-
-	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
+		     etmq->aux_record_list[etmq->aux_record_list_idx].aux_size);
 
-	if (!decoder)
-		goto out_free;
-	do {
-		size_t consumed;
-
-		ret = cs_etm_decoder__process_data_block(
-				decoder, buffer->offset,
-				&((u8 *)buffer->data)[buffer_used],
-				buffer->size - buffer_used, &consumed);
-		if (ret)
+	while (1)
+		if (cs_etm__decode_data_block(etmq) <= 0)
 			break;
-
-		buffer_used += consumed;
-	} while (buffer_used < buffer->size);
-
-	cs_etm_decoder__free(decoder);
-
-out_free:
-	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -735,9 +700,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
-	if (cs_etm__init_decoder_params(&d_params, etmq,
-					CS_ETM_OPERATION_DECODE))
-		goto out_free;
+	if (dump_trace) {
+		if (cs_etm__init_decoder_params(&d_params, NULL,
+					CS_ETM_OPERATION_PRINT))
+			goto out_free;
+	} else {
+		if (cs_etm__init_decoder_params(&d_params, etmq,
+						CS_ETM_OPERATION_DECODE))
+			goto out_free;
+	}
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
@@ -903,7 +874,7 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu, struct pe
 	if (ret)
 		return ret;
 
-	if (!etm->timeless_decoding)
+	if (!etm->timeless_decoding && !dump_trace)
 		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
 	else
 		return 0;
@@ -1647,6 +1618,9 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
 	int ret;
 
+	if (etmq->aux_record_list_idx >= etmq->aux_record_list_len)
+		return 0;
+
 	if (etmq->aux_record_list[etmq->aux_record_list_idx].aux_size <= 0) {
 		etmq->aux_record_list_idx++;
 		ret = cs_etm_decoder__reset(etmq->decoder);
@@ -2387,10 +2361,7 @@ static int cs_etm__process_event(struct perf_session *session,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 
-	if (dump_trace)
-		return 0;
-
-	if (!tool->ordered_events) {
+	if (!tool->ordered_events && !dump_trace) {
 		pr_err("CoreSight ETM Trace requires ordered events\n");
 		return -EINVAL;
 	}
@@ -2407,6 +2378,9 @@ static int cs_etm__process_event(struct perf_session *session,
 			return err;
 	}
 
+	if (dump_trace)
+		return 0;
+
 	if (etm->timeless_decoding &&
 	    event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
@@ -2424,6 +2398,9 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 					  union perf_event *event,
 					  struct perf_tool *tool __maybe_unused)
 {
+	unsigned int i;
+	struct auxtrace_queues *queues;
+	struct cs_etm_queue *etmq;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
@@ -2446,12 +2423,17 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 						 event, data_offset, &buffer);
 		if (err)
 			return err;
+	}
 
-		if (dump_trace)
-			if (auxtrace_buffer__get_data(buffer, fd)) {
-				cs_etm__dump_event(etm, buffer);
-				auxtrace_buffer__put_data(buffer);
+	if (dump_trace) {
+		queues = &etm->queues;
+		for (i = 0; i < queues->nr_queues; i++) {
+			etmq = queues->queue_array[i].priv;
+			if (etmq) {
+				while (cs_etm__get_data_block(etmq) > 0)
+					cs_etm__dump_event(etmq);
 			}
+		}
 	}
 
 	return 0;
@@ -2705,7 +2687,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
-		return 0;
 	}
 
 	if (session->itrace_synth_opts->set) {
-- 
2.28.0

