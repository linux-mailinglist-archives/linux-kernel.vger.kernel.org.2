Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5D4335D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhJSMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:23:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235604AbhJSMXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:23:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB712F;
        Tue, 19 Oct 2021 05:21:21 -0700 (PDT)
Received: from [10.57.73.194] (unknown [10.57.73.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8043F70D;
        Tue, 19 Oct 2021 05:21:18 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
 <20211011142940.GB37383@leoy-ThinkPad-X240s>
 <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
 <eae1a617-2624-dc1f-1ddb-ba9f5600819d@arm.com>
 <20211018132328.GG130233@leoy-ThinkPad-X240s>
Message-ID: <cd354485-5267-0e07-eb18-ddd0d002ecc3@arm.com>
Date:   Tue, 19 Oct 2021 13:21:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018132328.GG130233@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Many thanks for you comments as always and sorry for the rushed patch.

On 18/10/2021 14:23, Leo Yan wrote:
> Hi German,
>
> On Mon, Oct 18, 2021 at 12:01:27PM +0100, German Gomez wrote:
>> Hi,
>>
>> What do you thing of the patch below? PERF_RECORD_SWITCH events are also
>> included for tracing forks. The patch would sit on top of Namhyung's.
> Yeah, it's good to add PERF_RECORD_SWITCH.
>
>> On 12/10/2021 12:07, German Gomez wrote:
>>> Hi, Leo and Namhyung,
>>>
>>> I want to make sure I'm on the same page as you regarding this topic.
>>>
>>> [...]
>>>
>>> If we are not considering patching the driver at this stage, so we allow
>>> hardware tracing on non-root namespaces. I think we could proceed like
>>> this:
>>>
>>> ï¿½ - For userspace, always use context-switch events as they are
>>> ï¿½ï¿½ï¿½ accurate and consistent with namespaces.
> I don't think you can always use context-switch events for userspace
> samples.  The underlying mechanism is when there have context-switch
> event or context packet is coming, it will invoke the function
> machine__set_current_tid() to set current pid/tid; afterwards, we
> can retrieve the current pid/tid with the function
> arm_spe_set_pid_tid_cpu().
>
> The question is that if we want to use the tid/pid info at the same
> time for both context-switch events and context packets, then it's
> hard to maintain.  E.g. we need to create multiple thread context, one
> is used to track pid info coming from context-switch events and
> another context is to track pid info from context packet.

My thinking was to use only one of the methods for the entire run, but
the code below is not expressive enough I'm afraid and I agree it could
become hard to maintain. I need to polish it up.

>
> To simplify the code, I still think we give context packet priority and
> use it if it's avalible.  And we rollback to use context-switch events
> for pid/tid when context packet is not avaliable.

OK if it simplifies things. I think context-pkt availability can be
determined before any events are processed by looking at the top record
in the auxtrace_heap, o any of the auxtrace_queues.

>>> ï¿½ - For kernel tracing, if context packets are enabled, use them, but
>>> ï¿½ï¿½ï¿½ warn the user that the PIDs correspond to the root namespace.
>>> ï¿½ - Otherwise, use context-switch events and warn the user of the time
>>> ï¿½ï¿½ï¿½ inaccuracies.
>>>
>>> Later, if the driver is patched to disable context packets outside the
>>> root namespace, kernel tracing could fall back to using context-switch
>>> events and warn the user with a single message about the time
>>> inaccuracies.
>>>
>>> If we are aligned, we could collect your feedback and share an updated
>>> patch that considers the warnings.
>>>
>>> Many thanks
>>> Best regards
>> ---
>> ï¿½tools/perf/util/arm-spe.c | 66 +++++++++++++++++++++++++++++++++++++--
>> ï¿½1 file changed, 63 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 708323d7c93c..6a2f7a484a80 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -71,6 +71,17 @@ struct arm_spe {
>> ï¿½ï¿½ï¿½ï¿½ u64ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ kernel_start;
>> ï¿½
>> ï¿½ï¿½ï¿½ï¿½ unsigned longï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ num_events;
>> +
>> +ï¿½ï¿½ï¿½ /*
>> +ï¿½ï¿½ï¿½ ï¿½* Used for PID tracing.
>> +ï¿½ï¿½ï¿½ ï¿½*/
>> +ï¿½ï¿½ï¿½ u8ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ exclude_kernel;
>> +
>> +ï¿½ï¿½ï¿½ /*
>> +ï¿½ï¿½ï¿½ ï¿½* Warning messages.
>> +ï¿½ï¿½ï¿½ ï¿½*/
>> +ï¿½ï¿½ï¿½ u8ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ warn_context_pkt_namesapce;
>> +ï¿½ï¿½ï¿½ u8ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ warn_context_switch_ev_accuracy;
>> ï¿½};
>> ï¿½
>> ï¿½struct arm_spe_queue {
>> @@ -586,11 +597,42 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>> ï¿½ï¿½ï¿½ï¿½ return timeless_decoding;
>> ï¿½}
>> ï¿½
>> +static bool arm_spe__is_exclude_kernel(struct arm_spe *spe) {
>> +ï¿½ï¿½ï¿½ struct evsel *evsel;
>> +ï¿½ï¿½ï¿½ struct evlist *evlist = spe->session->evlist;
>> +
>> +ï¿½ï¿½ï¿½ evlist__for_each_entry(evlist, evsel) {
>> +ï¿½ï¿½ï¿½ if (evsel->core.attr.type == spe->pmu_type && evsel->core.attr.exclude_kernel)
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ return true;
>> +ï¿½ï¿½ï¿½ }
>> +
>> +ï¿½ï¿½ï¿½ return false;
>> +}
>> +
>> ï¿½static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ struct auxtrace_queue *queue)
>> ï¿½{
>> ï¿½ï¿½ï¿½ï¿½ struct arm_spe_queue *speq = queue->priv;
>> -ï¿½ï¿½ï¿½ pid_t tid;
>> +ï¿½ï¿½ï¿½ pid_t tid = machine__get_current_tid(spe->machine, speq->cpu);
>> +ï¿½ï¿½ï¿½ u64 context_id = speq->decoder->record.context_id;
>> +
>> +ï¿½ï¿½ï¿½ /*
>> +ï¿½ï¿½ï¿½ * We're tracing the kernel.
>> +ï¿½ï¿½ï¿½ */
>> +ï¿½ï¿½ï¿½ if (!spe->exclude_kernel) {
> This is incorrect ... 'exclude_kernel' is a global variable and if
> it's set then perf will always run below code.
>
> I think here you want to avoid using contect packet for user space
> samples, but checking 'exclude_kernel' cannot help for this purpose
> since 'exclude_kernel' cannot be used to decide sample mode (kernel
> mode or user mode).
>
> Thanks,
> Leo
>
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ /*
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½* Use CONTEXT packets in kernel tracing if available and warn the user of the
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½* values correspond to the root PID namespace.
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½*
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½* If CONTEXT packets aren't available but context-switch events are, warn the user
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½* of the time inaccuracies.
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½*/
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ if (context_id != (u64) -1) {
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ tid = speq->decoder->record.context_id;
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ spe->warn_context_pkt_namesapce = true;
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ } else if (tid != -1 && context_id == (u64) -1)
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ spe->warn_context_switch_ev_accuracy = true;
>> +ï¿½ï¿½ï¿½ }
>> ï¿½
>> ï¿½ï¿½ï¿½ï¿½ tid = machine__get_current_tid(spe->machine, speq->cpu);
>> ï¿½ï¿½ï¿½ï¿½ if (tid != -1) {
>> @@ -740,7 +782,8 @@ static int arm_spe_process_event(struct perf_session *session,
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ if (err)
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ return err;
>> ï¿½
>> -ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ event->header.type == PERF_RECORD_SWITCH)
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ err = arm_spe_context_switch(spe, event, sample);
>> ï¿½ï¿½ï¿½ï¿½ }
>> ï¿½
>> @@ -807,7 +850,20 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ return arm_spe_process_timeless_queues(spe, -1,
>> ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ MAX_TIMESTAMP - 1);
>> ï¿½
>> -ï¿½ï¿½ï¿½ return arm_spe_process_queues(spe, MAX_TIMESTAMP);
>> +ï¿½ï¿½ï¿½ ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
>> +
>> +ï¿½ï¿½ï¿½ if (spe->warn_context_pkt_namesapce)
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ui__warning(
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ "Arm SPE CONTEXT packets used for PID/TID tracing.\n\n"
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ "PID values correspond to the root PID namespace.\n\n");
>> +
>> +ï¿½ï¿½ï¿½ if (spe->warn_context_switch_ev_accuracy)
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ui__warning(
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ "No Arm SPE CONTEXT packets found within traces.\n\n"
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ "Fallback to PERF_RECORD_SWITCH events for PID/TID tracing will have\n"
>> +ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ "workload-dependant timing inaccuracies.\n\n");
>> +
>> +ï¿½ï¿½ï¿½ return ret;
>> ï¿½}
>> ï¿½
>> ï¿½static void arm_spe_free_queue(void *priv)
>> @@ -1083,6 +1139,10 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>> ï¿½
>> ï¿½ï¿½ï¿½ï¿½ spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>> ï¿½
>> +ï¿½ï¿½ï¿½ spe->exclude_kernel = arm_spe__is_exclude_kernel(spe);
>> +ï¿½ï¿½ï¿½ spe->warn_context_pkt_namesapce = false;
>> +ï¿½ï¿½ï¿½ spe->warn_context_switch_ev_accuracy = false;
>> +
>> ï¿½ï¿½ï¿½ï¿½ /*
>> ï¿½ï¿½ï¿½ï¿½ ï¿½* The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
>> ï¿½ï¿½ï¿½ï¿½ ï¿½* and the parameters for hardware clock are stored in the session
>> -- 
>> 2.17.1


Thanks,
German

