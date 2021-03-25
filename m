Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0831348E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCYKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14901 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhCYKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNj5jFyzkfVN;
        Thu, 25 Mar 2021 18:36:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 18:38:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>
CC:     <linuxarm@huawei.com>, <kjain@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/6] perf arm64 metricgroup support
Date:   Thu, 25 Mar 2021 18:33:12 +0800
Message-ID: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains support to get basic metricgroups working for
arm64 CPUs.

Initial support is added for HiSilicon hip08 platform.

Some sample usage on Huawei D06 board:

 $ ./perf list metric    

List of pre-defined events (to be used in -e): 

Metrics:     

  bp_misp_flush
       [BP misp flush L3 topdown metric]
  branch_mispredicts
       [Branch mispredicts L2 topdown metric]
  core_bound
       [Core bound L2 topdown metric]
  divider
       [Divider L3 topdown metric]
  exe_ports_util
       [EXE ports util L3 topdown metric]
  fetch_bandwidth_bound
       [Fetch bandwidth bound L2 topdown metric]
  fetch_latency_bound
       [Fetch latency bound L2 topdown metric]
  fsu_stall
       [FSU stall L3 topdown metric]
  idle_by_icache_miss

$ sudo ./perf stat -v -M core_bound sleep 1
Using CPUID 0x00000000480fd010
metric expr (exe_stall_cycle - (mem_stall_anyload + armv8_pmuv3_0@event\=0x7005@)) / cpu_cycles for core_bound
found event cpu_cycles
found event armv8_pmuv3_0/event=0x7005/
found event exe_stall_cycle
found event mem_stall_anyload
adding {cpu_cycles -> armv8_pmuv3_0/event=0x7001/
mem_stall_anyload -> armv8_pmuv3_0/event=0x7004/
Control descriptor is not initialized
cpu_cycles: 989433 385050 385050
armv8_pmuv3_0/event=0x7005/: 19207 385050 385050
exe_stall_cycle: 900825 385050 385050
mem_stall_anyload: 253516 385050 385050

Performance counter stats for 'sleep':

989,433      cpu_cycles      #     0.63 core_bound
  19,207      armv8_pmuv3_0/event=0x7005/
 900,825      exe_stall_cycle
 253,516      mem_stall_anyload

       0.000805809 seconds time elapsed

       0.000875000 seconds user
       0.000000000 seconds sys
       
perf stat --topdown is not supported, as this requires the CPU PMU to
expose (alias) events for the TopDown L1 metrics from sysfs, which arm 
does not do. To get that to work, we probably need to make perf use the
pmu-events cpumap to learn about those alias events.

Metric reuse support is added for pmu-events parse metric testcase.
This had been broken on power9 recentlty:
https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/ 

Differences to v1:
- Add pmu_events_map__find() as arm64-specific function
- Fix metric reuse for pmu-events parse metric testcase 

John Garry (6):
  perf metricgroup: Make find_metric() public with name change
  perf test: Handle metric reuse in pmu-events parsing test
  perf pmu: Add pmu_events_map__find()
  perf vendor events arm64: Add Hisi hip08 L1 metrics
  perf vendor events arm64: Add Hisi hip08 L2 metrics
  perf vendor events arm64: Add Hisi hip08 L3 metrics

 tools/perf/arch/arm64/util/Build              |   1 +
 tools/perf/arch/arm64/util/pmu.c              |  25 ++
 .../arch/arm64/hisilicon/hip08/metrics.json   | 233 ++++++++++++++++++
 tools/perf/tests/pmu-events.c                 |  82 +++++-
 tools/perf/util/metricgroup.c                 |  12 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/pmu.c                         |   5 +
 tools/perf/util/pmu.h                         |   1 +
 tools/perf/util/s390-sample-raw.c             |   4 +-
 9 files changed, 355 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/pmu.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json

-- 
2.26.2

