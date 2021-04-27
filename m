Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1436CA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbhD0RLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhD0RLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:11:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:10:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u20so69041056lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlYlbs6HZgSVhhiZ36/Xl5isQaA0oQZ+rysyFeeXIcg=;
        b=Ok8FKSTFwJSi/+B3OBPaYjOshrNDSSCP0GnIQEd4Alk5NyKK+xpVnTvqu7tz8CBlKH
         A9bwTcFxi77k4U9wUpNrhvU0qxVJOBZPw557Ta/K2MI3O6roudmkkkhAhnUDDOER4eRN
         o7vZw9mv2XB+tyq+doDwypQn/yDan5xqgGQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlYlbs6HZgSVhhiZ36/Xl5isQaA0oQZ+rysyFeeXIcg=;
        b=D+sYhpEsxdjWdEBXxDZ9BbEssLgKUiyu0Kh/8nWg4si05M/nUhPozIzalWRTkh4KTQ
         MJDUtv9BzsVosRI+YsTAMFuPrqGcFRFUUISxegtWX4HA0jUcgR1pP1fPD8m9AOfDS6hP
         4W3z3w+Ky6qsoW5g5uMk7nN9ExciXI+aCFwH2OX2Z+0S0Kc0qOOG41X5biopQyU2a1bC
         uRg+v/Nu1EYrmi63TqtV3s2zer3IPBKpKD0FN2a4n+MX0BnyxAAjKSYH5SdPJRiCeXzH
         Qz0Q/s5YD9/i3APNYz3/qAjgYFaUjjB67gukwVC65zpH9komP6/9Rikv8m+g4ECrCRnQ
         S8vw==
X-Gm-Message-State: AOAM530BHI6CqED+Zmz1ErGn0wPYmp1H7Ud0fzjfBdFWLXFL/OTMInGY
        V1hS5bzUnQKfsuZqsXFJLY0Gj4C4fi0S8IkME0ltpw==
X-Google-Smtp-Source: ABdhPJwC9G5gZg1lxYY3Ta/WrblnujhFvwkDyMNrZ34zZOyzZ+egQPxVZovahs3zqVWLnyVh83VR+cGR4tKl12AvLe4=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr17134867ljk.442.1619543451346;
 Tue, 27 Apr 2021 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
