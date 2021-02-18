Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4638B31E367
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 01:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBRAJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 19:09:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:8383 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhBRAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 19:09:21 -0500
IronPort-SDR: HmXXP2bj+7cWLooxsuOTKf/wYC5krv5g9ssj6BuXX2erikKCmTUuwkb6Zr8HoFYPgCe2BPdvzH
 SKjkhpYYH2UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="247425899"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="247425899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 16:07:35 -0800
IronPort-SDR: q/kjDp5c7Wcz6UyjT93OZeHwlMe6UN2HDpnUDrfrbhZ3OLg8n7X1RqzElccwlsvqe00IUswfqr
 frplZnfk0M+A==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="400202268"
Received: from unknown (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 16:07:31 -0800
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <YCUXte/CMEQlCq4f@krava>
 <38f93d32-d133-8170-3c3a-0fdfa04a9058@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6cf9b7b8-fbae-738b-5ef7-a3ae8d933ce0@linux.intel.com>
Date:   Thu, 18 Feb 2021 08:07:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <38f93d32-d133-8170-3c3a-0fdfa04a9058@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2021 12:22 AM, Liang, Kan wrote:
> 
> 
> On 2/11/2021 6:40 AM, Jiri Olsa wrote:
>> On Mon, Feb 08, 2021 at 07:24:57AM -0800, kan.liang@linux.intel.com wrote:
>>
>> SNIP
>>
>>> Jin Yao (24):
>>>    perf jevents: Support unit value "cpu_core" and "cpu_atom"
>>>    perf util: Save pmu name to struct perf_pmu_alias
>>>    perf pmu: Save detected hybrid pmus to a global pmu list
>>>    perf pmu: Add hybrid helper functions
>>>    perf list: Support --cputype option to list hybrid pmu events
>>>    perf stat: Hybrid evsel uses its own cpus
>>>    perf header: Support HYBRID_TOPOLOGY feature
>>>    perf header: Support hybrid CPU_PMU_CAPS
>>>    tools headers uapi: Update tools's copy of linux/perf_event.h
>>>    perf parse-events: Create two hybrid hardware events
>>>    perf parse-events: Create two hybrid cache events
>>>    perf parse-events: Support hardware events inside PMU
>>>    perf list: Display pmu prefix for partially supported hybrid cache
>>>      events
>>>    perf parse-events: Support hybrid raw events
>>>    perf stat: Support --cputype option for hybrid events
>>>    perf stat: Support metrics with hybrid events
>>>    perf evlist: Create two hybrid 'cycles' events by default
>>>    perf stat: Add default hybrid events
>>>    perf stat: Uniquify hybrid event name
>>>    perf stat: Merge event counts from all hybrid PMUs
>>>    perf stat: Filter out unmatched aggregation for hybrid event
>>>    perf evlist: Warn as events from different hybrid PMUs in a group
>>>    perf Documentation: Document intel-hybrid support
>>>    perf evsel: Adjust hybrid event and global event mixed group
>>>
>>> Kan Liang (22):
>>>    perf/x86/intel: Hybrid PMU support for perf capabilities
>>>    perf/x86: Hybrid PMU support for intel_ctrl
>>>    perf/x86: Hybrid PMU support for counters
>>>    perf/x86: Hybrid PMU support for unconstrained
>>>    perf/x86: Hybrid PMU support for hardware cache event
>>>    perf/x86: Hybrid PMU support for event constraints
>>>    perf/x86: Hybrid PMU support for extra_regs
>>>    perf/x86/intel: Factor out intel_pmu_check_num_counters
>>>    perf/x86/intel: Factor out intel_pmu_check_event_constraints
>>>    perf/x86/intel: Factor out intel_pmu_check_extra_regs
>>>    perf/x86: Expose check_hw_exists
>>>    perf/x86: Remove temporary pmu assignment in event_init
>>>    perf/x86: Factor out x86_pmu_show_pmu_cap
>>>    perf/x86: Register hybrid PMUs
>>>    perf/x86: Add structures for the attributes of Hybrid PMUs
>>>    perf/x86/intel: Add attr_update for Hybrid PMUs
>>>    perf/x86: Support filter_match callback
>>>    perf/x86/intel: Add Alder Lake Hybrid support
>>>    perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
>>>    perf/x86/intel/uncore: Add Alder Lake support
>>>    perf/x86/msr: Add Alder Lake CPU support
>>>    perf/x86/cstate: Add Alder Lake CPU support
>>>
>>> Ricardo Neri (2):
>>>    x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
>>>    x86/cpu: Describe hybrid CPUs in cpuinfo_x86
>>>
>>> Zhang Rui (1):
>>>    perf/x86/rapl: Add support for Intel Alder Lake
>>
>> hi,
>> would you have git branch with all this somewhere?
>>
> 
> Here is the git branch
> 
> https://github.com/kliang2/perf.git adl_enabling
> 
> Please note that the branch is on top of Peter's perf/core branch, which doesn't include the latest 
> perf tool changes. The perf tool patches in the branch only includes the critical changes. There 
> will be more tool patches later, e.g., patches for perf mem, perf test etc.
> 
> Thanks,
> Kan

Yes, there will be much more perf tool patches later, such as the supports for perf mem, perf c2c 
and etc.

Since the AlderLake perf tool patches are too huge, I will separate the whole patches into several 
series in v2 and then post.

Thanks
Jin Yao
