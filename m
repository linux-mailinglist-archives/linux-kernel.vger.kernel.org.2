Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD303282C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhCAPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:44:40 -0500
Received: from foss.arm.com ([217.140.110.172]:60980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237075AbhCAPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:44:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34291042;
        Mon,  1 Mar 2021 07:43:48 -0800 (PST)
Received: from [10.57.52.215] (unknown [10.57.52.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A29D3F73C;
        Mon,  1 Mar 2021 07:43:45 -0800 (PST)
Subject: Re: [PATCH 3/7] perf cs-etm: Save aux records in each etm queue
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
 <20210212144513.31765-4-james.clark@arm.com>
 <20210227071056.GA3317@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <a5fc9db1-d80b-5351-ad98-98c9599c6f11@arm.com>
Date:   Mon, 1 Mar 2021 17:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210227071056.GA3317@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/02/2021 09:10, Leo Yan wrote:
> On Fri, Feb 12, 2021 at 04:45:09PM +0200, James Clark wrote:
>> The aux records will be used set the bounds of decoding in a
>> later commit. In the future we may also want to use the flags
>> of each record to control decoding.
>>
>> Do these need to be saved in their entirety, or can pointers
>> to each record safely be saved instead for later access?
> 
> Rather than introudcing the perf record list, I just wander if we can
> use easier method to fix this problem.  So below is the rough idea
> (though I don't really verify it):
> 
> The essential information we need is what's the valid buffer length can
> be used for decoding.  Though cs_etm_queue::buf_len tracks the buffer
> length, but it's the buffer length is for the whole AUX buffer, and
> which belongs to multiple "PERF_RECORD_AUX" events.  So we cannot decode
> at once for the whole trace data in the AUX trace buffer, on the other
> hand, the incoming "PERF_RECORD_AUX" event can guide the CoreSight
> decoder it should decode how much buffer size.  At the end, the trace
> data can be decoded step by step based on the incoming "PERF_RECORD_AUX"
> events.
> 
> I'd like to propose to add a new field "cs_etm_queue::buf_rec_len", it
> stands for the record length based on the RECORD_AUX event.  In
> theory, this value should be always less than "cs_etm_queue::buf_len".
> 
> When every time the "PERF_RECORD_AUX" event is coming, we find out the
> corresponding queue (so this can be applied for "1:1" or "N:1" models
> for source and sink), and accumulate "perf_record_aux::aux_size" into
> "cs_etm_queue::buf_rec_len".
> 
> At the decoder side, it decreases "etmq->buf_rec_len" until to zero for
> the current round of decoding (see cs_etm__decode_data_block()).  Since
> all the "PERF_RECORD_AUX" event will be processed before
> "PERF_RECORD_EXIT" event, so we don't worry the tail trace data will be
> ignored.
> 
> The main reason for this suggestion is it don't need to change the
> significant logic in current code.  I will try to do experiment for this
> idea and share back.
> 
> James, if you think I miss anything, please correct me as needed.
> Thanks!
> 

This is an interesting idea, I think we could push decoded packets into the
min heap as the aux records are received, and not do anything with them until
the end of the data is reached. That way instead of saving aux records, we'd
save the result of the decode for each aux record.

Currently each cs_etm_queue has a cs_etm_traceid_queue/cs_etm_packet_queue for each
stream, but that would have to be changed to have multiple ones because multiple
packets could be decoded to get through the whole aux record.

It would be a similarly sized change, and could also have a bigger impact on
memory. So I'm not sure if it would help to reduce the changes, but it is possible.

James

> Leo
> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++++++---
>>  1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 8f8b448632fb..88b541b2a804 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -92,12 +92,16 @@ struct cs_etm_queue {
>>  	/* Conversion between traceID and index in traceid_queues array */
>>  	struct intlist *traceid_queues_list;
>>  	struct cs_etm_traceid_queue **traceid_queues;
>> +	int aux_record_list_len;
>> +	int aux_record_list_idx;
>> +	struct perf_record_aux *aux_record_list;
>>  };
>>  
>>  /* RB tree for quick conversion between traceID and metadata pointers */
>>  static struct intlist *traceid_list;
>>  
>> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
>> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu,
>> +				 struct perf_record_aux *aux_record);
>>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>>  					   pid_t tid);
>> @@ -585,6 +589,7 @@ static void cs_etm__free_queue(void *priv)
>>  
>>  	cs_etm_decoder__free(etmq->decoder);
>>  	cs_etm__free_traceid_queues(etmq);
>> +	free(etmq->aux_record_list);
>>  	free(etmq);
>>  }
>>  
>> @@ -759,6 +764,19 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>>  	return NULL;
>>  }
>>  
>> +static int cs_etm__save_aux_record(struct cs_etm_queue *etmq,
>> +				   struct perf_record_aux *aux_record)
>> +{
>> +	etmq->aux_record_list = reallocarray(etmq->aux_record_list,
>> +					      etmq->aux_record_list_len+1,
>> +					      sizeof(*etmq->aux_record_list));
>> +	if (!etmq->aux_record_list)
>> +		return -ENOMEM;
>> +
>> +	etmq->aux_record_list[etmq->aux_record_list_len++] = *aux_record;
>> +	return 0;
>> +}
>> +
>>  static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
>>  {
>>  	int ret = 0;
>> @@ -865,7 +883,7 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>>  	return 0;
>>  }
>>  
>> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
>> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu, struct perf_record_aux *aux)
>>  {
>>  	int ret;
>>  	if (etm->queues.new_data) {
>> @@ -875,6 +893,14 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
>>  			return ret;
>>  	}
>>  
>> +	/* In timeless mode, cpu is set to -1, and a single aux buffer is filled */
>> +	if (cpu < 0)
>> +		cpu = 0;
>> +
>> +	ret = cs_etm__save_aux_record(etm->queues.queue_array[cpu].priv, aux);
>> +	if (ret)
>> +		return ret;
>> +
>>  	if (!etm->timeless_decoding)
>>  		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
>>  	else
>> @@ -2357,7 +2383,7 @@ static int cs_etm__process_event(struct perf_session *session,
>>  
>>  	if ((timestamp || etm->timeless_decoding)
>>  			&& event->header.type == PERF_RECORD_AUX) {
>> -		err = cs_etm__update_queues(etm, sample->cpu);
>> +		err = cs_etm__update_queues(etm, sample->cpu, &event->aux);
>>  		if (err)
>>  			return err;
>>  	}
>> -- 
>> 2.28.0
>>
