Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571B39F915
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhFHOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:30:16 -0400
Received: from foss.arm.com ([217.140.110.172]:60382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhFHOaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:30:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB806D;
        Tue,  8 Jun 2021 07:28:12 -0700 (PDT)
Received: from [10.57.6.53] (unknown [10.57.6.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197C03F73D;
        Tue,  8 Jun 2021 07:28:09 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/1] perf cs-etm: Split Coresight decode by aux
 records
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210601130751.25750-1-james.clark@arm.com>
 <20210601130751.25750-2-james.clark@arm.com>
 <20210604052117.GI10272@leoy-ThinkPad-X240s> <20210607200321.GA179489@p14s>
From:   James Clark <james.clark@arm.com>
Message-ID: <29733e40-c4c9-6c4d-6097-5be64845edad@arm.com>
Date:   Tue, 8 Jun 2021 17:28:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607200321.GA179489@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2021 23:03, Mathieu Poirier wrote:
> Hi James, 
> 
> Leo has beat me to the punch on most of the things I noticed in this set, so
> this is just to complement what has already been pointed out.
> 
> On Fri, Jun 04, 2021 at 01:21:17PM +0800, Leo Yan wrote:
>> Hi James,
>>
>> On Tue, Jun 01, 2021 at 04:07:51PM +0300, James Clark wrote:
>>> Populate the auxtrace queues using AUX records rather than whole
>>> auxtrace buffers.
>>>
>>> This is similar to the auxtrace_queues__process_index() ->
>>> auxtrace_queues__add_indexed_event() flow where
>>> perf_session__peek_event() is used to read AUXTRACE events out of random
>>> positions in the file based on the auxtrace index.
>>>
>>> Now there is a second pass using perf_session__peek_events() which loops
>>> over all PERF_RECORD_AUX events, finds the corresponding auxtrace
>>> buffer, and adds a fragment of that buffer to the auxtrace queues,
>>> rather than the whole buffer.
> 
> The first loop is enacted by perf_session__peek_events() and processes all the
> PERF_RECORD_AUX events.  The second loop correlates PERF_RECORD_AUX with
> PERF_RECORD_AUXTRACE.
> 
> The above paragraph seems to indicate the opposite.
> 

Hi Mathieu,

Yes, you're right I will reword this. The rest of the comments I also agree
with so I will fix them up and submit v5.

>>>
>>> This is a completely new implementation compared to v1 and v2 of the
>>> patchset where significant modifications were made to the decoding flow,
>>> including saving all of the AUX records, and changing the point where
>>> decoding started. These changes had effects on the outcome of decoding,
>>> but with this implementation, the output of decoding is identical to
>>> perf/core, except in the case where decoding failed due to the issue
>>> that this change addresses. No changes to decoding were made, apart
>>> from populating the auxtrace queues.
>>
>> IMHO, this patch is much better than previous versions! :)
>>
>> When went through the whole patch, the most code actually is general
>> enough and can consider to place into into util/auxtrace.c.  If there
>> have any objection, we can come back to add the code for only cs-etm
>> specific.
> 
> I would leave the idea of moving this to util/auxtrace.c alone for the time
> being.
> 
>>
>>> Because the decoder is already reset between each auxtrace buffer,
>>> populating the queues with fragments of whole buffers based on AUX
>>> records has the same affect as resetting the decoder on the AUX record
>>> bounds during decode. But this approach only requires a change to one
>>> part of the whole flow, rather than many parts.
>>>
>>> There is still one TODO about how buffers are found. Currently there is
>>> a plain loop as a search, but this could be improved with a binary
>>> search or keeping a record of which buffers have already been added and
>>> starting the search from the last used place. AUX records and buffers
>>> will come in similar orders in the file so the latter would be simpler
>>> and probably be good enough. But I'm looking for feedback about the
>>> approach as a whole before ironing out all of the details.
> 
> I think for the time being what you have here will work just fine.
> 
>>>
>>> Other issues that were fixed by the previous patchsets such as fixing
>>> the case where the first aux record comes before the first MMAP record
>>> can now be fixed as completely independent issues.
>>>
> 
> I assume you did not expect this patch to be merged and as such wrote as much as
> you could, which is fine.  The next revision should have a changelog that will
> concentrate on why this patch is needed.  I think the testing section (below) is
> useful and should be kept around.

Do you think something like this is enough for the reasoning:

    The reason that this change is needed is because AUX records are emitted
    any time tracing is disabled, for example when the process is scheduled out.
    Because ETM was disabled and enabled again, the decoder also needs to
    be reset to force the search for a sync packet. Otherwise there would
    be fatal decoding errors.

Thanks
James

> 
>>> Testing
>>> =======
>>>
>>> Testing was done with the following script, to diff the decoding results
>>> between the patched and un-patched versions of perf:
>>>
>>> 	#!/bin/bash
>>> 	set -ex
>>>
>>> 	$1 script -i $3 $4 > split.script
>>> 	$2 script -i $3 $4 > default.script
>>>
>>> 	diff split.script default.script | head -n 20
>>>
>>> And it was run like this, with various itrace options depending on the
>>> quantity of synthesised events:
>>>
>>> 	compare.sh ./perf-patched ./perf-default perf-per-cpu-2-threads.data --itrace=i100000ns
>>>
>>> No changes in output were observed in the following scenarios:
>>>
>>> * Simple per-cpu
>>> 	perf record -e cs_etm/@tmc_etr0/u top
>>>
>>> * Per-thread, single thread
>>> 	perf record -e cs_etm/@tmc_etr0/u --per-thread ./threads_C
>>>
>>> * Per-thread multiple threads (but only one thread collected data):
>>> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
>>>
>>> * Per-thread multiple threads (both threads collected data):
>>> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
>>>
>>> * Per-cpu explicit threads:
>>> 	perf record -e cs_etm/@tmc_etr0/u --pid 853,854
>>>
>>> * System-wide (per-cpu):
>>>     perf record -e cs_etm/@tmc_etr0/u -a
>>>
>>> * No data collected (no aux buffers)
>>> 	Can happen with any command when run for a short period
>>>
>>> * Containing truncated records
>>> 	Can happen with any command
>>>
>>> * Containing aux records with 0 size
>>> 	Can happen with any command
>>>
>>> * Snapshot mode
>>> 	perf record -e cs_etm/@tmc_etr0/u -a --snapshot
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  tools/perf/util/cs-etm.c | 159 ++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 156 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index 64536a6ed10a..053aad4b28cf 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -2679,6 +2679,161 @@ static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
>>>  	return metadata;
>>>  }
>>>  
>>> +/**
>>> + * Puts a fragment of an auxtrace buffer into the auxtrace queues based
>>> + * on the bounds of aux_event, if it matches with the buffer that's at
>>> + * file_offset.
>>> + *
>>> + * Normally, whole auxtrace buffers would be added to the queue. But we
>>> + * want to reset the decoder for every PERF_RECORD_AUX event, and the decoder
>>> + * is reset across each buffer, so splitting the buffers up in advance has
>>> + * the same effect.
>>> + */
>>> +static int cs_etm__queue_aux_fragment(struct perf_session *session,
>>> +						off_t file_offset, size_t sz,
>>> +						struct perf_record_aux *aux_event,
>>> +						struct perf_sample *sample)
> 
> The indentation doesn't work.  The 'o' of off_t should be aligned with the 's'
> of struct on the first line.  
> 
>>> +{
>>> +	int err;
>>> +	char buf[PERF_SAMPLE_MAX_SIZE];
>>> +	union perf_event *auxtrace_event_union;
>>> +	struct perf_record_auxtrace *auxtrace_event;
>>> +	union perf_event auxtrace_fragment;
>>> +	bool matchesCpuPid;
>>
>> It's better to avoid using camel naming.
>>
> 
> Leo is correct - I'm surprised checkpatch hasn't complained bitterly.
> 
>>> +	__u64 aux_offset;
>>> +	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>> +						   struct cs_etm_auxtrace,
>>> +						   auxtrace);
>>> +
>>> +	/*
>>> +	 * There should be a PERF_RECORD_AUXTRACE event at the file_offset that we got
>>> +	 * from looping through the auxtrace index.
>>> +	 */
>>> +	err = perf_session__peek_event(session, file_offset, buf,
>>> +				       PERF_SAMPLE_MAX_SIZE, &auxtrace_event_union, NULL);
>>> +	if (err)
>>> +		return err;
>>> +	auxtrace_event = &auxtrace_event_union->auxtrace;
>>> +	if (auxtrace_event->header.type != PERF_RECORD_AUXTRACE)
>>> +		return -EINVAL;
>>> +
>>> +	if (auxtrace_event->header.size < sizeof(struct perf_record_auxtrace) ||
>>> +		auxtrace_event->header.size != sz) {
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * In per-thread mode, CPU is set to -1, but TID will be set instead.
>>> +	 * See auxtrace_mmap_params__set_idx()
>>> +	 */
>>> +	if (auxtrace_event->cpu == (__u32) -1)
>>> +		matchesCpuPid = auxtrace_event->tid == sample->tid;
>>> +	else
>>> +		matchesCpuPid = auxtrace_event->cpu == sample->cpu;
>>
>> If "matchesCpuPid" is false, can directly bail out at here, so can
>> avoid the below unnecessary calculations.
>>
>>> +
>>> +	/*
>>> +	 * In snapshot/overwrite mode, the head points to the end of the buffer so aux_offset needs
>>> +	 * to have the size subtracted so it points to the beginning as in normal mode.
>>> +	 */
>>> +	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE)
>>> +		aux_offset = aux_event->aux_offset - aux_event->aux_size;
>>> +	else
>>> +		aux_offset = aux_event->aux_offset;
>>> +
>>> +	if (matchesCpuPid &&
>>> +	    aux_offset >= auxtrace_event->offset &&
>>> +	    aux_offset + aux_event->aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>>
>> It's possible that an event PERF_RECORD_AUXTRACE saves AUX trace data
>> for multiple events PERF_RECORD_AUX (if we consider watermark).
>>
>> So here the logic makes sense for me for checking the buffer range and
>> I don't find any issue.
>>
>>> +		/*
>>> +		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>>> +		 * based on the sizes of the aux event, and queue that fragment.
>>> +		 */
>>> +		auxtrace_fragment.auxtrace = *auxtrace_event;
>>> +		auxtrace_fragment.auxtrace.size = aux_event->aux_size;
>>> +		auxtrace_fragment.auxtrace.offset = aux_offset;
>>> +		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>>> +		return auxtrace_queues__add_event(&etm->queues,
>>> +					       session,
>>> +					       &auxtrace_fragment,
>>> +					       file_offset,
>>> +					       NULL);
>>> +	}
>>> +
>>> +	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
>>> +	return 1;
>>> +}
>>> +
>>> +static int cs_etm__queue_aux_records_cb(struct perf_session *session,
>>> +			     union perf_event *event, u64 offset __maybe_unused,
>>> +			     void *data __maybe_unused)
> 
> Same comment about the indentation.
> 
>>> +{
>>> +	struct perf_sample sample;
>>> +	int ret;
>>> +	struct auxtrace_index_entry *ent;
>>> +	struct auxtrace_index *auxtrace_index;
>>> +	struct evsel *evsel;
>>> +	size_t i;
>>> +	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>> +						   struct cs_etm_auxtrace,
>>> +						   auxtrace);
>>> +
> 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> 						   struct cs_etm_auxtrace,
> 						   auxtrace);
> 	struct auxtrace_index *auxtrace_index;
> 	struct auxtrace_index_entry *ent;
> 	struct perf_sample sample;
> 	struct evsel *evsel;
> 	size_t i;
> 	int ret;
> 
>>> +	/* Don't care about any other events, we're only queuing buffers for AUX events */
>>> +	if (event->header.type != PERF_RECORD_AUX)
>>> +		return 0;
>>> +
>>> +	if (event->header.size < sizeof(struct perf_record_aux))
>>> +		return -EINVAL;
>>> +
>>> +	/* Truncated Aux records can have 0 size and shouldn't result in anything being queued. */
>>> +	if (!event->aux.aux_size)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Parse the sample, we need the sample_id_all data that comes after the event so that the
>>> +	 * CPU or PID can be matched to an AUXTRACE buffer's CPU or PID.
>>> +	 */
>>> +	evsel = evlist__event2evsel(session->evlist, event);
>>> +	evsel__parse_sample(evsel, event, &sample);
>>
>> It's good to check the return errors from evsel__parse_sample().
>>
>>> +
>>> +	/*
>>> +	 * Loop throuch the auxtrace index to find the buffer that matches up with this
>>> +	 * aux event.
>>> +	 * TODO: binary search?
>>
>> For binary search, you might need to reorg the auxtrace_index and
>> its entries, I personally think this is not the priority.
>>
> 
> Here too I agree with Leo.  
> 
>>> +	 */
>>> +	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
>>> +		for (i = 0; i < auxtrace_index->nr; i++) {
>>> +			ent = &auxtrace_index->entries[i];
>>> +			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
>>> +							 ent->sz, &event->aux, &sample);
>>> +			if (!ret) {
>>> +				etm->data_queued = true;
>>> +				return 0;
>>> +			} else if (ret < 0) {
>>> +				/*
>>> +				 * Anything other than 1 is an error. Positive values are 'not
>>> +				 * found' we just want to go onto the next one in that case.
>>> +				 */
>>> +				return ret;
>>> +			}
>>> +		}
>>> +	}
>>
>> It's good to add a warning at here?  If cannot find a matched
>> AUXRECORD event and fails to queue the fragment, it's likely caused by
>> the AUX ring buffer's overrun.
>>
>>> +
>>> +	/*
>>> +	 * We would get here if there are no entries in the index (either no auxtrace buffers or
>>> +	 * no index). Fail silently as there is the possibility of queueing them in
>>> +	 * cs_etm__process_auxtrace_event() if etm->data_queued is still false;
>>> +	 *
>>> +	 * In that scenario, buffers will not be split by AUX records.
>>> +	 */
>>> +	return 0;
>>> +}
>>> +
>>> +static int cs_etm__queue_aux_records(struct perf_session *session)
>>> +{
>>> +	return perf_session__peek_events(session, session->header.data_offset,
>>> +					 session->header.data_size,
>>> +					 cs_etm__queue_aux_records_cb, NULL);
> 
> Perfect indentation. Here cs_etm__queue_aux_records() doesn't give us much.  I
> would simply call perf_session__peek_events() from
> cs_etm__process_auxtrace_info().
> 
>>> +}
>>> +
>>>  int cs_etm__process_auxtrace_info(union perf_event *event,
>>>  				  struct perf_session *session)
>>>  {
>>> @@ -2879,12 +3034,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>>>  	if (err)
>>>  		goto err_delete_thread;
>>>  
>>> -	err = auxtrace_queues__process_index(&etm->queues, session);
>>> +	err = cs_etm__queue_aux_records(session);
>>>  	if (err)
>>>  		goto err_delete_thread;
>>>  
>>> -	etm->data_queued = etm->queues.populated;
>>
>> Seems to me it's no reason to remove this sentence.
>>
>> "etm->queues.populated" will be set when call
>> auxtrace_queues__add_event(), so we still can assign it to
>> "etm->data_queued" at here.
>>
>> Thanks,
>> Leo
>>
> 
> I'm happy with what is done in this patch.
> 
> Thanks,
> Mathieu
> 
>>> -
>>>  	return 0;
>>>  
>>>  err_delete_thread:
>>> -- 
>>> 2.28.0
>>>
