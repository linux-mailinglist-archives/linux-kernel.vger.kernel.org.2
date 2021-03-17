Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFB33EEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCQKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:48:18 -0400
Received: from foss.arm.com ([217.140.110.172]:56822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCQKsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:48:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D83D6E;
        Wed, 17 Mar 2021 03:48:03 -0700 (PDT)
Received: from [10.57.17.188] (unknown [10.57.17.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4AC3F70D;
        Wed, 17 Mar 2021 03:48:01 -0700 (PDT)
Subject: Re: [PATCH v4 10/19] coresight: etm-perf: Allow an event to use
 different sinks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Linu Cherian <lcherian@marvell.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-11-suzuki.poulose@arm.com>
 <20210316202345.GE1387186@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9f13fcc6-ae8f-9a29-8cf3-993d200b5535@arm.com>
Date:   Wed, 17 Mar 2021 10:47:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316202345.GE1387186@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 8:23 PM, Mathieu Poirier wrote:
> On Thu, Feb 25, 2021 at 07:35:34PM +0000, Suzuki K Poulose wrote:
>> When a sink is not specified by the user, the etm perf driver
>> finds a suitable sink automatically, based on the first ETM
>> where this event could be scheduled. Then we allocate the
>> sink buffer based on the selected sink. This is fine for a
>> CPU bound event as the "sink" is always guaranteed to be
>> reachable from the ETM (as this is the only ETM where the
>> event is going to be scheduled). However, if we have a thread
>> bound event, the event could be scheduled on any of the ETMs
>> on the system. In this case, currently we automatically select
>> a sink and exclude any ETMs that cannot reach the selected
>> sink. This is problematic especially for 1x1 configurations.
>> We end up in tracing the event only on the "first" ETM,
>> as the default sink is local to the first ETM and unreachable
>> from the rest. However, we could allow the other ETMs to
>> trace if they all have a sink that is compatible with the
>> "selected" sink and can use the sink buffer. This can be
>> easily done by verifying that they are all driven by the
>> same driver and matches the same subtype. Please note
>> that at anytime there can be only one ETM tracing the event.
>>
>> Adding support for different types of sinks for a single
>> event is complex and is not something that we expect
>> on a sane configuration.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Tested-by: Linu Cherian <lcherian@marvell.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes:
>> - Rename sinks_match => sinks_compatible
>> - Tighten the check by matching the sink subtype
>> - Use user_sink instead of "sink_forced" and clean up the code (Mathieu)
>> - More comments, better commit description
>> ---
>>   .../hwtracing/coresight/coresight-etm-perf.c  | 60 ++++++++++++++++---
>>   1 file changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 0f603b4094f2..aa0974bd265b 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -232,6 +232,25 @@ static void etm_free_aux(void *data)
>>   	schedule_work(&event_data->work);
>>   }
>>   
>> +/*
>> + * Check if two given sinks are compatible with each other,
>> + * so that they can use the same sink buffers, when an event
>> + * moves around.
>> + */
>> +static bool sinks_compatible(struct coresight_device *a,
>> +			     struct coresight_device *b)
>> +{
>> +	if (!a || !b)
>> +		return false;
>> +	/*
>> +	 * If the sinks are of the same subtype and driven
>> +	 * by the same driver, we can use the same buffer
>> +	 * on these sinks.
>> +	 */
>> +	return (a->subtype.sink_subtype == b->subtype.sink_subtype) &&
>> +	       (sink_ops(a) == sink_ops(b));
> 
> Ok
> 
>> +}
>> +
>>   static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   			   int nr_pages, bool overwrite)
>>   {
>> @@ -239,6 +258,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   	int cpu = event->cpu;
>>   	cpumask_t *mask;
>>   	struct coresight_device *sink = NULL;
>> +	struct coresight_device *user_sink = NULL, *last_sink = NULL;
>>   	struct etm_event_data *event_data = NULL;
>>   
>>   	event_data = alloc_event_data(cpu);
>> @@ -249,7 +269,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   	/* First get the selected sink from user space. */
>>   	if (event->attr.config2) {
>>   		id = (u32)event->attr.config2;
>> -		sink = coresight_get_sink_by_id(id);
>> +		sink = user_sink = coresight_get_sink_by_id(id);
>>   	}
>>   
>>   	mask = &event_data->mask;
>> @@ -277,14 +297,33 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>   		}
>>   
>>   		/*
>> -		 * No sink provided - look for a default sink for one of the
>> -		 * devices. At present we only support topology where all CPUs
>> -		 * use the same sink [N:1], so only need to find one sink. The
>> -		 * coresight_build_path later will remove any CPU that does not
>> -		 * attach to the sink, or if we have not found a sink.
>> +		 * No sink provided - look for a default sink for all the ETMs,
>> +		 * where this event can be scheduled.
>> +		 * We allocate the sink specific buffers only once for this
>> +		 * event. If the ETMs have different default sink devices, we
>> +		 * can only use a single "type" of sink as the event can carry
>> +		 * only one sink specific buffer. Thus we have to make sure
>> +		 * that the sinks are of the same type and driven by the same
>> +		 * driver, as the one we allocate the buffer for. As such
>> +		 * we choose the first sink and check if the remaining ETMs
>> +		 * have a compatible default sink. We don't trace on a CPU
>> +		 * if the sink is not compatible.
>>   		 */
>> -		if (!sink)
>> +		if (!user_sink) {
>> +			/* Find the default sink for this ETM */
>>   			sink = coresight_find_default_sink(csdev);
>> +			if (!sink) {
>> +				cpumask_clear_cpu(cpu, mask);
>> +				continue;
>> +			}
>> +
>> +			/* Check if this sink compatible with the last sink */
>> +			if (last_sink && !sinks_compatible(last_sink, sink)) {
>> +				cpumask_clear_cpu(cpu, mask);
>> +				continue;
>> +			}
>> +			last_sink = sink;
> 
> This is much better.
> 
> I thought about something when I first looked a this patch in the previous
> revision...  With the above we are changing the behavior of the CS framework for
> systems that have one sink per CPU _clusters_, but for once it is for the better.
> 
> With this patch coresight_find_default_sink() is called for every CPU,
> allowing CPUs in the second cluster to find a valid path and be included in the
> trace session.  Before this patch CPUs in the second cluster couldn't
> establish a valid path to the sink since it was only reachable from the first
> cluster.

Exactly. That is the whole purpose of this patch. i.e, to allow tracing on all
CPUs with a per-cpu sink configuration.

> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks

Suzuki
