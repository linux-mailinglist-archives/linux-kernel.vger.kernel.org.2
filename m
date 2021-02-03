Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7830E777
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhBCXhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:37:09 -0500
Received: from foss.arm.com ([217.140.110.172]:48750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhBCXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:37:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F06A1D6E;
        Wed,  3 Feb 2021 15:36:16 -0800 (PST)
Received: from [10.57.47.183] (unknown [10.57.47.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82EE3F694;
        Wed,  3 Feb 2021 15:36:15 -0800 (PST)
Subject: Re: [PATCH V3 07/14] coresight: etm-perf: Handle stale output handles
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-8-git-send-email-anshuman.khandual@arm.com>
 <20210203190513.GF1536093@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b647135d-7d4f-1213-df00-2fd4028a23f3@arm.com>
Date:   Wed, 3 Feb 2021 23:36:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203190513.GF1536093@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 7:05 PM, Mathieu Poirier wrote:
> On Wed, Jan 27, 2021 at 02:25:31PM +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> The context associated with an ETM for a given perf event
>> includes :
>>    - handle -> the perf output handle for the AUX buffer.
>>    - the path for the trace components
>>    - the buffer config for the sink.
>>
>> The path and the buffer config are part of the "aux_priv" data
>> (etm_event_data) setup by the setup_aux() callback, and made available
>> via perf_get_aux(handle).
>>
>> Now with a sink supporting IRQ, the sink could "end" an output
>> handle when the buffer reaches the programmed limit and would try
>> to restart a handle. This could fail if there is not enough
>> space left the AUX buffer (e.g, the userspace has not consumed
>> the data). This leaves the "handle" disconnected from the "event"
>> and also the "perf_get_aux()" cleared. This all happens within
>> the sink driver, without the etm_perf driver being aware.
>> Now when the event is actually stopped, etm_event_stop()
>> will need to access the "event_data". But since the handle
>> is not valid anymore, we loose the information to stop the
>> "trace" path. So, we need a reliable way to access the etm_event_data
>> even when the handle may not be active.
>>
>> This patch replaces the per_cpu handle array with a per_cpu context
>> for the ETM, which tracks the "handle" as well as the "etm_event_data".
>> The context notes the etm_event_data at etm_event_start() and clears
>> it at etm_event_stop(). This makes sure that we don't access a
>> stale "etm_event_data" as we are guaranteed that it is not
>> freed by free_aux() as long as the event is active and tracing,
>> also provides us with access to the critical information
>> needed to wind up a session even in the absence of an active
>> output_handle.
>>
>> This is not an issue for the legacy sinks as none of them supports
>> an IRQ and is centrally handled by the etm-perf.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 45 +++++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index eb9e7e9..a3977b0 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -24,7 +24,26 @@
>>   static struct pmu etm_pmu;
>>   static bool etm_perf_up;
>>   
>> -static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
>> +/*
>> + * An ETM context for a running event includes the perf aux handle
>> + * and aux_data. For ETM, the aux_data (etm_event_data), consists of
>> + * the trace path and the sink configuration. The event data is accessible
>> + * via perf_get_aux(handle). However, a sink could "end" a perf output
>> + * handle via the IRQ handler. And if the "sink" encounters a failure
>> + * to "begin" another session (e.g due to lack of space in the buffer),
>> + * the handle will be cleared. Thus, the event_data may not be accessible
>> + * from the handle when we get to the etm_event_stop(), which is required
>> + * for stopping the trace path. The event_data is guaranteed to stay alive
>> + * until "free_aux()", which cannot happen as long as the event is active on
>> + * the ETM. Thus the event_data for the session must be part of the ETM context
>> + * to make sure we can disable the trace path.
>> + */
>> +struct etm_ctxt {
>> +	struct perf_output_handle handle;
>> +	struct etm_event_data *event_data;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
>>   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>>   
>>   /* ETMv3.5/PTM's ETMCR is 'config' */
>> @@ -332,7 +351,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>>   {
>>   	int cpu = smp_processor_id();
>>   	struct etm_event_data *event_data;
>> -	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
>> +	struct perf_output_handle *handle = &ctxt->handle;
>>   	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>>   	struct list_head *path;
>>
>          if (!csdev)
>                  goto fail;
> 
>          /*
>           * Something went wrong if an event data is already associated
>           * with a context.
>           */
>          if (WARN_ONE(ctxt->event_data))
>                  goto fail;
>   
>> @@ -374,6 +394,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>>   	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>>   		goto fail_disable_path;
>>   
>> +	/* Save the event_data for this ETM */
>> +	ctxt->event_data = event_data;
>>   out:
>>   	return;
>>   
>> @@ -392,13 +414,20 @@ static void etm_event_stop(struct perf_event *event, int mode)
>>   	int cpu = smp_processor_id();
>>   	unsigned long size;
>>   	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>> -	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> -	struct etm_event_data *event_data = perf_get_aux(handle);
>> +	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
>> +	struct perf_output_handle *handle = &ctxt->handle;
> 
> 	struct etm_event_data *event_data = perf_get_aux(handle);
>>   	struct list_head *path;
>>
> 
>          if (WARN_ON(event_data && event_data != ctxt->event_data))
>                  return;
> 
>          event_data = ctxt->event_data;
> 	/* Clear the event_data as this ETM is stopping the trace. */
> 	ctxt->event_data = NULL;
> 
> With the above:


I have folded the following changes in :

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c 
b/drivers/hwtracing/coresight/coresight-etm-perf.c
index cf0b0c2d5eed..9f85bf28a82f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -375,6 +375,10 @@ static void etm_event_start(struct perf_event *event, int flags)
  	if (!csdev)
  		goto fail;

+	/* Have we messed up our tracking ? */
+	if (WARN_ON(ctxt->event_data))
+		goto fail;
+
  	/*
  	 * Deal with the ring buffer API and get a handle on the
  	 * session's information.
@@ -432,11 +436,21 @@ static void etm_event_stop(struct perf_event *event, int mode)
  	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
  	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
  	struct perf_output_handle *handle = &ctxt->handle;
-	struct etm_event_data *event_data = ctxt->event_data;
+	struct etm_event_data *event_data;
  	struct list_head *path;

+	/*
+	 * If we still have access to the event_data via handle,
+	 * confirm that we haven't messed up the tracking.
+	 */
+	if (handle->event &&
+	    WARN_ON(perf_get_aux(handle) != ctxt->event_data))
+		return;
+
+	event_data = ctxt->event_data;
  	/* Clear the event_data as this ETM is stopping the trace. */
  	ctxt->event_data = NULL;
+
  	if (event->hw.state == PERF_HES_STOPPED)
  		return;

> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks
Suzuki
