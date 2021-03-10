Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6533338FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCJJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCJJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:41:19 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74724C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:41:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a17so24751073ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXkoSTZdLoKg2jgVROL3n8DkphhHYsaXqGSb7Y6KQRU=;
        b=SmNOr8A01cSCeXivBq9rXM9Iqp0sgkBo/yIC0HHWBc8Y5LqEd2iuSHP0GOrnunPZRh
         ruvkBYiRTroxLKFQs6L0+vwvz2Cc3KJSq5K5AlwGfWsVexfH7UZGHFJ3v/l7om/g1yJC
         zbzCSCWMILpf511b7IIIVf3c2TrJAZxAHBuJXOqJBVQq+DxwpqFRNTRrn239iJRqX0pf
         17e+chyZNIt4PBTskJBaAhMbK632dh22wV/WRNtzDCAZHUN08fWIEE+/HA0oPKpuNCmC
         TUmrRdUHqn6SA6I1WzF55cNxkJmoU96myKtn3OTxS5p7dLfdKkcmWaP2D9tHrJBOb3Oy
         Iotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXkoSTZdLoKg2jgVROL3n8DkphhHYsaXqGSb7Y6KQRU=;
        b=fs5dHcCMZu831q+4orl2v0Vf/YVrFRDTqNNuypPgBtXw5s9P16gGKlNVM+ZAkdDrcQ
         ZpMBoC2Rwnq7XE5PJ8d9UnemDoyWTKLw375bKcpn6Pn2Q0EABxu7vBkAOx2GmOevWTKR
         JVHLZE01Qg/iXihhhEZGX0GhgSabrjqoO6le7bcmbt3sO641B+9N6eWpjuVKrPoZwAS3
         P8k9vJua5WdqmamIe06Ex06WmcC00NIC7iMGfM0IRPidtvAlanYMc+h3AlMvY5ijJ6ll
         uhV4e1DuVKAIL76iD71DktK1EcUPUesufxX3FOEcjX1ZawsnGyWCM9vYlNllhVexmB/1
         gi0g==
X-Gm-Message-State: AOAM532lRYyhX0OrFq9ayRddbC8L3uz7N1taKMLAKiIfqFkCSCi4Sm6R
        yhBXLjNMHIJiRbAFOKv04gQLY/CRkPAOGXYiCyU=
X-Google-Smtp-Source: ABdhPJzVrI/RftJvenR3m9j5XAYPboD3zI+72G9RFOzKMzdblNHDF7ketlPQq63g63aU9emOObkgElK+aGqeR9qqsNQ=
X-Received: by 2002:a2e:9195:: with SMTP id f21mr1321491ljg.340.1615369277837;
 Wed, 10 Mar 2021 01:41:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk> <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
 <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk> <CAGyP=7egSA4ZMwdjpYGwKAq=O4P9NzkKQO2ACr_VOUj68-vvzA@mail.gmail.com>
 <CACT4Y+YGKZPDbvLSJJw7oXrZpUJEpvdGm_GxQ0cJ8NsCkWB45g@mail.gmail.com>
In-Reply-To: <CACT4Y+YGKZPDbvLSJJw7oXrZpUJEpvdGm_GxQ0cJ8NsCkWB45g@mail.gmail.com>
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Wed, 10 Mar 2021 15:11:06 +0530
Message-ID: <CAGyP=7eiuUH_JbNEgxdBh4cEHgk82KnbHS0i8PEsJ6D3Exx=pg@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Dmitry Vyukov <dvyukov@google.com>
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

> The kernel stack is not very useful in this case, it's a common faulting stack.
> Maybe it will shed some light if you install gdb in the image, attach
> it to the systemd process, then trigger the segfault and then unwind
> stack in the systemd process at the time of fault, dump registers,
> etc. However, I don't know if gdb will get the signal first, or the
> kernel will panic first...

