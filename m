Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DC4463DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhKENND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:13:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKENNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:13:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636117821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPWC8jQewkfGDLEH4jppRovKUEtYI9LoKKxunmdFFp4=;
        b=YuJx8f4PO4KHawMFpwrQqQLb43VmEusfoO3IafxTEPGnpMxFeiVJ98Go9vVpVWoIhT+CQE
        g3lpxsaldOxQUfskm1w7TfejSstPlHynR3FmwxBzghPsW0728Pflc7TbhwMYiNd6zTz0Ys
        d4V2PVOJ1OcysqyuTCqmv1uiXJz41astHUzrFZNMTH/N71Qqygeipn0nSTTI0f7ZRWVwHC
        XU3mr1NOo50kkeEVjfI767/zqbCN16pMxqZ+Lsr/uRCZgMMd64+OszrtazcCzuM1+69dkb
        ubMdqjp5MImiONVDyXMQSowN1mxnTNDJTrC+BZ/L6qaetplCbdlmQKCgRbHe3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636117821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPWC8jQewkfGDLEH4jppRovKUEtYI9LoKKxunmdFFp4=;
        b=RbjR10L46Uuairuw6Z0qnsDknHuc3Xevd+A33nbWZ0r1InJE3s9L9RrqrKoC0X/fRCN9CC
        t+sW/RB7ZqrTtfBA==
To:     syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rosted@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [syzbot] possible deadlock in ktime_get_coarse_ts64
In-Reply-To: <00000000000013aebd05cff8e064@google.com>
References: <00000000000013aebd05cff8e064@google.com>
Date:   Fri, 05 Nov 2021 14:10:21 +0100
Message-ID: <87lf224uki.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04 2021 at 09:18, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    dcd68326d29b Merge tag 'devicetree-for-5.16' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a3576ab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a89cd86e20989871
> dashboard link: https://syzkaller.appspot.com/bug?extid=43fd005b5a1b4d10781e
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.

No need to look for an reproducer. The wreckage is entirely clear.

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.15.0-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.4/14877 is trying to acquire lock:
> ffffffff8cb30008 (tk_core.seq.seqcount){----}-{0:0}, at: ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
>
> but task is already holding lock:
> ffffffff90dbf200 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_deactivate+0x61/0x400 lib/debugobjects.c:735
>
> which lock already depends on the new lock.

Actually it does not matter at all which lock is held. The wreckage is
more fundamental.

> the existing dependency chain (in reverse order) is:
>
> -> #1 (&obj_hash[i].lock){-.-.}-{2:2}:
>        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
>        __debug_object_init+0xd9/0x1860 lib/debugobjects.c:569
>        debug_hrtimer_init kernel/time/hrtimer.c:414 [inline]
>        debug_init kernel/time/hrtimer.c:468 [inline]
>        hrtimer_init+0x20/0x40 kernel/time/hrtimer.c:1592
>        ntp_init_cmos_sync kernel/time/ntp.c:676 [inline]
>        ntp_init+0xa1/0xad kernel/time/ntp.c:1095
>        timekeeping_init+0x512/0x6bf kernel/time/timekeeping.c:1639
>        start_kernel+0x267/0x56e init/main.c:1030
>        secondary_startup_64_no_verify+0xb1/0xbb
>
> -> #0 (tk_core.seq.seqcount){----}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3051 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
>        validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
>        __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
>        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
>        seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
>        ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
>        ktime_get_coarse include/linux/timekeeping.h:120 [inline]
>        ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]

--> this call is invalid

>        ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
>        bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
>        bpf_prog_a99735ebafdda2f1+0x10/0xb50
>        bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
>        __bpf_prog_run include/linux/filter.h:626 [inline]
>        bpf_prog_run include/linux/filter.h:633 [inline]
>        BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
>        trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
>        perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
>        perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
>        trace_lock_release+0x128/0x150 include/trace/events/lock.h:58

Timestamps from within a tracepoint can only be taken with:

         1) jiffies
         2) sched_clock()
         3) ktime_get_*_fast_ns()

Those are NMI safe and can be invoked from anywhere.

All other time getters which have to use the timekeeping seqcount
protection are prone to live locks and _cannot_ be used from
tracepoints ever.

This restriction exists since day one of tracepoints and is not
magically going away for BPF.

Thanks,

        tglx
