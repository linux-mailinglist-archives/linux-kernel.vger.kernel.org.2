Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C269D4316B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJRLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:03:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJRLDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:03:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC96FED1;
        Mon, 18 Oct 2021 04:01:31 -0700 (PDT)
Received: from [10.1.36.146] (e127744.cambridge.arm.com [10.1.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F053F73D;
        Mon, 18 Oct 2021 04:01:29 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
From:   German Gomez <german.gomez@arm.com>
To:     Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
 <20211011142940.GB37383@leoy-ThinkPad-X240s>
 <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
Message-ID: <eae1a617-2624-dc1f-1ddb-ba9f5600819d@arm.com>
Date:   Mon, 18 Oct 2021 12:01:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What do you thing of the patch below? PERF_RECORD_SWITCH events are also
included for tracing forks. The patch would sit on top of Namhyung's.

Thanks,
German

On 12/10/2021 12:07, German Gomez wrote:
> Hi, Leo and Namhyung,
>
> I want to make sure I'm on the same page as you regarding this topic.
>
> [...]
>
> If we are not considering patching the driver at this stage, so we allow
> hardware tracing on non-root namespaces. I think we could proceed like
> this:
>
>   - For userspace, always use context-switch events as they are
>     accurate and consistent with namespaces.
>   - For kernel tracing, if context packets are enabled, use them, but
>     warn the user that the PIDs correspond to the root namespace.
>   - Otherwise, use context-switch events and warn the user of the time
>     inaccuracies.
>
> Later, if the driver is patched to disable context packets outside the
> root namespace, kernel tracing could fall back to using context-switch
> events and warn the user with a single message about the time
> inaccuracies.
>
> If we are aligned, we could collect your feedback and share an updated
> patch that considers the warnings.
>
> Many thanks
> Best regards

---
 tools/perf/util/arm-spe.c | 66 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 708323d7c93c..6a2f7a484a80 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -71,6 +71,17 @@ struct arm_spe {
     u64                kernel_start;
 
     unsigned long            num_events;
+
+    /*
+     * Used for PID tracing.
+     */
+    u8                exclude_kernel;
+
+    /*
+     * Warning messages.
+     */
+    u8                warn_context_pkt_namesapce;
+    u8                warn_context_switch_ev_accuracy;
 };
 
 struct arm_spe_queue {
@@ -586,11 +597,42 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
     return timeless_decoding;
 }
 
+static bool arm_spe__is_exclude_kernel(struct arm_spe *spe) {
+    struct evsel *evsel;
+    struct evlist *evlist = spe->session->evlist;
+
+    evlist__for_each_entry(evlist, evsel) {
+    if (evsel->core.attr.type == spe->pmu_type && evsel->core.attr.exclude_kernel)
+        return true;
+    }
+
+    return false;
+}
+
 static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
                     struct auxtrace_queue *queue)
 {
     struct arm_spe_queue *speq = queue->priv;
-    pid_t tid;
+    pid_t tid = machine__get_current_tid(spe->machine, speq->cpu);
+    u64 context_id = speq->decoder->record.context_id;
+
+    /*
+    * We're tracing the kernel.
+    */
+    if (!spe->exclude_kernel) {
+        /*
+         * Use CONTEXT packets in kernel tracing if available and warn the user of the
+         * values correspond to the root PID namespace.
+         *
+         * If CONTEXT packets aren't available but context-switch events are, warn the user
+         * of the time inaccuracies.
+         */
+        if (context_id != (u64) -1) {
+            tid = speq->decoder->record.context_id;
+            spe->warn_context_pkt_namesapce = true;
+        } else if (tid != -1 && context_id == (u64) -1)
+            spe->warn_context_switch_ev_accuracy = true;
+    }
 
     tid = machine__get_current_tid(spe->machine, speq->cpu);
     if (tid != -1) {
@@ -740,7 +782,8 @@ static int arm_spe_process_event(struct perf_session *session,
         if (err)
             return err;
 
-        if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+        if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+            event->header.type == PERF_RECORD_SWITCH)
             err = arm_spe_context_switch(spe, event, sample);
     }
 
@@ -807,7 +850,20 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
         return arm_spe_process_timeless_queues(spe, -1,
                 MAX_TIMESTAMP - 1);
 
-    return arm_spe_process_queues(spe, MAX_TIMESTAMP);
+    ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
+
+    if (spe->warn_context_pkt_namesapce)
+        ui__warning(
+            "Arm SPE CONTEXT packets used for PID/TID tracing.\n\n"
+            "PID values correspond to the root PID namespace.\n\n");
+
+    if (spe->warn_context_switch_ev_accuracy)
+        ui__warning(
+            "No Arm SPE CONTEXT packets found within traces.\n\n"
+            "Fallback to PERF_RECORD_SWITCH events for PID/TID tracing will have\n"
+            "workload-dependant timing inaccuracies.\n\n");
+
+    return ret;
 }
 
 static void arm_spe_free_queue(void *priv)
@@ -1083,6 +1139,10 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 
     spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
+    spe->exclude_kernel = arm_spe__is_exclude_kernel(spe);
+    spe->warn_context_pkt_namesapce = false;
+    spe->warn_context_switch_ev_accuracy = false;
+
     /*
      * The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
      * and the parameters for hardware clock are stored in the session
-- 
2.17.1
