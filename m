Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284743D11E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbhGUOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:24:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239520AbhGUOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:22:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED9731B;
        Wed, 21 Jul 2021 08:02:26 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A52F3F73D;
        Wed, 21 Jul 2021 08:02:24 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] perf cs-etm: Use existing decoder instead of resetting it
Date:   Wed, 21 Jul 2021 16:02:01 +0100
Message-Id: <20210721150202.32065-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping trace, the decoder is continually deleted and recreated to
decode each buffer. To support both formatted and unformatted trace in
a later commit, the decoder will be configured in advance.

This commit removes the deletion of the decoder and allows the
formatted/unformatted setting to persist.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d07e52ffd3c..760050ea936d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -508,14 +508,11 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 	return ret;
 }
 
-static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
+static void cs_etm__dump_event(struct cs_etm_queue *etmq,
 			       struct auxtrace_buffer *buffer)
 {
 	int ret;
 	const char *color = PERF_COLOR_BLUE;
-	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params *t_params;
-	struct cs_etm_decoder *decoder;
 	size_t buffer_used = 0;
 
 	fprintf(stdout, "\n");
@@ -523,29 +520,11 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
 		     buffer->size);
 
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
-
-	if (!decoder)
-		goto out_free;
 	do {
 		size_t consumed;
 
 		ret = cs_etm_decoder__process_data_block(
-				decoder, buffer->offset,
+				etmq->decoder, buffer->offset,
 				&((u8 *)buffer->data)[buffer_used],
 				buffer->size - buffer_used, &consumed);
 		if (ret)
@@ -554,10 +533,7 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 		buffer_used += consumed;
 	} while (buffer_used < buffer->size);
 
-	cs_etm_decoder__free(decoder);
-
-out_free:
-	zfree(&t_params);
+	cs_etm_decoder__reset(etmq->decoder);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -769,7 +745,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 
 	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
-					CS_ETM_OPERATION_DECODE))
+					dump_trace ? CS_ETM_OPERATION_PRINT :
+						     CS_ETM_OPERATION_DECODE))
 		goto out_free;
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
@@ -2422,7 +2399,7 @@ static void dump_queued_data(struct cs_etm_auxtrace *etm,
 	for (i = 0; i < etm->queues.nr_queues; ++i)
 		list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
 			if (buf->reference == event->reference)
-				cs_etm__dump_event(etm, buf);
+				cs_etm__dump_event(etm->queues.queue_array[i].priv, buf);
 }
 
 static int cs_etm__process_auxtrace_event(struct perf_session *session,
@@ -2460,7 +2437,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 
 		if (dump_trace)
 			if (auxtrace_buffer__get_data(buffer, fd)) {
-				cs_etm__dump_event(etm, buffer);
+				cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
 				auxtrace_buffer__put_data(buffer);
 			}
 	} else if (dump_trace)
-- 
2.28.0

