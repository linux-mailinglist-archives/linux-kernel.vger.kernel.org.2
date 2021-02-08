Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6B313D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhBHSXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:23:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:27842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234117AbhBHPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:47:41 -0500
IronPort-SDR: 08ootvMi2Y8qHTPCU+B9vsB1pu9RdwYKGZlvLfeX0vdciQbWtHw5XUg9QaOOdTxNhctN7n1M5A
 a+RrZviA+rQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874636"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: N0xe8vnzH0vN7IpaUxp57CaG3vvy4aNc20gZQfHg9Ex+H4abi2L/wVjC34jbXrUPKgC0hNbjRi
 y+XoEN1ecAoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820944"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 49/49] perf evsel: Adjust hybrid event and global event mixed group
Date:   Mon,  8 Feb 2021 07:25:46 -0800
Message-Id: <1612797946-18784-50-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

A group mixed with hybrid event and global event is allowed. For example,
group leader is 'cpu-clock' and the group member is 'cpu_atom/cycles/'.

e.g.
perf stat -e '{cpu-clock,cpu_atom/cycles/}' -a

The challenge is their available cpus are not fully matched.
For example, 'cpu-clock' is available on CPU0-CPU23, but 'cpu_core/cycles/'
is available on CPU16-CPU23.

When getting the group id for group member, we must be very careful
because the cpu for 'cpu-clock' is not equal to the cpu for 'cpu_atom/cycles/'.
Actually the cpu here is the index of evsel->core.cpus, not the real CPU ID.
e.g. cpu0 for 'cpu-clock' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.

Another challenge is for group read. The events in group may be not
available on all cpus. For example the leader is a software event and
it's available on CPU0-CPU1, but the group member is a hybrid event and
it's only available on CPU1. For CPU0, we have only one event, but for CPU1
we have two events. So we need to change the read size according to
the real number of events on that cpu.

Let's see examples,

root@otcpl-adl-s-2:~# ./perf stat -e '{cpu-clock,cpu_atom/cycles/}' -a -vvv -- sleep 1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd 20  flags 0x8 = 28
sys_perf_event_open: pid -1  cpu 17  group_fd 21  flags 0x8 = 29
sys_perf_event_open: pid -1  cpu 18  group_fd 22  flags 0x8 = 30
sys_perf_event_open: pid -1  cpu 19  group_fd 23  flags 0x8 = 31
sys_perf_event_open: pid -1  cpu 20  group_fd 24  flags 0x8 = 32
sys_perf_event_open: pid -1  cpu 21  group_fd 25  flags 0x8 = 33
sys_perf_event_open: pid -1  cpu 22  group_fd 26  flags 0x8 = 34
sys_perf_event_open: pid -1  cpu 23  group_fd 27  flags 0x8 = 35
cpu-clock: 0: 1001661765 1001663044 1001663044
cpu-clock: 1: 1001659407 1001659885 1001659885
cpu-clock: 2: 1001646087 1001647302 1001647302
cpu-clock: 3: 1001645168 1001645550 1001645550
cpu-clock: 4: 1001645052 1001646102 1001646102
cpu-clock: 5: 1001643719 1001644472 1001644472
cpu-clock: 6: 1001641893 1001642859 1001642859
cpu-clock: 7: 1001640524 1001641036 1001641036
cpu-clock: 8: 1001637596 1001638076 1001638076
cpu-clock: 9: 1001638121 1001638200 1001638200
cpu-clock: 10: 1001635825 1001636915 1001636915
cpu-clock: 11: 1001633722 1001634276 1001634276
cpu-clock: 12: 1001687133 1001686941 1001686941
cpu-clock: 13: 1001693663 1001693317 1001693317
cpu-clock: 14: 1001693381 1001694407 1001694407
cpu-clock: 15: 1001691865 1001692321 1001692321
cpu-clock: 16: 1001696621 1001696550 1001696550
cpu-clock: 17: 1001699963 1001699822 1001699822
cpu-clock: 18: 1001701938 1001701850 1001701850
cpu-clock: 19: 1001699298 1001699214 1001699214
cpu-clock: 20: 1001691550 1001691026 1001691026
cpu-clock: 21: 1001688348 1001688212 1001688212
cpu-clock: 22: 1001684907 1001684799 1001684799
cpu-clock: 23: 1001680840 1001680780 1001680780
cycles: 0: 28175 1001696550 1001696550
cycles: 1: 403323 1001699822 1001699822
cycles: 2: 35905 1001701850 1001701850
cycles: 3: 36755 1001699214 1001699214
cycles: 4: 33757 1001691026 1001691026
cycles: 5: 37146 1001688212 1001688212
cycles: 6: 35483 1001684799 1001684799
cycles: 7: 38600 1001680780 1001680780
cpu-clock: 24040038386 24040046956 24040046956
cycles: 649144 8013542253 8013542253

 Performance counter stats for 'system wide':

         24,040.04 msec cpu-clock                 #   23.976 CPUs utilized
           649,144      cycles [cpu_atom]         #    0.027 M/sec

       1.002683706 seconds time elapsed

