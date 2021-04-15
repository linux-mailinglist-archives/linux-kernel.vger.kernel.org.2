Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD073609CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhDOMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:52:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhDOMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:52:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B11DED1;
        Thu, 15 Apr 2021 05:51:50 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2D43F694;
        Thu, 15 Apr 2021 05:51:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
 <06e1cc2e-1108-81cd-59e4-79277807b80c@arm.com>
 <20210415123953.GB1011890@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <4c173b86-b045-0514-b293-c39cc74d353d@arm.com>
Date:   Thu, 15 Apr 2021 15:51:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415123953.GB1011890@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 15:39, Leo Yan wrote:
> On Wed, Apr 14, 2021 at 05:41:46PM +0300, James Clark wrote:
>> Hi,
>>
>> For this change, I also tried removing the setting of PERF_SAMPLE_TIME in cs_etm__synth_events(). In theory, this would remove the sorting when opening the file, but the change doesn't affect when the built-in events are saved to the inject file. Resulting in events like MMAP and COMM with timestamps, but the synthesised events without. This results in the same issue of the synthesised events appearing before the COMM and MMAP events. If it was possible to somehow tell perf to remove timestamps from built-in events, removing PERF_SAMPLE_TIME would probably be the right solution, because we don't set sample.time.
>>
>> For Arm v8.4 we will have the kernel time in the etm timestamps, so an if can be added to switch between this behaviour and the next (more correct) one depending on the hardware. 
>>
>> On the subject of timestamps, but not related to this change, some combinations of timestamp options aren't working. For example:
>>
>>     perf record -e cs_etm/time,@tmc_etr0/u --per-thread
>> or  perf record -e cs_etm/@tmc_etr0/u --timestamp --per-thread
>>
>> These don't work because of the assumption that etm->timeless_decoding == --per-thread
>> and kernel timestamps enabled (/time/ or --timestamp) == etm timestamps enabled (/timestamp/), which isn't necessarily true.
>>
>> This can be made to work with a few code changes for cs_etm/time,timestamp/u --per-thread, but cs_etm/time/u --per-thread could be a bit more work. Changes involved would be using "per_cpu_mmaps" in some places instead of etm->timeless_decoding, and also setting etm->timeless_decoding based on whether there are any etm timestamps, not kernel ones. Although to search for any etm timestamp would involve a full decode ahead of time which might not be feasible (or maybe just checking the options, although that's not how it's done in cs_etm__is_timeless_decoding() currently).
> 
> Confirm for one thing:
> 
> For the orignal perf data file with "--per-thread" option, the decoder
> runs into the condition for "etm->timeless_decoding"; and it doesn't
> contain ETM timestamp.
> 
> Afterwards, the injected perf data file also misses ETM timestamp and
> hit the condition "etm->timeless_decoding".
> 
> So I am confusing why the original perf data can be processed properly
> but fails to handle the injected perf data file.

Hi Leo,

My patch only deals with per-cpu mode. With per-thread mode everything is already working
because _none_ of the events have timestamps because they are not enabled by default:

	/* In per-cpu case, always need the time of mmap events etc */
	if (!perf_cpu_map__empty(cpus))
		evsel__set_sample_bit(tracking_evsel, TIME);

When none of the events have timestamps, I think perf doesn't use the ordering code in
ordered-events.c. So when the inject file is opened, the events are read in file order.
In file order, MMAP and COMM events come first, because they were encountered before the
AUX record where we generated synthetic events.

So it's not really about --per-thread vs per-cpu mode, it's actually about whether
PERF_SAMPLE_TIME is set, which is set as a by-product of per-cpu mode.

I hope I understood your question properly.

James


> 
> Thanks,
> Leo
> 
>> Or, we could force /time/ and /timestamp/ options to always be enabled together in the record stage. 
>>
>>
>> Thanks
>> James
>>
>> On 14/04/2021 17:39, James Clark wrote:
>>> The following attribute is set when synthesising samples in
>>> timed decoding mode:
>>>
>>>     attr.sample_type |= PERF_SAMPLE_TIME;
>>>
>>> This results in new samples that appear to have timestamps but
>>> because we don't assign any timestamps to the samples, when the
>>> resulting inject file is opened again, the synthesised samples
>>> will be on the wrong side of the MMAP or COMM events.
>>>
>>> For example this results in the samples being associated with
>>> the perf binary, rather than the target of the record:
>>>
>>>     perf record -e cs_etm/@tmc_etr0/u top
>>>     perf inject -i perf.data -o perf.inject --itrace=i100il
>>>     perf report -i perf.inject
>>>
>>> Where 'Command' == perf should show as 'top':
>>>
>>>     # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
>>>     # ........  .......  ....................  ......................  ......................  ..................
>>>     #
>>>         31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -
>>>
>>> If the perf.data file is opened directly with perf, without the
>>> inject step, then this already works correctly because the
>>> events are synthesised after the COMM and MMAP events and
>>> no second sorting happens. Re-sorting only happens when opening
>>> the perf.inject file for the second time so timestamps are
>>> needed.
>>>
>>> Using the timestamp from the AUX record mirrors the current
>>> behaviour when opening directly with perf, because the events
>>> are generated on the call to cs_etm__process_queues().
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> Co-developed-by: Al Grant <al.grant@arm.com>
>>> Signed-off-by: Al Grant <al.grant@arm.com>
>>> ---
>>>  tools/perf/util/cs-etm.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index c25da2ffa8f3..d0fa9dce47f1 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
>>>  	u8 sample_instructions;
>>>  
>>>  	int num_cpu;
>>> +	u64 latest_kernel_timestamp;
>>>  	u32 auxtrace_type;
>>>  	u64 branches_sample_type;
>>>  	u64 branches_id;
>>> @@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>>>  	event->sample.header.size = sizeof(struct perf_event_header);
>>>  
>>> +	if (!etm->timeless_decoding)
>>> +		sample.time = etm->latest_kernel_timestamp;
>>>  	sample.ip = addr;
>>>  	sample.pid = tidq->pid;
>>>  	sample.tid = tidq->tid;
>>> @@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>>>  	event->sample.header.size = sizeof(struct perf_event_header);
>>>  
>>> +	if (!etm->timeless_decoding)
>>> +		sample.time = etm->latest_kernel_timestamp;
>>>  	sample.ip = ip;
>>>  	sample.pid = tidq->pid;
>>>  	sample.tid = tidq->tid;
>>> @@ -2412,9 +2417,10 @@ static int cs_etm__process_event(struct perf_session *session,
>>>  	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>>>  		return cs_etm__process_switch_cpu_wide(etm, event);
>>>  
>>> -	if (!etm->timeless_decoding &&
>>> -	    event->header.type == PERF_RECORD_AUX)
>>> +	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
>>> +		etm->latest_kernel_timestamp = sample_kernel_timestamp;
>>>  		return cs_etm__process_queues(etm);
>>> +	}
>>>  
>>>  	return 0;
>>>  }
>>>
