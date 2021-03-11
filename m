Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004AB337A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCKQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:54:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:16439 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCKQxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:53:41 -0500
IronPort-SDR: Xe1cPkMmw5E7xVQadQV0MGhVb3sg+u/xaTGs2XsQW+9ofwmfMqyDrDw9GhGy3eCr33CpPe403B
 PEQEXwqBnxjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188736812"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188736812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 08:53:39 -0800
IronPort-SDR: vC5obF2K5PiiFzrrfE+lRZOg1UmRm/I+mTRCNNnjc0UE7imEJl2Da32rftR89K/EtRLlWQXsvk
 Peyxvm+HkBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="438232616"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2021 08:53:38 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F33605808F3;
        Thu, 11 Mar 2021 08:53:36 -0800 (PST)
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
Date:   Thu, 11 Mar 2021 11:53:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 11:09 AM, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 08:37:56AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Alder Lake Hybrid system has two different types of core, Golden Cove
>> core and Gracemont core. The Golden Cove core is registered to
>> "cpu_core" PMU. The Gracemont core is registered to "cpu_atom" PMU.
>>
>> The difference between the two PMUs include:
>> - Number of GP and fixed counters
>> - Events
>> - The "cpu_core" PMU supports Topdown metrics.
>>    The "cpu_atom" PMU supports PEBS-via-PT.
>>
>> The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
>> PMEM.
>> The "cpu_atom" PMU is similar to Tremont, but with different
>> event_constraints, extra_regs and number of counters.
>>
> 
>> +		/* Initialize big core specific PerfMon capabilities.*/
>> +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>> +		pmu->name = "cpu_core";
> 
>> +		/* Initialize Atom core specific PerfMon capabilities.*/
>> +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
>> +		pmu->name = "cpu_atom";
> 
> So do these things use the same event lists as SPR and TNT?

No, there will be two new event lists on ADL. One is for Atom core, and 
the other is for big core. They are different to SPR and TNT.

> Is there any
> way to discover that, because AFAICT /proc/cpuinfo will say every CPU
> is 'Alderlake', and the above also doesn't give any clue.
>

Ricardo once submitted a patch to expose the CPU type under 
/sys/devices/system/cpu, but I don't know the latest status.
https://lore.kernel.org/lkml/20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com/



> FWIW, ARM big.LITTLE does discriminate in its /proc/cpuinfo, but I'm not
> entirely sure it's really useful. Mark said perf userspace uses
> somethink akin to our CPUID, except exposed through sysfs, to find the
> event lists.
>

Perf tool can use the pmu name.
For perf stat -e cpu_atom/EVENT_NAME/, perf will apply the event list 
for atom.
For perf stat -e cpu_core/EVENT_NAME/, perf will apply the event list 
for the big core.
For perf stat -e EVENT_NAME, perf tool will check if the EVENT_NAME 
exists. If it's available on both event list, perf will automatically 
create two events, perf stat -e cpu_atom/EVENT_NAME/,cpu_core/EVENT_NAME/.
If the event name is only available on a certain type, e.g., atom. The 
perf tool will only apply the corresponding event, e.g., perf stat -e 
cpu_atom/EVENT_NAME/

> My desktop has: cpu/caps/pmu_name and that gives "skylake", do we want
> the above to have cpu_core/caps/pmu_name give "sapphire_rapids" etc.. ?
> 

I think current implementation should be good enough.

$ cat /sys/devices/cpu_atom/caps/pmu_name
alderlake_hybrid

"alderlake_hybrid" tells the perf tool that it's Alder Lake Hybrid system.
"cpu_atom" tells the perf tool that it's for Atom core.


Thanks,
Kan
