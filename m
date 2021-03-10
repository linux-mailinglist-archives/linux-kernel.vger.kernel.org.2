Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0316334355
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCJQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCJQnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:43:41 -0500
IronPort-SDR: ABKeVSw7QwNabCvsS9GwaV4x65IjRwNRB6p2cgRiIMVVpwsYcE3+MkFjm1/XIUrrmcu5VakrB8
 v7NkvYh8BQ3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546392"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:43:40 -0800
IronPort-SDR: 4Rr5AtMk+pNWnbJ3FqqYr4lHfKMBRPIdESg9cp0fW6YMURgY2cRhxIH2uYtTX1v2SXhWyt8XKl
 Uo4RnS0DtrdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509728999"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:43:39 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 00/25] Add Alder Lake support for perf (kernel)
Date:   Wed, 10 Mar 2021 08:37:36 -0800
Message-Id: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Drop all user space patches, which will be reviewed later separately.
- Don't save the CPU type in struct cpuinfo_x86. Instead, provide helper
  functions to get parameters of hybrid CPUs. (Boris)
- Rework the perf kernel patches according to Peter's suggestion. The
  key changes include,
  - Code style changes. Drop all the macro which names in capital
    letters.
  - Drop the hybrid PMU index, track the pointer of the hybrid PMU in
    the per-CPU struct cpu_hw_events.
  - Fix the x86_get_pmu() support
  - Fix the allocate_fake_cpuc() support
  - Fix validate_group() support
  - Dynamically allocate the *hybrid_pmu for each hybrid PMU

Alder Lake uses a hybrid architecture utilizing Golden Cove cores
and Gracemont cores. On such architectures, all CPUs support the same,
homogeneous and symmetric, instruction set. Also, CPUID enumerate
the same features for all CPUs. There may be model-specific differences,
such as those addressed in this patchset.

The first two patches enumerate the hybrid CPU feature bit and provide
helper functions to get parameters of hybrid CPUs. (The initial idea [1]
was to save the CPU type in a new field x86_cpu_type in struct cpuinfo_x86.
Since the only user of the new field is perf, querying the
X86_FEATURE_HYBRID_CPU at the call site is a simpler alternative.[2])
Compared with the initial submission, the below two concerns[3][4] are
also addressed,
- Provide a good use case, PMU.
- Clarify what Intel Hybrid Technology is and is not.

The PMU capabilities for Golden Cove core and Gracemont core are not the
same. The key differences include the number of counters, events, perf
metrics feature, and PEBS-via-PT feature. A dedicated hybrid PMU has to
be registered for each of them. However, the current perf X86 assumes
that there is only one CPU PMU. To handle the hybrid PMUs, the patchset
- Introduce a new struct x86_hybrid_pmu to save the unique capabilities
  from different PMUs. It's part of the global x86_pmu. The architecture
  capabilities, which are available for all PMUs, are still saved in
  the global x86_pmu. To save the space, the x86_hybrid_pmu is
  dynamically allocated.
- The hybrid PMU registration has been moved to the cpu_starting(),
  because only boot CPU is available when invoking the
  init_hw_perf_events().
- Hybrid PMUs have different events and formats. Add new structures and
  helpers for events attribute and format attribute which take the PMU
  type into account.
- Add a PMU aware version PERF_TYPE_HARDWARE_PMU and
  PERF_TYPE_HW_CACHE_PMU to facilitate user space tools

The uncore, MSR and cstate are the same between hybrid CPUs.
Don't need to register hybrid PMUs for them.

The generic code kernel/events/core.c is not hybrid friendly either,
especially for the per-task monitoring. Peter once proposed a
patchset[5], but it hasn't been merged. This patchset doesn't intend to
improve the generic code (which can be improved later separately). It
still uses the capability PERF_PMU_CAP_HETEROGENEOUS_CPUS for each
hybrid PMUs. For per-task and system-wide monitoring, user space tools
have to create events on all available hybrid PMUs. The events which are
from different hybrid PMUs cannot be included in the same group.

[1]. https://lore.kernel.org/lkml/20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20210208175640.GD18227@zn.tnic/
[3]. https://lore.kernel.org/lkml/20201002203452.GE17436@zn.tnic/
[4]. https://lore.kernel.org/lkml/87r1qgccku.fsf@nanos.tec.linutronix.de/
[5]. https://lkml.kernel.org/r/20181010104559.GO5728@hirez.programming.kicks-ass.net/

Kan Liang (22):
  perf/x86: Track pmu in per-CPU cpu_hw_events
  perf/x86/intel: Hybrid PMU support for perf capabilities
  perf/x86: Hybrid PMU support for intel_ctrl
  perf/x86: Hybrid PMU support for counters
  perf/x86: Hybrid PMU support for unconstrained
  perf/x86: Hybrid PMU support for hardware cache event
  perf/x86: Hybrid PMU support for event constraints
  perf/x86: Hybrid PMU support for extra_regs
  perf/x86/intel: Factor out intel_pmu_check_num_counters
  perf/x86/intel: Factor out intel_pmu_check_event_constraints
  perf/x86/intel: Factor out intel_pmu_check_extra_regs
  perf/x86: Remove temporary pmu assignment in event_init
  perf/x86: Factor out x86_pmu_show_pmu_cap
  perf/x86: Register hybrid PMUs
  perf/x86: Add structures for the attributes of Hybrid PMUs
  perf/x86/intel: Add attr_update for Hybrid PMUs
  perf/x86: Support filter_match callback
  perf/x86/intel: Add Alder Lake Hybrid support
  perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
  perf/x86/intel/uncore: Add Alder Lake support
  perf/x86/msr: Add Alder Lake CPU support
  perf/x86/cstate: Add Alder Lake CPU support

Ricardo Neri (2):
  x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
  x86/cpu: Add helper functions to get parameters of hybrid CPUs

Zhang Rui (1):
  perf/x86/rapl: Add support for Intel Alder Lake

 arch/x86/events/core.c              | 314 ++++++++++++----
 arch/x86/events/intel/core.c        | 717 +++++++++++++++++++++++++++++++-----
 arch/x86/events/intel/cstate.c      |  39 +-
 arch/x86/events/intel/ds.c          |  32 +-
 arch/x86/events/intel/lbr.c         |   9 +-
 arch/x86/events/intel/uncore.c      |   7 +
 arch/x86/events/intel/uncore.h      |   1 +
 arch/x86/events/intel/uncore_snb.c  | 131 +++++++
 arch/x86/events/msr.c               |   2 +
 arch/x86/events/perf_event.h        | 108 +++++-
 arch/x86/events/rapl.c              |   2 +
 arch/x86/include/asm/cpu.h          |   6 +
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/intel-family.h |   4 +
 arch/x86/include/asm/msr-index.h    |   3 +
 arch/x86/include/asm/processor.h    |   3 +
 arch/x86/kernel/cpu/intel.c         |  44 +++
 include/linux/perf_event.h          |  12 +
 include/uapi/linux/perf_event.h     |  26 ++
 kernel/events/core.c                |  14 +-
 20 files changed, 1281 insertions(+), 194 deletions(-)

-- 
2.7.4

