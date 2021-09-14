Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5B40A75A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbhINH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:28:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16196 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhINH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:28:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H7vz70VJyz1DGxZ;
        Tue, 14 Sep 2021 15:26:11 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 15:27:10 +0800
Received: from [127.0.0.1] (10.69.38.196) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 14
 Sep 2021 15:27:09 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
Subject: [RFC] Perfomance varies according to sysctl_sched_migration_cost
To:     <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <21cnbao@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
Date:   Tue, 14 Sep 2021 15:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed that some benchmark performance varies after tunning the sysctl_sched_migration_cost
through /sys/kernel/debug/sched/migration_cost_ns on arm64. The default value is 500000, and
I tried 10000, 100000, 1000000. Below are some results from mmtests, based on 5.14-release.

On Kunpeng920 (128cores, 4numa, 2socket):

pgbench (config-db-pgbench-timed-ro-medium)
                     mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
Hmean     1       9558.99 (   0.00%)     9735.31 *   1.84%*     9410.84 *  -1.55%*     9602.47 *   0.45%*
Hmean     8      17615.90 (   0.00%)    17439.78 *  -1.00%*    18056.44 *   2.50%*    19222.18 *   9.12%*
Hmean     12     25228.38 (   0.00%)    25592.69 *   1.44%*    26739.06 *   5.99%*    27575.48 *   9.30%*
Hmean     24     46623.27 (   0.00%)    48853.30 *   4.78%*    47386.02 *   1.64%*    48542.94 *   4.12%*
Hmean     32     60578.78 (   0.00%)    62116.81 *   2.54%*    59961.36 *  -1.02%*    58681.07 *  -3.13%*
Hmean     48     68159.12 (   0.00%)    67867.90 (  -0.43%)    65631.79 *  -3.71%*    66487.16 *  -2.45%*
Hmean     80     66894.87 (   0.00%)    73440.92 *   9.79%*    68751.63 *   2.78%*    67326.70 (   0.65%)
Hmean     112    68582.27 (   0.00%)    65339.90 *  -4.73%*    68454.99 (  -0.19%)    67211.66 *  -2.00%*
Hmean     144    76290.98 (   0.00%)    70455.65 *  -7.65%*    64851.23 * -14.99%*    64940.61 * -14.88%*
Hmean     172    63245.68 (   0.00%)    68790.24 *   8.77%*    66246.46 *   4.74%*    69536.96 *   9.95%*
Hmean     204    61793.47 (   0.00%)    63711.62 *   3.10%*    66055.64 *   6.90%*    58023.20 *  -6.10%*
Hmean     236    61486.75 (   0.00%)    68404.44 *  11.25%*    70499.70 *  14.66%*    58285.67 *  -5.21%*
Hmean     256    57476.13 (   0.00%)    65645.83 *  14.21%*    69437.05 *  20.81%*    60518.05 *   5.29%*

tbench (config-network-tbench)
                     mig-cost-500000        mig-cost-100000         mig-cost-10000       mig-cost-1000000
Hmean     1        333.12 (   0.00%)      332.93 (  -0.06%)      335.34 *   0.67%*      334.36 *   0.37%*
Hmean     2        665.88 (   0.00%)      667.19 *   0.20%*      666.47 *   0.09%*      667.02 *   0.17%*
Hmean     4       1324.10 (   0.00%)     1312.23 *  -0.90%*     1313.07 *  -0.83%*     1315.13 *  -0.68%*
Hmean     8       2618.85 (   0.00%)     2602.00 *  -0.64%*     2577.49 *  -1.58%*     2600.48 *  -0.70%*
Hmean     16      5100.74 (   0.00%)     5068.80 *  -0.63%*     5041.34 *  -1.16%*     5069.78 *  -0.61%*
Hmean     32      8157.22 (   0.00%)     8163.50 (   0.08%)     7936.25 *  -2.71%*     8329.18 *   2.11%*
Hmean     64      4824.56 (   0.00%)     4890.81 *   1.37%*     5319.97 *  10.27%*     4830.68 *   0.13%*
Hmean     128     4635.17 (   0.00%)     6810.90 *  46.94%*     5304.36 *  14.44%*     4516.06 *  -2.57%*
Hmean     256     8816.62 (   0.00%)     8851.28 *   0.39%*     8448.76 *  -4.17%*     6840.12 * -22.42%*
Hmean     512     7825.56 (   0.00%)     8538.04 *   9.10%*     8002.77 *   2.26%*     7946.54 *   1.55%*

Also on Raspberrypi 4B:

pgbench (config-db-pgbench-timed-ro-medium)
                   mig-cost-500000        mig-cost-100000
Hmean     1     1651.41 (   0.00%)     3444.27 * 108.56%*
Hmean     4     4015.83 (   0.00%)     6883.21 *  71.40%*
Hmean     7     4161.45 (   0.00%)     6646.18 *  59.71%*
Hmean     8     4277.28 (   0.00%)     6764.60 *  58.15%*

For tbench on Raspberrypi 4B and both pgbench and tbench on x86, tuning sysctl_sched_migration_cost
doesn't have such huge difference and will have some degradations (max -8% on x86 for pgbench) in some cases.

The sysctl_sched_migration_cost will affects the frequency of load balance. It will affect
directly in task_hot() and newidle_balance() to decide whether we can do a migration or load
balance. And affects other parameters like rq->avg_idle, rq->max_idle_balance_cost and
sd->max_newidle_lb_cost to indirectly affect the load balance process. These parameters record
the load_balance() cost and will be limited up to sysctl_sched_migration_cost, so I measure
the average cost of load_balance() on Kunpeng920 with bcc tools(./funclantency load_balance -d 10):

system status   idle   50%load  100%load
avg cost      3160ns    4790ns    7563ns

The average cost of load balance seems quite smaller than the default sysctl_sched_migration_cost
which is 500000(500ms).

So I have some RFC questions:
1. how is the default 500000 (500ms) migration cost is measured or caculated?
   The value has never changed in the past decade. I dig into the git commits and find it was introduced
   in da84d9617672 ("sched: reintroduce cache-hot affinity"). But it didn't explain how did this value come.
2. The ABI now has been removed from sysctl and moved to debugfs. As tuning this can improve the performance
   of some workloads on some platforms, maybe it's better to make it a formal sysctl again with docs?

I'll be appreciated for any comments and replies!

Thanks,
Yicong


