Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56930336C77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCKGua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCKGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:50:29 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:50:28 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id n79so19638963qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHiNjCVzAF9f5ZQqYFH1xiJqt7vBsG0ih+SnubPBSag=;
        b=NhHfEjub5LruGGgnVMh3pytD99vGgrf11LNfUyPKvJWH91nm6usIh7jF6qFOYQflX/
         sNFYmzSfLMuSW3fnmxsyxI4QmvAz3yaPKH1aZsaE4BtlMwpB9WeNOBK6LWJ7M2pip8tE
         PwYeJ0XEFxL2L2BKrz1kN44mGw1vjEA7Xc6FXK3uvfPJHwXdnxc4n9U39mwO/gv055Dw
         PZr9+0XH7jYep2sM5NfG9U3QeTsul+cCY/LPpovZyhcjBBk3knRNRkCgWY2m5hQZxq3Y
         BWFNsq+KPlMzF0Kp/r96hjM+/AkLLycDeE3YP0zSl3dbodaizA1ETlF9RgqFUCfqEbyC
         MGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHiNjCVzAF9f5ZQqYFH1xiJqt7vBsG0ih+SnubPBSag=;
        b=ukcqr7AoORWZ3shMkfCO+1ABx70DgitAwSmZlYxsbrU+qSul9OyGKG4BoMwnh5wH2p
         M16pj9pxhujsveHX7rg0ILlUXYJ+BFONR5BfomX2Fb52qXFUrDErhxpRx+KCxSxx+ory
         B3Zb8c0RjJGnQe8nLfQZBLU1xPBgNNDvwc7ujPhBtx4DbHz3tIF5hPH4OLZoPVspxoFU
         rcokGGUQ0hcI4sf+6kr6WXLID0x0ZV4FqvhlX9jgeNBt7Y/2i3iVwRh7A16DcPKW5yy2
         91Dyl2V0/XfK4EhYGl1q8mxxw1hkb33kzi99aCXv1WYSpnVWyKsKInUTB1Ftw5KAJyZb
         w7RQ==
X-Gm-Message-State: AOAM530cT03Bd4bl2Kea2oJ7BbE2pf4tDti1Kj0jLUKAiH36Jj/AoQDl
        TWpxKKv/b0GS06J+7L6GZZ57OodcnEUFTjuKg3ikKQ==
X-Google-Smtp-Source: ABdhPJw+cTul0haRhSS1PArbm4YkgdTL5SYzPECntuAV3MAEScZ/3fNefP0yOScmFIqJvzxlYQgnt8hfJXNGVJQ8rhY=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr6318478qko.424.1615445427602;
 Wed, 10 Mar 2021 22:50:27 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <dbdca868-7ef2-47b3-ac26-12fe61f3156a@codethink.co.uk> <9a0823f4-de19-c2a2-5333-41c6caadbc11@ghiti.fr>
In-Reply-To: <9a0823f4-de19-c2a2-5333-41c6caadbc11@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 07:50:16 +0100
Message-ID: <CACT4Y+bP0znswS3hFrNsF0L00s35J55Vj_JTC=DJsd0d3iDKpA@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
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
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 7:40 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Ben,
>
> Le 3/10/21 =C3=A0 5:24 PM, Ben Dooks a =C3=A9crit :
> > On 10/03/2021 17:16, Dmitry Vyukov wrote:
> >> On Wed, Mar 10, 2021 at 5:46 PM syzbot
> >> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
> >>> arch_dup_tas..
> >>> git tree:
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1212c6e6d=
00000
> >>> kernel config:
> >>> https://syzkaller.appspot.com/x/.config?x=3De3c595255fb2d136
> >>> dashboard link:
> >>> https://syzkaller.appspot.com/bug?extid=3De74b94fe601ab9552d69
> >>> userspace arch: riscv64
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the
> >>> commit:
> >>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
> >>
> >> +riscv maintainers
> >>
> >> This is riscv64-specific.
> >> I've seen similar crashes in put_user in other places. It looks like
> >> put_user crashes in the user address is not mapped/protected (?).
> >
> > The unmapped case should have been handled.
> >
> > I think this issue is that the check for user-mode access added. From
> > what I read the code may be wrong in
> >
> > +    if (!user_mode(regs) && addr < TASK_SIZE &&
> > +            unlikely(!(regs->status & SR_SUM)))
> > +        die_kernel_fault("access to user memory without uaccess routin=
es",
> > +                addr, regs);
> >
> > I think the SR_SUM check might be wrong, as I read the standard the
> > SR_SUM should be set to disable user-space access. So the check
> > should be unlikely(regs->status & SR_SUM) to say access without
> > having disabled the protection.
>
> The check that is done seems correct to me: "The SUM (permit Supervisor
> User Memory access) bit modifies the privilege with which S-mode loads
> and stores access virtual memory.  *When SUM=3D0, S-mode memory accesses
> to pages that are accessible by U-mode (U=3D1 in Figure 4.15) will fault*=
.
>   When SUM=3D1, these accesses are permitted.SUM  has  no  effect  when
> page-based  virtual  memory  is  not  in  effect".
>
> I will try to reproduce the problem locally.

