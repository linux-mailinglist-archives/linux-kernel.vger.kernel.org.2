Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB245EA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbhKZJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:43:35 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14985 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348494AbhKZJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:41:34 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J0qNw75PlzZdHN;
        Fri, 26 Nov 2021 17:35:44 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 17:38:19 +0800
CC:     <yangyicong@hisilicon.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        "shenyang (M)" <shenyang39@huawei.com>
Subject: Re: [PATCH] sched/fair: Clear target from cpus to scan in
 select_idle_cpu
To:     Mel Gorman <mgorman@suse.de>
References: <20211124085401.14411-1-yangyicong@hisilicon.com>
 <20211125111731.GE3301@suse.de>
 <22f0f0b0-d29e-d142-6854-2effbe4648f1@hisilicon.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <adef59de-dfc1-d57a-48c5-7cc6370f88c0@hisilicon.com>
Date:   Fri, 26 Nov 2021 17:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <22f0f0b0-d29e-d142-6854-2effbe4648f1@hisilicon.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/25 20:46, Yicong Yang wrote:
> On 2021/11/25 19:17, Mel Gorman wrote:
>> On Wed, Nov 24, 2021 at 04:54:01PM +0800, Yicong Yang wrote:
>>> Commit 56498cfb045d noticed that "When select_idle_cpu starts scanning for
>>> an idle CPU, it starts with a target CPU that has already been checked
>>> by select_idle_sibling. This patch starts with the next CPU instead."
>>> It only changed the scanning start cpu to target + 1 but still leave
>>> the target in the scanning cpumask. The target still have a chance to be
>>> checked in the last turn. Fix this by clear the target from the cpus
>>> to scan.
>>>
>>> Fixes: 56498cfb045d ("sched/fair: Avoid a second scan of target in select_idle_cpu")
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Did you check the performance of this? When I tried something like this
>> in a different context, I found that the cost of clearing the bit was
>> more expensive than simply using target + 1. For the target to be
>> rescanned, the whole mask would have to be scanned as no other CPUs are
>> idle which is the unlikely case. By clearing the bit, a cost is always
>> incurred even if the first CPU scanned is idle.
>>
> 
> Not yet, it's from code. I've launched some tests and we'll see the results tomorrow.
> 
> We traced the scanning here and seems the case that scan the whole LLC without
> finding an idle cpu has some proportion. On 4-NUMA 128-Core Kunpeng 920 server
> tested with mysql, there is ~1% probability for not finding and idle cpu when
> sysbench threads is 128. The probability will increase when the load increases.
> .
> 

Hi Mel,

I tested hackbench and tbench on our machine with
numactl -N 0 run-mmtests.sh -c $config

config-workload-hackbench-process-pipes
                          5.16-rc1         5.16-rc1+patch
Amean     1       0.5178 (   0.00%)      0.5207 (  -0.56%)
Amean     4       1.0108 (   0.00%)      0.9274 (   8.25%)
Amean     7       1.9349 (   0.00%)      1.8508 (   4.35%)
Amean     12      3.4179 (   0.00%)      3.3170 (   2.95%)
Amean     21      5.9209 (   0.00%)      5.8878 (   0.56%)
Amean     30      6.8677 (   0.00%)      6.6241 *   3.55%*
Amean     48     10.3759 (   0.00%)      9.5785 *   7.69%*
Amean     64     13.4606 (   0.00%)     12.3713 *   8.09%*

config-network-tbench
                            5.16-rc1         5.16-rc1+patch
Hmean     1        324.56 (   0.00%)      324.01 *  -0.17%*
Hmean     2        650.91 (   0.00%)      646.89 *  -0.62%*
Hmean     4       1291.16 (   0.00%)     1298.56 *   0.57%*
Hmean     8       2625.06 (   0.00%)     2615.81 *  -0.35%*
Hmean     16      5293.86 (   0.00%)     5267.24 *  -0.50%*
Hmean     32      8464.34 (   0.00%)     9578.40 *  13.16%*
Hmean     64      7417.02 (   0.00%)     7218.91 *  -2.67%*
Hmean     128     6313.71 (   0.00%)     6180.67 *  -2.11%*

Thanks.