For cpu_atom/cycles/, cpu16-cpu23 are set with valid group fd (cpu-clock's fd
on that cpu). For counting results, cpu-clock has 24 cpus aggregation and
cpu_atom/cycles/ has 8 cpus aggregation. That's expected.

But if the event order is changed, e.g. '{cpu_atom/cycles/,cpu-clock}',
there leaves more works to do.

root@otcpl-adl-s-2:~# ./perf stat -e '{cpu_atom/cycles/,cpu-clock}' -a -vvv -- sleep 1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 11
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 27
sys_perf_event_open: pid -1  cpu 16  group_fd 3  flags 0x8 = 28
sys_perf_event_open: pid -1  cpu 17  group_fd 4  flags 0x8 = 29
sys_perf_event_open: pid -1  cpu 18  group_fd 5  flags 0x8 = 30
sys_perf_event_open: pid -1  cpu 19  group_fd 7  flags 0x8 = 31
sys_perf_event_open: pid -1  cpu 20  group_fd 8  flags 0x8 = 32
sys_perf_event_open: pid -1  cpu 21  group_fd 9  flags 0x8 = 33
sys_perf_event_open: pid -1  cpu 22  group_fd 10  flags 0x8 = 34
sys_perf_event_open: pid -1  cpu 23  group_fd 11  flags 0x8 = 35
cycles: 0: 422260 1001993637 1001993637
cycles: 1: 631309 1002039934 1002039934
cycles: 2: 309501 1002018065 1002018065
cycles: 3: 119279 1002040811 1002040811
cycles: 4: 89389 1002039312 1002039312
cycles: 5: 155437 1002054794 1002054794
cycles: 6: 92420 1002051141 1002051141
cycles: 7: 96017 1002073659 1002073659
cpu-clock: 0: 0 0 0
cpu-clock: 1: 0 0 0
cpu-clock: 2: 0 0 0
cpu-clock: 3: 0 0 0
cpu-clock: 4: 0 0 0
cpu-clock: 5: 0 0 0
cpu-clock: 6: 0 0 0
cpu-clock: 7: 0 0 0
cpu-clock: 8: 0 0 0
cpu-clock: 9: 0 0 0
cpu-clock: 10: 0 0 0
cpu-clock: 11: 0 0 0
cpu-clock: 12: 0 0 0
cpu-clock: 13: 0 0 0
cpu-clock: 14: 0 0 0
cpu-clock: 15: 0 0 0
cpu-clock: 16: 1001997706 1001993637 1001993637
cpu-clock: 17: 1002040524 1002039934 1002039934
cpu-clock: 18: 1002018570 1002018065 1002018065
cpu-clock: 19: 1002041360 1002040811 1002040811
cpu-clock: 20: 1002044731 1002039312 1002039312
cpu-clock: 21: 1002055355 1002054794 1002054794
cpu-clock: 22: 1002051659 1002051141 1002051141
cpu-clock: 23: 1002074150 1002073659 1002073659
cycles: 1915612 8016311353 8016311353
cpu-clock: 8016324055 8016311353 8016311353

 Performance counter stats for 'system wide':

         1,915,612      cycles [cpu_atom]         #    0.239 M/sec
          8,016.32 msec cpu-clock                 #    7.996 CPUs utilized

       1.002545027 seconds time elapsed

For cpu-clock, cpu16-cpu23 are set with valid group fd (cpu_atom/cycles/'s
fd on that cpu). For counting results, cpu_atom/cycles/ has 8 cpus aggregation
, that's correct. But for cpu-clock, it also has 8 cpus aggregation
(cpu16-cpu23, not all cpus), the code should be improved. Now one warning
is displayed: "WARNING: for cpu-clock, some CPU counts not read".

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c | 105 +++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/stat.h  |   1 +
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 61508cf..65c8cfc8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1453,15 +1453,26 @@ static void evsel__set_count(struct evsel *counter, int cpu, int thread, u64 val
 	perf_counts__set_loaded(counter->counts, cpu, thread, true);
 }
 
-static int evsel__process_group_data(struct evsel *leader, int cpu, int thread, u64 *data)
+static int evsel_cpuid_match(struct evsel *evsel1, struct evsel *evsel2,
+			     int cpu)
+{
+	int cpuid;
+
+	cpuid = perf_cpu_map__cpu(evsel1->core.cpus, cpu);
+	return perf_cpu_map__idx(evsel2->core.cpus, cpuid);
+}
+
+static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
+				     u64 *data, int nr_members)
 {
 	u64 read_format = leader->core.attr.read_format;
 	struct sample_read_value *v;
 	u64 nr, ena = 0, run = 0, i;
+	int idx;
 
 	nr = *data++;
 
-	if (nr != (u64) leader->core.nr_members)
+	if (nr != (u64) nr_members)
 		return -EINVAL;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -1481,24 +1492,85 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 		if (!counter)
 			return -EINVAL;
 
-		evsel__set_count(counter, cpu, thread, v[i].value, ena, run);
+		if (evsel__is_hybrid_event(counter) ||
+		    evsel__is_hybrid_event(leader)) {
+			idx = evsel_cpuid_match(leader, counter, cpu);
+			if (idx == -1)
+				return -EINVAL;
+		} else
+			idx = cpu;
+
+		evsel__set_count(counter, idx, thread, v[i].value, ena, run);
 	}
 
 	return 0;
 }
 
