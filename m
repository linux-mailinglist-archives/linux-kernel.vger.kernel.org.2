Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC291354588
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhDEQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:56080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239362AbhDEQoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:44:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD611042;
        Mon,  5 Apr 2021 09:43:55 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 705AB3F694;
        Mon,  5 Apr 2021 09:43:53 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     maz@kernel.org, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 15/20] coresight: etm-perf: Handle stale output handles
Date:   Mon,  5 Apr 2021 17:43:02 +0100
Message-Id: <20210405164307.1720226-16-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210405164307.1720226-1-suzuki.poulose@arm.com>
References: <20210405164307.1720226-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context associated with an ETM for a given perf event
includes :
  - handle -> the perf output handle for the AUX buffer.
  - the path for the trace components
  - the buffer config for the sink.

The path and the buffer config are part of the "aux_priv" data
(etm_event_data) setup by the setup_aux() callback, and made available
via perf_get_aux(handle).

Now with a sink supporting IRQ, the sink could "end" an output
handle when the buffer reaches the programmed limit and would try
to restart a handle. This could fail if there is not enough
space left the AUX buffer (e.g, the userspace has not consumed
the data). This leaves the "handle" disconnected from the "event"
and also the "perf_get_aux()" cleared. This all happens within
the sink driver, without the etm_perf driver being aware.
Now when the event is actually stopped, etm_event_stop()
will need to access the "event_data". But since the handle
is not valid anymore, we loose the information to stop the
"trace" path. So, we need a reliable way to access the etm_event_data
even when the handle may not be active.

This patch replaces the per_cpu handle array with a per_cpu context
for the ETM, which tracks the "handle" as well as the "etm_event_data".
The context notes the etm_event_data at etm_event_start() and clears
it at etm_event_stop(). This makes sure that we don't access a
stale "etm_event_data" as we are guaranteed that it is not
freed by free_aux() as long as the event is active and tracing,
also provides us with access to the critical information
needed to wind up a session even in the absence of an active
output_handle.

This is not an issue for the legacy sinks as none of them supports
an IRQ and is centrally handled by the etm-perf.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 59 +++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index aa0974bd265b..f123c26b9f54 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -24,7 +24,26 @@
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
-static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
+/*
+ * An ETM context for a running event includes the perf aux handle
+ * and aux_data. For ETM, the aux_data (etm_event_data), consists of
+ * the trace path and the sink configuration. The event data is accessible
+ * via perf_get_aux(handle). However, a sink could "end" a perf output
+ * handle via the IRQ handler. And if the "sink" encounters a failure
+ * to "begin" another session (e.g due to lack of space in the buffer),
+ * the handle will be cleared. Thus, the event_data may not be accessible
+ * from the handle when we get to the etm_event_stop(), which is required
+ * for stopping the trace path. The event_data is guaranteed to stay alive
+ * until "free_aux()", which cannot happen as long as the event is active on
+ * the ETM. Thus the event_data for the session must be part of the ETM context
+ * to make sure we can disable the trace path.
+ */
+struct etm_ctxt {
+	struct perf_output_handle handle;
+	struct etm_event_data *event_data;
+};
+
+static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 
 /*
@@ -376,13 +395,18 @@ static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
 	struct etm_event_data *event_data;
-	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
+	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
 
 	if (!csdev)
 		goto fail;
 
+	/* Have we messed up our tracking ? */
+	if (WARN_ON(ctxt->event_data))
+		goto fail;
+
 	/*
 	 * Deal with the ring buffer API and get a handle on the
 	 * session's information.
@@ -418,6 +442,8 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* Save the event_data for this ETM */
+	ctxt->event_data = event_data;
 out:
 	return;
 
@@ -436,13 +462,30 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	int cpu = smp_processor_id();
 	unsigned long size;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
-	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
-	struct etm_event_data *event_data = perf_get_aux(handle);
+	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
+	struct perf_output_handle *handle = &ctxt->handle;
+	struct etm_event_data *event_data;
 	struct list_head *path;
 
+	/*
+	 * If we still have access to the event_data via handle,
+	 * confirm that we haven't messed up the tracking.
+	 */
+	if (handle->event &&
+	    WARN_ON(perf_get_aux(handle) != ctxt->event_data))
+		return;
+
+	event_data = ctxt->event_data;
+	/* Clear the event_data as this ETM is stopping the trace. */
+	ctxt->event_data = NULL;
+
 	if (event->hw.state == PERF_HES_STOPPED)
 		return;
 
+	/* We must have a valid event_data for a running event */
+	if (WARN_ON(!event_data))
+		return;
+
 	if (!csdev)
 		return;
 
@@ -460,7 +503,13 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
 
-	if (mode & PERF_EF_UPDATE) {
+	/*
+	 * If the handle is not bound to an event anymore
+	 * (e.g, the sink driver was unable to restart the
+	 * handle due to lack of buffer space), we don't
+	 * have to do anything here.
+	 */
+	if (handle->event && (mode & PERF_EF_UPDATE)) {
 		if (WARN_ON_ONCE(handle->event != event))
 			return;
 
-- 
2.24.1

