Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8086E30BB46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBBJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:44:37 -0500
Received: from foss.arm.com ([217.140.110.172]:46692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhBBJng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:43:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6B17147A;
        Tue,  2 Feb 2021 01:42:49 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 592263F7D7;
        Tue,  2 Feb 2021 01:42:48 -0800 (PST)
Subject: Re: [PATCH V3 01/14] coresight: etm-perf: Allow an event to use
 different sinks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
 <20210201231720.GB1475392@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
Date:   Tue, 2 Feb 2021 09:42:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201231720.GB1475392@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 11:17 PM, Mathieu Poirier wrote:
> Hi Anshuman,
> 
> I have started reviewing this set.  As it is quite voluminous comments will
> come over serveral days.  I will let you know when I am done.
> 
> On Wed, Jan 27, 2021 at 02:25:25PM +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> When there are multiple sinks on the system, in the absence
>> of a specified sink, it is quite possible that a default sink
>> for an ETM could be different from that of another ETM. However
>> we do not support having multiple sinks for an event yet. This
>> patch allows the event to use the default sinks on the ETMs
>> where they are scheduled as long as the sinks are of the same
>> type.
>>
>> e.g, if we have 1x1 topology with per-CPU ETRs, the event can
>> use the per-CPU ETR for the session. However, if the sinks
>> are of different type, e.g TMC-ETR on one and a custom sink
>> on another, the event will only trace on the first detected
>> sink.
>>
> 
> I found the above changelog very confusing - I read it several times and still
> couldn't get all of it.  In the end this patch prevents sinks of different types
> from being used for session, and this is what the text should reflect.

Sorry about that. Your inference is correct, but it is only a side effect
of the primary motive. How about the following :

"When a sink is not specified by the user, the etm perf driver
finds a suitable sink automatically based on the first ETM, where
this event could be scheduled. Then we allocate the sink buffer based
on the selected sink. This is fine for a CPU bound event as the "sink"
is always guaranteed to be reachable from the ETM (as this is the only
ETM where the event is going to be scheduled). However, if we have a task
bound event, the event could be scheduled on any of the ETMs on the
system. In this case, currently we automatically select a sink and exclude
any ETMs that are not reachable from the selected sink. This is
problematic for 1x1 configurations as we end up in tracing the event
only on the "first" ETM, as the default sink is local to the first
ETM and unreachable from the rest.
However, we could allow the other ETMs to trace if they all have a
sink that is compatible with the "selected" sink and can use the
sink buffer. This can be easily done by verifying that they are
all driven by the same driver and matches the same subtype."


>   
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Tested-by: Linu Cherian <lcherian@marvell.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 48 +++++++++++++++++++-----
>>   1 file changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index bdc34ca..eb9e7e9 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -204,6 +204,13 @@ static void etm_free_aux(void *data)
>>   	schedule_work(&event_data->work);
>>   }
>>   
>> +static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
>> +{
>> +	if (!a || !b)
>> +		return false;
>> +	return (sink_ops(a) == sink_ops(b));
> 
> Yes

I think we can tighten this by verifying the dev->sub_type matches too.

> 
>> +}
>> +
>>   static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   			   int nr_pages, bool overwrite)
>>   {
>> @@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   	cpumask_t *mask;
>>   	struct coresight_device *sink = NULL;
> 
>          struct coresight_device *user_sink = NULL;
> 
>>   	struct etm_event_data *event_data = NULL;
>> +	bool sink_forced = false;
>>   
>>   	event_data = alloc_event_data(cpu);
>>   	if (!event_data)
>> @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   	if (event->attr.config2) {
>>   		id = (u32)event->attr.config2;
>>   		sink = coresight_get_sink_by_id(id);
> 
>                  user_sink = coresight_get_sink_by_id(id);
> 
>> +		sink_forced = true;
>>   	}
>>   
>>   	mask = &event_data->mask;
>> @@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   	 */
>>   	for_each_cpu(cpu, mask) {
>>   		struct list_head *path;
>> -		struct coresight_device *csdev;
> 
>                  struct coresight_device *last_sink = NULL;
> 
>> +		struct coresight_device *csdev, *new_sink;
>>   
>>   		csdev = per_cpu(csdev_src, cpu);
>>   		/*
>> @@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   		}
>>   
>>   		/*
>> -		 * No sink provided - look for a default sink for one of the
>> -		 * devices. At present we only support topology where all CPUs
>> -		 * use the same sink [N:1], so only need to find one sink. The
>> -		 * coresight_build_path later will remove any CPU that does not
>> -		 * attach to the sink, or if we have not found a sink.
>> +		 * No sink provided - look for a default sink for all the devices.
>> +		 * We only support multiple sinks, only if all the default sinks
>> +		 * are of the same type, so that the sink buffer can be shared
>> +		 * as the event moves around. We don't trace on a CPU if it can't
> 
> s/can't/can't./
> 
>> +		 *
> 
> Extra line
> 

OK

>>   		 */
>> -		if (!sink)
>> -			sink = coresight_find_default_sink(csdev);
>> +		if (!sink_forced) {
>> +			new_sink = coresight_find_default_sink(csdev);
>> +			if (!new_sink) {
>> +				cpumask_clear_cpu(cpu, mask);
>> +				continue;
>> +			}
>> +			/* Skip checks for the first sink */
>> +			if (!sink) {
>> +			       sink = new_sink;
>> +			} else if (!sinks_match(new_sink, sink)) {
>> +				cpumask_clear_cpu(cpu, mask);
>> +				continue;
>> +			}
>> +		} else {
>> +			new_sink = sink;
>> +		}
> 
>                  if (!user_sink) {
>                          /* find default sink for this CPU */
>                          sink = coresight_find_default_sink(csdev);
>                          if (!sink) {
>                                  cpumask_clear_cpu(cpu, mask);
>                                  continue;
>                          }
> 
>                          /* Chech new sink with last sink */
>                          if (last_sink && !sink_match(last_sink, sink)) {
>                                  cpumask_clear_cpu(cpu, mask);
>                                  continue;
>                          }
> 
>                          last_sink = sink;
>                  } else {
>                          sink = user_sink;
>                  }
> 

Agreed, it is much better readable.

Suzuki
