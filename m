Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4874E426878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbhJHLJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:09:56 -0400
Received: from foss.arm.com ([217.140.110.172]:43480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhJHLJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:09:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF645D6E;
        Fri,  8 Oct 2021 04:07:59 -0700 (PDT)
Received: from [10.57.25.192] (unknown [10.57.25.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D7E3F70D;
        Fri,  8 Oct 2021 04:07:57 -0700 (PDT)
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
Date:   Fri, 8 Oct 2021 12:07:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Namhyung,

On 06/10/2021 17:09, Namhyung Kim wrote:
> Hi Leo and German,
>
> [...]
>
> I think it'd be better to check it in perf record and not set
> evsel->core.attr.context_switch if possible.
>
> Or it can ignore the context switch once it sees a context packet.
>
>> Here should note one thing is the perf tool needs to have knowledge to
>> decide if the bit 3 'CX' (macro 'SYS_PMSCR_EL1_CX_SHIFT' in kernel) has
>> been set in register PMSCR or not.  AFAIK, Arm SPE driver doesn't
>> expose any interface (or config) to userspace for the context tracing,
>> so one method is to add an extra config in Arm SPE driver for this
>> bit, e.g. 'ATTR_CFG_FLD_cx_enable_CFG' can be added in Arm SPE driver.
>>
>> Alternatively, rather than adding new config, I am just wandering we
>> simply use two flags in perf's decoding: 'use_switch_event_for_pid' and
>> 'use_ctx_packet_for_pid', the first variable will be set if detects
>> the tracing is userspace only, the second varaible will be set when
>> detects the hardware tracing containing context packet.  So if the
>> variable 'use_ctx_packet_for_pid' has been set, then the decoder will
>> always use context packet for sample's PID, otherwise, it falls back
>> to check 'use_switch_event_for_pid' and set sample PID based on switch
>> events.
>>
>> If have any other idea, please feel free bring up.
> If it's just kernel config, we can check /proc/config.gz or
> /boot/config-$(uname -r).  When it knows for sure it can just use
> the context packet, otherwise it needs the context switch.
>
> Thanks,
> Namhyung

Please correct me if I'm wrong, after disabling the PID_IN_CONTEXTIDR
feature in the kernel, I don't see any context packets in the auxtraces.
I think after applying the patch from [1], it should be sufficient to
determine if pid tracing should fall back to use --switch-events when
context_id from that patch has a value of -1.

If the patch at the end of this message is applied on top of Namhyuna's
and [1], I think it can work. Also, if the pmu driver is patched to
disable the 'CX' bit when the pid is not in the root namespace [2]
(unfortunately I haven't been able to set up an environment to properly
test Leo's patch yet) tracing could also fall back to context-switch for
userspace tracing. What do you think?

Thanks,
German

[1] https://www.spinics.net/lists/linux-perf-users/msg12543.html
[2] https://lore.kernel.org/lkml/20210916135418.GA383600@leoy-ThinkPad-X240s/

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 708323d..e224665 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -71,6 +71,12 @@
     u64                kernel_start;
 
     unsigned long            num_events;
+
+    /*
+     * Used for PID tracing.
+     */
+    u8                use_context_id_pkt;
+    u8                use_context_switch_event;
 };
 
 struct arm_spe_queue {
@@ -586,13 +592,30 @@
     return timeless_decoding;
 }
 
+static bool arm_spe__is_exclude_kernel(struct arm_spe *spe) {
+    struct evsel *evsel;
+    struct evlist *evlist = spe->session->evlist;
+
+    evlist__for_each_entry(evlist, evsel) {
+        if (evsel->core.attr.type == spe->pmu_type && evsel->core.attr.exclude_kernel)
+            return true;
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
+    pid_t tid = -1;
 
-    tid = machine__get_current_tid(spe->machine, speq->cpu);
+    if (spe->use_context_id_pkt)
+        tid = speq->decoder->record.context_id;
+
+    if (tid == -1 && spe->use_context_switch_event)
+        tid = machine__get_current_tid(spe->machine, speq->cpu);
+
     if (tid != -1) {
         speq->tid = tid;
         thread__zput(speq->thread);
@@ -1084,6 +1107,15 @@
     spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
     /*
+     * Always try to use context packet by default for pid tracing.
+     *
+     * If it's not enabled in the pmu driver, it will always have a value of -1 and we can try
+     * to fall back to using context-switch events instead.
+     */
+    spe->use_context_id_pkt = true;
+    spe->use_context_switch_event = arm_spe__is_exclude_kernel(spe);
+
+    /*
      * The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
      * and the parameters for hardware clock are stored in the session
      * context.  Passes these parameters to the struct perf_tsc_conversion
@@ -1141,4 +1173,4 @@
 err_free:
     free(spe);
     return err;
-}
+}
\ No newline at end of file
