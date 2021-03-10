Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923C3333850
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhCJJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhCJJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:24 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB21C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:08:24 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so12478642qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lelg7Ymcsrx96H/9Hjjx+m4usnhjyVxAi/WxnBdwd2k=;
        b=O+i3cCDDegpOwRxcpOsL1eL7HO5uvDSQcvx8EPj6qeYl7MrGO1g0s2cLRvM9xN3xn+
         i0Ff/gOPl+rMsC//4T1x+dqg2MPjKMoZgqVJOFAyGFVK+DX8/jRrzDnXG1qMtFzbBDw8
         eAFPN2bw6r/K05PcCh7q9+G7tAK8L6OddCe3G4Gz1jW9QM+ETU78q562d6RnrxLft8HN
         ArNLlINMSq2SU50k5wBBkLtFQFUQsBvCz6zBVyA1/a+YNgRmNSYjPRfkSvEPs0dKeEr6
         QnbedkohHNaLpVzQ2tTdUKyHbLzgsu9RQ8T3J7b3NgXtqNnHxMhNyesUi7ey5H+XXU/x
         /zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lelg7Ymcsrx96H/9Hjjx+m4usnhjyVxAi/WxnBdwd2k=;
        b=XstaRxVhh3fd0tgECZ9XJZ6DzbvMm7NgcUrhi36h/Trlh3DPlXDtovlGqsuFI0Szqo
         V5MFozl+QpFtqi2hlBW1t0BoRqMg10x4Kxw3/Uq2QS4aukov6FIp6ksiz5vLRX3nTRsI
         74kLsUkVsIzypbh84glUD4LsbWfDuraySw0KS584l8KNs4o2R8FstzGP5FiOFaDMN6pu
         /IrzrKxaUeE4lyW30TesIHkc9uodEq63vdSpn6GTf7eyF0QwH8YS9O81kiJzOM2TTUMs
         Ysb12HmM65xPDOiXCqzWAQ6k8rvw/eGvSvoUbANo2FuyLkNmPFTFxS/DanJZaKlYbu7o
         EdVg==
X-Gm-Message-State: AOAM530l+gWccpAfVtQ5kNXgz0OuO4zBOTAVXoRxR3mmUuie7GvqTuw7
        N7NByo/LEZFOK2ru3HNdsLg5g21aGjvDQFb0+JZKfA==
X-Google-Smtp-Source: ABdhPJxxhIe+6f0rzAHqBkwI2qc7HvPiY89oGcWaIuMo6rqoLnYO8cIyK5OmLM9Qn+CMfIHWfs9PNS3pXYC3dkPfqCg=
X-Received: by 2002:aed:2c61:: with SMTP id f88mr1774089qtd.337.1615367303536;
 Wed, 10 Mar 2021 01:08:23 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk> <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
 <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk> <CAGyP=7egSA4ZMwdjpYGwKAq=O4P9NzkKQO2ACr_VOUj68-vvzA@mail.gmail.com>
