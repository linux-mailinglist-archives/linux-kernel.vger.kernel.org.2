Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF92337817
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhCKPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:41:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:58359 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234085AbhCKPlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:41:21 -0500
IronPort-SDR: GAP5UrQTP3+bXFB9Y/pgIa637+OnoXnFcDmQ9OTEvuAzQJnqKKVDZqz/p1elge787st9u7Zkts
 xvkAv58ttRKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="252701468"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="252701468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:41:20 -0800
IronPort-SDR: k9NRVQ7n59owaGICOtY/XD7WREgy2Ro4Ay4x0X/VaS0zLQQ3MsciwKCI6DQbg/FfFY32Y6l3o6
 W2hekEinXahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="438738277"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2021 07:41:03 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 17131580514;
        Thu, 11 Mar 2021 07:41:01 -0800 (PST)
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <24dbe717-ffb8-204b-bac2-59941c2314f7@linux.intel.com>
Date:   Thu, 11 Mar 2021 10:41:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 7:34 AM, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 08:37:52AM -0800, kan.liang@linux.intel.com wrote:
>> @@ -2092,9 +2105,37 @@ static int __init init_hw_perf_events(void)
>>   	if (err)
>>   		goto out1;
>>   
>> -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>> -	if (err)
>> -		goto out2;
>> +	if (!is_hybrid()) {
>> +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>> +		if (err)
>> +			goto out2;
>> +	} else {
>> +		u8 cpu_type = get_hybrid_cpu_type(smp_processor_id());
>> +		struct x86_hybrid_pmu *hybrid_pmu;
>> +		int i;
>> +
>> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
>> +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
>> +
>> +			hybrid_pmu->pmu = pmu;
>> +			hybrid_pmu->pmu.type = -1;
>> +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
>> +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
>> +
>> +			/* Only register the PMU for the boot CPU */
> 
> Why ?!
> > AFAICT we could register them all here. That instantly fixes that
> CPU_STARTING / CPU_DEAD fail elsewhere in this patch.

It's possible that all CPUs of a certain type all offline, but I cannot 
know the information here, because the boot CPU is the only online CPU. 
I don't know the status of the other CPUs.

If we unconditionally register all PMUs, users may see a PMU in 
/sys/devices, but they cannot use it, because there is no available CPU.
Is it acceptable that registering an empty PMU?


Thanks,
Kan

