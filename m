Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F317E42B9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbhJMH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhJMH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:59:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:57:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s4so4297092ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pD1NrYgFFXk+EiN7dYeLLl3e8Ur9ZDCOxhiMVwCWlJM=;
        b=npIxe3p8R94e7zhqeWq8YEaTsFkGicWvOWSaTv8tmFX/Pwq8c/iv1AC4YOzdD7icQX
         ecxAxS0FgHFky7UjSFlpny7F+fU4X+XXDGKRV4OdKHBn5uF0zEuocKrWEysoVafN9ygS
         nZPpbBMSiiWmDVPNZj7QZ4b70HBCjYDsJwiNly0WiE9UHVdgYg3+QxyT35EIjCbbeBHk
         63J6sq+WDReyXJ9KIY5q7MvjCUtqwQPT/hw9f0Bvtpb4xVG6RkYYM5x9klH/DKOPDNii
         CWweSWxiAAI0lP3tMjcrLPC3BSVIQYu1i3xNIxQdGfWcwCie26M+t3Z1y8IGG1Z7Gu9a
         H8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pD1NrYgFFXk+EiN7dYeLLl3e8Ur9ZDCOxhiMVwCWlJM=;
        b=VKQSlnUpJek6hPv8nzAJ5v8gasXtaeqF79EdNss5q2dxAaZTzY3x/BCFVFoL+qnn9k
         78y7Eo5/f0O7GCN2N8SBPYOtRFN7O/STPLcMZBIUY1MJsUTddjWPcqQWb9aoTMZmG9cx
         ssBthAV553ZZ43dFvpFuOpiwSybp5z2Rb13qi4V/pWCmTt1IUJBOwX1FpJERGauh4nS/
         Ps4Nn8KZdyGY/aiwDlYwJVLUnsF0trxx8Y47ISfFgwOoZuyp9rT7hIa9D/fNVmvL6bdM
         AZRwWj6QulLy3yHKws+Xc4/ohTWpXvmXDaYU+34Srq98u+x1BrIBdYgYNRjNjqmGo4Ax
         zpXg==
X-Gm-Message-State: AOAM533uw9lxT7S0PQiQE74jVwMkNxiiwFxNvd8W15kk7PeQJPIkqgia
        bv6EiMx4SL9m+r7GUq5b1TvBvqVsmJzJYRHycHvBxA==
X-Google-Smtp-Source: ABdhPJxdcAyITFmj1xQRgl1+M7JSW/4j6TUpDIIB3Z9Aw0q4T9UAmj6SQ/13DFhPzltQUGfJp2ER0t9PzuGtIjs2Taw=
X-Received: by 2002:a25:c644:: with SMTP id k65mr24731603ybf.191.1634111848695;
 Wed, 13 Oct 2021 00:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211011172236.11223-1-mkoutny@suse.com>
In-Reply-To: <20211011172236.11223-1-mkoutny@suse.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Oct 2021 09:57:17 +0200
Message-ID: <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list presence
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 19:24, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> The removal path checks cfs_rq->on_list flag without synchronization
> based on the reasoning that only empty cgroups can be removed and
> ->on_list can't switch back to 1. However, since the commit a7b359fc6a37
> ("sched/fair: Correctly insert cfs_rq's to list on unthrottle") even
> cfs_rq of an empty cgroup may be added to the list because of
> non-decayed load that transiently remains there.
> The result is that we may skip unlinking the cfs_rq from the list on the
> removal path and the list will then contain free'd cfs_rq, which leads

This test was there before we started to del a cfs_rq from the list
when unused. At that time, a cfs_rq was added when the 1st entity was
enqueued and then remained in the list until the group was destroyed.
This test in unregister_fair_sched_group() was there to optimize the
removal of a cfs_rq which has never been used and as a result never
added in the list AFAICT.

I'm not sure about your explanation above. We don't skip unlinking the
cfs_rq because it is already not linked at the moment of the test.
Furthermore, list_del_leaf_cfs_rq() starts with the same test on of
cfs_rq->on_list. The problem is that the cfs_rq can be added during or
after the test. Removing it should not be enough because we do the
same test under rq lock which only ensures that both the test and the
add on the list will not happen simultaneously. This seems to closes
the race window in your case but this could still happen AFAICT.

What about  your patchset about adding a cfs in the list only when
there is a runnable task ? Wouldn't this fix the problem ?

> sooner or later to a task failing inside update_blocked_averages while
> holding rq->lock and eventually locking up the machine on all other CPUs
> as well:
>
>         [ 8995.095798] BUG: kernel NULL pointer dereference, address: 000=
0000000000080
>         [ 9016.281685] NMI watchdog: Watchdog detected hard LOCKUP on cpu=
 21
