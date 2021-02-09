Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF4314C87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBIKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:06:34 -0500
Received: from foss.arm.com ([217.140.110.172]:48706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhBIKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:00:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 752CC113E;
        Tue,  9 Feb 2021 01:59:27 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58C983F73B;
        Tue,  9 Feb 2021 01:59:24 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] perf cs-etm: Save aux records in each etm queue
Date:   Tue,  9 Feb 2021 11:58:55 +0200
Message-Id: <20210209095857.28419-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210209095857.28419-1-james.clark@arm.com>
References: <20210209095857.28419-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aux records will be used set the bounds of decoding in a
later commit. In the future we may also want to use the flags
of each record to control decoding.

Do these need to be saved in their entirety, or can pointers
to each record safely be saved instead for later access?

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9ebe43d60d1e..efe418a7c82e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -92,12 +92,16 @@ struct cs_etm_queue {
 	/* Conversion between traceID and index in traceid_queues array */
 	struct intlist *traceid_queues_list;
 	struct cs_etm_traceid_queue **traceid_queues;
+	int aux_record_list_len;
+	int aux_record_list_idx;
+	struct perf_record_aux *aux_record_list;
 };
 
 /* RB tree for quick conversion between traceID and metadata pointers */
 static struct intlist *traceid_list;
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu,
+				 struct perf_record_aux *aux_record);
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
@@ -593,6 +597,7 @@ static void cs_etm__free_queue(void *priv)
 
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
+	free(etmq->aux_record_list);
 	free(etmq);
 }
 
@@ -767,13 +772,22 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	return NULL;
 }
 
-static int cs_etm__seach_first_timestamp(struct cs_etm_queue *etmq)
+static int cs_etm__seach_first_timestamp(struct cs_etm_queue *etmq,
+					 struct perf_record_aux *aux_record)
 {
 	int ret = 0;
 	u64 timestamp;
 	unsigned int cs_queue_nr;
 	u8 trace_chan_id;
 
+	etmq->aux_record_list = reallocarray(etmq->aux_record_list,
+					      etmq->aux_record_list_len+1,
+					      sizeof(*etmq->aux_record_list));
+	if (!etmq->aux_record_list)
+		return -ENOMEM;
+
+	etmq->aux_record_list[etmq->aux_record_list_len++] = *aux_record;
+
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
 	 * when the code that generated the traces started to execute so that
@@ -873,7 +887,7 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu, struct perf_record_aux *aux)
 {
 	int ret;
 	if (etm->queues.new_data) {
@@ -884,7 +898,7 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
 	}
 
 	if (!etm->timeless_decoding)
-		return cs_etm__seach_first_timestamp(etm->queues.queue_array[cpu].priv);
+		return cs_etm__seach_first_timestamp(etm->queues.queue_array[cpu].priv, aux);
 	else
 		return 0;
 }
@@ -2365,7 +2379,7 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if ((timestamp || etm->timeless_decoding)
 			&& event->header.type == PERF_RECORD_AUX) {
-		err = cs_etm__update_queues(etm, sample->cpu);
+		err = cs_etm__update_queues(etm, sample->cpu, &event->aux);
 		if (err)
 			return err;
 	}
-- 
2.28.0

