Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB48435A23A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhDIPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:47:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:47626 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIPre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:47:34 -0400
IronPort-SDR: owtE6YA/GBCKzRy8QAl5+PuU/Z7muUwEQqNsGxaCC6p05Jm2DGngPxYUGayU7A3JljgMiG6IMP
 fEglB9W279WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193827948"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193827948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:47:09 -0700
IronPort-SDR: rYpSCmdB/Oa0x44Bo26NfIeNiuTSUTE71xCYwt0Mt2f/AaIfk3cJWy32yM8H5rsLlmDe7/Jnt3
 5XJOWBmi78sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="382137555"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2021 08:47:09 -0700
Received: from [10.209.7.33] (kliang2-MOBL.ccr.corp.intel.com [10.209.7.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1AF915807A3;
        Fri,  9 Apr 2021 08:47:08 -0700 (PDT)
Subject: Re: [PATCH V5 16/25] perf/x86: Register hybrid PMUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-17-git-send-email-kan.liang@linux.intel.com>
 <YG/7BgFaRC/Eos76@hirez.programming.kicks-ass.net>
 <41c7b4ec-b742-2f7c-9991-7b23c9971dc6@linux.intel.com>
 <YHB2mNgw7k/NUIl9@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <525491eb-1733-ffd8-9b92-6409b2b6e0a0@linux.intel.com>
Date:   Fri, 9 Apr 2021 11:47:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHB2mNgw7k/NUIl9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 11:45 AM, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 09:50:20AM -0400, Liang, Kan wrote:
>>
>>
>> On 4/9/2021 2:58 AM, Peter Zijlstra wrote:
>>> On Mon, Apr 05, 2021 at 08:10:58AM -0700, kan.liang@linux.intel.com wrote:
>>>> @@ -2089,9 +2119,46 @@ static int __init init_hw_perf_events(void)
>>>>    	if (err)
>>>>    		goto out1;
>>>> -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>>>> -	if (err)
>>>> -		goto out2;
>>>> +	if (!is_hybrid()) {
>>>> +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>>>> +		if (err)
>>>> +			goto out2;
>>>> +	} else {
>>>> +		u8 cpu_type = get_this_hybrid_cpu_type();
>>>> +		struct x86_hybrid_pmu *hybrid_pmu;
>>>> +		bool registered = false;
>>>> +		int i;
>>>> +
>>>> +		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
>>>> +			cpu_type = x86_pmu.get_hybrid_cpu_type();
>>>> +
>>>> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
>>>> +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
>>>> +
>>>> +			hybrid_pmu->pmu = pmu;
>>>> +			hybrid_pmu->pmu.type = -1;
>>>> +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
>>>> +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
>>>> +
>>>> +			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
>>>> +						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
>>>> +			if (err)
>>>> +				continue;
>>>> +
>>>> +			if (cpu_type == hybrid_pmu->cpu_type)
>>>> +				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
>>>> +
>>>> +			registered = true;
>>>> +		}
>>>> +
>>>> +		if (!registered) {
>>>> +			pr_warn("Failed to register hybrid PMUs\n");
>>>> +			kfree(x86_pmu.hybrid_pmu);
>>>> +			x86_pmu.hybrid_pmu = NULL;
>>>> +			x86_pmu.num_hybrid_pmus = 0;
>>>> +			goto out2;
>>>> +		}
>>>
>>> I don't think this is quite right. registered will be true even if one
>>> fails, while I think you meant to only have it true when all (both)
>>> types registered correctly.
>>
>> No, I mean that perf error out only when all types fail to be registered.
> 
> All or nothing seems a better approach to me. There really isn't a good
> reason for any one of them to fail.
> 

Sure. I will change it in V6.

Thanks,
Kan
