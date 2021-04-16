Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8C3621AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhDPOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:06:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:61022 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhDPOGe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:06:34 -0400
IronPort-SDR: 7tec4m37zhR0TNaZQB3P/ipOkesbNzCip9Bj+x9XQDgAWmzl5HGc/T3PWtXGhgWWPad+LdJHVb
 mFhAa9LQvsNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195156020"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="195156020"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:09 -0700
IronPort-SDR: zMBDr2Cjqm6WLAKpdBh3psOUfsRNhOT1PR2rK1rbiqnBqo5qdmpBNG9HB/sJiYXYXkyuLZ7scR
 Nux1F/qef1IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766586"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:07 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 00/25] perf tool: AlderLake hybrid support series 1
Date:   Fri, 16 Apr 2021 22:04:52 +0800
Message-Id: <20210416140517.18206-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake uses a hybrid architecture utilizing Golden Cove cores
(core cpu) and Gracemont cores (atom cpu). Each cpu has dedicated
event list. Some events are available on core cpu, some events
are available on atom cpu and some events can be available on both.

Kernel exports new pmus "cpu_core" and "cpu_atom" through sysfs:
/sys/devices/cpu_core
/sys/devices/cpu_atom

cat /sys/devices/cpu_core/cpus
0-15

cat /sys/devices/cpu_atom/cpus
16-23

In this example, core cpus are 0-15 and atom cpus are 16-23.

To enable a core only event or atom only event:

        cpu_core/<event name>/
or
        cpu_atom/<event name>/

Count the 'cycles' event on core cpus.

  # perf stat -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

      12,853,951,349      cpu_core/cycles/

         1.002581249 seconds time elapsed

If one event is available on both atom cpu and core cpu, two events
are created automatically.

  # perf stat -e cycles -a -- sleep 1

   Performance counter stats for 'system wide':

      12,856,467,438      cpu_core/cycles/
       6,404,634,785      cpu_atom/cycles/

         1.002453013 seconds time elapsed

Group is supported if the events are from same pmu, otherwise a warning
is displayed and disable grouping automatically.

  # perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -a -- sleep 1

   Performance counter stats for 'system wide':

      12,863,866,968      cpu_core/cycles/
         554,795,017      cpu_core/instructions/

         1.002616117 seconds time elapsed

  # perf stat -e '{cpu_core/cycles/,cpu_atom/instructions/}' -a -- sleep 1
  WARNING: events in group from different hybrid PMUs!
  WARNING: grouped events cpus do not match, disabling group:
    anon group { cpu_core/cycles/, cpu_atom/instructions/ }

   Performance counter stats for 'system wide':

           6,283,970      cpu_core/cycles/
             765,635      cpu_atom/instructions/

         1.003959036 seconds time elapsed

Note that, since the whole patchset for AlderLake hybrid support is very
large (40+ patches). For simplicity, it's splitted into several patch
series.

The patch series 1 only supports the basic functionality. The advanced
supports for perf-c2c/perf-mem/topdown/metrics/topology header and others
will be added in follow-up patch series.

The perf tool codes can also be found at:
https://github.com/yaoj/perf.git

v4:
---
- In Liang Kan's patch:
  '[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE',
  the user interface for hardware events and cache events are changed, so
  perf tool patches are changed as well.

- Fix an issue when atom CPUs are offlined. "/sys/bus/event_source/devices/cpu_atom/cpus"
  exists but the content is empty. For this case, we can't enable the cpu_atom
  PMU. '[PATCH v4 05/25] perf pmu: Save detected hybrid pmus to a global pmu list'

- Define 'ret' variable for return value in patch
  '[PATCH v4 09/25] perf parse-events: Create two hybrid cache events'

- Directly return add_raw_hybrid() in patch
  '[PATCH v4 10/25] perf parse-events: Create two hybrid raw events'
 
- Drop the patch 'perf pmu: Support 'cycles' and 'branches' inside
  hybrid PMU'.

- Separate '[PATCH v3 12/27] perf parse-events: Support no alias assigned event
  inside hybrid PMU' into two patches:
  '[PATCH v4 11/25] perf parse-events: Compare with hybrid pmu name'
  '[PATCH v4 12/25] perf parse-events: Support event inside hybrid pmu'.
  And these two patches are improved according to Jiri's comments.

v3:
---
- Drop 'perf evlist: Hybrid event uses its own cpus'. This patch is wide
  and actually it's not very necessary. The current perf framework has
  processed the cpus for evsel well even for hybrid evsel. So this patch can
  be dropped.

- Drop 'perf evsel: Adjust hybrid event and global event mixed group'.
  The patch is a bit tricky and hard to understand. In v3, we will disable
  grouping when the group members are from different PMUs. So this patch
  would be not necessary.

- Create parse-events-hybrid.c/parse-events-hybrid.h and evlist-hybrid.c/evlist-hybrid.h.
  Move hybrid related codes to these files.