In-Reply-To: <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Tue, 27 Apr 2021 10:10:40 -0700
Message-ID: <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 3:21 PM Josh Don <joshdon@google.com> wrote:
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f732642e3e09..1a81e9cc9e5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
> >  static void __sched_core_enable(void)
> >  {
> >         static_branch_enable(&__sched_core_enabled);
> > +       /*
> > +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> > +        */
> > +       synchronize_sched();
>
> synchronize_rcu()
>
> >         __sched_core_flip(true);
> >         sched_core_assert_empty();
> >  }
> > @@ -449,16 +453,22 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
> >  {
> >         raw_spinlock_t *lock;
> >
> > +       preempt_disable();
> >         if (sched_core_disabled()) {
> >                 raw_spin_lock_nested(&rq->__lock, subclass);
> > +               /* preempt *MUST* still be disabled here */
> > +               preempt_enable_no_resched();
> >                 return;
> >         }
>
> This approach looks good to me. I'm guessing you went this route
> instead of doing the re-check after locking in order to optimize the
> disabled case?
>
Hi Josh and Peter,

I've been running into soft lookups and hard lockups when running a script
that just cycles setting the cookie of a group of processes over and over again.

Unfortunately the only way I can reproduce this is by setting the cookies
on qemu. I've tried sysbench, stress-ng but those seem to work just fine.

I'm running Peter's branch and even tried the suggested changes here but
still see the same behavior. I enabled panic on hard lockup and here below
is a snippet of the log.

Is there anything you'd like me to try or have any debugging you'd like me to
do? I'd certainly like to get to the bottom of this.

Thanks and have a great day,

Don

[ 1164.129706] NMI backtrace for cpu 10
[ 1164.129707] CPU: 10 PID: 6994 Comm: CPU 2/KVM Kdump: loaded
Tainted: G          I  L    5.12.0-rc8+ #4
[ 1164.129707] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS
2.9.4 11/06/2020
[ 1164.129708] RIP: 0010:native_queued_spin_lock_slowpath+0x69/0x1e0
[ 1164.129708] Code: 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09
d0 a9 00 01 ff ff 75 20 85 c0 75 0c b8 01 00 00 00 66 89 07 5d c3 f3
90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89 07 eb ec f6 c4 01 75 04 c6
47 01
[ 1164.129709] RSP: 0018:ffffb35d591e0e20 EFLAGS: 00000002
[ 1164.129710] RAX: 0000000000200101 RBX: ffff9ecb0096c180 RCX: 0000000000000001
[ 1164.129710] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9ecb0096c180
[ 1164.129711] RBP: ffffb35d591e0e20 R08: 0000000000000000 R09: 000000010002e2a6
[ 1164.129711] R10: 0000000000000000 R11: ffffb35d591e0ff8 R12: ffff9ecb0096c180
[ 1164.129712] R13: 000000000000000a R14: 000000000000000a R15: ffff9e6e8dc88000
[ 1164.129712] FS:  00007f91bd79f700(0000) GS:ffff9ecb00940000(0000)
knlGS:0000000000000000
[ 1164.129713] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1164.129713] CR2: 000000000255d05c CR3: 000000022eb8c005 CR4: 00000000007726e0
[ 1164.129714] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1164.129715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1164.129715] PKRU: 55555554
[ 1164.129715] Call Trace:
[ 1164.129716]  <IRQ>
[ 1164.129716]  _raw_spin_lock+0x1f/0x30
[ 1164.129717]  raw_spin_rq_lock_nested.part.93+0x2b/0x60
[ 1164.129717]  raw_spin_rq_lock_nested.constprop.126+0x1a/0x20
[ 1164.129718]  scheduler_tick+0x4c/0x240
[ 1164.129718]  ? tick_sched_handle.isra.17+0x60/0x60
[ 1164.129719]  update_process_times+0xab/0xc0
[ 1164.129719]  tick_sched_handle.isra.17+0x21/0x60
[ 1164.129720]  tick_sched_timer+0x6b/0x80
[ 1164.129720]  __hrtimer_run_queues+0x10d/0x230
[ 1164.129721]  hrtimer_interrupt+0xe7/0x230
[ 1164.129721]  __sysvec_apic_timer_interrupt+0x62/0x100
[ 1164.129721]  sysvec_apic_timer_interrupt+0x51/0xa0
[ 1164.129722]  </IRQ>
[ 1164.129722]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 1164.129722] RIP: 0010:smp_call_function_single+0xf6/0x130
[ 1164.129723] Code: 00 75 4d 48 83 c4 48 41 5a 5d 49 8d 62 f8 c3 48
89 75 c0 48 8d 75 b0 48 89 55 c8 e8 84 fe ff ff 8b 55 b8 83 e2 01 74
0a f3 90 <8b> 55 b8 83 e2 01 75 f6 eb c0 8b 05 4a d8 b0 01 85 c0 0f 85
67 ff
[ 1164.129724] RSP: 0018:ffffb35d5e20fb20 EFLAGS: 00000202
[ 1164.129725] RAX: 0000000000000000 RBX: ffff9e6e8df12600 RCX: ffffb35d5f2ffcc0
[ 1164.129725] RDX: 0000000000000001 RSI: ffffb35d5e20fb20 RDI: ffffb35d5e20fb20
[ 1164.129725] RBP: ffffb35d5e20fb70 R08: 0000000000001000 R09: 0000000000001907
[ 1164.129726] R10: ffffb35d5e20fb98 R11: 00000000003d0900 R12: 000000000000000a
[ 1164.129726] R13: 000000000000000c R14: 0000000000000000 R15: 0000000000000000
[ 1164.129727]  ? vmclear_error+0x150/0x390 [kvm_intel]
[ 1164.129727]  vmx_vcpu_load_vmcs+0x1b2/0x330 [kvm_intel]
[ 1164.129728]  ? update_load_avg+0x1b8/0x640
[ 1164.129728]  ? vmx_vcpu_load_vmcs+0x1b2/0x330 [kvm_intel]
[ 1164.129728]  ? load_fixmap_gdt+0x23/0x30
[ 1164.129729]  vmx_vcpu_load_vmcs+0x309/0x330 [kvm_intel]
[ 1164.129729]  kvm_arch_vcpu_load+0x41/0x260 [kvm]
[ 1164.129729]  ? __switch_to_xtra+0xe3/0x4e0
[ 1164.129730]  kvm_io_bus_write+0xbc/0xf0 [kvm]
[ 1164.129730]  ? kvm_io_bus_write+0xbc/0xf0 [kvm]
[ 1164.129730]  finish_task_switch+0x184/0x290
[ 1164.129731]  __schedule+0x30a/0x12f0
[ 1164.129731]  schedule+0x40/0xb0
[ 1164.129732]  kvm_vcpu_block+0x57/0x4b0 [kvm]
[ 1164.129732]  kvm_arch_vcpu_ioctl_run+0x3fe/0x1b60 [kvm]
[ 1164.129732]  kvm_vcpu_kick+0x59c/0xa10 [kvm]
[ 1164.129733]  ? kvm_vcpu_kick+0x59c/0xa10 [kvm]
[ 1164.129733]  __x64_sys_ioctl+0x96/0xd0
[ 1164.129733]  do_syscall_64+0x37/0x80
[ 1164.129734]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1164.129734] RIP: 0033:0x7fb1c8a4c317
[ 1164.129735] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89
01 48
[ 1164.129735] RSP: 002b:00007f91bd79e7e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 1164.129736] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fb1c8a4c317
[ 1164.129737] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001a
[ 1164.129737] RBP: 0000000000000000 R08: 000055f3e6d027c0 R09: 00007f91a80040b8
[ 1164.129738] R10: 00007f91a80050a0 R11: 0000000000000246 R12: 00007fb1c4023010
[ 1164.129739] R13: 000055f3e569d880 R14: 00007fb1cb8e7000 R15: 00007ffd86806f70


> Recommend a comment that the preempt_disable() here pairs with the
> synchronize_rcu() in __sched_core_enable().
>
> >
> >         for (;;) {
> >                 lock = __rq_lockp(rq);
> >                 raw_spin_lock_nested(lock, subclass);
> > -               if (likely(lock == __rq_lockp(rq)))
> > +               if (likely(lock == __rq_lockp(rq))) {
> > +                       /* preempt *MUST* still be disabled here */
> > +                       preempt_enable_no_resched();
> >                         return;
> > +               }
> >                 raw_spin_unlock(lock);
> >         }
> >  }
