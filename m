Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A226322E05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBWPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:53:17 -0500
Received: from foss.arm.com ([217.140.110.172]:57136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233427AbhBWPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:52:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078841FB;
        Tue, 23 Feb 2021 07:51:39 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7351A3F70D;
        Tue, 23 Feb 2021 07:51:37 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     syzbot <syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, luto@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in load_balance
In-Reply-To: <CAKfTPtAkzDWfqAP=Fb+4B+PBUNN_7oTdZ3Cs+wLdfrJNa_ymTQ@mail.gmail.com>
References: <000000000000a43f1f05bbefe703@google.com> <jhjlfbfhty2.mognet@arm.com> <CAKfTPtAkzDWfqAP=Fb+4B+PBUNN_7oTdZ3Cs+wLdfrJNa_ymTQ@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 23 Feb 2021 15:51:29 +0000
Message-ID: <jhj4ki27pfi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 14:45, Vincent Guittot wrote:
> On Tue, 23 Feb 2021 at 13:03, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>>
>> +Vincent
>>
>> On 22/02/21 09:12, syzbot wrote:
>> > syzbot has found a reproducer for the following issue on:
>> >
>> > HEAD commit:    31caf8b2 Merge branch 'linus' of git://git.kernel.org/pub/..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=16ab2682d00000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b81388f0b32761d4
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=d7581744d5fd27c9fbe1
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1277457f500000
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com
>> >
>> > ================================================================================
>> > UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7712:14
>> > shift exponent 149 is too large for 64-bit type 'long unsigned int'
>>
>> That 149 is surprising.
>
> Yes, surprising. But is it really a problem in itself  ? shifting left
>  would be a problem because of the overflow but here we shift right to
> divide and the result is correct
>

I would tend to think so, but the UB seems to apply regardless of the
shifting direction:

"""
If the value of the right operand is negative or is greater than or equal
to the width of the promoted left operand, the behavior is undefined.
"""

> Beside this, it seems that a significant number of previous attempts
> to balance load has been done with another migration_type otherwise it
> would  have raised a problem earlier (at 65) if previous LB were also
> migration_load. It would be good to understand why the 148 previous
> ones failed
>
>>
>> sd->cache_nice_tries is \in {1, 2}, and sd->nr_balanced_failed should be in
>> the same ballpark.
>>
>> A successful load_balance() resets it to 0; a failed one increments
>> it. Once it gets to sd->cache_nice_tries + 3, this should trigger an active
>> balance, which will either set it to sd->cache_nice_tries+1 or reset it to
>> 0. There is this one condition that could let it creep up uncontrollably:
>>
>>   /*
>>    * Don't kick the active_load_balance_cpu_stop,
>>    * if the curr task on busiest CPU can't be
>>    * moved to this_cpu:
>>    */
>>   if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
>>           raw_spin_unlock_irqrestore(&busiest->lock,
>>                                       flags);
>>           goto out_one_pinned;
>>   }
>>
>> So despite the resulting sd->balance_interval increase, repeatedly hitting
>> this might yield the above. Would we then want something like this?
>>
>> ---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8a8bd7b13634..b65c24b5ae91 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7422,6 +7422,11 @@ struct lb_env {
>>         struct list_head        tasks;
>>  };
>>
>> +static inline unsigned int sd_balance_failed_cap(struct sched_domain *sd)
>> +{
>> +       return sd->cache_nice_tries + 3;
>> +}
>> +
>>  /*
>>   * Is this task likely cache-hot:
>>   */
>> @@ -9493,7 +9498,7 @@ imbalanced_active_balance(struct lb_env *env)
>>          * threads on a system with spare capacity
>>          */
>>         if ((env->migration_type == migrate_task) &&
>> -           (sd->nr_balance_failed > sd->cache_nice_tries+2))
>> +           (sd->nr_balance_failed >= sd_balance_failed_cap(sd)))
>>                 return 1;
>>
>>         return 0;
>> @@ -9737,8 +9742,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                  * frequent, pollute the failure counter causing
>>                  * excessive cache_hot migrations and active balances.
>>                  */
>> -               if (idle != CPU_NEWLY_IDLE)
>> -                       sd->nr_balance_failed++;
>> +               if (idle != CPU_NEWLY_IDLE) {
>> +                       sd->nr_balance_failed = min(sd->nr_balance_failed + 1,
>> +                                                   sd_balance_failed_cap(sd));
>
> nr_balance_failed is an interesting metric that we want to monitor
> sometimes and we would like to be able to divide higher than
> 2^(sd->cache_nice_tries + 3).
>
> If we really want to prevent out of bound shift, The below is more
> appropriate IMO:
>
> index 636741fa27c9..4d0b3fa30849 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7707,7 +7707,7 @@ static int detach_tasks(struct lb_env *env)
>                          * migrate.
>                          */
>
> -                       if ((load >> env->sd->nr_balance_failed) >
> env->imbalance)
> +                       if ((load >> min_t(int,
> env->sd->nr_balance_failed, BITS_PER_LONG)) > env->imbalance)
>                                 goto next;
>

From the UB definition above, sounds like we need to cap at

  BITS_PER_TYPE(unsigned long) - 1

i.e. something like

  #define shr_bound(val, shift) \
          (val >> min_t(int, shift, BITS_PER_TYPE(val) - 1))

>                         env->imbalance -= load;
>
>
>> +               }
>>
>>                 if (need_active_balance(&env)) {
>>                         unsigned long flags;
>>
