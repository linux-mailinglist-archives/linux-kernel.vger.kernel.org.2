Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D832BF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835642AbhCCSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13116 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378965AbhCCP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:28:30 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrHqV3Qknz16Fyj;
        Wed,  3 Mar 2021 23:24:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 23:26:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <irogers@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <qiangqing.zhang@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] perf arm64 metricgroup support
Date:   Wed, 3 Mar 2021 23:22:13 +0800
Message-ID: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
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

John Garry (5):
  perf metricgroup: Support printing metrics for arm64
  perf metricgroup: Support adding metrics for arm64
  perf vendor events arm64: Add Hisi hip08 L1 metrics
  perf vendor events arm64: Add Hisi hip08 L2 metrics
  perf vendor events arm64: Add Hisi hip08 L3 metrics

 .../arch/arm64/hisilicon/hip08/metrics.json   | 233 ++++++++++++++++++
 tools/perf/util/metricgroup.c                 |  27 +-
 2 files changed, 257 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json

-- 
2.26.2

