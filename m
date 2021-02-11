Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521493190F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhBKRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:22:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:35348 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231737AbhBKQYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:24:15 -0500
IronPort-SDR: 3DOufxR+kvqdgU770cM1GNhpa2WuxUmFd+ywrXEVWRBE8CkgZ16vLMe29aHzG17Bf4Zjo8ylsR
 4peaHxP/pizA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="201400265"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="201400265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:22:24 -0800
IronPort-SDR: 5OxVEzNXUNBYV7Lt3nf9XNlEIDvN8hUR3k7WIZS9g/8gM/5y/gMnnul52xf6LeA6rv9b1fg4Gg
 BFtlYtn+GFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="437175826"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2021 08:22:24 -0800
Received: from [10.254.79.250] (kliang2-MOBL.ccr.corp.intel.com [10.254.79.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2F0E0580266;
        Thu, 11 Feb 2021 08:22:23 -0800 (PST)
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <YCUXte/CMEQlCq4f@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <38f93d32-d133-8170-3c3a-0fdfa04a9058@linux.intel.com>
Date:   Thu, 11 Feb 2021 11:22:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCUXte/CMEQlCq4f@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2021 6:40 AM, Jiri Olsa wrote:
> On Mon, Feb 08, 2021 at 07:24:57AM -0800, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> Jin Yao (24):
>>    perf jevents: Support unit value "cpu_core" and "cpu_atom"
>>    perf util: Save pmu name to struct perf_pmu_alias
>>    perf pmu: Save detected hybrid pmus to a global pmu list
>>    perf pmu: Add hybrid helper functions
>>    perf list: Support --cputype option to list hybrid pmu events
>>    perf stat: Hybrid evsel uses its own cpus
>>    perf header: Support HYBRID_TOPOLOGY feature
>>    perf header: Support hybrid CPU_PMU_CAPS
>>    tools headers uapi: Update tools's copy of linux/perf_event.h
>>    perf parse-events: Create two hybrid hardware events
>>    perf parse-events: Create two hybrid cache events
>>    perf parse-events: Support hardware events inside PMU
>>    perf list: Display pmu prefix for partially supported hybrid cache
>>      events
>>    perf parse-events: Support hybrid raw events
>>    perf stat: Support --cputype option for hybrid events
>>    perf stat: Support metrics with hybrid events
>>    perf evlist: Create two hybrid 'cycles' events by default
>>    perf stat: Add default hybrid events
>>    perf stat: Uniquify hybrid event name
>>    perf stat: Merge event counts from all hybrid PMUs
>>    perf stat: Filter out unmatched aggregation for hybrid event
>>    perf evlist: Warn as events from different hybrid PMUs in a group
>>    perf Documentation: Document intel-hybrid support
>>    perf evsel: Adjust hybrid event and global event mixed group
>>
>> Kan Liang (22):
>>    perf/x86/intel: Hybrid PMU support for perf capabilities
>>    perf/x86: Hybrid PMU support for intel_ctrl
>>    perf/x86: Hybrid PMU support for counters
>>    perf/x86: Hybrid PMU support for unconstrained
>>    perf/x86: Hybrid PMU support for hardware cache event
>>    perf/x86: Hybrid PMU support for event constraints
>>    perf/x86: Hybrid PMU support for extra_regs
>>    perf/x86/intel: Factor out intel_pmu_check_num_counters
>>    perf/x86/intel: Factor out intel_pmu_check_event_constraints
>>    perf/x86/intel: Factor out intel_pmu_check_extra_regs
>>    perf/x86: Expose check_hw_exists
>>    perf/x86: Remove temporary pmu assignment in event_init
>>    perf/x86: Factor out x86_pmu_show_pmu_cap
>>    perf/x86: Register hybrid PMUs
>>    perf/x86: Add structures for the attributes of Hybrid PMUs
>>    perf/x86/intel: Add attr_update for Hybrid PMUs
>>    perf/x86: Support filter_match callback
>>    perf/x86/intel: Add Alder Lake Hybrid support
>>    perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
>>    perf/x86/intel/uncore: Add Alder Lake support
>>    perf/x86/msr: Add Alder Lake CPU support
>>    perf/x86/cstate: Add Alder Lake CPU support
>>
>> Ricardo Neri (2):
>>    x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
>>    x86/cpu: Describe hybrid CPUs in cpuinfo_x86
>>
>> Zhang Rui (1):
>>    perf/x86/rapl: Add support for Intel Alder Lake
> 
> hi,
> would you have git branch with all this somewhere?
> 

Here is the git branch

https://github.com/kliang2/perf.git adl_enabling

Please note that the branch is on top of Peter's perf/core branch, which 
doesn't include the latest perf tool changes. The perf tool patches in 
the branch only includes the critical changes. There will be more tool 
patches later, e.g., patches for perf mem, perf test etc.

Thanks,
Kan
