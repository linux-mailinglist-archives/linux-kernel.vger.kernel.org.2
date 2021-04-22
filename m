Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D706A3676B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhDVBT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:19:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:22442 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234970AbhDVBT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:19:26 -0400
IronPort-SDR: TayZT3Y70wM/gE5nrSFGpiqHqe5JfvXefU2419e0UWwac69mCskqlcAvQ+o6HMmdJKU6vnDOYJ
 SGQJamWcsccA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195363039"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="195363039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:18:52 -0700
IronPort-SDR: nnmpHPoD1JWEAFnLt2mNlW4tqI85WpxTTu5jISRn6lWir05mjwaI3ahzszhVSAkmloK+eV5AfG
 97q0Vm2FOYIQ==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427730533"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.255.29.162]) ([10.255.29.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:18:49 -0700
Subject: Re: [PATCH RESEND 1/2] perf/x86: Skip checking MSR for MSR 0x0
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210421021825.37872-1-like.xu@linux.intel.com>
 <YIBFCOz9R966xAVZ@google.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <8b799e26-f8b0-adeb-b8a6-331087c0d4be@linux.intel.com>
Date:   Thu, 22 Apr 2021 09:18:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBFCOz9R966xAVZ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/21 23:30, Sean Christopherson wrote:
> On Wed, Apr 21, 2021, Like Xu wrote:
>> The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
>> When ARCH_LBR we don't set lbr_tos, the failure from the
>> check_msr() against MSR 0x000 will make x86_pmu.lbr_nr = 0,
>> thereby preventing the initialization of the guest LBR.
>>
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/intel/core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 5272f349dca2..5036496caa60 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4751,10 +4751,10 @@ static bool check_msr(unsigned long msr, u64 mask)
>>   	u64 val_old, val_new, val_tmp;
>>   
>>   	/*
>> -	 * Disable the check for real HW, so we don't
>> +	 * Disable the check for real HW or non-sense msr, so we don't
> 
> I think this should be "undefined MSR" or something along those lines.  MSR 0x0
> is a "real" MSR, on Intel CPUs it's an alias for IA32_MC0_ADDR; at least it's
> supposed to be, most/all Intel CPUs incorrectly alias it to IA32_MC0_CTL.

Thank you, Sean.

<idle>-0       [000] dN.. 38980.032347: read_msr: 0, value fff

Do we have a historic story or specification for this kind of alias ?

#define MSR_IA32_MC0_ADDR               0x00000402
#define MSR_IA32_MC0_CTL                0x00000400

> 
> Anyways, my point is that if your definition of "nonsense" is any MSR that is
> not a valid perf MSR, then this check is woefully incompletely.  If your
> definition is a nonsensical value, then this comment is simply wrong.
> 
> What you're really looking for is precisely the case where the MSR was zero
> initialized and never defined.
> 
>>   	 * mess with potentionaly enabled registers:
>>   	 */
>> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) || !msr)
>>   		return true;
>>   
>>   	/*
>> -- 
>> 2.30.2
>>

