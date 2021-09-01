Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B113FD4AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhIAHoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:44:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18998 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242845AbhIAHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:43:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gzwt15BSvzbl6q;
        Wed,  1 Sep 2021 15:39:05 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 15:43:01 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 15:43:00 +0800
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     Tejun Heo <tj@kernel.org>
CC:     <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <vincent.guittot@linaro.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
 <YS60T2bfLpxb6SUY@slm.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Message-ID: <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
Date:   Wed, 1 Sep 2021 15:43:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YS60T2bfLpxb6SUY@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello,tejun.

ÔÚ 2021/9/1 6:59, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Tue, Aug 31, 2021 at 03:58:42PM +0800, Zhang Qiao wrote:
>>> I think this would allow cgroup migrations to take place before
>>> sched_post_fork() is run, which likely will break stuff. The right

cgroup migrations? Do you mean child process set its cgroups at
cgroup_subsys->fork()?

>>> thing to do likely is taking sched_task_group (and whatever other
>>> fields) after cgroup_can_fork(), which fixates the cgroup memberships,
>>
>> But it still seems possible that it accessed an invalid sched_task_group?
>> because the child process does not update its sched_task_group util
>> cgroup_post_fork().
> 
> Between cgroup_can_fork() and cgroup_post_fork(), the cgroup membership and
> thus sched_task_group can't change, so if the child sets it to the parent's
> inbetween, the sched_task_group can't go away.

so the child just need to update its sched_task_group after cgroup_can_fork(),
then call sched_fork(), is it right?

thanks.

--
Qiao Zhang.
> 
> Thanks.
> 
