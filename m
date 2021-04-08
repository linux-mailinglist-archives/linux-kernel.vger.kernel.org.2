Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD6358C20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhDHSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:24:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:10393 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhDHSYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:24:46 -0400
IronPort-SDR: 0hjJYRxXjjEx3kjcNPwBhiptdHVAqbst9WwbvJNBj4YOI1H5q/OBzbV7lsYFQ/CrERoNrGzp5p
 WVfer+ERIlhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193149677"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="193149677"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 11:24:34 -0700
IronPort-SDR: 85cf7n+9RtQRomdxYD9G1/Sj0ZF6FXZA9BCX9NLwl9lHpgiIXiaxAz6bUFCR1aBFAFCHFS+jTy
 fbfdbPJvhGlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="530698250"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2021 11:24:34 -0700
Received: from [10.209.60.104] (kliang2-MOBL.ccr.corp.intel.com [10.209.60.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A0FA5580812;
        Thu,  8 Apr 2021 11:24:32 -0700 (PDT)
Subject: Re: [PATCH V5 04/25] perf/x86/intel: Hybrid PMU support for perf
 capabilities
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-5-git-send-email-kan.liang@linux.intel.com>
 <YG8H6Fac/p6PpcAu@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <191e68f1-fe6e-d948-f61a-91e156432828@linux.intel.com>
Date:   Thu, 8 Apr 2021 14:24:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG8H6Fac/p6PpcAu@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2021 9:40 AM, Peter Zijlstra wrote:
>> @@ -4330,7 +4347,7 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>>   
>>   static int intel_pmu_aux_output_match(struct perf_event *event)
>>   {
>> -	if (!x86_pmu.intel_cap.pebs_output_pt_available)
>> +	if (!intel_pmu_has_cap(event, PERF_CAP_PT_IDX))
>>   		return 0;
>>   
>>   	return is_intel_pt_event(event);
> these sites can have !event->pmu ?


I don't think the event->pmu can be NULL, but it could be pt_pmu.pmu.
If so, it should be a problem.

I think I will still use the x86_pmu.intel_cap.pebs_output_pt_available 
here in V6. The worst case is that we lost the PEBS via PT support on 
the small core for now.

I guess Alexander may provide a separate patch later to enable the PEBS 
via PT support on the ADL small core.

Thanks,
Kan
