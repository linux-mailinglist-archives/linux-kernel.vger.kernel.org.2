Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF53FB4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhH3LvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:51:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9386 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhH3LvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:51:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GypRd0b3wz8wdG;
        Mon, 30 Aug 2021 19:45:49 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 19:50:02 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 19:49:55 +0800
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
In-Reply-To: <20210826112635.7404-1-zhangqiao22@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Message-ID: <be26ef62-1e35-c2d6-c01a-6f77b16b2660@huawei.com>
Date:   Mon, 30 Aug 2021 19:49:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/26 19:26, Zhang Qiao wrote:
> There is a small race between copy_process() and sched_fork()
> where child->sched_task_group point to an already freed pointer.
> 
> parent doing fork()      | someone moving the parent
> 				to another cgroup
> -------------------------------+-------------------------------
> copy_process()
>     + dup_task_struct()<1>
> 				parent move to another cgroup,
> 				and free the old cgroup. <2>
>     + sched_fork()
>       + __set_task_cpu()<3>
>       + task_fork_fair()
>         + sched_slice()<4>
> 
> In the worst case, this bug can lead to "use-after-free" and
> cause panic as shown above,
> (1)parent copy its sched_task_group to child at <1>;
> (2)someone move the parent to another cgroup and free the old
>    cgroup at <2>;
> (3)the sched_task_group and cfs_rq that belong to the old cgroup
>    will be accessed at <3> and <4>, which cause a panic:
> 
> [89249.732198] BUG: unable to handle kernel NULL pointer
> dereference at 0000000000000000
> [89249.732701] PGD 8000001fa0a86067 P4D 8000001fa0a86067 PUD
> 2029955067 PMD 0
> [89249.733005] Oops: 0000 [#1] SMP PTI
> [89249.733288] CPU: 7 PID: 648398 Comm: ebizzy Kdump: loaded
> Tainted: G           OE    --------- -  - 4.18.0.x86_64+ #1
> [89249.734318] RIP: 0010:sched_slice+0x84/0xc0
>  ....
> [89249.737910] Call Trace:
> [89249.738181]  task_fork_fair+0x81/0x120
> [89249.738457]  sched_fork+0x132/0x240
> [89249.738732]  copy_process.part.5+0x675/0x20e0
> [89249.739010]  ? __handle_mm_fault+0x63f/0x690
> [89249.739286]  _do_fork+0xcd/0x3b0
> [89249.739558]  do_syscall_64+0x5d/0x1d0
> [89249.739830]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [89249.740107] RIP: 0033:0x7f04418cd7e1
> 
> When a new process is forked, cgroup_post_fork() associates it
> with the cgroup of its parent. Therefore this commit move the
> __set_task_cpu() and task_fork() that access some cgroup-related
> fields(sched_task_group and cfs_rq) to sched_post_fork() and
> call sched_post_fork() after cgroup_post_fork().
> 
> Fixes: 8323f26ce342 ("sched: Fix race in task_group")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
hello, a gentle ping to confirm whether this gets a review or not.

thanks,

Qiao.

> ---
>  kernel/fork.c       |  2 +-
>  kernel/sched/core.c | 33 +++++++++++++--------------------
>  2 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bc94b2cc5995..a4acd87f00f9 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2330,8 +2330,8 @@ static __latent_entropy struct task_struct *copy_process(
>  	write_unlock_irq(&tasklist_lock);
>  
>  	proc_fork_connector(p);
> -	sched_post_fork(p);
>  	cgroup_post_fork(p, args);
> +	sched_post_fork(p);
>  	perf_event_fork(p);
>  
>  	trace_task_newtask(p, clone_flags);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..041f21e8b266 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4069,8 +4069,6 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
>   */
>  int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  {
> -	unsigned long flags;
> -
>  	__sched_fork(clone_flags, p);
>  	/*
>  	 * We mark the process as NEW here. This guarantees that
> @@ -4116,24 +4114,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  
>  	init_entity_runnable_average(&p->se);
>  
> -	/*
> -	 * The child is not yet in the pid-hash so no cgroup attach races,
> -	 * and the cgroup is pinned to this child due to cgroup_fork()
> -	 * is ran before sched_fork().
> -	 *
> -	 * Silence PROVE_RCU.
> -	 */
> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
> -	rseq_migrate(p);
> -	/*
> -	 * We're setting the CPU for the first time, we don't migrate,
> -	 * so use __set_task_cpu().
> -	 */
> -	__set_task_cpu(p, smp_processor_id());
> -	if (p->sched_class->task_fork)
> -		p->sched_class->task_fork(p);
> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> -
>  #ifdef CONFIG_SCHED_INFO
>  	if (likely(sched_info_on()))
>  		memset(&p->sched_info, 0, sizeof(p->sched_info));
> @@ -4151,6 +4131,19 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  
>  void sched_post_fork(struct task_struct *p)
>  {
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	rseq_migrate(p);
> +	/*
> +	 * We're setting the CPU for the first time, we don't migrate,
> +	 * so use __set_task_cpu().
> +	 */
> +	__set_task_cpu(p, smp_processor_id());
> +	if (p->sched_class->task_fork)
> +		p->sched_class->task_fork(p);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +
>  	uclamp_post_fork(p);
>  }
>  
> 
