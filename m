Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557C36D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhD1I0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhD1IZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:25:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:25:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so49315225wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AkiEavMnHGUzFKdcw1TOM2YejpLtcBy2KaUdttiPhpc=;
        b=A9nxjTw3/ZiKWub+t7eh+4GWKu0yPV6LQ2jJ+2VXWLn7R/jmUpBd88q0dJuhtwemCH
         xAlvZ+o5drJ4EClglTAtz4MYC1RUWZHzB4S4dNYdZq6WA1Ee/xCSF6WKaZnThN/4jvyV
         t2vSoqEOa4vgRAX9jrxA6ZMzBrlob0d1LCtx/eqCExPGegIAdzlkgMFGVLScpujWWNiW
         WxQg8vCzhqeKeWcypuB/B/xoo0VSqepViohh1VRT4PyJhRgjEGM0tpvx2XG6xj/rvcla
         GjXPQMHl12nDg0WwcEsPDwfWTjc4z6wkSbmIzpOp4kRjELwvKruPyfdl12hnbVaZsRju
         criQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=AkiEavMnHGUzFKdcw1TOM2YejpLtcBy2KaUdttiPhpc=;
        b=aErvY5K+oQmx9MVwTarKPhsi+/lyIJDMas9kaJZIfg+pc4bjTVqFxu9qH8jWs43NFw
         A/vqaRgdumqf1eCj7D6etgFAW+lGJubhQRkYcpeQsLtYLA13+AZJaDs8QxbegMGWP/2t
         fiNrACZUPjnGX9dw95KIhE2iecH5aoI090wcg2MYliSdbDJInruohgi9jZElHQruVM+5
         AWQ4/bNYrPGsZ07M3h+hiQU4PsHgr2tD+oTBVL5l2BIBIFTTi1NSSeoC+zzVo1982htI
         CXJg0FEyCGGcjnVHR8fDcaK3tIOzGOzan05uMOmfVAMWXDeOXEdEIpwtB4bLrlp6620u
         lqOg==
X-Gm-Message-State: AOAM531rCld9dUrqlaMkoRtUc5PSXn3XfPSEuElm9BFnP2D387DAkjwM
        OVp8s6+12A8Ea7sXHPe6KPE=
X-Google-Smtp-Source: ABdhPJxNS4skUW9iefu/IVCrrZYbXRYJZyKecSfqw4cNwSAicZUwH+NZivAXY5CtSjRXlqWtXVvsHg==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr34485071wrx.73.1619598311153;
        Wed, 28 Apr 2021 01:25:11 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id u2sm3395989wmm.5.2021.04.28.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:25:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Apr 2021 10:25:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [GIT PULL] perf events updates for v5.13
Message-ID: <20210428082508.GA272557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-04-28

   # HEAD: ed8e50800bf4c2d904db9c75408a67085e6cca3d signal, perf: Add missing TRAP_PERF case in siginfo_layout()

Perf events changes in this cycle were:

 - Improve Intel uncore PMU support:

     - Parse uncore 'discovery tables' - a new hardware capability enumeration method
       introduced on the latest Intel platforms. This table is in a well-defined PCI
       namespace location and is read via MMIO. It is organized in an rbtree.

       These uncore tables will allow the discovery of standard counter blocks, but
       fancier counters still need to be enumerated explicitly.

     - Add Alder Lake support

     - Improve IIO stacks to PMON mapping support on Skylake servers

 - Add Intel Alder Lake PMU support - which requires the introduction of 'hybrid' CPUs
   and PMUs. Alder Lake is a mix of Golden Cove ('big') and Gracemont ('small' - Atom derived)
   cores.

   The CPU-side feature set is entirely symmetrical - but on the PMU side there's
   core type dependent PMU functionality.

 - Reduce data loss with CPU level hardware tracing on Intel PT / AUX profiling, by
   fixing the AUX allocation watermark logic.

 - Improve NUMA system memory allocations:

    - Put 'struct perf_event' into their separate kmem_cache pool

    - Per node perf_event and ring buffer allocations

 - Add support for synchronous signals for select perf events. The immediate motivation
   is to support low-overhead sampling-based race detection for user-space code. The
   feature consists of the following main changes:

    - Add thread-only event inheritance via perf_event_attr::inherit_thread, which limits
      inheritance of events to CLONE_THREAD.

    - Add the ability for events to not leak through exec(), via perf_event_attr::remove_on_exec.

    - Allow the generation of SIGTRAP via perf_event_attr::sigtrap, extend siginfo with an u64
      ::si_perf, and add the breakpoint information to ::si_addr and ::si_perf if the event is
      PERF_TYPE_BREAKPOINT.

   The siginfo support is adequate for breakpoints right now - but the new field can be used
   to introduce support for other types of metadata passed over siginfo as well.

 - Misc fixes, cleanups and smaller updates.

 Thanks,

	Ingo

------------------>
Alexander Antonov (1):
      perf/x86/intel/uncore: Enable IIO stacks to PMON mapping for multi-segment SKX

Alexander Shishkin (2):
      perf: Cap allocation order at aux_watermark
      perf intel-pt: Use aux_watermark

