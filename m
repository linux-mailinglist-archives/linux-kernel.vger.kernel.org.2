Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3F334545
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhCJRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:38:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:20521 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCJRik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:38:40 -0500
IronPort-SDR: bqwauvv9Ttp+S76vpmH7tScQfczm5sZN2dMEvub7XC9LNt71tbSVQkGzGbJEqiP+NgfcQbYS6p
 mRk3U8WQflTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="252540309"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="252540309"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 09:38:37 -0800
IronPort-SDR: 1ahEmA63Re4qRs6O+MzE+7cr+uLD9nKmKUAmFMs19suHhtqcov5Td2qNCJ+PgZBnE9bAfuHGqr
 cCs1revEMPKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="410277083"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2021 09:38:37 -0800
Received: from [10.251.19.203] (kliang2-MOBL.ccr.corp.intel.com [10.251.19.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5E2CB5808B0;
        Wed, 10 Mar 2021 09:38:36 -0800 (PST)
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
To:     Dave Hansen <dave.hansen@intel.com>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <a1adb737-f126-ecec-9bca-a1b5bdb76156@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e8dd446f-f57c-dfbd-d923-b313411b74a0@linux.intel.com>
Date:   Wed, 10 Mar 2021 12:38:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a1adb737-f126-ecec-9bca-a1b5bdb76156@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2021 11:50 AM, Dave Hansen wrote:
> On 3/10/21 8:37 AM, kan.liang@linux.intel.com wrote:
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
> 
> Where's the preempt_disable()?
> 
>> +static void init_hybrid_pmu(int cpu)
>> +{
>> +	unsigned int fixed_mask, unused_eax, unused_ebx, unused_edx;
>> +	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>> +	u8 cpu_type = get_hybrid_cpu_type(cpu);
>> +	struct x86_hybrid_pmu *pmu = NULL;
>> +	struct perf_cpu_context *cpuctx;
>> +	int i;
> 
> Ditto.
> 
> Are we really sure the IPIs are worth the trouble?  Why don't we just
> cache the leaf when we bring the CPU up like just about every other
> thing we read from CPUID?

Simple answer: You are right. We don't need it. A simple 
get_this_hybrid_cpu_type() should be fine for perf.

Here is the complete story.
I need the CPU type of the dead CPU in the cpu_dead. In the previous 
patch set, we can read it from the cached CPU type in the struct 
cpuinfo_x86.

In the V2 patch, I tried to do a similar thing (but I have to read it at 
runtime). Since the CPU is offlined, I asked Ricardo to provide the 
function get_hybrid_cpu_type() which can read the CPU type of a specific 
CPU. But I'm wrong. We cannot retrieve the valid CPU type from an 
offlined CPU. So I dropped the method and used another method to 
retrieve the information, but I didn't let Ricardo update the function. 
My bad.

Now, we only need to read the CPU type of the current CPU. A 
get_this_hybrid_cpu_type() function is enough for me.

I think we can get rid of the IPIs trouble with the new 
get_this_hybrid_cpu_type() in the next version. We shouldn't need the 
preempt_disable() either.

Thanks for pointing that out.

Kan

