Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADE45DA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354931AbhKYMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:52:06 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15867 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbhKYMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:58 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0HgF6cpYz91MJ;
        Thu, 25 Nov 2021 20:46:17 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 20:46:45 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 25 Nov 2021 20:46:44 +0800
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
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <22f0f0b0-d29e-d142-6854-2effbe4648f1@hisilicon.com>
Date:   Thu, 25 Nov 2021 20:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20211125111731.GE3301@suse.de>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/25 19:17, Mel Gorman wrote:
> On Wed, Nov 24, 2021 at 04:54:01PM +0800, Yicong Yang wrote:
>> Commit 56498cfb045d noticed that "When select_idle_cpu starts scanning for
>> an idle CPU, it starts with a target CPU that has already been checked
>> by select_idle_sibling. This patch starts with the next CPU instead."
>> It only changed the scanning start cpu to target + 1 but still leave
>> the target in the scanning cpumask. The target still have a chance to be
>> checked in the last turn. Fix this by clear the target from the cpus
>> to scan.
>>
>> Fixes: 56498cfb045d ("sched/fair: Avoid a second scan of target in select_idle_cpu")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Did you check the performance of this? When I tried something like this
> in a different context, I found that the cost of clearing the bit was
> more expensive than simply using target + 1. For the target to be
> rescanned, the whole mask would have to be scanned as no other CPUs are
> idle which is the unlikely case. By clearing the bit, a cost is always
> incurred even if the first CPU scanned is idle.
> 

Not yet, it's from code. I've launched some tests and we'll see the results tomorrow.

We traced the scanning here and seems the case that scan the whole LLC without
finding an idle cpu has some proportion. On 4-NUMA 128-Core Kunpeng 920 server
tested with mysql, there is ~1% probability for not finding and idle cpu when
sysbench threads is 128. The probability will increase when the load increases.
