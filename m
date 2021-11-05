Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B329E44640A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhKENXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhKENXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:23:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBF5610FD;
        Fri,  5 Nov 2021 13:21:11 +0000 (UTC)
Date:   Fri, 5 Nov 2021 09:21:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rosted@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [syzbot] possible deadlock in ktime_get_coarse_ts64
Message-ID: <20211105092108.71cd14ac@gandalf.local.home>
In-Reply-To: <87lf224uki.ffs@tglx>
References: <00000000000013aebd05cff8e064@google.com>
        <87lf224uki.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Nov 2021 14:10:21 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> > -> #0 (tk_core.seq.seqcount){----}-{0:0}:  
> >        check_prev_add kernel/locking/lockdep.c:3051 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
> >        validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
> >        __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
> >        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
> >        seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
> >        ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
> >        ktime_get_coarse include/linux/timekeeping.h:120 [inline]
> >        ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]  
> 
> --> this call is invalid  
> 
> >        ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
> >        bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
> >        bpf_prog_a99735ebafdda2f1+0x10/0xb50
> >        bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
> >        __bpf_prog_run include/linux/filter.h:626 [inline]
> >        bpf_prog_run include/linux/filter.h:633 [inline]
> >        BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
> >        trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
> >        perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
> >        perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
> >        trace_lock_release+0x128/0x150 include/trace/events/lock.h:58  
> 
> Timestamps from within a tracepoint can only be taken with:
> 
>          1) jiffies
>          2) sched_clock()
>          3) ktime_get_*_fast_ns()

This is why we have tracing clocks:

include/linux/trace_clock.h:

  trace_clock_local()
  trace_clock()
  trace_clock_jiffies()
  trace_clock_global()
  trace_clock_counter()

And perf uses its own clock, which is either local_clock() or one of the
ktime_get_*_ns() clocks.

-- Steve

> 
> Those are NMI safe and can be invoked from anywhere.
> 
> All other time getters which have to use the timekeeping seqcount
> protection are prone to live locks and _cannot_ be used from
> tracepoints ever.
> 
> This restriction exists since day one of tracepoints and is not
> magically going away for BPF.
