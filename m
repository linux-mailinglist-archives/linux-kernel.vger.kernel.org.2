Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2C3FC405
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhHaIAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:00:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14439 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhHaH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:59:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzKGc31y1zbft8;
        Tue, 31 Aug 2021 15:54:48 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 15:58:43 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 15:58:42 +0800
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     Tejun Heo <tj@kernel.org>, <peterz@infradead.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
CC:     <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <vincent.guittot@linaro.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
Message-ID: <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
Date:   Tue, 31 Aug 2021 15:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, thanks for your reviews.

On 2021/8/31 1:32, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 30, 2021 at 04:39:54PM +0200, Peter Zijlstra wrote:
>>> When a new process is forked, cgroup_post_fork() associates it
>>> with the cgroup of its parent. Therefore this commit move the
>>> __set_task_cpu() and task_fork() that access some cgroup-related
>>> fields(sched_task_group and cfs_rq) to sched_post_fork() and
>>> call sched_post_fork() after cgroup_post_fork().
> 
> I think this would allow cgroup migrations to take place before
> sched_post_fork() is run, which likely will break stuff. The right
> thing to do likely is taking sched_task_group (and whatever other
> fields) after cgroup_can_fork(), which fixates the cgroup memberships,
But it still seems possible that it accessed an invalid sched_task_group?
because the child process does not update its sched_task_group util
cgroup_post_fork().
> is run. For other controllers, operations like this would be performed
> from cgroup_subsys->fork() callback but it's tricky for sched due to
> autogroup.
> 
>>> Fixes: 8323f26ce342 ("sched: Fix race in task_group")
>>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>>
>> Hmm, I think you're right. Did something recently chagne in cgroup land
>> to make this more visible? This code hasn't changed in like 9 years.
I think this problem has always existed. I've reproduced it in multiple versions,
including 3.10 and 5.14-rc3.

> 
> I can't think of any remotely recent change either. I guess ppl just
> don't try to migrate the parent while fork is in progress.
> 
> Thanks.
> 

thandks.
