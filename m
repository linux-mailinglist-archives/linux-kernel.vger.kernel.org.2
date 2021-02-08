Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49F313D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhBHSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:23:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:27508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhBHPrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:47:12 -0500
IronPort-SDR: e4bLkPlPV8ep2AHsb/hvRPINUNMh+L5aBdooUNvH3xREgSa3dC2JnZ6kMa70tQyTJcS7FadG3m
 s4WP4cA0zNEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874635"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874635"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: JQEeqhRNDJKhkj+RKtdTLDIdHSACrCl5Y4P6L0/QMJVcj2ll3C0bYkOcM49YtrDTrehXgA/VoP
 WnpyJyQ2TCBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820941"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 48/49] perf Documentation: Document intel-hybrid support
Date:   Mon,  8 Feb 2021 07:25:45 -0800
Message-Id: <1612797946-18784-49-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Add some words and examples to help understanding of
Intel hybrid perf support.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/intel-hybrid.txt | 335 ++++++++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt  |   1 +
 tools/perf/Documentation/perf-stat.txt    |   2 +
 3 files changed, 338 insertions(+)
 create mode 100644 tools/perf/Documentation/intel-hybrid.txt

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
new file mode 100644
index 0000000..bdf38d0
--- /dev/null
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -0,0 +1,335 @@
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
+Use '--cputype' option to list core only event or atom only event.
+
+perf list --cputype atom
+
+inst_retired.any
+	[Fixed Counter: Counts the number of instructions retired. Unit: cpu_atom]
+
+Enable hybrid event with a specific pmu
+---------------------------------------
+
+To enable a core only event or atom only event, following syntax is supported:
+
+	cpu_core/<event name>/
+or
+	cpu_atom/<event name>/
+or
+	--cputype core -e <event name>
+or
+	--cputype atom -e <event name>
+
+For example, count the 'cycles' event on core cpus.
+
+	perf stat -e cpu_core/cycles/
+or
+	perf stat --cputype core -e cycles
+
+If '--cputype' value conflicts with pmu prefix, '--cputype' is ignored and
+a warning will be displayed.
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
+can't carry pmu information. So a new type PERF_TYPE_HARDWARE_PMU is
+introduced.
+
+The new attr.config layout for PERF_TYPE_HARDWARE_PMU:
+
+0xDD000000AA
+AA: original hardware event ID
+DD: PMU type ID
+
+Cache event is similar. A new type PERF_TYPE_HW_CACHE_PMU is introduced.
+
+The new attr.config layout for PERF_TYPE_HW_CACHE_PMU:
+
+0xDD00CCBBAA
+AA: original hardware cache ID
+BB: original hardware cache op ID
+CC: original hardware cache op result ID
+DD: PMU type ID
+
+PMU type ID is retrieved from sysfs
+
+cat /sys/devices/cpu_atom/type
+10
+
+cat /sys/devices/cpu_core/type
+4
+
+When enabling a hardware event without specified pmu, such as,
+perf stat -e cycles -a (use system-wide in this example), two events
+are created automatically.
+
+    ------------------------------------------------------------
+    perf_event_attr:
+      type                             6
+      size                             120
+      config                           0x400000000
+      sample_type                      IDENTIFIER
+      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+      disabled                         1
+      inherit                          1
+      exclude_guest                    1
+    ------------------------------------------------------------
+
+and
+
+    ------------------------------------------------------------
+    perf_event_attr:
+      type                             6
+      size                             120
+      config                           0xa00000000
+      sample_type                      IDENTIFIER
+      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+      disabled                         1
+      inherit                          1
+      exclude_guest                    1
+    ------------------------------------------------------------
+
+type 6 is PERF_TYPE_HARDWARE_PMU.
+0x4 in 0x400000000 indicates it's cpu_core pmu.
+0xa in 0xa00000000 indicates it's cpu_atom pmu (atom pmu type id is random).
+
+The kernel creates 'cycles' (0x400000000) on cpu0-cpu15 (core cpus),
+and create 'cycles' (0xa00000000) on cpu16-cpu23 (atom cpus).
+
+For perf-stat result, it displays two events:
+
+     Performance counter stats for 'system wide':
+
+            14,240,632      cycles
+             1,556,789      cycles
+
+The first 'cycles' is core event, the second 'cycles' is atom event.
+
+In event list, for the events with same event name, the first one is core
+event, and the second one is atom event.
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
+  type                             6
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
+  type                             6
+  size                             120
+  config                           0xa00000000
+  sample_type                      IDENTIFIER
+  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
+  disabled                         1
+  inherit                          1
+  enable_on_exec                   1
+  exclude_guest                    1
+------------------------------------------------------------
+
+cycles: 0: 751035 206505423 966647
+cycles: 0: 601381075 206505423 205538776
+cycles: 160444092 206505423 966647
+cycles: 604209364 206505423 205538776
+
+ Performance counter stats for 'taskset -c 16 ./triad_loop':
+
+       160,444,092      cycles                                    (0.47%)
+       604,209,364      cycles                                    (99.53%)
+
+       0.207494637 seconds time elapsed
+
+We can use '--no-scale' to see the original data.
+
+perf stat -e cycles --no-scale -- taskset -c 16 ./triad_loop
+
+cycles: 0: 755604 206642115 956961
+cycles: 0: 601433846 206642115 205685154
+cycles: 755604 206642115 956961
+cycles: 601433846 206642115 205685154
+
+ Performance counter stats for 'taskset -c 16 ./triad_loop':
+
+           755,604      cycles                     (0.46%)
+       601,433,846      cycles                     (99.54%)
+
+Suppert metrics with hybrid events:
+-----------------------------------
+
+For hybrid platform, the same metric is probably made of the events
+with different pmus.
+
+For example "CPI".
+
+Atom:
+CPI = cpu_clk_unhalted.core / inst_retired.any_p
+
+Core:
+CPI = cpu_clk_unhalted.thread / inst_retired.any
+
+inst_retired.any_p and inst_retired.any are available on both core
+and atom CPU. But cpu_clk_unhalted.core is only available on atom and
+cpu_clk_unhalted.thread is only available on core CPU.
+
+The metric group string is expanded to:
+"{inst_retired.any,cpu_clk_unhalted.thread}:W,{cpu_clk_unhalted.core,inst_retired.any_p}:W".
+
+"{inst_retired.any,cpu_clk_unhalted.thread}:W" applies CPI on core.
+"{cpu_clk_unhalted.core,inst_retired.any_p}:W" applies CPI on atom.
+
+The difficulty is "inst_retired.any_p" and "inst_retired.any"
+can be available on both. So add pmu suffixes "cpu_atom"/"cpu_core" to
+limit the event group on a specified PMU.
+
+"{inst_retired.any,cpu_clk_unhalted.thread}:W#cpu_core,{cpu_clk_unhalted.core,inst_retired.any_p}:W#cpu_atom"
+
+That means the group "{inst_retired.any,cpu_clk_unhalted.thread}:W" is only
+enabled on core and "{cpu_clk_unhalted.core,inst_retired.any_p}:W" is only
+enabled on atom.
+
+For perf-stat result, it reports two 'CPI'.
+
+perf stat -M CPI -a -- sleep 1
+
+     Performance counter stats for 'system wide':
+
+              3,654,776      inst_retired.any          #     4.76 CPI
+             17,409,944      cpu_clk_unhalted.thread
+                771,568      cpu_clk_unhalted.core     #     6.83 CPI
+                112,943      inst_retired.any_p
+
+First CPI is for core, the second CPI is for atom.
+Of course, we can get core CPI only by enabling '--cputype' option.
+
+perf stat --cputype core -M CPI --no-merge -a -- sleep 1
+
+     Performance counter stats for 'system wide':
+
+             2,496,815      inst_retired.any [cpu_core] #     3.66 CPI
+             9,149,133      cpu_clk_unhalted.thread [cpu_core]
+
+perf-record:
+------------
+
+If there is no '-e' specified in perf record, on hybrid platform,
+it creates two default 'cycles' and adds them to event list. One
+is for core, the other is for atom.
+
+Support the '--cputype' option for perf-record. It can only enable
+the events on specific cpus with specified pmu type.
+
+perf record --cputype core
+
+Only the core 'cycles' are enabled on core cpus.
+
+perf-stat:
+----------
+
+If there is no '-e' specified in perf stat, on hybrid platform,
+besides of software events, following events are created and
+added to event list in order.
+
+core 'cycles',
+atom 'cycles',
+core 'instructions',
+atom 'instructions',
+core 'branches',
+atom 'branches',
+core 'branch-misses',
+atom 'branch-misses'
+
+Support the '--cputype' option for perf-stat. It can only enable
+the events on specific cpus with specified pmu type.
+
+perf stat --cputype core
+
+Only the core events are enabled on core cpus.
+
+core 'cycles',
+core 'instructions',
+core 'branches',
+core 'branch-misses',
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
+"<not supported>" for 'instructions', because the pmus in
+group are not matched (cpu_core vs. cpu_atom).
\ No newline at end of file
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 34cf651..6fc01f0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -680,6 +680,7 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+include::intel-hybrid.txt[]
 
 SEE ALSO
 --------
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3d083a3..43bdeaa 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -520,6 +520,8 @@ The fields are in this order:
 
 Additional metrics may be printed with all earlier fields being empty.
 
+include::intel-hybrid.txt[]
+
 SEE ALSO
 --------
 linkperf:perf-top[1], linkperf:perf-list[1]
-- 
2.7.4

