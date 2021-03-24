Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73424346F29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCXCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:02:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:62317 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhCXCCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:02:11 -0400
IronPort-SDR: JKMcKSSGqg3jvq4Jvn7EoU7n3T1FTwwc2d33pezYzhMIgLEKJMbme45kRNwr/5Ad5KoijoG1VQ
 Yklk5HezqoXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190637171"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190637171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 19:02:11 -0700
IronPort-SDR: uCMsn+di9fCqE477yigC9GyHvbFNBLBr+ae5WCYO3wOWgXJQtivfsTUzDZuOjlUyKfW4a8bCNn
 gcuXUQp2vN1A==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="513998532"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 19:02:07 -0700
Subject: Re: [PATCH v4 RESEND 2/5] perf/x86/lbr: Simplify the exposure check
 for the LBR_INFO registers
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
 <20210322060635.821531-3-like.xu@linux.intel.com>
 <20210323213854.GD4746@worktop.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <d7703dfe-918a-15f8-ce67-fd4fefac9cfc@linux.intel.com>
Date:   Wed, 24 Mar 2021 10:02:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323213854.GD4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 5:38, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 02:06:32PM +0800, Like Xu wrote:
>> If the platform supports LBR_INFO register, the x86_pmu.lbr_info will
>> be assigned in intel_pmu_?_lbr_init_?() and it's safe to expose LBR_INFO
> 
> You mean: intel_pmu_lbr_*init*(). '?' is a single character glob and
> you've got too many '_'s.
> 
>> in the x86_perf_get_lbr() directly, instead of relying on lbr_format check.
> 
> But, afaict, not every model calls one of those. CORE_YONAH for example
> doesn't.
> 
>> Also Architectural LBR has IA32_LBR_x_INFO instead of LBR_FORMAT_INFO_x
>> to hold metadata for the operation, including mispredict, TSX, and
>> elapsed cycle time information.
> 
> Relevance?
> 
> Wouldn't it be much simpler to simple say something like:
> 
>    "x86_pmu.lbr_info is 0 unless explicitly initialized, so there's no
>    point checking lbr_fmt"

Yes, it is simpler and I will apply it in the next version.

> 
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   arch/x86/events/intel/lbr.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 21890dacfcfe..355ea70f1879 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1832,12 +1832,10 @@ void __init intel_pmu_arch_lbr_init(void)
>>    */
>>   int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
>>   {
>> -	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
>> -
>>   	lbr->nr = x86_pmu.lbr_nr;
>>   	lbr->from = x86_pmu.lbr_from;
>>   	lbr->to = x86_pmu.lbr_to;
>> -	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
>> +	lbr->info = x86_pmu.lbr_info;
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.29.2
>>

