Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D474D3D11E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhGUOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:23:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239506AbhGUOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D643F11B3;
        Wed, 21 Jul 2021 08:02:16 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 418C43F73D;
        Wed, 21 Jul 2021 08:02:14 -0700 (PDT)
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
Subject: [PATCH v2 2/6] perf cs-etm: Split setup and timestamp search functions
Date:   Wed, 21 Jul 2021 16:01:58 +0100
Message-Id: <20210721150202.32065-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactoring has some benefits:
 * Decoding is done to find the timestamp. If we want to print errors
   when maps aren't available, then doing it from cs_etm__setup_queue()
   may cause warnings to be printed.
 * The cs_etm__setup_queue() flow is shared between timed and timeless
   modes, so it needs to be guarded by an if statement which can now
   be removed.
 * Allows moving the setup queues function earlier.
 * If data was piped in, then not all queues would be filled so it
   wouldn't have worked properly anyway. Now it waits for flush so
   data in all queues will be available.

The motivation for this is to decouple setup functions with ones that
involve decoding. That way we can move the setup function earlier when
the formatted/unformatted trace information is available.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4c69ef391f60..426e99c07ca9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -809,29 +809,32 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
 {
-	int ret = 0;
-	unsigned int cs_queue_nr;
-	u8 trace_chan_id;
-	u64 cs_timestamp;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
-		goto out;
+		return 0;
 
 	etmq = cs_etm__alloc_queue(etm);
 
-	if (!etmq) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!etmq)
+		return -ENOMEM;
 
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
 	etmq->offset = 0;
 
-	if (etm->timeless_decoding)
-		goto out;
+	return 0;
+}
+
+static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
+					    struct cs_etm_queue *etmq,
+					    unsigned int queue_nr)
+{
+	int ret = 0;
+	unsigned int cs_queue_nr;
+	u8 trace_chan_id;
+	u64 cs_timestamp;
 
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
@@ -2218,13 +2221,27 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr;
+	unsigned int cs_queue_nr, queue_nr, i;
 	u8 trace_chan_id;
 	u64 cs_timestamp;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
 	struct cs_etm_traceid_queue *tidq;
 
+	/*
+	 * Pre-populate the heap with one entry from each queue so that we can
+	 * start processing in time order across all queues.
+	 */
+	for (i = 0; i < etm->queues.nr_queues; i++) {
+		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq)
+			continue;
+
+		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
+		if (ret)
+			return ret;
+	}
+
 	while (1) {
 		if (!etm->heap.heap_cnt)
 			goto out;
-- 
2.28.0

