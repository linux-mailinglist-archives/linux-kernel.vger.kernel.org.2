Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A436BD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhD0CqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:46:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0CqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:46:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FTmJ54s1Mzmdsx;
        Tue, 27 Apr 2021 10:42:13 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.183) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 27 Apr 2021 10:45:09 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>
CC:     <valentin.schneider@arm.com>, <juri.lelli@redhat.com>,
        <bristot@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, <guodong.xu@linaro.org>,
        <yangyicong@huawei.com>, <liguozhu@hisilicon.com>,
        <linuxarm@openeuler.org>, <wanghuiqiang@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Yongjia Xie" <xieyongjia1@huawei.com>
Subject: [PATCH] sched/fair: don't use waker's cpu if the waker of sync wake-up is interrupt
Date:   Tue, 27 Apr 2021 14:37:58 +1200
Message-ID: <20210427023758.4048-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.183]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a severe qperf performance decrease was reported in the below use case:
For a hardware with 2 NUMA nodes, node0 has cpu0-31, node1 has cpu32-63.
Ethernet is located in node1.

Run the below commands:
$ taskset -c 32-63 stress -c 32 &
$ qperf 192.168.50.166 tcp_lat
tcp_lat:
	latency = 2.95ms.
Normally the latency should be less than 20us. But in the above test,
latency increased dramatically to 2.95ms.

This is caused by ping-pong of qperf between node0 and node1. Since it
is a sync wake-up and waker's nr_running == 1, WAKE_AFFINE will pull
qperf to node1, but LB will soon migrate qperf back to node0.
Not like a normal sync wake-up coming from a task, the waker in the above
test is an interrupt and nr_running happens to be 1 since stress starts
32 threads on node1 with 32 cpus.

Testing also shows the performance of qperf won't drop if the number
of threads are increased to 64, 96 or larger values:
$ taskset -c 32-63 stress -c 96 &
$ qperf 192.168.50.166 tcp_lat
tcp_lat:
	latency = 14.7us.

Obviously "-c 96" makes "cpu_rq(this_cpu)->nr_running == 1" false in
wake_affine_idle() so WAKE_AFFINE won't pull qperf to node1.

To fix this issue, this patch checks the waker of sync wake-up is a task
but not an interrupt. In this case, the waker will schedule out and give
CPU to wakee.

Reported-by: Yongjia Xie <xieyongjia1@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb2d40..8ad2d732033d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5829,7 +5829,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
+	/*
+	 * If this is a sync wake-up and the only running thread is just
+	 * waker, thus, waker is not interrupt, we assume wakee will get
+	 * the cpu of waker soon
+	 */
+	if (sync && cpu_rq(this_cpu)->nr_running == 1 && in_task())
 		return this_cpu;
 
 	if (available_idle_cpu(prev_cpu))
-- 
2.25.1

