Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26741E925
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbhJAIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:38:22 -0400
Received: from foss.arm.com ([217.140.110.172]:37874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352782AbhJAIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBFD101E;
        Fri,  1 Oct 2021 01:36:28 -0700 (PDT)
Received: from [10.57.72.173] (unknown [10.57.72.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7778F3F793;
        Fri,  1 Oct 2021 01:36:26 -0700 (PDT)
Subject: Re: [PATCH v2 03/17] coresight: trbe: Add a helper to calculate the
 trace generated
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-4-suzuki.poulose@arm.com>
 <20210930175421.GB3047827@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <60037d18-9d0e-68ce-2a34-aa84e7876fb8@arm.com>
Date:   Fri, 1 Oct 2021 09:36:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930175421.GB3047827@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 18:54, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Tue, Sep 21, 2021 at 02:41:07PM +0100, Suzuki K Poulose wrote:
>> We collect the trace from the TRBE on FILL event from IRQ context
>> and when via update_buffer(), when the event is stopped. Let us
> 
> s/"and when via"/"and via"
> 
>> consolidate how we calculate the trace generated into a helper.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++--------
>>   1 file changed, 30 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 63f7edd5fd1f..063c4505a203 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -527,6 +527,30 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>>   	return TRBE_FAULT_ACT_SPURIOUS;
>>   }
>>   
>> +static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>> +					 struct trbe_buf *buf,
>> +					 bool wrap)
> 
> Stacking
> 

Ack

>> +{
>> +	u64 write;
>> +	u64 start_off, end_off;
>> +
>> +	/*
>> +	 * If the TRBE has wrapped around the write pointer has
>> +	 * wrapped and should be treated as limit.
>> +	 */
>> +	if (wrap)
>> +		write = get_trbe_limit_pointer();
>> +	else
>> +		write = get_trbe_write_pointer();
>> +
>> +	end_off = write - buf->trbe_base;
> 
> In both arm_trbe_alloc_buffer() and trbe_handle_overflow() the base address is
> acquired using get_trbe_base_pointer() but here it is referenced directly - any
> reason for that?  It certainly makes reviewing this simple patch quite
> difficult because I keep wondering if I am missing something subtle...

Very good observation. So far, we always prgrammed the TRBBASER with the
the VA(ring_buffer[0]). And thus reading the BASER and using the 
buf->trbe_base is all fine.

But going forward, we are going to use different values for the TRBBASER
to work around erratum. Thus to make the computation of the "offsets"
within the ring buffer, it is always correct to use this field. I could
move this to the patch where the work around is introduced, and put in
a comment there.

Thanks for the review

Suzuki

