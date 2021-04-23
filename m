Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E48368CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbhDWFip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:9376 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241013AbhDWFiZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:25 -0400
IronPort-SDR: uxfWvY9+dPiVPCJi66JecrXsm/Y5ANFX+e7A2XUWNiNk3dBY9IsLuJc1iNl9P4L86gQX+jYSVy
 hso66XDFT1tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501900"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501900"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:49 -0700
IronPort-SDR: YJunuRpY+QO3Qq12E3ZBTqRiM0pIxeoNx6KjQ622y4FnuNEWe+285KNbHcnZuNLlgjU18r2ESM
 YrWzfVCHyp1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293796"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:47 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 26/26] perf Documentation: Document intel-hybrid support
Date:   Fri, 23 Apr 2021 13:35:41 +0800
Message-Id: <20210423053541.12521-27-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some words and examples to help understanding of
Intel hybrid perf support.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - No change.

 tools/perf/Documentation/intel-hybrid.txt | 214 ++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt  |   1 +
 tools/perf/Documentation/perf-stat.txt    |   2 +
 3 files changed, 217 insertions(+)
 create mode 100644 tools/perf/Documentation/intel-hybrid.txt

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
new file mode 100644
index 000000000000..07f0aa3bf682
--- /dev/null
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -0,0 +1,214 @@
+Intel hybrid support
+--------------------
+Support for Intel hybrid events within perf tools.
+
+For some Intel platforms, such as AlderLake, which is hybrid platform and
+it consists of atom cpu and core cpu. Each cpu has dedicated event list.
+Part of events are available on core cpu, part of events are available
+on atom cpu and even part of events are available on both.
+
+Kernel exports two new cpu pmus via sysfs:
+/sys/devices/cpu_core
+/sys/devices/cpu_atom
+
+The 'cpus' files are created under the directories. For example,
+
+cat /sys/devices/cpu_core/cpus
+0-15
+
+cat /sys/devices/cpu_atom/cpus
+16-23
+
+It indicates cpu0-cpu15 are core cpus and cpu16-cpu23 are atom cpus.
+
+Quickstart
+
+List hybrid event
+-----------------
+
+As before, use perf-list to list the symbolic event.
+
+perf list
+
+inst_retired.any
+	[Fixed Counter: Counts the number of instructions retired. Unit: cpu_atom]
+inst_retired.any
+	[Number of instructions retired. Fixed Counter - architectural event. Unit: cpu_core]
+
+The 'Unit: xxx' is added to brief description to indicate which pmu
+the event is belong to. Same event name but with different pmu can
+be supported.
+
+Enable hybrid event with a specific pmu
+---------------------------------------
+
+To enable a core only event or atom only event, following syntax is supported:
+
+	cpu_core/<event name>/
+or
+	cpu_atom/<event name>/
+
+For example, count the 'cycles' event on core cpus.
+
+	perf stat -e cpu_core/cycles/
+
+Create two events for one hardware event automatically
+------------------------------------------------------
+
+When creating one event and the event is available on both atom and core,
+two events are created automatically. One is for atom, the other is for
+core. Most of hardware events and cache events are available on both
+cpu_core and cpu_atom.
+
+For hardware events, they have pre-defined configs (e.g. 0 for cycles).
+But on hybrid platform, kernel needs to know where the event comes from
+(from atom or from core). The original perf event type PERF_TYPE_HARDWARE
+can't carry pmu information. So now this type is extended to be PMU aware
+type. The PMU type ID is stored at attr.config[63:32].
+
+PMU type ID is retrieved from sysfs.
+/sys/devices/cpu_atom/type
+/sys/devices/cpu_core/type
+
+The new attr.config layout for PERF_TYPE_HARDWARE:
+
+PERF_TYPE_HARDWARE:                 0xEEEEEEEE000000AA
+                                    AA: hardware event ID
+                                    EEEEEEEE: PMU type ID
+
+Cache event is similar. The type PERF_TYPE_HW_CACHE is extended to be
+PMU aware type. The PMU type ID is stored at attr.config[63:32].
+
+The new attr.config layout for PERF_TYPE_HW_CACHE:
+
+PERF_TYPE_HW_CACHE:                 0xEEEEEEEE00DDCCBB
+                                    BB: hardware cache ID
+                                    CC: hardware cache op ID
+                                    DD: hardware cache op result ID
+                                    EEEEEEEE: PMU type ID
+
+When enabling a hardware event without specified pmu, such as,
+perf stat -e cycles -a (use system-wide in this example), two events
+are created automatically.
+
+  ------------------------------------------------------------
+  perf_event_attr:
+    size                             120
+    config                           0x400000000
+    sample_type                      IDENTIFIER
+    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+    disabled                         1
+    inherit                          1
+    exclude_guest                    1
+  ------------------------------------------------------------
+
+and
+
+  ------------------------------------------------------------
+  perf_event_attr:
+    size                             120
+    config                           0x800000000
+    sample_type                      IDENTIFIER
+    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+    disabled                         1
+    inherit                          1
+    exclude_guest                    1
+  ------------------------------------------------------------
+
+type 0 is PERF_TYPE_HARDWARE.
+0x4 in 0x400000000 indicates it's cpu_core pmu.
+0x8 in 0x800000000 indicates it's cpu_atom pmu (atom pmu type id is random).
+
+The kernel creates 'cycles' (0x400000000) on cpu0-cpu15 (core cpus),
+and create 'cycles' (0x800000000) on cpu16-cpu23 (atom cpus).
+
+For perf-stat result, it displays two events:
+
+ Performance counter stats for 'system wide':
+
+           6,744,979      cpu_core/cycles/
+           1,965,552      cpu_atom/cycles/
+
+The first 'cycles' is core event, the second 'cycles' is atom event.
+
+Thread mode example:
+--------------------
+
+perf-stat reports the scaled counts for hybrid event and with a percentage
+displayed. The percentage is the event's running time/enabling time.
+
+One example, 'triad_loop' runs on cpu16 (atom core), while we can see the
+scaled value for core cycles is 160,444,092 and the percentage is 0.47%.
+
+perf stat -e cycles -- taskset -c 16 ./triad_loop
+
+As previous, two events are created.
+
+------------------------------------------------------------
+perf_event_attr:
+  size                             120
+  config                           0x400000000
+  sample_type                      IDENTIFIER
+  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+  disabled                         1
+  inherit                          1
+  enable_on_exec                   1
+  exclude_guest                    1
+------------------------------------------------------------
+
+and
+
+------------------------------------------------------------
+perf_event_attr:
+  size                             120
+  config                           0x800000000
+  sample_type                      IDENTIFIER
+  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+  disabled                         1
+  inherit                          1
+  enable_on_exec                   1
+  exclude_guest                    1
+------------------------------------------------------------
+
+ Performance counter stats for 'taskset -c 16 ./triad_loop':
+
+       233,066,666      cpu_core/cycles/                                              (0.43%)
+       604,097,080      cpu_atom/cycles/                                              (99.57%)
+
+perf-record:
+------------
+
+If there is no '-e' specified in perf record, on hybrid platform,
+it creates two default 'cycles' and adds them to event list. One
+is for core, the other is for atom.
+
+perf-stat:
+----------
+
+If there is no '-e' specified in perf stat, on hybrid platform,
+besides of software events, following events are created and
+added to event list in order.
+
+cpu_core/cycles/,
+cpu_atom/cycles/,
+cpu_core/instructions/,
+cpu_atom/instructions/,
+cpu_core/branches/,
+cpu_atom/branches/,
+cpu_core/branch-misses/,
+cpu_atom/branch-misses/
+
+Of course, both perf-stat and perf-record support to enable
+hybrid event with a specific pmu.
+
+e.g.
+perf stat -e cpu_core/cycles/
+perf stat -e cpu_atom/cycles/
+perf stat -e cpu_core/r1a/
+perf stat -e cpu_atom/L1-icache-loads/
+perf stat -e cpu_core/cycles/,cpu_atom/instructions/
+perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}'
+
+But '{cpu_core/cycles/,cpu_atom/instructions/}' will return
+warning and disable grouping, because the pmus in group are
+not matched (cpu_core vs. cpu_atom).
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index f3161c9673e9..d71bac847936 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -695,6 +695,7 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+include::intel-hybrid.txt[]
 
 SEE ALSO
 --------
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 6ec5960b08c3..aedb05f56c35 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -550,6 +550,8 @@ The fields are in this order:
 
 Additional metrics may be printed with all earlier fields being empty.
 
+include::intel-hybrid.txt[]
+
 SEE ALSO
 --------
 linkperf:perf-top[1], linkperf:perf-list[1]
-- 
2.17.1

