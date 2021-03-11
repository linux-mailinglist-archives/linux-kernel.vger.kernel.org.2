Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAD337AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCKRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:25:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:43930 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhCKRZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:25:19 -0500
IronPort-SDR: Ct3fYWRJT5I+VDHLP7rBZIS1vlsGKEzKt5DdMAO/De9iUC9ir+XBGQ5BTLeu65JL5C8wfbFyNa
 6MNdewHWJh6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188800539"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188800539"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:25:18 -0800
IronPort-SDR: iFlcMHLMuCa/j6tIYe42wD0/b27tp/AWe68zWU/Ta8IFoIasAb/hSj9tY4yhzVbyWsDCP3tx4D
 Wby1U+MeLVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="431658323"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2021 09:25:18 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 75308580514;
        Thu, 11 Mar 2021 09:25:16 -0800 (PST)
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
Message-ID: <bbb66fce-71f4-e5a7-4930-21a7417ababa@linux.intel.com>
Date:   Thu, 11 Mar 2021 12:25:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 11:53 AM, Liang, Kan wrote:
> 
> 
> On 3/11/2021 11:09 AM, Peter Zijlstra wrote:
>> On Wed, Mar 10, 2021 at 08:37:56AM -0800, kan.liang@linux.intel.com 
>> wrote:
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
>>>    The "cpu_atom" PMU supports PEBS-via-PT.
>>>
>>> The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
>>> PMEM.
>>> The "cpu_atom" PMU is similar to Tremont, but with different
>>> event_constraints, extra_regs and number of counters.
>>>
>>
>>> +        /* Initialize big core specific PerfMon capabilities.*/
>>> +        pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>>> +        pmu->name = "cpu_core";
>>
>>> +        /* Initialize Atom core specific PerfMon capabilities.*/
>>> +        pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
>>> +        pmu->name = "cpu_atom";
>>
>> So do these things use the same event lists as SPR and TNT?
> 
> No, there will be two new event lists on ADL. One is for Atom core, and 
> the other is for big core. They are different to SPR and TNT.
> 
>> Is there any
>> way to discover that, because AFAICT /proc/cpuinfo will say every CPU
>> is 'Alderlake', and the above also doesn't give any clue.
>>
> 
> Ricardo once submitted a patch to expose the CPU type under 
> /sys/devices/system/cpu, but I don't know the latest status.
> https://lore.kernel.org/lkml/20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com/ 
> 
> 
> 
> 
>> FWIW, ARM big.LITTLE does discriminate in its /proc/cpuinfo, but I'm not
>> entirely sure it's really useful. Mark said perf userspace uses
>> somethink akin to our CPUID, except exposed through sysfs, to find the
>> event lists.
>>

Ah, I guess I misunderstood the concern. Let me try again.

Here is how perf tool find a event name via event list.

To get the correct event list file, yes, perf tool relies on the CPUID.
It will search a CPUID table in the 
tools/perf/pmu-events/arch/x86/mapfile.csv.
     GenuineIntel-6-97,v1,alderlake,core
Now perf tool knows the event list file "alderlake" is for the CPUID 97.

In the event list file for the Alder Lake (CPUID 0x97), we add a new 
field "Unit" to distinguish the type of PMU.
     "Unit": "cpu_core"
     "Unit": "cpu_atom"

So perf can search the event name for a certain type of PMU via PMU name 
"cpu_core" or "cpu_atom".

Perf tool doesn't use the "cpu_core/caps/pmu_name" for the event list.

Thanks,
Kan
