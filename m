Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF346439705
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhJYNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:06:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhJYNGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CEA6D6E;
        Mon, 25 Oct 2021 06:04:26 -0700 (PDT)
Received: from [172.29.15.235] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA67B3F5A1;
        Mon, 25 Oct 2021 06:04:23 -0700 (PDT)
Subject: Re: [RFC PATCH] sched/fair: use max_spare_cap_cpu if it is more
 energy efficient
To:     Xuewen Yan <xuewen.yan94@gmail.com>, brookxu <brookxu.cn@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1634804594-4163-1-git-send-email-brookxu.cn@gmail.com>
 <CAB8ipk_1-ZMMcaLiLGYBT3N3S_VdeGMhYmCqGytcAwmPE4Ni2g@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d51b64b2-8efc-898b-d836-2917b5cf2d85@arm.com>
Date:   Mon, 25 Oct 2021 15:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk_1-ZMMcaLiLGYBT3N3S_VdeGMhYmCqGytcAwmPE4Ni2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2021 06:05, Xuewen Yan wrote:
> Hi Chunguang
> 
> brookxu <brookxu.cn@gmail.com> 于2021年10月21日周四 下午4:24写道：
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> When debugging EAS, I found that if the task is migrated to
>> max_spare_cap_cpu, even if the power consumption of pd is lower,

The task p hasn't been migrated yet. `max_spare_cap_cpu` here is only a
potential candidate CPU to be selected for p.

>> we still put the task on prev_cpu. Maybe we should fix it.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>  kernel/sched/fair.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ff69f245b939..2ae7e03de6d2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6867,8 +6867,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
>>                 if (max_spare_cap_cpu >= 0) {
>>                         cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
>> -                       if (cur_delta < base_energy_pd)
> 
> this is aimed to prevent the cur_delta < 0, and usuallly, when the
> task was put on the max_spare_cpu, the cur_power should be bigger than
> base_pd_power,
> if the cur_power < base_pd_power, the cpu util may have changed, at
> this time, we should keep prev_cpu.
> 
> You can look at below discuss and patch:
> https://lore.kernel.org/all/20210429101948.31224-3-Pierre.Gondois@arm.com/
> https://lore.kernel.org/all/CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com/

That's correct. `prev_delta < base_energy_pd` or `cur_delta <
base_energy_pd` indicate the rare case that `compute_energy() { ->
cpu_util_next() -> cpu util }` returns a higher energy value for the
perf domain w/o the task p than w/ it.

`base_energy_pd` stands for the energy spend on the CPUs of the Perf
Domain (PD) w/o considering the task p (compute_energy(p, *-1*, pd)),
`dst_cpu == -1`.

If this happens to a candidate CPU (prev_cpu or a per-PD
max_spare_cap_cpu) we bail out and return target (i.e. prev_cpu) because
we can't compare the energy values (prev_delta and best_delta) later on
in this case.

[...]