- Create a new patch 'perf pmu: Support 'cycles' and 'branches' inside hybrid PMU' to
  support 'cycles' and 'branches' inside PMU.

- Create a new patch 'perf record: Uniquify hybrid event name' to tell user the
  pmu which the event belongs to for perf-record.

- If group members are from different hybrid PMUs, shows warning and disable
  grouping.

- Other refining and refactoring.

v2:
---
- Drop kernel patches (Kan posted the series "Add Alder Lake support for perf (kernel)" separately).
- Drop the patches for perf-c2c/perf-mem/topdown/metrics/topology header supports,
  which will be added in series 2 or series 3.
- Simplify the arguments of __perf_pmu__new_alias() by passing
  the 'struct pme_event' pointer.
- Check sysfs validity before access.
- Use pmu style event name, such as "cpu_core/cycles/".
- Move command output two chars to the right.
- Move pmu hybrid functions to new created pmu-hybrid.c/pmu-hybrid.h.
  This is to pass the perf test python case.

Jin Yao (25):
  tools headers uapi: Update tools's copy of linux/perf_event.h
  perf jevents: Support unit value "cpu_core" and "cpu_atom"
  perf pmu: Simplify arguments of __perf_pmu__new_alias
  perf pmu: Save pmu name
  perf pmu: Save detected hybrid pmus to a global pmu list
  perf pmu: Add hybrid helper functions
  perf stat: Uniquify hybrid event name
  perf parse-events: Create two hybrid hardware events
  perf parse-events: Create two hybrid cache events
  perf parse-events: Create two hybrid raw events
  perf parse-events: Compare with hybrid pmu name
  perf parse-events: Support event inside hybrid pmu
  perf record: Create two hybrid 'cycles' events by default
  perf stat: Add default hybrid events
  perf stat: Filter out unmatched aggregation for hybrid event
  perf stat: Warn group events from different hybrid PMU
  perf record: Uniquify hybrid event name
  perf tests: Add hybrid cases for 'Parse event definition strings' test
  perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
  perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
  perf tests: Support 'Track with sched_switch' test for hybrid
  perf tests: Support 'Parse and process metrics' test for hybrid
  perf tests: Support 'Session topology' test for hybrid
  perf tests: Support 'Convert perf time to TSC' test for hybrid
  perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid

 include/uapi/linux/perf_event.h            |  15 ++
 tools/include/uapi/linux/perf_event.h      |  15 ++
 tools/perf/builtin-record.c                |  47 +++++-
 tools/perf/builtin-stat.c                  |  29 ++++
 tools/perf/pmu-events/jevents.c            |   2 +
 tools/perf/tests/attr.c                    |   4 +
 tools/perf/tests/evsel-roundtrip-name.c    |  19 ++-
 tools/perf/tests/parse-events.c            | 152 ++++++++++++++++++
 tools/perf/tests/parse-metric.c            |  10 +-
 tools/perf/tests/perf-time-to-tsc.c        |  16 ++
 tools/perf/tests/shell/stat+shadow_stat.sh |   3 +
 tools/perf/tests/switch-tracking.c         |  10 +-
 tools/perf/tests/topology.c                |  10 +-
 tools/perf/util/Build                      |   3 +
 tools/perf/util/evlist-hybrid.c            |  88 ++++++++++
 tools/perf/util/evlist-hybrid.h            |  14 ++
 tools/perf/util/evlist.c                   |   5 +-
 tools/perf/util/evsel.c                    |  12 +-
 tools/perf/util/evsel.h                    |   4 +-
 tools/perf/util/parse-events-hybrid.c      | 178 +++++++++++++++++++++
 tools/perf/util/parse-events-hybrid.h      |  23 +++
 tools/perf/util/parse-events.c             |  86 +++++++++-
 tools/perf/util/parse-events.h             |   9 +-
 tools/perf/util/parse-events.y             |   9 +-
 tools/perf/util/pmu-hybrid.c               |  89 +++++++++++
 tools/perf/util/pmu-hybrid.h               |  22 +++
 tools/perf/util/pmu.c                      |  64 +++++---
 tools/perf/util/pmu.h                      |   7 +
 tools/perf/util/python-ext-sources         |   2 +
 tools/perf/util/stat-display.c             |  35 +++-
 30 files changed, 933 insertions(+), 49 deletions(-)
 create mode 100644 tools/perf/util/evlist-hybrid.c
 create mode 100644 tools/perf/util/evlist-hybrid.h
 create mode 100644 tools/perf/util/parse-events-hybrid.c
 create mode 100644 tools/perf/util/parse-events-hybrid.h
 create mode 100644 tools/perf/util/pmu-hybrid.c
 create mode 100644 tools/perf/util/pmu-hybrid.h

-- 
2.17.1

