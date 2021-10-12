Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290E42AC80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhJLSvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:51:37 -0400
Received: from out10.migadu.com ([46.105.121.227]:59689 "EHLO out10.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235168AbhJLSvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:51:14 -0400
Date:   Wed, 13 Oct 2021 02:32:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634063502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzDRoPIbgAxFIb1sOoboXwCpLvAGLx6AcopxutVjOfo=;
        b=ZGDAFSVpMys1JfpKrw0rI6mN3eDjNY7BmtMI1FPMyYhNyDq6xkhtGz5CNm7HZKZOPButLH
        TKwx5ZJUndazZG4Zsj1GpphjdvmOsJtO1qhGz56qFoM4XLm6VPYyU/8vTvJOeyF17Kh6dR
        Yq3FNthomtrF7Jjl4V96p4/rxitr86k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Odin Ugedal <odin@uged.al>
Cc:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list
 presence
Message-ID: <YWXUuXsA+1nNjZYN@geo.homenetwork>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Odin,

On Mon, Oct 11, 2021 at 08:12:08PM +0100, Odin Ugedal wrote:
> man. 11. okt. 2021 kl. 18:24 skrev Michal Koutný <mkoutny@suse.com>:
> >
> > The removal path checks cfs_rq->on_list flag without synchronization
> > based on the reasoning that only empty cgroups can be removed and
> > ->on_list can't switch back to 1. However, since the commit a7b359fc6a37
> > ("sched/fair: Correctly insert cfs_rq's to list on unthrottle") even
> > cfs_rq of an empty cgroup may be added to the list because of
> > non-decayed load that transiently remains there.
> > The result is that we may skip unlinking the cfs_rq from the list on the
> > removal path and the list will then contain free'd cfs_rq, which leads
> > sooner or later to a task failing inside update_blocked_averages while
> > holding rq->lock and eventually locking up the machine on all other CPUs
> > as well:
> >
> >         [ 8995.095798] BUG: kernel NULL pointer dereference, address: 0000000000000080
> >         [ 9016.281685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 21
> >
> > Illustrative stack dump of a task that faulted by accessing released
> > cfs_rq (+unrelated deadlock on rq->lock):
> >
> >         PID: 0      TASK: ffff8a310a5dc000  CPU: 16  COMMAND: "swapper/16"
> >          #0 [fffffe0000379e58] crash_nmi_callback at ffffffffba063683
> >          #1 [fffffe0000379e60] nmi_handle at ffffffffba0377ef
> >          #2 [fffffe0000379eb8] default_do_nmi at ffffffffba037c5e
> >          #3 [fffffe0000379ed8] do_nmi at ffffffffba037ea7
> >          #4 [fffffe0000379ef0] end_repeat_nmi at ffffffffbaa0178b
> >             [exception RIP: native_queued_spin_lock_slowpath+98]
> >             RIP: ffffffffba0fa6e2  RSP: ffffa8505932ca30  RFLAGS: 00000002
> >             RAX: 0000000001200101  RBX: ffff8a8de9044000  RCX: ffff8a8ec0800000
> >             RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff8a8ec082cc80
> >             RBP: ffff8a8ec082cc80   R8: ffff8a8ec0800000   R9: ffff8a31078058f8
> >             R10: 0000000000000000  R11: ffffffffbb4639d8  R12: 0000000000000000
> >             R13: ffff8a8de9044b84  R14: 0000000000000006  R15: 0000000000000010
> >             ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >         --- <NMI exception stack> ---
> >          #5 [ffffa8505932ca30] native_queued_spin_lock_slowpath at ffffffffba0fa6e2
> >          #6 [ffffa8505932ca30] _raw_spin_lock at ffffffffba922aab
> >          #7 [ffffa8505932ca38] try_to_wake_up at ffffffffba0cf8f9
> >          #8 [ffffa8505932ca98] __queue_work at ffffffffba0b9c7e
> >          #9 [ffffa8505932cae0] queue_work_on at ffffffffba0ba7b4
> >         #10 [ffffa8505932caf0] bit_putcs at ffffffffba541bc0
> >         #11 [ffffa8505932cbf0] fbcon_putcs at ffffffffba53c36b
> >         #12 [ffffa8505932cc48] vt_console_print at ffffffffba5ff032
> >         #13 [ffffa8505932cca8] console_unlock at ffffffffba1091a2
> >         #14 [ffffa8505932ccf0] vprintk_emit at ffffffffba10ad29
> >         #15 [ffffa8505932cd40] printk at ffffffffba10b590
> >         #16 [ffffa8505932cda8] no_context at ffffffffba081f66
> >         #17 [ffffa8505932ce10] do_page_fault at ffffffffba082df0
> >         #18 [ffffa8505932ce40] page_fault at ffffffffbaa012fe
> >             [exception RIP: update_blocked_averages+685]
> >             RIP: ffffffffba0d85cd  RSP: ffffa8505932cef0  RFLAGS: 00010046
> >             RAX: 0000000000000000  RBX: ffff8a8ca0510000  RCX: 0000000000000000
> >             RDX: 0000000000000000  RSI: ffff8a8ca0510000  RDI: 0000000000000000
> >             RBP: 0000000000000000   R8: 00000000eac0c6e6   R9: 0000000000000233
> >             R10: ffffa8505932cef0  R11: 0000000000000233  R12: ffff8a8ca0510140
> >             R13: 0000000000000000  R14: fffffffffffffec2  R15: 0000000000000080
> >             ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >         #19 [ffffa8505932cf50] run_rebalance_domains at ffffffffba0e2751
> >         #20 [ffffa8505932cf68] __softirqentry_text_start at ffffffffbac000e3
> >         #21 [ffffa8505932cfc8] irq_exit at ffffffffba0a2cf5
> >         #22 [ffffa8505932cfd8] smp_apic_timer_interrupt at ffffffffbaa02874
> >         #23 [ffffa8505932cff0] apic_timer_interrupt at ffffffffbaa01d9f
> >         --- <IRQ stack> ---
> >         #24 [ffffa850402f3dd8] apic_timer_interrupt at ffffffffbaa01d9f
> >             [exception RIP: cpuidle_enter_state+171]
> >             RIP: ffffffffba6fc32b  RSP: ffffa850402f3e80  RFLAGS: 00000246
> >             RAX: ffff8a8ec082cc80  RBX: ffffc7f053605e80  RCX: 000000000000001f
> >             RDX: 0000082e557d390c  RSI: 000000003d1877c2  RDI: 0000000000000000
> >             RBP: ffffffffbb55f100   R8: 0000000000000002   R9: 000000000002c500
> >             R10: ffffa850402f3e60  R11: 00000000000002ff  R12: 0000000000000002
> >             R13: 0000082e557d390c  R14: 0000000000000002  R15: 0000000000000000
> >             ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
> >         #25 [ffffa850402f3ec0] cpuidle_enter at ffffffffba6fc6f9
> >         #26 [ffffa850402f3ee0] do_idle at ffffffffba0d4567
> >         #27 [ffffa850402f3f20] cpu_startup_entry at ffffffffba0d4769
> >         #28 [ffffa850402f3f30] start_secondary at ffffffffba064e35
> >         #29 [ffffa850402f3f50] secondary_startup_64_no_verify at ffffffffba000112
> >
> > Fix this by always taking rq->lock when checking the ->on_list condition
> > (the modification of the list in UBA is therefore synchronized).
> 
> Hi,
> 
> Well, yeah, that statement (in the code you removed) does not hold any more,
> that is definitely true. Good catch.
> 
> To be 100% clear, this can only happen when a control group is
> throttled while it has load
> (cfs_rq_is_decayed(cfs_rq) is false); and then its unthrottling race
> with its deletion?
> Is that a correct understanding Michal?
> 
> >
> > Taking the rq->lock on every cpu cgroup removal may pose a performance
> > penalty. However, this should be just moving the necessary work from UBA
> > into the unregister_fair_sched_group() and therefore neutral on larger
> > scale (assuming given cpu cgroup was populated at least once).
> >
> > Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
> >
> > Signed-off-by: Michal Koutný <mkoutny@suse.com>
> > ---
> 
> Others know more about the performance impact of that lock, but in
> terms of logic,
> it looks good to me. Fixing it the other way around, without
> reintroducing the issue fixed in
> a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
> unthrottle"), would create even
> more brittle logic I think. fdaba61ef8a26 ("sched/fair: Ensure that
> the CFS parent is added
> after unthrottling) will also complicate that even more (and that
> patch is also needed for
> correcting the issues it does.
> 
> In theory, we can do something like the diff below (from the
> top of my head), but I'm not sure if I am 100% comfortable with such a solution.
> Especially due to the "child_cfs_rq_on_list(cfs_rq)" we need in addition
> to the nr_running. Do you agree that that will also solve the problem Michal,
> or am I missing something obvious here?
> 
> I do think Vincent might have some more thoughts about this, so I will
> defer it to him.
> 
> So in general, given that the locking thing is ok:
> Acked-by: Odin Ugedal <odin@uged.al>
> 
> Thanks
> Odin
> 
> [0]:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6a05d9b5443..e9a104d57b59 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4805,9 +4805,13 @@ static int tg_unthrottle_up(struct task_group
> *tg, void *data)
>                 cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
>                                              cfs_rq->throttled_clock_task;
> 
> -               /* Add cfs_rq with load or one or more already running
> entities to the list */
> -               if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> +               if (cfs_rq->nr_running || child_cfs_rq_on_list(cfs_rq)) {
>                         list_add_leaf_cfs_rq(cfs_rq);
> +               } else (!cfs_rq->on_list && !cfs_rq_is_decayed(cfs_rq)) {
> +                       // Fully decay/detach the load of the cfs_rq
> +                       cfs_rq->avg.load_avg = 0;
> +                       update_tg_load_avg(cfs_rq);


Er.. this is considered specific to this fix I think. Normal unthrottle(not
race with delete, avg maybe used in after) also need the normal avg decay.

> +               }
>         }
> 
>         return 0;



Thanks,
Tao
