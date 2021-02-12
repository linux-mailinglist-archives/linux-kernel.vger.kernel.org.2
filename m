Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94931A0DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBLOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:47:08 -0500
Received: from foss.arm.com ([217.140.110.172]:38100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhBLOqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:46:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F0D13A1;
        Fri, 12 Feb 2021 06:45:46 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D5783F73D;
        Fri, 12 Feb 2021 06:45:43 -0800 (PST)
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
Subject: [PATCH 3/7] perf cs-etm: Save aux records in each etm queue
Date:   Fri, 12 Feb 2021 16:45:09 +0200
Message-Id: <20210212144513.31765-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
References: <20210212144513.31765-1-james.clark@arm.com>
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
 tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8f8b448632fb..88b541b2a804 100644
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
@@ -585,6 +589,7 @@ static void cs_etm__free_queue(void *priv)
 
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
+	free(etmq->aux_record_list);
 	free(etmq);
 }
 
@@ -759,6 +764,19 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	return NULL;
 }
 
+static int cs_etm__save_aux_record(struct cs_etm_queue *etmq,
+				   struct perf_record_aux *aux_record)
+{
+	etmq->aux_record_list = reallocarray(etmq->aux_record_list,
+					      etmq->aux_record_list_len+1,
+					      sizeof(*etmq->aux_record_list));
+	if (!etmq->aux_record_list)
+		return -ENOMEM;
+
+	etmq->aux_record_list[etmq->aux_record_list_len++] = *aux_record;
+	return 0;
+}
+
 static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
 {
 	int ret = 0;
@@ -865,7 +883,7 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu, struct perf_record_aux *aux)
 {
 	int ret;
 	if (etm->queues.new_data) {
@@ -875,6 +893,14 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
 			return ret;
 	}
 
+	/* In timeless mode, cpu is set to -1, and a single aux buffer is filled */
+	if (cpu < 0)
+		cpu = 0;
+
+	ret = cs_etm__save_aux_record(etm->queues.queue_array[cpu].priv, aux);
+	if (ret)
+		return ret;
+
 	if (!etm->timeless_decoding)
 		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
 	else
@@ -2357,7 +2383,7 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if ((timestamp || etm->timeless_decoding)
 			&& event->header.type == PERF_RECORD_AUX) {
-		err = cs_etm__update_queues(etm, sample->cpu);
+		err = cs_etm__update_queues(etm, sample->cpu, &event->aux);
 		if (err)
 			return err;
 	}
-- 
2.28.0

