Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F936F395
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhD3B1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:27:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5142 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhD3B1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:27:30 -0400
Received: from dggeml701-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FWZQt4pRNzYYNM;
        Fri, 30 Apr 2021 09:24:22 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggeml701-chm.china.huawei.com (10.3.17.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Apr 2021 09:26:40 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 09:26:40 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux@armlinux.org.uk>,
        <suzuki.poulose@arm.com>, <julien.thierry.kdev@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] arm_pmu: Fix write counter incorrect in ARMv7 big-endian mode
Date:   Fri, 30 Apr 2021 09:26:59 +0800
Message-ID: <20210430012659.232110-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
changes the input "value" type from 32-bit to 64-bit,
which introduces the following problem:
ARMv7 PMU counters is 32-bit width, in big-endian mode, write counter uses
high 32-bit, which writes an incorrect value.

Before:

 Performance counter stats for 'ls':

              2.22 msec task-clock                #    0.675 CPUs utilized
                 0      context-switches          #    0.000 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                49      page-faults               #    0.022 M/sec
        2150476593      cycles                    #  966.663 GHz
        2148588788      instructions              #    1.00  insn per cycle
        2147745484      branches                  # 965435.074 M/sec
        2147508540      branch-misses             #   99.99% of all branches

None of the above hw event counters are correct.

Solution:

"value" forcibly converted to 32-bit type before being written to PMU register.

After:

 Performance counter stats for 'ls':

              2.09 msec task-clock                #    0.681 CPUs utilized
                 0      context-switches          #    0.000 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                46      page-faults               #    0.022 M/sec
           2807301      cycles                    #    1.344 GHz
           1060159      instructions              #    0.38  insn per cycle
            250496      branches                  #  119.914 M/sec
             23192      branch-misses             #    9.26% of all branches

Fixes: 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 arch/arm/kernel/perf_event_v7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 2924d7910b10..eb2190477da1 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -773,10 +773,10 @@ static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
 	} else if (idx == ARMV7_IDX_CYCLE_COUNTER) {
-		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
+		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" ((u32)value));
 	} else {
 		armv7_pmnc_select_counter(idx);
-		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" (value));
+		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" ((u32)value));
 	}
 }
 
-- 
2.30.GIT