Colin Ian King (1):
      perf/x86: Allow for 8<num_fixed_counters<16

Kan Liang (28):
      perf/x86/intel/uncore: Parse uncore discovery tables
      perf/x86/intel/uncore: Generic support for the MSR type of uncore blocks
      perf/x86/intel/uncore: Rename uncore_notifier to uncore_pci_sub_notifier
      perf/x86/intel/uncore: Generic support for the PCI type of uncore blocks
      perf/x86/intel/uncore: Generic support for the MMIO type of uncore blocks
      perf/x86: Move cpuc->running into P4 specific code
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
      perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
      perf/x86/intel/uncore: Add Alder Lake support
      perf/x86/msr: Add Alder Lake CPU support
      perf/x86/cstate: Add Alder Lake CPU support

Marco Elver (9):
      perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
      perf: Support only inheriting events if cloned with CLONE_THREAD
      perf: Add support for event removal on exec
      signal: Introduce TRAP_PERF si_code and si_perf to siginfo
      perf: Add support for SIGTRAP on perf events
      selftests/perf_events: Add kselftest for process-wide sigtrap handling
      selftests/perf_events: Add kselftest for remove_on_exec
      signal, perf: Fix siginfo_t by avoiding u64 on 32-bit architectures
      signal, perf: Add missing TRAP_PERF case in siginfo_layout()

Namhyung Kim (5):
      perf core: Allocate perf_buffer in the target node memory
      perf core: Add a kmem_cache for struct perf_event
      perf core: Allocate perf_event in the target node memory
      perf core: Factor out __perf_sw_event_sched
      perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event

Nathan Chancellor (2):
      x86/events/amd/iommu: Fix sysfs type mismatch
      perf/amd/uncore: Fix sysfs type mismatch

Ondrej Mosnacek (1):
      perf/core: Fix unconditional security_locked_down() call

Peter Zijlstra (1):
      perf: Rework perf_event_exit_event()

Ricardo Neri (2):
      x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
      x86/cpu: Add helper function to get the type of the current hybrid CPU

Zhang Rui (1):
      perf/x86/rapl: Add support for Intel Alder Lake


 arch/m68k/kernel/signal.c                          |   3 +
 arch/x86/events/amd/iommu.c                        |   6 +-
 arch/x86/events/amd/uncore.c                       |   6 +-
 arch/x86/events/core.c                             | 332 +++++++---
 arch/x86/events/intel/Makefile                     |   2 +-
 arch/x86/events/intel/core.c                       | 689 ++++++++++++++++++---
 arch/x86/events/intel/cstate.c                     |  39 +-
 arch/x86/events/intel/ds.c                         |  32 +-
 arch/x86/events/intel/lbr.c                        |   9 +-
 arch/x86/events/intel/p4.c                         |  16 +-
 arch/x86/events/intel/uncore.c                     | 207 ++++++-
 arch/x86/events/intel/uncore.h                     |  20 +-
 arch/x86/events/intel/uncore_discovery.c           | 622 +++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h           | 131 ++++
 arch/x86/events/intel/uncore_snb.c                 | 131 ++++
 arch/x86/events/intel/uncore_snbep.c               |  60 +-
 arch/x86/events/msr.c                              |   2 +
 arch/x86/events/perf_event.h                       | 119 +++-
 arch/x86/events/rapl.c                             |   2 +
 arch/x86/include/asm/cpu.h                         |   6 +
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   3 +
 arch/x86/kernel/cpu/intel.c                        |  16 +
 arch/x86/kernel/signal_compat.c                    |   5 +-
 fs/signalfd.c                                      |   4 +
 include/linux/compat.h                             |   2 +
 include/linux/perf_event.h                         |  78 ++-
 include/linux/signal.h                             |   1 +
 include/uapi/asm-generic/siginfo.h                 |   6 +-
 include/uapi/linux/perf_event.h                    |  28 +-
 include/uapi/linux/signalfd.h                      |   4 +-
 kernel/events/core.c                               | 345 ++++++++---
 kernel/events/ring_buffer.c                        |  43 +-
 kernel/fork.c                                      |   2 +-
 kernel/signal.c                                    |  13 +
 tools/perf/arch/x86/util/intel-pt.c                |   6 +
 tools/testing/selftests/perf_events/.gitignore     |   3 +
 tools/testing/selftests/perf_events/Makefile       |   6 +
 tools/testing/selftests/perf_events/config         |   1 +
 .../testing/selftests/perf_events/remove_on_exec.c | 260 ++++++++
 tools/testing/selftests/perf_events/settings       |   1 +
 .../selftests/perf_events/sigtrap_threads.c        | 210 +++++++
 42 files changed, 3055 insertions(+), 417 deletions(-)
 create mode 100644 arch/x86/events/intel/uncore_discovery.c
 create mode 100644 arch/x86/events/intel/uncore_discovery.h
 create mode 100644 tools/testing/selftests/perf_events/.gitignore
 create mode 100644 tools/testing/selftests/perf_events/Makefile
 create mode 100644 tools/testing/selftests/perf_events/config
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c
 create mode 100644 tools/testing/selftests/perf_events/settings
 create mode 100644 tools/testing/selftests/perf_events/sigtrap_threads.c