+static int hybrid_read_size(struct evsel *leader, int cpu, int *nr_members)
+{
+	struct evsel *pos;
+	int nr = 1, back, new_size = 0, idx;
+
+	for_each_group_member(pos, leader) {
+		idx = evsel_cpuid_match(leader, pos, cpu);
+		if (idx != -1)
+			nr++;
+	}
+
+	if (nr != leader->core.nr_members) {
+		back = leader->core.nr_members;
+		leader->core.nr_members = nr;
+		new_size = perf_evsel__read_size(&leader->core);
+		leader->core.nr_members = back;
+	}
+
+	*nr_members = nr;
+	return new_size;
+}
+
 static int evsel__read_group(struct evsel *leader, int cpu, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
 	int size = perf_evsel__read_size(&leader->core);
+	int new_size, nr_members;
 	u64 *data = ps->group_data;
 
 	if (!(read_format & PERF_FORMAT_ID))
 		return -EINVAL;
 
-	if (!evsel__is_group_leader(leader))
+	if (!evsel__is_group_leader(leader)) {
+		if (evsel__is_hybrid_event(leader->leader) &&
+		    !evsel__is_hybrid_event(leader)) {
+			/*
+			 * The group leader is hybrid event and it's
+			 * only available on part of cpus. But the group
+			 * member are available on all cpus. TODO:
+			 * read the counts on the rest of cpus for group
+			 * member.
+			 */
+			WARN_ONCE(1, "WARNING: for %s, some CPU counts "
+				     "not read\n", leader->name);
+			return 0;
+		}
 		return -EINVAL;
+	}
+
+	/*
+	 * For example the leader is a software event and it's available on
+	 * cpu0-cpu1, but the group member is a hybrid event and it's only
+	 * available on cpu1. For cpu0, we have only one event, but for cpu1
+	 * we have two events. So we need to change the read size according to
+	 * the real number of events on a given cpu.
+	 */
+	new_size = hybrid_read_size(leader, cpu, &nr_members);
+	if (new_size)
+		size = new_size;
+
+	if (ps->group_data && ps->group_data_size < size) {
+		zfree(&ps->group_data);
+		data = NULL;
+	}
 
 	if (!data) {
 		data = zalloc(size);
@@ -1506,6 +1578,7 @@ static int evsel__read_group(struct evsel *leader, int cpu, int thread)
 			return -ENOMEM;
 
 		ps->group_data = data;
+		ps->group_data_size = size;
 	}
 
 	if (FD(leader, cpu, thread) < 0)
@@ -1514,7 +1587,7 @@ static int evsel__read_group(struct evsel *leader, int cpu, int thread)
 	if (readn(FD(leader, cpu, thread), data, size) <= 0)
 		return -errno;
 
-	return evsel__process_group_data(leader, cpu, thread, data);
+	return evsel__process_group_data(leader, cpu, thread, data, nr_members);
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu, int thread)
@@ -1561,6 +1634,28 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	 */
 	BUG_ON(!leader->core.fd);
 
+	/*
+	 * If leader is not hybrid event, it's available on
+	 * all cpus (e.g. software event). But hybrid evsel
+	 * member is only available on part of cpus. So need
+	 * to get the leader's fd from correct cpu.
+	 */
+	if (evsel__is_hybrid_event(evsel) &&
+	    !evsel__is_hybrid_event(leader)) {
+		cpu = evsel_cpuid_match(evsel, leader, cpu);
+		BUG_ON(cpu == -1);
+	}
+
+	/*
+	 * Leader is hybrid event but member is global event.
+	 */
+	if (!evsel__is_hybrid_event(evsel) &&
+	    evsel__is_hybrid_event(leader)) {
+		cpu = evsel_cpuid_match(evsel, leader, cpu);
+		if (cpu == -1)
+			return -1;
+	}
+
 	fd = FD(leader, cpu, thread);
 	BUG_ON(fd == -1);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 80f6715..b96168c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -46,6 +46,7 @@ struct perf_stat_evsel {
 	struct stats		 res_stats[3];
 	enum perf_stat_evsel_id	 id;
 	u64			*group_data;
+	int			 group_data_size;
 };
 
 enum aggr_mode {
-- 
2.7.4

