Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6A35A138
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhDIOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:36:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:41145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbhDIOfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:54 -0400
IronPort-SDR: /iEQOYZvgIWusp5+jinojyFLWNKDtQ2RhGJcKYqt5TOMSzaaKTbaGPC6mhruPoKTIIAcxz/qXs
 vZLnW1cskHRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193812281"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193812281"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 07:35:41 -0700
IronPort-SDR: YCm4ygIJ1oB1hKg8J80oLu0/Eqppbwh5Ap1b5mv0yE3d9fbcFnb6rqDZZUmLexWGVIfW1gIRof
 iive88Loa5/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="387801770"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2021 07:35:40 -0700
Received: from [10.209.7.33] (kliang2-MOBL.ccr.corp.intel.com [10.209.7.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A24EF5807A3;
        Fri,  9 Apr 2021 07:35:38 -0700 (PDT)
Subject: Re: [PATCH V5 23/25] perf/x86/msr: Add Alder Lake CPU support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-24-git-send-email-kan.liang@linux.intel.com>
 <YHAdW5GmTNwshpOi@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8e7c3eb5-d6e4-14d7-881c-614c428909d1@linux.intel.com>
Date:   Fri, 9 Apr 2021 10:35:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHAdW5GmTNwshpOi@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 5:24 AM, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 08:11:05AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> PPERF and SMI_COUNT MSRs are also supported on Alder Lake.
>>
>> The External Design Specification (EDS) is not published yet. It comes
>> from an authoritative internal source.
>>
>> The patch has been tested on real hardware.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/msr.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
>> index 680404c..c853b28 100644
>> --- a/arch/x86/events/msr.c
>> +++ b/arch/x86/events/msr.c
>> @@ -100,6 +100,8 @@ static bool test_intel(int idx, void *data)
>>   	case INTEL_FAM6_TIGERLAKE_L:
>>   	case INTEL_FAM6_TIGERLAKE:
>>   	case INTEL_FAM6_ROCKETLAKE:
>> +	case INTEL_FAM6_ALDERLAKE:
>> +	case INTEL_FAM6_ALDERLAKE_L:
>>   		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
>>   			return true;
>>   		break;
> 
> If only it would be sanely enumerated... What about sapphire rapids?
> 

SPR also supports the MSRs. I will submit a patch separately to support SPR.

Thanks,
Kan
