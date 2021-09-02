Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7899A3FF6B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347724AbhIBV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347948AbhIBV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:59:23 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0618C061764
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:58:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id e206-20020a4a55d7000000b00291379cb2baso993700oob.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJ2G5V8fcu6Ri1yjuh8sHVMhU03X8sgsAKxgyHT7dRs=;
        b=aUOwq8pQZKd3IP15GQgd4sjVTP4qf85YVe4udvaWjgLjMYMlJPcN7V/0H+hPnptpej
         yLfTpmNzl7H8lZNwp7AM4EA22wTPZe8fj2JF2vo2/ZsW/mEQyTbEyasaIa8SLb2EdPZH
         VNYymIfQu2gcHhIABwgU6V+kJo3usw/56jAQ5fF3a9qiWqT7OIYflO1k6OFgJ0pF3oB4
         ckqdUfs2FuODoudyRyPu592JidRC+NSiome7PdOpgrWUxskepNfXbui5U4fzBbj3Ur7g
         1m62THcT5xdnHLXscpx3UGhnCv691RgemHYQ3oWpR0zRo78R8MTK5K7FwcfnK5Sp001w
         7e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJ2G5V8fcu6Ri1yjuh8sHVMhU03X8sgsAKxgyHT7dRs=;
        b=KVttB4JYJMkYcfVt9PkU28mC62S5x+ON/zp3ZIpZCZJJvypzdb1si7kCcWzFLaoPwe
         RI7wif+OT5djW7TPEk5kWfb9AX/gELjj10me3QFNv6dH8kGcLieHWYHHwt45L74FiepN
         fn6CP/EWSxrCktJ8IpQvzuDFSUTJF7iKRZYyhbv6Q07sPNh0pal+TjTfz8PH8Q0OWxLq
         I5tv0xElS1qQf9K1swO9tGqLtv0HrvgfZvDYXKrl11RxU9UdR+ZXMIf1bDLXdFKkJgNj
         dBu2X0S9yx1Usu7cAmi9sB4d1D2O7iimBVSrPggYBevuFnn7xfQiUX2Z4zDJL33UBCvw
         pddQ==
X-Gm-Message-State: AOAM531WbewAcbSlRT/CMabDym35FqeF5aLRItprwhVbu58j8pforNR3
        tA6shaIGS4ZzC9WSxNCL1xH4FOPWv2heTlXvAOL/+w==
X-Google-Smtp-Source: ABdhPJyxOrQc+puvphBlXN3F3tMSJqt3prpbKUN6LdZXwf4vKjhzOramR9UGhpk7g5Zkk/+MyG7lhfBe9MhiHTXDaeE=
X-Received: by 2002:a4a:e1a4:: with SMTP id 4mr287025ooy.14.1630619904032;
 Thu, 02 Sep 2021 14:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210902200134.25603-1-skhan@linuxfoundation.org>
In-Reply-To: <20210902200134.25603-1-skhan@linuxfoundation.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Sep 2021 23:58:12 +0200
Message-ID: <CANpmjNPWyp67SSfRiXVYTiqRaMre9XVQzNVM-73PQ6TTjQW3Gw@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Don't record workqueue stack holding raw_spin_lock
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, akpm@linux-foundation.org,
        andreyknvl@gmail.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sept 2021 at 22:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
> kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
> it tries to allocate memory attempting to acquire spinlock in page
> allocation code while holding workqueue pool raw_spinlock.
>
> There are several instances of this problem when block layer tries
> to __queue_work(). Call trace from one of these instances is below:
>
>     kblockd_mod_delayed_work_on()
>       mod_delayed_work_on()
>         __queue_delayed_work()
>           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>             insert_work()
>               kasan_record_aux_stack()
>                 kasan_save_stack()
>                   stack_depot_save()
>                     alloc_pages()
>                       __alloc_pages()
>                         get_page_from_freelist()
>                           rm_queue()
>                             rm_queue_pcplist()
>                               local_lock_irqsave(&pagesets.lock, flags);
>                               [ BUG: Invalid wait context triggered ]
>
> Fix it by calling kasan_record_aux_stack() conditionally only when
> CONFIG_PROVE_RAW_LOCK_NESTING is not enabled. After exploring other
> options such as calling kasan_record_aux_stack() after releasing the
> pool lock, opting for a least disruptive path of stubbing this record
> function to avoid nesting raw spinlock and spinlock.
>
> =============================
>  [ BUG: Invalid wait context ]
>  5.14.0-rc7+ #8 Not tainted
>  -----------------------------
>  snap/532 is trying to lock:
>  ffff888374f32ba0 (lock#2){..-.}-{3:3}, at: get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by snap/532:
>  #0: ffff888139fa4408 (&type->i_mutex_dir_key#10){.+.+}-{4:4}, at: walk_component (fs/namei.c:1663 fs/namei.c:1959)
>  #1: ffffffffab870c40 (rcu_read_lock){....}-{1:3}, at: __queue_work (./arch/x86/include/asm/preempt.h:80 ./include/linux/rcupdate.h:68 ./include/linux/rcupdate.h:685 kernel/workqueue.c:1421)
>  #2: ffff888374f36cd8 (&pool->lock){-.-.}-{2:2}, at: __queue_work (kernel/workqueue.c:1466)
>  stack backtrace:
>  CPU: 14 PID: 532 Comm: snap Not tainted 5.14.0-rc7+ #8
>  Hardware name: LENOVO 90Q30008US/3728, BIOS O4ZKT1CA 09/16/2020
>  Call Trace:
>  dump_stack_lvl (lib/dump_stack.c:106 (discriminator 4))
>  dump_stack (lib/dump_stack.c:113)
>  __lock_acquire.cold (kernel/locking/lockdep.c:4666 kernel/locking/lockdep.c:4727 kernel/locking/lockdep.c:4965)
>  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4873)
>  ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>  lock_acquire (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:5627 kernel/locking/lockdep.c:5590)
>  ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>  ? lock_release (kernel/locking/lockdep.c:5593)
>  ? __kasan_check_read (mm/kasan/shadow.c:32)
>  ? __lock_acquire (kernel/locking/lockdep.c:5019)
>  ? __zone_watermark_ok (./include/linux/list.h:282 ./include/linux/mmzone.h:111 mm/page_alloc.c:3908)
>  get_page_from_freelist (./include/linux/local_lock_internal.h:43 mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>  ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>  ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>  ? is_bpf_text_address (./arch/x86/include/asm/preempt.h:85 ./include/linux/rcupdate.h:73 ./include/linux/rcupdate.h:719 kernel/bpf/core.c:708)
>  ? lock_downgrade (kernel/locking/lockdep.c:5633)
>  ? __zone_watermark_ok (mm/page_alloc.c:4054)
>  __alloc_pages (mm/page_alloc.c:5391)
>  ? __alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:5354)
>  ? create_prof_cpu_mask (kernel/stacktrace.c:82)
> ? _find_first_bit (lib/find_bit.c:83)
>  alloc_pages (mm/mempolicy.c:2249)
>  stack_depot_save (lib/stackdepot.c:304)
>  ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>  kasan_save_stack (mm/kasan/common.c:41)
>  ? kasan_save_stack (mm/kasan/common.c:39)
>  ? kasan_record_aux_stack (mm/kasan/generic.c:348)
>  ? insert_work (./include/linux/instrumented.h:71 ./include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:616 kernel/workqueue.c:623 kernel/workqueue.c:1335)
>  ? __queue_work (kernel/workqueue.c:1501)
>  ? __queue_delayed_work (kernel/workqueue.c:1657)
>  ? mod_delayed_work_on (kernel/workqueue.c:1720)
>  ? kblockd_mod_delayed_work_on (block/blk-core.c:1633)
>  ? __blk_mq_delay_run_hw_queue (block/blk-mq.c:1567)
>  ? blk_mq_run_hw_queue (block/blk-mq.c:1610)
>  ? blk_mq_sched_insert_request (block/blk-mq-sched.c:480)
>  ? blk_mq_submit_bio (block/blk-mq.c:2276)
>
> Fixes: e89a85d63fb2 ("workqueue: kasan: record workqueue stack")
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> -- Instead of changing when record happens, disable record
>    when CONFIG_PROVE_RAW_LOCK_NESTING=y
>
>  kernel/workqueue.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index f148eacda55a..435970ef81ae 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1328,8 +1328,16 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
>  {
>         struct worker_pool *pool = pwq->pool;
>
> -       /* record the work call stack in order to print it in KASAN reports */
> +       /*
> +        * record the work call stack in order to print it in KASAN reports
> +        * Doing this when CONFIG_PROVE_RAW_LOCK_NESTING is enabled results
> +        * in nesting raw spinlock with page allocation spinlock.
> +        *
> +        * Avoid recording when CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
> +        */
> +#if !defined(CONFIG_PROVE_RAW_LOCK_NESTING)

Just "if (!IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))" should work
here, however...

... PROVE_RAW_LOCK_NESTING exists for PREEMPT_RT's benefit. I don't
think silencing the debugging tool is the solution, because the bug
still exists in a PREEMPT_RT kernel.

+Cc Sebastian for advice. I may have missed something obvious. :-)

I have a suspicion that kasan_record_aux_stack() (via
stack_depot_save()) is generally unsound on PREEMPT_RT kernels,
because allocating memory cannot be done within raw-locked critical
sections because memory allocation is preemptible on RT. Even using
GWP_NOWAIT/ATOMIC doesn't help (which kasan_record_aux_stack() uses).

It follows that if we do not know what type of locks may be held when
calling kasan_record_aux_stack() we have a bug in RT.

I see 3 options:

1. Try to move kasan_record_aux_stack() where no raw lock is held.
(Seems complicated per v1 attempt?)

But ideally we make kasan_record_aux_stack() more robust on RT:

2. Make kasan_record_aux_stack() a no-op on RT (and if
PROVE_RAW_LOCK_NESTING). Perhaps overkill?

3. Try to not allocate memory in stackdepot. Not sure this is feasible
without telling stackdepot to preallocate the max slabs on boot if RT.

Anything else? Because I don't think any of the options are satisfying.

Thanks,
-- Marco

>         kasan_record_aux_stack(work);
> +#endif
>
>         /* we own @work, set data and link */
>         set_work_pwq(work, pwq, extra_flags);
> --
> 2.30.2
>
