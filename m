Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3FC3FEA1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbhIBHnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:43:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9394 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhIBHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:43:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H0XpS0G41z8xfg;
        Thu,  2 Sep 2021 15:38:08 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 15:42:15 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 15:42:15 +0800
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
 <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
 <YS+uEmQRmQqAbkmG@slm.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Message-ID: <3df62791-d123-db9b-ec9c-092c47a941cc@huawei.com>
Date:   Thu, 2 Sep 2021 15:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YS+uEmQRmQqAbkmG@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/9/2 0:45, Tejun Heo 写道:
> Hello,
> 
> On Wed, Sep 01, 2021 at 03:43:00PM +0800, Zhang Qiao wrote:
>> 在 2021/9/1 6:59, Tejun Heo 写道:
>>> On Tue, Aug 31, 2021 at 03:58:42PM +0800, Zhang Qiao wrote:
>>>>> I think this would allow cgroup migrations to take place before
>>>>> sched_post_fork() is run, which likely will break stuff. The right
>>
>> cgroup migrations? Do you mean child process set its cgroups at
>> cgroup_subsys->fork()?
> 
> As soon as cgroup_post_fork() is complete, userspace can try moving the
> process to a different cgroup which can get confusing for sched_post_fork.

hello,tejun

I checked the code again.
I don't quite understand what you said, if the child be moved between
cgroup_post_fork() and sched_post_sched(), what problems might it cause?
Does the child process will use the old sched_task_group at sched_post_fork()-->__set_task_cpu()?
Or there are other problems, Can you talk in more detail?

thanks!

---
Qiao Zhang
> 
>>> Between cgroup_can_fork() and cgroup_post_fork(), the cgroup membership and
>>> thus sched_task_group can't change, so if the child sets it to the parent's
>>> inbetween, the sched_task_group can't go away.
>>
>> so the child just need to update its sched_task_group after cgroup_can_fork(),
>> then call sched_fork(), is it right?
> 
> Yeah, the bug here is that a field which is dependent on cgroup membership
> is being read before the cgroup membership is fixated.
> 
> Thanks.
> 
