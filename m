Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45430AE2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBARlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:41:46 -0500
Received: from foss.arm.com ([217.140.110.172]:35218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhBARlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:41:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A321150C;
        Mon,  1 Feb 2021 09:40:52 -0800 (PST)
Received: from [10.57.39.177] (unknown [10.57.39.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A663F718;
        Mon,  1 Feb 2021 09:40:48 -0800 (PST)
Subject: Re: [PATCH 8/8] perf arm-spe: Set thread TID
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210119144658.793-8-james.clark@arm.com>
 <20210131120156.GB230721@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <cb7c6deb-e4a1-95fa-b0d2-e4405f644e63@arm.com>
Date:   Mon, 1 Feb 2021 19:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210131120156.GB230721@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2021 14:01, Leo Yan wrote:
> Option 1: by merging patches 07/08 and 08/08, we can firstly support PID
> tracing for root namespace, and later we can extend to support PID
> tracing in container (and in VMs).
> 
> Option 2: we can use the software method to establish PID for SPE
> trace, which can base on kernel's events PERF_RECORD_SWITCH /
> PERF_RECORD_SWITCH_CPU_WIDE and check context switch ip.
> 
> To be honest, I am a bit concern for option 1 for later might
> introduce regression when later support PID for containers (and VMs).
> If you have a plan for option 1, I think it's good to record current
> limitation and the plan for next step in the commit log, so we can merge
> this patch at this time and later extend for containers.
> 
> Otherwise, we need to consider how to implement the PID tracing with
> option 2.  If it is the case, we should firstly only merge patches
> 01 ~ 06 for data source enabling.  How about you think for this?

In my opinion we should do option 1 and use what is there at the moment. That
gets users 90% of the functionality right now.

I plan to look at option 2 at some point, and it can always be added on top of
option 1 or replace what is there. But I don't know when I would get to it or
how long it will take.

James

> 
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Besides for techinical question, you could add your "Co-developed-by"
> tags for patches 06, 07, 08/08, which you have took time to refin them.
> 
> Thanks you for kindly efforts.
> 
> [1] https://lore.kernel.org/patchwork/patch/1353286/
> 
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Al Grant <al.grant@arm.com>
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Wei Li <liwei391@huawei.com>
>> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++-------------
>>  1 file changed, 50 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 27a0b9dfe22d..9828fad7e516 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -223,6 +223,46 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
>>  		PERF_RECORD_MISC_USER;
>>  }
>>  
>> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>> +				    struct auxtrace_queue *queue)
>> +{
>> +	struct arm_spe_queue *speq = queue->priv;
>> +	pid_t tid;
>> +
>> +	tid = machine__get_current_tid(spe->machine, speq->cpu);
>> +	if (tid != -1) {
>> +		speq->tid = tid;
>> +		thread__zput(speq->thread);
>> +	} else
>> +		speq->tid = queue->tid;
>> +
>> +	if ((!speq->thread) && (speq->tid != -1)) {
>> +		speq->thread = machine__find_thread(spe->machine, -1,
>> +						    speq->tid);
>> +	}
>> +
>> +	if (speq->thread) {
>> +		speq->pid = speq->thread->pid_;
>> +		if (queue->cpu == -1)
>> +			speq->cpu = speq->thread->cpu;
>> +	}
>> +}
>> +
>> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
>> +{
>> +	int err;
>> +	struct arm_spe *spe = speq->spe;
>> +	struct auxtrace_queue *queue;
>> +
>> +	err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
>> +	if (err)
>> +		return err;
>> +
>> +	queue = &speq->spe->queues.queue_array[speq->queue_nr];
>> +	arm_spe_set_pid_tid_cpu(speq->spe, queue);
>> +	return 0;
>> +}
>> +
>>  static void arm_spe_prep_sample(struct arm_spe *spe,
>>  				struct arm_spe_queue *speq,
>>  				union perf_event *event,
>> @@ -431,6 +471,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>>  static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>>  {
>>  	struct arm_spe *spe = speq->spe;
>> +	const struct arm_spe_record *record;
>>  	int ret;
>>  
>>  	if (!spe->kernel_start)
>> @@ -450,6 +491,11 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>>  		if (ret < 0)
>>  			continue;
>>  
>> +		record = &speq->decoder->record;
>> +		ret = arm_spe_set_tid(speq, record->context_id);
>> +		if (ret)
>> +			return ret;
>> +
>>  		ret = arm_spe_sample(speq);
>>  		if (ret)
>>  			return ret;
>> @@ -500,6 +546,10 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
>>  
>>  		record = &speq->decoder->record;
>>  
>> +		ret = arm_spe_set_tid(speq, record->context_id);
>> +		if (ret)
>> +			return ret;
>> +
>>  		speq->timestamp = record->timestamp;
>>  		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
>>  		if (ret)
>> @@ -552,31 +602,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>>  	return timeless_decoding;
>>  }
>>  
>> -static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>> -				    struct auxtrace_queue *queue)
>> -{
>> -	struct arm_spe_queue *speq = queue->priv;
>> -	pid_t tid;
>> -
>> -	tid = machine__get_current_tid(spe->machine, speq->cpu);
>> -	if (tid != -1) {
>> -		speq->tid = tid;
>> -		thread__zput(speq->thread);
>> -	} else
>> -		speq->tid = queue->tid;
>> -
>> -	if ((!speq->thread) && (speq->tid != -1)) {
>> -		speq->thread = machine__find_thread(spe->machine, -1,
>> -						    speq->tid);
>> -	}
>> -
>> -	if (speq->thread) {
>> -		speq->pid = speq->thread->pid_;
>> -		if (queue->cpu == -1)
>> -			speq->cpu = speq->thread->cpu;
>> -	}
>> -}
>> -
>>  static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
>>  {
>>  	unsigned int queue_nr;
>> -- 
>> 2.28.0
>>
