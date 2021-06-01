Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E9396AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 03:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFABlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 21:41:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:14407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbhFABlK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 21:41:10 -0400
IronPort-SDR: glPrFAqfIJPR3HvotDyDSF7Od0drYgI8pji+Y+yV3Y6SZyxi5uzSOnijkH3H3Zxu8+pAbIevWG
 iuNcOb6NDFjA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="267329927"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="267329927"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 18:39:29 -0700
IronPort-SDR: SSki7Kt9ZBShuRAiF8k74YlSc2RqVQJhi6eV5m76C91hCj8YLUBCxIKbV5m3Fh76quEDjmVmj3
 p5nimGEKKS/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="474059776"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2021 18:39:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf evsel: Adjust hybrid event and global event mixed group
Date:   Tue,  1 Jun 2021 09:38:27 +0800
Message-Id: <20210601013827.1102-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A group mixed with hybrid event and global event is allowed. For example,
group leader is 'intel_pt//' and the group member is 'cpu_atom/cycles/'.

e.g.
perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u'

The challenge is their available cpus are not fully matched. For example,
'intel_pt//' is available on CPU0-CPU23, but 'cpu_atom/cycles/' is
available on CPU16-CPU23.

When getting the group id for group member, we must be very careful.
Because the cpu for 'intel_pt//' is not equal to the cpu for
'cpu_atom/cycles/'. Actually the cpu here is the index of evsel->core.cpus,
not the real CPU ID.

e.g. cpu0 for 'intel_pt//' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.

Before:

  # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             10
    size                             128
    config                           0xe601
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    enable_on_exec                   1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 4084  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 4084  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 4084  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid 4084  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 4084  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 4084  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 4084  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 4084  cpu 7  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid 4084  cpu 8  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid 4084  cpu 9  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid 4084  cpu 10  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid 4084  cpu 11  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid 4084  cpu 12  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid 4084  cpu 13  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid 4084  cpu 14  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid 4084  cpu 15  group_fd -1  flags 0x8 = 21
  sys_perf_event_open: pid 4084  cpu 16  group_fd -1  flags 0x8 = 22
  sys_perf_event_open: pid 4084  cpu 17  group_fd -1  flags 0x8 = 23
  sys_perf_event_open: pid 4084  cpu 18  group_fd -1  flags 0x8 = 24
  sys_perf_event_open: pid 4084  cpu 19  group_fd -1  flags 0x8 = 25
  sys_perf_event_open: pid 4084  cpu 20  group_fd -1  flags 0x8 = 26
  sys_perf_event_open: pid 4084  cpu 21  group_fd -1  flags 0x8 = 27
  sys_perf_event_open: pid 4084  cpu 22  group_fd -1  flags 0x8 = 28
  sys_perf_event_open: pid 4084  cpu 23  group_fd -1  flags 0x8 = 29
  ------------------------------------------------------------
  perf_event_attr:
    size                             128
    config                           0x800000000
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
    read_format                      ID
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
    aux_sample_size                  4096
  ------------------------------------------------------------
  sys_perf_event_open: pid 4084  cpu 16  group_fd 5  flags 0x8
  sys_perf_event_open failed, error -22

The group_fd 5 is not correct. It should be 22 (the fd of
'intel_pt' on CPU16).

After:

  # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             10
    size                             128
    config                           0xe601
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    enable_on_exec                   1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 5162  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 5162  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 5162  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid 5162  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 5162  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 5162  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 5162  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 5162  cpu 7  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid 5162  cpu 8  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid 5162  cpu 9  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid 5162  cpu 10  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid 5162  cpu 11  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid 5162  cpu 12  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid 5162  cpu 13  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid 5162  cpu 14  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid 5162  cpu 15  group_fd -1  flags 0x8 = 21
  sys_perf_event_open: pid 5162  cpu 16  group_fd -1  flags 0x8 = 22
  sys_perf_event_open: pid 5162  cpu 17  group_fd -1  flags 0x8 = 23
  sys_perf_event_open: pid 5162  cpu 18  group_fd -1  flags 0x8 = 24
  sys_perf_event_open: pid 5162  cpu 19  group_fd -1  flags 0x8 = 25
  sys_perf_event_open: pid 5162  cpu 20  group_fd -1  flags 0x8 = 26
  sys_perf_event_open: pid 5162  cpu 21  group_fd -1  flags 0x8 = 27
  sys_perf_event_open: pid 5162  cpu 22  group_fd -1  flags 0x8 = 28
  sys_perf_event_open: pid 5162  cpu 23  group_fd -1  flags 0x8 = 29
  ------------------------------------------------------------
  perf_event_attr:
    size                             128
    config                           0x800000000
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
    read_format                      ID
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
    aux_sample_size                  4096
  ------------------------------------------------------------
  sys_perf_event_open: pid 5162  cpu 16  group_fd 22  flags 0x8 = 30
  sys_perf_event_open: pid 5162  cpu 17  group_fd 23  flags 0x8 = 31
  sys_perf_event_open: pid 5162  cpu 18  group_fd 24  flags 0x8 = 32
  sys_perf_event_open: pid 5162  cpu 19  group_fd 25  flags 0x8 = 33
  sys_perf_event_open: pid 5162  cpu 20  group_fd 26  flags 0x8 = 34
  sys_perf_event_open: pid 5162  cpu 21  group_fd 27  flags 0x8 = 35
  sys_perf_event_open: pid 5162  cpu 22  group_fd 28  flags 0x8 = 36
  sys_perf_event_open: pid 5162  cpu 23  group_fd 29  flags 0x8 = 37
  ------------------------------------------------------------
  ...

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a3cd1b5bb33..a9cf615fe580 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1581,6 +1581,15 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
 	return 0;
 }
 
+static int evsel_cpuid_match(struct evsel *evsel1, struct evsel *evsel2,
+			     int cpu)
+{
+	int cpuid;
+
+	cpuid = perf_cpu_map__cpu(evsel1->core.cpus, cpu);
+	return perf_cpu_map__idx(evsel2->core.cpus, cpuid);
+}
+
 static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 {
 	struct evsel *leader = evsel->leader;
@@ -1595,6 +1604,26 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	 */
 	BUG_ON(!leader->core.fd);
 
+	/*
+	 * If leader is global event (e.g. 'intel_pt//'), but member is
+	 * hybrid event. Need to get the leader's fd from correct cpu.
+	 */
+	if (evsel__is_hybrid(evsel) &&
+	    !evsel__is_hybrid(leader)) {
+		cpu = evsel_cpuid_match(evsel, leader, cpu);
+		BUG_ON(cpu == -1);
+	}
+
+	/*
+	 * Leader is hybrid event but member is global event.
+	 */
+	if (!evsel__is_hybrid(evsel) &&
+	    evsel__is_hybrid(leader)) {
+		cpu = evsel_cpuid_match(evsel, leader, cpu);
+		if (cpu == -1)
+			return -1;
+	}
+
 	fd = FD(leader, cpu, thread);
 	BUG_ON(fd == -1);
 
-- 
2.17.1

