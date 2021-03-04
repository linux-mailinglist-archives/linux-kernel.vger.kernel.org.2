Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C2C32D725
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhCDPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:52:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:61417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235795AbhCDPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:52:34 -0500
IronPort-SDR: y6kodplWCRnHp4Yb/w5qYk+VhSe4za3L7zcFDsk2IaxHHL2O+XWdWYQU0X+UirSTN1Xd0DFaHq
 1V7Rr0LHc+Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="184067068"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="184067068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:50:48 -0800
IronPort-SDR: 5YVL7sByqt5nAc7R74I7HimsUvaK5yBtwzc3ZB/yIBAhiV99HY9PJhvxuPfghYJJiOn6Xvk7pf
 zoHd/k4KfLnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="435838307"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Mar 2021 07:50:48 -0800
Received: from [10.252.141.30] (kliang2-MOBL.ccr.corp.intel.com [10.252.141.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D8FA35808B1;
        Thu,  4 Mar 2021 07:50:46 -0800 (PST)
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0b447023-7c74-bc4f-5485-e03897d213da@linux.intel.com>
Date:   Thu, 4 Mar 2021 10:50:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you please take a look at the perf kernel patches (3-25)?

By now, we have got some comments regarding the generic hybrid feature 
enumeration code and perf tool patches. I would appreciate it very much 
if you could comment on the perf kernel patches.

Thanks,
Kan

On 2/8/2021 10:24 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> (The V1 patchset is a complete patchset for the Alder Lake support on
> the Linux perf. It includes both kernel patches (1-25) and the user
> space patches (26-49). It tries to give the maintainers/reviewers an
> overall picture of the ADL enabling patches. The number of the patches
> are huge. Sorry for it. For future versions, the patchset will be
> divided into the kernel patch series and the userspace patch series.
> They can be reviewed separately.)
> 
> Alder Lake uses a hybrid architecture utilizing Golden Cove cores
> and Gracemont cores. On such architectures, all CPUs support the same,
> homogeneous and symmetric, instruction set. Also, CPUID enumerate
> the same features for all CPUs. There may be model-specific differences,
> such as those addressed in this patchset.
> 
> The first two patches enumerate the hybrid CPU feature bit and save the
> CPU type in a new field x86_cpu_type in struct cpuinfo_x86 for the
> following patches. They were posted previously[1] but not merged.
> Compared with the initial submission, they address the below two
> concerns[2][3],
> - Provide a good use case, PMU.
> - Clarify what Intel Hybrid Technology is and is not.
> 
> The PMU capabilities for Golden Cove core and Gracemont core are not the
> same. The key differences include the number of counters, events, perf
> metrics feature, and PEBS-via-PT feature. A dedicated hybrid PMU has to
> be registered for each of them. However, the current perf X86 assumes
> that there is only one CPU PMU. To handle the hybrid PMUs, the patchset
> - Introduce a new struct x86_hybrid_pmu to save the unique capabilities
>    from different PMUs. It's part of the global x86_pmu. The architecture
>    capabilities, which are available for all PMUs, are still saved in
>    the global x86_pmu. I once considered dynamically create dedicated
>    x86_pmu and pmu for each hybrid PMU. If so, they have to be changed to
>    pointers. Since they are used everywhere, the changes could be huge
>    and complex. Also, most of the PMU capabilities are the same between
>    hybrid PMUs. Duplicated data in the big x86_pmu structure will be
>    saved many times. So the dynamic way was dropped.
> - The hybrid PMU registration has been moved to the cpu_starting(),
>    because only boot CPU is available when invoking the
>    init_hw_perf_events().
> - Hybrid PMUs have different events and formats. Add new structures and
>    helpers for events attribute and format attribute which take the PMU
>    type into account.
> - Add a PMU aware version PERF_TYPE_HARDWARE_PMU and
>    PERF_TYPE_HW_CACHE_PMU to facilitate user space tools
> 
> The uncore, MSR and cstate are the same between hybrid CPUs.
> Don't need to register hybrid PMUs for them.
> 
> The generic code kernel/events/core.c is not hybrid friendly either,
> especially for the per-task monitoring. Peter once proposed a
> patchset[4], but it hasn't been merged. This patchset doesn't intend to
> improve the generic code (which can be improved later separately). It
> still uses the capability PERF_PMU_CAP_HETEROGENEOUS_CPUS for each
> hybrid PMUs. For per-task and system-wide monitoring, user space tools
> have to create events on all available hybrid PMUs. The events which are
> from different hybrid PMUs cannot be included in the same group.
> 
> [1]. https://lore.kernel.org/lkml/20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com/
> [2]. https://lore.kernel.org/lkml/20201002203452.GE17436@zn.tnic/
> [3]. https://lore.kernel.org/lkml/87r1qgccku.fsf@nanos.tec.linutronix.de/
> [4]. https://lkml.kernel.org/r/20181010104559.GO5728@hirez.programming.kicks-ass.net/
> 
> Jin Yao (24):
>    perf jevents: Support unit value "cpu_core" and "cpu_atom"
>    perf util: Save pmu name to struct perf_pmu_alias
>    perf pmu: Save detected hybrid pmus to a global pmu list
>    perf pmu: Add hybrid helper functions
>    perf list: Support --cputype option to list hybrid pmu events
>    perf stat: Hybrid evsel uses its own cpus
>    perf header: Support HYBRID_TOPOLOGY feature
>    perf header: Support hybrid CPU_PMU_CAPS
>    tools headers uapi: Update tools's copy of linux/perf_event.h
>    perf parse-events: Create two hybrid hardware events
>    perf parse-events: Create two hybrid cache events
>    perf parse-events: Support hardware events inside PMU
>    perf list: Display pmu prefix for partially supported hybrid cache
>      events
>    perf parse-events: Support hybrid raw events
>    perf stat: Support --cputype option for hybrid events
>    perf stat: Support metrics with hybrid events
>    perf evlist: Create two hybrid 'cycles' events by default
>    perf stat: Add default hybrid events
>    perf stat: Uniquify hybrid event name
>    perf stat: Merge event counts from all hybrid PMUs
>    perf stat: Filter out unmatched aggregation for hybrid event
>    perf evlist: Warn as events from different hybrid PMUs in a group
>    perf Documentation: Document intel-hybrid support
>    perf evsel: Adjust hybrid event and global event mixed group
> 
> Kan Liang (22):
>    perf/x86/intel: Hybrid PMU support for perf capabilities
>    perf/x86: Hybrid PMU support for intel_ctrl
>    perf/x86: Hybrid PMU support for counters
>    perf/x86: Hybrid PMU support for unconstrained
>    perf/x86: Hybrid PMU support for hardware cache event
>    perf/x86: Hybrid PMU support for event constraints
>    perf/x86: Hybrid PMU support for extra_regs
>    perf/x86/intel: Factor out intel_pmu_check_num_counters
>    perf/x86/intel: Factor out intel_pmu_check_event_constraints
>    perf/x86/intel: Factor out intel_pmu_check_extra_regs
>    perf/x86: Expose check_hw_exists
>    perf/x86: Remove temporary pmu assignment in event_init
>    perf/x86: Factor out x86_pmu_show_pmu_cap
>    perf/x86: Register hybrid PMUs
>    perf/x86: Add structures for the attributes of Hybrid PMUs
>    perf/x86/intel: Add attr_update for Hybrid PMUs
>    perf/x86: Support filter_match callback
>    perf/x86/intel: Add Alder Lake Hybrid support
>    perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
>    perf/x86/intel/uncore: Add Alder Lake support
>    perf/x86/msr: Add Alder Lake CPU support
>    perf/x86/cstate: Add Alder Lake CPU support
> 
> Ricardo Neri (2):
>    x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
>    x86/cpu: Describe hybrid CPUs in cpuinfo_x86
> 
> Zhang Rui (1):
>    perf/x86/rapl: Add support for Intel Alder Lake
> 
>   arch/x86/events/core.c                    | 286 ++++++++++---
>   arch/x86/events/intel/core.c              | 685 ++++++++++++++++++++++++++----
>   arch/x86/events/intel/cstate.c            |  39 +-
>   arch/x86/events/intel/ds.c                |  28 +-
>   arch/x86/events/intel/uncore.c            |   7 +
>   arch/x86/events/intel/uncore.h            |   1 +
>   arch/x86/events/intel/uncore_snb.c        | 131 ++++++
>   arch/x86/events/msr.c                     |   2 +
>   arch/x86/events/perf_event.h              | 117 ++++-
>   arch/x86/events/rapl.c                    |   2 +
>   arch/x86/include/asm/cpufeatures.h        |   1 +
>   arch/x86/include/asm/msr-index.h          |   2 +
>   arch/x86/include/asm/processor.h          |  13 +
>   arch/x86/kernel/cpu/common.c              |   3 +
>   include/linux/perf_event.h                |  12 +
>   include/uapi/linux/perf_event.h           |  26 ++
>   kernel/events/core.c                      |  14 +-
>   tools/include/uapi/linux/perf_event.h     |  26 ++
>   tools/perf/Documentation/intel-hybrid.txt | 335 +++++++++++++++
>   tools/perf/Documentation/perf-list.txt    |   4 +
>   tools/perf/Documentation/perf-record.txt  |   1 +
>   tools/perf/Documentation/perf-stat.txt    |  13 +
>   tools/perf/builtin-list.c                 |  42 +-
>   tools/perf/builtin-record.c               |   3 +
>   tools/perf/builtin-stat.c                 |  94 +++-
>   tools/perf/pmu-events/jevents.c           |   2 +
>   tools/perf/util/cputopo.c                 |  80 ++++
>   tools/perf/util/cputopo.h                 |  13 +
>   tools/perf/util/env.c                     |  12 +
>   tools/perf/util/env.h                     |  18 +-
>   tools/perf/util/evlist.c                  | 148 ++++++-
>   tools/perf/util/evlist.h                  |   7 +
>   tools/perf/util/evsel.c                   | 111 ++++-
>   tools/perf/util/evsel.h                   |  10 +-
>   tools/perf/util/header.c                  | 267 +++++++++++-
>   tools/perf/util/header.h                  |   1 +
>   tools/perf/util/metricgroup.c             | 226 +++++++++-
>   tools/perf/util/metricgroup.h             |   2 +-
>   tools/perf/util/parse-events.c            | 405 +++++++++++++++++-
>   tools/perf/util/parse-events.h            |  10 +-
>   tools/perf/util/parse-events.y            |  21 +-
>   tools/perf/util/pmu.c                     | 120 +++++-
>   tools/perf/util/pmu.h                     |  24 +-
>   tools/perf/util/stat-display.c            |  28 +-
>   tools/perf/util/stat.h                    |   2 +
>   45 files changed, 3106 insertions(+), 288 deletions(-)
>   create mode 100644 tools/perf/Documentation/intel-hybrid.txt
> 
