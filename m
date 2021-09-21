Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473054133AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhIUNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:04:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhIUNEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:04:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB37B106F;
        Tue, 21 Sep 2021 06:02:43 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.50.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C29E03F59C;
        Tue, 21 Sep 2021 06:02:41 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Don't immediately close events that are run on invalid CPU/sink combos
Date:   Tue, 21 Sep 2021 14:02:31 +0100
Message-Id: <20210921130231.386095-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a traced process runs on a CPU that can't reach the selected sink,
the event will be stopped with PERF_HES_STOPPED. This means that even if
the process migrates to a valid CPU, tracing will not resume.

This can be reproduced (on N1SDP) by using taskset to start the process
on CPU 0, and then switching it to CPU 2 (ETF 1 is only reachable from
CPU 2):

  taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls

This produces a single 0 length AUX record, and then no more trace:

  0x3c8 [0x30]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]

After the fix, the same command produces normal AUX records. The perf
self test "89: Check Arm CoreSight trace data recording and synthesized
samples" no longer fails intermittently. This was because the taskset in
the test is after the fork, so there is a period where the task is
scheduled on a random CPU rather than forced to a valid one.

Specifically selecting an invalid CPU will still result in a failure to
open the event because it will never produce trace:

  ./perf record -C 2 -e cs_etm/@tmc_etf0/
  failed to mmap with 12 (Cannot allocate memory)

The only scenario that has changed is if the CPU mask has a valid CPU
sink combo in it.

Testing
=======

* Coresight self test passes consistently:
  ./perf test Coresight

* CPU wide mode still produces trace:
  ./perf record -e cs_etm// -a

* Invalid -C options still fail to open:
  ./perf record -C 2,3 -e cs_etm/@tmc_etf0/
  failed to mmap with 12 (Cannot allocate memory)

* Migrating a task to a valid sink/CPU now produces trace:
  taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls

* If the task remains on an invalid CPU, no trace is emitted:
  taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- ls

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8ebd728d3a80..79346f0f0e0b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -452,9 +452,14 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 * sink from this ETM. We can't do much in this case if
 	 * the sink was specified or hinted to the driver. For
 	 * now, simply don't record anything on this ETM.
+	 *
+	 * As such we pretend that everything is fine, and let
+	 * it continue without actually tracing. The event could
+	 * continue tracing when it moves to a CPU where it is
+	 * reachable to a sink.
 	 */
 	if (!cpumask_test_cpu(cpu, &event_data->mask))
-		goto fail_end_stop;
+		goto out;
 
 	path = etm_event_cpu_path(event_data, cpu);
 	/* We need a sink, no need to continue without one */
@@ -466,16 +471,15 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (coresight_enable_path(path, CS_MODE_PERF, handle))
 		goto fail_end_stop;
 
-	/* Tell the perf core the event is alive */
-	event->hw.state = 0;
-
 	/* Finally enable the tracer */
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+out:
+	/* Tell the perf core the event is alive */
+	event->hw.state = 0;
 	/* Save the event_data for this ETM */
 	ctxt->event_data = event_data;
-out:
 	return;
 
 fail_disable_path:
@@ -517,6 +521,19 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	if (WARN_ON(!event_data))
 		return;
 
+	/*
+	 * Check if this ETM was allowed to trace, as decided at
+	 * etm_setup_aux(). If it wasn't allowed to trace, then
+	 * nothing needs to be torn down other than outputting a
+	 * zero sized record.
+	 */
+	if (handle->event && (mode & PERF_EF_UPDATE) &&
+	    !cpumask_test_cpu(cpu, &event_data->mask)) {
+		event->hw.state = PERF_HES_STOPPED;
+		perf_aux_output_end(handle, 0);
+		return;
+	}
+
 	if (!csdev)
 		return;
 
-- 
2.28.0

