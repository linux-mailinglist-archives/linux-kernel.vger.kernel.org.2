Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D0336CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCKHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:08:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhCKHIU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:20 -0500
IronPort-SDR: 65zQDSJcu2PL1dtzacUc0FvxnuJx17XdzuEhuprxvNveFbOnkXCcUiTQosClgGIP8jjY8+RAX4
 2jfRTsmCZyTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246008"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246008"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:20 -0800
IronPort-SDR: E2RMeJUkl28SDXpzwlCCRWHRthWE3GoM7U/PHRLxiCuNEzho7pRjv1ZRK068LtS7Cte13Eq+2i
 TR9NrRoN6G/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937795"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:17 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 00/27] perf tool: AlderLake hybrid support series 1
Date:   Thu, 11 Mar 2021 15:07:15 +0800
Message-Id: <20210311070742.9318-1-yao.jin@linux.intel.com>
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
is displayed.   

  # perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -a -- sleep 1

   Performance counter stats for 'system wide':

      12,863,866,968      cpu_core/cycles/
         554,795,017      cpu_core/instructions/

         1.002616117 seconds time elapsed

  # perf stat -e '{cpu_core/cycles/,cpu_atom/instructions/}' -a -- sleep 1
  WARNING: Group has events from different hybrid PMUs

   Performance counter stats for 'system wide':

      12,863,344,830      cpu_core/cycles/
     <not supported>      cpu_atom/instructions/

       1.002568830 seconds time elapsed

Note that, since the whole patchset for AlderLake hybrid support is very
large (40+ patches), for simplicity, it's splitted into several patch
series.

The patch series 1 only supports the basic functionality. The other
supports for perf-c2c/perf-mem/topdown/metrics/topology header and etc
will be added in follow-up series.

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

Jin Yao (27):
  tools headers uapi: Update tools's copy of linux/perf_event.h
  perf jevents: Support unit value "cpu_core" and "cpu_atom"
  perf pmu: Simplify arguments of __perf_pmu__new_alias
  perf pmu: Save pmu name
  perf pmu: Save detected hybrid pmus to a global pmu list
  perf pmu: Add hybrid helper functions
  perf evlist: Hybrid event uses its own cpus
  perf stat: Uniquify hybrid event name
  perf parse-events: Create two hybrid hardware events
  perf parse-events: Create two hybrid cache events
  perf parse-events: Support hardware events inside PMU
  perf parse-events: Support hybrid raw events
  perf evlist: Create two hybrid 'cycles' events by default
  perf stat: Add default hybrid events
  perf stat: Filter out unmatched aggregation for hybrid event
  perf evlist: Warn as events from different hybrid PMUs in a group
  perf evsel: Adjust hybrid event and global event mixed group
  perf script: Support PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
  perf tests: Add hybrid cases for 'Parse event definition strings' test
  perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
  perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
  perf tests: Support 'Track with sched_switch' test for hybrid
  perf tests: Support 'Parse and process metrics' test for hybrid
  perf tests: Support 'Session topology' test for hybrid
  perf tests: Support 'Convert perf time to TSC' test for hybrid
  perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
  perf Documentation: Document intel-hybrid support

 tools/include/uapi/linux/perf_event.h      |  26 ++
 tools/perf/Documentation/intel-hybrid.txt  | 228 +++++++++++++++++
 tools/perf/Documentation/perf-record.txt   |   1 +
 tools/perf/Documentation/perf-stat.txt     |   2 +
 tools/perf/builtin-record.c                |  13 +-
 tools/perf/builtin-script.c                |  24 ++
 tools/perf/builtin-stat.c                  |  69 ++++-
 tools/perf/pmu-events/jevents.c            |   2 +
 tools/perf/tests/attr.c                    |   5 +
 tools/perf/tests/evsel-roundtrip-name.c    |  19 +-
 tools/perf/tests/parse-events.c            | 171 +++++++++++++
 tools/perf/tests/parse-metric.c            |  11 +-
 tools/perf/tests/perf-time-to-tsc.c        |  16 ++
 tools/perf/tests/shell/stat+shadow_stat.sh |   3 +
 tools/perf/tests/switch-tracking.c         |  10 +-
 tools/perf/tests/topology.c                |  10 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/evlist.c                   | 148 ++++++++++-
 tools/perf/util/evlist.h                   |   6 +
 tools/perf/util/evsel.c                    | 111 ++++++++-
 tools/perf/util/evsel.h                    |  10 +-
 tools/perf/util/parse-events.c             | 277 ++++++++++++++++++++-
 tools/perf/util/parse-events.h             |   6 +-
 tools/perf/util/parse-events.y             |  21 +-
 tools/perf/util/pmu-hybrid.c               |  75 ++++++
 tools/perf/util/pmu-hybrid.h               |  29 +++
 tools/perf/util/pmu.c                      |  53 ++--
 tools/perf/util/pmu.h                      |   5 +
 tools/perf/util/python-ext-sources         |   2 +
 tools/perf/util/stat-display.c             |  32 ++-
 tools/perf/util/stat.h                     |   1 +
 31 files changed, 1311 insertions(+), 76 deletions(-)
 create mode 100644 tools/perf/Documentation/intel-hybrid.txt
 create mode 100644 tools/perf/util/pmu-hybrid.c
 create mode 100644 tools/perf/util/pmu-hybrid.h

-- 
2.17.1

