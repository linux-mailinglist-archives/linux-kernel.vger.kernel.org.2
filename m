Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF85429761
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhJKTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhJKTOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:14:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D189C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:12:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id o12so5568577qtq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s4xFx28gjAl66XVszwZxGNqY4+x/foeiSz4xgvI/wDQ=;
        b=fkw6YNJhzyoDf6+A4nZ5IyJ4cdTpfAmokSKG+0McwriRPbB4myVJjAVxGMr7DTiDOm
         Z1DLwcQ3tADLiZGCu3HwOFAhYl8ulkbEQP3xfVTVY4HK+4iYU7HcL2Kv0nnoDtI3GoXq
         2Lh4mKrAFC0HqnWJU+GRKKxAoZn2RHtzBFf5F5ojQqK+w6PJikCQyJIfYY/RwI62x3tH
         7r5kRab+xYk4p/QTtSlGC8iS72Aw+e3Bp8gCM+bzUkUcceTaZfdEW7yFTlAbpASE1k2n
         KvVw48LUuSIcYRHB33z1/hddb3rrDmvqrE/yH9OtvKwGs7Ah6ciEy1+5tOpNtbFTCmTN
         KwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s4xFx28gjAl66XVszwZxGNqY4+x/foeiSz4xgvI/wDQ=;
        b=uDks0qn9Sum5ma+Yp6mWroTPlSt0oJU+zsA20Q/NVUX3evH5tdZcI7ebjYTE1E53GE
         398T+tt2M0aOz8qFNpN2ek5ekwDnn6JnATzJmR1YFbfR7qplLS/jDg/HRqRSBuVCUoSJ
         6CmpLn71ZD8wzByXII7Eq8eq9AUuwRuBW3vbK4k4DItspp0WsQrjrZkN7oYZ1kEzCZC2
         d5CPRKNHwda2Iu2kyFv3oET9IPf8hMXfimX0CVneRBzjeG6GI7YCQIiYqezRRwtYksOO
         PKsOP80PxqwITe6YbNPOhu1CY+EGFaIVwXKTxhS69/NzcYhi9UEbYpoa28Nwy2mpOy+4
         OIuw==
X-Gm-Message-State: AOAM531uU3xrOXero1ypPw4Zb/78/03xBrf8VgfO5bnVz8fk8gT0xzBz
        N3iE5g96KTRhDBgsoqtX/gUswZTyB/gJf82pGFQN3Q==
X-Google-Smtp-Source: ABdhPJyu8YtrNSA1rFEhi1FKBmHSFRCFK+jytWNpJ6ZATVYbhLWyvIb0BB7pwH6XVT7AJSDeT4I/Idrlhk06cLH19e8=
X-Received: by 2002:a05:622a:13c8:: with SMTP id p8mr6670372qtk.162.1633979539512;
 Mon, 11 Oct 2021 12:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211011172236.11223-1-mkoutny@suse.com>
In-Reply-To: <20211011172236.11223-1-mkoutny@suse.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 11 Oct 2021 20:12:08 +0100
Message-ID: <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list presence
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

man. 11. okt. 2021 kl. 18:24 skrev Michal Koutn=C3=BD <mkoutny@suse.com>:
>
> The removal path checks cfs_rq->on_list flag without synchronization
> based on the reasoning that only empty cgroups can be removed and
> ->on_list can't switch back to 1. However, since the commit a7b359fc6a37
> ("sched/fair: Correctly insert cfs_rq's to list on unthrottle") even
> cfs_rq of an empty cgroup may be added to the list because of
> non-decayed load that transiently remains there.
> The result is that we may skip unlinking the cfs_rq from the list on the
> removal path and the list will then contain free'd cfs_rq, which leads
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

Hi,

Well, yeah, that statement (in the code you removed) does not hold any more=
,
that is definitely true. Good catch.

To be 100% clear, this can only happen when a control group is
throttled while it has load
(cfs_rq_is_decayed(cfs_rq) is false); and then its unthrottling race
with its deletion?
Is that a correct understanding Michal?

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

Others know more about the performance impact of that lock, but in
terms of logic,
it looks good to me. Fixing it the other way around, without
reintroducing the issue fixed in
a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
unthrottle"), would create even
more brittle logic I think. fdaba61ef8a26 ("sched/fair: Ensure that
the CFS parent is added
after unthrottling) will also complicate that even more (and that
patch is also needed for
correcting the issues it does.

In theory, we can do something like the diff below (from the
top of my head), but I'm not sure if I am 100% comfortable with such a solu=
tion.
Especially due to the "child_cfs_rq_on_list(cfs_rq)" we need in addition
to the nr_running. Do you agree that that will also solve the problem Micha=
l,
or am I missing something obvious here?

I do think Vincent might have some more thoughts about this, so I will
defer it to him.

So in general, given that the locking thing is ok:
Acked-by: Odin Ugedal <odin@uged.al>

Thanks
Odin

[0]:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..e9a104d57b59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4805,9 +4805,13 @@ static int tg_unthrottle_up(struct task_group
*tg, void *data)
                cfs_rq->throttled_clock_task_time +=3D rq_clock_task(rq) -
                                             cfs_rq->throttled_clock_task;

-               /* Add cfs_rq with load or one or more already running
entities to the list */
-               if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
+               if (cfs_rq->nr_running || child_cfs_rq_on_list(cfs_rq)) {
                        list_add_leaf_cfs_rq(cfs_rq);
+               } else (!cfs_rq->on_list && !cfs_rq_is_decayed(cfs_rq)) {
+                       // Fully decay/detach the load of the cfs_rq
+                       cfs_rq->avg.load_avg =3D 0;
+                       update_tg_load_avg(cfs_rq);
+               }
        }

        return 0;
