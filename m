Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7026B32827A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbhCAP3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:29:51 -0500
Received: from foss.arm.com ([217.140.110.172]:60758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237021AbhCAP3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:29:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F9621042;
        Mon,  1 Mar 2021 07:29:02 -0800 (PST)
Received: from [10.57.52.215] (unknown [10.57.52.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878993F73C;
        Mon,  1 Mar 2021 07:28:59 -0800 (PST)
Subject: Re: [PATCH 2/7] perf cs-etm: Only search timestamp in current
 sample's queue.
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-3-james.clark@arm.com>
 <20210220115019.GB3824@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <d9c4c2a0-9137-5015-60f3-ca7b502baaf2@arm.com>
Date:   Mon, 1 Mar 2021 17:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210220115019.GB3824@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2021 13:50, Leo Yan wrote:
> On Fri, Feb 12, 2021 at 04:45:08PM +0200, James Clark wrote:
>> Change initial timestamp search to only operate on the queue
>> related to the current event. In a later change the bounds
>> of the aux record will also be used to reset the decoder and
>> the record is only relevant to a single queue.
> 
> I roughly understand this patch tries to establish the mechanism for
> timstamp search per CPU, but I am struggling to understand what's issue
> you try to address.
> 
> So could you give more description for "what's current issue?" and
> "why need to use this way to fix the issue?".  This would be very
> appreciated.

Hi Leo,

The issue is that the aux records used to reset the decoder are associated
with a specific CPU/aux queue. Currently when any new data is received, all
queues are searched for a timestamp. We can't do it that way any more because
the aux records aren't available yet.

The reason to fix it this way is because now we can only do decode when
an aux record is received. This will happen multiple times, and will also
be cpu/queue specific.
 
> 
>> This change makes some files that had coresight data
>> but didn't syntesise any events start working and generating
>> events. I'm not sure of the reason for that. I'd expect this
>> change to only affect the ordering of events.
> 
> This seems to me that this patch introduces regression.

I'm wondering if it is a regression, or accidentally fixing a bug.
It doesn't seem like it's possible to go from not generating any samples to
generating lots without accidentally fixing an existing issue. If there is
valid data there, what would be stopping it from generating any samples?

I do need to look into this more closely though to find the real reason for
it, which will probably shed more light on it.

> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/cs-etm.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 27894facae5e..8f8b448632fb 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -97,7 +97,7 @@ struct cs_etm_queue {
>>  /* RB tree for quick conversion between traceID and metadata pointers */
>>  static struct intlist *traceid_list;
>>  
>> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
>>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>>  					   pid_t tid);
>> @@ -524,7 +524,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
>>  static int cs_etm__flush_events(struct perf_session *session,
>>  				struct perf_tool *tool)
>>  {
>> -	int ret;
>>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>  						   struct cs_etm_auxtrace,
>>  						   auxtrace);
>> @@ -534,11 +533,6 @@ static int cs_etm__flush_events(struct perf_session *session,
>>  	if (!tool->ordered_events)
>>  		return -EINVAL;
>>  
>> -	ret = cs_etm__update_queues(etm);
>> -
>> -	if (ret < 0)
>> -		return ret;
>> -
> 
> When flush events, it means the trace data is discontinuous or at the
> end of trace data.  If the trace data is discontinuous, we need to use
> cs_etm__update_queues() to create new queues.  So if we remove the
> calling cs_etm__update_queues(), I suspect it cannot handle the
> discontinuous trace data anymore.

Do you know how to force perf to record data like this? From my experience
etm->queues.new_data is only set once when the file is first opened.

> 
>>  	if (etm->timeless_decoding)
>>  		return cs_etm__process_timeless_queues(etm, -1);
>>  
>> @@ -851,10 +845,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>>  	etmq->queue_nr = queue_nr;
>>  	etmq->offset = 0;
>>  
>> -	if (etm->timeless_decoding)
>> -		return 0;
>> -	else
>> -		return cs_etm__search_first_timestamp(etmq);
>> +	return 0;
>>  }
>>  
>>  static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>> @@ -874,14 +865,20 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>>  	return 0;
>>  }
>>  
>> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
>> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
>>  {
>> +	int ret;
>>  	if (etm->queues.new_data) {
>>  		etm->queues.new_data = false;
>> -		return cs_etm__setup_queues(etm);
>> +		ret = cs_etm__setup_queues(etm);
> 
> Just remind, the new parameter "cpu" is introduced in this function,
> in theory, cs_etm__update_queues() should work for the specified CPU.
> But it always setup queues for all CPUs with calling
> cs_etm__setup_queues().
> 
>> +		if (ret)
>> +			return ret;
>>  	}
>>  
>> -	return 0;
>> +	if (!etm->timeless_decoding)
>> +		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
>> +	else
>> +		return 0;
> 
> In the original code of cs_etm__update_queues(), if there have no any
> new data (or has already setup queues), then it does nothing and
> directly bails out.
> 
> After applied the up change, it will always search the first timestamp
> for the "cpu".
> 

Maybe I need to pull my later change into here that makes it skip the search after
the timestamp is found for the first time. What do you think?

>>  }
>>  
>>  static inline
>> @@ -2358,8 +2355,9 @@ static int cs_etm__process_event(struct perf_session *session,
>>  	else
>>  		timestamp = 0;
>>  
>> -	if (timestamp || etm->timeless_decoding) {
>> -		err = cs_etm__update_queues(etm);
>> +	if ((timestamp || etm->timeless_decoding)
>> +			&& event->header.type == PERF_RECORD_AUX) {
>> +		err = cs_etm__update_queues(etm, sample->cpu);
> 
> Here might cause potential issue.  Let's see an example:
> 
> If CoreSight uses N:1 model for tracers and sink (just like multiple
> ETMs output trace to the same ETR), when "sample->cpu" is 0, it will
> only initialize the timestamp for CPU 0.  In the same AUX trace data,
> it can contains trace for CPU 1, 2, etc; for this case, the flow
> doesn't prepare the timestamp for CPU1/2, so it will fail to generate
> samples for CPU 1/2, right?

If there is only one sink then wouldn't there also only be only one aux queue
and aux records generated for one CPU? I thought each channel in the data
corresponded to a cs_etm_traceid_queue and that is how multiple tracers worked?
But the channel corresponds to a thread rather than a CPU because the struct
looks like this:

    struct cs_etm_traceid_queue {
	    u8 trace_chan_id;
	    pid_t pid, tid;
            ...

There is currently an issue with per-thread mode where AUX events don't have the
CPU ID set and I've assumed CPU 0 which is incorrect. Maybe that is related to
your potential issue as well.

Thanks,
James

> 
> Thanks,
> Leo
> 
>>  		if (err)
>>  			return err;
>>  	}
>> -- 
>> 2.28.0
>>