Weird. It crashes with this all the time:
https://syzkaller.appspot.com/bug?extid=3De74b94fe601ab9552d69

Even on trivial programs that almost don't do anything.
Maybe it's qemu bug? Do registers look sane in the dump? That SR_SUM, etc.


00:13:27 executing program 1:
openat$drirender128(0xffffffffffffff9c,
&(0x7f0000000040)=3D'/dev/dri/renderD128\x00', 0x0, 0x0)

[  812.318182][ T4833] Unable to handle kernel access to user memory
without uaccess routines at virtual address 00000000250b60d0
[  812.322304][ T4833] Oops [#1]
[  812.323196][ T4833] Modules linked in:
[  812.324110][ T4833] CPU: 1 PID: 4833 Comm: syz-executor.1 Not
tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
[  812.325862][ T4833] Hardware name: riscv-virtio,qemu (DT)
[  812.327561][ T4833] epc : schedule_tail+0x72/0xb2
[  812.328640][ T4833]  ra : schedule_tail+0x70/0xb2
[  812.330088][ T4833] epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp
: ffffffe0238bbec0
[  812.331312][ T4833]  gp : ffffffe005d25378 tp : ffffffe00a275b00 t0
: 0000000000000000
[  812.333014][ T4833]  t1 : 0000000000000001 t2 : 00000000000f4240 s0
: ffffffe0238bbee0
[  812.334137][ T4833]  s1 : 00000000250b60d0 a0 : 0000000000000036 a1
: 0000000000000003
[  812.336063][ T4833]  a2 : 1ffffffc0cfa8b00 a3 : ffffffe0000c80cc a4
: 7f467e72c6adf800
[  812.337398][ T4833]  a5 : 0000000000000000 a6 : 0000000000f00000 a7
: ffffffe0000f8c84
[  812.339287][ T4833]  s2 : 0000000000040000 s3 : ffffffe0077a96c0 s4
: ffffffe020e67fe0
[  812.340658][ T4833]  s5 : 0000000000004020 s6 : ffffffe0077a9b58 s7
: ffffffe067d74850
[  812.342492][ T4833]  s8 : ffffffe067d73e18 s9 : 0000000000000000
s10: ffffffe00bd72280
[  812.343668][ T4833]  s11: 000000bd067bf638 t3 : 7f467e72c6adf800 t4
: ffffffc403ee7fb2
[  812.345510][ T4833]  t5 : ffffffc403ee7fba t6 : 0000000000040000
[  812.347004][ T4833] status: 0000000000000120 badaddr:
00000000250b60d0 cause: 000000000000000f
[  812.348091][ T4833] Call Trace:
[  812.349291][ T4833] [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2
[  812.350796][ T4833] [<ffffffe000005570>] ret_from_exception+0x0/0x14
[  812.352799][ T4833] Dumping ftrace buffer:
[  812.354328][ T4833]    (ftrace buffer empty)
[  812.428145][ T4833] ---[ end trace 94b077e4d677ee73 ]---


00:10:42 executing program 1:
bpf$ENABLE_STATS(0x20, 0x0, 0x0)
bpf$ENABLE_STATS(0x20, 0x0, 0x0)

[  646.536862][ T5163] loop0: detected capacity change from 0 to 1
[  646.566730][ T5165] Unable to handle kernel access to user memory
without uaccess routines at virtual address 00000000032f80d0
[  646.586024][ T5165] Oops [#1]
[  646.586640][ T5165] Modules linked in:
[  646.587350][ T5165] CPU: 1 PID: 5165 Comm: syz-executor.1 Not
tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
[  646.588209][ T5165] Hardware name: riscv-virtio,qemu (DT)
[  646.589019][ T5165] epc : schedule_tail+0x72/0xb2
[  646.589811][ T5165]  ra : schedule_tail+0x70/0xb2
[  646.590435][ T5165] epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp
: ffffffe008013ec0
[  646.591142][ T5165]  gp : ffffffe005d25378 tp : ffffffe007634440 t0
: 0000000000000000
[  646.591836][ T5165]  t1 : 0000000000000001 t2 : 0000000000000008 s0
: ffffffe008013ee0
[  646.592509][ T5165]  s1 : 00000000032f80d0 a0 : 0000000000000004 a1
: 0000000000000003
[  646.593188][ T5165]  a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4
: 8d229faaffda9500
[  646.593878][ T5165]  a5 : 0000000000000000 a6 : 0000000000f00000 a7
: ffffffe000082eba
[  646.594552][ T5165]  s2 : 0000000000040000 s3 : ffffffe00c82c440 s4
: ffffffe00e61ffe0
[  646.595253][ T5165]  s5 : 0000000000004000 s6 : ffffffe067d57e00 s7
: ffffffe067d57850
[  646.595938][ T5165]  s8 : ffffffe067d56e18 s9 : ffffffe067d57e00
s10: ffffffe00c82c878
[  646.596627][ T5165]  s11: 000000967ba7a1cc t3 : 8d229faaffda9500 t4
: ffffffc4011bc79b
[  646.597319][ T5165]  t5 : ffffffc4011bc79d t6 : ffffffe008de3ce8
[  646.597909][ T5165] status: 0000000000000120 badaddr:
00000000032f80d0 cause: 000000000000000f
[  646.598682][ T5165] Call Trace:
[  646.599294][ T5165] [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2
[  646.600115][ T5165] [<ffffffe000005570>] ret_from_exception+0x0/0x14
[  646.601333][ T5165] Dumping ftrace buffer:
[  646.602322][ T5165]    (ftrace buffer empty)
[  646.663691][ T5165] ---[ end trace e7b7847ce74cdfca ]---





> Thanks,
>
> Alex
>
> >
> > Without this, you can end up with an infinite loop in the fault handler=
.
> >
> >>
> >>> Unable to handle kernel access to user memory without uaccess
> >>> routines at virtual address 000000002749f0d0
> >>> Oops [#1]
> >>> Modules linked in:
> >>> CPU: 1 PID: 4875 Comm: syz-executor.0 Not tainted
> >>> 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> >>> Hardware name: riscv-virtio,qemu (DT)
> >>> epc : schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
> >>>   ra : task_pid_vnr include/linux/sched.h:1421 [inline]
> >>>   ra : schedule_tail+0x70/0xb2 kernel/sched/core.c:4264
> >>> epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp : ffffffe025d17ec0
> >>>   gp : ffffffe005d25378 tp : ffffffe00f0d0000 t0 : 0000000000000000
> >>>   t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe025d17ee0
> >>>   s1 : 000000002749f0d0 a0 : 000000000000002a a1 : 0000000000000003
> >>>   a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4 : 5ae9db91c19bbe00
> >>>   a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
> >>>   s2 : 0000000000040000 s3 : ffffffe00eef96c0 s4 : ffffffe022c77fe0
> >>>   s5 : 0000000000004000 s6 : ffffffe067d74e00 s7 : ffffffe067d74850
> >>>   s8 : ffffffe067d73e18 s9 : ffffffe067d74e00 s10: ffffffe00eef96e8
> >>>   s11: 000000ae6cdf8368 t3 : 5ae9db91c19bbe00 t4 : ffffffc4043cafb2
> >>>   t5 : ffffffc4043cafba t6 : 0000000000040000
> >>> status: 0000000000000120 badaddr: 000000002749f0d0 cause:
> >>> 000000000000000f
> >>> Call Trace:
> >>> [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
> >>> [<ffffffe000005570>] ret_from_exception+0x0/0x14
> >>> Dumping ftrace buffer:
> >>>     (ftrace buffer empty)
> >>> ---[ end trace b5f8f9231dc87dda ]---
> >>>
> >>>
> >>> ---
> >>> This report is generated by a bot. It may contain errors.
> >>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>
> >>> syzbot will keep track of this issue. See:
> >>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>
> >>> --
> >>> You received this message because you are subscribed to the Google
> >>> Groups "syzkaller-bugs" group.
> >>> To unsubscribe from this group and stop receiving emails from it,
> >>> send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >>> To view this discussion on the web visit
> >>> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b74f1b05=
bd316729%40google.com.
> >>>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>
> >
> >
