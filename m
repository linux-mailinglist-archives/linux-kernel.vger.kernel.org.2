Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262F33768E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhCKPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:10:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:14263 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233653AbhCKPKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:10:00 -0500
IronPort-SDR: jXkeUTjMvKX/7Qbxs0YprWU/z8lxACbPZOhA/HQcsCBOKB8EoMn0pMbQ4yfHOiHKCYtxKhatVI
 BPEP2q+tD1Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208504937"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="208504937"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:09:59 -0800
IronPort-SDR: UOJfqlUMv3/LSAyzsuH/KANGOVJAan5Rc6QgrmdHalsa2F590yFJu4CVdgyugOcvoqTaZiVzev
 KsPCo/fPeqQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="438729171"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2021 07:09:58 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 32D1E580816;
        Thu, 11 Mar 2021 07:09:57 -0800 (PST)
Subject: Re: [PATCH V2 08/25] perf/x86: Hybrid PMU support for hardware cache
 event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-9-git-send-email-kan.liang@linux.intel.com>
 <YEn513bZDuWKj3LS@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b29200cd-88c3-a0c9-d563-d76e819fe5f7@linux.intel.com>
Date:   Thu, 11 Mar 2021 10:09:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEn513bZDuWKj3LS@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 6:07 AM, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 08:37:44AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The hardware cache events are different among hybrid PMUs. Each hybrid
>> PMU should have its own hw cache event table.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/core.c       | 11 +++++++++--
>>   arch/x86/events/perf_event.h |  9 +++++++++
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 039a851..1db4a67 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -352,6 +352,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>>   {
>>   	struct perf_event_attr *attr = &event->attr;
>>   	unsigned int cache_type, cache_op, cache_result;
>> +	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
>>   	u64 config, val;
>>   
>>   	config = attr->config;
>> @@ -371,7 +372,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>>   		return -EINVAL;
>>   	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
>>   
>> -	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
>> +	if (pmu)
>> +		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
>> +	else
>> +		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
>>   
>>   	if (val == 0)
>>   		return -ENOENT;
>> @@ -380,7 +384,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
>>   		return -EINVAL;
>>   
>>   	hwc->config |= val;
>> -	attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
>> +	if (pmu)
>> +		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
>> +	else
>> +		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
> 
> Why not:
> 
> 	attr->config1 = hybrid(event->pmu, hw_cache_extra_regs)[cache_type][cache_op][cache_result];
> 
> ?

Because hw_cache_extra_regs is not part of the struct x86_pmu.


Thanks,
Kan
