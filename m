Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5041DBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351598AbhI3OEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbhI3OET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:04:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D98C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tQboQTcD1N1FePoJYPb6M5S53Z3ZDiFTeR4eh78duLs=; b=rHc2dOWowH9SDYNWbQmP5/pr7s
        VNk42yUxqjkJ3wSBubK4I4BT2lCeWXFxgXJjqq9z8tUVgfbiITPAR1I5WKE0Qbe2G11iyv/Vb98Tf
        RyL1CYYLm0IVk+ujzDGHpO6TJ21SA5NB9JvaQsxQ6lCATS4cw5UYzDDHudGibm6Wmx6J/b18yu1Us
        SmXxPlfaHC/sexrCiadws7sURCsqBf7Rrtm8R7K4Bq/znscO6TFfu91lwDFk/S3wC/oI3qXIvQKyL
        Lf7bZmtWwMxp+1Na8dATphEmF+f6jrtuEiucGgxH4va1ATIQxEHnRSWap9yfXcZe3o2Ve6wx9okxx
        bj1vME5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVwb8-00CvGt-Jm; Thu, 30 Sep 2021 14:00:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C97D2300268;
        Thu, 30 Sep 2021 15:59:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD77D212EE537; Thu, 30 Sep 2021 15:59:41 +0200 (CEST)
Date:   Thu, 30 Sep 2021 15:59:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rseq with syscall as the last instruction
Message-ID: <YVXCzW+JHvClGG76@hirez.programming.kicks-ass.net>
References: <CACT4Y+bgzorbDgYw=cguZ4WuZeLbqsdyKUeGiyQq3Vo9jyjs6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bgzorbDgYw=cguZ4WuZeLbqsdyKUeGiyQq3Vo9jyjs6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:09:24AM +0200, Dmitry Vyukov wrote:
> Hi rseq maintainers,
> 
> I wonder if rseq can be used in the following scenario (or extended to be used).
> I want to pass extra arguments to syscalls using a kind of
> side-channel, for example, to say "do fault injection for the next
> system call", or "trace the next system call". But what is "next"
> system call should be atomic with respect to signals.
> Let's say there is shared per-task memory location known to the kernel
> where these arguments can be stored:
> 
> __thread struct trace_descriptor desk;
> prctl(REGISTER_PER_TASK_TRACE_DESCRIPTOR, &desk);
> 
> then before a system call I can setup the descriptor to enable tracing:
> 
> desk = ...
> SYSCALL;
> 
> The problem is that if a signal arrives in between we setup desk and
> SYSCALL instruction, we will actually trace some unrelated syscall in
> the signal handler.
> Potentially the kernel could switch/restore 'desk' around syscall
> delivery, but it becomes tricky/impossible for signal handlers that do
> longjmp or mess with PC in other ways; and also would require
> extending ucontext to include the desc information (not sure if it's
> feasible).
> 
> So instead the idea is to protect this sequence with rseq that will be
> restarted on signal delivery:
> 
> enter rseq critical section with end right after SYSCALL instruction;
> desk = ...
> SYSCALL;
> 
> Then, the kernel can simply clear 'desc', on syscall delivery.
> 
> rseq docs seem to suggest that this can work:
> 
> https://lwn.net/Articles/774098/
> +Restartable sequences are atomic with respect to preemption (making it
> +atomic with respect to other threads running on the same CPU), as well
> +as signal delivery (user-space execution contexts nested over the same
> +thread). They either complete atomically with respect to preemption on
> +the current CPU and signal delivery, or they are aborted.
> 
> But the doc also says that the sequence must not do syscalls:
> 
> +Restartable sequences must not perform system calls. Doing so may result
> +in termination of the process by a segmentation fault.
> 
> The question is:
> Can this restriction be weakened to allow syscalls as the last instruction?
> For flags in this case we would pass
> RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT and
> RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE, but no
> RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL.
> 
> I don't see any fundamental reasons why this couldn't work b/c if we
> restart only on signals, then once we reach the syscall, rseq critical
> section is committed, right?
> 
> Do you have any feeling of how hard it would be to support or if there
> can be some implementation issues?

IIRC the only enforcement of this constraint is rseq_syscall() (which is
a NOP when !CONFIG_DEBUG_RSEQ, because performance).

However, since we use regs->ip, which for SYSCALL points to right
*after* the SYSCALL instruction (for obvious reasons), it will not in
fact match in_rseq_cs().

And as such, I think your scheme should just work as is. Did you try?
