Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5462E4047F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhIIJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:46:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9022 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:46:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4vGw3VLwzVh3h;
        Thu,  9 Sep 2021 17:44:24 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 17:45:17 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 17:45:17 +0800
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     Tejun Heo <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
 <YS60T2bfLpxb6SUY@slm.duckdns.org>
 <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
 <YS+uEmQRmQqAbkmG@slm.duckdns.org>
 <3df62791-d123-db9b-ec9c-092c47a941cc@huawei.com>
 <YTea0kK9yL5+GoKt@slm.duckdns.org>
 <be0bdf5a-479c-51bb-6d51-42739c11710d@huawei.com>
 <YTjk8oiFa5EfDPn9@slm.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <YTjk8oiFa5EfDPn9@slm.duckdns.org>
Message-ID: <3036e192-20ba-4345-66e6-14fa8b765d59@huawei.com>
Date:   Thu, 9 Sep 2021 17:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/9/9 0:29, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Wed, Sep 08, 2021 at 07:32:06PM +0800, Zhang Qiao wrote:
>> I will update this patch by following the steps below:
>> 1)rename cgroup_subsys->fork() to cgroup_subsys->post_fork();
>> 2)add cgroup_subsys->fork() and the cpu_cgroup_fork() callback like this:
>>
>> void cpu_cgroup_fork(struct task_struct *task) {
>> ....
>> 	p->sched_task_group = task_group(current);
>> 	__set_task_cpu(p, smp_processor_id());
>> 	if (p->sched_class->task_fork)
>> 		p->sched_class->task_fork(p);
>> ....
>>
>>
>> 3)call cgroup_subsys->fork() after cgroup_can_fork().
>>
>> Do you have any suggestion?
> 
> I'm not following why it needs to shuffle the callbacks. Can't you just
Just to provide a placeholder to call task_fork(). But thought about it,
there are indeed some problems with this modification.

Thanks.

Zhang Qiao

> relocate the fectching of task_group after can_fork?>
> Thanks.
> 