In-Reply-To: <CAGyP=7egSA4ZMwdjpYGwKAq=O4P9NzkKQO2ACr_VOUj68-vvzA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Mar 2021 10:08:12 +0100
Message-ID: <CACT4Y+YGKZPDbvLSJJw7oXrZpUJEpvdGm_GxQ0cJ8NsCkWB45g@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Palash Oswal <oswalpalash@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:02 AM Palash Oswal <oswalpalash@gmail.com> wrote:
>
> On Tue, Mar 9, 2021 at 7:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Lovely.  So something in that sequence of syscalls manages to trigger
> > segfault in unrelated process.  What happens if you put it to sleep
> > right after open_by_handle_at() (e.g. by read(2) from fd 0, etc.)?
>
> Added read(2) call in the reproducer, and there's no longer a segfault
> in systemd, but the process is still killed
>   syscall(__NR_open_by_handle_at, r[0], 0x20000000ul, 0x2f00ul);
> +  unsigned char buffer[1];
> +  read(0, buffer, 1);
>   return 0;
>
> root@sandbox:~# gcc -pthread repro.c -o repro
> root@sandbox:~# ./repro
> [  450.676798] got to 221
> [  450.676881] got to 183
> [  450.677655] got to 201
> [  450.678042] got to 208
> [  450.678349] got to 210
> [  450.681404] got to 270
> [  450.707100] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [  450.708393] CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.2+ #22
> [  450.709105] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.14.0-1 04/01/2014
> [  450.710117] Call Trace:
> [  450.710440]  dump_stack+0xb2/0xe4
> [  450.710902]  panic+0x196/0x502
> [  450.711277]  do_exit.cold+0x70/0x108
> [  450.711710]  do_group_exit+0x78/0x120
> [  450.712161]  get_signal+0x22e/0xd60
> [  450.712588]  arch_do_signal_or_restart+0xef/0x890
> [  450.713165]  exit_to_user_mode_prepare+0x102/0x190
> [  450.713744]  irqentry_exit_to_user_mode+0x9/0x20
> [  450.714340]  irqentry_exit+0x19/0x30
> [  450.714817]  exc_page_fault+0xc3/0x240
> [  450.715275]  ? asm_exc_page_fault+0x8/0x30
> [  450.715805]  asm_exc_page_fault+0x1e/0x30
> [  450.716295] RIP: 0033:0x7febb8036f10
> [  450.716738] Code: Unable to access opcode bytes at RIP 0x7febb8036ee6.
> [  450.717512] RSP: 002b:00007ffd91fec2f8 EFLAGS: 00010246
> [  450.718139] RAX: 0000000000000000 RBX: 000055c6cc268f40 RCX: 00007febb80672e3
> [  450.719030] RDX: 00007ffd91fec480 RSI: 00007ffd91fec5b0 RDI: 0000000000000007
> [  450.719877] RBP: 0000000000000007 R08: 431bde82d7b634db R09: 000000000000000b
> [  450.720681] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd927eb4d0
> [  450.721527] R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
> [  450.722470] Kernel Offset: disabled
> [  450.722941] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> Added a hb at panic() and here's the backtrace from gdb:
> (gdb) hb kernel/panic.c:177
> Hardware assisted breakpoint 1 at 0xffffffff82201bd7: file
> kernel/panic.c, line 178.
> (gdb) c
> Continuing.
> Thread 1 hit Breakpoint 1, panic (fmt=fmt@entry=0xffffffff82bcd850
> "Attempted to kill init! exitcode=0x%08x\n") at kernel/panic.c:178
> 178    {
> (gdb) bt
> #0  panic (fmt=fmt@entry=0xffffffff82bcd850 "Attempted to kill init!
> exitcode=0x%08x\n") at kernel/panic.c:178
> #1  0xffffffff822025a3 in do_exit (code=code@entry=11) at kernel/exit.c:794
> #2  0xffffffff810e6e98 in do_group_exit (exit_code=11) at kernel/exit.c:922
> #3  0xffffffff810febae in get_signal
> (ksig=ksig@entry=0xffffc90000013e38) at kernel/signal.c:2773
> #4  0xffffffff8104fa8f in arch_do_signal_or_restart
> (regs=0xffffc90000013f58, has_signal=<optimized out>) at
> arch/x86/kernel/signal.c:831
> #5  0xffffffff811a0602 in handle_signal_work (ti_work=<optimized out>,
> regs=0xffffc90000013f58) at kernel/entry/common.c:147
> #6  exit_to_user_mode_loop (ti_work=<optimized out>, regs=<optimized
> out>) at kernel/entry/common.c:171
> #7  exit_to_user_mode_prepare (regs=0xffffc90000013f58) at
> kernel/entry/common.c:201
> #8  0xffffffff8227a299 in irqentry_exit_to_user_mode (regs=<optimized
> out>) at kernel/entry/common.c:307
> #9  0xffffffff8227a2c9 in irqentry_exit
> (regs=regs@entry=0xffffc90000013f58, state=..., state@entry=...) at
> kernel/entry/common.c:395
> #10 0xffffffff82279c83 in exc_page_fault (regs=0xffffc90000013f58,
> error_code=20) at arch/x86/mm/fault.c:1509
> #11 0xffffffff82400ade in asm_exc_page_fault () at
> ./arch/x86/include/asm/idtentry.h:580
> #12 0x0000000000000002 in fixed_percpu_data ()
> #13 0xffffffffffffffff in ?? ()
> #14 0x0000000000000001 in fixed_percpu_data ()
> #15 0x00007ffdef6e1480 in ?? ()
> #16 0x0000000000000007 in fixed_percpu_data ()
> #17 0x000055a7e97caf40 in ?? ()
> #18 0x0000000000000246 in ?? ()
> #19 0x00000000ffffffff in ?? ()
> #20 0x000000000000000b in fixed_percpu_data ()
> #21 0x0000000000000000 in ?? ()

The kernel stack is not very useful in this case, it's a common faulting stack.
Maybe it will shed some light if you install gdb in the image, attach
it to the systemd process, then trigger the segfault and then unwind
stack in the systemd process at the time of fault, dump registers,
etc. However, I don't know if gdb will get the signal first, or the
kernel will panic first...
FWIW I can't reproduce this locally on wheezy/stretch images.
