Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663233DBA93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhG3O3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbhG3O3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:29:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D31BD6D;
        Fri, 30 Jul 2021 07:29:08 -0700 (PDT)
Received: from [10.57.86.111] (unknown [10.57.86.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F48C3F70D;
        Fri, 30 Jul 2021 07:29:06 -0700 (PDT)
Subject: Re: [PATCH 05/10] coresight: trbe: Allow driver to choose a different
 alignment
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-6-suzuki.poulose@arm.com>
 <646d73c5-0015-d296-2ac8-63f8bd5a4dc0@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <43d802e7-d321-6386-19ee-d3bd8e0c1bbb@arm.com>
Date:   Fri, 30 Jul 2021 15:29:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <646d73c5-0015-d296-2ac8-63f8bd5a4dc0@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 12:02, Anshuman Khandual wrote:
> 
> 
> On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
>> The TRBE hardware mandates a minimum alignment for the TRBPTR_EL1,
>> advertised via the TRBIDR_EL1. This is used by the driver to
>> align the buffer write head. This patch allows the driver to
>> choose a different alignment from that of the hardware, by
>> decoupling the alignment tracking. This will be useful for
>> working around errata.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 9735d514c5e1..9ea28813182b 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -92,7 +92,8 @@ static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
>>   /*
>>    * struct trbe_cpudata: TRBE instance specific data
>>    * @trbe_flag		- TRBE dirty/access flag support
>> - * @tbre_align		- Actual TRBE alignment required for TRBPTR_EL1.
>> + * @trbe_hw_align	- Actual TRBE alignment required for TRBPTR_EL1.
>> + * @trbe_align		- Software alignment used for the TRBPTR_EL1,
>>    * @cpu			- CPU this TRBE belongs to.
>>    * @mode		- Mode of current operation. (perf/disabled)
>>    * @drvdata		- TRBE specific drvdata
>> @@ -100,6 +101,7 @@ static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
>>    */
>>   struct trbe_cpudata {
>>   	bool trbe_flag;
>> +	u64 trbe_hw_align;
>>   	u64 trbe_align;
>>   	int cpu;
>>   	enum cs_mode mode;
>> @@ -906,7 +908,7 @@ static ssize_t align_show(struct device *dev, struct device_attribute *attr, cha
>>   {
>>   	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
>>   
>> -	return sprintf(buf, "%llx\n", cpudata->trbe_align);
>> +	return sprintf(buf, "%llx\n", cpudata->trbe_hw_align);
>>   }
>>   static DEVICE_ATTR_RO(align);
>>   
>> @@ -995,11 +997,13 @@ static void arm_trbe_probe_cpu(void *info)
>>   	}
>>   
>>   	trbe_check_errata(cpudata);
>> -	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
>> -	if (cpudata->trbe_align > SZ_2K) {
>> +
>> +	cpudata->trbe_hw_align = 1ULL << get_trbe_address_align(trbidr);
>> +	if (cpudata->trbe_hw_align > SZ_2K) {
>>   		pr_err("Unsupported alignment on cpu %d\n", cpu);
>>   		goto cpu_clear;
>>   	}
>> +	cpudata->trbe_align = cpudata->trbe_hw_align;
> 
> When it changes, it must be asserted that trbe_align would be a multiple
> of trbe_hw_align before existing from arm_trbe_probe_cpu().

We only set it to PAGE_SIZE, which is one of 4K, 16K, 64K all of which
are aligned to 2K or any of the smaller alignment supported by TRBE.


> 
>>   	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
>>   	cpudata->cpu = cpu;
>>   	cpudata->drvdata = drvdata;
>>
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 

Thanks
Suzuki
