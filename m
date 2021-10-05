Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1F423391
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhJEWhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:37:08 -0400
Received: from foss.arm.com ([217.140.110.172]:35688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhJEWhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C44C6D;
        Tue,  5 Oct 2021 15:35:16 -0700 (PDT)
Received: from [10.57.72.173] (unknown [10.57.72.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 924273F66F;
        Tue,  5 Oct 2021 15:35:14 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] coresight: trbe: Add a helper to fetch cpudata
 from perf handle
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-13-suzuki.poulose@arm.com>
 <20211004174239.GB3263478@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0ff450f4-ab3e-b409-5278-35cdfb883284@arm.com>
Date:   Tue, 5 Oct 2021 23:35:13 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211004174239.GB3263478@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 04/10/2021 18:42, Mathieu Poirier wrote:
> On Tue, Sep 21, 2021 at 02:41:16PM +0100, Suzuki K Poulose wrote:
>> Add a helper to get the CPU specific data for TRBE instance, from
>> a given perf handle. This also adds extra checks to make sure that
>> the event associated with the handle is "bound" to the CPU and is
>> active on the TRBE.
>>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 983dd5039e52..797d978f9fa7 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -268,6 +268,15 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>>   	return buf->nr_pages * PAGE_SIZE;
>>   }
>>   
>> +static inline struct trbe_cpudata *
>> +trbe_handle_to_cpudata(struct perf_output_handle *handle)
>> +{
>> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +
>> +	BUG_ON(!buf || !buf->cpudata);
>> +	return buf->cpudata;
>> +}
>> +
>>   /*
>>    * TRBE Limit Calculation
>>    *
>> @@ -533,8 +542,7 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>>   {
>>   	int ec = get_trbe_ec(trbsr);
>>   	int bsc = get_trbe_bsc(trbsr);
>> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
>> -	struct trbe_cpudata *cpudata = buf->cpudata;
>> +	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
> 
> There is two other places where this pattern is present:  is_perf_trbe() and
> __trbe_normal_offset().

I skipped them, as they have to get access to the "trbe_buf" anyways.
So the step by step, made sense. But I could replace them too to make it
transparent.

What do you think ?

Suzuki


