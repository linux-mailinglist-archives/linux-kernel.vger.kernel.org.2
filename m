Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B108337ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCKRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:31:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:7048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCKRbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:31:10 -0500
IronPort-SDR: hE5Tay7vDuUJZfMZ1bIOGn1uUa02h7FggHyoJninA3R6GJx3grwlmo6MQoz2CTRS5iIYde1gtO
 bJ9bTHuzImZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="186329383"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="186329383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:31:09 -0800
IronPort-SDR: Bugh2Iwt9i2MF+AnVAn3xB1b6sNsAqoinvdDQ1/OuBEPtH1Xb0FvUeu3V+7ghXdDwP6gt6LEAC
 YlVkXIYCAskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="404139836"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2021 09:31:09 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DA88B580514;
        Thu, 11 Mar 2021 09:31:07 -0800 (PST)
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Mark Rutland <mark.rutland@arm.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <YEpGMm2xnfbxDZpp@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0094f13f-17b9-3d55-a57c-a48e82fb848c@linux.intel.com>
Date:   Thu, 11 Mar 2021 12:31:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEpGMm2xnfbxDZpp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 11:32 AM, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 05:09:25PM +0100, Peter Zijlstra wrote:
>> On Wed, Mar 10, 2021 at 08:37:56AM -0800, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Alder Lake Hybrid system has two different types of core, Golden Cove
>>> core and Gracemont core. The Golden Cove core is registered to
>>> "cpu_core" PMU. The Gracemont core is registered to "cpu_atom" PMU.
>>>
>>> The difference between the two PMUs include:
>>> - Number of GP and fixed counters
>>> - Events
>>> - The "cpu_core" PMU supports Topdown metrics.
>>>    The "cpu_atom" PMU supports PEBS-via-PT.
>>>
>>> The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
>>> PMEM.
>>> The "cpu_atom" PMU is similar to Tremont, but with different
>>> event_constraints, extra_regs and number of counters.
>>>
>>
>>> +		/* Initialize big core specific PerfMon capabilities.*/
>>> +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>>> +		pmu->name = "cpu_core";
>>
>>> +		/* Initialize Atom core specific PerfMon capabilities.*/
>>> +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
>>> +		pmu->name = "cpu_atom";
>>
>> So do these things use the same event lists as SPR and TNT? Is there any
>> way to discover that, because AFAICT /proc/cpuinfo will say every CPU
>> is 'Alderlake', and the above also doesn't give any clue.
>>
>> FWIW, ARM big.LITTLE does discriminate in its /proc/cpuinfo, but I'm not
>> entirely sure it's really useful. Mark said perf userspace uses
>> somethink akin to our CPUID, except exposed through sysfs, to find the
>> event lists.
>>
>> My desktop has: cpu/caps/pmu_name and that gives "skylake", do we want
>> the above to have cpu_core/caps/pmu_name give "sapphire_rapids" etc.. ?
> 
> FWIW, "Tremont" is the only pmu_name with a capital :-( I don't suppose
> we can still fix that?
> 

The cpu/caps/pmu_name is not used for the event list.

I don't think perf tool checks the "Tremont". I think it should be OK to 
fix it. Let me post a patch.

Thanks,
Kan
