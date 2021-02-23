Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7330322BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBWNqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBWNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:46:32 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:45:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v30so11262110lfq.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbLfnKeyB5qQuCIe6mIO3QOQb1kncdAW78Ttu3/DT8Q=;
        b=iyf6V6QXTM7z3LUIPlJ1O2b7+uhFj5lDNj11z4FRJ5xtkMq+SyMqOMjZr99f8p0A3H
         QHDj9wFkKEV84L7eosMMk0Ct9d540NCu1OkMtO82qKYAy9GJkRcxCIYgbtmzBZV6tXTP
         WG4nZi5RvL3JaylEV63QUOp7PZ7cKzUEqXcL+cFNsTRNT2w+T85k9E1B+TtOf9qMTM22
         MbkzERs4J6YqvV4jgPcB+dwBeSzWwQpB0PHxI4x8F9k+sKW1AW6r9tRZEfnp8j0tJki2
         s63JiL4L/xJt/2K7fNk0N51hG2KHj/1wmsfizPGCYzpzjyqaKOdDCmHlVSEJufks3zCt
         1Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbLfnKeyB5qQuCIe6mIO3QOQb1kncdAW78Ttu3/DT8Q=;
        b=SNBDDi2UCytCn0XAgxTaC/cow6Y5zuxetQn0INLx1fwJQwmPQxFzXyey9aFImLeiKr
         w542mG7qyBS5jQgm5r67+JJtgoyV0cA6J4hZ6YKKTwcvFkX5AhWvvL6gSiGycRsHSK5v
         WoHzISbTnYEur0cuuyllUsSwZZbSj8xcnC3I+rsAqjn+FgirCsNNCpKrZ2qI8jPl3HMK
         e/4gdkhXug07SFgY7Pyl2fMdrtOlmbcJnVxz5VQwCCAPTXijpNAjA+oN9fu+xzI5nNcC
         WwuCfDPVRfWqYQ/4AVxybXZ+LiFXfU96inEZaBdA6j0rheGee720zdLq0DFtEH9/4GHj
         ADeA==
X-Gm-Message-State: AOAM532kC5oyjG8rys+chtFiL8AnU+wPCT9MlGqT2JLVHjCVHpbv1pzJ
        FeACkk5OS2wg+/jFNh1CGOjhxYSiK7nCbwWIGS57RA==
X-Google-Smtp-Source: ABdhPJxQ0s16SHYzGoWl2o2eNa2wakQvmupSIMM9214xlzvkZx2AD44cEy6nHE9cBN7uK8m6iNnsBYPZ1Q0IltSu9hI=
X-Received: by 2002:a05:6512:3a86:: with SMTP id q6mr16600025lfu.286.1614087944686;
 Tue, 23 Feb 2021 05:45:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a43f1f05bbefe703@google.com> <jhjlfbfhty2.mognet@arm.com>
In-Reply-To: <jhjlfbfhty2.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Feb 2021 14:45:33 +0100
Message-ID: <CAKfTPtAkzDWfqAP=Fb+4B+PBUNN_7oTdZ3Cs+wLdfrJNa_ymTQ@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     syzbot <syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, luto@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 13:03, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> +Vincent
>
> On 22/02/21 09:12, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    31caf8b2 Merge branch 'linus' of git://git.kernel.org/pub/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16ab2682d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b81388f0b32761d4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d7581744d5fd27c9fbe1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1277457f500000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com
> >
> > ================================================================================
> > UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7712:14
> > shift exponent 149 is too large for 64-bit type 'long unsigned int'
>
> That 149 is surprising.

Yes, surprising. But is it really a problem in itself  ? shifting left
 would be a problem because of the overflow but here we shift right to
divide and the result is correct

Beside this, it seems that a significant number of previous attempts
to balance load has been done with another migration_type otherwise it
would  have raised a problem earlier (at 65) if previous LB were also
migration_load. It would be good to understand why the 148 previous
ones failed

>
> sd->cache_nice_tries is \in {1, 2}, and sd->nr_balanced_failed should be in
> the same ballpark.
>
> A successful load_balance() resets it to 0; a failed one increments
> it. Once it gets to sd->cache_nice_tries + 3, this should trigger an active
> balance, which will either set it to sd->cache_nice_tries+1 or reset it to
> 0. There is this one condition that could let it creep up uncontrollably:
>
>   /*
>    * Don't kick the active_load_balance_cpu_stop,
>    * if the curr task on busiest CPU can't be
>    * moved to this_cpu:
>    */
>   if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
>           raw_spin_unlock_irqrestore(&busiest->lock,
>                                       flags);
>           goto out_one_pinned;
>   }
>
> So despite the resulting sd->balance_interval increase, repeatedly hitting
> this might yield the above. Would we then want something like this?
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..b65c24b5ae91 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7422,6 +7422,11 @@ struct lb_env {
>         struct list_head        tasks;
>  };
>
> +static inline unsigned int sd_balance_failed_cap(struct sched_domain *sd)
> +{
> +       return sd->cache_nice_tries + 3;
> +}
> +
>  /*
>   * Is this task likely cache-hot:
>   */
> @@ -9493,7 +9498,7 @@ imbalanced_active_balance(struct lb_env *env)
>          * threads on a system with spare capacity
>          */
>         if ((env->migration_type == migrate_task) &&
> -           (sd->nr_balance_failed > sd->cache_nice_tries+2))
> +           (sd->nr_balance_failed >= sd_balance_failed_cap(sd)))
>                 return 1;
>
>         return 0;
> @@ -9737,8 +9742,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                  * frequent, pollute the failure counter causing
>                  * excessive cache_hot migrations and active balances.
>                  */
> -               if (idle != CPU_NEWLY_IDLE)
> -                       sd->nr_balance_failed++;
> +               if (idle != CPU_NEWLY_IDLE) {
> +                       sd->nr_balance_failed = min(sd->nr_balance_failed + 1,
> +                                                   sd_balance_failed_cap(sd));

nr_balance_failed is an interesting metric that we want to monitor
sometimes and we would like to be able to divide higher than
2^(sd->cache_nice_tries + 3).

If we really want to prevent out of bound shift, The below is more
appropriate IMO:

index 636741fa27c9..4d0b3fa30849 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7707,7 +7707,7 @@ static int detach_tasks(struct lb_env *env)
                         * migrate.
                         */

-                       if ((load >> env->sd->nr_balance_failed) >
env->imbalance)
+                       if ((load >> min_t(int,
env->sd->nr_balance_failed, BITS_PER_LONG)) > env->imbalance)
                                goto next;

                        env->imbalance -= load;


> +               }
>
>                 if (need_active_balance(&env)) {
>                         unsigned long flags;
>