>
> Illustrative stack dump of a task that faulted by accessing released
> cfs_rq (+unrelated deadlock on rq->lock):
>
>         PID: 0      TASK: ffff8a310a5dc000  CPU: 16  COMMAND: "swapper/16=
"
>          #0 [fffffe0000379e58] crash_nmi_callback at ffffffffba063683
>          #1 [fffffe0000379e60] nmi_handle at ffffffffba0377ef
>          #2 [fffffe0000379eb8] default_do_nmi at ffffffffba037c5e
>          #3 [fffffe0000379ed8] do_nmi at ffffffffba037ea7
>          #4 [fffffe0000379ef0] end_repeat_nmi at ffffffffbaa0178b
>             [exception RIP: native_queued_spin_lock_slowpath+98]
>             RIP: ffffffffba0fa6e2  RSP: ffffa8505932ca30  RFLAGS: 0000000=
2
>             RAX: 0000000001200101  RBX: ffff8a8de9044000  RCX: ffff8a8ec0=
800000
>             RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff8a8ec0=
82cc80
>             RBP: ffff8a8ec082cc80   R8: ffff8a8ec0800000   R9: ffff8a3107=
8058f8
>             R10: 0000000000000000  R11: ffffffffbb4639d8  R12: 0000000000=
000000
>             R13: ffff8a8de9044b84  R14: 0000000000000006  R15: 0000000000=
000010
>             ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>         --- <NMI exception stack> ---
>          #5 [ffffa8505932ca30] native_queued_spin_lock_slowpath at ffffff=
ffba0fa6e2
>          #6 [ffffa8505932ca30] _raw_spin_lock at ffffffffba922aab
>          #7 [ffffa8505932ca38] try_to_wake_up at ffffffffba0cf8f9
>          #8 [ffffa8505932ca98] __queue_work at ffffffffba0b9c7e
>          #9 [ffffa8505932cae0] queue_work_on at ffffffffba0ba7b4
>         #10 [ffffa8505932caf0] bit_putcs at ffffffffba541bc0
>         #11 [ffffa8505932cbf0] fbcon_putcs at ffffffffba53c36b
>         #12 [ffffa8505932cc48] vt_console_print at ffffffffba5ff032
>         #13 [ffffa8505932cca8] console_unlock at ffffffffba1091a2
>         #14 [ffffa8505932ccf0] vprintk_emit at ffffffffba10ad29
>         #15 [ffffa8505932cd40] printk at ffffffffba10b590
>         #16 [ffffa8505932cda8] no_context at ffffffffba081f66
>         #17 [ffffa8505932ce10] do_page_fault at ffffffffba082df0
>         #18 [ffffa8505932ce40] page_fault at ffffffffbaa012fe
>             [exception RIP: update_blocked_averages+685]
>             RIP: ffffffffba0d85cd  RSP: ffffa8505932cef0  RFLAGS: 0001004=
6
>             RAX: 0000000000000000  RBX: ffff8a8ca0510000  RCX: 0000000000=
000000
>             RDX: 0000000000000000  RSI: ffff8a8ca0510000  RDI: 0000000000=
000000
>             RBP: 0000000000000000   R8: 00000000eac0c6e6   R9: 0000000000=
000233
>             R10: ffffa8505932cef0  R11: 0000000000000233  R12: ffff8a8ca0=
510140
>             R13: 0000000000000000  R14: fffffffffffffec2  R15: 0000000000=
000080
>             ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>         #19 [ffffa8505932cf50] run_rebalance_domains at ffffffffba0e2751
>         #20 [ffffa8505932cf68] __softirqentry_text_start at ffffffffbac00=
0e3
>         #21 [ffffa8505932cfc8] irq_exit at ffffffffba0a2cf5
>         #22 [ffffa8505932cfd8] smp_apic_timer_interrupt at ffffffffbaa028=
74
>         #23 [ffffa8505932cff0] apic_timer_interrupt at ffffffffbaa01d9f
>         --- <IRQ stack> ---
>         #24 [ffffa850402f3dd8] apic_timer_interrupt at ffffffffbaa01d9f
>             [exception RIP: cpuidle_enter_state+171]
>             RIP: ffffffffba6fc32b  RSP: ffffa850402f3e80  RFLAGS: 0000024=
6
>             RAX: ffff8a8ec082cc80  RBX: ffffc7f053605e80  RCX: 0000000000=
00001f
>             RDX: 0000082e557d390c  RSI: 000000003d1877c2  RDI: 0000000000=
000000
>             RBP: ffffffffbb55f100   R8: 0000000000000002   R9: 0000000000=
02c500
>             R10: ffffa850402f3e60  R11: 00000000000002ff  R12: 0000000000=
000002
>             R13: 0000082e557d390c  R14: 0000000000000002  R15: 0000000000=
000000
>             ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
>         #25 [ffffa850402f3ec0] cpuidle_enter at ffffffffba6fc6f9
>         #26 [ffffa850402f3ee0] do_idle at ffffffffba0d4567
>         #27 [ffffa850402f3f20] cpu_startup_entry at ffffffffba0d4769
>         #28 [ffffa850402f3f30] start_secondary at ffffffffba064e35
>         #29 [ffffa850402f3f50] secondary_startup_64_no_verify at ffffffff=
ba000112
>
> Fix this by always taking rq->lock when checking the ->on_list condition
> (the modification of the list in UBA is therefore synchronized).
>
> Taking the rq->lock on every cpu cgroup removal may pose a performance
> penalty. However, this should be just moving the necessary work from UBA
> into the unregister_fair_sched_group() and therefore neutral on larger
> scale (assuming given cpu cgroup was populated at least once).
>
> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on un=
throttle")
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/sched/fair.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6a05d9b5443..081c7ac02f65 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11440,13 +11440,6 @@ void unregister_fair_sched_group(struct task_gro=
up *tg)
>                 if (tg->se[cpu])
>                         remove_entity_load_avg(tg->se[cpu]);
>
> -               /*
> -                * Only empty task groups can be destroyed; so we can spe=
culatively
> -                * check on_list without danger of it being re-added.
> -                */
> -               if (!tg->cfs_rq[cpu]->on_list)
> -                       continue;
> -
>                 rq =3D cpu_rq(cpu);
>
>                 raw_spin_rq_lock_irqsave(rq, flags);
> --
> 2.33.0
>
