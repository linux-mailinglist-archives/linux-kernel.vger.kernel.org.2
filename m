Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23733563AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbhDGGEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:04:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237120AbhDGGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:04:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13763Xc8136836;
        Wed, 7 Apr 2021 02:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fgSM9VG2hQh2qvQnn86DImQ6ivuulGNLQgRNU6MUvjY=;
 b=VjU1HoBW+pKZJ1+QVJPi8sU+g9Vwf7vGuJArbnpfYHFWmjuVDWSqEHO42QqQF0GI55BT
 a8QNfEx8MMkgc4YsbwicBamLxh3vBUIdR04g7eJsOilIpPXJuSPdG7VnHFlUiUf6aRu0
 5CIhu49H3TEDe6HI8O4NoBkGVGVb8TEiOU/CC7K3xajuxwxCzmqZwO5lr4TDWPaV9Jlg
 Iqq9L/mv3yUf/9FozlAUPx++469SYmCFF0byKP5WVWby1cyxBKDps25lE3FQE8k9+l9G
 zHmdldN5wWgcN4pUuwWeITGxZ+k8AK1m4wSNcB1ymay9YxmBV4DEDx/aJZv+CS/DBRpI nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumdbku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 02:03:37 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13763Z8v136951;
        Wed, 7 Apr 2021 02:03:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumdbha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 02:03:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1375wF6Q018093;
        Wed, 7 Apr 2021 06:03:28 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 37rvgs3dv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 06:03:28 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13763Rx131981900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 06:03:27 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8AE6A05D;
        Wed,  7 Apr 2021 06:03:27 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12DE86A05A;
        Wed,  7 Apr 2021 06:03:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.220])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 06:03:20 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] perf arm64 metricgroup support
To:     John Garry <john.garry@huawei.com>, will@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com
Cc:     linuxarm@huawei.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, pc@us.ibm.com
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <0c8379f9-c073-ebf8-5335-812f9b30c6cd@linux.ibm.com>
Date:   Wed, 7 Apr 2021 11:33:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pK0YpwXU1-M7yjhphJqdkgDQqQzdsny9
X-Proofpoint-ORIG-GUID: GegICzjJSQgsIyyxkijbjVD-t7HT2oZt
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/21 4:03 PM, John Garry wrote:
> This series contains support to get basic metricgroups working for
> arm64 CPUs.
> 
> Initial support is added for HiSilicon hip08 platform.
> 
> Some sample usage on Huawei D06 board:
> 
>  $ ./perf list metric    
> 
> List of pre-defined events (to be used in -e): 
> 
> Metrics:     
> 
>   bp_misp_flush
>        [BP misp flush L3 topdown metric]
>   branch_mispredicts
>        [Branch mispredicts L2 topdown metric]
>   core_bound
>        [Core bound L2 topdown metric]
>   divider
>        [Divider L3 topdown metric]
>   exe_ports_util
>        [EXE ports util L3 topdown metric]
>   fetch_bandwidth_bound
>        [Fetch bandwidth bound L2 topdown metric]
>   fetch_latency_bound
>        [Fetch latency bound L2 topdown metric]
>   fsu_stall
>        [FSU stall L3 topdown metric]
>   idle_by_icache_miss
> 
> $ sudo ./perf stat -v -M core_bound sleep 1
> Using CPUID 0x00000000480fd010
> metric expr (exe_stall_cycle - (mem_stall_anyload + armv8_pmuv3_0@event\=0x7005@)) / cpu_cycles for core_bound
> found event cpu_cycles
> found event armv8_pmuv3_0/event=0x7005/
> found event exe_stall_cycle
> found event mem_stall_anyload
> adding {cpu_cycles -> armv8_pmuv3_0/event=0x7001/
> mem_stall_anyload -> armv8_pmuv3_0/event=0x7004/
> Control descriptor is not initialized
> cpu_cycles: 989433 385050 385050
> armv8_pmuv3_0/event=0x7005/: 19207 385050 385050
> exe_stall_cycle: 900825 385050 385050
> mem_stall_anyload: 253516 385050 385050
> 
> Performance counter stats for 'sleep':
> 
> 989,433      cpu_cycles      #     0.63 core_bound
>   19,207      armv8_pmuv3_0/event=0x7005/
>  900,825      exe_stall_cycle
>  253,516      mem_stall_anyload
> 
>        0.000805809 seconds time elapsed
> 
>        0.000875000 seconds user
>        0.000000000 seconds sys
>        
> perf stat --topdown is not supported, as this requires the CPU PMU to
> expose (alias) events for the TopDown L1 metrics from sysfs, which arm 
> does not do. To get that to work, we probably need to make perf use the
> pmu-events cpumap to learn about those alias events.
> 
> Metric reuse support is added for pmu-events parse metric testcase.
> This had been broken on power9 recentlty:
> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/ 

Patch set looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol jain

> 
> Differences to v1:
> - Add pmu_events_map__find() as arm64-specific function
> - Fix metric reuse for pmu-events parse metric testcase 
> 
> John Garry (6):
>   perf metricgroup: Make find_metric() public with name change
>   perf test: Handle metric reuse in pmu-events parsing test
>   perf pmu: Add pmu_events_map__find()
>   perf vendor events arm64: Add Hisi hip08 L1 metrics
>   perf vendor events arm64: Add Hisi hip08 L2 metrics
>   perf vendor events arm64: Add Hisi hip08 L3 metrics
> 
>  tools/perf/arch/arm64/util/Build              |   1 +
>  tools/perf/arch/arm64/util/pmu.c              |  25 ++
>  .../arch/arm64/hisilicon/hip08/metrics.json   | 233 ++++++++++++++++++
>  tools/perf/tests/pmu-events.c                 |  82 +++++-
>  tools/perf/util/metricgroup.c                 |  12 +-
>  tools/perf/util/metricgroup.h                 |   3 +-
>  tools/perf/util/pmu.c                         |   5 +
>  tools/perf/util/pmu.h                         |   1 +
>  tools/perf/util/s390-sample-raw.c             |   4 +-
>  9 files changed, 355 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/pmu.c
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> 