Here's the gdb trace from the end of open_by_handle_at to the panic. I
will try to attach gdb to systemd and report back.

Thread 1 hit Breakpoint 3, __x64_sys_open_by_handle_at
(regs=0xffffc90000933f58) at fs/fhandle.c:271
271        return ret;
do_syscall_64 (nr=<optimized out>, regs=0xffffc90000933f58) at
arch/x86/entry/common.c:56
56        syscall_exit_to_user_mode(regs);
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:127
127        movq    RCX(%rsp), %rcx
128        movq    RIP(%rsp), %r11
130        cmpq    %rcx, %r11    /* SYSRET requires RCX == RIP */
131        jne    swapgs_restore_regs_and_return_to_usermode
145        ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
153        cmpq    %rcx, %r11
154        jne    swapgs_restore_regs_and_return_to_usermode
156        cmpq    $__USER_CS, CS(%rsp)        /* CS must match SYSRET */
157        jne    swapgs_restore_regs_and_return_to_usermode
159        movq    R11(%rsp), %r11
160        cmpq    %r11, EFLAGS(%rsp)        /* R11 == RFLAGS */
161        jne    swapgs_restore_regs_and_return_to_usermode
181        testq    $(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
182        jnz    swapgs_restore_regs_and_return_to_usermode
186        cmpq    $__USER_DS, SS(%rsp)        /* SS must match SYSRET */
187        jne    swapgs_restore_regs_and_return_to_usermode
195        POP_REGS pop_rdi=0 skip_r11rcx=1
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:201
201        movq    %rsp, %rdi
202        movq    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:205
205        pushq    RSP-RDI(%rdi)    /* RSP */
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:206
206        pushq    (%rdi)        /* RDI */
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:214
214        SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
216        popq    %rdi
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:217
217        popq    %rsp
entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:218
218        USERGS_SYSRET64
native_io_apic_read (apic=<optimized out>, reg=24) at
arch/x86/kernel/apic/io_apic.c:277
277        return readl(&io_apic->data);
59    build_mmio_read(readl, "l", unsigned int, "=r", :"memory")
__ioapic_read_entry (apic=0, pin=<optimized out>) at
arch/x86/kernel/apic/io_apic.c:294
294        entry.w2 = io_apic_read(apic, 0x11 + 2 * pin);
296        return entry;
ioapic_irq_get_chip_state (irqd=<optimized out>, which=<optimized
out>, state=0xffffc90000247a8f) at arch/x86/kernel/apic/io_apic.c:1960
1960            if (rentry.irr && rentry.is_level) {
1952        for_each_irq_pin(p, mcd->irq_2_pin) {
1965        raw_spin_unlock(&ioapic_lock);
1966        return 0;
__synchronize_hardirq (desc=desc@entry=0xffff888003d36c00,
sync_chip=sync_chip@entry=true) at kernel/irq/manage.c:71
71            raw_spin_unlock_irqrestore(&desc->lock, flags);
74        } while (inprogress);
synchronize_irq (irq=4) at kernel/irq/manage.c:138
138            wait_event(desc->wait_for_threads,
138            wait_event(desc->wait_for_threads,
serial8250_do_shutdown (port=port@entry=0xffffffff836b62a0
<serial8250_ports>) at drivers/tty/serial/8250/8250_port.c:2449
2449        if (up->dma)
329        return &lock->rlock;
2453        if (port->flags & UPF_FOURPORT) {
2458            port->mctrl &= ~TIOCM_OUT2;
2460        serial8250_set_mctrl(port, port->mctrl);
2461        spin_unlock_irqrestore(&port->lock, flags);
2467                serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
2466        serial_port_out(port, UART_LCR,
2468        serial8250_clear_fifos(up);
2474        disable_rsa(up);
2481        serial_port_in(port, UART_RX);
2482        serial8250_rpm_put(up);
2484        up->ops->release_irq(up);
uart_port_shutdown (port=port@entry=0xffff8880054e0000) at
drivers/tty/serial/serial_core.c:1716
1716            synchronize_irq(uport->irq);
uart_shutdown (tty=tty@entry=0xffff88800451c400,
state=state@entry=0xffff8880054e0000) at
drivers/tty/serial/serial_core.c:307
307        tty_port_set_suspended(port, 0);
315        uart_port_lock(state, flags);
316        xmit_buf = state->xmit.buf;
317        state->xmit.buf = NULL;
318        uart_port_unlock(uport, flags);
320        if (xmit_buf)
321            free_page((unsigned long)xmit_buf);
uart_hangup (tty=tty@entry=0xffff88800451c400) at ./include/linux/spinlock.h:329
329        return &lock->rlock;
1680            spin_unlock_irqrestore(&port->lock, flags);
1681            tty_port_set_active(port, 0);
1682            tty_port_tty_set(port, NULL);
1683            if (uport && !uart_console(uport))
1685            wake_up_interruptible(&port->open_wait);
1686            wake_up_interruptible(&port->delta_msr_wait);
1688        mutex_unlock(&port->mutex);
__tty_hangup (tty=tty@entry=0xffff88800451c400,
exit_session=exit_session@entry=1) at drivers/tty/tty_io.c:651
651        set_bit(TTY_HUPPED, &tty->flags);
652        clear_bit(TTY_HUPPING, &tty->flags);
653        tty_unlock(tty);
655        if (f)
disassociate_ctty (on_exit=on_exit@entry=1) at drivers/tty/tty_jobctrl.c:279
279            tty_kref_put(tty);
295        spin_lock_irq(&current->sighand->siglock);
15        return this_cpu_read_stable(current_task);
298        tty = tty_kref_get(current->signal->tty);
299        spin_unlock_irq(&current->sighand->siglock);
301        if (tty) {
316        read_lock(&tasklist_lock);
317        session_clear_tty(task_session(current));
318        read_unlock(&tasklist_lock);
do_exit (code=code@entry=7) at kernel/exit.c:824
824        exit_task_namespaces(tsk);
825        exit_task_work(tsk);
826        exit_thread(tsk);
834        perf_event_exit_task(tsk);
836        sched_autogroup_exit_task(tsk);
837        cgroup_exit(tsk);
842        flush_ptrace_hw_breakpoint(tsk);
844        exit_tasks_rcu_start();
845        exit_notify(tsk, group_dead);
846        proc_exit_connector(tsk);
847        mpol_put_task_policy(tsk);
849        if (unlikely(current->pi_state_cache))
15        return this_cpu_read_stable(current_task);
857        if (tsk->io_context)
858            exit_io_context(tsk);
860        if (tsk->splice_pipe)
863        if (tsk->task_frag.page)
869        preempt_disable();
870        if (tsk->nr_dirtied)
871            __this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);
872        exit_rcu();
873        exit_tasks_rcu_finish();
876        do_task_dead();


> FWIW I can't reproduce this locally on wheezy/stretch images.

These are the reproducers I have for this bug from various ext4 images-
Repro 1 -
r0 = creat(&(0x7f0000000180)='./file0\x00', 0x0)
open_by_handle_at(r0, &(0x7f0000000000)={0xa, 0x1, "b70b"}, 0x40200)
Repro 2 -
r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
open_by_handle_at(r0,
&(0x7f0000000000)=ANY=[@ANYBLOB="0a000000020000004b0d"], 0x2f00)
Repro 3 -
r0 = creat(&(0x7f0000000040)='./file0\x00', 0x0)
open_by_handle_at(r0,
&(0x7f0000000080)=ANY=[@ANYBLOB="2700000001000000d10b"], 0x2f00)

Have you tried running syzkaller with "enable_syscalls":
["creat","open_by_handle_at"]? It takes about an hour on my system to
identify this bug for a new image.
I'm using the stretch images.
