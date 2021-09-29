Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB741C4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbhI2Mk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:40:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:23235 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbhI2MkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:40:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HKG9l6DwPz8tY6;
        Wed, 29 Sep 2021 20:37:47 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 20:38:39 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 20:38:39 +0800
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: [QUESTION] ltp: mavise06 failed when the task scheduled to another
 cpu
To:     <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <",sjenning"@redhat.com>, <xuyang2018.jy@fujitsu.com>,
        <",liwang"@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <",linux-mm"@kvack.org>
Message-ID: <575ae411-08d8-7d92-105f-2d9574b3f542@huawei.com>
Date:   Wed, 29 Sep 2021 20:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when runing this case in 5.10-lts kernel, it will trigger the folloing 
failure:

  ......

     madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 1752 Kb
     madvise06.c:208: TPASS: more than 102400 Kb were moved to the swap 
cache
     madvise06.c:217: TINFO: PageFault(madvice / no mem access): 102401
     madvise06.c:221: TINFO: PageFault(madvice / mem access): 102417
     madvise06.c:82: TINFO: After page access
     madvise06.c:84: TINFO:  Swap: 307372 Kb
     madvise06.c:86: TINFO:  SwapCached: 101820 Kb
     madvise06.c:88: TINFO:  Cached: 103004Kb
     madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 0Kb
     madvise06.c:225: TFAIL: 16 pages were faulted out of 2 max

and we found that when we call the madvise the task was scheduled to 
another cpu:

......

tst_res(TINFO, "before madvise MEMLIMIT CPU:%d", sched_getcpu());--->cpu0

TEST(madvise(target, MEM_LIMIT, MADV_WILLNEED));

tst_res(TINFO, "after madvise MEMLIMIT CPU:%d", sched_getcpu());--->cpu1

......

tst_res(TINFO, "before madvise PASS_THRESHOLDCPU:%d", 
sched_getcpu());-->cpu1

TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));

tst_res(TINFO, "after madvise PASS_THRESHOLDCPU:%d", sched_getcpu());-->cpu0

.....

Is the PERCPU data swap_slot was not handled well?


with the following patch almost fix the error:

e9b9734b7465 sched/fair: Reduce cases for active balance

8a41dfcda7a3 sched/fair: Don't set LBF_ALL_PINNED unnecessarily

fc488ffd4297 sched/fair: Skip idle cfs_rq

but bind the task to a cpu also can solve this problem.

Kind regards,

Yongqiang Liu

