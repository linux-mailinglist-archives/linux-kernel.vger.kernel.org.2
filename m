Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A74336CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCKHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhCKHIv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:51 -0500
IronPort-SDR: L+FcZQXCUgp6UZIIOVjMXMzM5UXAL7OoGkYBFpuvWstPZFWVKiF1748C8DmyoAZWZG9T3AnQIV
 f2/2EO6VcanQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246064"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246064"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:51 -0800
IronPort-SDR: kL1fcc41yl3ujE3pahJDLcCxDr4JfmcdgrsHAX7M3xk6oYKIPbc6GYAyugp7CQB8B83Askl8zA
 bRGUkrPDaZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937918"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:48 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 13/27] perf evlist: Create two hybrid 'cycles' events by default
Date:   Thu, 11 Mar 2021 15:07:28 +0800
Message-Id: <20210311070742.9318-14-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When evlist is empty, for example no '-e' specified in perf record,
one default 'cycles' event is added to evlist.

While on hybrid platform, it needs to create two default 'cycles'
events. One is for core, the other is for atom.

This patch actually calls evsel__new_cycles() two times to create
two 'cycles' events.

  root@ssp-pwrt-002:~# ./perf record -vv -- sleep 1
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
  sys_perf_event_open: pid 22300  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 22300  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 22300  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid 22300  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 22300  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 22300  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 22300  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 22300  cpu 7  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid 22300  cpu 8  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid 22300  cpu 9  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid 22300  cpu 10  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid 22300  cpu 11  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid 22300  cpu 12  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid 22300  cpu 13  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid 22300  cpu 14  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid 22300  cpu 15  group_fd -1  flags 0x8 = 21
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
  sys_perf_event_open: pid 22300  cpu 16  group_fd -1  flags 0x8 = 22
  sys_perf_event_open: pid 22300  cpu 17  group_fd -1  flags 0x8 = 23
  sys_perf_event_open: pid 22300  cpu 18  group_fd -1  flags 0x8 = 24
  sys_perf_event_open: pid 22300  cpu 19  group_fd -1  flags 0x8 = 25
  sys_perf_event_open: pid 22300  cpu 20  group_fd -1  flags 0x8 = 26
  sys_perf_event_open: pid 22300  cpu 21  group_fd -1  flags 0x8 = 27
  sys_perf_event_open: pid 22300  cpu 22  group_fd -1  flags 0x8 = 28
  sys_perf_event_open: pid 22300  cpu 23  group_fd -1  flags 0x8 = 29
  ...

We can see one core 'cycles' (0x400000000) is enabled on cpu0-cpu15
and atom 'cycles' (0xa00000000) is enabled on cpu16-cpu23.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-record.c | 10 ++++++----
 tools/perf/util/evlist.c    | 32 +++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c     |  6 +++---
 tools/perf/util/evsel.h     |  2 +-
 4 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 35465d1db6dd..363ea1047148 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2786,10 +2786,12 @@ int cmd_record(int argc, const char **argv)
 	if (record.opts.overwrite)
 		record.opts.tail_synthesize = true;
 
-	if (rec->evlist->core.nr_entries == 0 &&
-	    __evlist__add_default(rec->evlist, !record.opts.no_samples) < 0) {
-		pr_err("Not enough memory for event selector list\n");
-		goto out;
+	if (rec->evlist->core.nr_entries == 0) {
+		perf_pmu__scan(NULL);
+		if (__evlist__add_default(rec->evlist, !record.opts.no_samples) < 0) {
+			pr_err("Not enough memory for event selector list\n");
+			goto out;
+		}
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3ee12fcd0c9f..f139151b9433 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -244,10 +244,40 @@ void evlist__set_leader(struct evlist *evlist)
 	}
 }
 
+static int __evlist__add_hybrid_default(struct evlist *evlist, bool precise)
+{
+	struct evsel *evsel;
+	struct perf_pmu *pmu;
+	__u64 config;
+	struct perf_cpu_map *cpus;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
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
+	if (perf_pmu__hybrid_exist())
+		return __evlist__add_hybrid_default(evlist, precise);
 
+	evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
+				  PERF_COUNT_HW_CPU_CYCLES);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7ecbc8e2fbfa..e0b6227d263f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,11 +295,11 @@ static bool perf_event_can_profile_kernel(void)
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
index 69aadc52c1bd..8e9079505e96 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -204,7 +204,7 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 	return evsel__newtp_idx(sys, name, 0);
 }
 
-struct evsel *evsel__new_cycles(bool precise);
+struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-- 
2.17.1

