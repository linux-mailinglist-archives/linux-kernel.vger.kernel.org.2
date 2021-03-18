Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940303402B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCRKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCRKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:05:45 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB466C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:05:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o19so2922730qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8pU7BHHO/LeXmRyXlL2LvIpm+c3b0DZixAYPVYjH/A=;
        b=jvsZE911gwbVoyyKp3ORIzW7H+pE6FwglTK3NNWMxDvaKyYc8WSyeUZ4oSsI3hWmpB
         lQPUASIWENw2jO5uV/QfTau3ANqGHqxRgF1x45rRhobivpKAQwIYS6H+2z7rkeBippkb
         7oe/uHQAy/ogH+Na6KL2EJ+ofoKfanWPXyhoXW7uT7ZmDZP4dv2LzXKHMEoYggC3C1WW
         XBH/w8vlbkiIM/LZ4KXS5kUbafsOdhpquwk2TdqHzq2BjsJOgcqM8S3tI5DZ5bUlxC92
         OqrS2JDJ6FJIONLzm6ZNuUscbwQI7tnKPxhFhbDio0GCfSAavfkYdmIiqz8S/L/oUYxz
         vcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8pU7BHHO/LeXmRyXlL2LvIpm+c3b0DZixAYPVYjH/A=;
        b=XRecAKJAL3ztXdo9lcSvG7hhNWoe6+Bx1mB9rhFZO4nQIXeNbKnyukErjW/j+RPMH2
         HuHzxNeUFL69xKDnBqLPzHYt8iapO69MkuW3oKH5YJCqBEdn2CoUtRkZrtZip4a9AQi5
         qEgrGnZh0ntldU2YzYYE13GDKTGSQOG7/pewXnWLZJu2+al0n5idqGwPBFlY7pGsgliC
         YFjy/yT1LoK0KRJCmeU/kB0k2a/brRV4hAiDbUrE2ZuePGFH/0sWmJnNpOEHH2o/KFSJ
         9DZLjpiO2KtIKG/WFG67lixXOYUmSf89zd/ScQNlPUzCW5hQWQ35o2vLnb//HInbBl67
         vK8w==
X-Gm-Message-State: AOAM532Ee/hiJS0rC81FiPFr0XkwAXQXGERbis59VTjnDJpVippqdUWN
        JkRs0mNOE6515AHQYZnbIVLcZ/qX+o3KaZXzhVH+rw==
X-Google-Smtp-Source: ABdhPJw9USUK0PJ8ldWYaizymkquXfJ56gGBYzuyjcVFZNEPtP1euvL42k/3/foathLFkpysZZC1KgYZ82mAxtMTEEU=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr3416885qvb.23.1616061943599;
 Thu, 18 Mar 2021 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk> <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <aa801bc7-cf6f-b77a-bbb0-28b0ff36e8ba@codethink.co.uk> <816870e9-9354-ffbd-936b-40e38e4276a4@codethink.co.uk>
 <4ce57c7e-6e5d-d136-0a81-395a4207ba44@codethink.co.uk> <CACT4Y+ZJwJ9vcgCyabDUny0CnYmbHLRqU6m_KccdObS+7bBoGw@mail.gmail.com>
 <CACT4Y+ay21Cw8TtUdyDAzXAJaqpDPyCKNW6XF1GKsHoNeL=qKw@mail.gmail.com> <38efd34b-1ac5-f2a5-d090-83f909b3b87f@codethink.co.uk>
In-Reply-To: <38efd34b-1ac5-f2a5-d090-83f909b3b87f@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 11:05:31 +0100
Message-ID: <CACT4Y+aTZZOGbY3r0bobO1+wEt4-r83KXbt1aGnp7xQ+Ji6gZw@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Terry Hu <kejia.hu@codethink.co.uk>,
        =?UTF-8?Q?Javier_Jard=C3=B3n?= <javier.jardon@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:41 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 12/03/2021 17:38, Dmitry Vyukov wrote:
