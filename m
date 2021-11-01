Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB134441A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhKALTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:19:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26142 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKALTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:19:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HjVmW2lJmz1DJ5G;
        Mon,  1 Nov 2021 19:14:35 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 19:16:37 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 19:16:37 +0800
Subject: Re: [QUESTION] oom killed the key system process triggered by a bad
 process alloc memory with MAP_LOCKED
To:     Michal Hocko <mhocko@suse.com>
CC:     <rientjes@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <penguin-kernel@i-love.sakura.ne.jp>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
References: <cc85a520-804c-35cc-c7d7-b9999c0671fe@huawei.com>
 <YX+kMpr/fvmMW7hy@dhcp22.suse.cz>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <2f368ad4-6a7f-798d-11c1-369eed757bb0@huawei.com>
Date:   Mon, 1 Nov 2021 19:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YX+kMpr/fvmMW7hy@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/11/1 16:24, Michal Hocko 写道:
> Hi,
>
> On Mon 01-11-21 16:05:50, Yongqiang Liu wrote:
> [...]
>> And we found that when the oom_reaper is done but the memory is still high:
>>
>> [   45.115685] Out of memory: Killed process 2553 (oom) total-vm:953404kB,
>> anon-rss:947748kB, file-rss:388kB, shmem-rss:0kB, UID:0 pgtables:1896kB
>> oom_score_adj:1000
>> [   45.115739] oom_reaper: reaped process 2553 (oom), now anon-rss:947708kB,
>> file-rss:0kB, shmem-rss:0kB
>>
>> This is because the bad proccess which recieved SIGKILL is unlocking the mem
>> to exit which needs more time. And the next oom is triggered to kill the
>> other system process.
> Yes, this is a known limitation of the oom_reaper based OOM killing.
> __oom_reap_task_mm has to skip over mlocked memory areas because
> munlocking requires some locking (or at least that was the case when the
> oom reaper was introduced) and the primary purpose of the oom_reaper is
> to guarantee a forward progress.
>
> Addressing that limitation would require the munlock operation to not
> depend on any locking. I am not sure how much work that would be with
> the current code. Until now this was not a high priority because
> processes with a high mlock limit should be really trusted with their
> memory consumption so they shouldn't be really the primary oom killer
> target.
>
> Are you seeing this problem happening with a real workload or is this
> only triggered with some artificial tests? E.g. LTP oom tests are known
> to trigger this situation but they do not represent any real workload.

I haven't found it in real workload yet. It's just a testcase.

--

Yongqiang Liu

