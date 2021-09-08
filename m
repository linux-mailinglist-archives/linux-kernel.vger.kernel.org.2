Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF04038C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbhIHLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:33:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15394 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhIHLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:33:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4Kd20KKczQmXZ;
        Wed,  8 Sep 2021 19:28:06 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 19:32:06 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 19:32:06 +0800
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
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <YTea0kK9yL5+GoKt@slm.duckdns.org>
Message-ID: <be0bdf5a-479c-51bb-6d51-42739c11710d@huawei.com>
Date:   Wed, 8 Sep 2021 19:32:06 +0800
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



On 2021/9/8 1:01, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 02, 2021 at 03:42:15PM +0800, Zhang Qiao wrote:
>> I checked the code again.
>> I don't quite understand what you said, if the child be moved between
>> cgroup_post_fork() and sched_post_sched(), what problems might it cause?
> 
> cgroup_post_fork() is where the child's creation is committed from cgroup's
> POV, so it'd be migrating cgroups before the initial creation is finished.
>>From glancing, looks like it'll break css_set task counts to begin with.
> This violates the basic assumptions and can cause critical failures in
> subtle ways. The would replace one subtle race with a possibly worse one.

Hello,

I will update this patch by following the steps below:
1)rename cgroup_subsys->fork() to cgroup_subsys->post_fork();
2)add cgroup_subsys->fork() and the cpu_cgroup_fork() callback like this:

void cpu_cgroup_fork(struct task_struct *task) {
....
	p->sched_task_group = task_group(current);
	__set_task_cpu(p, smp_processor_id());
	if (p->sched_class->task_fork)
		p->sched_class->task_fork(p);
....


3)call cgroup_subsys->fork() after cgroup_can_fork().

Do you have any suggestion?
thanks.

Zhang Qiao

> 
> Thanks.
> 
