Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1E34AEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCZTJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:27803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZTIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:08:48 -0400
IronPort-SDR: xlm48iA2PWTUYEkPwBlgYMFKkSgoSZgbvsVxbYkaxafpyPfmLDu7Pf3axqZY+XpNMPs5mfQ9bv
 kyZPEBBGfpOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234753"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234753"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:08:47 -0700
IronPort-SDR: 4KEF8KWHoGuk4Kbotd8/rRnBRvKtUvVdVDBxH7n381/oM9DSUP8Yf5l5upWZjgv4kHhEUAmW+U
 RnCA/ZOvpBjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392320961"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:08:47 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 00/25] Add Alder Lake support for perf (kernel)
Date:   Fri, 26 Mar 2021 12:01:47 -0700
Message-Id: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Don't show "hybrid_cpu" in /proc/cpuinfo (Boris) (Patch 1)
- Use get_this_hybrid_cpu_type() to replace get_hybrid_cpu_type() to
  avoid the trouble of IPIs. The new function retrieves the type of the
  current hybrid CPU. It's good enough for perf. (Dave) (Patch 2)
- Remove definitions for Atom and Core CPU types. Perf will define a
  enum for the hybrid CPU type in the perf_event.h (Peter) (Patch 2 & 16)
- Remove X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK. Not used in the patch set
  (Kan)(Patch 2)
- Update the description of the patch 2 accordingly. (Boris) (Patch 2)
- All the hybrid PMUs are registered at boot time. (Peter) (Patch 16)
- Align all ATTR things. (Peter) (Patch 20)
- The patchset doesn't change the caps/pmu_name. The perf tool doesn't
  rely on it to distinguish the event list. The caps/pmu_name is only to
  indicate the microarchitecture, which is the hybrid Alder Lake for
  both PMUs.

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
a helper function to get the CPU type of hybrid CPUs. (The initial idea
[1] was to save the CPU type in a new field x86_cpu_type in struct
cpuinfo_x86. Since the only user of the new field is perf, querying the
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

The kernel codes can also be found at
https://github.com/kliang2/perf.git adl_enabling

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
  x86/cpu: Add helper function to get the type of the current hybrid CPU

Zhang Rui (1):
  perf/x86/rapl: Add support for Intel Alder Lake

 arch/x86/events/core.c             | 337 ++++++++++++++----
 arch/x86/events/intel/core.c       | 691 ++++++++++++++++++++++++++++++++-----
 arch/x86/events/intel/cstate.c     |  39 ++-
 arch/x86/events/intel/ds.c         |  32 +-
 arch/x86/events/intel/lbr.c        |   9 +-
 arch/x86/events/intel/uncore.c     |   7 +
 arch/x86/events/intel/uncore.h     |   1 +
 arch/x86/events/intel/uncore_snb.c | 131 +++++++
 arch/x86/events/msr.c              |   2 +
 arch/x86/events/perf_event.h       | 109 +++++-
 arch/x86/events/rapl.c             |   2 +
 arch/x86/include/asm/cpu.h         |   6 +
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   3 +
 arch/x86/include/asm/processor.h   |   2 +
 arch/x86/kernel/cpu/intel.c        |  14 +
 include/linux/perf_event.h         |  12 +
 include/uapi/linux/perf_event.h    |  26 ++
 kernel/events/core.c               |  14 +-
 19 files changed, 1243 insertions(+), 195 deletions(-)

-- 
2.7.4