> > On Fri, Mar 12, 2021 at 6:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> On Fri, Mar 12, 2021 at 5:36 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >>>
> >>> On 12/03/2021 16:34, Ben Dooks wrote:
> >>>> On 12/03/2021 16:30, Ben Dooks wrote:
> >>>>> On 12/03/2021 15:12, Dmitry Vyukov wrote:
> >>>>>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
> >>>>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
> >>>>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> syzbot found the following issue on:
> >>>>>>>>>
> >>>>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
> >>>>>>>>> arch_dup_tas..
> >>>>>>>>> git tree:
> >>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>>>>>>>> console output:
> >>>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
> >>>>>>>>> kernel config:
> >>>>>>>>> https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> >>>>>>>>> dashboard link:
> >>>>>>>>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
> >>>>>>>>> userspace arch: riscv64
> >>>>>>>>>
> >>>>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>>>>
> >>>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to
> >>>>>>>>> the commit:
> >>>>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
> >>>>>>>>
> >>>>>>>> +riscv maintainers
> >>>>>>>>
> >>>>>>>> This is riscv64-specific.
> >>>>>>>> I've seen similar crashes in put_user in other places. It looks like
> >>>>>>>> put_user crashes in the user address is not mapped/protected (?).
> >>>>>>>
> >>>>>>> I've been having a look, and this seems to be down to access of the
> >>>>>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
> >>>>>>> bad address to clone?
> >>>>>>>
> >>>>>>>    From looking at the code, the put_user() code should have set the
> >>>>>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
> >>>>>>> s2 register in the crash report) and from looking at the compiler
> >>>>>>> output from my gcc-10, the code looks to be dong the relevant csrs
> >>>>>>> and then csrc around the put_user
> >>>>>>>
> >>>>>>> So currently I do not understand how the above could have happened
> >>>>>>> over than something re-tried the code seqeunce and ended up retrying
> >>>>>>> the faulting instruction without the SR_SUM bit set.
> >>>>>>
> >>>>>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
> >>>>>> strange that 99% of these crashes are in schedule_tail. If it would be
> >>>>>> qemu, then they would be more evenly distributed...
> >>>>>>
> >>>>>> Another observation: looking at a dozen of crash logs, in none of
> >>>>>> these cases fuzzer was actually trying to fuzz clone with some insane
> >>>>>> arguments. So it looks like completely normal clone's (e..g coming
> >>>>>> from pthread_create) result in this crash.
> >>>>>>
> >>>>>> I also wonder why there is ret_from_exception, is it normal? I see
> >>>>>> handle_exception disables SR_SUM:
> >>>>>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73
> >>>>>>
> >>>>>
> >>>>> So I think if SR_SUM is set, then it faults the access to user memory
> >>>>> which the _user() routines clear to allow them access.
> >>>>>
> >>>>> I'm thinking there is at least one issue here:
> >>>>>
> >>>>> - the test in fault is the wrong way around for die kernel
> >>>>> - the handler only catches this if the page has yet to be mapped.
> >>>>>
> >>>>> So I think the test should be:
> >>>>>
> >>>>>           if (!user_mode(regs) && addr < TASK_SIZE &&
> >>>>>                           unlikely(regs->status & SR_SUM)
> >>>>>
> >>>>> This then should continue on and allow the rest of the handler to
> >>>>> complete mapping the page if it is not there.
> >>>>>
> >>>>> I have been trying to create a very simple clone test, but so far it
> >>>>> has yet to actually trigger anything.
> >>>>
> >>>> I should have added there doesn't seem to be a good way to use mmap()
> >>>> to allocate memory but not insert a vm-mapping post the mmap().
> >>>>
> >>> How difficult is it to try building a branch with the above test
> >>> modified?
> >>
> >> I don't have access to hardware, I don't have other qemu versions ready to use.
> >> But I can teach you how to run syzkaller locally :)
> >> I am not sure anybody run it on real riscv hardware at all. When
> >> Tobias ported syzkaller, Tobias also used qemu I think.
> >>
> >> I am now building with an inverted check to test locally.
> >>
> >> I don't fully understand but this code, but does handle_exception
> >> reset SR_SUM around do_page_fault? If so, then looking at SR_SUM in
> >> do_page_fault won't work with positive nor negative check.
> >
> >
> > The inverted check crashes during boot:
> >
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -249,7 +249,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
> >                  flags |= FAULT_FLAG_USER;
> >
> >          if (!user_mode(regs) && addr < TASK_SIZE &&
> > -                       unlikely(!(regs->status & SR_SUM)))
> > +                       unlikely(regs->status & SR_SUM))
> >                  die_kernel_fault("access to user memory without
> > uaccess routines",
> >                                  addr, regs);
> >
> >
> > [   77.349329][    T1] Run /sbin/init as init process
> > [   77.868371][    T1] Unable to handle kernel access to user memory
> > without uaccess routines at virtual address 00000000000e8e39
> > [   77.870355][    T1] Oops [#1]
> > [   77.870766][    T1] Modules linked in:
> > [   77.871326][    T1] CPU: 0 PID: 1 Comm: init Not tainted
> > 5.12.0-rc2-00010-g0d7588ab9ef9-dirty #42
> > [   77.872057][    T1] Hardware name: riscv-virtio,qemu (DT)
> > [   77.872620][    T1] epc : __clear_user+0x36/0x4e
> > [   77.873285][    T1]  ra : padzero+0x9c/0xb0
> > [   77.873849][    T1] epc : ffffffe000bb7136 ra : ffffffe0004f42a0 sp
> > : ffffffe006f8fbc0
> > [   77.874438][    T1]  gp : ffffffe005d25718 tp : ffffffe006f98000 t0
> > : 00000000000e8e40
> > [   77.875031][    T1]  t1 : 00000000000e9000 t2 : 000000000001c49c s0
> > : ffffffe006f8fbf0
> > [   77.875618][    T1]  s1 : 00000000000001c7 a0 : 00000000000e8e39 a1
> > : 00000000000001c7
> > [   77.876204][    T1]  a2 : 0000000000000002 a3 : 00000000000e9000 a4
> > : ffffffe006f99000
> > [   77.876787][    T1]  a5 : 0000000000000000 a6 : 0000000000f00000 a7
> > : ffffffe00031c088
> > [   77.877367][    T1]  s2 : 00000000000e8e39 s3 : 0000000000001000 s4
> > : 0000003ffffffe39
> > [   77.877952][    T1]  s5 : 00000000000e8e39 s6 : 00000000000e9570 s7
> > : 00000000000e8e39
> > [   77.878535][    T1]  s8 : 0000000000000001 s9 : 00000000000e8e39
> > s10: ffffffe00c65f608
> > [   77.879126][    T1]  s11: ffffffe00816e8d8 t3 : ea3af0fa372b8300 t4
> > : 0000000000000003
> > [   77.879711][    T1]  t5 : ffffffc401dc45d8 t6 : 0000000000040000
> > [   77.880209][    T1] status: 0000000000040120 badaddr:
> > 00000000000e8e39 cause: 000000000000000f
> > [   77.880846][    T1] Call Trace:
> > [   77.881213][    T1] [<ffffffe000bb7136>] __clear_user+0x36/0x4e
> > [   77.881912][    T1] [<ffffffe0004f523e>] load_elf_binary+0xf8a/0x2400
> > [   77.882562][    T1] [<ffffffe0003e1802>] bprm_execve+0x5b0/0x1080
> > [   77.883145][    T1] [<ffffffe0003e38bc>] kernel_execve+0x204/0x288
> > [   77.883727][    T1] [<ffffffe003b70e94>] run_init_process+0x1fe/0x212
> > [   77.884337][    T1] [<ffffffe003b70ec6>] try_to_run_init_process+0x1e/0x66
> > [   77.884956][    T1] [<ffffffe003bc0864>] kernel_init+0x14a/0x200
> > [   77.885541][    T1] [<ffffffe000005570>] ret_from_exception+0x0/0x14
> > [   77.886955][    T1] ---[ end trace 1e934d07b8a4bed8 ]---
> > [   77.887705][    T1] Kernel panic - not syncing: Fatal exception
> > [   77.888333][    T1] SMP: stopping secondary CPUs
> > [   77.889357][    T1] Rebooting in 86400 seconds..
>
> I have reproduced this on qemu, not managed to get the real hardwre
> working with this branch yet.
>
> I have a working hypothesis now, having added debug to check the
> sstatus.SR_SUM flag and reviewed the assembly, I think this is
> what is happening:
>
> C code of "put_user(func(), address)" is generating code to do:
>
> 1:      __enable_user_access();
> 2:      cpu_reg = func();
> 3:      assembly for *address = cpu_reg;
> 4:      __disable_user_access();
>
> I think the call to func() with all the sanitisers enabled allow
> the func() to possibly schedule out. The __swtich_to() code does
> not restore the original status registers which means that if
> there is IO during the sleep SR_SUM may end up being cleared and
> never re-set. We get back to 3 and fault as 2 cleared the result of 1.
>
> It is very possible no-one has seen this before as generally the
> functions involved in feeding put_user() are fairly small and thus
> this system is both under load and has some reason to schedule then
> this bug has probably been rare to unseen.
>
> I think the correct solution is to store the SR_SUM bit status in
> the thread_struct and make __switch_to() save/restore this when
> changing between tasks/threads. Trying to re-order the code to
> force swapping of 1 and 2 may reduce the bug's window.
>
> Further thinking of the order of 1 and 2 is that we should probably
> fix that order so that func() is not run with the user-space access
> protection disabled.
>
> I'll try and make some sort of of small test case to avoid having
> to run syz-stress to provoke this.

Ouch!
Can't preempt kernel schedule at almost any instruction where
preemption is not disabled explicitly?  But if it's disabled, then the
instrumented code won't schedule as well, right? I suspect this may be
quite a bad issue for preempt kernels.

Shouldn't __put_user materialize the expression in a local var using
__typeof__ magic before __enable_user_access? I suspect it may
potentially lead to quite bad security implications.

It can also make sense to add checks to schedule to check that it's
not called from unexpected contexts.
