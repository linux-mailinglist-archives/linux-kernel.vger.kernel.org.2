Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E680134702A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhCXDc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:32:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:50343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235128AbhCXDcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:32:08 -0400
IronPort-SDR: Kp4PVmbN2v3BQqHl1mzqKEhofPpHSAXGarnPbMZ8Nq7KoV7jRP+O3VKyYgPud+VZ/RD/7YPE9V
 5SiGihCLDklw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188303139"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="188303139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 20:32:07 -0700
IronPort-SDR: n9yiWYkkabwbYShanMlWpKWuSPT+7Nff9C+rz7HA/kkTLyQBup5hFvktxN31HzOXhy9PxsNA07
 G9aEv93c643Q==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="514024033"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 20:32:04 -0700
Subject: Re: [PATCH v4 RESEND 4/5] perf/x86/lbr: Skip checking for the
 existence of LBR_TOS for Arch LBR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-5-like.xu@linux.intel.com>
 <20210323214935.GF4746@worktop.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <b0344a1c-0b3f-f50d-5757-61d2eb766869@linux.intel.com>
Date:   Wed, 24 Mar 2021 11:32:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323214935.GF4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 5:49, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 02:06:34PM +0800, Like Xu wrote:
>> The Architecture LBR does not have MSR_LBR_TOS (0x000001c9). KVM will
>> generate #GP for this MSR access, thereby preventing the initialization
>> of the guest LBR.
>>
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   arch/x86/events/intel/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 382dd3994463..7f6d748421f2 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -5740,7 +5740,8 @@ __init int intel_pmu_init(void)
>>   	 * Check all LBR MSR here.
>>   	 * Disable LBR access if any LBR MSRs can not be accessed.
>>   	 */
>> -	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
>> +	if (x86_pmu.lbr_nr && !boot_cpu_has(X86_FEATURE_ARCH_LBR) &&
>> +	    !check_msr(x86_pmu.lbr_tos, 0x3UL))
>>   		x86_pmu.lbr_nr = 0;
> 
> But when ARCH_LBR we don't set lbr_tos, so we check MSR 0x000, not 0x1c9.

It's true.

> 
> Do we want check_msr() to ignore msr==0 ?

Considering another target of check_msr() is for uncore msrs,
how about this change:

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 759226919a36..06fa31a01a5b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4704,10 +4704,10 @@ static bool check_msr(unsigned long msr, u64 mask)
         u64 val_old, val_new, val_tmp;

         /*
-        * Disable the check for real HW, so we don't
+        * Disable the check for real HW or non-sense msr, so we don't
          * mess with potentionaly enabled registers:
          */
-       if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+       if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) || !msr)
                 return true;

         /*


> Additionally, do we want a check for lbr_info ?

I am not inclined to do this because we may have
virtualized model-specific guest LBR support
which may break the cpu_model assumption.

> 
>>   	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>   		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
>> -- 
>> 2.29.2
>>

