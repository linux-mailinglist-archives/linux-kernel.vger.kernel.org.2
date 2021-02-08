Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6536313D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhBHSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:18:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:27842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhBHPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:01 -0500
IronPort-SDR: Y1VQw+9j6O2GwVp99qsIUOZosj7YKBu2ogfPP51tjycI9UUcQbZ4w8/mbnRzW1F51NWknlKceh
 3xSTgmMNygcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874629"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: jmV2ryjQSmX3XybDlHCUgWNw5i4KV+Xl8hnYc9yNh+lHk7bQDWuTrgAUySBj/p34aUVj5dVlW9
 OI0xYu1OfYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820921"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 42/49] perf evlist: Create two hybrid 'cycles' events by default
Date:   Mon,  8 Feb 2021 07:25:39 -0800
Message-Id: <1612797946-18784-43-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

When evlist is empty, for example no '-e' specified in perf record,
one default 'cycles' event is added to evlist.

While on hybrid platform, it needs to create two default 'cycles'
events. One is for core, the other is for atom.

This patch actually calls evsel__new_cycles() two times to create
two 'cycles' events.

root@otcpl-adl-s-2:~# ./perf record -vv -- sleep 1
...
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000000
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 11609  cpu 0  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 11609  cpu 1  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 11609  cpu 2  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 11609  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 11609  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 11609  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 11609  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 11609  cpu 7  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 11609  cpu 8  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 11609  cpu 9  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid 11609  cpu 10  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid 11609  cpu 11  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 11609  cpu 12  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid 11609  cpu 13  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid 11609  cpu 14  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid 11609  cpu 15  group_fd -1  flags 0x8 = 21
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000000
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  freq                             1
  enable_on_exec                   1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 11609  cpu 16  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid 11609  cpu 17  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid 11609  cpu 18  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid 11609  cpu 19  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid 11609  cpu 20  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid 11609  cpu 21  group_fd -1  flags 0x8 = 27
sys_perf_event_open: pid 11609  cpu 22  group_fd -1  flags 0x8 = 28
sys_perf_event_open: pid 11609  cpu 23  group_fd -1  flags 0x8 = 29
...
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x9
  watermark                        1
  sample_id_all                    1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 30
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 31
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 32
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 33
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 34
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 35
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 36
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 37
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 38
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 39
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 40
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 41
sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 42
sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 43
sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 44
sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 45
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 46
sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 47
sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 48
sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 49
sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 50
sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 51
sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 52
sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 53
...

We can see one core 'cycles' (0x400000000) is enabled on cpu0-cpu15
and atom 'cycles' (0xa00000000) is enabled on cpu16-cpu23.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evlist.c | 33 ++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c  |  6 +++---
 tools/perf/util/evsel.h  |  2 +-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 626a0e7..8606e82 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -243,10 +243,41 @@ void evlist__set_leader(struct evlist *evlist)
 	}
 }
 
+static int __evlist__add_hybrid_default(struct evlist *evlist, bool precise)
+{
+	struct evsel *evsel;
+	struct perf_pmu *pmu;
+	__u64 config;
+	struct perf_cpu_map *cpus;
+
+	perf_pmu__for_each_hybrid_pmus(pmu) {
+		config = PERF_COUNT_HW_CPU_CYCLES |
+			 ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
+		evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE_PMU,
+					  config);
+		if (!evsel)
+			return -ENOMEM;
+
+		cpus = perf_cpu_map__get(pmu->cpus);
+		evsel->core.cpus = cpus;
+		evsel->core.own_cpus = perf_cpu_map__get(cpus);
+		evsel->pmu_name = strdup(pmu->name);
+		evlist__add(evlist, evsel);
+	}
+
+	return 0;
+}
+
 int __evlist__add_default(struct evlist *evlist, bool precise)
 {
-	struct evsel *evsel = evsel__new_cycles(precise);
+	struct evsel *evsel;
+
+	perf_pmu__scan(NULL);
+	if (perf_pmu__hybrid_exist())
+		return __evlist__add_hybrid_default(evlist, precise);
 
+	evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
+				  PERF_COUNT_HW_CPU_CYCLES);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 24c0b59..61508cf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -292,11 +292,11 @@ static bool perf_event_can_profile_kernel(void)
 	return perf_event_paranoid_check(1);
 }
 
-struct evsel *evsel__new_cycles(bool precise)
+struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 {
 	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_HARDWARE,
-		.config	= PERF_COUNT_HW_CPU_CYCLES,
+		.type	= type,
+		.config	= config,
 		.exclude_kernel	= !perf_event_can_profile_kernel(),
 	};
 	struct evsel *evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4eb054a..aa73442 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -198,7 +198,7 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 	return evsel__newtp_idx(sys, name, 0);
 }
 
-struct evsel *evsel__new_cycles(bool precise);
+struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-- 
2.7.4

